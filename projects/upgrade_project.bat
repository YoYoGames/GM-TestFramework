@echo off
if "%PROJECTTOOL%" == "" set "PROJECTTOOL=C:\Source\ProjectTool\Source\bin\Debug\net8.0\ProjectTool"
if "%CORERESOURCES_DLL%" == "" (
	echo "Environment variable CORERESOURCES_DLL is not set skipping convertion!"
  exit 0
)

pushd %~dp0
set "BASE=%cd%"

mkdir Prefabs
"%PROJECTTOOL%" SHOWVERSIONEDTYPES DESTINATION=resourceslist.json SOURCE="%CORERESOURCES_DLL%"

for /d %%p in (*) do (
  cd %%p
  "%PROJECTTOOL%" project save source=.\\%%p.yyp RESOURCETYPESPATH=%BASE%\\resourceslist.json PREFABSFOLDER=%BASE%\\Prefabs
  cd ..
)

cd "%BASE%"
del resourceslist.json
rmdir /s /q Prefabs

popd