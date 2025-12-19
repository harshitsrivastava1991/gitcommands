*** Settings ***
Documentation    To validate the login form
Library    SeleniumLibrary
Test Teardown    Close Browser
Test Setup    Open the browser with the url    Firefox
Resource    ../PageObject/Generic.robot

*** Variables ***
${Error_Message_Login}        xpath://div[@class='alert alert-danger col-md-12']


*** Test Cases ***
Validate unsuccessful login
    Open the browser with the login page url
    Fill the login form
    Wait until it checks and display error message
    Verify error message is correct

*** Keywords ***
Open the browser with the login page url
    Create Webdriver    Firefox
    Go To    http://www.rahulshettyacademy.com/loginpagePractise/
Fill the login form
    Input Text        id:username   Harshit Srivastava
    Input Password    id:password   123234
    Click Button      id:signInBtn
Wait until it checks and display error message
    Wait Until Element Is Visible    ${Error_Message_Login}
Verify error message is correct
    ${result}=    Get Text    ${Error_Message_Login}
    Should Be Equal As Strings    ${result}    Incorrect username/password.
    Element Text Should Be    ${Error_Message_Login}    Incorrect username/password.


