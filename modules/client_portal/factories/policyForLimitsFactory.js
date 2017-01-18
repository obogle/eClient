app.factory('policyForLimitsFactory', ['$uibModal','$http', function($uibModal,$http) {
	 var savedData = {}
	 
	 function set(data) {
	   savedData = data;
	 }
	 function get() {
	  return savedData;
	 }
	 
	 function showLimitsModal() {
		var modalInstance = $uibModal.open({
				animation: true,
				templateUrl: 'templates/limitsOfLiability.html',
				controller: 'limitsOfLiabilityCtrl'
				
			});
		}
	
	 function getLimitsInfo(policyNo, successFunction) {
	  	$http.get(globaleBrokerHttp + '/getLimitsJSON/'+policyNo)
			.success(function(response) {
				
				successFunction(response)
			});
	 }
	 
	 
	 return {
	  set: set,
	  get: get,
	  showLimitsModal:showLimitsModal,
	  getLimitsInfo: getLimitsInfo
	 }

}]);