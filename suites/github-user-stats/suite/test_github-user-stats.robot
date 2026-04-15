*** Settings ***
Documentation    Test cases for github-user-stats snap
Library    BuiltIn
Library    OperatingSystem
Library    Screenshot

Suite Setup    Verify Snap Is Installed
Suite Teardown    Uninstall Snap

*** Test Cases ***
Verify Github-user-stats Snap Launches
    [Documentation]    Ensure the github-user-stats snap launches successfully
    [Tags]    smoke
    ${result}    Run Keyword And Return Status    Snap List    github-user-stats
    Should Be True    ${result}    github-user-stats snap should be installed

Launch Github-user-stats Application
    [Documentation]    Launch the github-user-stats application
    [Tags]    functional
    Start Application    github-user-stats
    Wait For Application Window    github-user-stats    10s
    Capture Screenshot    github-user-stats-launched

Verify Application Window Exists
    [Documentation]    Check that the application window is visible
    [Tags]    functional
    ${windows}    Run    wmctrl -l
    Should Contain    ${windows.stdout}    github-user-stats

Take Application Screenshot
    [Documentation]    Capture a screenshot of the running application
    [Tags]    ui
    Wait Until Keyword Succeeds    5s    1s    Window Exists    github-user-stats
    Capture Screenshot    github-user-stats-main-window

*** Keywords ***
Verify Snap Is Installed
    ${list}    Run    snap list
    Should Contain    ${list.stdout}    github-user-stats

Uninstall Snap
    Run    snap remove github-user-stats    warn

Start Application
    [Documentation]    Start the github-user-stats snap
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
