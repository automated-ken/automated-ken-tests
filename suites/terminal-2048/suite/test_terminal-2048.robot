*** Settings ***
Documentation    Test cases for terminal-2048 snap
Library    BuiltIn
Library    OperatingSystem
Library    Screenshot

Suite Setup    Verify Snap Is Installed
Suite Teardown    Uninstall Snap

*** Test Cases ***
Verify Terminal-2048 Snap Launches
    [Documentation]    Ensure the terminal-2048 snap launches successfully
    [Tags]    smoke
    ${result}    Run Keyword And Return Status    Snap List    terminal-2048
    Should Be True    ${result}    terminal-2048 snap should be installed

Launch Terminal-2048 Application
    [Documentation]    Launch the terminal-2048 application
    [Tags]    functional
    Start Application    terminal-2048
    Wait For Application Window    terminal-2048    10s
    Capture Screenshot    terminal-2048-launched

Verify Application Window Exists
    [Documentation]    Check that the application window is visible
    [Tags]    functional
    ${windows}    Run    wmctrl -l
    Should Contain    ${windows.stdout}    terminal-2048

Take Application Screenshot
    [Documentation]    Capture a screenshot of the running application
    [Tags]    ui
    Wait Until Keyword Succeeds    5s    1s    Window Exists    terminal-2048
    Capture Screenshot    terminal-2048-main-window

*** Keywords ***
Verify Snap Is Installed
    ${list}    Run    snap list
    Should Contain    ${list.stdout}    terminal-2048

Uninstall Snap
    Run    snap remove terminal-2048    warn

Start Application
    [Documentation]    Start the terminal-2048 snap
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
