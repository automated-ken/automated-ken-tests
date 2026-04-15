*** Settings ***
Documentation    Test cases for Widelands snap
Library    BuiltIn
Library    OperatingSystem
Library    Screenshot

Suite Setup    Verify Snap Is Installed
Suite Teardown    Uninstall Snap

*** Test Cases ***
Verify Widelands Snap Launches
    [Documentation]    Ensure the Widelands snap launches successfully
    [Tags]    smoke
    ${result}    Run Keyword And Return Status    Snap List    Widelands
    Should Be True    ${result}    Widelands snap should be installed

Launch Widelands Application
    [Documentation]    Launch the Widelands application
    [Tags]    functional
    Start Application    Widelands
    Wait For Application Window    Widelands    10s
    Capture Screenshot    Widelands-launched

Verify Application Window Exists
    [Documentation]    Check that the application window is visible
    [Tags]    functional
    ${windows}    Run    wmctrl -l
    Should Contain    ${windows.stdout}    Widelands

Take Application Screenshot
    [Documentation]    Capture a screenshot of the running application
    [Tags]    ui
    Wait Until Keyword Succeeds    5s    1s    Window Exists    Widelands
    Capture Screenshot    Widelands-main-window

*** Keywords ***
Verify Snap Is Installed
    ${list}    Run    snap list
    Should Contain    ${list.stdout}    Widelands

Uninstall Snap
    Run    snap remove Widelands    warn

Start Application
    [Documentation]    Start the Widelands snap
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
