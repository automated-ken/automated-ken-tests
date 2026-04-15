*** Settings ***
Documentation    Test cases for glade snap
Library    BuiltIn
Library    OperatingSystem
Library    Screenshot

Suite Setup    Verify Snap Is Installed
Suite Teardown    Uninstall Snap

*** Test Cases ***
Verify Glade Snap Launches
    [Documentation]    Ensure the glade snap launches successfully
    [Tags]    smoke
    ${result}    Run Keyword And Return Status    Snap List    glade
    Should Be True    ${result}    glade snap should be installed

Launch Glade Application
    [Documentation]    Launch the glade application
    [Tags]    functional
    Start Application    glade
    Wait For Application Window    glade    10s
    Capture Screenshot    glade-launched

Verify Application Window Exists
    [Documentation]    Check that the application window is visible
    [Tags]    functional
    ${windows}    Run    wmctrl -l
    Should Contain    ${windows.stdout}    glade

Take Application Screenshot
    [Documentation]    Capture a screenshot of the running application
    [Tags]    ui
    Wait Until Keyword Succeeds    5s    1s    Window Exists    glade
    Capture Screenshot    glade-main-window

*** Keywords ***
Verify Snap Is Installed
    ${list}    Run    snap list
    Should Contain    ${list.stdout}    glade

Uninstall Snap
    Run    snap remove glade    warn

Start Application
    [Documentation]    Start the glade snap
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
