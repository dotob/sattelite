# meteor accounts config
accountsUIBootstrap3.setLanguage 'de'

# overwrite underscore with lodash
_ = lodash

# angular
app = angular.module 'app', [
	'angular-meteor', 
#	'ui.bootstrap',
	'ui.router'
]

# routes
userResolve = 
	"currentUser": [
		"$meteor", ($meteor) ->
			$meteor.requireUser()
	]

adminResolve = 
	"currentUser": [
		"$meteor", ($meteor) ->
			hasAdmin = Meteor.users.findOne {'profile.isAdmin': true}
			if !hasAdmin
				return true
			else
				return $meteor.requireValidUser (user) ->
					user?.profile?.isAdmin
	]

angular.module('app').config ['$stateProvider', '$urlRouterProvider', '$locationProvider', ($stateProvider, $urlRouterProvider, $locationProvider) ->
	$stateProvider
		.state 'menu',
			url: '/'
			templateUrl: 'client/jade/menu.html'
			controller: 'chooseMenuCtrl'
			resolve: userResolve
		.state 'dish',
			url: '/dish/:id'
			templateUrl: 'client/jade/dish.html'
			controller: 'printCtrl'
			resolve: userResolve
		.state 'order',
			url: '/order/:id'
			templateUrl: 'client/jade/order.html'
			controller: 'adminCtrl'
			resolve: adminResolve
		.state 'login',
			url: '/login'
			templateUrl: 'client/jade/login.html'
			
	$urlRouterProvider.otherwise '/'
	$locationProvider.html5Mode true
]

angular.module('app').run ['$rootScope', '$state', ($rootScope, $state) ->
	Accounts.onLogin () -> $state.go 'menu'
	$rootScope.$on '$stateChangeError', (event, toState, toParams, fromState, fromParams, error) ->
		# We can catch the error thrown when the $requireUser promise is rejected
		# and redirect the user back to the main page
		if error == 'AUTH_REQUIRED'
			$state.go 'login'
]

