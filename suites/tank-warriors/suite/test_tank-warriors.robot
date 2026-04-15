*** Settings ***
Documentation    Test cases for tank-warriors snap
Library    BuiltIn
Library    OperatingSystem
Library    Screenshot

Suite Setup    Verify Snap Is Installed
Suite Teardown    Uninstall Snap

*** Test Cases ***
Verify Tank-warriors Snap Launches
    [Documentation]    Ensure the tank-warriors snap launches successfully
    [Tags]    smoke
    ${result}    Run Keyword And Return Status    Snap List    tank-warriors
    Should Be True    ${result}    tank-warriors snap should be installed

Launch Tank-warriors Application
    [Documentation]    Launch the tank-warriors application
    [Tags]    functional
    Start Application    tank-warriors
    Wait For Application Window    tank-warriors    10s
    Capture Screenshot    tank-warriors-launched

Verify Application Window Exists
    [Documentation]    Check that the application window is visible
    [Tags]    functional
    ${windows}    Run    wmctrl -l
    Should Contain    ${windows.stdout}    tank-warriors

Take Application Screenshot
    [Documentation]    Capture a screenshot of the running application
    [Tags]    ui
    Wait Until Keyword Succeeds    5s    1s    Window Exists    tank-warriors
    Capture Screenshot    tank-warriors-main-window

*** Keywords ***
Verify Snap Is Installed
    ${list}    Run    snap list
    Should Contain    ${list.stdout}    tank-warriors

Uninstall Snap
    Run    snap remove tank-warriors    warn

Start Application
    [Documentation]    Start the tank-warriors snap
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
