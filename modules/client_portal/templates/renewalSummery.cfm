<!--- payment summery--->
<div class="row" > <!--ng-init=" payOnline = 'true'"-->
	<div class="col-xs-12 col-sm-12 col-md-6  hidden-xs">  
    	<h3 style="color:#006" class="">
        	<span class="fa-stack fa-lg">
              <i class="fa fa-circle-thin fa-stack-2x"></i>
              <i class="fa fa-file fa-stack-1x"></i>
            </span> 
            Policy Summary
        </h3>
        <hr class="shadowDivider"/>
        <!--renewalPolicySummary array empty, server has not responded--->
        
       <div ng-if="!renewalPolicySummary.length">
        	 <i class="fa fa-spinner fa-pulse text-primary"></i> Loading policy information
       </div>
        <!--renewalPolicySummary has message to say there are no transactions--->
       <div  ng-if = "renewalPolicySummary[0].MESSAGE">
        <h3>
        	{{renewalPolicySummary[0].MESSAGE}} 
        	
        </h3>
      </div>
      <div class="row"   ng-repeat="detail in renewalPolicySummary[0].DETAILS" ng-if="renewalPolicySummary.length && !renewalPolicySummary[0].MESSAGE"> 
    		<div class="col-xs-5 col-sm-5 text-primary">
            	{{detail.TAG}}: 
            </div>
            <div class="col-xs-7 col-sm-7">
                {{detail.DATA}}
            </div>
            <br/>
        </div>
    </div>

	<div class="col-xs-12  col-sm-12 col-md-6 " > 
    	  
          <h3 style="color:#006" class="">
        	<span class="fa-stack fa-lg">
              <i class="fa fa-circle-thin fa-stack-2x"></i>
              <i class="fa fa-usd fa-stack-1x"></i>
            </span> 
           Premium Breakdown
        </h3>
        <hr class="shadowDivider"/>
       
          
          <div class="row">
                    <div class="col-xs-7 col-sm-6 col-md-6 col-lg-6">
                        <span class="text-primary" style="">Premium:</span> 
                    </div>
                    <div class="col-xs-5 col-sm-6 col-md-6 col-lg-6">
                        {{paymentInfo.premWithoutGCT | currency}}
                    </div>
                </div>
                <div class="row">
                    <div class="col-xs-7 col-sm-6 col-md-6 col-lg-6">
                        <span class="text-primary" style="">{{miscText}}</span> 
                    </div>
                    <div class="col-xs-5 col-sm-6 col-md-6 col-lg-6">   
                        {{paymentInfo.miscFee | currency}} 
                    </div>
                </div>
                <div class="row">
                    <div class="col-xs-7 col-sm-6 col-md-6 col-lg-6">
                        <span class="text-primary" style="">{{tax_label}}</span> 
                    </div>
                    <div class="col-xs-5 col-sm-6 col-md-6 col-lg-6">   
                        {{paymentInfo.GCT | currency}}
                    </div>
                </div>
                <div class="row" ng-if="clientStampLabel">
                    <div class="col-xs-7 col-sm-6 col-md-6 col-lg-6">
                        <span class="text-primary" style="">{{clientStampLabel}}</span> 
                    </div>
                    <div class="col-xs-5 col-sm-6 col-md-6 col-lg-6">   
                        {{paymentInfo.clientStampAmt | currency}}
                    </div>
                	<hr/>    
                </div>
                <hr/>
                <div class="row">
                    <div class="col-xs-7 col-sm-6 col-md-6 col-lg-6">
                        <span class="text-primary lead">Amount Due:</span> 
                    </div>
                    <div class="col-xs-5 col-sm-6 col-md-6 col-lg-6">  
                        <span class="text-success lead"> {{paymentInfo.amtDue | currency}} {{paymentInfo.currency}}</span>
                    </div>
                </div>
            	
                
                <div class="row" ng-if ="paymentPlanOptions.length">
                    <div ng-show="showPaymentPlanDetails" class="fadeIn">
                    	<hr/>
                        <div class="col-xs-12">
                        	<h4 class="text-success">Payment Plan Options:</h4>
                        </div>
                        <br/><br/>
                        <div class="pricing-table col-xs-6 col-sm-{{12 / paymentPlanOptions.length}}" ng-repeat="paymentPlanOption in paymentPlanOptions track by $index" ng-class="{'featured': paymentPlanOption.checked == 'checked' }">
                            
                            <div class="pricing-table-header">
                                <h1>{{paymentPlanOption.name}}</h1>
                            </div>
                            <div class="pricing-table-content">
                               <h6>due now</h6>
                               {{paymentPlanOption.amount}}
                            </div>
                            
                            <div class="pricing-table-footer">
                                <p style="letter-spacing: 1px;">{{paymentPlanOption.frequency}}</p>
                                <button type="button"  class="btn  btn-md  btn-block" ng-click="changeSelectedPlan(paymentPlanOption.selectedplan)" ng-class="{'btn-success': paymentPlanOption.checked == 'checked','btn-primary': paymentPlanOption.checked != 'checked'  }" ><span ng-show="paymentPlanOption.checked == 'checked'"><i class="fa fa-check"></i> Selected</span> <span ng-show="paymentPlanOption.checked != 'checked'">Choose</span></button>
                    
                            </div>
                        </div>
                        <br/>   
                    </div>
                 </div>
                 <br  ng-if ="paymentPlanOptions.length" />
                <button type="button"  ng-show ="paymentPlanOptions.length" class="btn btn-clickAndGoDarkBlue btn-lg btn-block" ng-click="showPaymentPlanDetails = showPaymentPlanDetails == true ? false : true;" ng-init="showPaymentPlanDetails = false"  ><span ng-show="!showPaymentPlanDetails " class="hidden-xs"><i class="fa fa-plus-square"></i> Open |</span> <span ng-show="showPaymentPlanDetails" class="hidden-xs"><i class="fa fa-minus-square"></i> Close |</span>  Choose a Payment Plan </button>
		 					
          </div>
        </div>
          
          
          
          
          <!---
          
          
        <div class= "panel panel-primary" style=" margin-top:20px;"><!---pannel--->
            <div class="panel-heading" style="background-color: #000066"><h4>Premium Breakdown</h4></div>
            <div class="panel-body">
                <div class="row">
                    <div class="col-xs-7 col-sm-6 col-md-6 col-lg-6">
                        <span class="text-primary" style="">Premium:</span> 
                    </div>
                    <div class="col-xs-5 col-sm-6 col-md-6 col-lg-6">
                        {{paymentInfo.premWithoutGCT | currency}}
                    </div>
                </div>
                <div class="row">
                    <div class="col-xs-7 col-sm-6 col-md-6 col-lg-6">
                        <span class="text-primary" style="">{{miscText}}</span> 
                    </div>
                    <div class="col-xs-5 col-sm-6 col-md-6 col-lg-6">   
                        {{paymentInfo.miscFee | currency}} 
                    </div>
                </div>
                <div class="row">
                    <div class="col-xs-7 col-sm-6 col-md-6 col-lg-6">
                        <span class="text-primary" style="">GCT:</span> 
                    </div>
                    <div class="col-xs-5 col-sm-6 col-md-6 col-lg-6">   
                        {{paymentInfo.GCT | currency}}
                    </div>
                </div>
                <hr/>
                <div class="row">
                    <div class="col-xs-7 col-sm-6 col-md-6 col-lg-6">
                        <span class="text-primary lead">Amount Due:</span> 
                    </div>
                    <div class="col-xs-5 col-sm-6 col-md-6 col-lg-6">  
                        <span class="text-success lead"> {{paymentInfo.amtDue | currency}} {{paymentInfo.currency}}</span>
                    </div>
                </div>
            	
                
                <div class="row" ng-if ="paymentPlanOptions.length">
                    <div ng-show="showPaymentPlanDetails" class="fadeIn">
                    	<hr/>
                        <div class="col-xs-12">
                        	<h4 class="text-success">Payment Plan Options:</h4>
                        </div>
                        <br/><br/>
                        <div class="pricing-table col-xs-6 col-sm-{{12 / paymentPlanOptions.length}}" ng-repeat="paymentPlanOption in paymentPlanOptions track by $index" ng-class="{'featured': paymentPlanOption.checked == 'checked' }">
                            
                            <div class="pricing-table-header">
                                <h1>{{paymentPlanOption.name}}</h1>
                            </div>
                            <div class="pricing-table-content">
                               
                               {{paymentPlanOption.amount}}
                            </div>
                            
                            <div class="pricing-table-footer">
                                <p>{{paymentPlanOption.frequency}}</p>
                                <button type="button"  class="btn  btn-md  btn-block" ng-click="changeSelectedPlan(paymentPlanOption.selectedplan)" ng-class="{'btn-success': paymentPlanOption.checked == 'checked','btn-primary': paymentPlanOption.checked != 'checked'  }" ><span ng-show="paymentPlanOption.checked == 'checked'"><i class="fa fa-check"></i> Selected</span> <span ng-show="paymentPlanOption.checked != 'checked'">Choose</span></button>
                    
                            </div>
                        </div>
                                   
                        <br/>
                    </div>
                    
                 </div>
                 <br  ng-show ="paymentPlanOptions.length" /><br  ng-show ="paymentPlanOptions.length" />
                <button type="button"  ng-show ="paymentPlanOptions.length" class="btn btn-success btn-lg btn-block" ng-click="showPaymentPlanDetails = showPaymentPlanDetails == true ? false : true;" ng-init="showPaymentPlanDetails = false"  ng-class="{'btn-danger': showPaymentPlanDetails}" ><span ng-show="!showPaymentPlanDetails " class="hidden-xs"><i class="fa fa-plus-square"></i> Open |</span> <span ng-show="showPaymentPlanDetails" class="hidden-xs"><i class="fa fa-minus-square"></i> Close |</span>  Choose a Payment Plan </button>
		 					
          </div>
        </div>
    </div><!---pannel--->
    --->
    
