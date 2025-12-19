*** Settings ***
Documentation    To validate the login form
Library    SeleniumLibrary
Library    Collections
Library    ../customLibraries/Shop.py
Test Setup    Open the browser with the url
Suite Setup
Suite Teardown
Test Teardown    Close Browser Session
Resource    ../PageObject/Generic.robot
Resource    ../PageObject/LandingPage.robot
Resource    ../PageObject/ShopPage.robot
Resource    ../PageObject/CheckoutPage.robot
Resource    ../PageObject/Confirmation.robot

*** Variables ***
${country_name}    India
@{listofProducts}             Blackberry    Nokia Edge

*** Test Cases ***
Validate unsuccessful login
    [Tags]    SMOKE    REGRESSION
    LandingPage.Fill the login form    ${user_name}    ${invalid_password}
    LandingPage.wait until Element is located in the page
    LandingPage.Verify error message is correct
    
Validate cards display in the shopping page
    [Tags]    REGRESSION
    LandingPage.Fill the login Form     ${user_name}    ${valid_password}
    ShopPage.wait until Element is located in the page
    ShopPage.Verify Card titles in the Shop page
    add items to cart and checkout      ${listofProducts}
    CheckoutPage.Verify items in the Checkout Page and proceed
    Confirmation.Enter the Country and select the terms      ${country_name}
    Confirmation.Purchase the Product and Confirm the Purchase

Select the Form and navigate to Child Window
    LandingPage.Fill the Login Details and Login Form







    


