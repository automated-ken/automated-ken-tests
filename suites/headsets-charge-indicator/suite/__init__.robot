*** Settings ***
Documentation    YARF test suite for headsets-charge-indicator snap
Library    BuiltIn
Library    OperatingSystem

Suite Setup    Setup Test Environment
Suite Teardown    Clean Up

*** Variables ***
    Mir

*** Keywords ***
Setup Test Environment
    Log    Setting up test environment for headsets-charge-indicator
    Create Directory    ${OUTPUT_DIR}/results

Clean Up
    Log    Cleaning up test environment
