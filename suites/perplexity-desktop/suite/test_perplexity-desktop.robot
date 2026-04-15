*** Settings ***
Documentation    Test cases for perplexity-desktop snap
Library    BuiltIn
Library    OperatingSystem
Library    Screenshot

Suite Setup    Verify Snap Is Installed
Suite Teardown    Uninstall Snap

*** Test Cases ***
Verify Perplexity-desktop Snap Launches
    [Documentation]    Ensure the perplexity-desktop snap launches successfully
    [Tags]    smoke
    ${result}    Run Keyword And Return Status    Snap List    perplexity-desktop
    Should Be True    ${result}    perplexity-desktop snap should be installed

Launch Perplexity-desktop Application
    [Documentation]    Launch the perplexity-desktop application
    [Tags]    functional
    Start Application    perplexity-desktop
    Wait For Application Window    perplexity-desktop    10s
    Capture Screenshot    perplexity-desktop-launched

Verify Application Window Exists
    [Documentation]    Check that the application window is visible
    [Tags]    functional
    ${windows}    Run    wmctrl -l
    Should Contain    ${windows.stdout}    perplexity-desktop

Take Application Screenshot
    [Documentation]    Capture a screenshot of the running application
    [Tags]    ui
    Wait Until Keyword Succeeds    5s    1s    Window Exists    perplexity-desktop
    Capture Screenshot    perplexity-desktop-main-window

*** Keywords ***
Verify Snap Is Installed
    ${list}    Run    snap list
    Should Contain    ${list.stdout}    perplexity-desktop

Uninstall Snap
    Run    snap remove perplexity-desktop    warn

Start Application
    [Documentation]    Start the perplexity-desktop snap
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
