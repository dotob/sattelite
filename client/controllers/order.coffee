angular.module('app').controller 'orderCtrl', ['$scope', '$meteor', '$stateParams', ($scope, $meteor, $stateParams) ->
	$scope.order = $scope.$meteorObject(share.Orders, $stateParams.id) 
	$scope.menu = $scope.$meteorObject(share.Menus, $scope.order.menu) 
	console.log $scope.order

	$scope.addOrderItem = (order, item) ->
		order.order_items.push item
		console.log "added #{item.name} to order #{order.menu.name}"
]