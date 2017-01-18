
app.controller('transactionDetailsCtrl', ['$scope','$rootScope' ,'$http','redirectServices', '$window',  function ($scope, $rootScope,$http,redirectServices,$window){
	
	$rootScope.pageClass = '';
	var clientNo = $rootScope.clientInfo.clientNo;
	
	
	
	//Function definitions
	$scope.getTransactionDetails = function() {
		 var getTransactionDetailsCall = 'local/view_transactionsClient.cfc?method=viewTransClient&client_number='+clientNo
		 $http.post(getTransactionDetailsCall)
					.success(function (response) {
							$scope.transactionDetails = response;
								
							
					})
					.error(function(response) {
						$scope.transactionDetails = ([{"MESSAGE":"Oops! There was a problem with retreiving your transactions. Please try refreshing the page."}]);
						//function to save all data going to savetransactio for error handling
						$http.get('local/error_log.cfc?method=errorLog&function_name=view_transactionsClient&function_string='+getTransactionDetailsCall+'&client_number='+clientNo)
					});
		 
    };
	
	
	$scope.getDocument = function (policyNo, period){
		var getDocumentCall = globaleBrokerHttp + '/getCertCnote/'+policyNo+'/'+period+'/client'
		$http.get(getDocumentCall)
			.success(function(response) {
				var generatedDocumentThumb =  $(response).find('documents_detail').find('document_thumbnail').text();
				var generatedDocumentLink =  $(response).find('documents_detail').find('document_issued').text();
				var document_header =  $(response).find('documents_detail').find('document_header').text();
				$scope.documentToShow = generatedDocumentThumb;
				$scope.documentLink = generatedDocumentLink;
				$scope.document_header = document_header;
			})
			.error(function(response) {
				$scope.document_header = "Oops! There was a problem with retreiving your document. Please try refreshing the page.";
				//function to save all data going to savetransactio for error handling
				$http.get('local/error_log.cfc?method=errorLog&function_name=getCertCnote&function_string='+getDocumentCall+'&client_number='+clientNo)
			});
			
	}
	
	
	$scope.renewPolicy = function (policyNo, renewal_month, territory, plan){
		redirectServices.goToRenewal();
		
	}
	
	$scope.openPDF = function(pdfLink){
		$window.open(pdfLink, 'C-Sharpcorner', 'width=500,height=600');	
	}
	//function calls
	$scope.getTransactionDetails();

}]);



