@echo off

set L=jp
if "%1"=="en" set L=en
echo Building the document in %L%
kxkitty kinx_%L%.md
