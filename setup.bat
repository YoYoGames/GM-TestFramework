@echo off

echo Installing Python dependencies...
pip install -r requirements.txt

echo Installing NodeJS dependencies...
cd servers
npm install
cd ..

echo Installation complete!