_ = lodash

angular.module('app').controller 'orderSummaryCtrl', ['$scope', '$rootScope', '$stateParams', '$state', ($scope, $rootScope, $stateParams, $state) ->
	$scope.orders = $scope.$meteorCollection share.Orders
	$scope.order = $scope.$meteorObject share.Orders, $stateParams.id
	$scope.menu = $scope.$meteorObject share.Menus, $scope.order.menu

	$scope.gotoOrder = (order) ->
		$state.go 'order', {id: order._id}

	$scope.openOrder = () ->
		$scope.order.isOpen = true

	$scope.closeOrder = () ->
		$scope.order.isOpen = false

	$scope.updateSum = () ->
		$scope.order_sum = _.sum $scope.order.order_items, (i) -> i.price
		console.log "sum: #{$scope.order_sum}"

	$scope.updateSum()
]