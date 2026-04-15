*** Settings ***
Documentation    Test cases for aqueducts snap
Library    BuiltIn
Library    OperatingSystem
Library    Screenshot

Suite Setup    Verify Snap Is Installed
Suite Teardown    Uninstall Snap

*** Test Cases ***
Verify Aqueducts Snap Launches
    [Documentation]    Ensure the aqueducts snap launches successfully
    [Tags]    smoke
    ${result}    Run Keyword And Return Status    Snap List    aqueducts
    Should Be True    ${result}    aqueducts snap should be installed

Launch Aqueducts Application
    [Documentation]    Launch the aqueducts application
    [Tags]    functional
    Start Application    aqueducts
    Wait For Application Window    aqueducts    10s
    Capture Screenshot    aqueducts-launched

Verify Application Window Exists
    [Documentation]    Check that the application window is visible
    [Tags]    functional
    ${windows}    Run    wmctrl -l
    Should Contain    ${windows.stdout}    aqueducts

Take Application Screenshot
    [Documentation]    Capture a screenshot of the running application
    [Tags]    ui
    Wait Until Keyword Succeeds    5s    1s    Window Exists    aqueducts
    Capture Screenshot    aqueducts-main-window

*** Keywords ***
Verify Snap Is Installed
    ${list}    Run    snap list
    Should Contain    ${list.stdout}    aqueducts

Uninstall Snap
    Run    snap remove aqueducts    warn

Start Application
    [Documentation]    Start the aqueducts snap
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
