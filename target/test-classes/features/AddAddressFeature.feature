Feature:  Create an account and add address to the account.

#  Step 1)	Get a token
#  Step 2)	Generate an account
#  Step 3)	Add address to generated account

Background:  Create new account
 Given url "https://tek-insurance-api.azurewebsites.net"
 * def CreateAccountResult = callonce read('CreateAccountFeature.feature')
 And print CreateAccountResult
 * def primaryPersonId = CreateAccountResult.response.id
 * def token = CreateAccountResult.result.response.token
 
  
Scenario:  Add address to an account
 Given path "/api/accounts/add-account-address"
 Given param primaryPersonId = primaryPersonId 
 Given header Authorization = "Bearer " + token
 Given request
 		"""
		{
		"addressType": "Home",
		"addressLine1": "88 Octopus Drive",
		"city": "Bethesda",
		"state": "MD",
		"postalCode": "20814",
		"current": true,
		}
		"""
 When method post
 Then status 201
 And print response
