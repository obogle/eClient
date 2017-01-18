


   

                                    <div class="row" >
                                        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" > 
                                            <div id="policyAlerts" style="margin-top:20px;">
                                            
                                            </div>
                                        </div>
                                    </div>
                                    
                                    
                                    <br/>
                                   
                                   
                                                         
                                    <div class="row"  ><!---policy row--->
                                                	<h3  style="color:#006;">
                                                    <span class="fa-stack fa-lg">
                                                      <i class="fa fa-circle-thin fa-stack-2x"></i>
                                                      <i class="fa fa-file fa-stack-1x"></i>
                                                    </span>
                                                    Your Transactions</h3>
                                                    <hr/>
                                                    
                                                    <br/>
                                                       <!--transactionDetails array empty, server has not responded--->
                                                       <div ng-if="!transactionDetails.length">
                                                            <div class="col-xs-12">
                                                                <h3 class="clickAndGoBlueText"><i class="fa fa-spinner fa-pulse"></i> Retreiving your transactions</h3>
                                                            </div>
                                                       </div>
                                                        <!--transactionDetails has message to say there are no active policies--->
                                                       <div  ng-if = "transactionDetails[0].MESSAGE">
                                                        <div class="col-xs-12">
                                                            <uib-alert  type="warning">
                                                                 <i class="fa fa-exclamation-triangle"></i> {{transactionDetails[0].MESSAGE}}
                                                            </uib-alert>
                                                        </div>
                                                      </div>
                                  
                                                      <uib-accordion ng-if="transactionDetails.length && !transactionDetails[0].MESSAGE" class="fadeIn">
                                                              <span ng-repeat="inTwo in transactionDetails">
                                                                <uib-accordion-group  is-open="inTwo.POS"  panel-class="panel-clickAndGo">
                                                                  <uib-accordion-heading  ng-init="getDocument(inTwo.POLICY, inTwo.PERIOD)"    >
                                                                  	<span class="accordianPolicyHeading">
                                                                      	<i class="{{inTwo.ICON }}"></i> {{inTwo.HEADING}}<span class="hidden-xs"> |  {{inTwo.DATE}}</span>
                                                                        
                                                                        <span class="pull-right hidden-xs">
                                                                        	{{inTwo.TOTAL}}
                                                                        </span>
                                                                  	</span>
                                                                  </uib-accordion-heading>
                                                                 
                                                                  <span ng-repeat="status in inTwo.status track by $index">
                                                                      <uib-progressbar  ng-if="status.DEFAULT" class="progress-striped active" value="status.BAR" type="primary" style="margin:-15px;">
                                                                        <b><span class="hidden-xs">{{status.BAR}}% complete</span></b>
                                                                      </uib-progressbar>
                                                                  </span>
                                                                  <br/>
                                                                    <div id="progressTitles" style="margin:-15px;">
                                                                        <table id="progressTitlesTable" >
                                                                            <tr >
                                                                                <td ng-repeat="status in inTwo.status track by $index" width="{{100 / inTwo.status.length}}%" >
                                                                                    <span class="text-{{status.PROGRESS}}">{{status.NAME}}</span>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </div>
                                                                    <br/>
                                                                  <br/>
                                                                  <div class="row"  >
                                                                  	<span class="col-xs-12 col-sm-8">
                                                                    	<h4  class="text-info hidden-xs"><i class="{{inTwo.ICON }}"></i> Transaction Details</h4>
                                                                        <hr class="hidden-xs hidden-sm"/>
                                                                        <div class="row"  ng-repeat="inThree in inTwo.DETAILS" >
                                                                            <span class="col-xs-6 col-sm-4 col-md-4 col-lg-4" style="color: #003">
                                                                                {{inThree.TAG}}:
                                                                             </span>
                                                                             <span class="text-info  col-xs-6 col-sm-8 col-md-8 col-lg-8" > 
                                                                                {{inThree.DATA || "N/A" }}
                                                                             </span>
                                                                             <br/>
                                                                             <hr class="visible-xs"/>
                                                                         </div>
                                                                         <div class="row"  > 
                                                                             <span class="col-xs-6 col-sm-4 col-md-4 col-lg-4" style="color: #003">
                                                                                Delivery Method:
                                                                             </span>
                                                                             <span class="text-info  col-xs-6 col-sm-8 col-md-8 col-lg-8" > 
                                                                                <a href ng-click="showDeliveryDetails = showDeliveryDetails == true ? false : true;" ng-init="showDeliveryDetails = false">{{inTwo.METHOD}} (click for details)</a>
                                                                             </span>
                                                                         </div>
                                                                        
                                                                         <uib-alert   class="row col-sm-8 col-sm-offset-4 fadeIn" type="warning" ng-show="showDeliveryDetails" >
                                                                             <span  class="text-darkBlue" ><i class="fa fa-truck"></i> Your delivery/ pick up information</span>
                     														 <hr/>
                                                                             <div ng-repeat="inFour in inTwo.DELIVERY" > 
                                                                                <span class="col-xs-6 col-sm-4 col-md-4 col-lg-4" style="color: #003">
                                                                                    {{inFour.TAG }}:
                                                                                 </span>
                                                                                 <span class="text-info  col-xs-6 col-sm-6 col-md-6 col-lg-6" > 
                                                                                    
                                                                                    <span ng-bind-html="inFour.DATA | newline"></span>
                                                                                 </span>
                                                                             </div>
                                                                        </uib-alert>
                                                                         <br/>
                                                                         
                                                                         <div class="row"> 
                                                                             <span class="col-xs-6 col-sm-4 col-md-4 col-lg-4 hidden-xs" style="color: #003">
                                                                                Transaction Total:
                                                                             </span>
                                                                             <span class="text-info  col-xs-12 col-sm-8 col-md-8 col-lg-8" > 
                                                                                <button type="button" class="btn btn-success btn-lg  hidden-xs" ng-click="showPaymentDetails = showPaymentDetails == true ? false : true;" ng-init="showPaymentDetails = false">{{inTwo.TOTAL}} (click for details)</button>
                                                                             	 <a href  class="visible-xs btn btn-success btn-sm" ng-click="showPaymentDetails = showPaymentDetails == true ? false : true;" ng-init="showPaymentDetails = false">{{inTwo.TOTAL}} (click for details)</a>
                                                                             </span>
                                                                         </div>
                                                                         <br/>
                                                                         <uib-alert   class="row col-sm-8 col-sm-offset-4 fadeIn" type="warning" ng-show="showPaymentDetails" >
                                                                             <span  class="text-darkBlue" ><i class="fa fa-shopping-cart"></i> Payment Breakdown</span>
                     														 <hr/>
                                                                             <div ng-repeat="inFour in inTwo.PAYMENT" > 
                                                                                <span class="col-xs-6 col-sm-4 col-md-4 col-lg-4" style="color: #003">
                                                                                    {{inFour.TAG }}:
                                                                                 </span>
                                                                                 <span class="text-info  col-xs-6 col-sm-6 col-md-6 col-lg-6" > 
                                                                                    
                                                                                    <span ng-bind-html="inFour.DATA | newline"></span>
                                                                                 </span>
                                                                             </div>
                                                                        </uib-alert>
                                                                     </span>
                                                                     <hr class="visible-xs" />
                                                                     <span class="text-info col-xs-12 col-sm-4">
                                                                     		 <uib-alert  type="warning" ng-show="document_header">
                                                                             	<i class="fa fa-info-circle"></i> {{document_header}}
                                                                             </uib-alert>
                                                                             <a ng-click="openPDF(documentLink)" ng-if="documentLink" > <img ng-src="{{documentToShow}}" /></a>
                                                                             <a  ng-if="!documentLink" > <img ng-src="{{documentToShow}}" /></a>
                                                                     </span>
                                                                  </div>
                                                                  <!---  Client files --->
                                                                   <div class="row" >
                                                                   		<div class="col-xs-12" ng-show="inTwo.supporting.length || inTwo.uploads.length || inTwo.receipt.length ">
                                                                            <br/>
                                                                            <h4  class="text-info hidden-xs">Documents associated with this transaction</h4>
                                                                            <hr class="shadowDivider hidden-xs hidden-sm"/>
                                                                            <div class="col-sm-4 text-center"  ng-repeat="file in inTwo.supporting">
                                                                                <a href ng-click="openPDF(file.LINK)"><i class="fa fa-files-o fa-3x"></i><br/>{{file.NAME}}</a>
                                                                            </div>
                                                                            <div class="col-sm-4 text-center"  ng-repeat="file in inTwo.uploads">
                                                                                <a href ng-click="openPDF(file.LINK)"><i class="fa fa-file-o fa-3x"></i><br/>{{file.NAME}}</a>
                                                                            </div>
                                                                            <div class="col-sm-4 text-center"  ng-repeat="file in inTwo.receipt">
                                                                                <a href ng-click="openPDF(file.LINK)"><i class="fa fa-file-pdf-o fa-3x"></i><br/>{{file.NAME}}</a>
                                                                            </div>
                                                                    	</div>
                                                                    </div>
                                                                     <!--- / Client files --->
                                                                </uib-accordion-group>
                                                          </span>  
                                                      </uib-accordion>
                                    </div> <!---/ policy row--->
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                             