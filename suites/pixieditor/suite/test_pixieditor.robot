*** Settings ***
Documentation    Test cases for pixieditor snap
Library    BuiltIn
Library    OperatingSystem
Library    Screenshot

Suite Setup    Verify Snap Is Installed
Suite Teardown    Uninstall Snap

*** Test Cases ***
Verify Pixieditor Snap Launches
    [Documentation]    Ensure the pixieditor snap launches successfully
    [Tags]    smoke
    ${result}    Run Keyword And Return Status    Snap List    pixieditor
    Should Be True    ${result}    pixieditor snap should be installed

Launch Pixieditor Application
    [Documentation]    Launch the pixieditor application
    [Tags]    functional
    Start Application    pixieditor
    Wait For Application Window    pixieditor    10s
    Capture Screenshot    pixieditor-launched

Verify Application Window Exists
    [Documentation]    Check that the application window is visible
    [Tags]    functional
    ${windows}    Run    wmctrl -l
    Should Contain    ${windows.stdout}    pixieditor

Take Application Screenshot
    [Documentation]    Capture a screenshot of the running application
    [Tags]    ui
    Wait Until Keyword Succeeds    5s    1s    Window Exists    pixieditor
    Capture Screenshot    pixieditor-main-window

*** Keywords ***
Verify Snap Is Installed
    ${list}    Run    snap list
    Should Contain    ${list.stdout}    pixieditor

Uninstall Snap
    Run    snap remove pixieditor    warn

Start Application
    [Documentation]    Start the pixieditor snap
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
