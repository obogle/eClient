
app.controller('menuCtrl', ['$scope','$rootScope','redirectServices', function ($scope, $rootScope,redirectServices){
	$scope.logout = function(){
		redirectServices.logout()
	}
	
	$scope.viewTransactions = function(){
		redirectServices.goToViewTransactions();
	}
	
	$scope.goToDash = function(){
		redirectServices.goToDashboard();	
	}
	
}]);



