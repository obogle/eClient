
app.controller('completeRegistrationCtrl', ['$scope','$rootScope' ,'$http','$routeParams','$interval','redirectServices', function ($scope, $rootScope,$http, $routeParams,$interval, redirectServices){

	var key =$routeParams.key;
	
	
	
	//function definitions
	
	$scope.activateUser = function(key){
		$http.post('local/reg_confirmation.cfc?method=clientRegistration&tmp_code='+key)
					.success(function (response) {
								var isActivated = $(response).find('registration_info').find('active').text();
								var message = $(response).find('registration_info').find('registration_message').text()

								if (isActivated){
									$scope.message = message
									$scope.classText = 'text-success';
									
									
									
								}else{
								
									$scope.message = message
									$scope.classText = 'text-danger';
									
								}
										
									
					})
					.error(function (data) {
					});
	
	};
	
	
	//countdown
   	$scope.countDown = 12;    
    $interval(function()
		{
			$scope.countDown--
			if($scope.countDown == 0){
				redirectServices.goToLogin();
			}
			
		},1000,0);
	
	
	
	
	//Function calls
	$scope.activateUser(key);
}]);



