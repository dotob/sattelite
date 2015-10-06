_ = lodash

angular.module('app').controller 'orderCtrl', ['$scope', '$meteor', '$stateParams', ($scope, $meteor, $stateParams) ->
	$scope.order = $scope.$meteorObject(share.Orders, $stateParams.id) 
	$scope.menu = $scope.$meteorObject(share.Menus, $scope.order.menu) 

	$scope.updateSum = () ->
		$scope.order_sum = _.sum $scope.order.order_items, (i) -> i.price
		console.log "sum: #{$scope.order_sum}"

	$scope.saveSpecials = (order_item, input_id) ->
		specials = $("##{input_id}").val()
		console.log "save: #{specials}"
		order_item.specials = specials

	$scope.addOrderItem = (order, item) ->
		item.id = Random.id()
		order.order_items.push item
		$scope.updateSum()
		console.log "added #{item.name} to order #{order.menu.name}"

	$scope.updateSum()
]