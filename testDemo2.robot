
,jjcgxfxfvxcgxhfchgvg
*** Settings ***
Documentation    To validate the login form
Library    SeleniumLibrary
Library    Collections
Test Setup    Open the browser with the url    Firefox
Test Teardown    Close Browser Session
Resource    ../PageObject/Generic.robot

*** Variables ***
${Error_Message_Login}        xpath://div[@class='alert alert-danger col-md-12']
${Shop_page_load}             xpath://a[@class='nav-link btn btn-primary']

*** Test Cases ***
Validate unsuccessful login 
    Fill the login form    ${user_name}    ${invalid_password}
    Wait Until Element Is located in the page    ${Error_Message_Login}
    Verify error message is correct
    
Validate cards display in the shopping page
    Fill the login form    ${user_name}    ${valid_password}
    Wait Until Element Is located in the page    ${Shop_page_load}
    Verify card titles in the shop page
    Select the Card    Blackberry

Select the Form and navigate to Child Window
    Fill the login details and select the User Option

*** Keywords ***

Fill the login form
    [Arguments]    ${username}    ${password}
    Input Text        id:username   ${username}
    Input Password    id:password   ${password}
    Click Button      id:signInBtn


Wait Until Element Is located in the page
    [Arguments]    ${element}
    Wait Until Element Is Visible    ${element}

Verify error message is correct
    ${result}=    Get Text    ${Error_Message_Login}
    Should Be Equal As Strings    ${result}    Incorrect username/password.
    Element Text Should Be    ${Error_Message_Login}    Incorrect username/password.

Verify card titles in the shop page
    @{expectedList} =    Create List    iphone X    Samsung Note 8    Nokia Edge    Blackberry
    @{elements} =    Get WebElements    css:.card-title
    @{actualList} =    Create List    
    FOR    ${element}    IN    @{elements}
         Log    ${element.text}
         Append To list    ${actualList}    ${element.text}
    END
    Lists Should Be Equal    ${expectedList}    ${actualList}
    
Select the Card
    [Arguments]    ${cardName}
    ${elements} =    Get WebElements    css:.card-title
    ${index} =    Set Variable    1
    FOR     ${element}     IN    @{elements}
           Exit For Loop If        '${cardName}' == '${element.text}'
           ${index}=    Evaluate   ${index} + 1
        
    END
    Click Button    xpath:(//*[@class='card-footer'])[${index}]/button

Fill the login details and select the User Option
    Input Text        id:username    rahulshettyacademy
    Input Password    id:password    learning
    Click Element       xpath:(//span[@class='checkmark'])[2]
    Wait Until Element Is Visible    css:.modal-body
    Click Element    id:okayBtn
    Wait Until Element Is Not Visible    css:.modal-body
    Select From List By Value    css:select.form-control    teach
    Select Checkbox    id:terms
    Checkbox Should Be Selected    id:terms