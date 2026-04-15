*** Settings ***
Documentation    Test cases for open-model-zoo snap
Library    BuiltIn
Library    OperatingSystem
Library    Screenshot

Suite Setup    Verify Snap Is Installed
Suite Teardown    Uninstall Snap

*** Test Cases ***
Verify Open-model-zoo Snap Launches
    [Documentation]    Ensure the open-model-zoo snap launches successfully
    [Tags]    smoke
    ${result}    Run Keyword And Return Status    Snap List    open-model-zoo
    Should Be True    ${result}    open-model-zoo snap should be installed

Launch Open-model-zoo Application
    [Documentation]    Launch the open-model-zoo application
    [Tags]    functional
    Start Application    open-model-zoo
    Wait For Application Window    open-model-zoo    10s
    Capture Screenshot    open-model-zoo-launched

Verify Application Window Exists
    [Documentation]    Check that the application window is visible
    [Tags]    functional
    ${windows}    Run    wmctrl -l
    Should Contain    ${windows.stdout}    open-model-zoo

Take Application Screenshot
    [Documentation]    Capture a screenshot of the running application
    [Tags]    ui
    Wait Until Keyword Succeeds    5s    1s    Window Exists    open-model-zoo
    Capture Screenshot    open-model-zoo-main-window

*** Keywords ***
Verify Snap Is Installed
    ${list}    Run    snap list
    Should Contain    ${list.stdout}    open-model-zoo

Uninstall Snap
    Run    snap remove open-model-zoo    warn

Start Application
    [Documentation]    Start the open-model-zoo snap
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
