*** Settings ***
Documentation    Test cases for gtk-theme-traditionalhumanized snap
Library    BuiltIn
Library    OperatingSystem
Library    Screenshot

Suite Setup    Verify Snap Is Installed
Suite Teardown    Uninstall Snap

*** Test Cases ***
Verify Gtk-theme-traditionalhumanized Snap Launches
    [Documentation]    Ensure the gtk-theme-traditionalhumanized snap launches successfully
    [Tags]    smoke
    ${result}    Run Keyword And Return Status    Snap List    gtk-theme-traditionalhumanized
    Should Be True    ${result}    gtk-theme-traditionalhumanized snap should be installed

Launch Gtk-theme-traditionalhumanized Application
    [Documentation]    Launch the gtk-theme-traditionalhumanized application
    [Tags]    functional
    Start Application    gtk-theme-traditionalhumanized
    Wait For Application Window    gtk-theme-traditionalhumanized    10s
    Capture Screenshot    gtk-theme-traditionalhumanized-launched

Verify Application Window Exists
    [Documentation]    Check that the application window is visible
    [Tags]    functional
    ${windows}    Run    wmctrl -l
    Should Contain    ${windows.stdout}    gtk-theme-traditionalhumanized

Take Application Screenshot
    [Documentation]    Capture a screenshot of the running application
    [Tags]    ui
    Wait Until Keyword Succeeds    5s    1s    Window Exists    gtk-theme-traditionalhumanized
    Capture Screenshot    gtk-theme-traditionalhumanized-main-window

*** Keywords ***
Verify Snap Is Installed
    ${list}    Run    snap list
    Should Contain    ${list.stdout}    gtk-theme-traditionalhumanized

Uninstall Snap
    Run    snap remove gtk-theme-traditionalhumanized    warn

Start Application
    [Documentation]    Start the gtk-theme-traditionalhumanized snap
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
