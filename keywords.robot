*** Keywords ***

### Register & Login Keyword ###
Register Attempt
    [Arguments]     ${url}      ${alias}    ${fname}    ${lname}    ${email}    ${password}     ${location}
    Go To           ${url}${alias}
    Input Text      id=id_first_name    ${fname}
    Input Text      id=id_last_name     ${lname}
    Input Text      id=id_email         ${email}
    Input Text      id=id_password1     ${password}
    Click Button    Register
    Location Should Be          ${location}

Login Attempt
    [Arguments]     ${url}      ${alias}    ${username}     ${password}     ${location}     ${message}
    Go To           ${url}${alias}
    Input Text      id=id_login-username    ${username}
    Input Text      id=id_login-password    ${password}
    Click Button    name=login_submit
    Location Should Be          ${location}
    Wait Until Page Contains    ${message}

### Checkout Process Keyword ###
Add Product To Cart
    [Arguments]     ${url}      ${alias}    ${product}
    Go To           ${url}${alias}
    Wait Until Location Is      ${url}${alias}      timeout=10  
    Go To           ${url}${alias}${product}
    Wait Until Location Is      ${url}${alias}${product}    timeout=10
    Select Radio Button         subscription-option     one-time
    Radio Button Should Be Set To   subscription-option     one-time
    Select From List By Value       id_quantity     1
    Click Button    Add to cart
    Go To           ${url}${ALIAS_BASKET}
    Select From List By Value       id=id_form-0-quantity   1

Add Empty Shipping Address
    [Arguments]     ${url}  ${alias}    ${xpath}
    Go To           ${url}${alias}
    Wait Until Location Is      ${url}${alias}      timeout=10
    Execute Javascript      document.evaluate('${xpath}', document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.click(); 
    Location Should Be      ${url}${alias}

Add Valid Shipping Address
    [Arguments]     ${url}  ${alias}    ${fname}    ${lname}    ${address1}     ${city}     ${state}    ${country}      ${postcode}     ${xpath}
    Go To           ${url}${alias}
    Wait Until Location Is      ${url}${alias}      timeout=10
    Select From List By Value       id=id_country   ${country}
    Input Text      id=id_first_name    ${fname}
    Input Text      id=id_last_name     ${lname}
    Input Text      id=id_line1         ${address1}
    Input Text      id=id_line4         ${city}
    Input Text      id=id_state         ${state}
    Input Text      id=id_postcode      ${postcode}
    Execute Javascript      document.evaluate('${xpath}', document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.click(); 

Add Empty Credit Card
    [Arguments]     ${url}  ${alias}    ${xpath}
    Go To           ${url}${alias}
    Wait Until Location Is      ${url}${alias}      timeout=10
    Execute Javascript      document.evaluate('${xpath}', document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.click(); 
    Location Should Be      ${url}${alias}

Add Invalid Credit Card
    [Arguments]     ${url}  ${alias}    ${number}   ${name}     ${expiration}   ${xpath}
    Wait Until Location Is      ${url}${alias}      timeout=10
    Select Radio Button         payment_method      new_card
    Select Frame        css:[src="https://core.spreedly.com/v1/embedded/number-frame.html?v=1.73"]
    Input Text          id=card_number      ${number}
    Unselect Frame
    Input Text          id=id_name         ${name}
    Input Text          id=id_expiry       ${expiration}
    Unselect Checkbox   id=id_is_saved_card
    Select Radio Button     same_as_shipping    true
    Execute Javascript      document.evaluate('${xpath}', document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.click();  

Add Valid Credit Card
    [Arguments]     ${url}  ${alias}    ${number}   ${name}     ${expiration}   ${cvv}  ${xpath}
    Wait Until Location Is      ${url}${alias}      timeout=10
    Select Radio Button         payment_method      new_card
    Select Frame        css:[src="https://core.spreedly.com/v1/embedded/number-frame.html?v=1.73"]
    Input Text          id=card_number      ${number}
    Unselect Frame
    Input Text          id=id_name         ${name}
    Input Text          id=id_expiry       ${expiration}
    Select Frame        css:[src="https://core.spreedly.com/v1/embedded/cvv-frame.html?v=1.73"]
    Input Text          id=cvv      ${cvv}
    Unselect Frame
    Unselect Checkbox   id=id_is_saved_card
    Select Radio Button     same_as_shipping    true
    Execute Javascript      document.evaluate('${xpath}', document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.click(); 

Check Order Status
    [Arguments]     ${url}  ${alias_os}     ${alias_oh}     ${xpath}
    Wait Until Page Contains    Thank you for your order!
    ${page_title}=      Get Title
    ${order_id}=        Remove String Using Regexp      ${page_title}       [^0-9]
    Go To               ${url}${alias_oh}${order_id}
    ${status}=          Get Text    ${xpath}
    Should Match        ${status}   Confirmed