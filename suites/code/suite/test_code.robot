*** Settings ***
Documentation    Test cases for code snap
Library    BuiltIn
Library    OperatingSystem
Library    Screenshot

Suite Setup    Verify Snap Is Installed
Suite Teardown    Uninstall Snap

*** Test Cases ***
Verify Code Snap Launches
    [Documentation]    Ensure the code snap launches successfully
    [Tags]    smoke
    ${result}    Run Keyword And Return Status    Snap List    code
    Should Be True    ${result}    code snap should be installed

Launch Code Application
    [Documentation]    Launch the code application
    [Tags]    functional
    Start Application    code
    Wait For Application Window    code    10s
    Capture Screenshot    code-launched

Verify Application Window Exists
    [Documentation]    Check that the application window is visible
    [Tags]    functional
    ${windows}    Run    wmctrl -l
    Should Contain    ${windows.stdout}    code

Take Application Screenshot
    [Documentation]    Capture a screenshot of the running application
    [Tags]    ui
    Wait Until Keyword Succeeds    5s    1s    Window Exists    code
    Capture Screenshot    code-main-window

*** Keywords ***
Verify Snap Is Installed
    ${list}    Run    snap list
    Should Contain    ${list.stdout}    code

Uninstall Snap
    Run    snap remove code    warn

Start Application
    [Documentation]    Start the code snap
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
