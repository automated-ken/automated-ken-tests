*** Settings ***
Documentation    Test cases for Transporter snap
Library    BuiltIn
Library    OperatingSystem
Library    Screenshot

Suite Setup    Verify Snap Is Installed
Suite Teardown    Uninstall Snap

*** Test Cases ***
Verify Transporter Snap Launches
    [Documentation]    Ensure the Transporter snap launches successfully
    [Tags]    smoke
    ${result}    Run Keyword And Return Status    Snap List    Transporter
    Should Be True    ${result}    Transporter snap should be installed

Launch Transporter Application
    [Documentation]    Launch the Transporter application
    [Tags]    functional
    Start Application    Transporter
    Wait For Application Window    Transporter    10s
    Capture Screenshot    Transporter-launched

Verify Application Window Exists
    [Documentation]    Check that the application window is visible
    [Tags]    functional
    ${windows}    Run    wmctrl -l
    Should Contain    ${windows.stdout}    Transporter

Take Application Screenshot
    [Documentation]    Capture a screenshot of the running application
    [Tags]    ui
    Wait Until Keyword Succeeds    5s    1s    Window Exists    Transporter
    Capture Screenshot    Transporter-main-window

*** Keywords ***
Verify Snap Is Installed
    ${list}    Run    snap list
    Should Contain    ${list.stdout}    Transporter

Uninstall Snap
    Run    snap remove Transporter    warn

Start Application
    [Documentation]    Start the Transporter snap
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
