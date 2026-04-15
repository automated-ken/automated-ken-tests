*** Settings ***
Documentation    Test cases for gnome-mines snap
Library    BuiltIn
Library    OperatingSystem
Library    Screenshot

Suite Setup    Verify Snap Is Installed
Suite Teardown    Uninstall Snap

*** Test Cases ***
Verify Gnome-mines Snap Launches
    [Documentation]    Ensure the gnome-mines snap launches successfully
    [Tags]    smoke
    ${result}    Run Keyword And Return Status    Snap List    gnome-mines
    Should Be True    ${result}    gnome-mines snap should be installed

Launch Gnome-mines Application
    [Documentation]    Launch the gnome-mines application
    [Tags]    functional
    Start Application    gnome-mines
    Wait For Application Window    gnome-mines    10s
    Capture Screenshot    gnome-mines-launched

Verify Application Window Exists
    [Documentation]    Check that the application window is visible
    [Tags]    functional
    ${windows}    Run    wmctrl -l
    Should Contain    ${windows.stdout}    gnome-mines

Take Application Screenshot
    [Documentation]    Capture a screenshot of the running application
    [Tags]    ui
    Wait Until Keyword Succeeds    5s    1s    Window Exists    gnome-mines
    Capture Screenshot    gnome-mines-main-window

*** Keywords ***
Verify Snap Is Installed
    ${list}    Run    snap list
    Should Contain    ${list.stdout}    gnome-mines

Uninstall Snap
    Run    snap remove gnome-mines    warn

Start Application
    [Documentation]    Start the gnome-mines snap
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
