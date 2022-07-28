@Smoke
Feature:  Security Test, Token Generating Test

#1)
@security
Scenario:  Generate Token with valid username and password
Given url 'https://tek-insurance-api.azurewebsites.net'
And path "/api/token"
And request {"username": "supervisor", "password": "tek_supervisor"}
When method post
Then status 200
And print response

#2)
@negativeUN
Scenario:  Generate Token with invalid username and valid password
Given url 'https://tek-insurance-api.azurewebsites.net'
And path "/api/token"
And request {"username": "sprvsr", "password": "tek_supervisor"}
When method post
Then status 404
And print response
* def errorMessage = response.errorMessage
And assert errorMessage == "USER_NOT_FOUND"


#3)
@negativePW
Scenario:  Generate Token with valid username and invalid password
Given url 'https://tek-insurance-api.azurewebsites.net'
And path "/api/token"
And request {"username": "supervisor", "password": "tk_sprvsr"}
When method post
Then status 400
And print response
* def errorMessage = response.errorMessage
And assert errorMessage == "Password Not Matched"
