*** Settings ***
Documentation    Test cases for ASHPD-Demo snap
Library    BuiltIn
Library    OperatingSystem
Library    Screenshot

Suite Setup    Verify Snap Is Installed
Suite Teardown    Uninstall Snap

*** Test Cases ***
Verify ASHPD-Demo Snap Launches
    [Documentation]    Ensure the ASHPD-Demo snap launches successfully
    [Tags]    smoke
    ${result}    Run Keyword And Return Status    Snap List    ASHPD-Demo
    Should Be True    ${result}    ASHPD-Demo snap should be installed

Launch ASHPD-Demo Application
    [Documentation]    Launch the ASHPD-Demo application
    [Tags]    functional
    Start Application    ASHPD-Demo
    Wait For Application Window    ASHPD-Demo    10s
    Capture Screenshot    ASHPD-Demo-launched

Verify Application Window Exists
    [Documentation]    Check that the application window is visible
    [Tags]    functional
    ${windows}    Run    wmctrl -l
    Should Contain    ${windows.stdout}    ASHPD-Demo

Take Application Screenshot
    [Documentation]    Capture a screenshot of the running application
    [Tags]    ui
    Wait Until Keyword Succeeds    5s    1s    Window Exists    ASHPD-Demo
    Capture Screenshot    ASHPD-Demo-main-window

*** Keywords ***
Verify Snap Is Installed
    ${list}    Run    snap list
    Should Contain    ${list.stdout}    ASHPD-Demo

Uninstall Snap
    Run    snap remove ASHPD-Demo    warn

Start Application
    [Documentation]    Start the ASHPD-Demo snap
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
