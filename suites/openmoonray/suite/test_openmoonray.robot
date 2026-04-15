*** Settings ***
Documentation    Test cases for openmoonray snap
Library    BuiltIn
Library    OperatingSystem
Library    Screenshot

Suite Setup    Verify Snap Is Installed
Suite Teardown    Uninstall Snap

*** Test Cases ***
Verify Openmoonray Snap Launches
    [Documentation]    Ensure the openmoonray snap launches successfully
    [Tags]    smoke
    ${result}    Run Keyword And Return Status    Snap List    openmoonray
    Should Be True    ${result}    openmoonray snap should be installed

Launch Openmoonray Application
    [Documentation]    Launch the openmoonray application
    [Tags]    functional
    Start Application    openmoonray
    Wait For Application Window    openmoonray    10s
    Capture Screenshot    openmoonray-launched

Verify Application Window Exists
    [Documentation]    Check that the application window is visible
    [Tags]    functional
    ${windows}    Run    wmctrl -l
    Should Contain    ${windows.stdout}    openmoonray

Take Application Screenshot
    [Documentation]    Capture a screenshot of the running application
    [Tags]    ui
    Wait Until Keyword Succeeds    5s    1s    Window Exists    openmoonray
    Capture Screenshot    openmoonray-main-window

*** Keywords ***
Verify Snap Is Installed
    ${list}    Run    snap list
    Should Contain    ${list.stdout}    openmoonray

Uninstall Snap
    Run    snap remove openmoonray    warn

Start Application
    [Documentation]    Start the openmoonray snap
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