</div>
<!--- addons--->
<div class="row "  ng-show="false">
 <br/>
 <div class="col-xs-12 side_arrow_box">
	<div class="col-xs-8">
        <h3 class="text-info">Customise your policy</h3>
     </div>
     <div class="col-xs-4 pull-right">
        <h3>
            <a href ng-click="showAddonnDetails = showAddonnDetails == true ? false : true;">
            <span ng-show="!showAddonnDetails" class="text-success"><i class="fa fa-plus-square"></i> Open</span> <span ng-show="showAddonnDetails" class="text-danger"><i class="fa fa-minus-square"></i> Close</span> 
            </a>
        </h3>
    </div>
    <br/>
    <div class="col-xs-12 fadeIn" ng-show="showAddonnDetails">
        <uib-accordion  class="">                         
              <span ng-repeat="risk in riskDetails">
                <uib-accordion-group  is-open="risk.POS" >
                  <uib-accordion-heading >
                      <span class="accordianPolicyHeading"    >
                        
                        <span class="hidden-xs">view <i class="fa fa-arrow-circle-o-right"></i> |</span> 
                        {{risk.HEADING}}
                      </span>
                  </uib-accordion-heading>
                  <div class="row"  >
                    
                            <div class="col-sm-4 text-center" ng-repeat="addon in risk['addons']" ng-class="{'text-success': addon.INCLUDE, 'text-info': ! addon.INCLUDE }">
                                <a hrf ><img ng-src="{{addon.ICON}}" width="60px" height="60px"/></a> 
                                <br/>
                                {{addon.NAME}}
                                </br>
                                <span ng-show="! addon.INCLUDE">{{addon.AMT}}</span><span ng-show="addon.INCLUDE" class="text-success"><i class="icon-check"></i> Selected</span>
                            </div>
                  </div>
                </uib-accordion-group>
          </span>  
      </uib-accordion>
   	</div>
 </div>
