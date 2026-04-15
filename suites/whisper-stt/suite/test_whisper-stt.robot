*** Settings ***
Documentation    Test cases for whisper-stt snap
Library    BuiltIn
Library    OperatingSystem
Library    Screenshot

Suite Setup    Verify Snap Is Installed
Suite Teardown    Uninstall Snap

*** Test Cases ***
Verify Whisper-stt Snap Launches
    [Documentation]    Ensure the whisper-stt snap launches successfully
    [Tags]    smoke
    ${result}    Run Keyword And Return Status    Snap List    whisper-stt
    Should Be True    ${result}    whisper-stt snap should be installed

Launch Whisper-stt Application
    [Documentation]    Launch the whisper-stt application
    [Tags]    functional
    Start Application    whisper-stt
    Wait For Application Window    whisper-stt    10s
    Capture Screenshot    whisper-stt-launched

Verify Application Window Exists
    [Documentation]    Check that the application window is visible
    [Tags]    functional
    ${windows}    Run    wmctrl -l
    Should Contain    ${windows.stdout}    whisper-stt

Take Application Screenshot
    [Documentation]    Capture a screenshot of the running application
    [Tags]    ui
    Wait Until Keyword Succeeds    5s    1s    Window Exists    whisper-stt
    Capture Screenshot    whisper-stt-main-window

*** Keywords ***
Verify Snap Is Installed
    ${list}    Run    snap list
    Should Contain    ${list.stdout}    whisper-stt

Uninstall Snap
    Run    snap remove whisper-stt    warn

Start Application
    [Documentation]    Start the whisper-stt snap
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
