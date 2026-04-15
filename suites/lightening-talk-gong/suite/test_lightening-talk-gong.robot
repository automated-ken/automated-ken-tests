*** Settings ***
Documentation    Test cases for lightening-talk-gong snap
Library    BuiltIn
Library    OperatingSystem
Library    Screenshot

Suite Setup    Verify Snap Is Installed
Suite Teardown    Uninstall Snap

*** Test Cases ***
Verify Lightening-talk-gong Snap Launches
    [Documentation]    Ensure the lightening-talk-gong snap launches successfully
    [Tags]    smoke
    ${result}    Run Keyword And Return Status    Snap List    lightening-talk-gong
    Should Be True    ${result}    lightening-talk-gong snap should be installed

Launch Lightening-talk-gong Application
    [Documentation]    Launch the lightening-talk-gong application
    [Tags]    functional
    Start Application    lightening-talk-gong
    Wait For Application Window    lightening-talk-gong    10s
    Capture Screenshot    lightening-talk-gong-launched

Verify Application Window Exists
    [Documentation]    Check that the application window is visible
    [Tags]    functional
    ${windows}    Run    wmctrl -l
    Should Contain    ${windows.stdout}    lightening-talk-gong

Take Application Screenshot
    [Documentation]    Capture a screenshot of the running application
    [Tags]    ui
    Wait Until Keyword Succeeds    5s    1s    Window Exists    lightening-talk-gong
    Capture Screenshot    lightening-talk-gong-main-window

*** Keywords ***
Verify Snap Is Installed
    ${list}    Run    snap list
    Should Contain    ${list.stdout}    lightening-talk-gong

Uninstall Snap
    Run    snap remove lightening-talk-gong    warn

Start Application
    [Documentation]    Start the lightening-talk-gong snap
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
