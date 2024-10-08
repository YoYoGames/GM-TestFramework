@echo off
if "%PROJECTTOOL%" == "" set "PROJECTTOOL=C:\Source\ProjectTool\Source\bin\Debug\net8.0\ProjectTool"

pushd %~dp0
set "BASE=%cd%"

"%PROJECTTOOL%" SHOWVERSIONEDTYPES DESTINATION=resourceslist.json

for /d %%p in (*) do (
  cd %%p
  "%PROJECTTOOL%" project save format=versioned source=.\\%%p.yyp forcevers0=true RESOURCETYPESPATH=%BASE%\\resourceslist.json PREFABSFOLDER=.
  cd ..
)

cd "%BASE%"
del resourceslist.json

popd