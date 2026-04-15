*** Settings ***
Documentation    Test cases for gnome-font-viewer snap
Library    BuiltIn
Library    OperatingSystem
Library    Screenshot

Suite Setup    Verify Snap Is Installed
Suite Teardown    Uninstall Snap

*** Test Cases ***
Verify Gnome-font-viewer Snap Launches
    [Documentation]    Ensure the gnome-font-viewer snap launches successfully
    [Tags]    smoke
    ${result}    Run Keyword And Return Status    Snap List    gnome-font-viewer
    Should Be True    ${result}    gnome-font-viewer snap should be installed

Launch Gnome-font-viewer Application
    [Documentation]    Launch the gnome-font-viewer application
    [Tags]    functional
    Start Application    gnome-font-viewer
    Wait For Application Window    gnome-font-viewer    10s
    Capture Screenshot    gnome-font-viewer-launched

Verify Application Window Exists
    [Documentation]    Check that the application window is visible
    [Tags]    functional
    ${windows}    Run    wmctrl -l
    Should Contain    ${windows.stdout}    gnome-font-viewer

Take Application Screenshot
    [Documentation]    Capture a screenshot of the running application
    [Tags]    ui
    Wait Until Keyword Succeeds    5s    1s    Window Exists    gnome-font-viewer
    Capture Screenshot    gnome-font-viewer-main-window

*** Keywords ***
Verify Snap Is Installed
    ${list}    Run    snap list
    Should Contain    ${list.stdout}    gnome-font-viewer

Uninstall Snap
    Run    snap remove gnome-font-viewer    warn

Start Application
    [Documentation]    Start the gnome-font-viewer snap
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
