# meteor accounts config
accountsUIBootstrap3.setLanguage 'de'
Accounts.ui.config
	passwordSignupFields: 'USERNAME_AND_EMAIL'

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
		.state 'menus',
			url: '/'
			templateUrl: 'client/jade/menus.html'
			controller: 'menusCtrl'
			resolve: userResolve
		.state 'order',
			url: '/order/:id'
			templateUrl: 'client/jade/order.html'
			controller: 'orderCtrl'
			resolve: userResolve
		.state 'orderSummary',
			url: '/order/:id/summary'
			templateUrl: 'client/jade/orderSummary.html'
			controller: 'orderSummaryCtrl'
			resolve: userResolve
		.state 'login',
			url: '/login'
			templateUrl: 'client/jade/login.html'
			
	$urlRouterProvider.otherwise '/'
	$locationProvider.html5Mode true
]

angular.module('app').run ['$rootScope', '$state', ($rootScope, $state) ->
	Accounts.onLogin () -> $state.go 'menus'
	$rootScope.$on '$stateChangeError', (event, toState, toParams, fromState, fromParams, error) ->
		# We can catch the error thrown when the $requireUser promise is rejected
		# and redirect the user back to the main page
		if error == 'AUTH_REQUIRED'
			$state.go 'login'
]

