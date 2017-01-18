
app.factory('paymentOptionFactory', ['$uibModal','$http', function($uibModal,$http) {
	 var savedData = {}
	 
	 function setOption(data) {
	   savedData = data;
	 }
	 function getOption() {
	  return savedData;
	 }
	 
	 return {
	  setOption: setOption,
	  getOption: getOption
	 }

}]);