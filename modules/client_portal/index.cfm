<!DOCTYPE html>
<html lang="en" >
    <head>
        <meta charset="utf-8" />
        <title>ICWI  Click & Go</title>
        
        <cfinclude template="../header.cfm" />
        <!-- find more at https://code.angularjs.org/1.2.0rc1/ -->
		<script src="angular-route.min.js" ></script>
        <script src="js/routes.js" ></script>
        <script src="js/loadScript.js" ></script>
        <script src="js/angular-idle.min.js"></script>
        
        <!---editable text ---> 
      	<link href="css/xeditable.css" rel="stylesheet">
		<script src="js/xeditable.min.js"></script>
        <!---/ editable text ---> 
        
        
		
		<!---onboarding---> 
    	<link href="css/ng-onboarding.css" rel="stylesheet">
		<script src="js/ng-onboarding.min.js"></script>
        <!---/ onboarding---> 
        
        
        
        
        <!---controllers---> 
        <script src="controllers/dashboardController.js" ></script>
        <script src="controllers/menuController.js" ></script>
        <script src="controllers/renewalController.js" ></script>
        <script src="controllers/passwordResetController.js" ></script>
        <script src="controllers/limitsOfLiabilityController.js" ></script>
        <script src="controllers/addonsController.js" ></script>
        <script src="controllers/completeRegistrationController.js" ></script>
        <script src="controllers/finalPasswordConfromationController.js" ></script>
        <script src="controllers/transactionDetailsController.js" ></script>
        <script src="controllers/loginController.js" ></script>
        <script src="controllers/renewalPaymentAcceptedController.js" ></script>
        
        <!---services --->
        <script src="services/authServices.js" ></script>
        <script src="services/redirectServices.js" ></script>
        
        <!---factories --->
        <script src="factories/policyForLimitsFactory.js" ></script>
        <script src="factories/getAddonsFactory.js" ></script>
        <script src="factories/getPolicyForRenewal.js" ></script>
        <script src="factories/paymentOptionFactory.js" ></script>
        
         <!--- detect ie code --->
         <script>
		 	
			// Get IE or Edge browser version
			var version = detectIE();
			
			if (version === false) {
			  //not IE
			} else if (version >= 12) {
			  // alert('Edge ' + version);
			} else {
			  // alert('IE ' + version);
			  //old ie bad
			  alert('Oh no!  You are using an out of date version of Internet Explorer and so cannot run ICWI Click & Go. If you are using Windows 10 or newer please switch to Microsoft Edge or try Chrome to experience insurance the ICWI way.')
			  
			}
			
			// add details to debug result
			// document.getElementById('details').innerHTML = window.navigator.userAgent;
			
			/**
			 * detect IE
			 * returns version of IE or false, if browser is not Internet Explorer
			 */
			function detectIE() {
			  var ua = window.navigator.userAgent;
			
			  // Test values; Uncomment to check result …
			
			  // IE 10
			  // ua = 'Mozilla/5.0 (compatible; MSIE 10.0; Windows NT 6.2; Trident/6.0)';
			  
			  // IE 11
			  // ua = 'Mozilla/5.0 (Windows NT 6.3; Trident/7.0; rv:11.0) like Gecko';
			  
			  // Edge 12 (Spartan)
			  // ua = 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.71 Safari/537.36 Edge/12.0';
			  
			  // Edge 13
			  // ua = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2486.0 Safari/537.36 Edge/13.10586';
			
			  var msie = ua.indexOf('MSIE ');
			  if (msie > 0) {
				// IE 10 or older => return version number
				return parseInt(ua.substring(msie + 5, ua.indexOf('.', msie)), 10);
			  }
			
			  var trident = ua.indexOf('Trident/');
			  if (trident > 0) {
				// IE 11 => return version number
				var rv = ua.indexOf('rv:');
				return parseInt(ua.substring(rv + 3, ua.indexOf('.', rv)), 10);
			  }
			
			  var edge = ua.indexOf('Edge/');
			  if (edge > 0) {
				// Edge (IE 12+) => return version number
				return parseInt(ua.substring(edge + 5, ua.indexOf('.', edge)), 10);
			  }
			
			  // other browser
			  return false;
			}
		</script>
        <!--- end detect ie code --->
        
        <!---global variables--->
        <script>
			console.log(
		   `
						░░░░░░░░░░░███████░░░░░░░░░░░
						░░░░░░░████░░░░░░░████░░░░░░░
						░░░░░██░░░░░░░░░░░░░░░██░░░░░
						░░░██░░░░░░░░░░░░░░░░░░░██░░░
						░░█░░░░░░░░░░░░░░░░░░░░░░░█░░
						░█░░████░░░░░░░░██████░░░░░█░
						█░░█░░░██░░░░░░█░░░░███░░░░░█
						█░█░░░░░░█░░░░░█░░░░░░░█░░░░█
						█░█████████░░░░█████████░░░░█
						█░░░░░░░░░░░░░░░░░░░░░░░░░░░█
						█░░░░░░░░░░░░░░░░░░░░░░░░░░░█
						█░░░████████████████████░░░░█
						░█░░░█▓▓▓▓▓▓▓▓█████▓▓▓█░░░░█░
						░█░░░░█▓▓▓▓▓██░░░░██▓██░░░░█░
						░░█░░░░██▓▓█░░░░░░░▒██░░░░█░░
						░░░██░░░░██░░░░░░▒██░░░░██░░░
						░░░░░██░░░░███████░░░░██░░░░░
						░░░░░░░███░░░░░░░░░███░░░░░░░
						░░░░░░░░░░█████████░░░░░░░░░░
			
			 ZZZZZZZZ?  :ZZZZ77ZZZ+ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ?
			   ZZZZ   ZZZZ      ZZZ. ZZZZ 7ZZZZ  ZZZZ    ZZZZ
			   ZZZZ  $ZZZZ           .ZZZZ  ZZZZ  ZZZ    ZZZZ
			   ZZZZ    ZZZ,    ~ZZ,   .ZZZ?  ZZZZ        ZZZZ
			 ZZZZZZZZ?  :ZZZZZ+ZZ       ZZZZ  ZZZ      ZZZZZZZZ?
			
			~~~~~~~~~~~~~~Serving you is all we do~~~~~~~~~~~~~~
			`
			)
		
		
        	
			<!--- var globaleClientHttp = "//clickandgo.icwi.com/rest/services" live--->
			var globaleClientHttp = "//127.0.0.1:8500/rest/services" <!--- test--->
			<!--- var globaleBrokerHttp = "//ebroker.icwi.com/rest/services"live--->
			var globaleBrokerHttp = "//127.0.0.1:8500/rest/services"<!--- test--->
        </script>
        <!--Start of Zopim Live Chat Script-->
		<script type="text/javascript">
        window.$zopim||(function(d,s){var z=$zopim=function(c){z._.push(c)},$=z.s=
        d.createElement(s),e=d.getElementsByTagName(s)[0];z.set=function(o){z.set.
        _.push(o)};z._=[];z.set._=[];$.async=!0;$.setAttribute("charset","utf-8");
        $.src="//v2.zopim.com/?2xcAGJQf8pIlpE7j4TOUzZCcFhxxsdT4";z.t=+new Date;$.
        type="text/javascript";e.parentNode.insertBefore($,e)})(document,"script");
        </script>
        <!--End of Zopim Live Chat Script-->
    </head>
    <body >
   
        <div ng-app="loginApp">
             <div  ng-show="clientInfo" ng-include="'../menu.cfm'" ></div>
             	<div class="container" id="loginOrregisterDiv" style="display:;"><!--- bootstrap wrapper --->
                            <div class="row"><!--- row login or register--->
                                <div class="col-xs-12 col-sm-12   <!---col-sm-offset-1---> form-box"  ng-class="{'col-sm-10': clientInfo, 'col-sm-offset-1': clientInfo, 'col-xs-10': !clientInfo}">        
                               <!--- <div class=" col-sm-offset-1 form-box" ng-class="{'col-sm-10': clientInfo, 'col-sm-12': !clientInfo}">        --->
                                    <div class="wrapperTop" ><!--- wrapper Top --->
                                    
                                        <div  ng-show="clientInfo"  ng-class="{'form-header': clientInfo}" style="padding:5px 10px 10px 10px">
                                        	<h3>
                                                <span class="">
                                                  <i class="fa fa-bookmark-o" aria-hidden="true"></i>
                                                </span>
                                                <span class="">Welcome {{clientInfo.clientName}}</span>
                                            </h3>
                                         </div>
                                    
                                 </div><!--- wrapper Top --->
                                 <div class="" ng-class="{'wrapperBottom': clientInfo}"><!--- wrapper Bottom--->
                                 	<!---to switch background--->
                                 	<div ng-if="clientInfo" ng-include="'templates/backgroundForApp.html'" ></div>
                                    <div ng-if="!clientInfo" ng-include="'templates/backgroundForAppHomepage.html'"></div>
                                    
                                    
                                     <div class="page {{ pageClass }}"  ng-view>
                                  
                                          
                                     </div>
                              </div><!--- / wrapper--->
                         </div>
                     </div>
                 </div>     <!--- / bootstrap wrapper --->
          </div>
    </body>
</html>
