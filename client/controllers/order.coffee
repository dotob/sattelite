_ = lodash

angular.module('app').controller 'orderCtrl', ['$scope', '$rootScope', '$stateParams', '$state', ($scope, $rootScope, $stateParams, $state) ->
	$scope.orders = $scope.$meteorCollection share.Orders
	$scope.order = $scope.$meteorObject share.Orders, $stateParams.id
	$scope.menu = $scope.$meteorObject share.Menus, $scope.order.menu
	$scope.favorites = []

	$scope.gotoOrderSummary = (order) ->
		$state.go 'orderSummary', {id: order._id}

	$scope.calcFavorites = () ->
		usersOrders = _.chain($scope.orders).map((o) -> o.order_items).flatten().reject((oi) -> oi.user._id != $rootScope.currentUser._id).value()
		usersOrdersGrouped = _.chain(usersOrders).groupBy((oi) -> oi.order_number).sortBy((v,k)-> -v.length).map((g) -> g[0].order_number).value()
		$scope.favorites = []
		for k in usersOrdersGrouped
			f = _.find $scope.menu.items, (mi) -> mi.order_number == k
			$scope.favorites.push f

	$scope.updateSum = () ->
		ois = _.filter $scope.order.order_items, (oi) -> oi.user._id == $rootScope.currentUser._id
		$scope.order_sum = _.sum ois, (i) -> i.price

	$scope.saveSpecials = (order_item, input_id) ->
		specials = $("##{input_id}").val() # this is bad...accessing dom elements via jquery...
		console.log "save: #{specials} to item #{input_id}"
		order_item.specials = specials

	$scope.removeOrderItem = (order, item) ->
		idx = _.findIndex order.order_items, (i) -> i.id == item.id
		order.order_items.splice idx, 1
		console.log "removed #{item.name} (#{idx}) from order #{$scope.menu.name}"

	$scope.addOrderItem = (order, item) ->
		item.id = Random.id() # add id for later specials hack
		item.user = $rootScope.currentUser

		order.order_items.push item
		$scope.updateSum()
		console.log "added #{item.name} to order #{$scope.menu.name}"

	$scope.updateSum()
	$scope.calcFavorites()
]