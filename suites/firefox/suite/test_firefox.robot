*** Settings ***
Documentation    Test cases for firefox snap
Library    BuiltIn
Library    OperatingSystem
Library    Screenshot

Suite Setup    Verify Snap Is Installed
Suite Teardown    Uninstall Snap

*** Test Cases ***
Verify Firefox Snap Launches
    [Documentation]    Ensure the firefox snap launches successfully
    [Tags]    smoke
    ${result}    Run Keyword And Return Status    Snap List    firefox
    Should Be True    ${result}    firefox snap should be installed

Launch Firefox Application
    [Documentation]    Launch the firefox application
    [Tags]    functional
    Start Application    firefox
    Wait For Application Window    firefox    10s
    Capture Screenshot    firefox-launched

Verify Application Window Exists
    [Documentation]    Check that the application window is visible
    [Tags]    functional
    ${windows}    Run    wmctrl -l
    Should Contain    ${windows.stdout}    firefox

Take Application Screenshot
    [Documentation]    Capture a screenshot of the running application
    [Tags]    ui
    Wait Until Keyword Succeeds    5s    1s    Window Exists    firefox
    Capture Screenshot    firefox-main-window

*** Keywords ***
Verify Snap Is Installed
    ${list}    Run    snap list
    Should Contain    ${list.stdout}    firefox

Uninstall Snap
    Run    snap remove firefox    warn

Start Application
    [Documentation]    Start the firefox snap
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
