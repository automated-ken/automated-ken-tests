*** Settings ***
Documentation    Test cases for cheese snap
Library    BuiltIn
Library    OperatingSystem
Library    Screenshot

Suite Setup    Verify Snap Is Installed
Suite Teardown    Uninstall Snap

*** Test Cases ***
Verify Cheese Snap Launches
    [Documentation]    Ensure the cheese snap launches successfully
    [Tags]    smoke
    ${result}    Run Keyword And Return Status    Snap List    cheese
    Should Be True    ${result}    cheese snap should be installed

Launch Cheese Application
    [Documentation]    Launch the cheese application
    [Tags]    functional
    Start Application    cheese
    Wait For Application Window    cheese    10s
    Capture Screenshot    cheese-launched

Verify Application Window Exists
    [Documentation]    Check that the application window is visible
    [Tags]    functional
    ${windows}    Run    wmctrl -l
    Should Contain    ${windows.stdout}    cheese

Take Application Screenshot
    [Documentation]    Capture a screenshot of the running application
    [Tags]    ui
    Wait Until Keyword Succeeds    5s    1s    Window Exists    cheese
    Capture Screenshot    cheese-main-window

*** Keywords ***
Verify Snap Is Installed
    ${list}    Run    snap list
    Should Contain    ${list.stdout}    cheese

Uninstall Snap
    Run    snap remove cheese    warn

Start Application
    [Documentation]    Start the cheese snap
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
