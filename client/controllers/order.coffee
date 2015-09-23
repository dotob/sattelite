angular.module('app').controller 'orderCtrl', ['$scope', '$meteor', '$stateParams', ($scope, $meteor, $stateParams) ->
	$scope.order = $scope.$meteorObject(share.Orders, $stateParams.id) 
	console.log $scope.order
]