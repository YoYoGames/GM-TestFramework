@echo off

echo Installing Python dependencies...
pip3 install -r requirements.txt

echo Installing NodeJS dependencies...
cd servers
npm install
cd ..

echo Installation complete!