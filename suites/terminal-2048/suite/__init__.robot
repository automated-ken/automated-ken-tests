*** Settings ***
Documentation    YARF test suite for terminal-2048 snap
Library    BuiltIn
Library    OperatingSystem

Suite Setup    Setup Test Environment
Suite Teardown    Clean Up

*** Variables ***
    Mir

*** Keywords ***
Setup Test Environment
    Log    Setting up test environment for terminal-2048
    Create Directory    ${OUTPUT_DIR}/results

Clean Up
    Log    Cleaning up test environment
