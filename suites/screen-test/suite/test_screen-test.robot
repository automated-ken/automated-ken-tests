*** Settings ***
Documentation    Test cases for screen-test snap
Library    BuiltIn
Library    OperatingSystem
Library    Screenshot

Suite Setup    Verify Snap Is Installed
Suite Teardown    Uninstall Snap

*** Test Cases ***
Verify Screen-test Snap Launches
    [Documentation]    Ensure the screen-test snap launches successfully
    [Tags]    smoke
    ${result}    Run Keyword And Return Status    Snap List    screen-test
    Should Be True    ${result}    screen-test snap should be installed

Launch Screen-test Application
    [Documentation]    Launch the screen-test application
    [Tags]    functional
    Start Application    screen-test
    Wait For Application Window    screen-test    10s
    Capture Screenshot    screen-test-launched

Verify Application Window Exists
    [Documentation]    Check that the application window is visible
    [Tags]    functional
    ${windows}    Run    wmctrl -l
    Should Contain    ${windows.stdout}    screen-test

Take Application Screenshot
    [Documentation]    Capture a screenshot of the running application
    [Tags]    ui
    Wait Until Keyword Succeeds    5s    1s    Window Exists    screen-test
    Capture Screenshot    screen-test-main-window

*** Keywords ***
Verify Snap Is Installed
    ${list}    Run    snap list
    Should Contain    ${list.stdout}    screen-test

Uninstall Snap
    Run    snap remove screen-test    warn

Start Application
    [Documentation]    Start the screen-test snap
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
