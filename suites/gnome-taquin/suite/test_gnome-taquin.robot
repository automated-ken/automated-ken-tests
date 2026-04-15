*** Settings ***
Documentation    Test cases for gnome-taquin snap
Library    BuiltIn
Library    OperatingSystem
Library    Screenshot

Suite Setup    Verify Snap Is Installed
Suite Teardown    Uninstall Snap

*** Test Cases ***
Verify Gnome-taquin Snap Launches
    [Documentation]    Ensure the gnome-taquin snap launches successfully
    [Tags]    smoke
    ${result}    Run Keyword And Return Status    Snap List    gnome-taquin
    Should Be True    ${result}    gnome-taquin snap should be installed

Launch Gnome-taquin Application
    [Documentation]    Launch the gnome-taquin application
    [Tags]    functional
    Start Application    gnome-taquin
    Wait For Application Window    gnome-taquin    10s
    Capture Screenshot    gnome-taquin-launched

Verify Application Window Exists
    [Documentation]    Check that the application window is visible
    [Tags]    functional
    ${windows}    Run    wmctrl -l
    Should Contain    ${windows.stdout}    gnome-taquin

Take Application Screenshot
    [Documentation]    Capture a screenshot of the running application
    [Tags]    ui
    Wait Until Keyword Succeeds    5s    1s    Window Exists    gnome-taquin
    Capture Screenshot    gnome-taquin-main-window

*** Keywords ***
Verify Snap Is Installed
    ${list}    Run    snap list
    Should Contain    ${list.stdout}    gnome-taquin

Uninstall Snap
    Run    snap remove gnome-taquin    warn

Start Application
    [Documentation]    Start the gnome-taquin snap
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
