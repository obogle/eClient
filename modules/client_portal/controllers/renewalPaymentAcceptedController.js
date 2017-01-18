
  
app.controller('renewalPaymentAcceptedCtrl', ['$scope','$rootScope' ,'$http','$routeParams','$interval','redirectServices', function ($scope, $rootScope,$http, $routeParams,$interval, redirectServices){

	/*
	
$interval(function()
									{
										$scope.countDown--
										if($scope.countDown == 0){
										 redirectServices.goToDashboard();
										}
										
									},1000,0);
									
									
*/									
	$scope.viewTransactions = function(){
		redirectServices.goToViewTransactions();
	}
	
	//countdown
   	$scope.countDown = 12;    
    
	
	$scope.goToDash = function(){
		//Function calls
		redirectServices.goToDashboard();
	};
	$scope.logout = function(){
		redirectServices.logout()
	}
	
}]);



