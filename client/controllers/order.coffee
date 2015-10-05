_ = lodash

angular.module('app').controller 'orderCtrl', ['$scope', '$meteor', '$stateParams', ($scope, $meteor, $stateParams) ->
	$scope.order = $scope.$meteorObject(share.Orders, $stateParams.id) 
	$scope.menu = $scope.$meteorObject(share.Menus, $scope.order.menu) 

	$scope.updateSum = () ->
		$scope.order_sum = _.sum $scope.order.order_items, (i) -> i.price
		console.log "sum: #{$scope.order_sum}"

	$scope.addOrderItem = (order, item) ->
		order.order_items.push item
		$scope.updateSum()
		console.log "added #{item.name} to order #{order.menu.name}"

	$scope.updateSum()
]