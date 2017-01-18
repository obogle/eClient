app.factory('getPolicyForRenewalFactory', [ function() {
	 var savedData = {}
	 var savedmonth = {}
	 var savedTerritory = {}
	 var savedPlan = {}
	 var paymentID = {}
	 var paymentCode = {}
	 var selectedDeliveryOptionID = {}
	 var selectedDeliveryOption ={}
	 var savedBranch ={}
	 
	 function set(data) {
	   savedData = data;
	 }
	 function get() {
	  return savedData;
	 }
	 
	function setRenewalMonth(data){
		savedmonth  = data;
	}
	 function getRenewalMonth() {
	  return savedmonth;
	 }
	 
	 function setRenewalBranch(data){
		savedBranch  = data;
	}
	 function getRenewalBranch() {
	  return savedBranch;
	 }
	 
	 function setRenewalTerritory(data){
		savedTerritory  = data;
	}
	 function getRenewalTerritory() {
	  return savedTerritory;
	 }
	 
	 
	 
	 function setRenewalPlan(data){
		savedPlan  = data;
	}
	 function getRenewalPlan() {
	  return savedPlan;
	 }
	 
	 
	  function setRenewalPaymentID(data){
		paymentID  = data;
	}
	 function getRenewalPaymentID() {
	  return paymentID;
	 }
	 
	 
	 function setRenewalPaymentCode(data){
		paymentCode  = data;
	 }
	 function getRenewalPaymentCode() {
	  return paymentCode;
	 }
	 
	 
	 
	  function setSelectedDeliveryOption(data){
		selectedDeliveryOption  = data;
	}
	 function getSelectedDeliveryOptionD() {
	  return selectedDeliveryOption;
	 }
	 
	 
	 
	  function setSelectedDeliveryOptionID(data){
		selectedDeliveryOptionID  = data;
	}
	 function getSelectedDeliveryOptionID() {
	  return selectedDeliveryOptionID;
	 }
	 
	 
	 return {
	  set: set,
	  get: get,
	  
	  setRenewalMonth: setRenewalMonth,
	  getRenewalMonth : getRenewalMonth,
	  
	  setRenewalTerritory: setRenewalTerritory,
	  getRenewalTerritory : getRenewalTerritory,
	  
	  setRenewalPlan: setRenewalPlan,
	  getRenewalPlan : getRenewalPlan,
	  
	  getRenewalBranch:getRenewalBranch,
	  setRenewalBranch:setRenewalBranch,
	  
	  setRenewalPaymentID: setRenewalPaymentID,
	  getRenewalPaymentID : getRenewalPaymentID,
	  
	  setRenewalPaymentCode:setRenewalPaymentCode,
	  getRenewalPaymentCode:getRenewalPaymentCode,
	  
	  setSelectedDeliveryOption: setSelectedDeliveryOption,
	  getSelectedDeliveryOptionD : getSelectedDeliveryOptionD,
	  
	  setSelectedDeliveryOptionID: setSelectedDeliveryOptionID,
	  getSelectedDeliveryOptionID : getSelectedDeliveryOptionID
	 }

}]);