</div>


<!---
 <uib-tabset class="tab-animation">
        <uib-tab ng-repeat="risk in riskDetails" heading="{{risk.HEADING}}" >
              <uib-accordion>
                                                         
                      <span ng-repeat="addon in risk['addons']">
                        <uib-accordion-group  >
                          <uib-accordion-heading >
                              <span class="accordianPolicyHeading">
                                <span class="hidden-xs">view <i class="fa fa-arrow-circle-o-right"></i> |</span> 
                                {{addon.NAME}}  
                              </span>
                         </uib-accordion-heading>
                          <a hrf ><img ng-src="{{addon.ICON}}" width="100px" height="100px"/></a>{{addon.AMOUNT}}
                        </uib-accordion-group>
                  </span>  
              </uib-accordion>
              
              
              
              
           
              
            
        </uib-tab>
    </uib-tabset>
    
--->
<!--- / addons--->

<div class="row" ng-show="false">
	<div class="col-xs-12  col-sm-12  col-md-12  col-lg-12 ">  
        <h3 style="color:#006"  class="text-muted">
        	<span class="fa-stack fa-lg">
              <i class="fa fa-circle-thin fa-stack-2x"></i>
              <i class="fa fa-plus fa-stack-1x"></i>
            </span> 
            Signature Options
        </h3>
        <hr class="shadowDivider"/>
    </div>
    
    
    
    <span class="text-info col-xs-12">
         <uib-alert  class="slideIn" type="default" ng-show="showRiskTabHelp && inTwo.risks.length" close="showRiskTabHelp = false" ng-init="showRiskTabHelp=true">
            <i class="fa fa-info-circle"></i> This policy has {{inTwo.risks.length}} risks. Youcan choose addons below.
         </uib-alert>
        <uib-tabset class="tab-animation">
            <uib-tab ng-repeat="risk in riskDetails" heading="{{risk.POS}}" ng-init="getAddons(risk.DATA)" >
                <br/>
                <uib-alert  type="warning">
                    {{risk.HEADING}}
                </uib-alert>
                
                <div class="row">
                    <div class="pricing-table col-sm-4" ng-repeat="addon in addonsForRisk">
                        <div class="pricing-table-header">
                            <h1>{{addon.NAME}}</h1>
                            <a href ng-click="showAddonBenefits1 = showAddonBenefits1 == true ? false : true;" ng-init="showAddonBenefits1 = false">See Benefits</a>
                        </div>
                        
                        <div class="pricing-table-content slideIn" ng-show="showAddonBenefits1">
                            <ul>
                                <li><strong>50GB</strong> Disk Space</li>
                                <li><strong>20</strong> Email Addresses</li>
                                <li><strong>10</strong> Subdomains</li>
                                <li><strong>30</strong> MySQL Databases</li>
                            </ul>
                        </div>
                        
                        <div class="pricing-table-footer">
                            <h2><sup>$</sup>{{addon.AMT}}</h2>
                            <a href="#">Sign Up</a>
                        </div>
                    </div>
                </div>
                
                
                
                
            </uib-tab>
        </uib-tabset>
    </span>
</div>
<!--- /addons --->

<!--- payment method--->
<div ng-include src="'templates/paymentOptions.cfm'"></div>


<br/><br/>