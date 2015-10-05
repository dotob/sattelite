_ = lodash

angular.module('app').controller 'menusCtrl', ['$scope', '$meteor', '$rootScope', '$state', ($scope, $meteor, $rootScope, $state) ->
	$scope.menus = $scope.$meteorCollection share.Menus
	$scope.orders = $scope.$meteorCollection share.Orders

	$scope.gotoOrder = (order) ->
		$state.go 'order', {id: order._id}

	$scope.createNewOrder = (menu) ->
		saved = $scope.orders.save
			menu: menu._id
			user: $rootScope.currentUser
			order_items: []

		good = (inserts) ->
			id = _.first(inserts)._id
			console.log "inserted new order with id:#{id}"
			$state.go 'order', {id: id}
		bad = (reason) ->
			console.log reason

		saved.then good, bad

]