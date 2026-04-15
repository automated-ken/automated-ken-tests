*** Settings ***
Documentation    YARF test suite for gnome-mines snap
Library    BuiltIn
Library    OperatingSystem

Suite Setup    Setup Test Environment
Suite Teardown    Clean Up

*** Variables ***
    Mir

*** Keywords ***
Setup Test Environment
    Log    Setting up test environment for gnome-mines
    Create Directory    ${OUTPUT_DIR}/results

Clean Up
    Log    Cleaning up test environment
