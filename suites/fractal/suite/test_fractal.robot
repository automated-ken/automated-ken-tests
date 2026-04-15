*** Settings ***
Documentation    Test cases for fractal snap
Library    BuiltIn
Library    OperatingSystem
Library    Screenshot

Suite Setup    Verify Snap Is Installed
Suite Teardown    Uninstall Snap

*** Test Cases ***
Verify Fractal Snap Launches
    [Documentation]    Ensure the fractal snap launches successfully
    [Tags]    smoke
    ${result}    Run Keyword And Return Status    Snap List    fractal
    Should Be True    ${result}    fractal snap should be installed

Launch Fractal Application
    [Documentation]    Launch the fractal application
    [Tags]    functional
    Start Application    fractal
    Wait For Application Window    fractal    10s
    Capture Screenshot    fractal-launched

Verify Application Window Exists
    [Documentation]    Check that the application window is visible
    [Tags]    functional
    ${windows}    Run    wmctrl -l
    Should Contain    ${windows.stdout}    fractal

Take Application Screenshot
    [Documentation]    Capture a screenshot of the running application
    [Tags]    ui
    Wait Until Keyword Succeeds    5s    1s    Window Exists    fractal
    Capture Screenshot    fractal-main-window

*** Keywords ***
Verify Snap Is Installed
    ${list}    Run    snap list
    Should Contain    ${list.stdout}    fractal

Uninstall Snap
    Run    snap remove fractal    warn

Start Application
    [Documentation]    Start the fractal snap
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
