*** Settings ***
Documentation    Test cases for device-config-client snap
Library    BuiltIn
Library    OperatingSystem
Library    Screenshot

Suite Setup    Verify Snap Is Installed
Suite Teardown    Uninstall Snap

*** Test Cases ***
Verify Device-config-client Snap Launches
    [Documentation]    Ensure the device-config-client snap launches successfully
    [Tags]    smoke
    ${result}    Run Keyword And Return Status    Snap List    device-config-client
    Should Be True    ${result}    device-config-client snap should be installed

Launch Device-config-client Application
    [Documentation]    Launch the device-config-client application
    [Tags]    functional
    Start Application    device-config-client
    Wait For Application Window    device-config-client    10s
    Capture Screenshot    device-config-client-launched

Verify Application Window Exists
    [Documentation]    Check that the application window is visible
    [Tags]    functional
    ${windows}    Run    wmctrl -l
    Should Contain    ${windows.stdout}    device-config-client

Take Application Screenshot
    [Documentation]    Capture a screenshot of the running application
    [Tags]    ui
    Wait Until Keyword Succeeds    5s    1s    Window Exists    device-config-client
    Capture Screenshot    device-config-client-main-window

*** Keywords ***
Verify Snap Is Installed
    ${list}    Run    snap list
    Should Contain    ${list.stdout}    device-config-client

Uninstall Snap
    Run    snap remove device-config-client    warn

Start Application
    [Documentation]    Start the device-config-client snap
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
