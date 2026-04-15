*** Settings ***
Documentation    Test cases for gnome-nibbles snap
Library    BuiltIn
Library    OperatingSystem
Library    Screenshot

Suite Setup    Verify Snap Is Installed
Suite Teardown    Uninstall Snap

*** Test Cases ***
Verify Gnome-nibbles Snap Launches
    [Documentation]    Ensure the gnome-nibbles snap launches successfully
    [Tags]    smoke
    ${result}    Run Keyword And Return Status    Snap List    gnome-nibbles
    Should Be True    ${result}    gnome-nibbles snap should be installed

Launch Gnome-nibbles Application
    [Documentation]    Launch the gnome-nibbles application
    [Tags]    functional
    Start Application    gnome-nibbles
    Wait For Application Window    gnome-nibbles    10s
    Capture Screenshot    gnome-nibbles-launched

Verify Application Window Exists
    [Documentation]    Check that the application window is visible
    [Tags]    functional
    ${windows}    Run    wmctrl -l
    Should Contain    ${windows.stdout}    gnome-nibbles

Take Application Screenshot
    [Documentation]    Capture a screenshot of the running application
    [Tags]    ui
    Wait Until Keyword Succeeds    5s    1s    Window Exists    gnome-nibbles
    Capture Screenshot    gnome-nibbles-main-window

*** Keywords ***
Verify Snap Is Installed
    ${list}    Run    snap list
    Should Contain    ${list.stdout}    gnome-nibbles

Uninstall Snap
    Run    snap remove gnome-nibbles    warn

Start Application
    [Documentation]    Start the gnome-nibbles snap
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
