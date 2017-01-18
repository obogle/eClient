<form class="form-horizontal paymentForm" name="paymentForm" novalidate>
     <uib-accordion close-others="true">
        <!---is-disabled="accordianStatus.isDeliveryOptionsDisabled"--->
     	<uib-accordion-group panel-class="panel-plain" is-open="accordianStatus.isDeliveryOptionsOpen"  ng-if="deliveryOptions.length > 1"><!---Delivery Options accordian group--->
        	 <uib-accordion-heading >
                  <div class="row" ng-show="deliveryOptions.length">
                        <div class="col-xs-12  col-sm-12  col-md-12  col-lg-12 ">  
                            <h4 class="text-darkBlue"  >
                                <span class="fa-stack fa-lg">
                                  <i class="fa fa-circle-thin fa-stack-2x"></i>
                                  <i class="fa fa-car fa-stack-1x"></i>
                                </span> 
                                Delivery Options 
                            </h4>
                         </div>
                    </div>
                  
              </uib-accordion-heading>
              
            <div ng-show="deliveryOptions.length > 1"><!---delivery details--->
            <br />
            <h4>How would you like to get your document?</h4>
            <br/>
                <!--
                <div class="row" ng-show="deliveryOptions.length">
                    <div class="col-xs-12  col-sm-12  col-md-12  col-lg-12 ">  
                        <h3 class="text-darkBlue"  >
                            <span class="fa-stack fa-lg">
                              <i class="fa fa-circle-thin fa-stack-2x"></i>
                              <i class="fa fa-car fa-stack-1x"></i>
                            </span> 
                            Delivery Options 
                        </h3>
                        <hr class="shadowDivider"/>
                     </div>
                </div>
                -->
                
                    
                <div class="row" ng-init=" wantsDelivered = 'true'" ><!---delivery option---> 
                    <a href   ng-repeat="deliveryOption in deliveryOptions" class="paymentOptionDiv" > 
                     <div class="col-xs-12 col-sm-{{12 / deliveryOptions.length}} col-md-{{12 / deliveryOptions.length}} col-lg-{{12 / deliveryOptions.length}}" ng-class="{'selectedDiv': selectedDeliveryOption == '{{deliveryOption.OPTIONS}}'}"  ng-click="changeDeliveryOption(deliveryOption.OPTIONS, deliveryOption.ID)" >   
                        <h4>
                            <span ng-show=" selectedDeliveryOption == '{{deliveryOption.OPTIONS}}'">
                                <i style="color:#90D280;" class="fa fa-check-circle-o"></i> 
                            </span>
                            <span ng-show=" selectedDeliveryOption != '{{deliveryOption.OPTIONS}}'">
                                <i class="{{deliveryOption.ICON}}"></i> 
                            </span>
                            {{deliveryOption.HEADING}}
                            <span ng-show=" selectedDeliveryOption == '{{deliveryOption.OPTIONS}}'">
                                selected
                            </span>
                        </h4>
                        <span style="font-size:12px;" ng-show=" selectedDeliveryOption != '{{deliveryOption.OPTIONS}}'"><i class="fa fa-exclamation-circle"></i> Click to choose this option</span>
                       <br/>
                        <span class="hidden-xs">
                            {{deliveryOption.DETAILS}}
                        </span>
                        <span class="visible-xs" ng-show=" selectedDeliveryOption == '{{deliveryOption.OPTIONS}}'">
                            {{deliveryOption.DETAILS}}
                        </span>
                     </div>
                   </a>
                 </div><!---/ delivery option--->
            
            
            <br/>
            
            </div><!---/ delivery details--->
            
            
        </uib-accordion-group><!---/ Delivery Options accordian group--->
        <uib-accordion-group panel-class="panel-plain" is-open="deliveryOptions.length <= 1"><!---Document Collection accordian group--->
        	<uib-accordion-heading >
                <div class="row">
                    <div class="col-xs-12  col-sm-12  col-md-12  col-lg-12 ">  
                        <h4 class="text-darkBlue"  >
                            <span class="fa-stack fa-lg">
                              <i class="fa fa-circle-thin fa-stack-2x"></i>
                              <i class="fa fa-file-text fa-stack-1x"></i>
                            </span> 
                            Document Collection
                        </h4>
                     </div>
                </div>
            </uib-accordion-heading >
            <div class="row" ><!--- collection and payment info--->
                  
                 <div class="col-xs-12  col-sm-12 col-md-7 text-left" > <!---shippind address branch pic up row--->
                    <div ng-show ="selectedDeliveryOption == 'DL'" class="fadeIn"> <!--- delivery place--->
                            <span class="text-darkBlue"><i class="fa fa-motorcycle"></i> Delivery Address</span>
                            <hr/>
                            
                           
                          <div class="form-group">
                                <div ng-show="paymentForm.$submitted || paymentForm.deliveryName.$touched"  class="text-danger">
                                    <!---|| paymentForm.deliveryName.$error.pattern--->
                                  <div ng-show="paymentForm.deliveryName.$error.required "><i class="fa fa-asterisk"></i> Delivery name is required</div>
                                </div>
                                <span for="cardNum" class="col-sm-4 control-span">Name:</span>
                                <div class="col-sm-8">
                                    <!---ng-pattern="/^[A-Za-z\- ]+$/"---> 
                                    <input type="text" class="form-control" ng-model="paymentInfo.deliveryName" name="deliveryName" placeholder="Name" ng-required ="selectedDeliveryOption == 'DL'">
                                </div>
                          </div>
                          
                           <div class="form-group">
                                <div ng-show="paymentForm.$submitted || paymentForm.address1.$touched"  class="text-danger">
                                  <div ng-show="paymentForm.address1.$error.required || paymentForm.address1.$error.maxlength"><i class="fa fa-asterisk"></i> Address is required (max 39)</div>
                                </div>
                                <span for="cardNum" class="col-sm-4 control-span">Address:</span>
                                <div class="col-sm-8">
                                    <input type="text" class="form-control" ng-model="paymentInfo.deliveryAddress1" name="address1" ng-maxlength="39" placeholder="Address line1 " ng-required="selectedDeliveryOption == 'DL'">
                                </div>
                          </div>
                          <div class="form-group">
                                <div ng-show="paymentForm.$submitted || paymentForm.address2.$touched"  class="text-danger">
                                  <div ng-show="paymentForm.address2.$error.required || paymentForm.address2.$error.maxlength"><i class="fa fa-asterisk"></i> Oops! The max length is 39</div>
                                </div>
                                <span for="cardNum" class="col-sm-4 control-span"><!--Address line 2:--></span>
                                <div class="col-sm-8">
                                    <input type="text" class="form-control" ng-model="paymentInfo.deliveryAddress2" name="address2" ng-maxlength="39" placeholder="Address line 2">
                                </div>
                          </div>
                          
                          <!--
                            if you want to use  parish only
                            
                          <div class="form-group">
                            <div ng-show="paymentForm.$submitted || paymentForm.city.$touched" class="text-darkBlue">
                              <div ng-show="paymentForm.city.$error.required "><i class="fa fa-asterisk"></i> Please select your parish</div>
                            </div>
                            <span for="inputPassword3" class="col-sm-4 control-span">Parish:</span>
                            <div class="col-sm-8">
                                <select class="form-control" ng-model="paymentInfo.shippingParish" name="city" ng-required="!paymentInfo.shippingBillingSame && selectedDeliveryOption == 'DL'">
                                  <option value="">Parish</option>
                                  <option ng-repeat="parish in parishes" value="{{parish.parishName}}">{{parish.parishName}}</option>
                                </select> 
                            </div>
                          </div>
                          -->
                          
                           <!--
                            if you want to use  parish and town
                           --->
                           
                          <div class="form-group">
                                <div ng-show="paymentForm.$submitted || paymentForm.shippingParish.$touched  || paymentForm.shippingTown.$touched"  class="text-danger">
                                  <div ng-show="paymentForm.shippingTown.$error.required || paymentForm.shippingParish.$error.required "><i class="fa fa-asterisk"></i> Please select your parish and town</div>
                                </div>
                                <span for="inputPassword3" class="col-sm-4 control-span">Parish & town:</span>
                                <div class="col-sm-4">
                                    <select class="form-control" ng-model="paymentInfo.shippingParish" name="shippingParish" data-ng-options="item.parishID as item.parishName for item in shippingParishes" data-ng-change="getTown(paymentInfo.shippingParish, 'true')" ng-required="selectedDeliveryOption == 'DL'">
                                      <!--<option value="">Parish</option>-->
                                      <option value="" disabled selected>--Select--</option>
                                    </select> 
                                </div>
                                <div class="col-sm-4" ng-show="towns.length">
                                    <!-- item.townName for item in towns track by item.townID returns as object-->
                                     <select class="form-control" ng-model="paymentInfo.shippingTown"   name="shippingTown" data-ng-options="item.townID as item.townName for item in towns" ng-required="selectedDeliveryOption == 'DL'">
                                        <!--<option value="">Town</option>-->
                                        <option value="" disabled selected>--Select--</option>
                                    </select> 
                                </div>
                           </div>
                           
                           <div class="form-group">
                                <span for="cardNum" class="col-sm-4 control-span sr-only">Country:</span> 
                                <div class="col-sm-8">
                                    <input type="hidden" class="form-control" ng-model="paymentInfo.country" name="card-country"  disabled>
                                </div>
                          </div>
              
                           <span ng-show ="selectedDeliveryOption == 'DL' &&  payment_code=='OP'"><input type="checkbox" name="shippingBillingSame" value="shippingBillingSame" ng-model="paymentInfo.shippingBillingSame" > My shipping address is the same as my billing address</span>      
                          <br/><br/>
                     </div><!--- / delivery place--->
                     <div ng-show ="selectedDeliveryOption == 'PU'" class="fadeIn"> <!--- pickup place--->
                        <span class="text-darkBlue"><i class="fa fa-building"></i> Pick Up Branch</span>
                        <hr/>
                        
                           <div class="alert alert-warning" ng-show="branch_contact" data-html='true'>{{branch_contact}}</div>
                           <div class="form-group col-md-12">
                                <div ng-show="paymentForm.$submitted || paymentForm.pickUpName.$touched"  class="text-danger">
                                  <!---|| paymentForm.pickUpName.$error.pattern--->
                                  <div ng-show="paymentForm.pickUpName.$error.required "><i class="fa fa-asterisk"></i> Who is picking up the document?</div>
                                </div>
                                <span for="cardNum" class="col-xs-4 col-sm-4 control-span">Person collecting:</span>
                                <div class="col-xs-8 col-sm-8 ">
                                    <!---ng-pattern="/^[A-Za-z\- ]+$/"--->
                                    <input type="text" class="form-control" ng-model="paymentInfo.pickUpName"  name="pickUpName" placeholder="Name" ng-required ="selectedDeliveryOption == 'PU'">
                                </div>
                          </div>
                          
                           <div class="form-group  col-md-12">
                                <div ng-show="paymentForm.$submitted || paymentForm.shippingBranch.$touched"  class="text-danger">
                                  <div ng-show="paymentForm.shippingBranch.$error.required"><i class="fa fa-asterisk"></i> Please select your branch</div>
                                </div>
                                <span for="cardNum" class="col-xs-4 col-sm-4 control-span">Branch:</span>
                                <div class="col-xs-8 col-sm-8 ">
                                    <select class="form-control" ng-model="paymentInfo.shippingBranch" name="shippingBranch" ng-required ="selectedDeliveryOption == 'PU'" ng-change="getBranchContact()">
                                      <option value="">Branch</option>
                                      <option ng-repeat="branch in branches" value="{{branch.branchID}}">{{branch.branchName}}</option>
                                    </select> 
                                         
                                </div>
                          </div>
                           <div class="form-group">
                               
                                <div class="col-sm-8">
                                    <input type="hidden" class="form-control" ng-model="paymentInfo.country"  name="country"  disabled>
                                </div>
                          </div>
                          
                     </div><!--- / pick up place--->
                 </div><!--- / shippind address branch pic up row--->
                 
                 <div class="row"> <!---appointment row--->
                            <div class="col-xs-12 col-sm-12 col-md-5"><!---date stuff--->
                             <div class="col-xs-12 col-sm-12">
                                <span class="text-darkBlue"><i class="fa fa-clock-o"></i> <span  ng-show ="selectedDeliveryOption == 'PU'">Pick Up</span><span  ng-show ="selectedDeliveryOption == 'DL'">Delivery</span> Date & Time</span>
                                 <hr/>
                                 <!---
                                 <div class="alert alert-info"  ng-class="{'alert-danger': outsideOpeningHours=='true' || date_past == 'true' || paymentInfo.dt ==undefined}"><span ng-show ="paymentInfo.dt !==undefined"><span class="hidden-xs">You selected </span>{{paymentInfo.dt | date:'EEE MMM d, yyyy' }} at {{paymentInfo.dt | date:'shortTime' }} </span><span ng-show ="paymentInfo.dt ==undefined"><i class="fa fa-exclamation-triangle"></i> Oops! You have cleared the date</span><br/><span ng-show ="date_past == 'true'"><i class="fa fa-exclamation-triangle"></i> Oops! That time slot has passed</span><br/><span ng-show ="outsideOpeningHours == 'true'"><i class="fa fa-exclamation-triangle"></i> We are operational Monday- Friday 8:30 am - 4:30 pm</span></div>
                                 --->   
                                <div class="col-xs-12 col-sm-12">
                                     <div ng-if="paymentInfo.dt">
                                          <div class="alert "  ng-class="{'alert-danger': !dateAvailable,'alert-warning': dateAvailable}">
                                            <span>
                                                {{dateMessage}}
                                            </span>
                                          </div>
                                     </div>      
                                   
                                      
                                     <div class="form-group">
                                        <!--- date error stuff--->
                                        <div ng-show="paymentForm.$submitted || paymentForm.paymentInfo.dt.$touched" class="text-danger">
                                          <div ng-show="paymentForm.dtErrorCheck.$error.required"><i class="fa fa-asterisk"></i> A valid date is requuired</div>
                                        </div>
                                        <!--if dateAvailable true then this is not requied ie pass validation-->
                                        <input type="hidden" ng-model="dtErrorCheck" name="dtErrorCheck"  ng-required ="!dateAvailable"/> 
                                        
                                        <div class="col-xs-7  col-sm-7 col-md-12">
                                            <p class="hidden-xs hidden-sm">	
                                                Day you want to get your document?
                                            </p>
                                            <!-- date stuff-->
                                            <br class="visible-xs visible-sm" />
                                            <p class="input-group">
                                              
                                              <input type="date" class="form-control" ng-change="timeCheck(paymentInfo.dt)"  uib-datepicker-popup ng-model="paymentInfo.dt" name="datepicker" is-open="status.opened" min-date="minDate" max-date="maxDate" datepicker-options="dateOptions" date-disabled="disabled(date, mode)" ng-required="true" close-text="Close" />
                                              <span class="input-group-btn hidden-xs">
                                                <button type="button" class="btn btn-default btn-md" ng-click="open($event)"><i class="glyphicon glyphicon-calendar"></i></button>
                                              </span>
                                            </p>
                                        </div>
                                        <div class="col-xs-5 col-sm-5 col-md-12">
                                            <p class="hidden-xs hidden-sm">
                                                Time do you want to get your document?
                                            </p>
                                            <uib-timepicker ng-model="paymentInfo.dt" name="timepicker" ng-change="timeCheck(paymentInfo.dt)" ></uib-timepicker>
                                        </div>
                                     </div>
                                     </div>
                                 </div>
                            </div><!--- / date stuff--->
                </div><!--- / appointment row--->
  
			</div><!--- / collection and payment info--->
        </uib-accordion-group><!---/ Document Collection accordian group--->
        <uib-accordion-group panel-class="panel-plain" heading="Payment" is-open="accordianStatus.isPaymentOpen"><!---Payment accordian group--->
        	<uib-accordion-heading >
                <div class="row">
                    <div class="col-xs-12  col-sm-12  col-md-12  col-lg-12 ">  
                        <h4 class="text-darkBlue"  >
                            <span class="fa-stack fa-lg">
                              <i class="fa fa-circle-thin fa-stack-2x"></i>
                              <i class="fa fa-usd fa-stack-1x"></i>
                            </span> 
                            Payment
                        </h4>
                     </div>
                </div>
            </uib-accordion-heading >
            <!---payment details--->
            <div class="row">
                <div class="col-md-7" ng-if="payment_code=='PP'"><!---phone payment stuff---><!---pay ny phone has ID 3 and code PP--->
                        <span class="text-darkBlue"><i class="fa fa-phone"></i> Contact Details</span>
                        <hr/>
                        Please provide us with a phone number to contact you to collect your payment details. Just in case you need us, call 1-888-920-(ICWI).
                        <br/>
                        <div class="col-xs-12" >
                           <div class="form-group">
                                <div ng-show="paymentForm.$submitted || paymentForm.payByPnhoneNumber.$touched"  class="text-danger">
                                  <div ng-show="paymentForm.payByPnhoneNumber.$error.required || paymentForm.payByPnhoneNumber.$error.pattern || paymentForm.payByPnhoneNumber.$error.maxlength || paymentForm.payByPnhoneNumber.$error.minlength"><i class="fa fa-asterisk"></i> Phone number required. Format: xxx-xxx-xxxx<br/>Remeber area code for example 876 for Jamaica</div>
                                </div>
                                 <input type="text" class="form-control" ng-model="paymentInfo.payByPnhoneNumber" name="payByPnhoneNumber" ng-pattern="/^\(?(\d{3})\)?[-]?(\d{3})[-]?(\d{4})$/"  ng-maxlength="12" ng-minlength="12" placeholder="xxx-xxx-xxxx" ng-required="payment_code=='PP'"> 
                          </div>
                          
                       </div>
                 </div><!--- / phone payment  stuff--->
                <div class="col-md-7" ng-if="payment_code=='OP'"><!---pay online has ID 1--->
                    <div class="col-xs-12  col-sm-12 fadeIn"  > <!---billing address row---> 
                            <span  class="text-darkBlue" ><i class="fa fa-home"></i> Billing Address</span>
                            <hr/>
                            <div ng-show="paymentInfo.shippingBillingSame" class="fadeIn"> 
                                Ok! We will bill to your shipping address
                                <br/><br/>
                                <b>Name:</b> {{paymentInfo.deliveryName || 'Please enter name in billing'}}
                                </br>
                                <b>Address:</b> {{paymentInfo.deliveryAddress1 || 'Please enter main address in billing'}} {{paymentInfo.deliveryAddress2}}
                            </div>
                            <div ng-show="!paymentInfo.shippingBillingSame"> 
                                 <div class="form-group">
                                        <div ng-show="paymentForm.$submitted || paymentForm.cardname.$touched"  class="text-danger">
                                          <div ng-show="paymentForm.cardname.$error.required || paymentForm.cardname.$error.maxlength"><i class="fa fa-asterisk"></i> Name as it appears on card is required (max 39)</div>
                                        </div>
                                        <span for="cardNum" class="col-sm-4 control-span">Name on card:</span>
                                        <div class="col-sm-8">
                                            <input type="text" class="form-control" ng-model="paymentInfo.cardname" name="cardname"  placeholder="Billing Name"  ng-maxlength="39" ng-required="!paymentInfo.shippingBillingSame && payment_code=='OP'">
                                            <input type="hidden" class="form-control"  name="card-name"  value="{{paymentInfo.cardname}}" disabled>
                                            
                                        </div>
                                  </div>
                                   <div class="form-group">
                                        <div ng-show="paymentForm.$submitted || paymentForm.cardaddress1.$touched"  class="text-danger">
                                          <div ng-show="paymentForm.cardaddress1.$error.required || paymentForm.cardaddress1.$error.maxlength"><i class="fa fa-asterisk"></i> Address is required (max 39)</div>
                                        </div>
                                        <span for="cardNum" class="col-sm-4 control-span">Address:</span>
                                        <div class="col-sm-8">
                                            <input type="text" class="form-control" ng-model="paymentInfo.addr1" name="cardaddress1" placeholder="Address line1 " ng-maxlength="39"  ng-required="!paymentInfo.shippingBillingSame && payment_code=='OP'">
                                            <input type="hidden" class="form-control"  name="card-address1"  value="{{paymentInfo.addr1}}" disabled>
                                        </div>
                                  </div>
                                  <div class="form-group">
                                        <div ng-show="paymentForm.$submitted || paymentForm.cardaddress2.$touched"  class="text-danger">
                                          <div ng-show="paymentForm.cardaddress2.$error.required || paymentForm.cardaddress2.$error.maxlength"><i class="fa fa-asterisk"></i> Oops! The max length is 39</div>
                                        </div>
                                        <span for="cardNum" class="col-sm-4 control-span"><!--Address line 2:--></span>
                                        <div class="col-sm-8">
                                            <input type="text" class="form-control" ng-model="paymentInfo.addr2" name="cardaddress2" placeholder="Address line 2" ng-maxlength="39">
                                            <input type="hidden" class="form-control"  name="card-address2"  value="{{paymentInfo.addr2}}" disabled>
                                        </div>
                                  </div>
                                  <!--
                                  if you want to use  parish only
                                  
                                  <div class="form-group">
                                        <div ng-show="paymentForm.$submitted || paymentForm.cardcity.$touched" class="text-darkBlue">
                                          <div ng-show="paymentForm.cardcity.$error.required "><i class="fa fa-asterisk"></i> Please select your parish</div>
                                        </div>
                                        <span for="inputPassword3" class="col-sm-4 control-span">Parish:</span>
                                        <div class="col-sm-8">
                                            <select class="form-control" ng-model="paymentInfo.billingParish" name="cardcity" ng-required="payment_code=='OP'">
                                              <option value="">Parish</option>
                                              <option ng-repeat="parish in parishes" value="{{parish.parishName}}">{{parish.parishName}}</option>
                                            </select> 
                                            <input type="hidden" class="form-control"  name="card-city"  value="{{paymentInfo.billingParish}}" disabled>
                                        </div>
                                   </div>
                                  -->
                                  
                                  <!--
                                  if you want to use both parish and town
                                  
                                  
                                  <div class="form-group">
                                        <div ng-show="paymentForm.$submitted || paymentForm.billingParish.$touched  || paymentForm.billingTown.$touched" class="text-darkBlue">
                                          <div ng-show="paymentForm.billingTown.$error.required || paymentForm.billingParish.$error.required "><i class="fa fa-asterisk"></i> Please select your parish and town</div>
                                        </div>
                                        <span for="inputPassword3" class="col-sm-4 control-span">Parish & town:</span>
                                        <div class="col-sm-4">
                                            <select class="form-control" ng-model="paymentInfo.billingParish" name="billingParish" data-ng-options="item.parishName for item in billingParishes track by item.parishID " data-ng-change="getTown(paymentInfo.shippingParish.parishID, 'false')" required>
                                              <option value="">Parish</option>
                                            </select> 
                                        </div>
                                        <div class="col-sm-4" ng-show="towns.length">
                                             <select class="form-control" ng-model="paymentInfo.billingTown"  name="billingTown" data-ng-options="item.townName for item in towns track by item.townID" required>
                                                <option value="">Town</option>
                                            </select> 
                                        </div>
                                   </div>
                                   
                                   <div class="form-group">
                                        <span for="cardNum" class="col-sm-4 control-span sr-only">Country:</span> 
                                        <div class="col-sm-8">
                                            <input type="hidden" class="form-control" ng-model="paymentInfo.country" name="card-country"  disabled>
                                        </div>
                                  </div>
                                  -->
                               </div>
                               
                               
                         <br/>
                     </div><!--- / billing address row--->
                     
                     <div class="col-xs-12 col-sm-12" ng-if="payment_code=='OP'"> <!---card form---> <!---pay online has ID 1--->
                                     
                                     
                                         
                                 <span  class="text-darkBlue" ><i class="fa fa-credit-card"></i> Credit Card Details</span>
                                 <hr/>
                                 <uib-alert  type="danger" ng-show="showFinalPaymentMessage"><i class="fa fa-info-circle"></i> {{showFinalPaymentMessage}}</uib-alert>
                                 
                                 <input type="hidden" class="form-control" name="customname1"  value="customerNumber" disabled>     
                                 <input type="hidden" class="form-control" name="customvalue1"  value="{{clientNo}}" disabled>   
                                 
                                 
                                  <div class="form-group">
                                    <div ng-show="paymentForm.$submitted || paymentForm.cardNumber.$touched"  class="text-danger">
                                      <div ng-show="paymentForm.cardNumber.$error.required  || paymentForm.cardNumber.$error.pattern || paymentForm.cardNumber.$error.maxlength"><br/><i class="fa fa-asterisk"></i> Card number is required <br class="visible-xs" />(numeric characters only. Max 16)</div>
                                    </div>
                                    <span for="cardNum" class="col-sm-4 control-span">Card Number:</span>
                                    <div class="col-sm-6">
                                      <input type="text" class="form-control" ng-model="paymentInfo.cardNumber" name="cardNumber" ng-pattern="/^[0-9]+$/"  ng-maxlength="16" placeholder="Card Number" ng-required="payment_code=='OP'">
                                      <input type="hidden" class="form-control"  name="card-number" >
                                    </div>
                                    <div class="col-sm-2 hidden-xs">
                                        <img src="http://www.tomnjerrys.net/wp-content/uploads/2013/06/MasterCard-credit-cards-and-Visa-If-you-apply-for-both.jpg" />
                                    </div>
                                  </div>
                                  
                                  <div class="form-group">
                                    <div ng-show="paymentForm.$submitted || paymentForm.cardcvv.$touched" class="text-danger">
                                      <div ng-show="paymentForm.cardcvv.$error.required  || paymentForm.cardcvv.$error.pattern || paymentForm.cardcvv.$error.maxlength"><i class="fa fa-asterisk"><br/></i> Card CVV number is required  <br class="visible-xs" />(numeric characters only. Max 4)</div>
                                    </div>
                                    <span for="inputPassword3" class="col-xs-6 col-sm-4 control-span">Security Code:<a href uib-popover="CVV is the three digit code on the back of your credit card" class="visible-xs" popover-trigger="mouseenter"  popover-placement="top"><i  class="fa fa-question-circle"></i> What is this?</a> </span>
                                    <div class="col-xs-6 col-sm-4">
                                      <input type="text" class="form-control" ng-model="paymentInfo.cardcvv" name="cardcvv" ng-pattern="/^[0-9]+$/"  ng-maxlength="4" placeholder="Card CVV" ng-required="payment_code=='OP'">
                                      <input type="hidden" class="form-control"  name="card-cvv" >
                                      
                                    </div>
                                    <div class="col-sm-4">
                                      <a href uib-popover="CVV is the three digit code on the back of your credit card" popover-trigger="mouseenter" class="hidden-xs" popover-placement="top"><i  class="fa fa-question-circle"></i> What is this?</a>
                                    </div>
                                  </div>
                                  <div class="form-group">
                                    <span for="inputPassword3" class=" col-xs-12 col-sm-4 col-md-14 col-lg-4 control-span">Expiration Date:</span>
                                    <div class="col-xs-6 col-sm-4 col-md-14 col-lg-4 text-danger" >
                                      <div ng-show="paymentForm.$submitted || paymentForm.cardExpMonth.$touched" class="text-danger">
                                        <div ng-show="paymentForm.cardExpMonth.$error.required  || paymentForm.cardExpMonth.$error.pattern || paymentForm.cardExpMonth.$error.maxlength || paymentForm.cardExpMonth.$error.minlength || paymentForm.cardExpMonth.$error.max"><i class="fa fa-asterisk"></i>Day required <br/>2 Didgets only</div>
                                      </div>
                                      <input type="text" class="form-control" ng-model="paymentInfo.cardExpMonth" name="cardExpMonth" placeholder="mm"  ng-pattern="/^[0-9]+$/"  ng-maxlength="2" ng-max="31"  ng-minlength="2" ng-required="payment_code=='OP'"> 
                                    </div>
                                    <div class="col-xs-6 col-sm-4 col-md-14 col-lg-4 text-danger">
                                      <div ng-show="paymentForm.$submitted || paymentForm.cardExpYear.$touched" class="text-danger">
                                        <div ng-show="paymentForm.cardExpYear.$error.required  || paymentForm.cardExpYear.$error.pattern || paymentForm.cardExpYear.$error.maxlength || paymentForm.cardExpYear.$error.minlength || paymentForm.cardExpYear.$error.max"><i class="fa fa-asterisk"></i> Year required  <br/>2 Digits only</div>
                                      </div>
                                      <input type="text" class="form-control"  ng-model="paymentInfo.cardExpYear" name="cardExpYear" placeholder="yy"  ng-maxlength="2"  ng-minlength="2" ng-max="12" ng-required="payment_code=='OP'">
                                    </div>
                                 </div>
                                <input type="hidden" class="form-control"  name="card-exp" ng-model="paymentInfo.cardexp" value="{{paymentInfo.cardExpMonth}}/{{paymentInfo.cardExpYear}}" disabled>
                            </div><!---card form--->
                      </div>          
                     <div class="col-xs-12 col-sm-12 col-md-5 "> <!---payment pannel row--->
                             <br class="visible-xs visible-sm"/>
                             <div class="panel panel-primary" ><!---payment pannel--->
                              <div class="panel-heading" style="background-color: #000066">Payment Summary</div>
                              <div class="panel-body">
                                <div class="row hidden-xs">
                                    <div class="col-xs-12 col-sm-5">
                                        <span class="text-primary" style="">Premium:</span> 
                                    </div>
                                    <div class="col-xs-12 col-sm-7">
                                        {{paymentInfo.premWithoutGCT | currency}}
                                        <input type="hidden" ng-model="paymentInfo.premWithoutGCT" value="" />
                                    </div>
                                </div>
                                <div class="row hidden-xs">
                                    <div class="col-xs-12 col-sm-5">
                                        <span class="text-primary" style="">{{miscText}}</span> 
                                    </div>
                                    <div class="col-xs-12  col-sm-7">   
                                        {{paymentInfo.miscFee | currency}} 
                                        <input type="hidden" ng-model="paymentInfo.miscFee" value="" />
                                        <input type="hidden" ng-model="paymentInfo.miscText" value="" />
                                    </div>
                                </div>
                                
                                <div class="row hidden-xs" >
                                    <div class="col-xs-12 col-sm-5">
                                        <span class="text-primary" style="">Service Fee:</span> 
                                    </div>
                                    <div class="col-xs-12 col-sm-7">   
                                        {{paymentInfo.serviceFee | currency}} 
                                        <input type="hidden" ng-model="paymentInfo.serviceFee" value="" />
                                    </div>
                                </div>
                                <div class="row hidden-xs">
                                    <div class="col-xs-12 col-sm-5">
                                        <span class="text-primary" style="">{{tax_label}}:</span> 
                                    </div>
                                    <div class="col-xs-12  col-sm-7">   
                                        {{paymentInfo.GCT | currency}}
                                         <input type="hidden" ng-model="paymentInfo.GCT"  value="" name="tax"/>
                                    </div>
                                    <hr/>    
                                </div>
                                
                                <div class="row">
                                    <div class="col-xs-6 col-sm-5">
                                        <span class="text-primary">Amount Due:</span> 
                                    </div>
                                    <div class="col-xs-6  col-sm-7">  
                                    
                                        <span class="text-success lead"> {{paymentInfo.amtDue | currency}} {{paymentInfo.currency}}</span>
                                        <input type="hidden" ng-model="paymentInfo.amtDue" value="" name="card-amount" />
                                        <input type="hidden" ng-model="paymentInfo.currency" value=""  name="paymentCurrency" />
                                        
                                        
                                        <input type="hidden" name="askamtflg" value="1">
                                        <input type="hidden" name="card-allowed" value="Visa,Mastercard,Amex,Discover">
                                        <input type="hidden" name="comments" value=" ">
                                        <input type="hidden" name="currency" value="jmd">
                                        <input type="hidden" name="currency_symbol" value="JMD">
                                        <input type="hidden" name="easycart" value="0">
                                        <input type="hidden" name="order-id" value="39150350015 ">
                                        <input type="hidden" name="publisher-email" value="amorgan@icwi.com">
                                        <input type="hidden" name="publisher-name" value="icwi">
                
                                    </div>
                                </div>
                              </div>
                            </div><!--- / payment pannel--->   
                                
                                
                     </div> <!---payment pannel row--->
                     
                </div>
                <!---/payment details--->
                
                
                <div class="row"><!--- payment summary row--->
                    <div class="col-xs-12  col-sm-5  col-md-5 col-lg-5  "> 
                        
                     </div>
                </div><!--- / payment summary row--->
               
        </uib-accordion-group><!---/ Payment accordian group--->
     </uib-accordion>
      <!---payment bttn--->
        <div class="row">
            <div class="col-xs-12  col-sm-6 pull-right" >  
                <br/>
                <uib-alert  type="danger" ng-show="saveTransFailed" ><i class="fa fa-info-circle"></i> We are unable to complete processing at this time. Please email us at help@icwi.com so that we can fix it.</uib-alert>
                <uib-alert  type="danger" ng-if="showFinalPaymentMessage"><i class="fa fa-info-circle"></i> {{showFinalPaymentMessage}}</uib-alert>
                <!---<uib-alert  type="warning" ng-show="paymentForm.$invalid" ><i class="fa fa-info-circle"></i> You must fill out all form fields to continue</uib-alert>--->
            </div>  
        </div>
        <div class="row">  
            <div class="col-xs-6">
                <button ng-click="minusStep()" type="button" class="btn btn-clickAndGoBlue btn-lg btn-block" >
                    <span class="fa-stack  ">
                      <i class="fa fa-circle-thin fa-stack-2x"></i>
                      <i class="fa fa-arrow-left fa-stack-1x"></i>
                    </span>
                    Back
                </button>
             </div>
             <div class="col-xs-6">
                <button type="submit"    ng-show="submitActive == 'true' && paymentForm.$valid" id="paymentButton" class="btn-lg btn-block "  ng-class="{'btn-secondary ' : paymentForm.$invalid, 'btn-success ' : paymentForm.$valid}" ng-click="submitPayment(paymentInfo, paymentForm.$valid)" >
                    
                                                                
                    Submit
                    <span class="fa-stack  ">
                    </span>
                </button>
                <button type="submit"  ng-show="submitActive != 'true'" id="paymentButton" class="btn-lg btn-block "  ng-class="{'btn-danger' : saveTransFailed , 'btn-primary' : !saveTransFailed }" ><i class="fa fa-spinner fa-pulse"></i> {{processText}}</button>
                <!---
                
                to test error checking
                
                 {{paymentForm.$error }}
                 
                 --->
            </div>
        </div><!---/ payment bttn--->
 </form> 