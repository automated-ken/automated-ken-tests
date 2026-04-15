*** Settings ***
Documentation    YARF test suite for duck-ai snap
Library    BuiltIn
Library    OperatingSystem

Suite Setup    Setup Test Environment
Suite Teardown    Clean Up

*** Variables ***
    Mir

*** Keywords ***
Setup Test Environment
    Log    Setting up test environment for duck-ai
    Create Directory    ${OUTPUT_DIR}/results

Clean Up
    Log    Cleaning up test environment
