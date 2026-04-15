*** Settings ***
Documentation    Test cases for TigerVNC snap
Library    BuiltIn
Library    OperatingSystem
Library    Screenshot

Suite Setup    Verify Snap Is Installed
Suite Teardown    Uninstall Snap

*** Test Cases ***
Verify TigerVNC Snap Launches
    [Documentation]    Ensure the TigerVNC snap launches successfully
    [Tags]    smoke
    ${result}    Run Keyword And Return Status    Snap List    TigerVNC
    Should Be True    ${result}    TigerVNC snap should be installed

Launch TigerVNC Application
    [Documentation]    Launch the TigerVNC application
    [Tags]    functional
    Start Application    TigerVNC
    Wait For Application Window    TigerVNC    10s
    Capture Screenshot    TigerVNC-launched

Verify Application Window Exists
    [Documentation]    Check that the application window is visible
    [Tags]    functional
    ${windows}    Run    wmctrl -l
    Should Contain    ${windows.stdout}    TigerVNC

Take Application Screenshot
    [Documentation]    Capture a screenshot of the running application
    [Tags]    ui
    Wait Until Keyword Succeeds    5s    1s    Window Exists    TigerVNC
    Capture Screenshot    TigerVNC-main-window

*** Keywords ***
Verify Snap Is Installed
    ${list}    Run    snap list
    Should Contain    ${list.stdout}    TigerVNC

Uninstall Snap
    Run    snap remove TigerVNC    warn

Start Application
    [Documentation]    Start the TigerVNC snap
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
