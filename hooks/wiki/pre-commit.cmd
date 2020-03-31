@echo off
powershell.exe -executionpolicy bypass -file .git/hooks/pre-commit.ps1
