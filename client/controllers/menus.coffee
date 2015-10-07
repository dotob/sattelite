_ = lodash

angular.module('app').controller 'menusCtrl', ['$scope', '$meteor', '$rootScope', '$state', ($scope, $meteor, $rootScope, $state) ->
	today = new Date()
	today.setDate(0)
	today.setHours(0)
	today.setMinutes(0)
	$scope.orders = $scope.$meteorCollection(() -> share.Orders.find({date: {$gte: today}}))
	$scope.menus = $scope.$meteorCollection share.Menus

	$scope.gotoOrder = (order) ->
		$state.go 'order', {id: order._id}

	$scope.gotoOrderSummary = (order) ->
		$state.go 'orderSummary', {id: order._id}

	$scope.createNewOrder = (menu) ->
		saved = $scope.orders.save
			menu: menu._id
			user: $rootScope.currentUser
			order_items: []
			date: new Date()
			isOpen: true

		saved.then (inserts) ->
			id = _.first(inserts)._id
			console.log "inserted new order with id:#{id}"
			$state.go 'order', {id: id}

	$scope.menu_name = (menuid) ->
		menu = share.Menus.findOne {_id: menuid}
		menu.name
]