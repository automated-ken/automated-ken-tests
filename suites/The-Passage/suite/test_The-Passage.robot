*** Settings ***
Documentation    Test cases for The-Passage snap
Library    BuiltIn
Library    OperatingSystem
Library    Screenshot

Suite Setup    Verify Snap Is Installed
Suite Teardown    Uninstall Snap

*** Test Cases ***
Verify The-Passage Snap Launches
    [Documentation]    Ensure the The-Passage snap launches successfully
    [Tags]    smoke
    ${result}    Run Keyword And Return Status    Snap List    The-Passage
    Should Be True    ${result}    The-Passage snap should be installed

Launch The-Passage Application
    [Documentation]    Launch the The-Passage application
    [Tags]    functional
    Start Application    The-Passage
    Wait For Application Window    The-Passage    10s
    Capture Screenshot    The-Passage-launched

Verify Application Window Exists
    [Documentation]    Check that the application window is visible
    [Tags]    functional
    ${windows}    Run    wmctrl -l
    Should Contain    ${windows.stdout}    The-Passage

Take Application Screenshot
    [Documentation]    Capture a screenshot of the running application
    [Tags]    ui
    Wait Until Keyword Succeeds    5s    1s    Window Exists    The-Passage
    Capture Screenshot    The-Passage-main-window

*** Keywords ***
Verify Snap Is Installed
    ${list}    Run    snap list
    Should Contain    ${list.stdout}    The-Passage

Uninstall Snap
    Run    snap remove The-Passage    warn

Start Application
    [Documentation]    Start the The-Passage snap
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
