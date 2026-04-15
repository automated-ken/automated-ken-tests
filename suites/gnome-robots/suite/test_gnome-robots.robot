*** Settings ***
Documentation    Test cases for gnome-robots snap
Library    BuiltIn
Library    OperatingSystem
Library    Screenshot

Suite Setup    Verify Snap Is Installed
Suite Teardown    Uninstall Snap

*** Test Cases ***
Verify Gnome-robots Snap Launches
    [Documentation]    Ensure the gnome-robots snap launches successfully
    [Tags]    smoke
    ${result}    Run Keyword And Return Status    Snap List    gnome-robots
    Should Be True    ${result}    gnome-robots snap should be installed

Launch Gnome-robots Application
    [Documentation]    Launch the gnome-robots application
    [Tags]    functional
    Start Application    gnome-robots
    Wait For Application Window    gnome-robots    10s
    Capture Screenshot    gnome-robots-launched

Verify Application Window Exists
    [Documentation]    Check that the application window is visible
    [Tags]    functional
    ${windows}    Run    wmctrl -l
    Should Contain    ${windows.stdout}    gnome-robots

Take Application Screenshot
    [Documentation]    Capture a screenshot of the running application
    [Tags]    ui
    Wait Until Keyword Succeeds    5s    1s    Window Exists    gnome-robots
    Capture Screenshot    gnome-robots-main-window

*** Keywords ***
Verify Snap Is Installed
    ${list}    Run    snap list
    Should Contain    ${list.stdout}    gnome-robots

Uninstall Snap
    Run    snap remove gnome-robots    warn

Start Application
    [Documentation]    Start the gnome-robots snap
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
