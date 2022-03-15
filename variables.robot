*** Variables ***

### URL ###
${BROWSER}              Chrome
${URL_BASE}             https://aptest.29next.store/
${ALIAS_REGISTER}       accounts/register/
${ALIAS_LOGIN}          accounts/login/
${ALIAS_LOGOUT}         accounts/logout/
${ALIAS_PROFILE}        accounts/profile/
${ALIAS_CATALOGUE}      catalogue/
${ALIAS_WATCH}          example-product_2/
${ALIAS_SHEET}          magic-sheets_3/
${ALIAS_BASKET}         basket/
${ALIAS_CHECKOUT_SA}    checkout/shipping-address/
${ALIAS_CHECKOUT_PD}    checkout/payment-details/
${ALIAS_CHECKOUT_OS}    order-status/
${ALIAS_ORDER_HIS}      accounts/orders/

### User Details ###
${VALID_USERNAME}=      dev+uat10@29next.com
${VALID_PASSWORD}=      29NextTest
${INVALID_USERNAME}=    dev+uat10@29next.co
${INVALID_PASSWORD}=    29NextTests

### Address Details ###
${FNAME}=           Test
${LNAME}=           User
${ADDRESS1}=        234 Test Ave
${CITY}=            Henderson
${STATE}=           KY
${COUNTRY}=         US
${POSTCODE}=        42301
${PHONE}=           0812345678

### Credit Card Details ###
${NUMBER}=          4111 1111 1111 1111
${NAME}=            Test User
${EXPIRATION}=      08/26
${CVV}=             123

### Button&Other's xpath ###
${XPATH_ADDRESS_BTN}=           //*[@id="new-shipping-address"]/div[2]/div[1]/button
${XPATH_PAYMENT_BTN}=           //*[@id="paymentBtn"]
${XPATH_ORDER_CONFIRMED}=       //*[@id="default"]/section[2]/div/div[1]/div/div/div/p/strong[2]

### Register Message ###
${REGISTER_FAIL_MESSAGE}=   A user with that email address already exists

### Login Message ###
${LOGIN_FAIL_MESSAGE}=      Please enter a correct email address and password.
${LOGIN_PASS_MESSAGE}=      Welcome back