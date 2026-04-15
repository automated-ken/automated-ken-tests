*** Settings ***
Documentation    Test cases for yaru-widgets-example snap
Library    BuiltIn
Library    OperatingSystem
Library    Screenshot

Suite Setup    Verify Snap Is Installed
Suite Teardown    Uninstall Snap

*** Test Cases ***
Verify Yaru-widgets-example Snap Launches
    [Documentation]    Ensure the yaru-widgets-example snap launches successfully
    [Tags]    smoke
    ${result}    Run Keyword And Return Status    Snap List    yaru-widgets-example
    Should Be True    ${result}    yaru-widgets-example snap should be installed

Launch Yaru-widgets-example Application
    [Documentation]    Launch the yaru-widgets-example application
    [Tags]    functional
    Start Application    yaru-widgets-example
    Wait For Application Window    yaru-widgets-example    10s
    Capture Screenshot    yaru-widgets-example-launched

Verify Application Window Exists
    [Documentation]    Check that the application window is visible
    [Tags]    functional
    ${windows}    Run    wmctrl -l
    Should Contain    ${windows.stdout}    yaru-widgets-example

Take Application Screenshot
    [Documentation]    Capture a screenshot of the running application
    [Tags]    ui
    Wait Until Keyword Succeeds    5s    1s    Window Exists    yaru-widgets-example
    Capture Screenshot    yaru-widgets-example-main-window

*** Keywords ***
Verify Snap Is Installed
    ${list}    Run    snap list
    Should Contain    ${list.stdout}    yaru-widgets-example

Uninstall Snap
    Run    snap remove yaru-widgets-example    warn

Start Application
    [Documentation]    Start the yaru-widgets-example snap
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
