app.factory('getAddonsFactory', ['$uibModal','$http', function($uibModal,$http) {
	 var savedData = {}
	 
	 function set(data) {
	   savedData = data;
	 }
	 function get() {
	  return savedData;
	 }
	 
	 function showAddonModal() {
		var modalInstance = $uibModal.open({
				animation: true,
				templateUrl: 'templates/addons.html',
				controller: 'addonsCtrl'
				
			});
		}
	
	 function getAddonInfo(riskNo, successFunction) {
	  	$http.get(globaleBrokerHttp + '/getAddonsJSON/'+riskNo)
			.success(function(response) {
				
				successFunction(response)
			});
	 }
	 
	 
	 return {
	  set: set,
	  get: get,
	  showAddonModal:showAddonModal,
	  getAddonInfo: getAddonInfo
	 }

}]);