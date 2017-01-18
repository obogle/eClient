
app.controller('loginCtrl', ['$scope','$rootScope','authServices' ,'$window', '$routeParams','$http', function ($scope, $rootScope,authServices,$window, $routeParams, $http){
	/* to see change request list
	$scope.requests =[]
	$scope.logChangeRequestInfo = function(){
			$http.get(globaleBrokerHttp + '/getBranch/4')
			.success(function(response) {
					$scope.requests =[]
					$(response).find('branch_detail').each(function(){
						var branchName = $(this).find('branch_name').text();
						var branchID = $(this).find('branch_id').text();
						
						$http.get(globaleClientHttp  +'/getUserChangeRequests/' + branchID )
                        .success(function(response) {
							//$scope.requests.push({call: globaleClientHttp  +'/getUserChangeRequests/' + branchID , 'branchName' : branchName, 'reqNum' : response.length, 'deets': response});
							if (!response[0].MESSAGE) {
							  console.log(branchName + ' outstanding requests: '+response.length)
							}
						});
					});
				
			});
	}
	$scope.logChangeRequestInfo();
	*/
	//$rootScope.pageClass = 'page-easeInFallOut';
	$rootScope.pageClass = '';
	
	$scope.loginSubmit = function(){
		var username = $scope.eClientLoginUsername
		var pass = $scope.eClientLoginPassword
		
		authServices.credentialsOK(		
									username,
									pass,
									function(clientNo) {
										//clear fields
										$scope.eClientLoginUsername = ''
										$scope.eClientLoginPassword = ''
										
										$scope.login(clientNo)
									},
									function(errorMessage) {
										$scope.loginError = errorMessage
										$scope.showloginError = true; 
									}
			
		)
		
	};
	
	
	//Performs the login function, by sending a request to the server with the Auth service
	$scope.login = function(clientNo) {
		authServices.completeLogin(clientNo)
		
	};
	$scope.forgotPwd = function(username) {
		authServices.resetPassword($scope.emailForForgottenPwd)
	  };
	
	// if a session exists for current user (page was refreshed)
	// log him in again
	if ($window.sessionStorage["clientInfo"]) {
		//alert('okayy ' + $window.sessionStorage["clientInfo"])
		//if username stored in session then already validated
		$scope.login($window.sessionStorage["clientInfo"]);
	}
	
	
	$scope.init = function(){
		//get token (if any) from url
		var accessToken = $routeParams.accessToken;
		
		//if an access token passed in url
		if(accessToken)	{
			//see if token valid
			$http.get(globaleClientHttp+'/getClientToken/'+accessToken)
			.success(function(response) {
				
				//if it is valid a key which is the client no will be passed back
				var clientNoFrmService = $(response).find('token_check').find('key').text();
				
				//if the key was passed back, token is valid
				//so log user in
				if(clientNoFrmService){
					$scope.login(clientNoFrmService)
				}
			});
			
		}
	}
	$scope.init()
}]);



