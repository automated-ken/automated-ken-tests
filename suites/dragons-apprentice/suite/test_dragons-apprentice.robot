*** Settings ***
Documentation    Test cases for dragons-apprentice snap
Library    BuiltIn
Library    OperatingSystem
Library    Screenshot

Suite Setup    Verify Snap Is Installed
Suite Teardown    Uninstall Snap

*** Test Cases ***
Verify Dragons-apprentice Snap Launches
    [Documentation]    Ensure the dragons-apprentice snap launches successfully
    [Tags]    smoke
    ${result}    Run Keyword And Return Status    Snap List    dragons-apprentice
    Should Be True    ${result}    dragons-apprentice snap should be installed

Launch Dragons-apprentice Application
    [Documentation]    Launch the dragons-apprentice application
    [Tags]    functional
    Start Application    dragons-apprentice
    Wait For Application Window    dragons-apprentice    10s
    Capture Screenshot    dragons-apprentice-launched

Verify Application Window Exists
    [Documentation]    Check that the application window is visible
    [Tags]    functional
    ${windows}    Run    wmctrl -l
    Should Contain    ${windows.stdout}    dragons-apprentice

Take Application Screenshot
    [Documentation]    Capture a screenshot of the running application
    [Tags]    ui
    Wait Until Keyword Succeeds    5s    1s    Window Exists    dragons-apprentice
    Capture Screenshot    dragons-apprentice-main-window

*** Keywords ***
Verify Snap Is Installed
    ${list}    Run    snap list
    Should Contain    ${list.stdout}    dragons-apprentice

Uninstall Snap
    Run    snap remove dragons-apprentice    warn

Start Application
    [Documentation]    Start the dragons-apprentice snap
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
