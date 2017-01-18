
app.controller('limitsOfLiabilityCtrl', ['$scope','policyForLimitsFactory','$uibModal','$uibModalInstance', function ($scope,policyForLimitsFactory,$uibModal,$uibModalInstance){
 	$scope.plcyNo = policyForLimitsFactory.get();


	policyForLimitsFactory.getLimitsInfo(	$scope.plcyNo,
											function(response) {
												$scope.limits = response;
												
											})
								
  $scope.cancelModal = function () {
	$uibModalInstance.dismiss('cancel');
  };
}]);
