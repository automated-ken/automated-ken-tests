*** Settings ***
Documentation    Test cases for geforce-now snap
Library    BuiltIn
Library    OperatingSystem
Library    Screenshot

Suite Setup    Verify Snap Is Installed
Suite Teardown    Uninstall Snap

*** Test Cases ***
Verify Geforce-now Snap Launches
    [Documentation]    Ensure the geforce-now snap launches successfully
    [Tags]    smoke
    ${result}    Run Keyword And Return Status    Snap List    geforce-now
    Should Be True    ${result}    geforce-now snap should be installed

Launch Geforce-now Application
    [Documentation]    Launch the geforce-now application
    [Tags]    functional
    Start Application    geforce-now
    Wait For Application Window    geforce-now    10s
    Capture Screenshot    geforce-now-launched

Verify Application Window Exists
    [Documentation]    Check that the application window is visible
    [Tags]    functional
    ${windows}    Run    wmctrl -l
    Should Contain    ${windows.stdout}    geforce-now

Take Application Screenshot
    [Documentation]    Capture a screenshot of the running application
    [Tags]    ui
    Wait Until Keyword Succeeds    5s    1s    Window Exists    geforce-now
    Capture Screenshot    geforce-now-main-window

*** Keywords ***
Verify Snap Is Installed
    ${list}    Run    snap list
    Should Contain    ${list.stdout}    geforce-now

Uninstall Snap
    Run    snap remove geforce-now    warn

Start Application
    [Documentation]    Start the geforce-now snap
    [Arguments]    ${app_name}
    Run    snap run ${app_name}    &

Wait For Application Window
    [Documentation]    Wait for the application window to appear
    [Arguments]    ${app_name}    ${timeout}=10s
    Wait Until Keyword Succeeds    ${timeout}    1s    Window Exists    ${app_name}

Window Exists
    [Documentation]    Check if a window exists for the given app
    [Arguments]    ${app_name}
    ${windows}    Run    wmctrl -l
    Should Contain    ${windows.stdout}    ${app_name}
