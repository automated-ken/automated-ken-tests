*** Settings ***
Documentation    Test cases for gnome-tetravex snap
Library    BuiltIn
Library    OperatingSystem
Library    Screenshot

Suite Setup    Verify Snap Is Installed
Suite Teardown    Uninstall Snap

*** Test Cases ***
Verify Gnome-tetravex Snap Launches
    [Documentation]    Ensure the gnome-tetravex snap launches successfully
    [Tags]    smoke
    ${result}    Run Keyword And Return Status    Snap List    gnome-tetravex
    Should Be True    ${result}    gnome-tetravex snap should be installed

Launch Gnome-tetravex Application
    [Documentation]    Launch the gnome-tetravex application
    [Tags]    functional
    Start Application    gnome-tetravex
    Wait For Application Window    gnome-tetravex    10s
    Capture Screenshot    gnome-tetravex-launched

Verify Application Window Exists
    [Documentation]    Check that the application window is visible
    [Tags]    functional
    ${windows}    Run    wmctrl -l
    Should Contain    ${windows.stdout}    gnome-tetravex

Take Application Screenshot
    [Documentation]    Capture a screenshot of the running application
    [Tags]    ui
    Wait Until Keyword Succeeds    5s    1s    Window Exists    gnome-tetravex
    Capture Screenshot    gnome-tetravex-main-window

*** Keywords ***
Verify Snap Is Installed
    ${list}    Run    snap list
    Should Contain    ${list.stdout}    gnome-tetravex

Uninstall Snap
    Run    snap remove gnome-tetravex    warn

Start Application
    [Documentation]    Start the gnome-tetravex snap
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
