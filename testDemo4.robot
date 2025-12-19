*** Settings ***
Documentation    To validate the login form
Library    SeleniumLibrary
Test Teardown    Close Browser
Test Setup    Open the browser with the url    Firefox
Resource    ../PageObject/Generic.robot
Test Template    Validate unsuccessful login

*** Variables ***
${Error_Message_Login}        xpath://div[@class='alert alert-danger col-md-12']


*** Test Cases ***    username        password
Invalid username      dssdad          learning
Invalid password      Harshit     afaf
special character     @$!             learning

*** Keywords ***
Validate unsuccessful login
    [Arguments]    ${username}    ${password}
    Open the browser with the login page url
    Fill the login form    ${username}    ${password}
    Wait until it checks and display error message
    Verify error message is correct
    
Open the browser with the login page url
    Create Webdriver    firefox
    Go To    http://www.rahulshettyacademy.com/loginpagePractise/

Fill the login form
    [Arguments]    ${username}    ${password}
    Input Text        id:username   ${username}
    Input Password    id:password   ${password}
    Click Button      id:signInBtn

Wait until it checks and display error message
    Wait Until Element Is Visible    ${Error_Message_Login}

Verify error message is correct
    ${result}=    Get Text    ${Error_Message_Login}
    Should Be Equal As Strings    ${result}    Incorrect username/password.
    Element Text Should Be    ${Error_Message_Login}    Incorrect username/password.


