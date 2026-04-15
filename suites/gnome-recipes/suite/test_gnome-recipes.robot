*** Settings ***
Documentation    Test cases for gnome-recipes snap
Library    BuiltIn
Library    OperatingSystem
Library    Screenshot

Suite Setup    Verify Snap Is Installed
Suite Teardown    Uninstall Snap

*** Test Cases ***
Verify Gnome-recipes Snap Launches
    [Documentation]    Ensure the gnome-recipes snap launches successfully
    [Tags]    smoke
    ${result}    Run Keyword And Return Status    Snap List    gnome-recipes
    Should Be True    ${result}    gnome-recipes snap should be installed

Launch Gnome-recipes Application
    [Documentation]    Launch the gnome-recipes application
    [Tags]    functional
    Start Application    gnome-recipes
    Wait For Application Window    gnome-recipes    10s
    Capture Screenshot    gnome-recipes-launched

Verify Application Window Exists
    [Documentation]    Check that the application window is visible
    [Tags]    functional
    ${windows}    Run    wmctrl -l
    Should Contain    ${windows.stdout}    gnome-recipes

Take Application Screenshot
    [Documentation]    Capture a screenshot of the running application
    [Tags]    ui
    Wait Until Keyword Succeeds    5s    1s    Window Exists    gnome-recipes
    Capture Screenshot    gnome-recipes-main-window

*** Keywords ***
Verify Snap Is Installed
    ${list}    Run    snap list
    Should Contain    ${list.stdout}    gnome-recipes

Uninstall Snap
    Run    snap remove gnome-recipes    warn

Start Application
    [Documentation]    Start the gnome-recipes snap
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
