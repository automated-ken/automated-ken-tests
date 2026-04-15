*** Settings ***
Documentation    Test cases for Thrive snap
Library    BuiltIn
Library    OperatingSystem
Library    Screenshot

Suite Setup    Verify Snap Is Installed
Suite Teardown    Uninstall Snap

*** Test Cases ***
Verify Thrive Snap Launches
    [Documentation]    Ensure the Thrive snap launches successfully
    [Tags]    smoke
    ${result}    Run Keyword And Return Status    Snap List    Thrive
    Should Be True    ${result}    Thrive snap should be installed

Launch Thrive Application
    [Documentation]    Launch the Thrive application
    [Tags]    functional
    Start Application    Thrive
    Wait For Application Window    Thrive    10s
    Capture Screenshot    Thrive-launched

Verify Application Window Exists
    [Documentation]    Check that the application window is visible
    [Tags]    functional
    ${windows}    Run    wmctrl -l
    Should Contain    ${windows.stdout}    Thrive

Take Application Screenshot
    [Documentation]    Capture a screenshot of the running application
    [Tags]    ui
    Wait Until Keyword Succeeds    5s    1s    Window Exists    Thrive
    Capture Screenshot    Thrive-main-window

*** Keywords ***
Verify Snap Is Installed
    ${list}    Run    snap list
    Should Contain    ${list.stdout}    Thrive

Uninstall Snap
    Run    snap remove Thrive    warn

Start Application
    [Documentation]    Start the Thrive snap
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
