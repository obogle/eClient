
app.controller('dashboardCtrl', ['$scope','$uibModal', '$rootScope' ,'$http','policyForLimitsFactory','getAddonsFactory','getPolicyForRenewalFactory','redirectServices','Idle', 'Keepalive',function ($scope, $uibModal, $rootScope,$http,policyForLimitsFactory,getAddonsFactory,getPolicyForRenewalFactory,redirectServices,Idle, Keepalive){
	
	$rootScope.pageClass = 'page-slideInSlideOut';
	var clientNo = $rootScope.clientInfo.clientNo;
	
	
	//onboarding
	$scope.startOnboarding = function() {
          $scope.stepIndex = 0
          $scope.showOnboarding = true;
        };
        $scope.onboardingSteps = [
          {
            overlay: true,
            title: 'Welcome!',
            description: "This is a box with the position set to 'centered'.",
            position: 'centered'
          },
          {
            attachTo: '#content_1',
            position: 'centered',
            overlay: true,
            title: 'Check this out!',
            width: 400,
            description: "This popover is attached to the '#content_1' element with a position of 'right'. It also has a width of 400."
          },
          {
            attachTo: '#content_2',
            position: 'left',
            overlay: true,
            title: 'Content 2 is here!',
            description: 'Etiam dictum dignissim suscipit. Cras vitae velit hendrerit, euismod risus fringilla, varius sapien. Duis cursus vulputate egestas. Suspendisse nec mi vitae tortor vulputate aliquet. Fusce malesuada, elit et sagittis posuere, elit erat congue leo, in pellentesque felis orci vel est. Nunc tincidunt neque erat, a tempus lacus auctor nec. Duis nec sem sed quam fringilla porttitor. In ac lacinia nunc. Nulla ornare mi eget gravida venenatis. Nam sit amet neque quis ligula condimentum ultricies nec at ipsum.'
          },
          {
            attachTo: '#content_3',
            position: 'right',
            overlay: true,
            overlayOpacity: 0.2,
            title: 'Welcome to Content 3!',
            description: 'This one has the opacity of the overlay set to 0.2',
          },
          {
            attachTo: '#content_4',
            position: 'top',
            overlay: false,
            title: 'Content 4 Info!',
            description: 'This one contains no overlay!',
            width: 500
          },
          {
            overlay: true,
            title: 'All Done!',
            description: "This box is explicitly set to a position of {top: 150, right: 300}",
            top: 150,
            right: 300
          }
        ];

	
	//Function definitions
	$scope.updateUser = function(id, data, tag) {
		 $http.post('local/account_update.cfc?method=updateAccount&client_number='+clientNo+'&field_name='+id+'&value='+encodeURIComponent(data)+'&tag='+tag +'' )
					.success(function (response) {
							$scope.showPolicyRequestChangeMessage =$(response).find('update_details').find('update_message').text()
							$scope.showPolicyRequestChangeAlertType = $(response).find('update_details').find('update_status').text()
							$scope.showPolicyRequestChange = true;	
								
									
					})
					.error(function (data) {
					});
		 
    };
	
	
	$scope.retieveAccountInfo = function (clientNo, placeAccount){
		$http.get(globaleBrokerHttp + '/getClientJSON/'+clientNo)
			.success(function(response) {
				placeAccount(response)
			})
			.error(function(response) {
				placeAccount([{"MESSAGE":"Oops! There was a problem with retreiving your account information. Please try refreshing the page."}])
				//function to save all data going to savetransactio for error handling
				$http.get('local/error_log.cfc?method=errorLog&function_name=getClientJSON&function_string='+retieveAccountInfoCall+'&client_number='+clientNo)
			});
	}
	

	
	$scope.retievePolicyInfo = function (clientNo, placePolicy){
		
		$http.get(globaleBrokerHttp + '/getPolicyJSON/'+clientNo)
			.success(function(response) {
				placePolicy(response)
			})
			.error(function(response) {
				placePolicy([{"MESSAGE":"Oops! There was a problem with retreiving your policy. Please try refreshing the page."}])
				//function to save all data going to savetransactio for error handling
				$http.get('local/error_log.cfc?method=errorLog&function_name=getPolicyJSON&function_string='+retievePolicyInfoCall+'&client_number='+clientNo)
			});
	}
	
	
	
	
	$scope.getPolicyAlerts = function (policyNo){
		$http.get('local/client_alerts.cfc?method=clientAlert&client_number='+ clientNo)
			.success(function(response) {
				$scope.policyAlerts = response;
			});
	}
	
	$scope.displayLimits = function (policyNo){
		policyForLimitsFactory.set(policyNo);
		policyForLimitsFactory.showLimitsModal();
		
	}
	
	$scope.displayAddons = function (riskNo){
		getAddonsFactory.set(riskNo);
		getAddonsFactory.showAddonModal();
		
	}
	
	
	/*
	$scope.checkRenewal = function (policyNo){
		
		$http.get(globaleClientHttp + '/checkRnwlPolicyJSON/'+ policyNo)
			.success(function(response) {
				$scope.upForRenewal = response;
			});
	}
	
	*/
	
	$scope.renewPolicy = function (policyNo, renewal_month, territory, plan, branch ){
		
		getPolicyForRenewalFactory.set(policyNo);
		getPolicyForRenewalFactory.setRenewalMonth(renewal_month);
		getPolicyForRenewalFactory.setRenewalTerritory(territory);
		getPolicyForRenewalFactory.setRenewalPlan(plan);
		getPolicyForRenewalFactory.setRenewalBranch(branch);
		
		redirectServices.goToRenewal();
		
	}
	
	$scope.viewTransactions = function(){
		redirectServices.goToViewTransactions();
	}
	
	//Function calls
	$scope.getPolicyAlerts('35507709')
	
	
	$scope.closePolicyAlert = function (index) {
		 $scope.policyAlerts.splice(index, 1);
	};


	$scope.retieveAccountInfo(	clientNo,
								function(response) {
									$scope.accountDetails = response;
									
								})
	
    //'1793039'
	//'927011'
	//1363913
	//1828959
	
	//Policy with locks - 1505998
	//extension no locks- 2484740 
	$scope.retievePolicyInfo(	clientNo,
								function(response) {
									$scope.policyDetails = response;
									
								})
								
								
								
								
								
								
								
								
								
								
								
	 $scope.started = false;

      function closeModals() {
        if ($scope.warning) {
          $scope.warning.close();
          $scope.warning = null;
        }

        if ($scope.timedout) {
          $scope.timedout.close();
          $scope.timedout = null;
		  
        }
      }

      $scope.$on('IdleStart', function() {
        closeModals();
	/*
        $scope.warning = $uibModal.open({
          templateUrl: 'warning-dialog.html',
          windowClass: 'modal-danger',
		  controller:function($uibModalInstance ,$scope){
			  
		  $scope.closeModals = function () {
				$uibModalInstance.dismiss('cancel');
			 };
	
		}
        });
*/
      });

      $scope.$on('IdleEnd', function() {
        closeModals();
      });

      $scope.$on('IdleTimeout', function() {
        closeModals();
		/*
        $scope.timedout = $uibModal.open({
          templateUrl: 'timedout-dialog.html',
          windowClass: 'modal-danger'
        });
		*/
		//redirectServices.logout();
		
      });



}]);



