
  
app.controller('finalPasswordConfromationCtrl', ['$scope','$rootScope' ,'$http', '$routeParams','$interval','redirectServices', function ($scope, $rootScope,$http, $routeParams,$interval, redirectServices){

	$scope.showMessage = false;
	//function definitions
	
	$scope.changePwd = function(key, password, password2){
		$scope.showMessage = false;
		$http.post('local/change_password.cfc?method=changePassword&code='+$routeParams.key+'&new_pwd='+password+'&con_pwd='+password2)
					.success(function (response) {
								var isAccepted = $(response).find('password_info').find('status').text();
								var message = $(response).find('password_info').find('password_message').text()


								if (isAccepted){
									$scope.message = message
									$scope.classText = 'success';
									$scope.dontHideLoginStuff = false;
									
									$interval(function()
									{
										$scope.countDown--
										if($scope.countDown == 0){
										 redirectServices.goToLogin();
										}
										
									},1000,0);
								}else{
								
									$scope.message = message
									$scope.classText = 'danger';
									$scope.dontHideLoginStuff = true;
									
								}
								$scope.showMessage = true;
									
					})
					.error(function (data) {
					});
	
	};
	
	
	//countdown
   	$scope.countDown = 12;    
    
	
	$scope.triggerChangePwd = function(){
		//Function calls
		$scope.changePwd($routeParams.key, $scope.password, $scope.password2);
	};
	
}]);



