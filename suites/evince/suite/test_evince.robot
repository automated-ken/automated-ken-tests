*** Settings ***
Documentation    Test cases for evince snap
Library    BuiltIn
Library    OperatingSystem
Library    Screenshot

Suite Setup    Verify Snap Is Installed
Suite Teardown    Uninstall Snap

*** Test Cases ***
Verify Evince Snap Launches
    [Documentation]    Ensure the evince snap launches successfully
    [Tags]    smoke
    ${result}    Run Keyword And Return Status    Snap List    evince
    Should Be True    ${result}    evince snap should be installed

Launch Evince Application
    [Documentation]    Launch the evince application
    [Tags]    functional
    Start Application    evince
    Wait For Application Window    evince    10s
    Capture Screenshot    evince-launched

Verify Application Window Exists
    [Documentation]    Check that the application window is visible
    [Tags]    functional
    ${windows}    Run    wmctrl -l
    Should Contain    ${windows.stdout}    evince

Take Application Screenshot
    [Documentation]    Capture a screenshot of the running application
    [Tags]    ui
    Wait Until Keyword Succeeds    5s    1s    Window Exists    evince
    Capture Screenshot    evince-main-window

*** Keywords ***
Verify Snap Is Installed
    ${list}    Run    snap list
    Should Contain    ${list.stdout}    evince

Uninstall Snap
    Run    snap remove evince    warn

Start Application
    [Documentation]    Start the evince snap
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
