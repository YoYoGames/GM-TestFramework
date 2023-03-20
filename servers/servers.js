import express from 'express';
import http from 'http';
import path from 'path'
import fs from 'fs';
import ip from 'ip'
import cors from "cors"
import { WebSocketServer } from 'ws'
import { Buffer } from 'buffer';
import queryString from 'query-string';

function ensureDirectoryExists(directoryPath, callback = () => { }) {
    fs.mkdir(directoryPath, { recursive: true }, (err) => {
        if (err) {
            console.error(`Error creating directory: ${directoryPath}`, err);
            callback(err);
        } else {
            console.log(`Directory created successfully: ${directoryPath}`);
            callback(null);
        }
    });
};

function createEmptyFile(filePath, callback = () => { }) {
    const dirname = path.dirname(filePath);

    // Ensure the directory exists before creating the file
    fs.mkdir(dirname, { recursive: true }, (err) => {
        if (err) {
            callback(err);
            return;
        }

        // Create an empty file
        fs.writeFile(filePath, '', (err) => {
            if (err) {
                callback(err);
                return;
            }

            callback(null);
        });
    });
}

function createMetaFile(filePath, data, callback = () => { }) {

    const dirname = path.dirname(filePath);

    // Ensure the directory exists before creating the file
    fs.mkdir(dirname, { recursive: true }, (err) => {
        if (err) {
            callback(err);
            return;
        }

        // Create an empty file
        fs.writeFile(filePath, data, (err) => {
            if (err) {
                callback(err);
                return;
            }

            callback(null);
        });
    });

}

function hasErrorsOrCrashed(data) {
    const tallies = data.tallies;
    return tallies.failed != undefined || tallies.expired != undefined;
}

function runServers(runtimeVersion, port) {

    const testsPath = path.join('workspace', 'results', 'tests', runtimeVersion);
    const performancePath = path.join('workspace', 'results', 'performance', runtimeVersion);
    const failFile = path.join('workspace', '.fail');
    const metaFile = path.join('workspace', '.meta');

    ensureDirectoryExists(testsPath);
    ensureDirectoryExists(performancePath);

    const app = express();

    const jsonOptions = {
        limit: '50mb'
    }

    const urlencodedOptions = {
        extended: true,
        limit: '50mb'
    }

    const corsOptions = {
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Methods": "POST",
        "Access-Control-Allow-Headers": "Content-Type",
    };

    app.use(express.json(jsonOptions));
    app.use(express.urlencoded(urlencodedOptions));
    app.use(cors(corsOptions))

    const server = http.createServer(app);

    // HTTP Server

    app.post('/tests', (req, res) => {
        // receive JSON message and store it to disk
        const body = req.body;

        const targetName = body.isBrowser ? 'html5' : body.targetName;
        const runnerName = body.isCompiled ? 'yyc' : 'vm';
        const filesystemType = body.isSandboxed ? '_sandboxed' : '';

        const fileName = `${targetName}_${runnerName}${filesystemType}`;
        const filePath = path.join(testsPath, `${fileName}.json`);

        const stream = fs.createWriteStream(filePath);
        stream.once('open', function () {
            stream.write(JSON.stringify(body));
            stream.end();
        });

        // There were errors or exception (fail the job)
        if (hasErrorsOrCrashed(body.data)) {
            createEmptyFile(failFile)
        }

        const data = {
            folder: testsPath,
            file: fileName
        }
        createMetaFile(metaFile, JSON.stringify(data))

        res.status(200).send('Tests data stored');
    });

    app.post('/performance', (req, res) => {
        // receive JSON message and store it to disk
        const body = req.body;
        const fileName = `${body.platformName}_${body.runnerName}.json`;
        const filePath = path.join(performancePath, fileName);

        const stream = fs.createWriteStream(filePath);
        stream.once('open', function () {
            stream.write(JSON.stringify(body));
            stream.end();
        });

        res.status(200).send('Performance data stored');
    });

    // Websocket Server

    const wss = new WebSocketServer({
        noServer: true,
        maxPayload: 1000000,
        path: "/websockets"
    });

    server.on("upgrade", (request, socket, head) => {

        wss.handleUpgrade(request, socket, head, (websocket) => {
            wss.emit("connection", websocket, request);
        });
    });

    wss.on('connection', (connection, request) => {

        // websocket protocol implementation
        console.log(`New websocket connection`);

        const [_, params] = request?.url?.split("?");
        const connectionParams = queryString.parse(params);

        var mode = connectionParams?.mode ?? "raw";
        if (mode == "handshake") {

            console.log("Starting Handshake");
            
            connection.userData = { handshake: true };
            connection.send("GM:Studio-Connect\0", { binary: true });
        }
        else console.log("Starting Echo");

        connection.on("message", (data, isBinary) => {

            if (connection.userData?.handshake) {

                if (isBinary == false) {
                    connection.terminate();

                    console.log("Connection terminated!");
                    return;
                }

                if (data.length != 16) {
                    connection.terminate();

                    console.log("Connection terminated!");
                    return;
                }

                var gameid = data.readUInt32LE(12);

                if (data.readUInt32LE(0) != 0xCAFEBABE || data.readUInt32LE(4) != 0xDEADB00B || data.readUInt32LE(8) != 16) {
                    connection.terminate();

                    console.log("Connection terminated!");
                    return;
                }

                var res = Buffer.alloc(12);
                res.writeUInt32LE(0xDEAFBEAD, 0);
                res.writeUInt32LE(0xF00DBEEB, 4);
                res.writeUInt32LE(12, 8);

                connection.send(res);
                connection.userData.handshake = false;

                console.log("Handshake succeeded!");
            }
            else {
                // Just send the data back
                connection.send(data);
                console.log(data.buffer)
            }
        });
    });

    // Initialize server

    server.listen(port, () => {
        console.log(`Servers running on ip ${ip.address()} port ${port}`);
    });
};


const args = process.argv.slice(2);

if (args.length >= 2) {
    runServers(args[0], args[1]);
}
else {
    runServers("0.0.0.0", 8080, false);
}