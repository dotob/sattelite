angular.module('app').controller 'tagsCtrl', ['$scope', '$meteor', ($scope, $meteor) ->
	$scope.menus = $scope.$meteorCollection(share.Menus)

	$scope.chooseMenu = (menu) ->
		#todo
]