*** Settings ***
Documentation    Test cases for dippi snap
Library    BuiltIn
Library    OperatingSystem
Library    Screenshot

Suite Setup    Verify Snap Is Installed
Suite Teardown    Uninstall Snap

*** Test Cases ***
Verify Dippi Snap Launches
    [Documentation]    Ensure the dippi snap launches successfully
    [Tags]    smoke
    ${result}    Run Keyword And Return Status    Snap List    dippi
    Should Be True    ${result}    dippi snap should be installed

Launch Dippi Application
    [Documentation]    Launch the dippi application
    [Tags]    functional
    Start Application    dippi
    Wait For Application Window    dippi    10s
    Capture Screenshot    dippi-launched

Verify Application Window Exists
    [Documentation]    Check that the application window is visible
    [Tags]    functional
    ${windows}    Run    wmctrl -l
    Should Contain    ${windows.stdout}    dippi

Take Application Screenshot
    [Documentation]    Capture a screenshot of the running application
    [Tags]    ui
    Wait Until Keyword Succeeds    5s    1s    Window Exists    dippi
    Capture Screenshot    dippi-main-window

*** Keywords ***
Verify Snap Is Installed
    ${list}    Run    snap list
    Should Contain    ${list.stdout}    dippi

Uninstall Snap
    Run    snap remove dippi    warn

Start Application
    [Documentation]    Start the dippi snap
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
