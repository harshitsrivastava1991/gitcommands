*** Settings ***
Documentation    To validate the login form
Library    SeleniumLibrary
Library    Collections
Library    String
Test Setup    Open the browser with the url    Firefox
Test Teardown    Close Browser Session
Resource    ../PageObject/Generic.robot

*** Variables ***
${Error_Message_Login}        xpath://div[@class='alert alert-danger col-md-12']
${Shop_page_load}             xpath://a[@class='nav-link btn btn-primary']

*** Test Cases ***
Validate Child Window Functionality
    Select the link of the child window
    Verify the user is switched to child window
    Grab the email id in the child window
    Switch to Parent Window and enter the Email

*** Keywords ***

Select the link of the child window
    Click Element    css:.blinkingText
    Sleep    5

Verify the user is switched to child window
    Switch Window    New
    Element Text Should Be    xpath://h1[normalize-space()='Documents request']    DOCUMENTS REQUEST

Grab the email id in the child window
   ${text}=     Get Text    css:.red
   @{words}=    Split String    ${text}    at

   #0=Please email us
   #1=mentor@rahulshettyacademy.com with below template to receive response

   ${text_split}=    Get From List    ${words}    1
   Log    ${text_split}
   @{words_2}=    Split String    ${text_split}
   ${email}=    Get From List    ${words_2}    0
   Set Global Variable    ${email}
   
Switch to Parent Window and enter the Email
    Switch Window    MAIN
    Title Should Be    LoginPage Practise | Rahul Shetty Academy
    Input Text        id:username   ${email}
    Sleep    10




