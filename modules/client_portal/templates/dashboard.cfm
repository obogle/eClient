

<script type="text/ng-template" id="warning-dialog.html">
  <div class="modal-header">
   <h3>Are you still there? </h3>
  </div>
  You will be logged out in {{countdown}} second(s).
  <div idle-countdown="countdown" ng-init="countdown=10" class="modal-body">
   <uib-progressbar max="10" value="countdown" animate="true" class="progress-striped active">{{countdown}} second(s)</uib-progressbar>
  </div>

</script>









   

                                    <div class="row" >
                                        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" > 
                                            <div id="policyAlerts" style="margin-top:20px;">
                                            
                                            </div>
                                        </div>
                                    </div>
                                   <!--  
                                   <a id='start_button' href='' ng-click='startOnboarding()'>Start Onboarding!</a>
                                  <onboarding-popover enabled='showOnboarding' steps='onboardingSteps' step-index='stepIndex'></onboarding-popover>
                                  <div id='content_1' class='zone'>
                                    <h2>Content 1</h2>
                                  </div>
                                  <div id='content_2' class='zone'>
                                    <h2>Content 2</h2>
                                    <p>Morbi pulvinar massa quis lectus hendrerit, id porta erat sodales. Nullam vitae turpis metus. Suspendisse porta consequat nisi at viverra. Phasellus egestas est et condimentum ultrices. Donec vulputate convallis dictum. In et risus scelerisque, ornare elit ullamcorper, adipiscing libero. Proin nec venenatis orci, ut facilisis sem. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Cras non bibendum orci, sed luctus dolor. Pellentesque quis faucibus ipsum. Ut id eleifend sapien, a dignissim ante. Maecenas sagittis justo imperdiet consectetur imperdiet. Praesent sagittis lectus risus, quis sodales odio porta a.</p>
                                  </div>
                                  <div id='content_3' class='zone'>
                                    <h3>Content 3</h3>
                                    <table>
                                      <thead><tr><th>ID</th><th>Name</th></tr></thead>
                                      <tbody>
                                        <tr><td>1</td><td>John Doe</td></tr>
                                        <tr><td>2</td><td>Jane Smith</td></tr>
                                      </tbody>
                                    </table>
                                  </div>
                                  <div id='content_4' class='zone'>
                                    <h2>Content Zone 4</h2>
                                    <form>
                                      <p>
                                        <label>Field 1</label>
                                        <br/>
                                        <input type='text' />
                                      </p>
                                      <p>
                                        <label>Field 2</label>
                                        <br/>
                                        <select><option>Choose Me</option></select>
                                      </p>
                                    </form>
                                  </div>
                                </div> 
                                    -->  
                                 
                                    <div class="row" ><!---policy alerts row--->
                                        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12"> <!---account --->
                                        	<uib-alert ng-repeat="alert in policyAlerts track by $index" type="warning" close="closePolicyAlert($index)"><i class="fa fa-exclamation-triangle"></i> {{alert.DATA}}</uib-alert>
                                        </div>
                                    </div><!---/ policy alerts row--->
                                    <div class="row" ><!---account menu row--->
                                        <div class="col-xs-12 col-sm-12 col-md-12"> <!---account --->
                                                <h3  style="color:#006;">
                                                    <span class="fa-stack fa-lg">
                                                      <i class="fa fa-circle-thin fa-stack-2x"></i>
                                                      <i class="fa fa-user fa-stack-1x"></i>
                                                    </span> 
                                                    Account Summary
                                                 </h3>
                                                 
                                                 <hr class="shadowDivider"/>
                                                
                                               
                                                <!--- No Editing
                                                <div class="row"  ng-repeat="detail in accountDetails" style="padding-bottom:10px;">
                                                	
                                                    <span class="text-info col-xs-12 col-sm-4 col-md-4 col-lg-4">
                                                    	{{detail.TAG}}:
                                                     </span>
                                                     <span class="col-xs-9 col-sm-6 col-md-6 col-lg-6">   
                                                		{{detail.DATA}}
                                                     </span>
                                                </div>
                                                --->
                                                
												<div class="row">
                                                	<span class="text-info col-xs-12 col-sm-10 col-md-10 col-lg-10 ">
                                                		<uib-alert class="slideIn" type="warning" ng-show="showPolicyRequestChange" close="showPolicyRequestChange = false"><i class="fa fa-info-circle"></i> {{showPolicyRequestChangeMessage}}</uib-alert>
                                                    </span>
                                                </div>
												<!---Editable Content--->
                                                <div class="row" style="padding-bottom:10px;" ng-if="accountDetails.length && accountDetails[0].MESSAGE" > 
                                                	<div class="col-xs-12">
                                                    	<h3>{{accountDetails[0].MESSAGE}}</h3>
                                                    </div>
                                                </div>
												<div class="row" style="padding-bottom:10px;" ng-repeat="detail in accountDetails"  ng-if="accountDetails.length && !accountDetails[0].MESSAGE" > 
                                                	
                                                        <span class="text-info col-xs-12 col-sm-4 col-md-4 col-lg-4">
                                                            <span  class="visible-xs " ><a  tooltip-placement="right"  uib-tooltip="The {{detail.TAG}} field can be edited. Just click to edit."><span  tooltip-placement="right"ng-show="detail.EDIT" class="fa fa-pencil text-success"> </span></a> {{detail.TAG}}:</span>
                                                            <span  class="hidden-xs ">{{detail.TAG}}:</span>
                                                         </span>
                                                         <span class="col-xs-12 col-sm-5"> 
                                                            <a href  onaftersave="updateUser(detail.ID, detail.DATA, detail.TAG)" editable-text="detail.DATA" ng-show="detail.EDIT"  e-required >{{ detail.DATA || "Please update" }}</a> 
                                                            <span   ng-show="!detail.EDIT">{{ detail.DATA || "N/A" }}</span>
                                                         </span>
                                                         <span class="col-xs-4 col-sm-3 hidden-xs "> 
                                                            <a  uib-tooltip="The {{detail.TAG}} field can be edited. Just click to edit." ng-show="detail.EDIT" class="text-success"><span class="fa fa-pencil"></span> Edit<span >  </span></a>
                                                         </span>
                                           		</div>
												
                                            	
                                                
                                        </div><!--- / account --->
                                      
                                        
                                    </div><!--- / account menu row--->
                                    
                                    
                                    
                                    
                                   
                                    <div class="row"  ><!---policy row--->
                                                <div class="col-xs-12 col-sm-12">
                                                    <h3  style="color:#006;">
                                                    	<span class="fa-stack fa-lg">
                                                          <i class="fa fa-circle-thin fa-stack-2x"></i>
                                                          <i class="fa fa-file fa-stack-1x"></i>
                                                        </span> 
                                                        
                                                        Policy Information
                                                     </h3>
                                                     <hr class="shadowDivider"/><br/>
                                                  
                                                       <!--policyDetails array empty, server has not responded--->
                                                       <div ng-if="!policyDetails.length">
                                                       		<div class="col-xs-12">
                                                            	<h3 class="clickAndGoBlueText"><i class="fa fa-spinner fa-pulse"></i> Retrieving policy information</h3>
                                                      		</div>
                                                       </div>
                                                        <!--policyDetails has message to say there are no active policies--->
                                                       <div  ng-if = "policyDetails[0].MESSAGE">
                                                       	<div class="col-xs-12">
                                                        	<h3>{{policyDetails[0].MESSAGE}}</h3>
                                                      	</div>
                                                      </div>
                                  
                                                      <uib-accordion ng-if="policyDetails.length && !policyDetails[0].MESSAGE" class="fadeIn">
                                                         
                                                              <span ng-repeat="inTwo in policyDetails">
                                                                <uib-accordion-group  is-open="inTwo.POS"  panel-class="panel-clickAndGo" >
                                                                  <uib-accordion-heading >
                                                                      <span class="accordianPolicyHeading"    >
                                                                      	
                                                                        <span class="hidden-xs">view <i class="fa fa-chevron-circle-down"></i> |</span> 
                                                                        <i class="{{inTwo.ICON }}"></i> 
                                                                        {{inTwo.HEADING}} 
                                                                        
                                                                        

                                                                      </span>
                                                                      <a ng-show="inTwo['renewal'].length && !inTwo['renewal'][0].MESSAGE" class="pull-right clickAndGoYellowText"   href ng-click="renewPolicy(inTwo.DATA, inTwo['renewal'][0].RNWL, inTwo['renewal'][0].TERRITORY, inTwo['renewal'][0].PLAN, inTwo.BRANCH)">
                                                                        Click to {{inTwo['renewal'][0].TAG}} 
                                                                     </a>
                                                                  </uib-accordion-heading>
                                                                  <div class="row"  >
                                                                  	<span class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
                                                                    	<h4  class="text-info hidden-xs">Policy Summary</h4>
                                                                        <hr class="hidden-xs hidden-sm"/>
                                                                        
                                                                        <div class="row"  ng-repeat="inThree in inTwo.DETAILS" >
                                                                            
                                                                            <span class="col-xs-5 col-sm-4 hidden-xs" style="color: #003; line-height:2.5em">
                                                                                {{inThree.TAG}}:
                                                                             </span>
                                                                             <span class="col-xs-5 col-sm-4 visible-xs" style="color: #003;">
                                                                                {{inThree.TAG}}:
                                                                             </span>
                                                                             <span class="text-info  col-xs-7 col-sm-8" > 
                                                                                {{inThree.DATA || "N/A"}}
                                                                             </span>
                                                                             <!---
                                                                             Policy information will be displayed here. Not needed for testing
                                                                             <br/>
																			 --->
                                                                             
                                                                             <br/>
                                                                         </div>
                                                                         <br /> 
                                                                         <button type="button" class="btn btn-clickAndGoBlue btn-lg btn-block" ng-click="displayLimits(inTwo.DATA)" ng-show="inTwo.limits"><span class="hidden-xs">View the </span>Limits of Liability</button>
                                                                        
                                                                     </span>
                                                                     
                                                                     <hr class="visible-xs" />
                                                                     <span class="text-info col-xs-12 col-sm-12 col-md-6 col-lg-6">
                                                                            <br class="visible-xs  visible-sm"/>
                                                                            
                                                                     		 <uib-alert  class="slideIn" type="default" ng-show="showRiskTabHelp && inTwo.risks.length > 1" close="showRiskTabHelp = false" ng-init="showRiskTabHelp=true">
                                                                             	<i class="fa fa-info-circle"></i> This policy has {{inTwo.risks.length}} risks. The details are below. Click on the tabs to switch between details.
                                                                             </uib-alert>
                                                                             <uib-alert  class="slideIn" type="default" ng-show="showOneRiskTabHelp && inTwo.risks.length < 2" close="showOneRiskTabHelp = false" ng-init="showOneRiskTabHelp=true">
                                                                             	<i class="fa fa-info-circle"></i> This policy has {{inTwo.risks.length}} risk. Your risk summary is shown below
                                                                             </uib-alert>
                                                                            <uib-tabset class="tab-animation">
                                                                                <uib-tab ng-repeat="risk in inTwo.risks" heading="{{risk.POS}}" >
                                                                                    
                                                                                    <uib-alert  type="warning">
                                                                                    	{{risk.HEADING}}
                                                                                    </uib-alert>
                                                                                    
                                                                                    <div class="row" ng-repeat="riskItem in risk.DETAILS">
                                                                                   
                                                                                        <span style="color: #003" class="col-xs-5 col-sm-6 col-md-6">
                                                                                            {{riskItem.TAG}}:
                                                                                        </span>
                                                                                        <span class="col-xs-7 col-sm-6 col-md-6 col-lg-6"> 
                                                                                            {{riskItem.DATA}}
                                                                                         </span>
                                                                                    </div>
                                                                                    <div class="row" ng-show="risk.addons">
                                                                                        <span style="color: #003" class="col-xs-5 col-sm-6">
                                                                                            Signature Options:
                                                                                        </span>
                                                                                        <span class="col-xs-7 col-sm-6"> 
                                                                                            <a href ng-click="displayAddons(risk.DATA)" > View additional benefits</a>
                                                                                         </span>
                                                                                    </div>
                                                                                    <br class="" />
                                                                                     <a ng-show="inTwo['renewal'][0].MESSAGE" >
                                                                                    	{{inTwo['renewal'][0].MESSAGE}} 
                                                                                     </a>
                                                                                     <a ng-show="inTwo['renewal'].length && !inTwo['renewal'][0].MESSAGE" class="pull-right  btn btn-clickAndGoYellow btn-lg "   href ng-click="renewPolicy(inTwo.DATA, inTwo['renewal'][0].RNWL, inTwo['renewal'][0].TERRITORY, inTwo['renewal'][0].PLAN, inTwo.BRANCH)">
                                                                                     	Click to {{inTwo['renewal'][0].TAG}} 
                                                                                        <span class="fa-stack ">
                                                                                          <i class="fa fa-circle-thin fa-stack-2x"></i>
                                                                                          <i class="fa fa-arrow-right fa-stack-1x"></i>
                                                                                        </span>
                                                                                     </a>
                                                                             
                                                                                    
                                                                                </uib-tab>
                                                                            </uib-tabset>
                                                                     </span>
                                                                     <span class="col-xs-12 text-danger" >
                                                                     	<br/>
                                                                     	<i class="fa fa-exclamation-triangle" aria-hidden="true"></i> If you would like to make any changes or corrections to your policy before proceeding with your renewal, Live Chat with us, call us at 1-888-920-ICWI (4294) or email us at customercare@icwi.com and a Representative will be happy to assist. 
                                                                     </span>
                                                                  </div>
                                                                </uib-accordion-group>
                                                          </span>  
                                                      </uib-accordion>
                                                 </div>
                                    </div> <!---/ policy row--->
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                             