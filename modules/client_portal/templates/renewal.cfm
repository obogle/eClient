

<uib-progressbar  class="progress-striped active" value="stepSize" type="success" ng-init="stepSize=5"><b>{{stepSize | number:0 }}% <span class="hidden-xs">complete</span></b></uib-progressbar>
<div id="progressTitles">
    <table id="progressTitlesTable" >
        <tr >
        	<td ng-repeat="formStep in formStepHeadings track by $index" width="{{100 / formStepHeadings.length}}%">
            	<span ng-class="{'text-success': $index + 1 <=  step}">{{formStep.heading}} </span>
            </td>
        </tr>
    </table>
</div>

<br class="hidden-xs"/>

<div ng-switch="step" ng-init="step=1" >
  <div ng-switch-when="1" class="slideInDown">
	 
     <div ng-include src="'templates/renewalInstructionsAndLocks.cfm'"></div>

	 
  </div>

  <div ng-switch-when="2" class="slideInDown">
     <div ng-include src="'templates/renewalSummery.cfm'"></div>
     <div class="row">
     	<div class="col-xs-6">
             <button ng-click="minusStep()" type="button" class="btn btn-clickAndGoBlue btn-lg btn-block">
             	<span class="fa-stack  ">
                  <i class="fa fa-circle-thin fa-stack-2x"></i>
                  <i class="fa fa-arrow-left fa-stack-1x"></i>
                </span>
                Back
             </button>
        </div>
        <div class="col-xs-6">    
             <button ng-click="addStep(); "  type="button" class="btn  btn-clickAndGoYellow btn-lg btn-block">
             	Next 
                <span class="fa-stack ">
                  <i class="fa fa-circle-thin fa-stack-2x"></i>
                  <i class="fa fa-arrow-right fa-stack-1x"></i>
                </span>
             </button>
  		</div>
  	 </div>
  </div>

  <div ng-switch-when="3" class="slideInDown">
     <div ng-include src="'templates/paymentPage.cfm'"></div>
  </div>
</div>

