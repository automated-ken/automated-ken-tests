*** Settings ***
Documentation    Test cases for Warble snap
Library    BuiltIn
Library    OperatingSystem
Library    Screenshot

Suite Setup    Verify Snap Is Installed
Suite Teardown    Uninstall Snap

*** Test Cases ***
Verify Warble Snap Launches
    [Documentation]    Ensure the Warble snap launches successfully
    [Tags]    smoke
    ${result}    Run Keyword And Return Status    Snap List    Warble
    Should Be True    ${result}    Warble snap should be installed

Launch Warble Application
    [Documentation]    Launch the Warble application
    [Tags]    functional
    Start Application    Warble
    Wait For Application Window    Warble    10s
    Capture Screenshot    Warble-launched

Verify Application Window Exists
    [Documentation]    Check that the application window is visible
    [Tags]    functional
    ${windows}    Run    wmctrl -l
    Should Contain    ${windows.stdout}    Warble

Take Application Screenshot
    [Documentation]    Capture a screenshot of the running application
    [Tags]    ui
    Wait Until Keyword Succeeds    5s    1s    Window Exists    Warble
    Capture Screenshot    Warble-main-window

*** Keywords ***
Verify Snap Is Installed
    ${list}    Run    snap list
    Should Contain    ${list.stdout}    Warble

Uninstall Snap
    Run    snap remove Warble    warn

Start Application
    [Documentation]    Start the Warble snap
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
