*** Settings ***
Documentation    Test cases for terminal-solitaire snap
Library    BuiltIn
Library    OperatingSystem
Library    Screenshot

Suite Setup    Verify Snap Is Installed
Suite Teardown    Uninstall Snap

*** Test Cases ***
Verify Terminal-solitaire Snap Launches
    [Documentation]    Ensure the terminal-solitaire snap launches successfully
    [Tags]    smoke
    ${result}    Run Keyword And Return Status    Snap List    terminal-solitaire
    Should Be True    ${result}    terminal-solitaire snap should be installed

Launch Terminal-solitaire Application
    [Documentation]    Launch the terminal-solitaire application
    [Tags]    functional
    Start Application    terminal-solitaire
    Wait For Application Window    terminal-solitaire    10s
    Capture Screenshot    terminal-solitaire-launched

Verify Application Window Exists
    [Documentation]    Check that the application window is visible
    [Tags]    functional
    ${windows}    Run    wmctrl -l
    Should Contain    ${windows.stdout}    terminal-solitaire

Take Application Screenshot
    [Documentation]    Capture a screenshot of the running application
    [Tags]    ui
    Wait Until Keyword Succeeds    5s    1s    Window Exists    terminal-solitaire
    Capture Screenshot    terminal-solitaire-main-window

*** Keywords ***
Verify Snap Is Installed
    ${list}    Run    snap list
    Should Contain    ${list.stdout}    terminal-solitaire

Uninstall Snap
    Run    snap remove terminal-solitaire    warn

Start Application
    [Documentation]    Start the terminal-solitaire snap
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
