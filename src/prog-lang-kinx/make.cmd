@echo off

pushd %~dp0
set L=jp
if "%1"=="en" set L=en
echo Building the document (jp/en) - selected %L%
kxkitty kinx_%L%.md
popd
