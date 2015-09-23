Meteor.methods
	createNewUser: (newUserName, newUserPassword, newUserAdmin) ->
		Accounts.createUser
			username: newUserName
			password: newUserPassword
			profile:
				isAdmin: newUserAdmin
	setPassword: (id, pw) ->
		Accounts.setPassword id, pw


Meteor.startup () ->
	if Meteor.users.find().count() == 0
		Accounts.createUser
			username: 'basti'
			password: 'basti'
			email: 'sk@dotob.de'
	if share.Menus.find().count() == 0
		fs = Npm.require 'fs'
		path = Npm.require 'path'
		basepath = path.resolve('.').split('.meteor')[0]
		file = basepath + "private/sattelite.json"
		data_raw = fs.readFileSync file, 'utf8'
		data = JSON.parse data_raw
		for e in data
			share.Menus.insert e
