*** Settings ***
Documentation    Test cases for tali snap
Library    BuiltIn
Library    OperatingSystem
Library    Screenshot

Suite Setup    Verify Snap Is Installed
Suite Teardown    Uninstall Snap

*** Test Cases ***
Verify Tali Snap Launches
    [Documentation]    Ensure the tali snap launches successfully
    [Tags]    smoke
    ${result}    Run Keyword And Return Status    Snap List    tali
    Should Be True    ${result}    tali snap should be installed

Launch Tali Application
    [Documentation]    Launch the tali application
    [Tags]    functional
    Start Application    tali
    Wait For Application Window    tali    10s
    Capture Screenshot    tali-launched

Verify Application Window Exists
    [Documentation]    Check that the application window is visible
    [Tags]    functional
    ${windows}    Run    wmctrl -l
    Should Contain    ${windows.stdout}    tali

Take Application Screenshot
    [Documentation]    Capture a screenshot of the running application
    [Tags]    ui
    Wait Until Keyword Succeeds    5s    1s    Window Exists    tali
    Capture Screenshot    tali-main-window

*** Keywords ***
Verify Snap Is Installed
    ${list}    Run    snap list
    Should Contain    ${list.stdout}    tali

Uninstall Snap
    Run    snap remove tali    warn

Start Application
    [Documentation]    Start the tali snap
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
