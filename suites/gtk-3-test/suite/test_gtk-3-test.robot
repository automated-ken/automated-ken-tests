*** Settings ***
Documentation    Test cases for gtk-3-test snap
Library    BuiltIn
Library    OperatingSystem
Library    Screenshot

Suite Setup    Verify Snap Is Installed
Suite Teardown    Uninstall Snap

*** Test Cases ***
Verify Gtk-3-test Snap Launches
    [Documentation]    Ensure the gtk-3-test snap launches successfully
    [Tags]    smoke
    ${result}    Run Keyword And Return Status    Snap List    gtk-3-test
    Should Be True    ${result}    gtk-3-test snap should be installed

Launch Gtk-3-test Application
    [Documentation]    Launch the gtk-3-test application
    [Tags]    functional
    Start Application    gtk-3-test
    Wait For Application Window    gtk-3-test    10s
    Capture Screenshot    gtk-3-test-launched

Verify Application Window Exists
    [Documentation]    Check that the application window is visible
    [Tags]    functional
    ${windows}    Run    wmctrl -l
    Should Contain    ${windows.stdout}    gtk-3-test

Take Application Screenshot
    [Documentation]    Capture a screenshot of the running application
    [Tags]    ui
    Wait Until Keyword Succeeds    5s    1s    Window Exists    gtk-3-test
    Capture Screenshot    gtk-3-test-main-window

*** Keywords ***
Verify Snap Is Installed
    ${list}    Run    snap list
    Should Contain    ${list.stdout}    gtk-3-test

Uninstall Snap
    Run    snap remove gtk-3-test    warn

Start Application
    [Documentation]    Start the gtk-3-test snap
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
