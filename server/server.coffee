Meteor.methods
	createNewUser: (newUserName, newUserPassword, newUserAdmin) ->
		Accounts.createUser
			username: newUserName
			password: newUserPassword
			profile:
				isAdmin: newUserAdmin
	setPassword: (id, pw) ->
		Accounts.setPassword id, pw
