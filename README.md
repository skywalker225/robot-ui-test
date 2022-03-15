# robot-ui-test
an automated UAT test for the checkout flow to ensure user can successfully create an order

## Test Configuration
1. Robot Framework 4.1.3 (Python 3.9.5 on darwin)
2. robotframework-seleniumlibrary installed
3. webdriver/chromedriver installed

Run test by `robot 29next_ui_test.robot`, keywords.robot and variables.robot are required.

## Test Case
Test result is in **output** folder
1. Registration Verification = 2 test cases
   - Register With Available Email Should Succeed
   - Register With Existed Email Should Fail
2. Login Verification = 3 test cases
   - Login With Username That Does Not Existed Should Fail
   - Login With Password That Does Not Matched Should Fail
   - Login With Valid Username And Password Should Succeed
3. Checkout Verification = 4 test cases
   - Create Order With Empty Address Should Fail
   - Create Order With Empty Credit Card Should Fail
   - Create Order With Incomplete Credit Card Should Fail ***
   - Create Order With Valid Input Should Succeed
 
_*** User able to pay by credit card without cvv, this test case failed_
 
 ![screencapture-file-Users-monchayaaudson-Documents-next-log-html-2022-03-15-09_18_19](https://user-images.githubusercontent.com/3469379/158301228-700d7466-5034-4a59-9234-331278ec72fb.png)
