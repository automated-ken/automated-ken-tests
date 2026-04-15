*** Settings ***
Documentation    Test cases for alpaca-kenvandine snap
Library    BuiltIn
Library    OperatingSystem
Library    Screenshot

Suite Setup    Verify Snap Is Installed
Suite Teardown    Uninstall Snap

*** Test Cases ***
Verify Alpaca-kenvandine Snap Launches
    [Documentation]    Ensure the alpaca-kenvandine snap launches successfully
    [Tags]    smoke
    ${result}    Run Keyword And Return Status    Snap List    alpaca-kenvandine
    Should Be True    ${result}    alpaca-kenvandine snap should be installed

Launch Alpaca-kenvandine Application
    [Documentation]    Launch the alpaca-kenvandine application
    [Tags]    functional
    Start Application    alpaca-kenvandine
    Wait For Application Window    alpaca-kenvandine    10s
    Capture Screenshot    alpaca-kenvandine-launched

Verify Application Window Exists
    [Documentation]    Check that the application window is visible
    [Tags]    functional
    ${windows}    Run    wmctrl -l
    Should Contain    ${windows.stdout}    alpaca-kenvandine

Take Application Screenshot
    [Documentation]    Capture a screenshot of the running application
    [Tags]    ui
    Wait Until Keyword Succeeds    5s    1s    Window Exists    alpaca-kenvandine
    Capture Screenshot    alpaca-kenvandine-main-window

*** Keywords ***
Verify Snap Is Installed
    ${list}    Run    snap list
    Should Contain    ${list.stdout}    alpaca-kenvandine

Uninstall Snap
    Run    snap remove alpaca-kenvandine    warn

Start Application
    [Documentation]    Start the alpaca-kenvandine snap
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
