*** Settings ***
Documentation    Test cases for white-house snap
Library    BuiltIn
Library    OperatingSystem
Library    Screenshot

Suite Setup    Verify Snap Is Installed
Suite Teardown    Uninstall Snap

*** Test Cases ***
Verify White-house Snap Launches
    [Documentation]    Ensure the white-house snap launches successfully
    [Tags]    smoke
    ${result}    Run Keyword And Return Status    Snap List    white-house
    Should Be True    ${result}    white-house snap should be installed

Launch White-house Application
    [Documentation]    Launch the white-house application
    [Tags]    functional
    Start Application    white-house
    Wait For Application Window    white-house    10s
    Capture Screenshot    white-house-launched

Verify Application Window Exists
    [Documentation]    Check that the application window is visible
    [Tags]    functional
    ${windows}    Run    wmctrl -l
    Should Contain    ${windows.stdout}    white-house

Take Application Screenshot
    [Documentation]    Capture a screenshot of the running application
    [Tags]    ui
    Wait Until Keyword Succeeds    5s    1s    Window Exists    white-house
    Capture Screenshot    white-house-main-window

*** Keywords ***
Verify Snap Is Installed
    ${list}    Run    snap list
    Should Contain    ${list.stdout}    white-house

Uninstall Snap
    Run    snap remove white-house    warn

Start Application
    [Documentation]    Start the white-house snap
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
