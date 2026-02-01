@echo off
REM ================================
REM Shortcut to run Robot Framework
REM tests via run_with_reports.py
REM ================================

if "%~1"=="" (
    echo ❌ Usage: run_test <ModuleName> <TestFileName> [<TestCaseName>]
    exit /b 1
)

set MODULE=%~1
set SUITE=%~2
set TESTCASE=%~3

set ROBOT_FILE=tests\%MODULE%\%SUITE%.robot

if not exist %ROBOT_FILE% (
    echo ❌ Robot file not found: %ROBOT_FILE%
    exit /b 1
)

if "%TESTCASE%"=="" (
    echo 🚀 Running suite: %ROBOT_FILE%
    python scripts\run_with_reports.py %ROBOT_FILE%
) else (
    echo 🚀 Running test case: %TESTCASE% in suite %ROBOT_FILE%
    python scripts\run_with_reports.py %ROBOT_FILE% "%TESTCASE%"
)
