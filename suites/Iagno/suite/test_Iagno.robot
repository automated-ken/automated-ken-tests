*** Settings ***
Documentation    Test cases for Iagno snap
Library    BuiltIn
Library    OperatingSystem
Library    Screenshot

Suite Setup    Verify Snap Is Installed
Suite Teardown    Uninstall Snap

*** Test Cases ***
Verify Iagno Snap Launches
    [Documentation]    Ensure the Iagno snap launches successfully
    [Tags]    smoke
    ${result}    Run Keyword And Return Status    Snap List    Iagno
    Should Be True    ${result}    Iagno snap should be installed

Launch Iagno Application
    [Documentation]    Launch the Iagno application
    [Tags]    functional
    Start Application    Iagno
    Wait For Application Window    Iagno    10s
    Capture Screenshot    Iagno-launched

Verify Application Window Exists
    [Documentation]    Check that the application window is visible
    [Tags]    functional
    ${windows}    Run    wmctrl -l
    Should Contain    ${windows.stdout}    Iagno

Take Application Screenshot
    [Documentation]    Capture a screenshot of the running application
    [Tags]    ui
    Wait Until Keyword Succeeds    5s    1s    Window Exists    Iagno
    Capture Screenshot    Iagno-main-window

*** Keywords ***
Verify Snap Is Installed
    ${list}    Run    snap list
    Should Contain    ${list.stdout}    Iagno

Uninstall Snap
    Run    snap remove Iagno    warn

Start Application
    [Documentation]    Start the Iagno snap
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
