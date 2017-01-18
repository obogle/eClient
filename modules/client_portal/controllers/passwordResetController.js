


app.controller('passwordResetCtrl', ['$scope','$rootScope', '$uibModal','$uibModalInstance','$http','$interval', function ($scope, $rootScope,$uibModal,$uibModalInstance, $http, $interval){
  
  
  $scope.checkEmailToReset= function () {

		$http.post('local/password_resetLv1.cfc?method=resetPasswordLvI&user_name='+$scope.credentialsForForgottenPwd)
		
					.success(function (response) {
								$scope.emailResponseMessage = $(response).find('question_info').find('message').text()
								$scope.securityQuestion= $(response).find('question_info').find('quest').text();
								$scope.emailPassed =  $(response).find('question_info').find('status').text();
								
					})
  	};
  
  
  
  
  var securityAns = $scope.securityAns;
  $scope.resetPwd= function () {
	
	
	$scope.doReset(		
					securityAns,
					function(message) {
						$scope.showResetMessage = message;
					}
		)
  	};
	
	


	$scope.doReset = function(securityAns, showResetMessage){

		$http.post('local/password_reset.cfc?method=resetPasswordLvII&user_name='+$scope.credentialsForForgottenPwd+'&answer='+$scope.securityAns )
					.success(function (response) {
								
								var messageForuser = $(response).find('password_info').find('password_message').text()
								showResetMessage(messageForuser)
								
								$scope.resetSuccessful = $(response).find('password_info').find('reset_successful').text()
								
								
								if ($scope.resetSuccessful == 'true'){
									
									$interval(function()
									{
										$scope.countDown--
										if($scope.countDown == 0){
										  $scope.cancelModal();
										}
										
									},1000,0);
								}
					})
					
	};

  //countdown
   	$scope.countDown = 12;    
    
	
	
  $scope.cancelModal = function () {
    $uibModalInstance.dismiss('cancel');
  };
}]);


