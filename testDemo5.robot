*** Settings ***
Documentation    To validate the login form
Library    SeleniumLibrary
Library    DataDriver    file=C:\Users\hs235x\PycharmProjects\PythonProject1\RobotFramework\test\resources
Test Teardown    Close Browser
Test Setup    Open the browser with the url    Firefox
Resource    ../PageObject/Generic.robot
Test Template    Validate unsuccessful login

*** Variables ***
${Error_Message_Login}        xpath://div[@class='alert alert-danger col-md-12']

*** Test Cases ***
Login with user ${username} and password ${password}    abc    123456


*** Keywords ***
Validate unsuccessful login
    [Tags]    SMOKE
    [Arguments]    ${username}    ${password}
    Open the browser with the login page url
    Fill the login form    ${username}    ${password}
    Wait until it checks and display error message
    Verify error message is correct
    
Open the browser with the login page url

    Create Webdriver    Firefox
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


