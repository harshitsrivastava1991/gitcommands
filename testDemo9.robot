*** Settings ***
Library    SeleniumLibrary
Resource    ../PageObject/CAPGeneric.robot
Test Teardown    Close Browser
Test Setup    Open The CAP URL On any Browser

*** Test Cases ***
Validate the CAP flow
    CAPGeneric.Select the att password option
    CAPGeneric.Validate the login flow and submit    ${user_name}    ${user_password}
    CAPGeneric.Validate the elements on the home page banner



