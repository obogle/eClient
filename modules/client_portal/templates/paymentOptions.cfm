<div class="row" ng-show="paymentOptions.length > 1">
	<div class="col-xs-12  col-sm-12  col-md-12  col-lg-12 ">  
        <h3 style="color:#006"  class="text-muted">
        	<span class="fa-stack fa-lg">
              <i class="fa fa-circle-thin fa-stack-2x"></i>
              <i class="fa fa-shopping-cart fa-stack-1x"></i>
            </span> 
            Payment Method
        </h3>
        <hr class="shadowDivider"/>
    </div>
</div>
<!--
<uib-alert  type="warning" >
	<div class="row">
         <div class="col-xs-11 col-sm-12 col-md-12 col-lg-12">   
            <h><i class="fa fa-shopping-cart"></i>  Payment Method - Please choose a method to pay by.</h>
         </div>
     </div>
</uib-alert>
-->
<div class="row"  ng-show="paymentOptionsDisclaimers.length > 0" >    <!---payment options disclaimer --->
    <div  class="col-sm-12 text-danger" ng-repeat="disclaimer in paymentOptionsDisclaimers">
        <i class="fa fa-exclamation-triangle" aria-hidden="true"></i> {{disclaimer.MESSAGE}}  
        <br/> <br/>
        
    </div>
</div>  <!--- / payment options disclaimer --->
<div class="row"  ng-show="paymentOptions.length > 1" >
	<div class="col-xs-12  col-sm-12  col-md-12  col-lg-12 ">  
        <a href  ng-repeat="paymentOption in paymentOptions" class="paymentOptionDiv"  > 
         <div  class="col-xs-12 col-sm-12 col-md-{{12 / paymentOptions.length}} col-md-{{12 / paymentOptions.length}} col-lg-{{12 / paymentOptions.length}} "   ng-class="{'selectedDiv': selectedPayment == '{{paymentOption.ID}}'}" ng-click="changePaymentOption(paymentOption.ID, paymentOption.CODE)" >   
         		
                <h4   ng-show=" selectedPayment == {{paymentOption.ID}}"> 
                	<i style="color:#90D280;" class="fa fa-check-circle-o"></i> Pay {{paymentOption.HEADING}} selected
               </h4> 
               <h4 ng-show=" selectedPayment != {{paymentOption.ID}}"> 
               		<i class="{{paymentOption.ICON}}"></i></span> Pay {{paymentOption.HEADING}}
               </h4> 
                <span style="font-size:12px;" ng-show=" selectedPayment != {{paymentOption.ID}}"><i class="fa fa-exclamation-circle"></i> Click to choose this option</span>
                <br/>
                    
                    <span class="hidden-xs">
                        {{paymentOption.DETAILS}}
                    </span>
                    <span class="visible-xs" ng-show=" selectedPayment == {{paymentOption.ID}}">
                        {{paymentOption.DETAILS}}
                    </span>
                 
         		<hr class="visible-xs visible-sm"/>
         </div>
       </a>
    </div>
 </div>
