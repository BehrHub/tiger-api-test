Feature: Security Test. Verify Token Test.

#			Generate a valid token and verify it with below requirement.
# 		test api endpoint "/api/token/verify" with valid Token.
# 		Status should be 200 - OK and response is true.
#			1)
Scenario:  Verify valid Token
Given url "https://tek-insurance-api.azurewebsites.net"
And path "/api/token"
And request {"username": "supervisor","password": "tek_supervisor"}
When method post
Then status 200
* def generatedToken = response.token
Given path "/api/token/verify"
And param username = "supervisor"
And param token = generatedToken
When method get
Then status 200
And print response


Scenario:  Verify invalid token
# 		Test api endpoint "api/token/verify" with invalid token.
# 		Note: since it's invalid token it can be any random string. you don't need to generate a new token.
# 		Status should be 400 - bad request and response should be token "TOKEN_EXPIRED"
# 		There is a defect open for this scenario already.
# 		2)
Given url "https://tek-insurance-api.azurewebsites.net"
And path "/api/token/verify"
And param username = "supervisor"
And param token = "invalid-token-random-string"
When method get
Then status 400
And print response


Scenario:  Test Token verify with valid token and invalid username
# 		Test api endpoint "api/token/verify" with Valid token and Invalid username,
# 		Status should be 400
# 		and errorMessage = Wrong username send along with Token.
# 		3)
Given url "https://tek-insurance-api.azurewebsites.net"
And path "/api/token/"
And request {"username": "supervisor","password": "tek_supervisor"}
When method post
Then status 200
* def generatedToken = response.token
Given path "/api/token/verify"
And param username = "invalid-username"
And param token = generatedToken
When method get
Then status 400
And print response
* def errorMessage = response.errorMessage
Then assert errorMessage == "Wrong Username send along with Token"
