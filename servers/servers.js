import express from 'express';
import http from 'http';
import path from 'path';
import fs from 'fs';
import ip from 'ip';
import cors from "cors";
import { WebSocketServer } from 'ws';
import queryString from 'query-string';
import xmlbuilder from 'xmlbuilder';
import { Buffer } from 'buffer';


function ensureDirectoryExists(directoryPath, callback = () => {}) {
    fs.mkdir(directoryPath, { recursive: true }, (err) => {
        if (err) {
            console.error(`Error creating directory: ${directoryPath}`, err);
            callback(err);
        } else {
            console.log(`Directory created successfully: ${directoryPath}`);
            callback(null);
        }
    });
}

function createEmptyFile(filePath, callback = () => {}) {
    const dirname = path.dirname(filePath);

    fs.mkdir(dirname, { recursive: true }, (err) => {
        if (err) {
            callback(err);
            return;
        }

        fs.writeFile(filePath, '', (err) => {
            if (err) {
                callback(err);
                return;
            }

            callback(null);
        });
    });
}

function createMetaFile(filePath, data, callback = () => {}) {
    const dirname = path.dirname(filePath);

    fs.mkdir(dirname, { recursive: true }, (err) => {
        if (err) {
            callback(err);
            return;
        }

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


function jsonToXml(testData, testsuiteName) {
    const tallies = {
        passed: 0,
        skipped: 0,
        failed: 0
    };

    testData.forEach(test => {
        const { result } = test;
        if (result === 'Passed') {
            tallies.passed++;
        } else if (result === 'Skipped') {
            tallies.skipped++;
        } else if (result === 'Failed' || result === 'Error') {
            tallies.failed++;
        }
    });

    const timestamp = new Date().toISOString();

    // Create XML document using xmlbuilder
    const xml = xmlbuilder.create('testsuites', { version: '1.0', encoding: 'UTF-8' })
        .ele('testsuite', {
            name: testsuiteName,
            timestamp: timestamp,
            passed: tallies.passed,
            skipped: tallies.skipped,
            failed: tallies.failed
        });

    testData.forEach(test => {
        const { name, result, duration, errors } = test;
        const durationInSeconds = duration ? (duration / 1000).toFixed(3) : '';

        const testcase = xml.ele('testcase', { name: name, time: durationInSeconds });

        if (result === 'Failed' && Array.isArray(errors)) {
            errors.forEach((error, index) => {              
                
                const properties = testcase.ele('properties');
                properties.ele('property', { name: `Actual #${index + 1}`, value: error.actual.replace(/"/g, '') }).up();
                properties.ele('property', { name: `Expected #${index + 1}`, value: error.expected.replace(/"/g,'') }).up();
                properties.ele('property', { name: `Stack #${index + 1}`, value: error.stack.replace(/"/g, '') });
        
                testcase.ele('failure', { message: error.title || '', type: error.description || '' });
            });
        }

        if (result === 'Skipped') {
            testcase.ele('skipped').txt(name || 'Test Skipped');
        }
    });

    // End and return the XML string
    return xml.end({ pretty: true });
}

export { jsonToXml };
function extractTestData(body) {
    try {
        // Assuming your test data is stored in the `data` property of the body object
        const testData = body.data;
        // Check if testData.details exists and contains the expected structure
        if (!testData || !testData.details || !testData.details.passed || !testData.details.failed || !testData.details.skipped) {
            throw new Error("Invalid test data structure");
        }
        // Combine passed, failed, and skipped tests into a single array
        const allTests = testData.details.passed.concat(testData.details.failed, testData.details.skipped);
        return allTests;
    } catch (error) {
        console.error("Error extracting test data:", error);
        return [];
    }
}

function runServers(runtimeVersion, port, testsuiteName) {
    const testsPath = path.join('workspace', 'results', 'tests', runtimeVersion);
    const performancePath = path.join('workspace', 'results', 'performance', runtimeVersion);
    const failFile = path.join('workspace', '.fail');
    const metaFile = path.join('workspace', '.meta');
    const testsuiteName = testsuiteName;

    ensureDirectoryExists(testsPath);
    ensureDirectoryExists(performancePath);

    const app = express();
    const jsonOptions = { limit: '50mb' };
    const urlencodedOptions = { extended: true, limit: '50mb' };
    const corsOptions = { "Access-Control-Allow-Origin": "*", "Access-Control-Allow-Methods": "POST", "Access-Control-Allow-Headers": "Content-Type" };

    app.use(express.json(jsonOptions));
    app.use(express.urlencoded(urlencodedOptions));
    app.use(cors(corsOptions))

    const server = http.createServer(app);


    app.post('/tests', (req, res) => {
        const body = req.body;   

        const targetName = body.isBrowser ? 'html5' : body.targetName;
        const runnerName = body.isCompiled ? 'yyc' : 'vm';
        const filesystemType = body.isSandboxed ? '_sandboxed' : '';

        const fileName = `${targetName}_${runnerName}${filesystemType}`;
        try {
            console.log("Request Body:", body);
            // Extracting test data
            const testData = extractTestData(body);
            console.log("Test Data:", testData);
        
            const jsonFilePath = path.join(testsPath, `${fileName}.json`);
            console.log("JSON File Path:", jsonFilePath);
        
            // Writing JSON data to file
            fs.writeFile(jsonFilePath, JSON.stringify(body), (err) => {
                if (err) {
                    console.error("Error writing to JSON file:", err);
                } else {
                    console.log("JSON data written to file successfully:", jsonFilePath);
                }
            });
        } catch (error) {
            console.error("Error processing test data:", error);
        }        
        
        try {
            console.log("Request Body:", body);
        
            const testData = extractTestData(body);
            console.log("Test Data:", testData);
        
            const xmlData = jsonToXml(testData);
            console.log("Generated XML Data:", xmlData);
        
            const xmlFilePath = path.join(testsPath, `${fileName}.xml`);
            console.log("XML File Path:", xmlFilePath);
        
            const streamXML = fs.createWriteStream(xmlFilePath);
            streamXML.once('open', function () {
                console.log("Writing XML Data to file:", xmlData);
                streamXML.write(xmlData);
                streamXML.end();
            });
            streamXML.on('error', function(err) {
                console.error("Error writing to XML file:", err);
            });
        } catch (error) {
            console.error("Error processing test data:", error);
        }
         

        if (hasErrorsOrCrashed(body.data)) {
            createEmptyFile(failFile)
        }

        const data = { folder: testsPath, file: fileName };
        createMetaFile(metaFile, JSON.stringify(data))

        res.status(200).send('Tests data stored');
    });

    app.post('/performance', (req, res) => {
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

    const wss = new WebSocketServer({ noServer: true, maxPayload: 1000000, path: "/websockets" });

    server.on("upgrade", (request, socket, head) => {
        wss.handleUpgrade(request, socket, head, (websocket) => {
            wss.emit("connection", websocket, request);
        });
    });

    wss.on('connection', (connection, request) => {
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
                connection.send(data);
                console.log(data.buffer)
            }
        });
    });

    server.listen(port, () => {
        console.log(`Servers running on ip ${ip.address()} port ${port}`);
    });
}

const args = process.argv.slice(2);


if (args.length >= 3) {
    var runtimeVersion = args[0];
    var port = args[1];
    var testsuiteName = args[2];
    
    runServers(runtimeVersion, port, testsuiteName);
}
else {
    runServers("0.0.0.0", 8080, false);
}
