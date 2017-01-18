
app.controller('renewalCtrl', ['$scope','$rootScope' ,'$http','getPolicyForRenewalFactory', '$window','redirectServices', 'paymentOptionFactory', '$log', 'Upload', function ($scope, $rootScope,$http, getPolicyForRenewalFactory,$window, redirectServices, paymentOptionFactory, $log, Upload){
	$rootScope.pageClass = '';
	
    var policyToRenew = getPolicyForRenewalFactory.get();
	var monthToRenew = getPolicyForRenewalFactory.getRenewalMonth()
	var territoryForRenew = getPolicyForRenewalFactory.getRenewalTerritory()
	var planForRenew = getPolicyForRenewalFactory.getRenewalPlan()
	var branchFromFactory = getPolicyForRenewalFactory.getRenewalBranch()
	var clientNo = $rootScope.clientInfo.clientNo;
	
	//definitions
	$scope.user = {};
	$scope.towns = [];
	$scope.branches = [];
	$scope.billingParishes = [];
	$scope.shippingParishes = [];
	$scope.paymentInfo = [];
	
	$scope.formStepHeadings = [{heading: 'Step 1: Instructions'},{heading: 'Step 2: Payment Details'},{heading: 'Step 3: Make Payment'}]
	$scope.saveTransFailed = false;
	$scope.clientNo = clientNo
	$scope.submitActive= 'true';
	$scope.locksUpOrNo = 'notReady'
	$scope.renewalPolicySummary = ''
	$scope.changeSelectedPlan = function(selectedplan){
		getPolicyForRenewalFactory.setRenewalPlan(selectedplan);
		$scope.retrievePaymentSummary();
		$scope.checkRenewal();
	}

	$scope.retrievePaymentSummary = function (){
		
		planForRenew = getPolicyForRenewalFactory.getRenewalPlan()
		
		$http.get(globaleBrokerHttp + '/getPremium/'+policyToRenew+'/'+planForRenew+'/'+monthToRenew+'/'+territoryForRenew) //TEST
			.success(function(response) {
				$scope.paymentInfo.premWithoutGCT = $(response).find('prem_detail').find('premWithoutGCT').text();
				$scope.miscText = $(response).find('prem_detail').find('misc').text();
				$scope.paymentInfo.miscFee = $(response).find('prem_detail').find('prem_fee').text();
				$scope.paymentInfo.serviceFee = $(response).find('prem_detail').find('srvc_fee').text();
				$scope.paymentInfo.GCT = $(response).find('prem_detail').find('prem_gct').text();
				$scope.tax_label = $(response).find('prem_detail').find('tax_label').text();
				$scope.paymentInfo.clientStampAmt = $(response).find('prem_detail').find('stamp_duty').text();
				$scope.clientStampLabel = $(response).find('prem_detail').find('stamp_label').text();
				$scope.paymentInfo.currency = $(response).find('prem_detail').find('currency').text();
				$scope.paymentInfo.amtDue = $(response).find('prem_detail').find('prem_due').text();
				$scope.merchant = $(response).find('prem_detail').find('merchant').text();
				
				$scope.paymentPlanOptions =[]
				
				$(response).find('prem_detail_pp').each(function(){
					var plan = $(this).find('plan_code').text();
					var details =  $(this).find('plan_details').text();
					var checked = $(this).find('checked').text();
					var name = $(this).find('plan_name').text();
					var amount = $(this).find('amount').text();
					var frequency = $(this).find('plan_descr').text();
					
					$scope.paymentPlanOptions.push({'selectedplan' : plan, 'details' : details, 'checked' : checked,'name' : name,'amount' : amount,'frequency' : frequency});
					
				});
			});
	}
	
	/*
	$scope.setUpPaymentOptions = function(){
		//calling functions needed to set options for payment page
		retrieveDeliveryOptions(); 
			
	}
	*/
	
	$scope.getBranch = function(){
			$http.get(globaleBrokerHttp + '/getBranch/' + territoryForRenew)
			.success(function(response) {
					$scope.branches =[]
					$(response).find('branch_detail').each(function(){
						var branchName = $(this).find('branch_name').text();
						var branchID = $(this).find('branch_id').text();
						
						$scope.branches.push({'branchID' : branchID, 'branchName' : branchName});

					});
				
			});
	}
	
	$scope.getBranchContact = function(selected_branch){
		$http.get(globaleBrokerHttp + '/getBranch/' + territoryForRenew)
			.success(function(response) {
				
					$(response).find('branch_detail').each(function(){
						
						var branchID = $(this).find('branch_id').text();
						var branch_address = $(this).find('branch_address').text();
						var branch_name = $(this).find('branch_name').text();
						var branch_phone = $(this).find('branch_phone').text();
						var branch_email = $(this).find('branch_email').text();
						
						if ($scope.paymentInfo.shippingBranch == branchID){
							$scope.branch_contact = 'Find us at '+branch_address+' or call: '+branch_phone+'; '+branch_email+'';
						}

					});
				
			});
		
	}
	
	$scope.getShippingParish = function(){
			//limited says if town list should be filtered
			//for example for delivery where we dont seliver to all towns
			
			$http.get(globaleBrokerHttp + '/getParishTown/' + territoryForRenew+'/'+ 'true')
			.success(function(response) {
					$scope.paymentInfo.country =  $(response).find('country_name').text();
					
					$scope.shippingParishes = []
					$(response).find('parish_detail').each(function(){
						
						
						var parishName = $(this).find('parish_name').text();
						var parishID = $(this).find('parish_id').text();
						
						$scope.shippingParishes.push({'parishName' : parishName, 'parishID' : parishID});

					});
				
			});
	}
	$scope.geBillingParish = function(){
			//limited says if town list should be filtered
			//for example for delivery where we dont seliver to all towns
			$http.get(globaleBrokerHttp + '/getParishTown/' + territoryForRenew+'/'+'false')
			.success(function(response) {
					$scope.paymentInfo.country =  $(response).find('country_name').text();
					
					$scope.billingParishes = []
					$(response).find('parish_detail').each(function(){
						
						
						var parishName = $(this).find('parish_name').text();
						var parishID = $(this).find('parish_id').text();
						
						$scope.billingParishes.push({'parishName' : parishName, 'parishID' : parishID});

					});
				
			});
	}
	$scope.getTown = function(parish_id, limited){
			//save selected parish name
			$scope.getParishName($scope.paymentInfo.shippingParish)
			
			//limited says if town list should be filtered
			//for example for delivery where we dont seliver to all towns
			$scope.towns=[];
			
			$http.get(globaleBrokerHttp + '/getTown/'+territoryForRenew+'/' + parish_id+'/'+ limited)
			.success(function(response) {
					$(response).find('town_detail').each(function(){
						var townName = $(this).find('town_name').text();
						var townID = $(this).find('town_id').text();
						
						$scope.towns.push({'townName' : townName, 'townID' : townName});

					});
				
			});
	}
	
	$scope.changePaymentOption = function(paymentID, paymentCode){
		$scope.selectedPayment = paymentID;
		$scope.selectedPaymentCode = paymentCode;
		getPolicyForRenewalFactory.setRenewalPaymentID(paymentID)
		getPolicyForRenewalFactory.setRenewalPaymentCode(paymentCode)
		$scope.retrieveDeliveryOptions(); 
	}
	
	
	$scope.retrievePaymentOptionsDisclaimers = function(){

		$http.post('local/disclaimer.cfc?method=getDisclaimer&territory_id='+territoryForRenew)
					.success(function (response) {
							$scope.paymentOptionsDisclaimers = response
					});
	};
	$scope.retrievePaymentOptions = function(){

		$http.post('local/payment_options.cfc?method=fetchPaymentOptions&territory_id='+territoryForRenew)
					.success(function (response) {
							//default selected payment method from Database
							$scope.selectedPayment = response[0]['DEFAULT']
							//default selected payment method code from Database
							$scope.selectedPaymentCode = response[0]['CODE']
							//Also save it in factory for other page incse they dont click stuff
							$scope.changePaymentOption($scope.selectedPayment, $scope.selectedPaymentCode)
							//save response to scope do view can display
							$scope.paymentOptions = response;
					});
	};
	$scope.changeDeliveryOption = function(deliverOptionCode, deliverOptionID){
		// for now when code is Delivery "DL" we are going to manually set branch to user branch
		// in the future this haas to change and should probably be based on isers parish
		// if im a head office customer but i choose delivery in ochi, it should be serviced out of ochi
		if(deliverOptionCode == 'DL') {$scope.paymentInfo.shippingBranch = undefined};
		
		$scope.selectedDeliveryOption = deliverOptionCode;
		getPolicyForRenewalFactory.setSelectedDeliveryOption(deliverOptionCode)
		getPolicyForRenewalFactory.setSelectedDeliveryOptionID(deliverOptionID)
	}
	
	$scope.retrieveDeliveryOptions = function(){
		$scope.payment_id = getPolicyForRenewalFactory.getRenewalPaymentID();
		$scope.payment_code = getPolicyForRenewalFactory.getRenewalPaymentCode();
		$http.post('local/delivery_options.cfc?method=fetchDeliveryOptions&pymt_id='+ $scope.payment_id)
					.success(function (response) {
							//default selected payment method from Database
							$scope.changeDeliveryOption(response[0]['DEFAULT'], response[0]['ID']);
							//save response to scope do view can display
							$scope.deliveryOptions = response;
					});
	};
	
	
	
	
	$scope.getPaymentData = function(paymentID, paymentCode){
		$scope.selectedPayment = paymentID;
		$scope.selectedPaymentCode = paymentCode;
	}
	
	
	
	

	
	
	
	
	
	$scope.checkRenewal = function (){
		//send policy no annd system
		
		$http.get(globaleBrokerHttp + '/checkRnwlPolicyJSON/'+ policyToRenew + '/' + planForRenew)
			.success(function(response) {
				
				$scope.renewalPolicySummary = response;
			});
	}
	$scope.clientPayingOnlineSetAnswer= function (answer){
			paymentOptionFactory.setOption(answer)
	}
	
	
	$scope.clientPayingOnlineAnswer= function (){
			$scope.clientPayingOnline = paymentOptionFactory.getOption()
	}

	
	$scope.checkLocks = function (){
		//send policy no annd system
		$http.get(globaleBrokerHttp + '/checkLocksJSON/'+ policyToRenew+'/eclient')
			.success(function(response) {
				$scope.client_locks = response[0]["clnt_locks"];
				$scope.locksUpOrNo = response[0]["LOCKS_EXIST"];
				$scope.locksMessage = response[0]["MESSAGE"];
				$scope.locksExist = $scope.client_locks != 0;

			});
	}
	
	
	$scope.goToDash = function(){
		redirectServices.goToDashboard();	
	}
	
	$scope.addStep = function(){
	   $scope.step = $scope.step + 1;
	   $scope.calculateProgress();
    }
		
	$scope.minusStep = function(){
	   $scope.step = $scope.step - 1;
	   $scope.calculateProgress();
	}
	
	$scope.calculateProgress = function(){
	   $scope.stepSize = (($scope.step - 1) /  $scope.formStepHeadings.length)*100;
	   if($scope.stepSize < 5){$scope.stepSize = 5}
	}
	



	$scope.dispayLockOption = function(step){
	   $scope.lockSwitch = step;
    }
	
	//$scope.master = {};
    $scope.submitPoca = function(isValid, lockId) {
     // $scope.master = angular.copy(user);
	  if(isValid){
		  var user = $scope.user;
		  
		  //proof of id - personal poca
		 if(user.idpicFile){
		  $scope.uploadPic(user.idpicFile,'POI')
		 }
		 
		 //proof of address - personal poca
		 if(user.addresspicFile){
		  $scope.uploadPic(user.addresspicFile,'POA')
		 }
		 
		 //proof of id  dir 1- com poca
		 if(user.dirOneFile){
		  $scope.uploadPic(user.dirOneFile,'POI1')
		 }
		 
		 //proof of ID director 2 -com poca
		 if(user.dirTwoFile){
		  $scope.uploadPic(user.addresspicFile,'POI2')
		 }
		 
		  //proof of cert of incorporation -com poca
		 if(user.certOfIncorporationFile){
		  $scope.uploadPic(user.certOfIncorporationFile,'COI')
		 }
		 
		 /*
		 //other POCA info
		 var origURL =  '/createPOCA/'+clientNo +'/'+user.PolicyNumber+'/'+ user.typeOfPOCA+'/'+ user.personTitle +'/'+ user.FirstName+'/'+ user.MiddleName+'/'+ user.comLeagalName+'/'+ user.otherNameDifferent +'/'+ user.otherName +'/'+user.MotherLastName +'/'+user.companyPartnershipAssociation   +'/'+  user.regAddr   +'/'+ user.mailingAddrDifferent   +'/'+  user.mailingAddr   +'/'+  user.otherAddresses  +'/'+  user.phoneNums  +'/'+user.CellNumber+'/'+ user.HomeNumber+'/'+user.WorkNumber+'/'+  user.occupation_industry  +'/'+  user.emailAddress  +'/'+  user.year +'/'+ user.dobmonth +'/'+  user.dobday +'/'+user.CountryofBirth+'/'+user.Nationality+'/'+ user.idType  +','+user.otherIDType+'/'+user.idNumber+'/'+ user.expyear +'-'+ user.expmonth +'-'+user.expDay+'/'+ user.TRNNumber+'/'+  user.contactName  +'/'+  user.contactPosition  +'/'+  user.contactEmail  +'/'+ user.comContactPersonPhoneNum  +'/'+ user.Employername +'/'+  user.Employeraddr1 +'/'+  user.EmployernumbersArray +'/'+ user.descSrc+'/'+ user.ceoFirstName  +'/'+  user.ceoMiddleName  +'/'+  user.ceoLastName  +'/'+  user.ceoHomeAddr  +'/'+  user.cfoFirstName  +'/'+  user.cfoMiddleName  +'/'+  user.cfoLastName  +'/'+  user.cfoHomeAddr +'/'+  user.cooFirstName  +'/'+  user.cooMiddleName  +'/'+  user.cooLastName  +'/'+  user.cooHomeAddr +'/'+  user.comOtherDirecttorsCategory  +'/'+  user.comOtherDirecttorsName  +'/'+  user.comOtherDirecttorsAddress  +'/'+  user.isPEP +'/'+   user.pocaLastName +'/'+  user.pocaFirstName +'/'+  user.pocaMiddleName +'/'+ user.descprominentOfficer  +'/'+  user.officeprominentOfficer  +'/'+  user.pocaPosition +'/'+   user.pocaSpouseName +'/'+  user.pocaSpouseAddress +'/ '+  (user.pocaChildName  || undefined) +'/ '+  (user.pocaChildAddress || undefined);
		 
		 var ammendedURL = origURL.replace(/\/\s*\//gi , "/undefined/").replace(/\/\s*\//gi , "/undefined/").replace(/\/\s*\//gi , "/undefined/");
		 $http.get(globaleBrokerHttp + ammendedURL)
		
		*/ 
		
		$.ajax({
				//using OPTIONS method instead of any shorthands because if using web service URL and person enters / or some other special characters, it breaks the webservice url
				//using encodeURIComponent because sending % 
				method: 'POST',
				 url: globaleBrokerHttp + '/createPOCA', //TEST
				 
				 data: ({ 
					 //using OPTIONS method instead of any shorthands because if using web service URL and person enters / or some other special characters, it breaks the webservice url
					//using encodeURIComponent because sending % 
				 	client_number:  encodeURIComponent(clientNo || ''),
				 	policy_number:  encodeURIComponent(user.PolicyNumber  || ''),
					poca_type:  encodeURIComponent(user.typeOfPOCA || ''),
					title:  encodeURIComponent(user.personTitle || ''),
					first_name:  encodeURIComponent(user.FirstName || ''),
					middle_name:  encodeURIComponent(user.MiddleName || ''),
					company_last_name:  encodeURIComponent(user.comLeagalName || ''),
					other_name_yn:  encodeURIComponent(user.otherNameDifferent || ''),
					other_name:  encodeURIComponent(user.otherName || ''),
					mother_maiden_name:  encodeURIComponent(user.MotherLastName || ''),
					company_type:  encodeURIComponent(user.companyPartnershipAssociation || ''),
					permanent_address:  encodeURIComponent(user.addr1  || ''),
					mailing_addr_diff:  encodeURIComponent(user.mailingAddrDifferent || ''),
					mailing_address:  encodeURIComponent(user.mailingAddr || ''),
					other_address:  encodeURIComponent(user.otherAddresses || ''),
					phone_numbers:  encodeURIComponent(user.phoneNums || ''),
					mobile_number:  encodeURIComponent(user.CellNumber || ''),
					home_number:  encodeURIComponent(user.HomeNumber || ''),
					work_number:  encodeURIComponent(user.WorkNumber || ''),
					occupation_industry:  encodeURIComponent(user.occupation_industry || ''),
					email_address:  encodeURIComponent(user.emailAddress || ''),
					birth_incorp_year:  encodeURIComponent(user.year || ''),
					birth_incorp_month:  encodeURIComponent(user.dobmonth || ''),
					birth_incorp_day:  encodeURIComponent(user.dobday || ''),
					place_of_birth:  encodeURIComponent(user.CountryofBirth || ''),
					nationality:  encodeURIComponent(user.Nationality || ''),
					id_type:  encodeURIComponent(user.idType || '' +' '+ user.otherIDType),
					id_number:  encodeURIComponent(user.idNumber || ''),
					expiration_date:  encodeURIComponent((user.expyear || '') +'-'+ ( user.expmonth || '' ) +'-'+ (user.expDay || '')),
					trn_number:  encodeURIComponent(user.TRNNumber || ''),
					contact_name:  encodeURIComponent(user.contactName || ''),
					contact_position:  encodeURIComponent(user.contactPosition || ''),
					contact_email:  encodeURIComponent(user.contactEmail || ''),
					contact_numbers:  encodeURIComponent(user.comContactPersonPhoneNum || ''),
					employer_name:  encodeURIComponent(user.Employername || ''),
					employer_address:  encodeURIComponent(user.Employeraddr1 || ''),
					employer_numbers:  encodeURIComponent(user.EmployernumbersArray || ''),
					alternate_income:  encodeURIComponent(user.descSrc || ''),
					ceo_fname:  encodeURIComponent(user.ceoFirstName || ''),
					ceo_mname:  encodeURIComponent(user.ceoMiddleName || ''),
					ceo_lname:  encodeURIComponent(user.ceoLastName || ''),
					ceo_address:  encodeURIComponent(user.ceoHomeAddr || ''),
					cfo_fname:  encodeURIComponent(user.cfoFirstName || ''),
					cfo_mname:  encodeURIComponent(user.cfoMiddleName || ''),
					cfo_lname:  encodeURIComponent(user.cfoLastName || ''),
					cfo_address:  encodeURIComponent(user.cfoHomeAddr || ''),
					coo_fname:  encodeURIComponent(user.cooFirstName || ''),
					coo_mname:  encodeURIComponent(user.cooMiddleName || ''),
					coo_lname:  encodeURIComponent(user.cooLastName || ''),
					coo_address:  encodeURIComponent(user.cooHomeAddr || ''),
					shareholders_category:  encodeURIComponent(user.comOtherDirecttorsCategory || ''),
					shareholders_name:  encodeURIComponent(user.comOtherDirecttorsName || ''),
					shareholders_address:  encodeURIComponent(user.comOtherDirecttorsAddress || ''),
					is_pep:  encodeURIComponent(user.isPEP || ''),
					pep_lname:  encodeURIComponent(user.pocaLastName || ''),
					pep_fname:  encodeURIComponent(user.pocaFirstName || ''),
					pep_mname:  encodeURIComponent(user.pocaMiddleName  || ''),
					pep_relationship:  encodeURIComponent(user.descprominentOfficer  || ''),
					pep_office:  encodeURIComponent(user.officeprominentOfficer  || ''),
					pep_position:  encodeURIComponent(user.pocaPosition  || ''),
					pep_spouse_name:encodeURIComponent(user.pocaSpouseName || ''),
					pep_spouse_address:  encodeURIComponent(user.pocaSpouseAddress || ''),
					pep_child_name:  encodeURIComponent(user.pocaChildName || ''),
					pep_child_address:  encodeURIComponent(user.pocaChildAddress || '')
				 })
				 ,
				headers: {
					"Content-Type": 'text/plain'
				}

			})
			
			.then(function(response) {
				//just clear stored lock option so form stops showing
				//$scope.dispayLockOption('NA')
				//update status no matter what since poca no longer stops renewal
				$scope.statusChange(lockId, 'True')
				
				
				/*
				//POCA NO LONGER STOPS RENEWAL
				//no changes lets us know if they made an illegal gange or not
				var canPassLock = $(response).find('poca_detail').find('nochanges').text();
				var lockCode = $(response).find('poca_detail').find('outstanding_code').text();
				
				if(canPassLock == 'True'){
					//if they answered all stuff correctly then temp unlock
					$scope.statusChange(lockId, 'True')
				}else{
					
					//else create lock that blocks client from coninuing
					// we dont want them to try and fill out the questionnare again
					//and lie to get through
					//if they had made illecal changes still temp unlock quest lock so they cant fill out from again
					//call stopLock to get the new lock that wont allow them to proceed
					//stopLock takes policy number, renewal month year and lock code (outsnading code) not to be confused with lock id which will let us know which permanent lock to bring up
					$scope.statusChange(lockId, 'True')
					
					$http.get(globaleBrokerHttp + '/stopLock/'+policyToRenew+'/'+monthToRenew+'/'+lockCode+'/eclient')
					.success(function(response) {
						
					});
				}
				*/
			}); 
		  
	  }
    };
	

	
	$scope.getBranchName = function(branchID) {
     	$http.get(globaleBrokerHttp + '/getBranchById/' + branchID)
			.success(function(response) {
				var branchName = $(this).find('branch_detail').find('branch_name').text();
				return branchName
			}); 
    };
	
	$scope.getParishName = function(enteredParishID){
		
			//limited says if town list should be filtered
			//for example for delivery where we dont seliver to all towns
			
			$http.get(globaleBrokerHttp + '/getParishTown/' + territoryForRenew+'/'+ 'true')
			.success(function(response) {
					$(response).find('parish_detail').each(function(){
						var parishName = $(this).find('parish_name').text();
						var parishID = $(this).find('parish_id').text();
						//alert('oo these dont patch enterd parish ID: '+enteredParishID+ ' current parish id: '+parishID+ ' parish name: '+parishName)
						if(parishID == enteredParishID){
							//alert('YAY these  patch enterd parish ID: '+enteredParishID+ ' current parish id: '+parishID+ ' parish name: '+parishName)
							$scope.parishNameToSave = parishName
							return parishName
						}
					});
			});
	}
	String.prototype.replaceAll = function(target, replacement) {
	  return this.split(target).join(replacement);
	};
	$scope.submitPayment = function(paymentInfo, isValid) {
     	// $scope.master = angular.copy(user);
		if(isValid){
			  $scope.processText =  "Processing Request" 
			  $scope.saveTransFailed = false
			  
			  $scope.showFinalPaymentMessage = '';
			  $scope.submitActive= 'false'
			  
			  var payment_id = getPolicyForRenewalFactory.getRenewalPaymentID();
			  var selectedDeliveryOptionCode = getPolicyForRenewalFactory.getSelectedDeliveryOptionD();
			  var selectedDeliveryOptionID = getPolicyForRenewalFactory.getSelectedDeliveryOptionID();
			  var app_date = $scope.paymentInfo.dt.getFullYear().toString()+'-'+ ($scope.paymentInfo.dt.getMonth() + 1).toString()+'-'+$scope.paymentInfo.dt.getDate().toString()+' '+ $scope.paymentInfo.dt.getHours().toString()+':'+$scope.paymentInfo.dt.getMinutes().toString()+':'+$scope.paymentInfo.dt.getSeconds().toString();
	
			  var plan_code = getPolicyForRenewalFactory.getRenewalPlan();
			  var renewal_month_year = getPolicyForRenewalFactory.getRenewalMonth()
			  $scope.trans_status = 'true';
			  
			 //var branchName = $scope.getBranchName(paymentInfo.shippingBranch)
			 var parishName = $scope.parishNameToSave
			 //alert('okay going with parish '+parishName)
			 var shippingBranchID = paymentInfo.shippingBranch || branchFromFactory;
			
			 
			 var saveTransactionCall = 'local/save_transaction.cfc?method=saveTransaction&client_number='+clientNo+'&policy_number='+policyToRenew+'&pymt_id='+ payment_id+'&dev_id='+ selectedDeliveryOptionID +'&dev_code='+selectedDeliveryOptionCode+'&apt_dt='+app_date+'&branch_id='+ shippingBranchID +'&addr_1='+paymentInfo.deliveryAddress1+'&addr_2='+paymentInfo.deliveryAddress2+'&country='+paymentInfo.country+'&parish='+ parishName +'&town='+paymentInfo.shippingTown+'&phone_number='+paymentInfo.payByPnhoneNumber+'&term_amt='+paymentInfo.premWithoutGCT+'&misc_fee='+paymentInfo.miscFee+'&misc_text='+paymentInfo.miscText+'&tax_amt='+paymentInfo.GCT+'&stamp_duty='+ (paymentInfo.clientStampAmt || 0) +'&total_payment='+paymentInfo.amtDue+'&currency='+paymentInfo.currency+'&tax_label='+$scope.tax_label+'&dev_name='+paymentInfo.deliveryFName+' '+paymentInfo.deliveryLName+'&pic_name='+ paymentInfo.pickUpFName +' '+ paymentInfo.pickUpLName+'&trans_status='+$scope.trans_status+'&plan_code='+plan_code+'&renewal_month_year='+renewal_month_year+'&system=eClient&card_name='+paymentInfo.cardname+'&card_number='+paymentInfo.cardNumber+'&card_exp='+paymentInfo.cardExpMonth+'/'+paymentInfo.cardExpYear+'&card_cvv='+paymentInfo.cardcvv+'&card_amount='+paymentInfo.amtDue+'&merchant='+$scope.merchant+'&trans_type='+ $scope.renewalPolicySummary[0].TAG;
			  
			 var ammendedURL = saveTransactionCall.replace(/undefined/gi, "")
		 
			  //save transaction
			  $http.post(ammendedURL)
			  .success(function (response) {
					 $scope.showFinalPaymentMessage = $(response).find('payment_info').find('payment_status').text();
					 
					 var shouldRedirect = $(response).find('payment_info').find('trans_success').text();
					 
					 if(shouldRedirect == 'true'){
						 redirectServices.goToRenewalPaymentConfirmation();
					 }else{
						//if payment fails then re activate submit button
						$scope.submitActive= 'true' 
						
					 }
					
			  })	
			  .error(function (data, status, headers, config) {
					$scope.processText =  "Oops we can not process at this time" 
					$scope.saveTransFailed = true
					$scope.cardMessage = '';
					
					//function to save all data going to savetransactio for error handling
					$http.get('https://clickandgo.icwi.com/rest/services/getPymtStatus/' + policyToRenew)
					.success(function(response) {
						if (response[0]) {
							$scope.cardMessage = response[0]["MESSAGE"];
							$scope.cardPassed = response[0]["SUCCESS"];
						}
					});
					/* 
					TAKE THIS OUT IF NOT WORKING ON LIVE
					*/
					saveTransactionCall = saveTransactionCall + '&error_code=' + status;
					
					
					
					//function to save all data going to savetransactio for error handling
					$http.get('local/error_log.cfc?method=errorLog&function_name=save_transaction&function_string='+saveTransactionCall.replaceAll("&", "|icwi|")+'&client_number='+clientNo)
					.success(function(response) {
							$scope.saveTransErrorCode = $(response).find('error_detail').find('error_code').text();
					});
			  });	
			 
			  
			  
					  
		 }
    };
	
	$scope.renewalFormUser =[]
	$scope.submitRenewalQuest = function(renewalFormUser, isValid, lockId) {
     // $scope.master = angular.copy(user);
	 
	 if(isValid){
		 /*
		 var origURL =  '/createRenewal/'+renewalFormUser.piemaildifferent+'/'+renewalFormUser.piEmailAddress+'/'+renewalFormUser.pimailingdifferent+'/'+encodeURIComponent(renewalFormUser.pimailingAddr) 
		 +'/'+renewalFormUser.pinumbersdifferent+'/'+renewalFormUser.pinumbers+'/'+renewalFormUser.piresidencedifferent+'/'+renewalFormUser.piresidence+'/'+renewalFormUser.pioccupationdifferent
		 +'/'+renewalFormUser.pioccupation+'/'+renewalFormUser.piemployerdifferent+'/'+renewalFormUser.piemployer+'/'+renewalFormUser.piusagedifferent+'/'+renewalFormUser.piusage+'/'
		 +renewalFormUser.piownerdifferent+'/'+renewalFormUser.piowner+'/'+renewalFormUser.piinterestdifferent+'/'+renewalFormUser.piinterest+'/'+renewalFormUser.picustodydifferent+'/'+
		 renewalFormUser.picustody+'/'+renewalFormUser.pifineddifferent+'/'+renewalFormUser.pifined+'/'+renewalFormUser.pisickdifferent+'/'+renewalFormUser.pisick  +'/'+
		 renewalFormUser.piaccidentdifferent+'/'+renewalFormUser.piaccident+'/'+ renewalFormUser.piyoungMledifferent +'/'+ renewalFormUser.piyoungMl+'/'+renewalFormUser.piyoungFemaledifferent+'/'+  
		 renewalFormUser.piyoungFemale+'/'+policyToRenew;
		 var ammendedURL = origURL.replace(/\/\s*\//gi , "/undefined/").replace(/\/\s*\//gi , "/undefined/").replace(/\/\s*\//gi , "/undefined/");
		 
		 $http.get(globaleBrokerHttp + ammendedURL)
			*/
			
			$.ajax({
				//using OPTIONS method instead of any shorthands because if using web service URL and person enters / or some other special characters, it breaks the webservice url
				//using encodeURIComponent because sending % 
				method: 'POST',
				 url: globaleBrokerHttp + '/createRenewal', //TEST
				 
				 data: ({ 
				 	emailYN: renewalFormUser.piemaildifferent,
				 	emailText :	encodeURIComponent(renewalFormUser.piEmailAddress || ''),
					
					mailingAddressYN :	renewalFormUser.pimailingdifferent,
					mailingAddressText :	encodeURIComponent(renewalFormUser.pimailingAddr || ''),
					
					numbersYN :	renewalFormUser.pinumbersdifferent,
					numbers :	encodeURIComponent(renewalFormUser.pinumbers || ''),
					
					addressYN :	renewalFormUser.piresidencedifferent,
					addressText :	encodeURIComponent(renewalFormUser.piresidence || ''),
					
					businessYN :	renewalFormUser.pioccupationdifferent,
					businessText :	encodeURIComponent(renewalFormUser.pioccupation || ''),
					
					employerAddressYN :	renewalFormUser.piemployerdifferent,
					employerAddressText :	encodeURIComponent(renewalFormUser.piemployer || ''),
					
					usageYN :	renewalFormUser.piusagedifferent,
					usageText :	encodeURIComponent(renewalFormUser.piusage || ''),
					
					ownerYN :	renewalFormUser.piownerdifferent,
					ownerText :	encodeURIComponent(renewalFormUser.piowner || ''),
					
					otherPartyYN :	renewalFormUser.piinterestdifferent,
					otherPartyText :	encodeURIComponent(renewalFormUser.piinterest || ''),
					
					custodyYN :	renewalFormUser.picustodydifferent,
					custodyText :	encodeURIComponent(renewalFormUser.picustody || ''),
					
					finedYN :	renewalFormUser.pifineddifferent,
					finedText :	encodeURIComponent(renewalFormUser.pifined || ''),
					
					illnessYN :	renewalFormUser.pisickdifferent,
					illnessText :	encodeURIComponent(renewalFormUser.pisick || ''),
					
					accidentsYN :	renewalFormUser.piaccidentdifferent,
					accidentsText :	encodeURIComponent(renewalFormUser.piaccident || ''),
					
					youngMaleYN :	renewalFormUser.piyoungMledifferent,
					youngMaleText :	encodeURIComponent(renewalFormUser.piyoungMl || ''),
					
					youngFemaleYN :	renewalFormUser.piyoungFemaledifferent,
					youngFemaleText :	encodeURIComponent(renewalFormUser.piyoungFemale || ''),
					
					plcy_no : policyToRenew
							 
				 })
				 ,
				headers: {
					"Content-Type": 'text/plain'
				}

			})
			
			.then(function(response) {
				
				//just clear stored lock option so form stops showing
				$scope.dispayLockOption('NA')
				
				//no changes lets us know if they made an illegal gange or not
				var canPassLock = $(response).find('pi_detail').find('nochanges').text();
				var lockCode = $(response).find('pi_detail').find('outstanding_code').text();
				if(canPassLock == 'True'){
					//if they answered all stuff correctly then temp unlock
					$scope.statusChange(lockId, 'True')
				}else{
					
					//else create lock that blocks client from coninuing
					// we dont want them to try and fill out the questionnare again
					//and lie to get through
					//if they had made illecal changes still temp unlock quest lock so they cant fill out from again
					//call stopLock to get the new lock that wont allow them to proceed
					//stopLock takes policy number, renewal month year and lock code (outsnading code) not to be confused with lock id which will let us know which permanent lock to bring up
					
					$scope.statusChange(lockId, 'True')
					
					$http.get(globaleBrokerHttp + '/stopLock/'+policyToRenew+'/'+monthToRenew+'/'+lockCode+'/eClient')
					.success(function(response) {
						
					});
					
				}
			}); 
	  }
    };
	

	$scope.getNumber = function(num) {
		return new Array(num);
	}
	
	//change status of locks
	$scope.statusChange = function(itemId, lockStatus) {
		//satus false does not unlock
		//true to proceed box temp unlocks pending to proceedbox is for covernotse if they dont have the document
		//true to check box really unlocks pending to check box is for covernotse if they dont have the document
		//http://ebroker.icwi.local/rest/eservice/updateLocks/item_id/check_box/proceed_box
		
		$http.get(globaleBrokerHttp + '/updateLocks/'+itemId+'/False/'+lockStatus)
		.success(function(response) {
			//call function to refresh locks
			$scope.checkLocks()
		});
	}
	$scope.prefilRenewalQues = function (policyToRenew){
		
		$http.get(globaleBrokerHttp + '/getRenewalQues/'+ policyToRenew)
			.success(function(response) {
				
				if($(response).find('questions').find('maleDriverAge').text()){
					$scope.renewalFormUser.maleDriverAge = $(response).find('questions').find('maleDriverAge').text(); //RenewalQues
				}
			    if($(response).find('questions').find('femaleDriverAge').text()){
					$scope.renewalFormUser.femaleDriverAge = $(response).find('questions').find('femaleDriverAge').text(); //RenewalQues
				}
				
				
				
			});
	}
	
	
	$scope.prefilPoca = function (clientNo){
		
		$http.get(globaleBrokerHttp + '/getPOCA/'+ clientNo)
			.success(function(response) {
				
				
				$scope.user.PolicyNumber = policyToRenew; //personal poca
				//$scope.user.comPolicyNo = policyToRenew; com poca
				if($(response).find('account_details').find('title').text()){
					$scope.user.personTitle = $(response).find('account_details').find('title').text(); //personal poca
				}
				if($(response).find('account_details').find('title').text()){
					$scope.user.personTitle = $(response).find('account_details').find('title').text(); //personal poca
				}
				if($(response).find('account_details').find('other_title').text()){
					$scope.user.otherTitle = $(response).find('account_details').find('other_title').text();  //personal poca
				}
				if($(response).find('account_details').find('mname').text()){
					$scope.user.MiddleName = $(response).find('account_details').find('mname').text(); //personal poca
				}
				if($(response).find('account_details').find('fname').text()){
					$scope.user.FirstName = $(response).find('account_details').find('fname').text(); //personal poca
				}
				if($(response).find('account_details').find('lname').text()){
					//$scope.user.LastName = $(response).find('account_details').find('lname').text(); personal poca
					$scope.user.comLeagalName = $(response).find('account_details').find('lname').text(); //com poca
				}
				if($(response).find('account_details').find('other_name').text()){
					$scope.user.otherName = $(response).find('account_details').find('other_name').text(); //personal poca
					//$scope.user.tradingName = $(response).find('account_details').find('other_name').text(); com poca
				}
				if($(response).find('account_details').find('mother_maiden_name').text()){
					$scope.user.MotherLastName = $(response).find('account_details').find('mother_maiden_name').text();//personal poca
				}
				if($(response).find('account_details').find('company_type').text()){
					$scope.user.companyPartnershipAssociation = $(response).find('account_details').find('company_type').text();
				}
				if($(response).find('account_details').find('home_addr').text()){
					$scope.user.addr1 = $(response).find('account_details').find('home_addr').text();//personal poca
				}
				if($(response).find('account_details').find('work_addr').text()){
					$scope.user.regAddr = $(response).find('account_details').find('work_addr').text();//com poca
				}
				if($(response).find('account_details').find('mailing_addr').text()){
					$scope.user.mailingAddr = $(response).find('account_details').find('mailing_addr').text();//com poca
					$scope.user.homeAddrORIG = $(response).find('account_details').find('mailing_addr').text();//store original for renewal questionaire
					//$scope.user.Mailingaddr1 = $(response).find('account_details').find('mailing_addr').text();personal poca
				}
				if($(response).find('account_details').find('place_of_birth').text()){
					$scope.user.CountryofBirth = $(response).find('account_details').find('place_of_birth').text();//personal poca
				}
				if($(response).find('account_details').find('nationality').text()){
					$scope.user.Nationality = $(response).find('account_details').find('nationality').text();//personal poca
				}
				if($(response).find('account_details').find('home_no').text()){
					$scope.user.HomeNumber = $(response).find('account_details').find('home_no').text();//personal poca
				}
				if($(response).find('account_details').find('work_no').text()){
					$scope.user.WorkNumber = $(response).find('account_details').find('work_no').text();//personal poca
				}
				if($(response).find('account_details').find('mobile_no').text()){
					$scope.user.CellNumber = $(response).find('account_details').find('mobile_no').text();//personal poca
				}
				if($(response).find('account_details').find('phone_no').text()){
					$scope.user.phoneNums = $(response).find('account_details').find('phone_no').text().split();//com poca
				}
				if($(response).find('account_details').find('birth_incorp_day').text()){
					$scope.user.dobday = $(response).find('account_details').find('birth_incorp_day').text();//personal poca
				}
				if($(response).find('account_details').find('birth_incorp_month').text()){
					$scope.user.dobmonth = $(response).find('account_details').find('birth_incorp_month').text();//personal poca
				}
				if($(response).find('account_details').find('birth_incorp_year').text()){
					$scope.user.year = $(response).find('account_details').find('birth_incorp_year').text();//personal poca
				}
					//$scope.user.comInceptionDay = $(response).find('account_details').find('birth_incorp_day').text();com poca
					//$scope.user.comInceptionMonth = $(response).find('account_details').find('birth_incorp_month').text();com poca
					//$scope.user.comInceptionYear = $(response).find('account_details').find('birth_incorp_year').text();com poca
					//$scope.user.EmailAddress = $(response).find('account_details').find('email').text();personal poca
				if($(response).find('account_details').find('email').text()){	
					$scope.user.emailAddress = $(response).find('account_details').find('email').text();//com poca
				}
				
				if($(response).find('account_details').find('other_locations').text()){
					$scope.user.otherAddresses = $(response).find('account_details').find('other_locations').text().split();//com poca
				}
				if($(response).find('account_details').find('employer').find('employer_name').text()){
					$scope.user.Employername = $(response).find('account_details').find('employer').find('employer_name').text();//personal poca
				}
				if($(response).find('account_details').find('employer').find('employer_address').text()){
					$scope.user.Employeraddr1 = $(response).find('account_details').find('employer').find('emploeer_address').text();//personal poca
				}
				if($(response).find('account_details').find('employer').find('employer_address').text()){
					$scope.user.EmployernumbersArray = $(response).find('account_details').find('employer').find('employer_numberss').text().split();//personal poca
				}
				if($(response).find('account_details').find('alternate_income').text()){
					$scope.user.descSrc = $(response).find('account_details').find('alternate_income').text();//personal poca
				}
				if($(response).find('account_details').find('id_type').text()){
					$scope.user.idType = $(response).find('account_details').find('id_type').text();//personal poca
				}
				if($(response).find('account_details').find('id_num').text()){
					$scope.user.idNumber = $(response).find('account_details').find('id_num').text();//personal poca
				}
				if($(response).find('account_details').find('exp_day').text()){
					$scope.user.expDay = $(response).find('account_details').find('exp_day').text();//personal poca
				}
				if($(response).find('account_details').find('exp_month').text()){
					$scope.user.expmonth = $(response).find('account_details').find('exp_month').text();//personal poca
				}
				if($(response).find('account_details').find('exp_year').text()){
					$scope.user.expyear = $(response).find('account_details').find('exp_year').text();//personal poca
				}
				if($(response).find('account_details').find('trn').text()){
					$scope.user.TRNNumber = $(response).find('account_details').find('trn').text();//personal poca
				}
				if($(response).find('account_details').find('occupation_industry').text()){
					//$scope.user.EnteryourOccupation = $(response).find('account_details').find('occupation').text();//personal poca
					$scope.user.occupation_industry = $(response).find('account_details').find('occupation_industry').text(); //com poca
				}
				if($(response).find('account_details').find('clnt_type').text()){
					$scope.user.typeOfPOCA = $(response).find('account_details').find('clnt_type').text();//com poca personal poca
				}
				if($(response).find('account_details').find('poca_type').text()){
					$scope.user.typeOfPOCA =  $(response).find('account_details').find('poca_type').text();
				}
				
				
				
				
			});
	}
	
	
	/*
	
	
	FOR DATES
	
	*/
	
	
	
	 $scope.today = function() {
    	/*$scope.paymentInfo.dt = '';*/
		var now = new Date();
		//set to three hours from current time
		$scope.paymentInfo.dt = new Date(now.getTime() + (4*1000*60*60));
		
		
		//if its a sunday make it monday
		if($scope.paymentInfo.dt.getDay() === 0){
			$scope.paymentInfo.dt.setDate($scope.paymentInfo.dt.getDate() + 1);
		}
		
		//if its a saturday make it monday
		if($scope.paymentInfo.dt.getDay() === 6){
			$scope.paymentInfo.dt.setDate($scope.paymentInfo.dt.getDate() + 2);
		}
		
		
	  };
	  $scope.today();
		
	
	  // Disable weekend selection
	  /*
	  $scope.disabled = function(date, mode) {
		return ( mode === 'day' && ( date.getDay() === 0 || date.getDay() === 6 ) );
	  };
	 */
	  $scope.toggleMin = function() {
		$scope.minDate = $scope.minDate ? null : new Date();
	  };
	  $scope.toggleMin();
	  $scope.maxDate = new Date(2020, 5, 22);
	
	  $scope.open = function($event) {
		$scope.status.opened = true;
	  };
	
	 
	  $scope.status = {
		opened: false
	  };
	
	  var tomorrow = new Date();
	  tomorrow.setDate(tomorrow.getDate() + 1);
	  var afterTomorrow = new Date();
	  afterTomorrow.setDate(tomorrow.getDate() + 2);
	  $scope.events =
		[
		  {
			date: tomorrow,
			status: 'full'
		  },
		  {
			date: afterTomorrow,
			status: 'partially'
		  }
    ];
	
	/*
	
	For time
	
	*/

	$scope.timeCheck= function(dt){
			//set opening hours
		   var dt = dt || new Date();
		   var hour = dt.getHours();
		   var minutes = dt.getMinutes();
		   
		   
		   if( (hour < 8) ||(hour == 8 && minutes < 30 ) || (hour == 16 && minutes > 30 ) || (hour > 16)  ){
			  $scope.outsideOpeningHours = "true"
		   }else{
			  $scope.outsideOpeningHours = "false"   
		   }
		
			
			//dont choose a past date
			//get current time
			var mytime = new Date();
			
			if(dt.getTime() < mytime.getTime()){
					$scope.date_past = "true"
					//if they coose a time in the pass then reset
				    //$log.log('dt less  ' + dt.getTime() +'    ' +mytime.getTime() );
			}else
			{
				$scope.date_past = "false"
				//if user chosen time is greater thats good
				//$log.log('dt more  ' +dt.getTime() +'    ' +mytime.getTime());
			}
	}
	
	
	//watch for date changes
	//call function on evert date change.
	//also on branch change because might be out of hours for that branch
	$scope.$watchCollection('[paymentInfo.dt, paymentInfo.shippingBranch, selectedDeliveryOption]', function() {
		$scope.checkdate()
    });
	
	
	
	$scope.checkdate = function(){
		if($scope.paymentInfo.dt){
			var app_date = $scope.paymentInfo.dt.getFullYear().toString()+'-'+ ($scope.paymentInfo.dt.getMonth() + 1).toString()+'-'+$scope.paymentInfo.dt.getDate().toString()+' '+$scope.paymentInfo.dt.getHours().toString()+':'+$scope.paymentInfo.dt.getMinutes().toString()+':'+$scope.paymentInfo.dt.getSeconds().toString();
		
			var payment_code = getPolicyForRenewalFactory.getRenewalPaymentCode();
			var plan_code = getPolicyForRenewalFactory.getRenewalPlan();
        	$http.post('local/pickup_check.cfc?method=pickUpChecker&branch_id='+$scope.paymentInfo.shippingBranch+'&date_time='+app_date+'&dev_code='+$scope.selectedDeliveryOption +'&pymt_code=' + payment_code + '&policy_no='+ policyToRenew+'&rnwl_period='+ monthToRenew)
					.success(function (response) {
								$scope.dateMessage = response[0]['MESSAGE']
								$scope.dateAvailable =response[0]['DATE_AVAILABLE']
					});
		}
	}
	//for risks
	$scope.getRisks = function (policyNo){
		$http.get(globaleBrokerHttp + '/getRiskJSON/'+policyNo)
			.success(function(response) {
				$scope.riskDetails = response;
			});
	}
	
	
	//for addons
	$scope.getAddons = function (riskItemNo){
		/*
		$http.get(globaleBrokerHttp + '/viewAddons/'+riskItemNo)
			.success(function(response) {
				$scope.addonsForRisk = response;
			});
		*/
	}
	
	// upload on file select or drop
    $scope.uploadPic = function (file, lockCode, lockID) {
		$scope.uploadFailed = ""
		
        if (file) {
			
            //for (var i = 0; i < files.length; i++) {
             // var file = files[i];
			 
			 
              if (!file.$error) {
                Upload.upload({
                    url: '/client/modules/client_portal/local/document_upload.cfc?method=documentUpload',
                    data: {
					  policy_number: policyToRenew,
					  renewal_period: monthToRenew,
					  document_type: lockCode,
                      document_file: file  
                    }
                }).then(function (resp) {
					//console.log('Success uploaded. Response: ' + resp.data);
					//var successCallback = new Function('successCallback', successCallbackBody);
					
					if(lockID){
						//call cloase locks function if ok
						//lock id exists only if its for a status update
						$scope.statusChange(lockID, 'True');
					}
					
					
				}, function (resp) {
					console.log('Alyssa: I see this failed. Error status: ' + resp.status);
					$scope.uploadFailed = "Unfortunately, we are unable to upload your file at this time. Please use the 'Proceed without uploading' button to continue."
					
				}, function (evt) {
						   
				   
                });
              }
           //}
        }
	}
	
	
 	/*
	
	for accordian
	
	*/
	$scope.accordianStatus = {
		isDeliveryOptionsDisabled: true,
		isDocumentCollectionDisabled: false,
		isPaymentDisabled: false,
		
		isDeliveryOptionsOpen: true,
		isDocumentCollectionOpen: false,
		isPaymentOpen: false
	  };
	
	
	
	//functuion calls
	$scope.prefilPoca(clientNo)
	$scope.prefilRenewalQues(policyToRenew)
	$scope.checkLocks()
	$scope.retrievePaymentSummary();
	$scope.checkRenewal();
	$scope.retrievePaymentOptions();
	$scope.retrievePaymentOptionsDisclaimers();
	$scope.getPaymentData();
	$scope.getRisks(policyToRenew)
	$scope.getBranch();
	$scope.getShippingParish();
	
}]);




























