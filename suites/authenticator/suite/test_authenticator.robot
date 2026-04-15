*** Settings ***
Documentation    Test cases for authenticator snap
Library    BuiltIn
Library    OperatingSystem
Library    Screenshot

Suite Setup    Verify Snap Is Installed
Suite Teardown    Uninstall Snap

*** Test Cases ***
Verify Authenticator Snap Launches
    [Documentation]    Ensure the authenticator snap launches successfully
    [Tags]    smoke
    ${result}    Run Keyword And Return Status    Snap List    authenticator
    Should Be True    ${result}    authenticator snap should be installed

Launch Authenticator Application
    [Documentation]    Launch the authenticator application
    [Tags]    functional
    Start Application    authenticator
    Wait For Application Window    authenticator    10s
    Capture Screenshot    authenticator-launched

Verify Application Window Exists
    [Documentation]    Check that the application window is visible
    [Tags]    functional
    ${windows}    Run    wmctrl -l
    Should Contain    ${windows.stdout}    authenticator

Take Application Screenshot
    [Documentation]    Capture a screenshot of the running application
    [Tags]    ui
    Wait Until Keyword Succeeds    5s    1s    Window Exists    authenticator
    Capture Screenshot    authenticator-main-window

*** Keywords ***
Verify Snap Is Installed
    ${list}    Run    snap list
    Should Contain    ${list.stdout}    authenticator

Uninstall Snap
    Run    snap remove authenticator    warn

Start Application
    [Documentation]    Start the authenticator snap
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
