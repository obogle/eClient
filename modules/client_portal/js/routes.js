var app = angular.module('loginApp',['ngRoute'
									,'ui.bootstrap'
									,'xeditable'
									,'ngIdle'
									,'ngAnimate'
									,'ngLoadScript'
									,'ngOnboarding'
									,'ngFileUpload'
									,'AxelSoft'
									]);
									
									
									

//filter for newline
app.filter('newline', function($sce) {
    return function(text) {
        text = text.replace(/\n\r?/g, '<br />');
        return $sce.trustAsHtml(text);
    }
});

//telephone filter
app.filter('telFilter', function () {
    return function (tel) {
        if (!tel) { return ''; }

        var value = tel.toString().trim().replace(/^\+/, '');

        if (value.match(/[^0-9]/)) {
            return tel;
        }

        var country, city, number;

        switch (value.length) {
            case 7: // ####### -> ###-####
                country = 1;
                city = value.slice(0, 0);
                number = value.slice(0,7);
                break;
            case 10: // +1PPP####### -> C (PPP) ###-####
                country = 1;
                city = value.slice(0, 3);
                number = value.slice(3);
                break;

            case 11: // +CPPP####### -> CCC (PP) ###-####
                country = value[0];
                city = value.slice(1, 4);
                number = value.slice(4);
                break;

            case 12: // +CCCPP####### -> CCC (PP) ###-####
                country = value.slice(0, 3);
                city = value.slice(3, 5);
                number = value.slice(5);
                break;

            default:
                return tel;
        }

        if (country == 1) {
            country = "";
        }

        number = number.slice(0, 3) + '-' + number.slice(3);

        return (country + " (" + city + ") " + number).trim();
    };
});
//null element
app.directive("diNull", function() {
        return {
            restrict: "E",
            replace: true,
            template: ""
        };
    });
	
	
//editable text fields
app.run(function(editableOptions) {
  editableOptions.theme = 'bs3'; // bootstrap3 theme. Can be also 'bs2', 'default'
});


//angularjs multistep form
//app.directive(rcSubmitDirective);
app.config(function(IdleProvider, KeepaliveProvider) {
  IdleProvider.idle(2);
  IdleProvider.timeout(4);
  KeepaliveProvider.interval(4);
});


// assume myApp was defined according to the "Configure" example above
/* */
app.run(['Idle', function(Idle) {
  Idle.watch();
}]);

//check every 10 minutes if sever is down  - 600000
/**/
app.run(function($rootScope, $interval, serverTestService, redirectServices) {
	$rootScope.serverIsAvailable = 'Available'

	serverTestService.testServer();
	if ($rootScope.serverIsAvailable == 'Unavailable'){
		redirectServices.goToServerErrorPage(); 
	}
	
    $interval(function() {
        console.log('checking if server is up...');
		serverTestService.testServer();
    }, 600000);
	
	$rootScope.$watch('serverIsAvailable', function (newValue, oldValue, scope) {
		if (oldValue == newValue) return;
		if ($rootScope.serverIsAvailable == 'Unavailable'){
			redirectServices.goToServerErrorPage(); 
		}
		if ($rootScope.serverIsAvailable == 'Available'){
			redirectServices.goToDashboard();
		}
	}, true);
	
});
app.service('serverTestService', function($http, $rootScope) {

	this.testServer = function (){
		$http.get(globaleBrokerHttp + '/getServiceUpdateStatus/')
		.success(function (response) {
				$rootScope.serverIsAvailable = $(response).find('status').text();
		})
	}
});


