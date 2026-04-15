*** Settings ***
Documentation    Test cases for super-cool-app snap
Library    BuiltIn
Library    OperatingSystem
Library    Screenshot

Suite Setup    Verify Snap Is Installed
Suite Teardown    Uninstall Snap

*** Test Cases ***
Verify Super-cool-app Snap Launches
    [Documentation]    Ensure the super-cool-app snap launches successfully
    [Tags]    smoke
    ${result}    Run Keyword And Return Status    Snap List    super-cool-app
    Should Be True    ${result}    super-cool-app snap should be installed

Launch Super-cool-app Application
    [Documentation]    Launch the super-cool-app application
    [Tags]    functional
    Start Application    super-cool-app
    Wait For Application Window    super-cool-app    10s
    Capture Screenshot    super-cool-app-launched

Verify Application Window Exists
    [Documentation]    Check that the application window is visible
    [Tags]    functional
    ${windows}    Run    wmctrl -l
    Should Contain    ${windows.stdout}    super-cool-app

Take Application Screenshot
    [Documentation]    Capture a screenshot of the running application
    [Tags]    ui
    Wait Until Keyword Succeeds    5s    1s    Window Exists    super-cool-app
    Capture Screenshot    super-cool-app-main-window

*** Keywords ***
Verify Snap Is Installed
    ${list}    Run    snap list
    Should Contain    ${list.stdout}    super-cool-app

Uninstall Snap
    Run    snap remove super-cool-app    warn

Start Application
    [Documentation]    Start the super-cool-app snap
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
