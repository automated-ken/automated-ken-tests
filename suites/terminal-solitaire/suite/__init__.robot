*** Settings ***
Documentation    YARF test suite for terminal-solitaire snap
Library    BuiltIn
Library    OperatingSystem

Suite Setup    Setup Test Environment
Suite Teardown    Clean Up

*** Variables ***
    Mir

*** Keywords ***
Setup Test Environment
    Log    Setting up test environment for terminal-solitaire
    Create Directory    ${OUTPUT_DIR}/results

Clean Up
    Log    Cleaning up test environment
