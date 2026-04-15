*** Settings ***
Documentation    Test cases for infinity-arcade snap
Library    BuiltIn
Library    OperatingSystem
Library    Screenshot

Suite Setup    Verify Snap Is Installed
Suite Teardown    Uninstall Snap

*** Test Cases ***
Verify Infinity-arcade Snap Launches
    [Documentation]    Ensure the infinity-arcade snap launches successfully
    [Tags]    smoke
    ${result}    Run Keyword And Return Status    Snap List    infinity-arcade
    Should Be True    ${result}    infinity-arcade snap should be installed

Launch Infinity-arcade Application
    [Documentation]    Launch the infinity-arcade application
    [Tags]    functional
    Start Application    infinity-arcade
    Wait For Application Window    infinity-arcade    10s
    Capture Screenshot    infinity-arcade-launched

Verify Application Window Exists
    [Documentation]    Check that the application window is visible
    [Tags]    functional
    ${windows}    Run    wmctrl -l
    Should Contain    ${windows.stdout}    infinity-arcade

Take Application Screenshot
    [Documentation]    Capture a screenshot of the running application
    [Tags]    ui
    Wait Until Keyword Succeeds    5s    1s    Window Exists    infinity-arcade
    Capture Screenshot    infinity-arcade-main-window

*** Keywords ***
Verify Snap Is Installed
    ${list}    Run    snap list
    Should Contain    ${list.stdout}    infinity-arcade

Uninstall Snap
    Run    snap remove infinity-arcade    warn

Start Application
    [Documentation]    Start the infinity-arcade snap
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
