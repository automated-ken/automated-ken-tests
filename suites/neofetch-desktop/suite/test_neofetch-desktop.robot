*** Settings ***
Documentation    Test cases for neofetch-desktop snap
Library    BuiltIn
Library    OperatingSystem
Library    Screenshot

Suite Setup    Verify Snap Is Installed
Suite Teardown    Uninstall Snap

*** Test Cases ***
Verify Neofetch-desktop Snap Launches
    [Documentation]    Ensure the neofetch-desktop snap launches successfully
    [Tags]    smoke
    ${result}    Run Keyword And Return Status    Snap List    neofetch-desktop
    Should Be True    ${result}    neofetch-desktop snap should be installed

Launch Neofetch-desktop Application
    [Documentation]    Launch the neofetch-desktop application
    [Tags]    functional
    Start Application    neofetch-desktop
    Wait For Application Window    neofetch-desktop    10s
    Capture Screenshot    neofetch-desktop-launched

Verify Application Window Exists
    [Documentation]    Check that the application window is visible
    [Tags]    functional
    ${windows}    Run    wmctrl -l
    Should Contain    ${windows.stdout}    neofetch-desktop

Take Application Screenshot
    [Documentation]    Capture a screenshot of the running application
    [Tags]    ui
    Wait Until Keyword Succeeds    5s    1s    Window Exists    neofetch-desktop
    Capture Screenshot    neofetch-desktop-main-window

*** Keywords ***
Verify Snap Is Installed
    ${list}    Run    snap list
    Should Contain    ${list.stdout}    neofetch-desktop

Uninstall Snap
    Run    snap remove neofetch-desktop    warn

Start Application
    [Documentation]    Start the neofetch-desktop snap
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
