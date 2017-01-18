
app.service('redirectServices',['$rootScope','$window', '$location', function( $rootScope, $window, $location){
	
	this.logout = function(){
		//Session.destroy();
		$window.sessionStorage.removeItem("clientInfo");
		delete $rootScope.clientInfo;
		$location.path('/needLogin')
		//$window.location.reload();
	}

	this.goToDashboard = function(){
		$location.path('/dashboard');
	}


	this.goToLogin = function(){
		$location.path('/');
	}
	this.goToRenewal = function(){
		$location.path('/renewal');
	}
	
	this.goToViewTransactions = function(){
		$location.path('/transactionDetails');
	}
	
	this.goToRenewalPaymentConfirmation = function(){
		$location.path('/renewalAccepted');
	}
	
	this.goToServerErrorPage = function(){
		$location.path('/updatingAccount');
	}
}]);