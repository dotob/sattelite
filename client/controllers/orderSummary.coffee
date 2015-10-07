_ = lodash

angular.module('app').controller 'orderSummaryCtrl', ['$scope', '$rootScope', '$stateParams', ($scope, $rootScope, $stateParams) ->
	$scope.orders = $scope.$meteorCollection share.Orders
	$scope.order = $scope.$meteorObject share.Orders, $stateParams.id
	$scope.menu = $scope.$meteorObject share.Menus, $scope.order.menu

]