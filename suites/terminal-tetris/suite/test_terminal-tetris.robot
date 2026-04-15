*** Settings ***
Documentation    Test cases for terminal-tetris snap
Library    BuiltIn
Library    OperatingSystem
Library    Screenshot

Suite Setup    Verify Snap Is Installed
Suite Teardown    Uninstall Snap

*** Test Cases ***
Verify Terminal-tetris Snap Launches
    [Documentation]    Ensure the terminal-tetris snap launches successfully
    [Tags]    smoke
    ${result}    Run Keyword And Return Status    Snap List    terminal-tetris
    Should Be True    ${result}    terminal-tetris snap should be installed

Launch Terminal-tetris Application
    [Documentation]    Launch the terminal-tetris application
    [Tags]    functional
    Start Application    terminal-tetris
    Wait For Application Window    terminal-tetris    10s
    Capture Screenshot    terminal-tetris-launched

Verify Application Window Exists
    [Documentation]    Check that the application window is visible
    [Tags]    functional
    ${windows}    Run    wmctrl -l
    Should Contain    ${windows.stdout}    terminal-tetris

Take Application Screenshot
    [Documentation]    Capture a screenshot of the running application
    [Tags]    ui
    Wait Until Keyword Succeeds    5s    1s    Window Exists    terminal-tetris
    Capture Screenshot    terminal-tetris-main-window

*** Keywords ***
Verify Snap Is Installed
    ${list}    Run    snap list
    Should Contain    ${list.stdout}    terminal-tetris

Uninstall Snap
    Run    snap remove terminal-tetris    warn

Start Application
    [Documentation]    Start the terminal-tetris snap
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
