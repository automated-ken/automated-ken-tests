*** Settings ***
Documentation    Test cases for gnome-info-collect snap
Library    BuiltIn
Library    OperatingSystem
Library    Screenshot

Suite Setup    Verify Snap Is Installed
Suite Teardown    Uninstall Snap

*** Test Cases ***
Verify Gnome-info-collect Snap Launches
    [Documentation]    Ensure the gnome-info-collect snap launches successfully
    [Tags]    smoke
    ${result}    Run Keyword And Return Status    Snap List    gnome-info-collect
    Should Be True    ${result}    gnome-info-collect snap should be installed

Launch Gnome-info-collect Application
    [Documentation]    Launch the gnome-info-collect application
    [Tags]    functional
    Start Application    gnome-info-collect
    Wait For Application Window    gnome-info-collect    10s
    Capture Screenshot    gnome-info-collect-launched

Verify Application Window Exists
    [Documentation]    Check that the application window is visible
    [Tags]    functional
    ${windows}    Run    wmctrl -l
    Should Contain    ${windows.stdout}    gnome-info-collect

Take Application Screenshot
    [Documentation]    Capture a screenshot of the running application
    [Tags]    ui
    Wait Until Keyword Succeeds    5s    1s    Window Exists    gnome-info-collect
    Capture Screenshot    gnome-info-collect-main-window

*** Keywords ***
Verify Snap Is Installed
    ${list}    Run    snap list
    Should Contain    ${list.stdout}    gnome-info-collect

Uninstall Snap
    Run    snap remove gnome-info-collect    warn

Start Application
    [Documentation]    Start the gnome-info-collect snap
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
