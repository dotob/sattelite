_ = lodash

angular.module('app').controller 'orderCtrl', ['$scope', '$rootScope', '$stateParams', ($scope, $rootScope, $stateParams) ->
	$scope.orders = $scope.$meteorCollection share.Orders
	$scope.order = $scope.$meteorObject share.Orders, $stateParams.id
	$scope.menu = $scope.$meteorObject share.Menus, $scope.order.menu

	$scope.calcFavorites = () ->
		usersOrders = _.chain($scope.orders).map((o) -> o.order_items).flatten().reject((oi) -> oi.user._id != $rootScope.currentUser._id).value()
		usersOrdersGrouped = _.chain(usersOrders).groupBy((oi) -> oi.order_number).sortBy((v,k)-> -v.length).map((g) -> g[0].order_number).value()
		console.log usersOrdersGrouped
		favs = []
		for k in usersOrdersGrouped
			f = _.find $scope.menu.items, (mi) -> mi.order_number == k
			favs.push f
		$scope.favorites = favs

	$scope.updateSum = () ->
		$scope.order_sum = _.sum $scope.order.order_items, (i) -> i.price
		console.log "sum: #{$scope.order_sum}"

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