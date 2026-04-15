*** Settings ***
Documentation    Test cases for godot4 snap
Library    BuiltIn
Library    OperatingSystem
Library    Screenshot

Suite Setup    Verify Snap Is Installed
Suite Teardown    Uninstall Snap

*** Test Cases ***
Verify Godot4 Snap Launches
    [Documentation]    Ensure the godot4 snap launches successfully
    [Tags]    smoke
    ${result}    Run Keyword And Return Status    Snap List    godot4
    Should Be True    ${result}    godot4 snap should be installed

Launch Godot4 Application
    [Documentation]    Launch the godot4 application
    [Tags]    functional
    Start Application    godot4
    Wait For Application Window    godot4    10s
    Capture Screenshot    godot4-launched

Verify Application Window Exists
    [Documentation]    Check that the application window is visible
    [Tags]    functional
    ${windows}    Run    wmctrl -l
    Should Contain    ${windows.stdout}    godot4

Take Application Screenshot
    [Documentation]    Capture a screenshot of the running application
    [Tags]    ui
    Wait Until Keyword Succeeds    5s    1s    Window Exists    godot4
    Capture Screenshot    godot4-main-window

*** Keywords ***
Verify Snap Is Installed
    ${list}    Run    snap list
    Should Contain    ${list.stdout}    godot4

Uninstall Snap
    Run    snap remove godot4    warn

Start Application
    [Documentation]    Start the godot4 snap
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
