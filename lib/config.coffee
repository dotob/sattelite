# create collections
share.Menus = new Mongo.Collection 'menus' 
share.Orders = new Mongo.Collection 'orders' 

# add created, updated etc fields
#share.Orders.attachBehaviour 'timestampable'

onlyUsers = 
	insert: (userId) ->
		userId?
	update: (userId) ->
		userId?
	remove: (userId) ->
		userId?

onlyAdmin = 
	insert: (userId) ->
		user = Meteor.users.findOne(userId)
		user?.profile?.isAdmin
	update: (userId) ->
		user = Meteor.users.findOne(userId)
		user?.profile?.isAdmin
	remove: (userId) ->
		user = Meteor.users.findOne(userId)
		user?.profile?.isAdmin

# user access config
share.Menus.allow onlyUsers
share.Orders.allow onlyUsers

Meteor.users.allow
	remove: (userId) ->
		user = Meteor.users.findOne(userId)
		user?.profile?.isAdmin