//show number in input as currency formatted but 
app.directive('realTimeCurrency', function ($filter, $locale) {
    var decimalSep = $locale.NUMBER_FORMATS.DECIMAL_SEP;
    var toNumberRegex = new RegExp('[^0-9\\' + decimalSep + ']', 'g');
    var trailingZerosRegex = new RegExp('\\' + decimalSep + '0+$');
    var filterFunc = function (value) {
        return $filter('currency')(value);
    };

    function getCaretPosition(input){
        if (!input) return 0;
        if (input.selectionStart !== undefined) {
            return input.selectionStart;
        } else if (document.selection) {
            // Curse you IE
            input.focus();
            var selection = document.selection.createRange();
            selection.moveStart('character', input.value ? -input.value.length : 0);
            return selection.text.length;
        }
        return 0;
    }

    function setCaretPosition(input, pos){
        if (!input) return 0;
        if (input.offsetWidth === 0 || input.offsetHeight === 0) {
            return; // Input's hidden
        }
        if (input.setSelectionRange) {
            input.focus();
            input.setSelectionRange(pos, pos);
        }
        else if (input.createTextRange) {
            // Curse you IE
            var range = input.createTextRange();
            range.collapse(true);
            range.moveEnd('character', pos);
            range.moveStart('character', pos);
            range.select();
        }
    }
    
    function toNumber(currencyStr) {
        return parseFloat(currencyStr.replace(toNumberRegex, ''), 10);
    }

    return {
        restrict: 'A',
        require: 'ngModel',
        link: function postLink(scope, elem, attrs, modelCtrl) {    
            modelCtrl.$formatters.push(filterFunc);
            modelCtrl.$parsers.push(function (newViewValue) {
                var oldModelValue = modelCtrl.$modelValue;
                var newModelValue = toNumber(newViewValue);
                modelCtrl.$viewValue = filterFunc(newModelValue);
                var pos = getCaretPosition(elem[0]);
                elem.val(modelCtrl.$viewValue);
                var newPos = pos + modelCtrl.$viewValue.length -
                                   newViewValue.length;
                if ((oldModelValue === undefined) || isNaN(oldModelValue)) {
                    newPos -= 3;
                }
                setCaretPosition(elem[0], newPos);
                return newModelValue;
            });
        }
    };
});

app.config(['$routeProvider',function($routeProvider){
	$routeProvider

	.when("/passwordReset/:key",
    {
      templateUrl: "templates/finalPasswordConfromation.cfm",
      controller: "finalPasswordConfromationCtrl"
	  
    })
	
	.when('/welcome/:accessToken', {
		templateUrl: 'templates/login.cfm',
		controller: 'loginCtrl',
	})
	.when('/register', {
		templateUrl: 'templates/register.cfm'
	})
	.when('/updatingAccount', {
		//for when server updating put them on dummy page so they dont run any web services
		templateUrl: 'templates/serverUpdating.cfm'
	})
	.when('/dashboard', {
		resolve:{
			"check": function($location, $rootScope){
				if (!$rootScope.clientInfo){
						$location.path('/');
				}
				
			}
		},
		templateUrl: 'templates/dashboard.cfm',
		controller: 'dashboardCtrl',
	})
	.when("/confirmRegistration/:key",
    {
      templateUrl: "templates/completeRegistration.cfm",
      controller: "completeRegistrationCtrl"
    })
	
	.when('/renewal', {
		resolve:{
			"check": function($location, $rootScope){
				if (!$rootScope.clientInfo){
						$location.path('/');
				}
				
			}
		},
		templateUrl: 'templates/renewal.cfm',
		controller: 'renewalCtrl',
	})
	
	.when('/renewalAccepted', {
		resolve:{
			"check": function($location, $rootScope){
				if (!$rootScope.clientInfo){
						$location.path('/');
				}
				
			}
		},
		templateUrl: 'templates/renewalPaymentAccepted.cfm',
		controller: 'renewalPaymentAcceptedCtrl',
	})
	.when('/transactionDetails', {
		resolve:{
			"check": function($location, $rootScope){
				if (!$rootScope.clientInfo){
						$location.path('/');
				}
				
			}
		},
		templateUrl: 'templates/transactionDetails.cfm',
		controller: 'transactionDetailsCtrl',
	})
	.otherwise({
		 /*
		 I seemed to get somewhere with
		 redirectTo: '/welcome'
		 */
		redirectTo: '/welcome/'
	});
}]);