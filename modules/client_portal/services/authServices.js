
app.service('authServices',['$rootScope','$window', '$location', '$uibModal', '$http','redirectServices', function( $rootScope, $window, $location, $uibModal,$http,redirectServices){
	
	<!--logging in stuff =) --->

	this.credentialsOK = function(clntUsername, clntPassword, userVerified, userNotVerified){

		$http.post('local/process_login.cfc?method=verifyCredentials&user_name='+clntUsername+'&user_password='+clntPassword+'' )
					.success(function (response) {
								var verified = $(response).find('login_check').find('userVerified').text();
								var data = $(response).find('login_check').find('data').text()
								
								
								if (verified){
									userVerified(data)
								}else{
									userNotVerified(data)
								}
										
									
					})
					.error(function (data) {
						userNotVerified('Call ICWI for further assistance')
					});
	};
	
	
	
	this.completeLogin = function(clntNo){
			
			
			$http.get(globaleBrokerHttp + '/getClient/'+clntNo)
			.success(function(response) {
				
				//set the browser session, to avoid relogin on refresh
				$window.sessionStorage["clientInfo"] = clntNo;
				
				var rootScopeClientInfo = {'clientNo' : clntNo, 'clientIsLoggedIn': true, 'clientName' :$(response).find('account_details').find('clnt_name').text()  }
				//update current user into the Session service or $rootScope
				$rootScope["clientInfo"] = rootScopeClientInfo;
					
				
				//fire event of successful login
				////////////////////$rootScope.$broadcast(AUTH_EVENTS.loginSuccess);
				redirectServices.goToDashboard()
			});
			
		
	};
	
	
	
		

	this.resetPassword = function(email){

		var modalInstance = $uibModal.open({
			animation: true,
			templateUrl: 'templates/resetPassword.html',
			controller: 'passwordResetCtrl'
			
		});
	
		
	 };
	
	<!---logging out stuff--->
	//log out the user and broadcast the logoutSuccess event
	this.destroyAuth = function(){
		redirectServices.logout()
		
	}

	
}]);