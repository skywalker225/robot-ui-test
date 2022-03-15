#############################################################################################
##                               29 Next UAT TEST CASE                                     ##
#############################################################################################
# 1. Registration Verification = 2 test cases
# 2. Login Verification = 3 test cases
# 3. Checkout Verification = 4 test cases

*** Settings ***
Library         RequestsLibrary
Library         SeleniumLibrary
Library         String
Resource        variables.robot
Resource        keywords.robot
Suite Setup     Open Browser    ${URL_BASE}     ${BROWSER}
...             Maximize Browser Window
Suite Teardown  Close Browser


*** Test Cases ***

### Registration Verification ###
Register With Available Email Should Succeed
    [Documentation]     Register with available and valid email
    [Tags]      Register
    Register Attempt    ${URL_BASE}
    ...     ${ALIAS_REGISTER}
    ...     ${FNAME}
    ...     ${LNAME}
    ...     ${VALID_USERNAME}
    ...     ${VALID_PASSWORD}
    ...     ${URL_BASE}${ALIAS_PROFILE}
    Go To   ${URL_BASE}${ALIAS_LOGOUT}

Register With Existed Email Should Fail
    [Documentation]     Register with existed email
    [Tags]      Register
    Register Attempt    ${URL_BASE}
    ...     ${ALIAS_REGISTER}
    ...     ${FNAME}
    ...     ${LNAME}
    ...     ${VALID_USERNAME}
    ...     ${VALID_PASSWORD}
    ...     ${URL_BASE}${ALIAS_REGISTER}
    Wait Until Page Contains    ${REGISTER_FAIL_MESSAGE}

### Login Verification ###
Login With Username That Does Not Existed Should Fail
    [Documentation]     Login with username(email) that's not existed
    [Tags]      Login
    Login Attempt   ${URL_BASE}
    ...     ${ALIAS_LOGIN}
    ...     ${INVALID_USERNAME}
    ...     ${VALID_PASSWORD}
    ...     ${URL_BASE}${ALIAS_LOGIN}
    ...     ${LOGIN_FAIL_MESSAGE}

Login With Password That Does Not Matched Should Fail
    [Documentation]     Login with existed username(email) but invalid password
    [Tags]      Login
    Login Attempt   ${URL_BASE}
    ...     ${ALIAS_LOGIN}
    ...     ${VALID_USERNAME}
    ...     ${INVALID_PASSWORD}
    ...     ${URL_BASE}${ALIAS_LOGIN}
    ...     ${LOGIN_FAIL_MESSAGE}
    
Login With Valid Username And Password Should Succeed
    [Documentation]     Login with existed username(email) and valid password
    [Tags]      Login
    Login Attempt   ${URL_BASE}
    ...     ${ALIAS_LOGIN}
    ...     ${VALID_USERNAME}
    ...     ${VALID_PASSWORD}
    ...     ${URL_BASE}${ALIAS_PROFILE}
    ...     ${LOGIN_PASS_MESSAGE}

### Checkout Verification ###
Create Order With Empty Address Should Fail
    [Documentation]     Checkout with empty address
    [Tags]      Checkout
    Add Product To Cart     ${URL_BASE}     ${ALIAS_CATALOGUE}      ${ALIAS_WATCH}
    Add Empty Shipping Address    ${URL_BASE}     ${ALIAS_CHECKOUT_SA}    ${xpath_address_btn}

Create Order With Empty Credit Card Should Fail
    [Documentation]     Checkout with empty card number, name, expiration and cvv in payment process
    [Tags]      Checkout
    Add Product To Cart     ${URL_BASE}     ${ALIAS_CATALOGUE}      ${ALIAS_WATCH}
    Add Valid Shipping Address    ${URL_BASE}
    ...                     ${ALIAS_CHECKOUT_SA}
    ...                     ${FNAME}
    ...                     ${LNAME}
    ...                     ${ADDRESS1}
    ...                     ${CITY}
    ...                     ${STATE}
    ...                     ${COUNTRY}
    ...                     ${POSTCODE}
    ...                     ${XPATH_ADDRESS_BTN}
    Add Empty Credit Card   ${URL_BASE}     ${ALIAS_CHECKOUT_PD}    ${xpath_payment_btn}

Create Order With Incomplete Credit Card Should Fail
    [Documentation]     Checkout with valid card number, name and expiration but empty cvv in payment process
    [Tags]      Checkout
    Add Product To Cart     ${URL_BASE}     ${ALIAS_CATALOGUE}      ${ALIAS_WATCH}
    Add Valid Shipping Address    ${URL_BASE}
    ...     ${ALIAS_CHECKOUT_SA}
    ...     ${FNAME}
    ...     ${LNAME}
    ...     ${ADDRESS1}
    ...     ${CITY}
    ...     ${STATE}
    ...     ${COUNTRY}
    ...     ${POSTCODE}
    ...     ${xpath_address_btn}
    Wait Until Keyword Succeeds
    ...     10 sec
    ...     1 sec
    ...     Add Invalid Credit Card
    ...     ${URL_BASE}
    ...     ${ALIAS_CHECKOUT_PD}
    ...     ${NUMBER}
    ...     ${NAME}
    ...     ${EXPIRATION}
    ...     ${XPATH_PAYMENT_BTN}
    Sleep   5s
    Run Keyword And Continue On Failure     Location Should Be      ${URL_BASE}${ALIAS_CHECKOUT_PD}

Create Order With Valid Credit Card Should Succeed
    [Documentation]     Checkout with valid card number, name, expiration and cvv in payment process
    [Tags]      Checkout
    Add Product To Cart     ${URL_BASE}     ${ALIAS_CATALOGUE}      ${ALIAS_WATCH}
    Add Valid Shipping Address    ${URL_BASE}
    ...     ${ALIAS_CHECKOUT_SA}
    ...     ${FNAME}
    ...     ${LNAME}
    ...     ${ADDRESS1}
    ...     ${CITY}
    ...     ${STATE}
    ...     ${COUNTRY}
    ...     ${POSTCODE}
    ...     ${xpath_address_btn}
    Add Valid Credit Card     ${URL_BASE}
    ...     ${ALIAS_CHECKOUT_PD}
    ...     ${NUMBER}
    ...     ${NAME}
    ...     ${EXPIRATION}
    ...     ${CVV}
    ...     ${xpath_payment_btn}
    Check Order Status  ${URL_BASE}     ${ALIAS_CHECKOUT_OS}    ${ALIAS_ORDER_HIS}      ${XPATH_ORDER_CONFIRMED}