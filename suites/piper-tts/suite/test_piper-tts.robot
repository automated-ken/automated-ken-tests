*** Settings ***
Documentation    Test cases for piper-tts snap
Library    BuiltIn
Library    OperatingSystem
Library    Screenshot

Suite Setup    Verify Snap Is Installed
Suite Teardown    Uninstall Snap

*** Test Cases ***
Verify Piper-tts Snap Launches
    [Documentation]    Ensure the piper-tts snap launches successfully
    [Tags]    smoke
    ${result}    Run Keyword And Return Status    Snap List    piper-tts
    Should Be True    ${result}    piper-tts snap should be installed

Launch Piper-tts Application
    [Documentation]    Launch the piper-tts application
    [Tags]    functional
    Start Application    piper-tts
    Wait For Application Window    piper-tts    10s
    Capture Screenshot    piper-tts-launched

Verify Application Window Exists
    [Documentation]    Check that the application window is visible
    [Tags]    functional
    ${windows}    Run    wmctrl -l
    Should Contain    ${windows.stdout}    piper-tts

Take Application Screenshot
    [Documentation]    Capture a screenshot of the running application
    [Tags]    ui
    Wait Until Keyword Succeeds    5s    1s    Window Exists    piper-tts
    Capture Screenshot    piper-tts-main-window

*** Keywords ***
Verify Snap Is Installed
    ${list}    Run    snap list
    Should Contain    ${list.stdout}    piper-tts

Uninstall Snap
    Run    snap remove piper-tts    warn

Start Application
    [Documentation]    Start the piper-tts snap
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
