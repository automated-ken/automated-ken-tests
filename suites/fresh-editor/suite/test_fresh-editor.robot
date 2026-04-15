*** Settings ***
Documentation    Test cases for fresh-editor snap
Library    BuiltIn
Library    OperatingSystem
Library    Screenshot

Suite Setup    Verify Snap Is Installed
Suite Teardown    Uninstall Snap

*** Test Cases ***
Verify Fresh-editor Snap Launches
    [Documentation]    Ensure the fresh-editor snap launches successfully
    [Tags]    smoke
    ${result}    Run Keyword And Return Status    Snap List    fresh-editor
    Should Be True    ${result}    fresh-editor snap should be installed

Launch Fresh-editor Application
    [Documentation]    Launch the fresh-editor application
    [Tags]    functional
    Start Application    fresh-editor
    Wait For Application Window    fresh-editor    10s
    Capture Screenshot    fresh-editor-launched

Verify Application Window Exists
    [Documentation]    Check that the application window is visible
    [Tags]    functional
    ${windows}    Run    wmctrl -l
    Should Contain    ${windows.stdout}    fresh-editor

Take Application Screenshot
    [Documentation]    Capture a screenshot of the running application
    [Tags]    ui
    Wait Until Keyword Succeeds    5s    1s    Window Exists    fresh-editor
    Capture Screenshot    fresh-editor-main-window

*** Keywords ***
Verify Snap Is Installed
    ${list}    Run    snap list
    Should Contain    ${list.stdout}    fresh-editor

Uninstall Snap
    Run    snap remove fresh-editor    warn

Start Application
    [Documentation]    Start the fresh-editor snap
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
