*** Settings ***
Documentation    Test cases for lunar-client snap
Library    BuiltIn
Library    OperatingSystem
Library    Screenshot

Suite Setup    Verify Snap Is Installed
Suite Teardown    Uninstall Snap

*** Test Cases ***
Verify Lunar-client Snap Launches
    [Documentation]    Ensure the lunar-client snap launches successfully
    [Tags]    smoke
    ${result}    Run Keyword And Return Status    Snap List    lunar-client
    Should Be True    ${result}    lunar-client snap should be installed

Launch Lunar-client Application
    [Documentation]    Launch the lunar-client application
    [Tags]    functional
    Start Application    lunar-client
    Wait For Application Window    lunar-client    10s
    Capture Screenshot    lunar-client-launched

Verify Application Window Exists
    [Documentation]    Check that the application window is visible
    [Tags]    functional
    ${windows}    Run    wmctrl -l
    Should Contain    ${windows.stdout}    lunar-client

Take Application Screenshot
    [Documentation]    Capture a screenshot of the running application
    [Tags]    ui
    Wait Until Keyword Succeeds    5s    1s    Window Exists    lunar-client
    Capture Screenshot    lunar-client-main-window

*** Keywords ***
Verify Snap Is Installed
    ${list}    Run    snap list
    Should Contain    ${list.stdout}    lunar-client

Uninstall Snap
    Run    snap remove lunar-client    warn

Start Application
    [Documentation]    Start the lunar-client snap
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
