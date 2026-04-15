*** Settings ***
Documentation    Test cases for proton-lumo-ai snap
Library    BuiltIn
Library    OperatingSystem
Library    Screenshot

Suite Setup    Verify Snap Is Installed
Suite Teardown    Uninstall Snap

*** Test Cases ***
Verify Proton-lumo-ai Snap Launches
    [Documentation]    Ensure the proton-lumo-ai snap launches successfully
    [Tags]    smoke
    ${result}    Run Keyword And Return Status    Snap List    proton-lumo-ai
    Should Be True    ${result}    proton-lumo-ai snap should be installed

Launch Proton-lumo-ai Application
    [Documentation]    Launch the proton-lumo-ai application
    [Tags]    functional
    Start Application    proton-lumo-ai
    Wait For Application Window    proton-lumo-ai    10s
    Capture Screenshot    proton-lumo-ai-launched

Verify Application Window Exists
    [Documentation]    Check that the application window is visible
    [Tags]    functional
    ${windows}    Run    wmctrl -l
    Should Contain    ${windows.stdout}    proton-lumo-ai

Take Application Screenshot
    [Documentation]    Capture a screenshot of the running application
    [Tags]    ui
    Wait Until Keyword Succeeds    5s    1s    Window Exists    proton-lumo-ai
    Capture Screenshot    proton-lumo-ai-main-window

*** Keywords ***
Verify Snap Is Installed
    ${list}    Run    snap list
    Should Contain    ${list.stdout}    proton-lumo-ai

Uninstall Snap
    Run    snap remove proton-lumo-ai    warn

Start Application
    [Documentation]    Start the proton-lumo-ai snap
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
