*** Settings ***
Documentation    Test cases for element-desktop snap
Library    BuiltIn
Library    OperatingSystem
Library    Screenshot

Suite Setup    Verify Snap Is Installed
Suite Teardown    Uninstall Snap

*** Test Cases ***
Verify Element-desktop Snap Launches
    [Documentation]    Ensure the element-desktop snap launches successfully
    [Tags]    smoke
    ${result}    Run Keyword And Return Status    Snap List    element-desktop
    Should Be True    ${result}    element-desktop snap should be installed

Launch Element-desktop Application
    [Documentation]    Launch the element-desktop application
    [Tags]    functional
    Start Application    element-desktop
    Wait For Application Window    element-desktop    10s
    Capture Screenshot    element-desktop-launched

Verify Application Window Exists
    [Documentation]    Check that the application window is visible
    [Tags]    functional
    ${windows}    Run    wmctrl -l
    Should Contain    ${windows.stdout}    element-desktop

Take Application Screenshot
    [Documentation]    Capture a screenshot of the running application
    [Tags]    ui
    Wait Until Keyword Succeeds    5s    1s    Window Exists    element-desktop
    Capture Screenshot    element-desktop-main-window

*** Keywords ***
Verify Snap Is Installed
    ${list}    Run    snap list
    Should Contain    ${list.stdout}    element-desktop

Uninstall Snap
    Run    snap remove element-desktop    warn

Start Application
    [Documentation]    Start the element-desktop snap
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
