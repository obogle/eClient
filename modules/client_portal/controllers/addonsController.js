
app.controller('addonsCtrl', ['$scope','getAddonsFactory','$uibModal','$uibModalInstance', function ($scope,getAddonsFactory,$uibModal,$uibModalInstance){
 	$scope.riskNo = getAddonsFactory.get();


	getAddonsFactory.getAddonInfo(	$scope.riskNo,
											function(response) {
												$scope.addons = response;
												
											})
								
  $scope.cancelModal = function () {
	$uibModalInstance.dismiss('cancel');
  };
}]);
