*** Settings ***
Documentation    Test cases for lightsoff snap
Library    BuiltIn
Library    OperatingSystem
Library    Screenshot

Suite Setup    Verify Snap Is Installed
Suite Teardown    Uninstall Snap

*** Test Cases ***
Verify Lightsoff Snap Launches
    [Documentation]    Ensure the lightsoff snap launches successfully
    [Tags]    smoke
    ${result}    Run Keyword And Return Status    Snap List    lightsoff
    Should Be True    ${result}    lightsoff snap should be installed

Launch Lightsoff Application
    [Documentation]    Launch the lightsoff application
    [Tags]    functional
    Start Application    lightsoff
    Wait For Application Window    lightsoff    10s
    Capture Screenshot    lightsoff-launched

Verify Application Window Exists
    [Documentation]    Check that the application window is visible
    [Tags]    functional
    ${windows}    Run    wmctrl -l
    Should Contain    ${windows.stdout}    lightsoff

Take Application Screenshot
    [Documentation]    Capture a screenshot of the running application
    [Tags]    ui
    Wait Until Keyword Succeeds    5s    1s    Window Exists    lightsoff
    Capture Screenshot    lightsoff-main-window

*** Keywords ***
Verify Snap Is Installed
    ${list}    Run    snap list
    Should Contain    ${list.stdout}    lightsoff

Uninstall Snap
    Run    snap remove lightsoff    warn

Start Application
    [Documentation]    Start the lightsoff snap
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
