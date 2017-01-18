

<div class="row">
	<div class=" col-sm-12">
    
        <h3 style="color:#006" class="hidden-xs">
        	<span class="fa-stack fa-lg">
              <i class="fa fa-circle-thin fa-stack-2x"></i>
              <i class="fa fa-laptop fa-stack-1x"></i>
            </span> 
             Ready to {{renewalPolicySummary.TAG || 'Renew'}}?
        </h3>
        
        <h3 class="text-darkBlue visible-xs">
            <span class="fa-stack fa-md">
              <i class="fa fa-circle-thin fa-stack-2x"></i>
              <i class="fa fa-mobile fa-stack-1x"></i>
            </span> 
             Ready to {{renewalPolicySummary.TAG || Renew}}?
        </h3>
        <hr class="shadowDivider"/>
	</div>
</div>

<div class="row">
		
        <div class=" col-sm-12 hidden-xs "> <!--- instructions  --->
            
            <div class="col-sm-12  col-md-6 ">
                <p>
                    We make the process as easy as 1-2-3!
                </p>
                
                <p >
                    <h3 ng-show="locksUpOrNo == 'notReady'"  class="clickAndGoBlueText"><i class="fa fa-spinner fa-pulse fa-2x fa-fw margin-bottom"></i>  Fetching your details</h3>
                </p >
                
                <p  ng-if="locksUpOrNo == 'unlocked'">
                    <br class=" hidden-xs hidden-sm "/>
                    Great news! Your policy is ready for renewal.  
                    <br/><br class=" hidden-xs "/>
                    On the following page you will be given convenient payment options and asked to select how you would like to receive your new insurance document. 
                    <br/><br class=" hidden-xs "/>
                    Click 'Next' to continue.
                </p>
               
                <div  ng-if="locksUpOrNo == 'locked'" >
                	   <br class=" hidden-xs hidden-xs hidden-sm"/>
                       <div class="col-xs-12" style="line-height:2.2em"> 
                            <span class="fa-stack fa-lg  col-sm-2">
                              <i class="fa fa-circle fa-stack-2x"></i>
                              <i class="fa fa-inverse fa-stack-1x">1</i>
                            </span>
                            <span class="col-sm-10">
                                Please click each padlock <i class="fa fa-lock fa-2x text-danger"></i> below and follow the instructions. Once complete, the padlock will be removed.
                            </span>
                            
                        </div>
                        <br/><br/>
                        
                        <div class="col-xs-12" style="line-height:2.2em">     
                            <span class="fa-stack fa-lg col-sm-2">
                              <i class="fa fa-circle fa-stack-2x"></i>
                              <i class="fa fa-inverse fa-stack-1x">2</i>
                            </span>
                            <span class="col-sm-10">
                                When all padlocks have been cleared, you will be prompted to click the 'Next' button.
                            </span>
                            
        				</div>
                        <br/><br/>
                        
                        <div class="col-xs-12" style="line-height:2.2em"> 
                            <span class="fa-stack fa-lg col-sm-2">
                              <i class="fa fa-circle fa-stack-2x"></i>
                              <i class="fa fa-inverse fa-stack-1x">3</i>
                            </span>
                            <span class="col-sm-10">
                                
                                You will then be given convenient payment options and asked to select how you would like to receive your new insurance document.
                            </span>
                            <br/><br/>
                            
                            <button type="button" ng-click="goToDash()" class="btn btn-clickAndGoBlue btn-lg btn-block" >
                                <span class="fa-stack  ">
                                  <i class="fa fa-circle-thin fa-stack-2x"></i>
                                  <i class="fa fa-arrow-left fa-stack-1x"></i>
                                </span>
                                Back
                             </button>
                             <br/><br/>
   						</div>
                </div>
            </div>
            <!---
			<div class="col-sm-12  col-md-6  clickAndGoBlueWell" ng-show="renewalPolicySummary.TAG != 'Renew' ">
                <uib-alert  class="slideIn " type="info">
                    <i class="fa fa-info-circle"></i> Need more help? Watch the video below for further assistance
                 </uib-alert>
                 <a href="http://www.youtube.com/embed/2HhM93ftMTQ" target="_blank">
                 <img src = "http://webstunning.com/img/ytd.gif"/>
                 </a>
                 
              
               
            </div> 
			--->
            <div class="col-sm-12  col-md-6" ><!---ng-show="renewalPolicySummary.TAG == 'Renew' "--->
                <img src="//ebroker.icwi.com/email/images/renewalGraphic.png"  />
        	</div>
        </div><!--- / instructions --->
        
		
		
        
        
      	
        <div class="col-sm-12">
        	<!---class="alert "  ng-class="{'alert-danger': locksUpOrNo == 'locked','alert-success': locksUpOrNo == 'unlocked','alert-warning': locksUpOrNo == 'notReady'}" ---> 
            <div class="alert visible-xs" ng-class="{'alert-danger': locksUpOrNo == 'locked','alert-success': locksUpOrNo == 'unlocked'}" >
                <span ng-show="locksUpOrNo != 'notReady'">
                    <span ng-if="locksExist"><i class="fa fa-exclamation-triangle"></i></span><span ng-if="!locksExist"><i class="fa fa-check-circle"></i></span> {{locksMessage}}
                </span>
				<p >
                    <h3 ng-show="locksUpOrNo == 'notReady'"  class="clickAndGoBlueText visible-xs"><i class="fa fa-spinner fa-pulse fa-2x fa-fw margin-bottom"></i>  Retreiving Policy Information</h3>
                </p >
            </div>
        </div>

</div>

<div class="row visible-xs" >
	<div class="col-xs-12 " ng-if="!locksExist">   
    
    	<h3 class="text-darkBlue" >
        	<span class="fa-stack fa-md">
              <i class="fa fa-circle-thin fa-stack-2x"></i>
              <i class="fa fa-file fa-stack-1x"></i>
            </span>  
            Policy Summary
        </h3>
        <hr class="shadowDivider"/>
        <div class="row"   ng-repeat="detail in renewalPolicySummary.DETAILS"> 
    		<div class="col-xs-5 col-sm-3 col-md-3 col-lg-3 text-primary">
            	{{detail.TAG}}: 
            </div>
            <div class="col-xs-7 col-sm-9 col-md-9 col-lg-9">
                {{detail.DATA}}
            </div>
            <br/>
        </div>
    </div>
    <br/><br/>
</div>

<div class="row" ng-if="locksUpOrNo == 'unlocked'">
    <div class="col-xs-6">
         <button type="button" ng-click="goToDash()" class="btn btn-clickAndGoBlue btn-lg btn-block" >
         	<span class="fa-stack  ">
              <i class="fa fa-circle-thin fa-stack-2x"></i>
              <i class="fa fa-arrow-left fa-stack-1x"></i>
            </span>
            Back
         </button>
    </div>
     <div class="col-xs-6">
         <button ng-click="addStep()" class="btn btn-clickAndGoYellow btn-lg btn-block"  ng-init="locksExist = true">
         	Next
         	<span class="fa-stack ">
              <i class="fa fa-circle-thin fa-stack-2x"></i>
              <i class="fa fa-arrow-right fa-stack-1x"></i>
            </span>
         </button>
    </div>
</div>


<div ng-if="locksUpOrNo == 'locked'" class="text-right">
    <a href class="text-success"   ng-click="checkLocks()"><i class="fa fa-refresh" aria-hidden="true"></i> Refresh locks</a>
</div>
<div class="table-responsive" >
    <table class="table">
    	
        <tr > 
            <td  ng-repeat="inTwo in client_locks" style="text-align:center" class="" > 
                <!---uib-tooltip="Click to expand" popover-placement="top"--->
                <a href class="text-danger"   ng-click="dispayLockOption(inTwo.CODE);  goToLock()" ng-class="{'clickAndGoGreyText': inTwo.CODE == lockSwitch, }" >
                    <i class="fa fa-lock fa-4x"></i>
                    <br/>
                    [Click to continue]
                    <br/>
                    {{inTwo.TAG}} 
                    <br/>
                    {{inTwo.RISK}} 
                 </a>
            </td>
        </tr>
    </table>
</div>



<div ng-show="inTwo.CODE == lockSwitch" ng-repeat="inTwo in client_locks "  class="row well   fadeIn"> <!---lock details--->
    
        <div class="col-xs-12" >
        	<a href  class="pull-right text-danger" ng-click="dispayLockOption('')"><i class="fa fa-times" aria-hidden="true"></i> Close</a>
        </div>
        <h3 class="clickAndGoBlueText">{{inTwo.TAG}}</h3>
        <!--- for renewal questionair ONLY--->
        <div class="row text-danger" ng-if="lockSwitch=='POCA' || lockSwitch=='AU'  || lockSwitch=='POCACOM'">
            <div  class="col-sm-12 ">
                <i class="fa fa-exclamation-triangle" aria-hidden="true"></i> <b>We need an original signed copy of this form.</b>  
                <br/>
                We will email you a copy of the completed form in your transaction confirmation email.  
            </div>
        </div>
        <hr class="shadowDivider"/>
        <uib-alert  type="info"><div ><!---<i class="fa fa-info-circle" aria-hidden="true"></i> --->{{inTwo.DATA}}</div></uib-alert>
        
        <!---
		do not show for the foll locks:
		POCA, Comercial POCA, Renewal questionaire (au) 
		Renewal questionaire review (qr - wrond answer on questionaire review)
		Poca review (pr - wrong answer on POCA)
		--->
        <div ng-show="!(lockSwitch=='POCA' || lockSwitch=='POCACOM' || lockSwitch=='AU' || lockSwitch=='QR' || lockSwitch=='PR' || lockSwitch=='CO')">
            <div class="col-xs-12">
               
               
                    <h4><i class="fa fa-cloud-upload" aria-hidden="true"></i> File upload (optional)</h4>
                    <hr/>      
               <div class="col-sm-6">    
                    <p>
                    	Uploading your document will help us to serve you faster.
                    </p>
                    <p class="hidden-xs">
                    	To upload your file, click on the upload button to the right or drag and drop the file into the area if you’re using a computer.
                    </p>
                    <p class="hidden-xs">
                    	You can upload an image or pdf.
                    </p>
                </div>
                <div class="col-sm-6 " >    
                 <form name="uploadForm" >   
                     <div ng-show="!picFile">
                         <div ngf-drop name="file" ngf-select ng-model="picFile" class="drop-box" 
                            ngf-drag-over-class="'dragover'" ngf-multiple="false" ngf-allow-dir="true"
                            accept="image/*,application/pdf" 
                            ngf-pattern="'image/*,application/pdf'">
                            
                                Drop pdfs or images here or click to upload
                                <br/><br/>
                                <button >Select File</button>
                                
                          </div>
                          <span ng-show="!picFile">No files uploaded yet</span>
                      </div>
                      <div ng-show="picFile"> 
                          <h3 class="text-success">You have selected:</h3>
                          <h3 class="clickAndGoBlueText"><i class="fa fa-check-square-o" aria-hidden="true"></i> {{picFile.name}} {{picFile.$error}} {{picFile.$errorParam}}</h3> 
                          <img ng-show="uploadForm.file.$valid" ngf-thumbnail="picFile" class="uploadThumb">
                          
                          <span ng-show="picFile.type === 'application/pdf'"  class="clickAndGoBlueText"><i class="fa fa-file-pdf-o fa-5x" aria-hidden="true"></i></span>
                          <br/><br/>
                          <button ng-click="picFile = null" >Remove this file</button>
                      </div>  
                    
                    
                </form>
                <br/><br/>
               </div>
            </div>
            <div class="col-xs-12 ">
            	<uib-alert  type="warning" ng-show="uploadFailed" ><i class="fa fa-info-circle"></i> {{uploadFailed}}</uib-alert>
            </div>
            <div class="col-xs-12 col-sm-6">
                <button type="submit" id="" class="btn-clickAndGoBlue btn-lg btn-block"  ng-click="statusChange(inTwo.ID, 'Pending')" >Proceed without uploading</button>
                <br class="visible-xs" />
            </div>
            <div class="col-xs-12 col-sm-6">
             <!---statusChange(inTwo.ID, 'True');---> 
             	
                
                <button type="submit" id="" class="btn-lg btn-block  "  ng-click="uploadPic(picFile, inTwo.CODE, inTwo.ID)" ng-disabled=" !picFile.name" ng-class="{'btn-clickAndGoYellow' : picFile.name}" >Proceed, upload my document</button>
            </div>
        </div>


            
    
        
         
        	 <!---Commercial poca--->
   			<div id="pocaComForm"  class="container"  ng-show="lockSwitch=='POCACOM'"><!--- container for supporting com poca divs --->
                <div class="row"><!--- row for supporting com poca divs--->
                    <div class="col-sm-9  form-box ">                          
                        <div class="kioskGeneralForm wrapper" > <!---start of poca com form--->
                            <span>
                                The Proceeds of Crime Act (POCA) 2007 requires all Financial Institutions to collect and maintain your most current information. We therefore ask that you complete and return this form so that your records can be updated accordingly. Failure to do so will prevent completion of the policy contract documentation.
                            </span>
                            <br/><br/>
                            <form  name="pocaComForm"  novalidate>    
    							<div class="form-group"><!---policy no group--->
                                		<!---
                                       <!--label-->
                                       <span class="text-danger" ng-show="comPolicyNumForm.$invalid"><i class="fa fa-asterisk"></i> </span><label class="" for="male">Policy Number(s):</label>
                                       
                                        <!--Add remove buttons-->
                                        <div class="row pull-right">
                                           <div class="col-xs-12 ">
                                            <a href ng-click="comPolicyNumArray.push('field')" class="text-success"><i class="fa fa-plus-square" aria-hidden="true"></i> Add another policy number</a>
                                            <a href ng-click="comPolicyNumArray.length > 1 && comPolicyNumArray.pop()" class="text-warning"><i class="fa fa-minus-square" aria-hidden="true"></i> Remove</a>
                                           </div>
                                        </div>
                                        
                                        <!--form to repeat feild-->
                                        <div class="row " >
                                            <ng-form name="comPolicyNumForm" ng-init="comPolicyNumArray=['feild']">
                                                <span ng-repeat="i in comPolicyNumArray track by $index"   >
                                                    
                                                        <div class="col-xs-12 fadeIn" >
                                                            <!--error message-->
                                                            <div ng-show="comPolicyNumForm.$submitted || comPolicyNumForm.PolicyNumber{{$index}}.$touched" class="text-danger">
                                                              <div ng-show="comPolicyNumForm.PolicyNumber{{$index}}.$error.required || comPolicyNumForm.PolicyNumber{{$index}}.$error.pattern">Policy number {{$index + 1}} required (numbers only, max 11 numbers)</div>
                                                            </div>
                                                            <input type="text"  ng-model="user.comPolicyNumber[$index]" name="PolicyNumber{{$index}}"  ng-pattern="/^[0-9]{1,11}$/" class="form-control"  placeholder="Policy Number {{$index +1}}"  required=""  autocomplete="off" />
                                                            <br/>
                                                        </div>
                                                </span>
                                            </ng-form>
                                        </div>
                                        --->
                                        <br/>
                                       <!--label-->
                                       <span class="text-danger" ng-show="pocaComForm.PolicyNumber.$error.required"><i class="fa fa-asterisk"></i> </span><label class="" for="male">Policy Number:</label>
                                       
                                        <!--form to repeat feild-->
                                        <div class="row " >
                                            <div class="col-xs-12 fadeIn" >
                                                <!--error message-->
                                                <div ng-show="pocaComForm.$submitted || pocaComForm.PolicyNumber.$touched" class="text-danger">
                                                  <div ng-show="pocaComForm.PolicyNumber.$error.required || pocaComForm.PolicyNumber.$error.pattern">Policy number required</div>
                                                </div>
                                                <input type="text"  ng-model="user.PolicyNumber" name="PolicyNumber"  class="form-control"  placeholder="Policy Number"  required=""  autocomplete="off" />
                                                <br/>
                                            </div>
                                        </div>
                                        
                                    </div><!--- end policy no group--->
                                   
                                    <div class="form-group"><!---legal name--->
                                       <!--label-->
                                       <span class="text-danger" ng-show="pocaComForm.comLeagalName.$error.required"><i class="fa fa-asterisk"></i> </span><label class="" for="male">Legal  Name:</label>
                                       
                                        <!--form to repeat feild-->
                                        <div class="row " >
                                            <div class="col-xs-12 fadeIn" >
                                                <!--error message-->
                                                <div ng-show="pocaComForm.$submitted || pocaComForm.comLeagalName.$touched" class="text-danger">
                                                  <div ng-show="pocaComForm.comLeagalName.$error.required || pocaComForm.comLeagalName.$error.pattern">Leagal name required</div>
                                                </div>
                                                <input type="text"  ng-model="user.comLeagalName" name="comLeagalName"  class="form-control"  placeholder="Leagal Name"  required=""  autocomplete="off" />
                                                <br/>
                                            </div>
                                        </div>
                                    </div><!--- end leagal name--->
                                    
                                    <label>Is your trading name different from your legal name?</label> 
                                    <input type="radio" ng-model="user.otherNameDifferent" value="false" ng-init="user.otherNameDifferent = 'false'">No 
                                    <input type="radio" ng-model="user.otherNameDifferent" value="true">Yes
                                    <br/>
                                    <div class="form-group">
                                        <div ng-show="user.otherNameDifferent == 'true'" class="fadeIn"> 
                                            <label class="" for="male">Trading Name</label>
                                            <div ng-show="pocaComForm.$submitted || pocaComForm.otherName.$touched" class="text-danger">
                                              <div ng-show="pocaComForm.otherName.$error.required"><i class="fa fa-asterisk"></i> Please enter trading name</div>
                                            </div>
                                            <input type="text" ng-model="user.otherName"  ng-required="user.otherNameDifferent == 'true'" name="otherName" class="form-control"  placeholder="Trading Name" autocomplete="off"/>   
                                        </div>
                                     </div>
                                     
                                     <div class="form-group"><!---Company, Partnership or Association--->
                                       <!--label-->
                                       <span class="text-danger" ng-show="pocaComForm.companyPartnershipAssociation.$error.required"><i class="fa fa-asterisk"></i> </span><label class="" for="male">Company, Partnership or Association?</label>
                                       
                                        <!--form to repeat feild-->
                                        <div class="row " >
                                            <div class="col-xs-12 fadeIn" >
                                                <!--error message-->
                                                <div ng-show="pocaComForm.$submitted || pocaComForm.companyPartnershipAssociation.$touched" class="text-danger">
                                                  <div ng-show="pocaComForm.companyPartnershipAssociation.$error.required || pocaComForm.companyPartnershipAssociation.$error.pattern">Are you a Company, Partnership or Association required</div>
                                                </div>
                                            </div>
                                            <div class="col-xs-12  col-sm-4 " >
                                                <input type="radio" ng-model="user.companyPartnershipAssociation" name="companyPartnershipAssociation" value="Company" ng-required="!user.companyPartnershipAssociation">Company 
                                    		</div>
                                            <div class="col-xs-12  col-sm-4 " >
                                                <input type="radio" ng-model="user.companyPartnershipAssociation"  name="companyPartnershipAssociation" value="Partnership" ng-required="!user.companyPartnershipAssociation">Partnership
                                            </div>
                                            <div class="col-xs-12  col-sm-4 " >
                                                <input type="radio" ng-model="user.companyPartnershipAssociation"  name="companyPartnershipAssociation" value="Association" ng-required="!user.companyPartnershipAssociation">Association
                                            </div>
                                        </div>
                                    </div><!--- end Company, Partnership or Association--->
                                    
                                    <div class="form-group"><!--- registered address --->
                                       <!--label-->
                                       <span class="text-danger" ng-show="pocaComForm.regAddr.$error.required"><i class="fa fa-asterisk"></i> </span><label class="" for="male">Registered Address:</label>
                                       
                                        <!--form to repeat feild-->
                                        <div class="row " >
                                            <div class="col-xs-12 fadeIn" >
                                                <!--error message-->
                                                <div ng-show="pocaComForm.$submitted || pocaComForm.regAddr.$touched" class="text-danger">
                                                  <div ng-show="pocaComForm.regAddr.$error.required || pocaComForm.regAddr.$error.pattern">Registered address required</div>
                                                </div>
                                                <input type="text"  ng-model="user.regAddr" name="regAddr"  class="form-control"  placeholder="Registered Address"  required=""  autocomplete="off" />
                                                <br/>
                                            </div>
                                        </div>
                                    </div><!--- end registered address--->
                                    
                                    <label>Is your registered address different from your mailing address?</label> 
                                    <input type="radio" ng-model="user.mailingAddrDifferent" value="false" ng-init="user.mailingAddrDifferent = 'false'">No 
                                    <input type="radio" ng-model="user.mailingAddrDifferent" value="true">Yes
                                    <br/>
                                    <div class="form-group">
                                        <div ng-show="user.mailingAddrDifferent == 'true'" class="fadeIn"> 
                                            <label class="" for="male">Mailing Address</label>
                                            <div ng-show="pocaComForm.$submitted || pocaComForm.mailingAddr.$touched" class="text-danger">
                                              <div ng-show="pocaComForm.mailingAddr.$error.required"><i class="fa fa-asterisk"></i> Please enter mailing address</div>
                                            </div>
                                            <input type="text" ng-model="user.mailingAddr"  ng-required="user.mailingAddrDifferent == 'true'" name="mailingAddr" class="form-control"  placeholder="Mailing Address" autocomplete="off"/>   
                                        </div>
                                     </div>
                                     
                                     <div class="form-group"><!---other addresses group--->
                                       <!--label-->
                                       <span class="text-danger" ng-show="comOtherAddressesForm.$invalid"><i class="fa fa-asterisk"></i> </span><label class="" for="male">Address(es) of other Locations (if any):</label>
                                       
                                        <!--Add remove buttons-->
                                        <div class="row pull-right">
                                           <div class="col-xs-12 ">
                                            <a href ng-click="comOtherAddressesArray.push('field')" class="text-success"><i class="fa fa-plus-square" aria-hidden="true"></i> Add another address</a>
                                            <a href ng-click="comOtherAddressesArray.length > 1 && comOtherAddressesArray.pop()" class="text-warning"><i class="fa fa-minus-square" aria-hidden="true"></i> Remove</a>
                                           </div>
                                        </div>
                                        
                                        <!--form to repeat feild-->
                                        <div class="row "  ng-init="user.otherAddresses = []"  >
                                            <ng-form name="comOtherAddressesForm" ng-init="comOtherAddressesArray=['feild']"  class="fadeIn">
                                                <span ng-repeat="i in comOtherAddressesArray track by $index"   >
                                                    <div class="col-xs-12 fadeIn" >
                                                        <!--error message-->
                                                        <div ng-show="comOtherAddressesForm.$submitted || comOtherAddressesForm.otherAddresses{{$index}}.$touched" class="text-danger">
                                                          <div ng-show="comOtherAddressesForm.otherAddresses{{$index}}.$error.required || comOtherAddressesForm.otherAddresses{{$index}}.$error.pattern">Other Address {{$index +1}} required </div>
                                                        </div>
                                                        <input type="text"   ng-model="user.otherAddresses[$index]" name="otherAddresses{{$index}}"  class="form-control"  placeholder="Other Address {{$index +1}}"  autocomplete="off" />
                                                        <br/>
                                                    </div>
                                                </span>
                                            </ng-form>
                                        </div>
                                    </div><!--- end other addresses group--->
                                    
                                     <div class="form-group"><!---phone numbers--->
                                       <!--label-->
                                       <span class="text-danger" ng-show="comPhoneNumForm.$invalid"><i class="fa fa-asterisk"></i> </span><label class="" for="male">Telephone Number(s). Enter numbers ONLY:</label>
                                       <br/>
                                        
                                        <!--Add remove buttons-->
                                        <div class="row pull-right">
                                           <div class="col-xs-12 ">
                                            <a href ng-click="comPhoneNumArray.push('field')" class="text-success"><i class="fa fa-plus-square" aria-hidden="true"></i> Add another number</a>
                                            <a href ng-click="comPhoneNumArray.length > 1 && comPhoneNumArray.pop()" class="text-warning"><i class="fa fa-minus-square" aria-hidden="true"></i> Remove</a>
                                           </div>
                                        </div>
                                        
                                        
                                        <span class="" ng-show="comPhoneNumForm.$invalid">
                                       		<i class="fa fa-info-circle"></i>7 digits minimum, numbers / digits only. Remember the area code (876 for Jamaica)
                                            <br/>
                                        </span>
                                        
                                        
                                        <!--form to repeat feild-->
                                        <div class="row"  ng-init="user.phoneNums = []" >
                                            <ng-form name="comPhoneNumForm" ng-init="comPhoneNumArray=['feild']">
                                                <span ng-repeat="i in comPhoneNumArray track by $index"  class="fadeIn" >
                                                    <div class="col-xs-12 col-sm-4 fadeIn" >
                                                        <!--error message-->
                                                        <div ng-show="comPhoneNumForm.$submitted || comPhoneNumForm.phoneNums{{$index}}.$touched" class="text-danger">
                                                          <div ng-show="comPhoneNumForm.phoneNums{{$index}}.$error.required || comPhoneNumForm.phoneNums{{$index}}.$error.pattern">No dashes or spaces. Digits ONLY</div>
                                                        </div>
                                                        <input type="text"   ng-model="user.phoneNums[$index]" name="phoneNums{{$index}}"  ng-pattern="/^[0-9]{7,}$/"  class="form-control"  placeholder="xxxxxxxxxx"  required=""  autocomplete="off" />
                                                        <br/>
                                                    </div>
                                                </span>
                                            </ng-form>
                                        </div>
                                    </div><!--- end phone numbers--->
                                    
                                    
                                    <div class = "row">
                                    	<div class="col-xs-12 col-sm-8">  
                                           <div class="form-group"><!---Nature of Business--->
                                               <!--label-->
                                               <span class="text-danger" ng-show="pocaComForm.occupation_industry.$error.required"><i class="fa fa-asterisk"></i> </span><label class="" for="male">Nature of Business / Industry:</label>
                                                <!--form to repeat feild-->
                                                <div class="row " >
                                                    <div class="col-xs-12 fadeIn" >
                                                        <!--error message-->
                                                        <div ng-show="pocaComForm.$submitted || pocaComForm.occupation_industry.$touched" class="text-danger">
                                                          <div ng-show="pocaComForm.occupation_industry.$error.required || pocaComForm.occupation_industry.$error.pattern">Nature of Business / Industry required</div>
                                                        </div>
                                                        <input type="text"  ng-model="user.occupation_industry" name="occupation_industry"  class="form-control"  placeholder="Nature of Business / Industry"  required=""  autocomplete="off" />
                                                        <br/>
                                                    </div>
                                                </div>
                                            </div><!--- end Nature of Business--->
                                   		</div>
                                    	<div class="col-xs-12 col-sm-4">
                                            <div class="form-group"><!---email address --->
                                                <div class="row">
                                                    <div class="col-xs-12 ">
                                                        <span class="text-danger" ng-show="pocaComForm.emailAddress.$error.required || pocaComForm.emailAddress.$error.pattern"><i class="fa fa-asterisk"></i> </span><label for="male"  class="">Company Email Address:</label>
                                                        <div ng-show="pocaComForm.$submitted || pocaComForm.emailAddress.$touched" class="text-danger">
                                                          <div ng-show="pocaComForm.emailAddress.$error.required || pocaComForm.emailAddress.$error.pattern">Please enter a valid email address</div>
                                                        </div>
                                                        <input type="text" ng-model="user.emailAddress" name="emailAddress" required=""  class="form-control" ng-pattern="/^[^\s/]+(\.[^\s/]+)*@[^\s/]+(\.[^\s/]+)*(\.[^\s/]{2,4})$/"  placeholder="Company Email Address"  autocomplete="off"/>
                                                    </div>
                                                </div>
                                           </div><!---end email address --->
                                     	</div>
                                        
                                   </div>
                                   
                                    <div class="form-group"><!---  date of registration --->
                                    	<span class="text-danger" ng-show="pocaComForm.dobday.$error.required || pocaComForm.dobmonth.$error.required || pocaComForm.year.$error.required"><i class="fa fa-asterisk"></i> </span><label for="male">Date of Incorporation / Registration:</label><br/>
                                    
                                        <div class="row">
                                            <div class="col-xs-12 col-sm-4 col-md-4 col-lg-4">
                                                <div ng-show="pocaComForm.$submitted || pocaComForm.dobday.$touched" class="text-danger">
                                                  <div ng-show="pocaComForm.dobday.$error.required">Day required</div>
                                                </div>
                                                <select ng-model="user.dobday"  required=""  name="dobday"  class="form-control ">
                                                  <option value="">Day</option>
                                                  <option value="">---</option>
                                                  <option value="01">01</option>
                                                  <option value="02">02</option>
                                                  <option value="03">03</option>
                                                  <option value="04">04</option>
                                                  <option value="05">05</option>
                                                  <option value="06">06</option>
                                                  <option value="07">07</option>
                                                  <option value="08">08</option>
                                                  <option value="09">09</option>
                                                  <option value="10">10</option>
                                                  <option value="11">11</option>
                                                  <option value="12">12</option>
                                                  <option value="13">13</option>
                                                  <option value="14">14</option>
                                                  <option value="15">15</option>
                                                  <option value="16">16</option>
                                                  <option value="17">17</option>
                                                  <option value="18">18</option>
                                                  <option value="19">19</option>
                                                  <option value="20">20</option>
                                                  <option value="21">21</option>
                                                  <option value="22">22</option>
                                                  <option value="23">23</option>
                                                  <option value="24">24</option>
                                                  <option value="25">25</option>
                                                  <option value="26">26</option>
                                                  <option value="27">27</option>
                                                  <option value="28">28</option>
                                                  <option value="29">29</option>
                                                  <option value="30">30</option>
                                                  <option value="31">31</option>
                                                </select>
                                            </div>
                                            <div class="col-xs-12 col-sm-4 col-md-4 col-lg-4">
                                                <div ng-show="pocaComForm.$submitted || pocaComForm.dobmonth.$touched" class="text-danger">
                                                  <div ng-show="pocaComForm.dobmonth.$error.required">Month required</div>
                                                </div>
                                                <select ng-model="user.dobmonth"  required=""  name="dobmonth" class="form-control ">
                                                  <option value="">Month</option>
                                                  <option value="">-----</option>
                                                  <option value="01">January</option>
                                                  <option value="02">February</option>
                                                  <option value="03">March</option>
                                                  <option value="04">April</option>
                                                  <option value="05">May</option>
                                                  <option value="06">June</option>
                                                  <option value="07">July</option>
                                                  <option value="08">August</option>
                                                  <option value="09">September</option>
                                                  <option value="10">October</option>
                                                  <option value="11">November</option>
                                                  <option value="12">December</option>
                                                </select>
                                            </div>
                                            <div class="col-xs-12 col-sm-4 col-md-4 col-lg-4">
                                                <div ng-show="pocaComForm.$submitted || pocaComForm.year.$touched" class="text-danger">
                                                  <div ng-show="pocaComForm.year.$error.required || pocaComForm.year.$error.pattern">Valid year required (4 numbers only)</div>
                                                </div>
                                                <input type="text" ng-model="user.year"  required="" ng-pattern="/^[0-9]{4}$/" name="year" class="form-control  "  placeholder="Year" autocomplete="off"/>
                                            </div>
                                        </div>
                                    </div> <!--- end date of registration --->
                                    
                                    <div class=""><!--- contact person info--->
                                    	<span class="text-danger" ng-show="pocaComForm.contactName.$error.required || pocaComForm.contactPosition.$error.required || pocaComForm.contactEmail.$error.required || comContactPersonPhoneNumForm.$invalid"><i class="fa fa-asterisk"></i> </span>
                                        Contact Person
                                        <span class="pull-right">
                                            <a href ng-click="addContactinfo = !addContactinfo" ng-class="{'text-success': !addContactinfo, 'text-danger' : addContactinfo}"><span ng-show="!addContactinfo" ><i class="fa fa-plus-circle" aria-hidden="true"></i> Add</span> <span ng-show="addContactinfo" ><i class="fa fa-minus-circle" aria-hidden="true"></i> Hide</span> info for Contact Person</a>               
                                        </span>
                                        <br/>
                                        <hr/>
                                        
                                        <div ng-show="addContactinfo" class="fadeIn well">
                                        	<br/>
                                            <div class="row" ><!--  row personal info-->
                                                 
                                                <div class="col-xs-12 col-sm-4 fadeIn" ><!--- contact name--->
                                                    <!--label-->
                                                    <span class="text-danger" ng-show="pocaComForm.contactName.$error.required"><i class="fa fa-asterisk"></i> </span><label class="" for="male">Name:</label>
                                                    <!--error message-->
                                                    <div ng-show="pocaComForm.$submitted || pocaComForm.contactName.$touched" class="text-danger">
                                                      <div ng-show="pocaComForm.contactName.$error.required || pocaComForm.contactName.$error.pattern">Name required <br/>(no symbols or numbers)</div>
                                                    </div>
                                                    <input type="text"  ng-model="user.contactName" name="contactName"  class="form-control" ng-pattern="/^[A-Za-z\-\' ]+$/" placeholder="Contact Name"  required=""  autocomplete="off" />
                                                    <br/>
                                                </div><!--- end contact name--->
                                                
                                                <div class="col-xs-12 col-sm-4 fadeIn" ><!--- contact position--->
                                                    <!--label-->
                                                    <span class="text-danger" ng-show="pocaComForm.contactPosition.$error.required"><i class="fa fa-asterisk"></i> </span><label class="" for="male">Position:</label>
                                                    <!--error message-->
                                                    <div ng-show="pocaComForm.$submitted || pocaComForm.contactPosition.$touched" class="text-danger">
                                                      <div ng-show="pocaComForm.contactPosition.$error.required || pocaComForm.contactPosition.$error.pattern">Position required</div>
                                                    </div>
                                                    <input type="text"  ng-model="user.contactPosition" name="contactPosition"  class="form-control"  placeholder="Contact Position"  required=""  autocomplete="off" />
                                                    <br/>
                                                </div><!--- end contact position--->
                                                
                                                <div class="col-xs-12 col-sm-4 fadeIn" ><!--- contact email--->
                                                    <!--label-->
                                                    <span class="text-danger" ng-show="pocaComForm.contactEmail.$error.required"><i class="fa fa-asterisk"></i> </span><label class="" for="male">Email:</label>
                                                    <!--error message-->
                                                    <div ng-show="pocaComForm.$submitted || pocaComForm.contactEmail.$touched" class="text-danger">
                                                      <div ng-show="pocaComForm.contactEmail.$error.required || pocaComForm.contactEmail.$error.pattern">Valid email required</div>
                                                    </div>
                                                    <input type="text"  ng-model="user.contactEmail" name="contactEmail"  class="form-control"  ng-pattern="/^[^\s/]+(\.[^\s/]+)*@[^\s/]+(\.[^\s/]+)*(\.[^\s/]{2,4})$/"  placeholder="Contact Email"  required=""  autocomplete="off" />
                                                    <br/>
                                                </div><!--- end contact email--->
                                                
                                            </div><!-- end row personal info-->
                                            <div class="row"><!--  row Phone numbers-->
                                                 <div class="col-xs-12 ">
                                                   <!--label-->
                                                   <span class="text-danger" ng-show="comContactPersonPhoneNumForm.$invalid"><i class="fa fa-asterisk"></i> </span><label class="" for="male">Telephone Number(s). Enter digits ONLY:</label>
                                                   <br/>
                                                    
                                                    <!--Add remove buttons-->
                                                    <div class="row pull-right">
                                                       <div class="col-xs-12 ">
                                                        <a href ng-click="comContactPersonPhoneNumArray.push('field')" class="text-success"><i class="fa fa-plus-square" aria-hidden="true"></i> Add another number</a>
                                                        <a href ng-click="comContactPersonPhoneNumArray.length > 1 && comContactPersonPhoneNumArray.pop()" class="text-warning"><i class="fa fa-minus-square" aria-hidden="true"></i> Remove</a>
                                                       </div>
                                                    </div>
                                                    
                                                    
                                                    <span class="text-danger" ng-show="comContactPersonPhoneNumForm.$invalid">
                                                        (7 digits minimum, numbers / digits only) <i class="fa fa-info-circle"></i> Remember the area code (876 for Jamaica)
                                                        <br/>
                                                    </span>
                                                    
                                                    
                                                    <!--form to repeat feild-->
                                                    <div class="row"  ng-init="user.comContactPersonPhoneNum = []">
                                                        <ng-form name="comContactPersonPhoneNumForm" ng-init="comContactPersonPhoneNumArray=['feild']">
                                                            <span ng-repeat="i in comContactPersonPhoneNumArray track by $index"  >
                                                                <div class="col-xs-12 col-sm-4 fadeIn" >
                                                                    <!--error message-->
                                                                    <div ng-show="comContactPersonPhoneNumForm.$submitted || comContactPersonPhoneNumForm.comContactPersonPhoneNum{{$index}}.$touched" class="text-danger">
                                                                      <div ng-show="comContactPersonPhoneNumForm.comContactPersonPhoneNum{{$index}}.$error.required || comContactPersonPhoneNumForm.comContactPersonPhoneNum{{$index}}.$error.pattern">No dashes or spaces. Digits ONLY </div>
                                                                    </div>
                                                                    <input type="text"  ng-model="user.comContactPersonPhoneNum[$index]" name="comContactPersonPhoneNum{{$index}}"  ng-pattern="/^[0-9]{7,}$/"  class="form-control"  placeholder="xxxxxxxxxx"  required=""  autocomplete="off" />
                                                                    <br/>
                                                                </div>
                                                            </span>
                                                        </ng-form>
                                                    </div>
                                                </div>
                                            </div><!-- end row Phone numbers-->
										</div>
                                    </div>  <!--- end contact person info---> 
                                    <br/>
                                   	<b> Names of Executive Officers / Directors / Partners: </b>
                                    
                                    <br/>
                                    <span class="text-danger" ng-show="pocaComForm.ceoFirstName.$error.required || pocaComForm.ceoLastName.$error.required || pocaComForm.ceoHomeAddr.$error.required"><i class="fa fa-asterisk"></i> </span>
                                    Chief Executive Officer  
                                    <span class="pull-right">
                                        <a href ng-click="addCEOinfo = !addCEOinfo" ng-class="{'text-success': !addCEOinfo, 'text-danger' : addCEOinfo}"><span ng-show="!addCEOinfo" ><i class="fa fa-plus-circle" aria-hidden="true"></i> Add</span> <span ng-show="addCEOinfo" ><i class="fa fa-minus-circle" aria-hidden="true"></i> Hide</span> info for CEO</a>               
                                    </span>
                                    <br/>
                                    <hr/>
                                    <div class="fadeIn well" ng-show="addCEOinfo"><!--- CEO info--->
                                    	
                                        <div class="row"><!--  row personal info-->
                                             
                                            <div class="col-xs-12 col-sm-4 fadeIn" ><!--- first name--->
                                                <!--label-->
                                      	 		<span class="text-danger" ng-show="pocaComForm.ceoFirstName.$error.required"><i class="fa fa-asterisk"></i> </span><label class="" for="male">CEO First Name:</label>
                                                <!--error message-->
                                                <div ng-show="pocaComForm.$submitted || pocaComForm.ceoFirstName.$touched" class="text-danger">
                                                  <div ng-show="pocaComForm.ceoFirstName.$error.required || pocaComForm.ceoFirstName.$error.pattern">First name required <br/>(no symbols or numbers)</div>
                                                </div>
                                                <input type="text"  ng-model="user.ceoFirstName" name="ceoFirstName"  class="form-control" ng-pattern="/^[A-Za-z\-\' ]+$/" placeholder="First Name"   autocomplete="off" />
                                                <br/>
                                            </div><!--- end first name--->
                                            <div class="col-xs-12 col-sm-4 fadeIn" ><!--- middle name--->
                                                <!--label-->
                                      	 		<span class="text-danger" ng-show="pocaComForm.ceoMiddleName.$error.required"><i class="fa fa-asterisk"></i> </span><label class="" for="male">CEO Middle Name:</label>
                                                <!--error message-->
                                                <div ng-show="pocaComForm.$submitted || pocaComForm.ceoMiddleName.$touched" class="text-danger">
                                                  <div ng-show="pocaComForm.ceoMiddleName.$error.required || pocaComForm.ceoMiddleName.$error.pattern">(no symbols or numbers)</div>
                                                </div>
                                                <input type="text"  ng-model="user.ceoMiddleName" name="ceoMiddleName"  class="form-control" ng-pattern="/^[A-Za-z\-\' ]+$/" placeholder="Middle Name"  autocomplete="off" />
                                                <br/>
                                            </div><!--- end middle name--->
                                            <div class="col-xs-12 col-sm-4 fadeIn" ><!--- last name--->
                                                <!--label-->
                                      	 		<span class="text-danger" ng-show="pocaComForm.ceoLastName.$error.required"><i class="fa fa-asterisk"></i> </span><label class="" for="male">CEO Last Name:</label>
                                                <!--error message-->
                                                <div ng-show="pocaComForm.$submitted || pocaComForm.ceoLastName.$touched" class="text-danger">
                                                  <div ng-show="pocaComForm.ceoLastName.$error.required || pocaComForm.ceoLastName.$error.pattern">Last name required <br/>(no symbols or numbers)</div>
                                                </div>
                                                <input type="text"  ng-model="user.ceoLastName" name="ceoLastName"  class="form-control" ng-pattern="/^[A-Za-z\-\' ]+$/" placeholder="Last Name"   autocomplete="off" />
                                                <br/>
                                            </div><!--- end last name--->
                                            
                                        </div><!-- end row personal info-->
                                        <div class="row"><!--  row home addr-->
                                        	<div class="col-xs-12 ">
                                            	<!--label-->
                                      	 		<span class="text-danger" ng-show="pocaComForm.ceoHomeAddr.$error.required"><i class="fa fa-asterisk"></i> </span><label class="" for="male">CEO Home Address:</label>
                                                <!--error message-->
                                                <div ng-show="pocaComForm.$submitted || pocaComForm.ceoHomeAddr.$touched" class="text-danger">
                                                  <div ng-show="pocaComForm.ceoHomeAddr.$error.required || pocaComForm.ceoHomeAddr.$error.pattern">Home address required</div>
                                                </div>
                                                <input type="text"  ng-model="user.ceoHomeAddr" name="ceoHomeAddr"  class="form-control"  placeholder="Home Address"   autocomplete="off" />
                                                <br/> 
                                        	</div>
                                        </div><!-- end row home addr-->
                                    </div>  <!--- end CEO info---> 
                                    
                                    <span class="text-danger" ng-show="pocaComForm.cfoFirstName.$error.required || pocaComForm.cfoLastName.$error.required || pocaComForm.cfoHomeAddr.$error.required"><i class="fa fa-asterisk"></i> </span>
                                    Chief Financial Officer 
                                    <span class="pull-right">
                                        <a href ng-click="addCFOinfo = !addCFOinfo" ng-class="{'text-success': !addCFOinfo, 'text-danger' : addCFOinfo}"><span ng-show="!addCFOinfo" ><i class="fa fa-plus-circle" aria-hidden="true"></i> Add</span> <span ng-show="addCFOinfo" ><i class="fa fa-minus-circle" aria-hidden="true"></i> Hide</span> info for CFO</a>               
                                    </span>
                                    <br/>
                                    <hr/>
                                    <div class="fadeIn well" ng-show="addCFOinfo"><!--- CFO info--->
                                    	
                                        <div class="row"><!--  row personal info-->
                                             
                                            <div class="col-xs-12 col-sm-4 fadeIn" ><!--- first name--->
                                                <!--label-->
                                      	 		<span class="text-danger" ng-show="pocaComForm.cfoFirstName.$error.required"><i class="fa fa-asterisk"></i> </span><label class="" for="male">CFO First Name:</label>
                                                <!--error message-->
                                                <div ng-show="pocaComForm.$submitted || pocaComForm.cfoFirstName.$touched" class="text-danger">
                                                  <div ng-show="pocaComForm.cfoFirstName.$error.required || pocaComForm.cfoFirstName.$error.pattern">First name required <br/>(no symbols or numbers)</div>
                                                </div>
                                                <input type="text"  ng-model="user.cfoFirstName" name="cfoFirstName"  class="form-control" ng-pattern="/^[A-Za-z\-\' ]+$/" placeholder="First Name"  autocomplete="off" />
                                                <br/>
                                            </div><!--- end first name--->
                                            <div class="col-xs-12 col-sm-4 fadeIn" ><!--- middle name--->
                                                <!--label-->
                                      	 		<span class="text-danger" ng-show="pocaComForm.cfoMiddleName.$error.required"><i class="fa fa-asterisk"></i> </span><label class="" for="male">CFO Middle Name:</label>
                                                <!--error message-->
                                                <div ng-show="pocaComForm.$submitted || pocaComForm.cfoMiddleName.$touched" class="text-danger">
                                                  <div ng-show="pocaComForm.cfoMiddleName.$error.required || pocaComForm.cfoMiddleName.$error.pattern">(no symbols or numbers)</div>
                                                </div>
                                                <input type="text"  ng-model="user.cfoMiddleName" name="cfoMiddleName"  class="form-control" ng-pattern="/^[A-Za-z\-\' ]+$/" placeholder="Middle Name"  autocomplete="off" />
                                                <br/>
                                            </div><!--- end middle name--->
                                            <div class="col-xs-12 col-sm-4 fadeIn" ><!--- last name--->
                                                <!--label-->
                                      	 		<span class="text-danger" ng-show="pocaComForm.cfoLastName.$error.required"><i class="fa fa-asterisk"></i> </span><label class="" for="male">CFO Last Name:</label>
                                                <!--error message-->
                                                <div ng-show="pocaComForm.$submitted || pocaComForm.cfoLastName.$touched" class="text-danger">
                                                  <div ng-show="pocaComForm.cfoLastName.$error.required || pocaComForm.cfoLastName.$error.pattern">Last name required <br/>(no symbols or numbers)</div>
                                                </div>
                                                <input type="text"  ng-model="user.cfoLastName" name="cfoLastName"  class="form-control" ng-pattern="/^[A-Za-z\-\' ]+$/" placeholder="Last Name"  autocomplete="off" />
                                                <br/>
                                            </div><!--- end last name--->
                                            
                                        </div><!-- end row personal info-->
                                        <div class="row"><!--  row home addr-->
                                        	<div class="col-xs-12 ">
                                            	<!--label-->
                                      	 		<span class="text-danger" ng-show="pocaComForm.cfoHomeAddr.$error.required"><i class="fa fa-asterisk"></i> </span><label class="" for="male">CFO Home Address:</label>
                                                <!--error message-->
                                                <div ng-show="pocaComForm.$submitted || pocaComForm.cfoHomeAddr.$touched" class="text-danger">
                                                  <div ng-show="pocaComForm.cfoHomeAddr.$error.required || pocaComForm.cfoHomeAddr.$error.pattern">Home address required</div>
                                                </div>
                                                <input type="text"  ng-model="user.cfoHomeAddr" name="cfoHomeAddr"  class="form-control"  placeholder="Home Address"   autocomplete="off" />
                                                <br/> 
                                        	</div>
                                        </div><!-- end row home addr-->
                                    </div>  <!--- end CFO info--->    
                                    
                                    <span class="text-danger" ng-show="pocaComForm.cooFirstName.$error.required || pocaComForm.cooLastName.$error.required || pocaComForm.cooHomeAddr.$error.required"><i class="fa fa-asterisk"></i> </span>
                                    Chief Operating Officer 
                                    <span class="pull-right">
                                        <a href ng-click="addCOOinfo = !addCOOinfo" ng-class="{'text-success': !addCOOinfo, 'text-danger' : addCOOinfo}"><span ng-show="!addCOOinfo" ><i class="fa fa-plus-circle" aria-hidden="true"></i> Add</span> <span ng-show="addCOOinfo" ><i class="fa fa-minus-circle" aria-hidden="true"></i> Hide</span> info for COO</a>               
                                    </span>
                                    <br/>
                                    <hr/>
                                    <div class="fadeIn well" ng-show="addCOOinfo"><!--- COO info--->
                                    	
                                        <div class="row"><!--  row personal info-->
                                             
                                            <div class="col-xs-12 col-sm-4 fadeIn" ><!--- first name--->
                                                <!--label-->
                                      	 		<span class="text-danger" ng-show="pocaComForm.cooFirstName.$error.required"><i class="fa fa-asterisk"></i> </span><label class="" for="male">COO First Name:</label>
                                                <!--error message-->
                                                <div ng-show="pocaComForm.$submitted || pocaComForm.cooFirstName.$touched" class="text-danger">
                                                  <div ng-show="pocaComForm.cooFirstName.$error.required || pocaComForm.cooFirstName.$error.pattern">First name required <br/>(no symbols or numbers)</div>
                                                </div>
                                                <input type="text"  ng-model="user.cooFirstName" name="cooFirstName"  class="form-control" ng-pattern="/^[A-Za-z\-\' ]+$/" placeholder="First Name"   autocomplete="off" />
                                                <br/>
                                            </div><!--- end first name--->
                                            <div class="col-xs-12 col-sm-4 fadeIn" ><!--- middle name--->
                                                <!--label-->
                                      	 		<span class="text-danger" ng-show="pocaComForm.cooMiddleName.$error.required"><i class="fa fa-asterisk"></i> </span><label class="" for="male">COO Middle Name:</label>
                                                <!--error message-->
                                                <div ng-show="pocaComForm.$submitted || pocaComForm.cooMiddleName.$touched" class="text-danger">
                                                  <div ng-show="pocaComForm.cooMiddleName.$error.required || pocaComForm.cooMiddleName.$error.pattern">(no symbols or numbers)</div>
                                                </div>
                                                <input type="text"  ng-model="user.cooMiddleName" name="cooMiddleName"  class="form-control" ng-pattern="/^[A-Za-z\-\' ]+$/" placeholder="Middle Name"  autocomplete="off" />
                                                <br/>
                                            </div><!--- end middle name--->
                                            <div class="col-xs-12 col-sm-4 fadeIn" ><!--- last name--->
                                                <!--label-->
                                      	 		<span class="text-danger" ng-show="pocaComForm.cooLastName.$error.required"><i class="fa fa-asterisk"></i> </span><label class="" for="male">COO Last Name:</label>
                                                <!--error message-->
                                                <div ng-show="pocaComForm.$submitted || pocaComForm.cooLastName.$touched" class="text-danger">
                                                  <div ng-show="pocaComForm.cooLastName.$error.required || pocaComForm.cooLastName.$error.pattern">Last name required <br/>(no symbols or numbers)</div>
                                                </div>
                                                <input type="text"  ng-model="user.cooLastName" name="cooLastName"  class="form-control" ng-pattern="/^[A-Za-z\-\' ]+$/" placeholder="Last Name"    autocomplete="off" />
                                                <br/>
                                            </div><!--- end last name--->
                                            
                                        </div><!-- end row personal info-->
                                        <div class="row"><!--  row home addr-->
                                        	<div class="col-xs-12 ">
                                            	<!--label-->
                                      	 		<span class="text-danger" ng-show="pocaComForm.cooHomeAddr.$error.required"><i class="fa fa-asterisk"></i> </span><label class="" for="male">COO Home Address:</label>
                                                <!--error message-->
                                                <div ng-show="pocaComForm.$submitted || pocaComForm.cooHomeAddr.$touched" class="text-danger">
                                                  <div ng-show="pocaComForm.cooHomeAddr.$error.required || pocaComForm.cooHomeAddr.$error.pattern">Home address required</div>
                                                </div>
                                                <input type="text"  ng-model="user.cooHomeAddr" name="cooHomeAddr"  class="form-control" placeholder="Home Address"    autocomplete="off" />
                                                <br/> 
                                        	</div>
                                        </div><!-- end row home addr-->
                                    </div>  <!--- end COO info--->   
                                    
                                    <div class="table-responsive">
                                    	<table class="table table-striped table-bordered">
                                            <thead>
                                                <tr>
                                                  <th colspan="3">Principle Owners, Directors and Shareholders with 10% or more shareholding:
                                                  	<br/>
                                                    <span class="pull-right">
                                                    	<a href ng-click="comOtherDirecttorsArray.push('field')" class="text-success"><i class="fa fa-plus-square" aria-hidden="true"></i> Add another person</a>
                                                    	<a href ng-click="comOtherDirecttorsArray.length > 1 && comOtherDirecttorsArray.pop()" class="text-warning"><i class="fa fa-minus-square" aria-hidden="true"></i> Remove</a>
                                                  	</span>
                                                  </th>
                                                </tr>
                                            </thead>
                                            <thead>
                                                <tr>
                                                  <th ng-init="user.comOtherDirecttorsCategory = []">Category</th>
                                                  <th ng-init="user.comOtherDirecttorsName = []" >Name</th>
                                                  <th ng-init="user.comOtherDirecttorsAddress = []"  >Home Address</th>
                                                </tr>
                                            </thead>
                                            <tbody ng-init="comOtherDirecttorsArray=['feild']">
                                                <tr  ng-repeat="i in comOtherDirecttorsArray track by $index">
                                                    <td>
                                                    	<div ng-show="pocaComForm.$submitted || pocaComForm.comOtherDirecttorsCategory{{$index}}.$touched" class="text-danger">
                                                          <div ng-show="pocaComForm.comOtherDirecttorsCategory{{$index}}.$error.required || pocaComForm.comOtherDirecttorsCategory{{$index}}.$error.pattern">Category required if name or address entered</div>
                                                        </div>
                                                    	<input type="text"   ng-model="user.comOtherDirecttorsCategory[$index]" name="comOtherDirecttorsCategory{{$index}}" ng-required="user.comOtherDirecttorsName[$index] || user.comOtherDirecttorsAddress[$index]" class="form-control"  placeholder="Person {{$index + 1}} category"   autocomplete="off" />
                                                    </td>
                                                    <td>
                                                    	<div ng-show="pocaComForm.$submitted || pocaComForm.comOtherDirecttorsName{{$index}}.$touched" class="text-danger">
                                                          <div ng-show="pocaComForm.comOtherDirecttorsName{{$index}}.$error.required || pocaComForm.comOtherDirecttorsName{{$index}}.$error.pattern">Name required if category or address entered</div>
                                                        </div>
                                                    	<input type="text"   ng-model="user.comOtherDirecttorsName[$index]" name="comOtherDirecttorsName{{$index}}"   ng-required="user.comOtherDirecttorsCategory[$index] || user.comOtherDirecttorsAddress[$index]"  class="form-control"   placeholder="Person {{$index + 1}} name"   autocomplete="off" />
                                                    </td>
                                                    <td>
                                                    	<div ng-show="pocaComForm.$submitted || pocaComForm.comOtherDirecttorsAddress{{$index}}.$touched" class="text-danger">
                                                          <div ng-show="pocaComForm.comOtherDirecttorsAddress{{$index}}.$error.required || pocaComForm.comOtherDirecttorsAddress{{$index}}.$error.pattern">Address required if category or name entered</div>
                                                        </div>
                                                    	<input type="text"ng-model="user.comOtherDirecttorsAddress[$index]" name="comOtherDirecttorsAddress{{$index}}"  class="form-control" ng-required="user.comOtherDirecttorsCategory[$index] || user.comOtherDirecttorsName[$index]"  placeholder="Person {{$index + 1}} address"  autocomplete="off" />
                                                    </td>
                                                </tr>
                                        	</tbody>
                                    	</table>
                                    </div>
                                    
                                    <br/>
                                    <i class="fa fa-upload" aria-hidden="true"></i>Uploads: Please upload a copy of the Certificate of Incorporation and a valid ID for two Company Directors. If you are unable to upload these now, kindly submit them to us within 15 days  
                                    <span class="pull-right">
                                        <a href ng-click="addisPEPUploads = !addisPEPUploads" ng-class="{'text-success': !addisPEPUploads, 'text-danger' : addisPEPUploads}"><span ng-show="!addisPEPUploads" ><i class="fa fa-plus-circle" aria-hidden="true"></i> Add</span> <span ng-show="addisPEPUploads" ><i class="fa fa-minus-circle" aria-hidden="true"></i> Hide</span> Uploads</a>               
                                    </span>
                                    <div class="row fadeIn" ng-show="addisPEPUploads">
                                    	<div class="col-xs-12 col-sm-6 col-md-4"> <!---director 1 upload--->
                                            <br/>
                                            <label for="male" class="">Copy of ID- Director 1</label>
                                            <br/>
                                            
                                            <ng-form name="dirOneUploadForm" >   
                                                 <div ng-show="!user.dirOneFile">
                                                     <div ngf-drop name="file" ngf-select ng-model="user.dirOneFile" class="drop-box" 
                                                        ngf-drag-over-class="'dragover'" ngf-multiple="false" ngf-allow-dir="true"
                                                        accept="image/*,application/pdf" 
                                                        ngf-pattern="'image/*,application/pdf'">
                                                        
                                                            Drop pdfs or images here or click to upload
                                                            <br/><br/>
                                                            <button >Select File</button>
                                                            
                                                      </div>
                                                      <span ng-show="!user.dirOneFile">ID of director 1 not selected yet</span>
                                                  </div>
                                                  <div ng-show="user.dirOneFile"> 
                                                  
                                                      <h4 class="text-success">You have selected:</h4>
                                                      <h4 class="clickAndGoBlueText"><i class="fa fa-check-square-o" aria-hidden="true"></i> {{user.dirOneFile.name}} {{user.dirOneFile.$error}} {{user.dirOneFile.$errorParam}}</h4> 
                                                      <img ng-show="dirOneUploadForm.file.$valid" ngf-thumbnail="user.dirOneFile" class="uploadThumb">
                                                      
                                                      <span ng-show="user.dirOneFile.type === 'application/pdf'"  class="clickAndGoBlueText"><i class="fa fa-file-pdf-o fa-5x" aria-hidden="true"></i></span>
                                                      <br/><br/>
                                                  </div>  
                                               
                                         
                                                <div class="row"  ng-show="user.dirOneFile">
                                                    <div class="col-xs-12 text-center">
                                                        Your selected file, {{user.dirOneFile.name}}, will be uploaded when you submit POCA this form <br/>
                                                    </div>
                                                    <div class="col-xs-12 ">
                                                        <button ng-click="user.dirOneFile = null" class="btn-lg btn-block  btn-danger">Remove file {{user.dirOneFile.name}}</span></button>
                                                    </div>
                                                    
    
                                                   <!---<div class="col-xs-12 col-sm-6 ">
                                                    POI is lock code for proof of ID
                                                        <button type="submit" id="" class="btn-lg btn-block  "  ng-click="uploadPic(idpicFile,'POI')" ng-disabled=" !idpicFile.name" ng-class="{'btn-clickAndGoBlue' : idpicFile.name}" >Upload ID</button>
                                                    </div>
                                                    --->
                                                </div>
                                                 
                                                   
                                                
                                          </ng-form>
                                        </div> <!--- / director 1 upload--->
                                        <div class="col-xs-12 col-sm-6 col-md-4"> <!---director 2 upload--->
                                            <br/>
                                            <label for="male" class="">Copy of ID- Director 2</label>
                                            <br/>
                                            
                                            <ng-form name="dirTwoUploadForm" >   
                                                 <div ng-show="!user.dirTwoFile">
                                                     <div ngf-drop name="file" ngf-select ng-model="user.dirTwoFile" class="drop-box" 
                                                        ngf-drag-over-class="'dragover'" ngf-multiple="false" ngf-allow-dir="true"
                                                        accept="image/*,application/pdf" 
                                                        ngf-pattern="'image/*,application/pdf'">
                                                        
                                                            Drop pdfs or images here or click to upload
                                                            <br/><br/>
                                                            <button >Select File</button>
                                                            
                                                      </div>
                                                      <span ng-show="!user.dirTwoFile">ID of director 2 not selected yet</span>
                                                  </div>
                                                  <div ng-show="user.dirTwoFile"> 
                                                      <h4 class="text-success">You have selected:</h4>
                                                      <h4 class="clickAndGoBlueText"><i class="fa fa-check-square-o" aria-hidden="true"></i> {{user.dirTwoFile.name}} {{user.dirTwoFile.$error}} {{user.dirTwoFile.$errorParam}}</h4> 
                                                      <img ng-show="dirTwoUploadForm.file.$valid" ngf-thumbnail="user.dirTwoFile" class="uploadThumb">
                                                      
                                                      <span ng-show="user.dirTwoFile.type === 'application/pdf'"  class="clickAndGoBlueText"><i class="fa fa-file-pdf-o fa-5x" aria-hidden="true"></i></span>
                                                      <br/><br/>
                                                     
                                                  </div>  
                                                
                                                  <div class="row" ng-show="user.dirTwoFile">
                                                   <div class="col-xs-12 text-center">
                                                        Your selected file, {{user.dirTwoFile.name}}, will be uploaded when you submit POCA form<br/>
                                                    </div>
                                                    <div class="col-xs-12  ">
                                                        <button ng-click="user.dirTwoFile = null"  class="btn-lg btn-block  btn-danger">Remove {{user.dirTwoFile.name}}</button>
                                                    </div>
                                                </div>
                                         </ng-form>
                                        </div><!--- / director 2  upload--->
                                        <div class="col-xs-12 col-sm-6 col-md-4"> <!--- Certificate of Incorporation upload--->
                                            <br/>
                                            <label for="male" class="">Certificate of Incorporation</label>
                                            <br/>
                                            
                                            <ng-form name="certOfIncorporationForm" >   
                                                 <div ng-show="!user.certOfIncorporationFile">
                                                     <div ngf-drop name="file" ngf-select ng-model="user.certOfIncorporationFile" class="drop-box" 
                                                        ngf-drag-over-class="'dragover'" ngf-multiple="false" ngf-allow-dir="true"
                                                        accept="image/*,application/pdf" 
                                                        ngf-pattern="'image/*,application/pdf'">
                                                        
                                                            Drop pdfs or images here or click to upload
                                                            <br/><br/>
                                                            <button >Select File</button>
                                                            
                                                      </div>
                                                      <span ng-show="!user.certOfIncorporationFile">Certificate of Incorporation not yet selected</span>
                                                  </div>
                                                  <div ng-show="user.certOfIncorporationFile"> 
                                                      <h4 class="text-success">You have selected:</h4>
                                                      <h4 class="clickAndGoBlueText"><i class="fa fa-check-square-o" aria-hidden="true"></i> {{user.certOfIncorporationFile.name}} {{user.certOfIncorporationFile.$error}} {{user.certOfIncorporationFile.$errorParam}}</h4> 
                                                      <img ng-show="certOfIncorporationForm.file.$valid" ngf-thumbnail="user.certOfIncorporationFile" class="uploadThumb">
                                                      
                                                      <span ng-show="user.certOfIncorporationFile.type === 'application/pdf'"  class="clickAndGoBlueText"><i class="fa fa-file-pdf-o fa-5x" aria-hidden="true"></i></span>
                                                      <br/><br/>
                                                     
                                                  </div>  
                                                
                                                  <div class="row" ng-show="user.certOfIncorporationFile">
                                                   <div class="col-xs-12 text-center">
                                                        Your selected file, {{user.certOfIncorporationFile.name}}, will be uploaded when you submit POCA form<br/>
                                                    </div>
                                                    <div class="col-xs-12  ">
                                                        <button ng-click="user.certOfIncorporationFile = null"  class="btn-lg btn-block  btn-danger">Remove {{user.certOfIncorporationFile.name}}</button>
                                                    </div>
                                                </div>
                                                <div class="col-xs-12">
                                                	We also need a copy of the Certificate of Incorporation and the valid ID of two Directors. If you are unable to upload them now, you have up to 15 days to bring them to us
                                                </div>
                                         </ng-form>
                                        </div><!--- /  Certificate of Incorporation upload--->	
                                    </div>
                                    <br/>
                                    <hr/>
                                    <br/>
                                    Do any of your named Executive Officers / Directors / Partners or Shareholders hold a prominent public position? (e.g. Member of Parliment or Senate, Mayor, Senior Government Official, Judiciary, Security Forces - ACP and above for JCF or Major and above for JDF)
                    
                                    <input type="radio" ng-model="user.isPEP" value="false" ng-init="user.isPEP = 'false'">No 
                                    <input type="radio" ng-model="user.isPEP" value="true">Yes
                                    <br/><br/>
                                    <div ng-if="user.isPEP=='true'" class="fadeIn" ng-init="isPEPArray=['feild'];user.pocaLastName = []; user.pocaFirstName = []; user.pocaMiddleName = [];user.pocaPosition = []; user.pocaIsMarried = [];user.pocaSpouseName = [];user.pocaSpouseAddress = [];isPEPChildrenArray = [['childFeild']]; user.pocaHasChildren = []; user.pocaChildName = [[';']]; user.pocaChildAddress = [[';']]"><!--- show hide poca--->
                                        <div ng-repeat="i in isPEPArray track by $index" ng-class-odd="'well'" >	<!---repeat for each poca--->
                                            <h3>Information for {{user.pocaFirstName[$index] || 'Person ' + ($index + 1)}} </h3>
                                            <hr/>
                                            <div class="col-xs-12 col-sm-4 fadeIn" ><!--- last name--->
                                                <!--label-->
                                                <span class="text-danger" ng-show="pocaComForm.pocaLastName{{$index}}.$error.required"><i class="fa fa-asterisk"></i> </span><label class="" for="male">Last Name:</label>
                                                <!--error message-->
                                                <div ng-show="pocaComForm.$submitted || pocaComForm.pocaLastName{{$index}}.$touched" class="text-danger">
                                                  <div ng-show="pocaComForm.pocaLastName{{$index}}.$error.required || pocaComForm.pocaLastName{{$index}}.$error.pattern">Last name required <br/>(no symbols or numbers)</div>
                                                </div>
                                                <input type="text"  ng-model="user.pocaLastName[$index]" name="pocaLastName{{$index}}"  class="form-control" ng-pattern="/^[A-Za-z\-\' ]+$/" placeholder="Last Name"  required=""  autocomplete="off" />
                                                <br/>
                                            </div><!--- end last name--->
                                            <div class="col-xs-12 col-sm-4 fadeIn" ><!--- first name--->
                                                <!--label-->
                                                <span class="text-danger" ng-show="pocaComForm.pocaFirstName{{$index}}.$error.required"><i class="fa fa-asterisk"></i> </span><label class="" for="male">First Name:</label>
                                                <!--error message-->
                                                <div ng-show="pocaComForm.$submitted || pocaComForm.pocaFirstName{{$index}}.$touched" class="text-danger">
                                                  <div ng-show="pocaComForm.pocaFirstName{{$index}}.$error.required || pocaComForm.pocaFirstName{{$index}}.$error.pattern">First name required <br/>(no symbols or numbers)</div>
                                                </div>
                                                <input type="text"  ng-model="user.pocaFirstName[$index]" name="pocaFirstName{{$index}}"  class="form-control" ng-pattern="/^[A-Za-z\-\' ]+$/" placeholder="First Name"  required=""  autocomplete="off" />
                                                <br/>
                                            </div><!--- end first name--->
                                            <div class="col-xs-12 col-sm-4 fadeIn" ><!--- middle name--->
                                                <!--label-->
                                                <span class="text-danger" ng-show="pocaComForm.pocaMiddleName{{$index}}.$error.required"><i class="fa fa-asterisk"></i> </span><label class="" for="male">Middle Name:</label>
                                                <!--error message-->
                                                <div ng-show="pocaComForm.$submitted || pocaComForm.pocaMiddleName{{$index}}.$touched" class="text-danger">
                                                  <div ng-show="pocaComForm.pocaMiddleName{{$index}}.$error.required || pocaComForm.pocaMiddleName{{$index}}.$error.pattern">(no symbols or numbers)</div>
                                                </div>
                                                <input type="text"  ng-model="user.pocaMiddleName[$index]" name="pocaMiddleName{{$index}}"  class="form-control" ng-pattern="/^[A-Za-z\-\' ]+$/" placeholder="Middle Name"  autocomplete="off" />
                                                <br/>
                                            </div><!--- end middle name--->
                                           
                                            <div class="col-xs-12  fadeIn" ><!--- position--->
                                                <!--label-->
                                                <span class="text-danger" ng-show="pocaComForm.pocaPosition{{$index}}.$error.required"><i class="fa fa-asterisk"></i> </span><label class="" for="male"> {{user.pocaFirstName[$index] || 'Person ' + ($index + 1)}}'s Position:</label>
                                                <!--error message-->
                                                <div ng-show="pocaComForm.$submitted || pocaComForm.pocaPosition{{$index}}.$touched" class="text-danger">
                                                  <div ng-show="pocaComForm.pocaPosition{{$index}}.$error.required || pocaComForm.pocaPosition{{$index}}.$error.pattern">Position required <br/>(no symbols or numbers)</div>
                                                </div>
                                                <input type="text"    ng-model="user.pocaPosition[$index]" name="pocaPosition{{$index}}"  class="form-control" ng-pattern="/^[A-Za-z\-\' ]+$/" placeholder="Position"  required=""  autocomplete="off" />
                                                <br/>
                                            </div>
                                            <!---end position--->
                                            <br/>
                                            <span class="text-danger" ng-show="pocaComForm.pocaIsMarried.$error.required"><i class="fa fa-asterisk"></i> </span> Does {{user.pocaFirstName[$index] && user.pocaLastName[$index] || 'Person ' + ($index + 1)}} have a Spouse? (This includes common law husband or wife)
                                            <input type="radio"  ng-model="user.pocaIsMarried[$index]" value="false" ng-required="!user.pocaIsMarried">No 
                                            <input type="radio" ng-model="user.pocaIsMarried[$index]" value="true" ng-required="!user.pocaIsMarried">Yes
                                            
                                            <div ng-if="user.pocaIsMarried[$index] == 'true'" class="fadeIn row"><!---Spouse info--->
                                                <br/>
                                                
                                                <span class="col-xs-12 col-sm-6 fadeIn" ><!--- Spouse name--->
                                                    <!--label-->
                                                    <span class="text-danger" ng-show="pocaComForm.pocaSpouseName{{$index}}.$error.required"><i class="fa fa-asterisk"></i> </span><label class="" for="male">Name of {{user.pocaFirstName[$parent.$index] || 'Person ' + ($index + 1)}}'s Spouse:</label>
                                                    <!--error message-->
                                                    <div ng-show="pocaComForm.$submitted || pocaComForm.pocaSpouseName{{$index}}.$touched" class="text-danger">
                                                      <div ng-show="pocaComForm.pocaSpouseName{{$index}}.$error.required || pocaComForm.pocaSpouseName{{$index}}.$error.pattern">Name of Spouse required <br/>(no symbols or numbers)</div>
                                                    </div>
                                                    <input type="text"  ng-model="user.pocaSpouseName[$index]" name="pocaSpouseName{{$index}}"  class="form-control" ng-pattern="/^[A-Za-z\-\' ]+$/" placeholder="Spouse Name"  required=""  autocomplete="off" />
                                                    <br/>
                                                </span><!--- end Spouse name--->
                                                <span class="col-xs-12 col-sm-6 fadeIn" ><!--- Spouse address--->
                                                    <!--label-->
                                                    <span class="text-danger" ng-show="pocaComForm.pocaSpouseAddress{{$index}}.$error.required"><i class="fa fa-asterisk"></i> </span><label class="" for="male">Address of {{user.pocaFirstName[$parent.$index] || 'Person ' + ($index + 1)}}'s Spouse:</label>
                                                    <!--error message-->
                                                    <div ng-show="pocaComForm.$submitted || pocaComForm.pocaSpouseAddress{{$index}}.$touched" class="text-danger">
                                                      <div ng-show="pocaComForm.pocaSpouseAddress{{$index}}.$error.required || pocaComForm.pocaSpouseAddress{{$index}}.$error.pattern">Spouse address required </div>
                                                    </div>
                                                    <input type="text"  ng-model="user.pocaSpouseAddress[$index]" name="pocaSpouseAddress{{$index}}"  class="form-control" placeholder="Spouse Address"  required=""  autocomplete="off" />
                                                    <br/>
                                                </span><!--- end  Spouse address--->
                                                
                                            </div><!--- end Spouse info--->
                                            <br/>
                                           
                                            <span class="text-danger" ng-show="pocaComForm.pocaHasChildren.$error.required"><i class="fa fa-asterisk"></i> </span> Does {{user.pocaFirstName[$index] || 'Person ' + ($index + 1)}} have any children?
                                            
                                            <input type="radio"  ng-model="user.pocaHasChildren[$index]" value="false" ng-required="!user.pocaHasChildren">No 
                                            <input type="radio" ng-model="user.pocaHasChildren[$index]" value="true" ng-required="!user.pocaHasChildren">Yes
                                            <br/>
                                            <span ng-if="user.pocaHasChildren[$index] == 'true'"  lass="fadeIn" ><!---child info--->
                                            	<!--Add remove buttons-->
                                                <div class="row">
                                                    <div class="row pull-right">
                                                       <div class="col-xs-12 ">
                                                        <a href ng-click="isPEPChildrenArray[$index].push('childFeild');" class="text-success"><i class="fa fa-plus-square" aria-hidden="true"></i> Add another child</a>
                                                        <a href ng-click="isPEPChildrenArray[$index].length > 1 && isPEPChildrenArray[$index].pop() " class="text-warning"><i class="fa fa-minus-square" aria-hidden="true"></i> Remove</a>
                                                       </div>
                                                    </div>
                                                </div>
                                                
                                                Information for {{user.pocaFirstName[$index] || 'Person ' + ($index + 1)}}'s children {{user.pocaChildName}}
                                                <hr/>
                                                <div ng-repeat="x in isPEPChildrenArray[$index] track by $index" class="fadeIn row ">
                                                	
                                                    <div class="col-xs-12 col-sm-6 fadeIn" ><!--- child name--->
                                                        <!--label-->
                                                        <span class="text-danger" ng-show="pocaComForm.pocaChildName{{$parent$index}}.$error.required"><i class="fa fa-asterisk"></i> </span><label class="" for="male">Name of child {{$index + 1}}:</label>
                                                        <!--error message-->
                                                        <div ng-show="pocaComForm.$submitted || pocaComForm.pocaChildName{{$parent$index}}.$touched" class="text-danger">
                                                          <div ng-show="pocaComForm.pocaChildName{{$parent$index}}.$error.required || pocaComForm.pocaChildName{{$parent$index}}.$error.pattern">Name of child required <br/>(no symbols or numbers)</div>
                                                        </div>
                                                        <input type="text"   ng-model="user.pocaChildName[$parent.$index][$index + 1]" name="pocaChildName{{$parent$index}}"  class="form-control" ng-pattern="/^[A-Za-z\-\' ]+$/" placeholder="Child Name"  required=""  autocomplete="off" />
                                                        <br/>
                                                    </div><!--- end child name--->
                                                    <div class="col-xs-12 col-sm-6 fadeIn" ><!--- child address--->
                                                        <!--label-->
                                                        <span class="text-danger" ng-show="pocaComForm.pocaChildAddress{{$parent$index}}.$error.required"><i class="fa fa-asterisk"></i> </span><label class="" for="male">Address of of child {{$index + 1}}:</label>
                                                        <!--error message-->
                                                        <div ng-show="pocaComForm.$submitted || pocaComForm.pocaChildAddress{{$parent$index}}.$touched" class="text-danger">
                                                          <div ng-show="pocaComForm.pocaChildAddress{{$parent$index}}.$error.required || pocaComForm.pocaChildAddress{{$parent$index}}.$error.pattern">Child address required </div>
                                                        </div>
                                                        <input type="text"  ng-model="user.pocaChildAddress[$parent.$index][$index + 1]" name="pocaChildAddress{{$parent$index}}"  class="form-control" placeholder="Child's Address"  required=""  autocomplete="off" />
                                                        <br/>
                                                    </div><!--- end  child address--->
                                            	</div>
                                            </span><!---end child info--->
                                            
                                           
                                            
                                     	</div> <!--- end repeat for each poca--->  
                                        
                                        <hr/>
                                        <!--Add remove buttons-->
                                        <div class="row pull-right">
                                           <div class="col-xs-12 ">
                                            <a href ng-click="isPEPArray.push('field'); user.pocaChildName.push([';']); user.pocaChildAddress.push([';']); isPEPChildrenArray.push(['childFeild'])" class="btn btn-success"><i class="fa fa-plus-square" aria-hidden="true"></i> Add another person</a>
                                            <a href ng-click="isPEPArray.length > 1 && isPEPArray.pop() && user.pocaChildName.pop() && user.pocaChildAddress.pop() && isPEPChildrenArray.pop()" class="btn btn-danger"><i class="fa fa-minus-square" aria-hidden="true"></i> Remove</a>
                                           </div>
                                        </div>
                                    </div><!--- end show hide poca--->
                                    
                                     <input type="hidden" ng-model="user.typeOfPOCA"/>
                                     <!---
    
                                        to test error checking
                                        
                                         {{pocaComForm.$error }}
                                         --->
     
                                        
                                        <!---
                                                                                    ERROR CHECKING
                                        
                                        <tt>pocaComForm.$valid = {{pocaComForm.$valid}}</tt><br>
                                        errors: {{pocaComForm.$error.required}}
                                        --->
   
                                        
                                        
                                        <br/> <br/>
                                        
                                        <uib-alert  type="warning" ng-show="pocaComForm.$invalid" ><i class="fa fa-info-circle"></i> You must fill out all the required form fields before proceeding</uib-alert>
                                        
                                        <br/>
                                       
                                        <div ng-if="inTwo.CODE == 'POCACOM'" ng-repeat="inTwo in client_locks"  >
                                            <button type="submit" id="pocaComBttn" class="btn-clickAndGoYellow btn-lg pull-right"  ng-click="submitPoca(pocaComForm.$valid, inTwo.ID)" >Proceed<span class="hidden-xs">, I verify that all this information is correct</span></button>
                                        </div>
                                    	
                                    	
                                    
                                    
                             </form>  
                         </div><!---end of poca com form--->
                      </div>
                 </div> <!--- end row for supporting com poca divs--->
             </div>  <!--- end container for supporting com poca divs --->
  			 <!--- end commercial poca--->             
              
            
            <div id="pocaForm"  class="container"  ng-show="lockSwitch=='POCA'"><!--- container for supporting divs --->
                    	<div class="row"><!--- row for supporting divs--->
                        	
                            <div class="col-sm-9  form-box ">                          
                                <div class="kioskGeneralForm wrapper " > <!---start of poca form--->
                                	<span>
                                    	The Proceeds of Crime Act (POCA) 2007 requires all Financial Institutions to collect and maintain your most current information. We therefore ask that you complete and return this form so that your records can be updated accordingly. Failure to do so will prevent completion of the policy contract documentation.
                                	</span>
                                    <br/><br/>
                                    <form  name="pocaForm"  novalidate>    

                                           
                                            <div class="form-group">
                                                <span class="text-danger" ng-show="pocaForm.PolicyNumber.$error.required"><i class="fa fa-asterisk"></i> </span><label class="" for="male">Policy Number:</label>
                                                <div ng-show="pocaForm.$submitted || pocaForm.PolicyNumber.$touched" class="text-danger">
                                                  <div ng-show="pocaForm.PolicyNumber.$error.required || pocaForm.PolicyNumber.$error.pattern">Policy number required (numbers only, max 11 numbers)</div>
                                                </div>
                                                <input type="text"  ng-model="user.PolicyNumber" name="PolicyNumber"  ng-pattern="/^[0-9]{1,11}$/" class="form-control"  placeholder="Policy Number" required=""  autocomplete="off"/>
                                                
                                            </div>
                                            
                                            <div class="form-group">
                                                <span class="text-danger" ng-show="pocaForm.FirstName.$error.required || pocaForm.LastName.$error.required  "><i class="fa fa-asterisk"></i> </span><label class="" for="male">Name:</label>
                                                <div class="row">
                                                	<div class="col-xs-12 col-sm-12 col-md-4 col-lg-4">
                                                        <div ng-show="pocaForm.$submitted || pocaForm.comLeagalName.$touched" class="text-danger">
                                                          <div ng-show="pocaForm.comLeagalName.$error.required || pocaForm.comLeagalName.$error.pattern">Surname Required (no symbols or numbers)</div>
                                                        </div>
                                                        <input type="text" ng-model="user.comLeagalName"  required="" ng-pattern="/^[A-Za-z\-\' ]+$/" name="comLeagalName" class="form-control"  placeholder="Surname" autocomplete="off"/>
                                                    </div>
                                                    <div class="col-xs-12 col-sm-12 col-md-4 col-lg-4">
                                                        <div ng-show="pocaForm.$submitted || pocaForm.FirstName.$touched" class="text-danger">
                                                          <div ng-show="pocaForm.FirstName.$error.required || pocaForm.FirstName.$error.pattern">First name Required (no symbols or numbers)</div>
                                                        </div>
                                                        <input type="text" ng-model="user.FirstName" required="" name="FirstName" ng-pattern="/^[A-Za-z\-\' ]+$/" class="form-control"  placeholder="First Name" autocomplete="off"/>
                                                    </div>
                                                    <div class="col-xs-12 col-sm-12 col-md-4 col-lg-4">
                                                        <div ng-show="pocaForm.$submitted || pocaForm.MiddleName.$touched" class="text-danger">
                                                          <div ng-show="pocaForm.MiddleName.$error.required || pocaForm.MiddleName.$error.pattern"><i class="fa fa-info-circle"></i> Oops, no symbols or numbers</div>
                                                        </div>
                                                        <input type="text" ng-model="user.MiddleName"  ng-pattern="/^[A-Za-z\-\' ]+$/" name="MiddleName" class="form-control"  placeholder="Middle Name" autocomplete="off"/>
                                                    </div>
                                                    
                                                </div>
                                            </div>
                                            
                                            
                                            <div class="form-group">
                                                
                                                <div class="row">
                                                    <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
                                                    	<label for="male" class="">Other Names (including aliases):</label>
                                               		 	<input type="text" ng-model="user.otherName" name="otherName" class="form-control"  placeholder="Other Name (Otherwise Known As)" autocomplete="off"/>
                                                    </div>
                                                    <!--
                                                    <div class="col-xs-12 col-sm-12 col-md-4 col-lg-4">
                                                    	<div ng-show="pocaForm.$submitted || pocaForm.MotherFirstName.$touched" class="text-danger">
                                                          <div ng-show="pocaForm.MotherFirstName.$error.required || pocaForm.MotherFirstName.$error.pattern">First name required (no symbols or numbers)</div>
                                                        </div>
                                                        <input type="text" ng-model="user.MotherFirstName"  required="" ng-pattern="/^[A-Za-z\-\' ]+$/" name="MotherFirstName" class="form-control "  placeholder="Mothers First Name" autocomplete="off"/>
                                                    </div>
                                                    <div class="col-xs-12 col-sm-12 col-md-4 col-lg-4">
                                                    	<div ng-show="pocaForm.$submitted || pocaForm.MotherMiddleName.$touched" class="text-danger">
                                                          <div ng-show="pocaForm.MotherMiddleName.$error.required || pocaForm.MotherMiddleName.$error.pattern"><i class="fa fa-info-circle"></i> Oops, no symbols or numbers</div>
                                                        </div>
                                                        <input type="text" ng-model="user.MotherMiddleName"  ng-pattern="/^[A-Za-z\-\' ]+$/" name="MotherMiddleName" class="form-control"  placeholder="Mother's Middle Name" autocomplete="off"/>
                                                    </div>
                                                    -->
                                                    <span class="text-danger" ng-show="pocaForm.MotherLastName.$error.required"><i class="fa fa-asterisk"></i> </span><label for="male">Mother's Maiden Name:</label><br/>
                                                    <div class="col-xs-12 col-sm-12 col-md-6">
                                                    	<div ng-show="pocaForm.$submitted || pocaForm.MotherLastName.$touched" class="text-danger">
                                                          <div ng-show="pocaForm.MotherLastName.$error.required || pocaForm.MotherLastName.$error.pattern">Mother's maiden name required (no symbols or numbers)</div>
                                                        </div>
                                                        <input type="text" ng-model="user.MotherLastName"  required="" ng-pattern="/^[A-Za-z\-\' ]+$/" name="MotherLastName" class="form-control "  placeholder="Mother's Maiden Name" autocomplete="off"/>
                                                    </div>
                                                </div>
                                            </div>
                                            
                                            
                                            <div class="form-group">
                                                <span class="text-danger" ng-show="pocaForm.personTitle.$error.required"><i class="fa fa-asterisk"></i> </span><label for="male">Title:</label><br/>
                                                <div class="row">
                                                	<div class="col-xs-12 fadeIn" >
                                                        <!--error message-->
                                                        <div ng-show="pocaForm.$submitted || pocaForm.personTitle.$touched" class="text-danger">
                                                          <div ng-show="pocaForm.personTitle.$error.required || pocaForm.personTitle.$error.pattern">Title required</div>
                                                        </div>
                                                    </div>
                                                    <div class="col-xs-12 " >
                                                		<input type="radio" ng-model="user.personTitle" name="personTitle" value="Mr" ng-required="!user.personTitle">Mr. 
                                                    
                                                        <input type="radio" ng-model="user.personTitle"  name="personTitle" value="Mrs" ng-required="!user.personTitle">Mrs.
                                                   
                                                        <input type="radio" ng-model="user.personTitle"  name="personTitle" value="Miss" ng-required="!user.personTitle">Miss
                                                        
                                                        <input type="radio" ng-model="user.personTitle"  name="personTitle" value="Ms" ng-required="!user.personTitle">Ms.
                                                        
                                                        <input type="radio" ng-model="user.personTitle"  name="personTitle" value="Other" ng-required="!user.personTitle">Other
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div ng-show="user.personTitle == 'Other'"  class="fadeIn"> <!---  --->
                                                    <span class="text-danger" ng-show="pocaForm.otherTitle.$error.required"><i class="fa fa-asterisk"></i> </span><label class="" for="male">State title:</label>
                                                    <div ng-show="pocaForm.$submitted || pocaForm.otherTitle.$touched" class="text-danger">
                                                      <div ng-show="pocaForm.otherTitle.$error.required"><i class="fa fa-asterisk"></i> You need to tell us your title</div>
                                                    </div>
                                                    <input type="text" ng-model="user.otherTitle"  ng-required="user.personTitle == 'Other'" name="otherTitle" class="form-control"  placeholder="Other title" autocomplete="off"/>   
                                                </div>
                                             </div>
                                            
                                            <span class="text-danger" ng-show="pocaForm.dobday.$error.required || pocaForm.dobmonth.$error.required || pocaForm.year.$error.required"><i class="fa fa-asterisk"></i> </span><label for="male">Date of Birth:</label><br/>
                                           <div class="form-group">
                                                <div class="row">
                                                       
                                                    <div class="col-xs-12 col-sm-4 col-md-4 col-lg-4">
                                                    	<div ng-show="pocaForm.$submitted || pocaForm.dobday.$touched" class="text-danger">
                                                          <div ng-show="pocaForm.dobday.$error.required">Day required</div>
                                                        </div>
                                                        <select ng-model="user.dobday"  required=""  name="dobday"  class="form-control ">
                                                          <option value="">Day</option>
                                                          <option value="">---</option>
                                                          <option value="01">01</option>
                                                          <option value="02">02</option>
                                                          <option value="03">03</option>
                                                          <option value="04">04</option>
                                                          <option value="05">05</option>
                                                          <option value="06">06</option>
                                                          <option value="07">07</option>
                                                          <option value="08">08</option>
                                                          <option value="09">09</option>
                                                          <option value="10">10</option>
                                                          <option value="11">11</option>
                                                          <option value="12">12</option>
                                                          <option value="13">13</option>
                                                          <option value="14">14</option>
                                                          <option value="15">15</option>
                                                          <option value="16">16</option>
                                                          <option value="17">17</option>
                                                          <option value="18">18</option>
                                                          <option value="19">19</option>
                                                          <option value="20">20</option>
                                                          <option value="21">21</option>
                                                          <option value="22">22</option>
                                                          <option value="23">23</option>
                                                          <option value="24">24</option>
                                                          <option value="25">25</option>
                                                          <option value="26">26</option>
                                                          <option value="27">27</option>
                                                          <option value="28">28</option>
                                                          <option value="29">29</option>
                                                          <option value="30">30</option>
                                                          <option value="31">31</option>
                                                        </select>
                                                    </div>
                                                    <div class="col-xs-12 col-sm-4 col-md-4 col-lg-4">
                                                    	<div ng-show="pocaForm.$submitted || pocaForm.dobmonth.$touched" class="text-danger">
                                                          <div ng-show="pocaForm.dobmonth.$error.required">Month required</div>
                                                        </div>
                                                        <select ng-model="user.dobmonth"  required=""  name="dobmonth" class="form-control ">
                                                          <option value="">Month</option>
                                                          <option value="">-----</option>
                                                          <option value="01">January</option>
                                                          <option value="02">February</option>
                                                          <option value="03">March</option>
                                                          <option value="04">April</option>
                                                          <option value="05">May</option>
                                                          <option value="06">June</option>
                                                          <option value="07">July</option>
                                                          <option value="08">August</option>
                                                          <option value="09">September</option>
                                                          <option value="10">October</option>
                                                          <option value="11">November</option>
                                                          <option value="12">December</option>
                                                        </select>
                                                    </div>
                                                    <div class="col-xs-12 col-sm-4 col-md-4 col-lg-4">
                                                    	<div ng-show="pocaForm.$submitted || pocaForm.year.$touched" class="text-danger">
                                                          <div ng-show="pocaForm.year.$error.required || pocaForm.year.$error.pattern">Year required (numbers only)</div>
                                                        </div>
                                            			<input type="text" ng-model="user.year"  required="" ng-pattern="/^[0-9]{4}$/" name="year" class="form-control  "  placeholder="Your Birth Year" autocomplete="off"/>
                                                    </div>
                                                </div>
                                            </div>
                                            
                                            <div class="form-group">
                                                <div class="row">
                                                    <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
                                                    	<span class="text-danger" ng-show="pocaForm.CountryofBirth.$error.required"><i class="fa fa-asterisk"></i> </span><label for="male" class="">Place (Parish) of Birth:</label>
                                                        <div ng-show="pocaForm.$submitted || pocaForm.CountryofBirth.$touched" class="text-danger">
                                                          <div ng-show="pocaForm.CountryofBirth.$error.required || pocaForm.CountryofBirth.$error.pattern">Parish required (letters only)</div>
                                                        </div>
                                               		 	 <input type="text"  ng-model="user.CountryofBirth"  required=""  name="CountryofBirth" class="form-control"  placeholder="Parish of Birth" />
                                                    </div>
                                                    <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
                                                        <span class="text-danger" ng-show="pocaForm.Nationality.$error.required"><i class="fa fa-asterisk"></i> </span><label for="male" class="">Nationality:</label>
                                                        <div ng-show="pocaForm.$submitted || pocaForm.Nationality.$touched" class="text-danger">
                                                          <div ng-show="pocaForm.Nationality.$error.required || pocaForm.Nationality.$error.pattern">Nationality required (letters only)</div>
                                                        </div>
                                                        <input type="text" ng-model="user.Nationality"  required="" name="Nationality" ng-pattern="/^[A-Za-z]+$/"  class="form-control"  placeholder="Nationality"/>
                                                    </div>
                                                </div>
                                            </div>
                                            
                                            
                                            <div class="form-group">
                                               
                                                <div class="row">
                                                    <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
                                                    	
                                                        <span class="text-danger" ng-show="pocaForm.idType.$error.required"><i class="fa fa-asterisk"></i> </span><label class=""  for="male">Identification type:</label><br/>
                                                        <div ng-show="pocaForm.$submitted || pocaForm.idType.$touched" class="text-danger">
                                                          <div ng-show="pocaForm.idType.$error.required ">ID type required</div>
                                                        </div>
                                                        
                                                        <select ng-model="user.idType"  required="" name="idType" class="form-control  ">
                                                          <option value="">ID Type</option>
                                                          <option value="">-----</option>
                                                          <!--- <option value="TRN">TRN</option>--->
                                                         <option value="DLNo">Driver's Licence</option>
                                                          <option value="PPort">Passport</option>
                                                          <option value="NID">National ID</option>
                                                          <option value="Other">Other</option>
                                                        </select>
                                                    </div>
                                                    <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
                                                    	
                                                        <span class="text-danger" ng-show="pocaForm.idNumber.$error.required"><i class="fa fa-asterisk"></i> </span><label class=""  for="male">ID number:</label><br/>
                                                        
                                                        <div ng-show="pocaForm.$submitted || pocaForm.idNumber.$touched" class="text-danger">
                                                          <div ng-show="pocaForm.idNumber.$error.required ">ID number required</div>
                                                        </div>
                                                        <input type="text" ng-model="user.idNumber"  required="" name="idNumber" class="form-control "  placeholder="Identification Number" autocomplete="off"/>
                                                    </div>
                                                </div>
                                            </div>
                                            
                                            <div class="form-group">
                                                <div ng-show="user.idType == 'Other'"><!---  --->
                                                    <label class="sr-only" for="male">Specify Type of ID:</label>
                                                    <div ng-show="pocaForm.$submitted || pocaForm.otherIDType.$touched" class="text-danger">
                                                      <div ng-show="pocaForm.otherIDType.$error.required "><i class="fa fa-asterisk"></i> What type if ID are you using?</div>
                                                    </div>
                                                    <input type="text" ng-model="user.otherIDType"  ng-required="user.idType == 'Other'" name="otherIDType" class="form-control"  placeholder="Describe Type of ID" autocomplete="off"/>
                                                </div>
                                           </div>
                                           <span class="text-danger" ng-show="pocaForm.expDay.$error.required ||pocaForm.expmonth.$error.required || pocaForm.expyear.$error.required"><i class="fa fa-asterisk"></i> </span><label for="male">ID Expiry Date:</label><br/>
                                            <div class="form-group">
                                                <div class="row">
                                                       
                                                    <div class="col-xs-12 col-sm-12 col-md-4 col-lg-4">
                                                        <div ng-show="pocaForm.$submitted || pocaForm.expDay.$touched" class="text-danger">
                                                          <div ng-show="pocaForm.expDay.$error.required ">Day is required</div>
                                                        </div>
                                                        <select ng-model="user.expDay"  required="" name="expDay"  class="form-control ">
                                                          <option value="">Day</option>
                                                          <option value="">---</option>
                                                          <option value="01">01</option>
                                                          <option value="02">02</option>
                                                          <option value="03">03</option>
                                                          <option value="04">04</option>
                                                          <option value="05">05</option>
                                                          <option value="06">06</option>
                                                          <option value="07">07</option>
                                                          <option value="08">08</option>
                                                          <option value="09">09</option>
                                                          <option value="10">10</option>
                                                          <option value="11">11</option>
                                                          <option value="12">12</option>
                                                          <option value="13">13</option>
                                                          <option value="14">14</option>
                                                          <option value="15">15</option>
                                                          <option value="16">16</option>
                                                          <option value="17">17</option>
                                                          <option value="18">18</option>
                                                          <option value="19">19</option>
                                                          <option value="20">20</option>
                                                          <option value="21">21</option>
                                                          <option value="22">22</option>
                                                          <option value="23">23</option>
                                                          <option value="24">24</option>
                                                          <option value="25">25</option>
                                                          <option value="26">26</option>
                                                          <option value="27">27</option>
                                                          <option value="28">28</option>
                                                          <option value="29">29</option>
                                                          <option value="30">30</option>
                                                          <option value="31">31</option>
                                                        </select>
                                                    </div>
                                                    <div class="col-xs-12 col-sm-12 col-md-4 col-lg-4">
                                                    	<div ng-show="pocaForm.$submitted || pocaForm.expmonth.$touched" class="text-danger">
                                                          <div ng-show="pocaForm.expmonth.$error.required ">Month is required</div>
                                                        </div>
                                                        <select ng-model="user.expmonth"  required="" name="expmonth"  class="form-control ">
                                                          <option value="">Month</option>
                                                          <option value="">-----</option>
                                                          <option value="01">January</option>
                                                          <option value="02">February</option>
                                                          <option value="03">March</option>
                                                          <option value="04">April</option>
                                                          <option value="05">May</option>
                                                          <option value="06">June</option>
                                                          <option value="07">July</option>
                                                          <option value="08">August</option>
                                                          <option value="09">September</option>
                                                          <option value="10">October</option>
                                                          <option value="11">November</option>
                                                          <option value="12">December</option>
                                                        </select>
                                                    </div>
                                                    <div class="col-xs-12 col-sm-12 col-md-4 col-lg-4">
                                                    	<div ng-show="pocaForm.$submitted || pocaForm.expyear.$touched" class="text-danger">
                                                          <div ng-show="pocaForm.expyear.$error.required || pocaForm.expyear.$error.pattern">Year required (numbers only)</div>
                                                        </div>
                                            			<input type="text" ng-model="user.expyear"  required="" ng-pattern="/^[0-9]{4}$/" name="expyear" class="form-control  "  placeholder="Expiry Year" autocomplete="off"/>
                                                    </div>
                                                </div>
                                            </div>
                                           <div class="form-group">
                                           		
                                           		<span class="text-danger" ng-show="pocaForm.TRNNumber.$error.required"><i class="fa fa-asterisk"></i> </span><label>Taxpayer Registration Number:</label>
                                                <div ng-show="pocaForm.$submitted || pocaForm.TRNNumber.$touched" class="text-danger">
                                                  <div ng-show="pocaForm.TRNNumber.$error.required || pocaForm.TRNNumber.$error.pattern">TRN is required (9 numbers)</div>
                                                </div>
                                                <input type="text" ng-model="user.TRNNumber"  required="" ng-pattern="/^[0-9]{9}$/" name="TRNNumber" class="form-control  "  placeholder="TRN Number" autocomplete="off"/>  
                                            </div> 
                                               
                                               
                                               
                                            <div class="form-group">
                                            	<span class="text-danger" ng-show="pocaForm.addr1.$error.required"><i class="fa fa-asterisk"></i> </span><label for="male" class="">Home address:</label>
                                                <div ng-show="pocaForm.$submitted || pocaForm.addr1.$touched" class="text-danger">
                                                  <div ng-show="pocaForm.addr1.$error.required">Address is required</div>
                                                </div>
                                               <input type="text" ng-model="user.addr1"  required="" name="addr1" class="form-control"  placeholder="Your Home Address" autocomplete="off"/>
                                            </div>
                                            
                                            
                                            <span class="text-danger" ng-show="pocaForm.mailingdifferent.$error.required"><i class="fa fa-asterisk"></i> </span><label>Is your mailing address different from your home address?</label> <br/>
                                            <div class="row">
                                                <div class="col-xs-12 fadeIn" >
                                                    <!--error message-->
                                                    <div ng-show="pocaForm.$submitted || pocaForm.mailingdifferent.$touched" class="text-danger">
                                                      <div ng-show="pocaForm.mailingdifferent.$error.required || pocaForm.mailingdifferent.$error.pattern">Title required</div>
                                                    </div>
                                                </div>
                                            </div>
                                            <input type="radio" ng-model="user.mailingdifferent" name="mailingdifferent" value="false" ng-required="!user.mailingdifferent">No 
                                            <input type="radio" ng-model="user.mailingdifferent" name="mailingdifferent" value="true" ng-required="!user.mailingdifferent">Yes
                                            <br/>
                                            <div class="form-group">
                                                <div ng-show="user.mailingdifferent == 'true'" class="fadeIn"> <!---  --->
                                                    <label class="" for="male">Mailing Address</label>
                                                    <div ng-show="pocaForm.$submitted || pocaForm.mailingAddr.$touched" class="text-danger">
                                                      <div ng-show="pocaForm.mailingAddr.$error.required"><i class="fa fa-asterisk"></i> You need to tell us your new address</div>
                                                    </div>
                                                    <input type="text" ng-model="user.mailingAddr"  ng-required="user.mailingdifferent == 'true'" name="mailingAddr" class="form-control"  placeholder="Mailing Address" autocomplete="off"/>   
                                                </div>
                                             </div>
                                             
                                             
                                            
                                            
                                            <div class="form-group">
                                                <span class="text-danger" ng-show="pocaForm.CellNumber.$error.required"><i class="fa fa-asterisk"></i> </span><label class=""  for="male">Telephone Numbers. Enter digits ONLY:</label>
                                                <div class="row">
                                                	<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                                                    	<div ng-show="pocaForm.$submitted || pocaForm.CellNumber.$touched || pocaForm.HomeNumber.$touched || pocaForm.WorkNumber.$touched" class="text-danger">
                                                          <div ng-show="pocaForm.CellNumber.$error.required || pocaForm.CellNumber.$error.pattern || pocaForm.HomeNumber.$error.pattern || pocaForm.WorkNumber.$error.pattern">
                                                          	At least one number required (7 digits minimum, numbers / digits only)
                                                            <br/>
                                                            <i class="fa fa-info-circle"></i> Remember the area code (876 for Jamaica)</div>
                                                            <br/>
                                                        </div>
                                                    </div>
                                                    
                                                    <div class="col-xs-12 col-sm-12 col-md-4 col-lg-4">
                                                    	<label for="male" class="">Home:</label><br/>
                                                        {{user.HomeNumber | telFilter}} 
                                                        <input type="text" ng-model="user.HomeNumber"  ng-pattern="/^[0-9]{7,}$/" name="HomeNumber" class="form-control "  placeholder="xxxxxxxxxx"  autocomplete="off"/>
                                                    </div>
                                                    <div class="col-xs-12 col-sm-12 col-md-4 col-lg-4">
                                                    	<label for="male" class="">Mobile:</label><br/>
                                                        {{user.CellNumber | telFilter}}
                                                        <input type="text" ng-model="user.CellNumber"  ng-required="!user.WorkNumber && !user.HomeNumber" ng-pattern="/^[0-9]{7,}$/" name="CellNumber" class="form-control "  placeholder="xxxxxxxxxx" autocomplete="off"/>
                                                    </div>
                                                    <div class="col-xs-12 col-sm-12 col-md-4 col-lg-4">
                                                    	<label for="male" class="">Work:</label><br/>
                                                        {{user.WorkNumber | telFilter}} 
                                                        <input type="text" ng-model="user.WorkNumber"   ng-pattern="/^[0-9]{7,}$/" name="WorkNumber" class="form-control "  placeholder="xxxxxxxxxx"  autocomplete="off"/>
                                                    </div>
                                                </div>
                                            </div>
                                            
                                           
                                            <div class="form-group">
                                                <div class="row">
                                                    <div class= "col-xs-12">
                                                     	<span class="text-danger" ng-show="pocaForm.emailAddress.$error.required || pocaForm.emailAddress.$error.pattern"><i class="fa fa-asterisk"></i> </span><label for="male"  class="">Email Address:</label>
                                                        <div ng-show="pocaForm.$submitted || pocaForm.emailAddress.$touched" class="text-danger">
                                                          <div ng-show="pocaForm.emailAddress.$error.required || pocaForm.emailAddress.$error.pattern">Please enter a valid email address</div>
                                                        </div>
                                                        <input type="text" ng-model="user.emailAddress" name="emailAddress" required=""  class="form-control" ng-pattern="/^[^\s/]+(\.[^\s/]+)*@[^\s/]+(\.[^\s/]+)*(\.[^\s/]{2,4})$/"  placeholder="Your Email Address"  autocomplete="off"/>
                                           			</div>
                                                </div>
                                            </div>
                                            
                                             
                                                                               
                                            <label for="male"></label>
                                            <div class="form-group">
                                            	
                                            	<span class="text-danger" ng-show="pocaForm.occupation_industry.$error.required"><i class="fa fa-asterisk"></i> </span><label for="male" class="">Occupation (businesswoman / businessman or self-employed is not acceptable):</label>
                                             	<div ng-show="pocaForm.$submitted || pocaForm.occupation_industry.$touched" class="text-danger">
                                                  <div ng-show="pocaForm.occupation_industry.$error.required ">Occupation required (no symbols or numbers)</div>
                                                </div>
                                                <input type="text"  ng-model="user.occupation_industry"  required=""  name="occupation_industry" class="form-control "  placeholder="Your Occupation" autocomplete="off"/>
                                            </div>
                                            <div class="form-group">
                                           		 <span class="text-danger" ng-show="pocaForm.anotherSource.$error.required"><i class="fa fa-asterisk"></i> </span><label>Do you have any other source of income?</label> 
                                                <input type="radio" ng-model="user.anotherSource" name="anotherSource" ng-required="!user.anotherSource" value="false" >No 
                                                <input type="radio" ng-model="user.anotherSource"  name="anotherSource" ng-required="!user.anotherSource" value="true">Yes
                                            </div>
                                           
                                           <div class="form-group">
                                                <div ng-show="user.anotherSource == 'true'">
                                                    <label class="sr-only" for="male">Describe Source:</label>
                                                    <div ng-show="pocaForm.$submitted || pocaForm.descSrc.$touched" class="text-danger">
                                                      <div ng-show="pocaForm.descSrc.$error.required "><i class="fa fa-asterisk"></i> Please tell us about the other source</div>
                                                    </div>
                                                    <input type="text" ng-model="user.descSrc"  ng-required="anotherSource == 'true'" name="descSrc" class="form-control"  placeholder="Describe other source" autocomplete="off"/> 
                                                </div>
                                           </div>
                                           
                                           <div class="form-group">
                                           		<div class="row">
													<div class="col-xs-12">
                                                        <span class="text-danger" ng-show="pocaForm.Employername.$error.required"><i class="fa fa-asterisk"></i> </span><label for="male"> Employer Name: </label>
                                                        
                                                        <div ng-show="pocaForm.$submitted || pocaForm.Employername.$touched" class="text-danger">
                                                          <div ng-show="pocaForm.Employername.$error.required ">Employer's name is required</div>
                                                        </div>
                                                        <input type="text" ng-model="user.Employername"  required="" name="Employername"  class="form-control "  placeholder="Employer Name" autocomplete="off"/>
													</div>

													<br/>
                                                 	<div class="col-xs-12">
                                                        <span class="text-danger" ng-show="pocaForm.Employeraddr1.$error.required"><i class="fa fa-asterisk"></i> </span><label for="male"> Employer Address: </label>
                                                        
                                                        <div ng-show="pocaForm.$submitted || pocaForm.Employeraddr1.$touched" class="text-danger">
                                                          <div ng-show="pocaForm.Employeraddr1.$error.required ">Employer's address and name is required</div>
                                                        </div>
                                                        <input type="text" ng-model="user.Employeraddr1"  required="" name="Employeraddr1"  class="form-control "  placeholder="Employer Address" autocomplete="off"/>
													</div>
                                                </div>
                                           </div>
                                            
                                           <div class="form-group"><!---phone numbers--->
                                               <!--label-->
                                               <span class="text-danger" ng-show="EmployernumbersForm.$invalid"><i class="fa fa-asterisk"></i> </span><label class="" for="male">Employer Telephone Number(s). Enter digits ONLY::</label>
                                               <br/>
                                                
                                                <!--Add remove buttons-->
                                                <div class="row pull-right">
                                                   <div class="col-xs-12 ">
                                                    <a href ng-click="EmployernumbersArray.push('field')" class="text-success"><i class="fa fa-plus-square" aria-hidden="true"></i> Add another number</a>
                                                    <a href ng-click="EmployernumbersArray.length > 1 && EmployernumbersArray.pop()" class="text-warning"><i class="fa fa-minus-square" aria-hidden="true"></i> Remove</a>
                                                   </div>
                                                </div>
                                                
                                                
                                                <span class="" ng-show="EmployernumbersForm.$invalid">
                                                    <i class="fa fa-info-circle"></i>7 digits minimum, numbers / digits only. Remember the area code (876 for Jamaica)
                                                    <br/>
                                                </span>
                                                
                                                
                                                <!--form to repeat feild-->
                                                <div class="row"  ng-init="user.EmployernumbersArray = []" >
                                                    <ng-form name="EmployernumbersForm" ng-init="EmployernumbersArray=['feild']">
                                                        <span ng-repeat="i in EmployernumbersArray track by $index"  class="fadeIn" >
                                                            <div class="col-xs-12 col-sm-4 fadeIn" >
                                                                <!--error message-->
                                                                <div ng-show="EmployernumbersForm.$submitted || EmployernumbersForm.EmployernumbersArray{{$index}}.$touched" class="text-danger">
                                                                  <div ng-show="EmployernumbersForm.EmployernumbersArray{{$index}}.$error.required || EmployernumbersForm.EmployernumbersArray{{$index}}.$error.pattern">No dashes or spaces. Numbers ONLY </div>
                                                                </div>
                                                                <input type="text"   ng-model="user.EmployernumbersArray[$index]" name="EmployernumbersArray{{$index}}"  ng-pattern="/^[0-9]{7,}$/"  class="form-control"  placeholder="xxxxxxxxxx"    autocomplete="off" />
                                                                <br/>
                                                            </div>
                                                        </span>
                                                    </ng-form>
                                                </div>
                                            </div><!--- end phone numbers---> 
                                            
                                            
                                            
                                            <br/>
                                            
                                           
                                            <hr ng-init="user.pocaIsMarried = [];user.pocaSpouseName = [];user.pocaSpouseAddress = [];isPEPChildrenArray = [['childFeild']]; user.pocaHasChildren = []; user.pocaChildName = [';']; user.pocaChildAddress = [[';']]"/>
                                            
                                            <div class="form-group">
                                           		<span class="text-danger" ng-show="pocaForm.isPEP.$error.required"><i class="fa fa-asterisk"></i> </span><label>Have you or any relative or close associate been entrusted with prominent public functions? (e.g. Member of Parliament or Senate, Mayor, Senior Government Official, Judiciary, Security Forces - ACP and above for JCF or Major and above for JDF)</label> 
                                                <input type="radio" ng-model="user.isPEP" value="false"  name="isPEP"  ng-required="!user.isPEP">No 
                                                <input type="radio"  ng-model="user.isPEP" value="true" name="isPEP" ng-required="!user.isPEP" >Yes   
                                            </div>
                                            
                                           <div ng-if = "user.isPEP == 'true'" >
                                                
                                                <span class="text-danger" ng-show="pocaForm.prominentOfficer.$error.required"><i class="fa fa-asterisk"></i> </span><label>Are you the holder of the office?</label> 
                                                <input type="radio"  ng-model="user.PEPisMe" ng-required="user.isPEP == 'true'"  value="false" name="prominentOfficer" >No 
                                                <input type="radio"  ng-model="user.PEPisMe"ng-required="user.isPEP == 'true'"  value="true" name="prominentOfficer">Yes
                                                <br/><br/>
                                                
                                                
                                                <span class="text-danger" ng-show="pocaForm.descprominentOfficer.$error.required"><i class="fa fa-asterisk"></i> </span><label class="" for="male">Please Describe: </label>
                                                <div ng-show="pocaForm.$submitted || pocaForm.descprominentOfficer.$touched" class="text-danger">
                                                  <div ng-show="pocaForm.descprominentOfficer.$error.required"><i class="fa fa-asterisk"></i> Please describe your relation</div>
                                                </div>
                                                <input type="text" ng-model="user.descprominentOfficer" ng-required="user.isPEP == 'true'"  name="descprominentOfficer" class="form-control"  placeholder="Enter description" autocomplete="off"/>
                                                <div ng-show="pocaForm.$submitted || pocaForm.descprominentOfficer.$touched" class="text-danger">
                                                  <div ng-show="pocaForm.PEPisMe.$error.required"><i class="fa fa-asterisk"></i> Do you hould the office?</div>
                                                </div>
                                                
                                                <div class="col-xs-12 col-sm-4 fadeIn" ><!--- last name--->
                                                    <!--label-->
                                                    <span class="text-danger" ng-show="pocaForm.pocaLastName.$error.required"><i class="fa fa-asterisk"></i> </span><label class="" for="male">Last Name:</label>
                                                    <!--error message-->
                                                    <div ng-show="pocaForm.$submitted || pocaForm.pocaLastName.$touched" class="text-danger">
                                                      <div ng-show="pocaForm.pocaLastName.$error.required || pocaForm.pocaLastName.$error.pattern">Last name required <br/>(no symbols or numbers)</div>
                                                    </div>
                                                    <input type="text"  ng-model="user.pocaLastName" name="pocaLastName"  class="form-control" ng-pattern="/^[A-Za-z\-\' ]+$/" placeholder="Last Name" ng-required="user.isPEP == 'true'"  autocomplete="off" />
                                                    <br/>
                                                </div><!--- end last name--->
                                                <div class="col-xs-12 col-sm-4 fadeIn" ><!--- first name--->
                                                    <!--label-->
                                                    <span class="text-danger" ng-show="pocaForm.pocaFirstName.$error.required"><i class="fa fa-asterisk"></i> </span><label class="" for="male">First Name:</label>
                                                    <!--error message-->
                                                    <div ng-show="pocaForm.$submitted || pocaForm.pocaFirstName.$touched" class="text-danger">
                                                      <div ng-show="pocaForm.pocaFirstName.$error.required || pocaForm.pocaFirstName.$error.pattern">First name required <br/>(no symbols or numbers)</div>
                                                    </div>
                                                    <input type="text"  ng-model="user.pocaFirstName" name="pocaFirstName"  class="form-control" ng-pattern="/^[A-Za-z\-\' ]+$/" placeholder="First Name"  ng-required="user.isPEP == 'true'"  autocomplete="off" />
                                                    <br/>
                                                </div><!--- end first name--->
                                                <div class="col-xs-12 col-sm-4 fadeIn" ><!--- middle name--->
                                                    <!--label-->
                                                    <span class="text-danger" ng-show="pocaForm.pocaMiddleName.$error.required"><i class="fa fa-asterisk"></i> </span><label class="" for="male">Middle Name:</label>
                                                    <!--error message-->
                                                    <div ng-show="pocaForm.$submitted || pocaForm.pocaMiddleName.$touched" class="text-danger">
                                                      <div ng-show="pocaForm.pocaMiddleName.$error.required || pocaForm.pocaMiddleName.$error.pattern">(no symbols or numbers)</div>
                                                    </div>
                                                    <input type="text"    ng-model="user.pocaMiddleName" name="pocaMiddleName"  class="form-control" ng-pattern="/^[A-Za-z\-\' ]+$/" placeholder="Middle Name"  autocomplete="off" />
                                                    <br/>
                                                </div><!--- end middle name--->
                                               
                                                <div class="col-xs-12  fadeIn" ><!--- position--->
                                                    <!--label-->
                                                    <span class="text-danger" ng-show="pocaForm.officeprominentOfficer.$error.required"><i class="fa fa-asterisk"></i> </span><label class="" for="male"> Office:</label>
                                                    <!--error message-->
                                                    <div ng-show="pocaForm.$submitted || pocaForm.officeprominentOfficer.$touched" class="text-danger">
                                                      <div ng-show="pocaForm.officeprominentOfficer.$error.required || pocaForm.officeprominentOfficer.$error.pattern">Position required <br/>(no symbols or numbers)</div>
                                                    </div>
                                                    <input type="text"    ng-model="user.officeprominentOfficer" name="officeprominentOfficer"  class="form-control" placeholder="Office" ng-required="user.isPEP == 'true'"  autocomplete="off" />
                                                    <br/>
                                                </div>
                                                <!---end position--->
                                                
                                               
                                                
                                                    
                                           		<div ng-show = "user.PEPisMe == 'true'">  
                                                    
                                                    <span class="text-danger" ng-show="pocaForm.pepHasSpouce.$error.required"><i class="fa fa-asterisk"></i> </span>Do you have a Spouse? (This includes common law husband or wife)
                                                	<input type="radio" ng-model="user.pepHasSpouce" name="pepHasSpouce" ng-required="!user.pepHasSpouce && user.PEPisMe == 'true'" value="false" >No 
                                                	<input type="radio" ng-model="user.pepHasSpouce"  name="pepHasSpouce" ng-required="!user.pepHasSpouce && user.PEPisMe == 'true'" value="true">Yes
                                                    <br/>
                                                    <div ng-if="user.pepHasSpouce == 'true'" class="fadeIn row"><!---Spouse info--->
                                                        <br/>
                                                        
                                                        <span class="col-xs-12 col-sm-6 fadeIn" ><!--- Spouse name--->
                                                            <!--label-->
                                                            <span class="text-danger" ng-show="pocaForm.pocaSpouseName.$error.required"><i class="fa fa-asterisk"></i> </span><label class="" for="male">Name of Spouse:</label>
                                                            <!--error message-->
                                                            <div ng-show="pocaForm.$submitted || pocaForm.pocaSpouseName.$touched" class="text-danger">
                                                              <div ng-show="pocaForm.pocaSpouseName.$error.required || pocaForm.pocaSpouseName.$error.pattern">Name of Spouse required <br/>(no symbols or numbers)</div>
                                                            </div>
                                                            <input type="text"  ng-model="user.pocaSpouseName" name="pocaSpouseName"  class="form-control" ng-pattern="/^[A-Za-z\-\' ]+$/" placeholder="Spouse Name"  required=""  autocomplete="off" />
                                                            <br/>
                                                        </span><!--- end Spouse name--->
                                                        <span class="col-xs-12 col-sm-6 fadeIn" ><!--- Spouse address--->
                                                            <!--label-->
                                                            <span class="text-danger" ng-show="pocaForm.pocaSpouseAddress.$error.required"><i class="fa fa-asterisk"></i> </span><label class="" for="male">Address of Spouse:</label>
                                                            <!--error message-->
                                                            <div ng-show="pocaForm.$submitted || pocaForm.pocaSpouseAddress.$touched" class="text-danger">
                                                              <div ng-show="pocaForm.pocaSpouseAddress.$error.required || pocaForm.pocaSpouseAddress.$error.pattern">Spouse address required </div>
                                                            </div>
                                                            <input type="text"  ng-model="user.pocaSpouseAddress" name="pocaSpouseAddress"  class="form-control" placeholder="Spouse Address"  required=""  autocomplete="off" />
                                                            <br/>
                                                        </span><!--- end  Spouse address--->
                                                        
                                                    </div><!--- end Spouse info--->
                                                    <br/>
                                                   
                                                    <span class="text-danger" ng-show="pocaForm.pocaHasChildren.$error.required"><i class="fa fa-asterisk"></i> </span> Do you have any children?
                                                    
                                                    <span class="text-danger" ng-show="pocaForm.pepHasChildren.$error.required"><i class="fa fa-asterisk"></i> </span> Do you have any children?
                                                	<input type="radio" ng-model="user.pepHasChildren" name="pepHasChildren" ng-required="!user.pepHasChildren && user.PEPisMe == 'true'" value="false" >No 
                                                	<input type="radio" ng-model="user.pepHasChildren"  name="pepHasChildren" ng-required="!user.pepHasChildren && user.PEPisMe == 'true'" value="true">Yes
                                                    <br/>
                                                   
                                                    <span ng-if="user.pepHasChildren == 'true'"  class="fadeIn" ><!---child info--->
                                                        <!--Add remove buttons-->
                                                        <div class="row">
                                                            <div class="row pull-right">
                                                               <div class="col-xs-12 ">
                                                                <a href ng-click="isPEPChildrenArray.push('childFeild');" class="text-success"><i class="fa fa-plus-square" aria-hidden="true"></i> Add another child</a>
                                                                <a href ng-click="isPEPChildrenArray.length > 1 && isPEPChildrenArray.pop() " class="text-warning"><i class="fa fa-minus-square" aria-hidden="true"></i> Remove</a>
                                                               </div>
                                                            </div>
                                                        </div>
                                                        
                                                        Information for your children
                                                        
                                                        <hr/>
                                                        <div ng-repeat="x in isPEPChildrenArray track by $index" class="fadeIn row ">
                                                            
                                                            <div class="col-xs-12 col-sm-6 fadeIn" ><!--- child name--->
                                                                <!--label-->
                                                                <span class="text-danger" ng-show="pocaForm.pocaChildName{{$index}}.$error.required"><i class="fa fa-asterisk"></i> </span><label class="" for="male">Name of child {{$index + 1}}:</label>
                                                                <!--error message-->
                                                                <div ng-show="pocaForm.$submitted || pocaForm.pocaChildName{{$index}}.$touched" class="text-danger">
                                                                  <div ng-show="pocaForm.pocaChildName{{$index}}.$error.required || pocaForm.pocaChildName{{$index}}.$error.pattern">Name of child required <br/>(no symbols or numbers)</div>
                                                                </div>
                                                                <input type="text"   ng-model="user.pocaChildName[$index + 1]" name="pocaChildName{{$index}}"  class="form-control" ng-pattern="/^[A-Za-z\-\' ]+$/" placeholder="Child Name"  required=""  autocomplete="off" />
                                                                <br/>
                                                            </div><!--- end child name--->
                                                            <div class="col-xs-12 col-sm-6 fadeIn" ><!--- child address--->
                                                                <!--label-->
                                                                <span class="text-danger" ng-show="pocaForm.pocaChildAddress{{$index}}.$error.required"><i class="fa fa-asterisk"></i> </span><label class="" for="male">Address of of child {{$index + 1}}:</label>
                                                                <!--error message-->
                                                                <div ng-show="pocaForm.$submitted || pocaForm.pocaChildAddress{{$index}}.$touched" class="text-danger">
                                                                  <div ng-show="pocaForm.pocaChildAddress{{$index}}.$error.required || pocaForm.pocaChildAddress{{$index}}.$error.pattern">Child address required </div>
                                                                </div>
        
                                                                <input type="text"  ng-model="user.pocaChildAddress[$index + 1]" name="pocaChildAddress{{$index}}"  class="form-control" placeholder="Child's Address"  required=""  autocomplete="off" />
                                                                <br/>
                                                            </div><!--- end  child address--->
                                                        </div>
                                                    </span><!---end child info--->
                                           		</div>
                                           </div>
                                          
                                           
                                            
                                            
                                           
                                           
                                            
                                            
                                            
                                            
                                            <div class="form-group"> 
                                            		<br/><br/>
                                            		</hr>
                                                	<div class="row">
                                                    	<div class="col-xs-12 col-sm-6 col-md-6 col-lg-6"> <!---id upload--->
                                                        	<label for="male" class="">Proof of Identification</label>
                                                            <br/><br/>
                                                        	
                                                            <ng-form name="IDuploadForm" >   
                                                                 <div ng-show="!user.idpicFile">
                                                                     Please upload a copy of your valid photo ID (and TRN, if you are not using your driver's licence).
                                                                     <div ngf-drop name="file" ngf-select ng-model="user.idpicFile" class="drop-box" 
                                                                        ngf-drag-over-class="'dragover'" ngf-multiple="false" ngf-allow-dir="true"
                                                                        accept="image/*,application/pdf" 
                                                                        ngf-pattern="'image/*,application/pdf'">
                                                                        
                                                                            Drop pdfs or images here or click to upload Your ID
                                                                            <br/><br/>
                                                                            <button >Select File</button>
                                                                            
                                                                      </div>
                                                                      <span ng-show="!user.idpicFile">ID not selected yet</span>
                                                                  </div>
                                                                  <div ng-show="user.idpicFile"> 
                                                                  
                                                                      <h4 class="text-success">You have selected:</h4>
                                                                      <h4 class="clickAndGoBlueText"><i class="fa fa-check-square-o" aria-hidden="true"></i> {{user.idpicFile.name}} {{user.idpicFile.$error}} {{user.idpicFile.$errorParam}}</h4> 
                                                                      <img ng-show="IDuploadForm.file.$valid" ngf-thumbnail="user.idpicFile" class="uploadThumb">
                                                                      
                                                                      <span ng-show="user.idpicFile.type === 'application/pdf'"  class="clickAndGoBlueText"><i class="fa fa-file-pdf-o fa-5x" aria-hidden="true"></i></span>
                                                                      <br/><br/>
                                                                  </div>  
                                                               
                                                         
                                                         		<div class="row"  ng-show="user.idpicFile">
                                                                    <div class="col-xs-12 ">
                                                                        Your selected file, {{user.idpicFile.name}}, will be uploaded when you submit POCA this form <br/>
                                                                    </div>
                                                                    <div class="col-xs-12 ">
                                                                        <button ng-click="user.idpicFile = null" class="btn-lg btn-block  btn-danger">Remove file {{user.idpicFile.name}}</span></button>
                                                                    </div>
                                                                    

                                                                   <!---<div class="col-xs-12 col-sm-6 ">
																	POI is lock code for proof of ID
                                                                    	<button type="submit" id="" class="btn-lg btn-block  "  ng-click="uploadPic(idpicFile,'POI')" ng-disabled=" !idpicFile.name" ng-class="{'btn-clickAndGoBlue' : idpicFile.name}" >Upload ID</button>
                                                               	 	</div>
                                                                    --->
                                                                </div>
                                                                 
                                                                   
                                                        		
                                                          </ng-form>
                                                        </div> <!--- / id upload--->
                                                        <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6"> <!---address upload--->
                                                        	<label for="male" class="">Proof of address</label>
                                                            <br/><br/>
                                                            
                                                            <ng-form name="AddressuploadForm" >   
                                                                 <div ng-show="!user.addresspicFile">
                                                                 	 Please upload proof of your address.  This can be a copy of a utility bill or bank statement. 
                                                                     <div ngf-drop name="file" ngf-select ng-model="user.addresspicFile" class="drop-box" 
                                                                        ngf-drag-over-class="'dragover'" ngf-multiple="false" ngf-allow-dir="true"
                                                                        accept="image/*,application/pdf" 
                                                                        ngf-pattern="'image/*,application/pdf'">
                                                                        
                                                                            Drop pdfs or images here or click to upload
                                                                            <br/><br/>
                                                                            <button >Select File</button>
                                                                            
                                                                      </div>
                                                                      <span ng-show="!user.addresspicFile">Proof of address not selected yet</span>
                                                                  </div>
                                                                  <div ng-show="user.addresspicFile"> 
                                                                      <h4 class="text-success">You have selected:</h4>
                                                                      <h4 class="clickAndGoBlueText"><i class="fa fa-check-square-o" aria-hidden="true"></i> {{user.addresspicFile.name}} {{user.addresspicFile.$error}} {{user.addresspicFile.$errorParam}}</h4> 
                                                                      <img ng-show="AddressuploadForm.file.$valid" ngf-thumbnail="user.addresspicFile" class="uploadThumb">
                                                                      
                                                                      <span ng-show="user.addresspicFile.type === 'application/pdf'"  class="clickAndGoBlueText"><i class="fa fa-file-pdf-o fa-5x" aria-hidden="true"></i></span>
                                                                      <br/><br/>
                                                                     
                                                                  </div>  
                                                                
                                                                  <div class="row" ng-show="user.addresspicFile">
                                                                   <div class="col-xs-12 ">
                                                                        Your selected file, {{user.addresspicFile.name}}, will be uploaded when you submit POCA form<br/>
                                                                    </div>
                                                                    <div class="col-xs-12  ">
                                                                        <button ng-click="user.addresspicFile = null"  class="btn-lg btn-block  btn-danger">Remove {{user.addresspicFile.name}}</button>
                                                                    </div>
                                                                   
                                                                    <!---<div class="col-xs-12 col-sm-6 ">
                                                                    	POA is lock code for proof of address
                                                                        <button type="submit" id="" class="btn-lg btn-block  "  ng-click="uploadPic(user.addresspicFile, 'POA')" ng-disabled=" !user.addresspicFile.name" ng-class="{'btn-clickAndGoBlue' : user.addresspicFile.name}" >Upload address</button>
                                                                    </div>--->
                                                                </div>
                                                         </ng-form>
                                                    	</div><!--- / address upload--->
                                                       
                                                        
                                                    </div>
                                           </div>
                                           
                                            <input type="hidden" ng-model="user.typeOfPOCA"/>
                                            
                                             <!---
		
											to test error checking 
											{{pocaForm.$error }}
											
											--->
		 
                                            
                                            <!---
																						ERROR CHECKING
											
                                            <tt>pocaForm.$valid = {{pocaForm.$valid}}</tt><br>
                                            errors: {{pocaForm.$error.required}}
                                            --->

                                            
                                            
                                            <br/>
                                            
                                            <uib-alert  type="warning" ng-show="pocaForm.$invalid" ><i class="fa fa-info-circle"></i> You must fill out all the required form fields before proceeding</uib-alert>
                                            
                                            <br/>
                                            <!---
                                            <button type="button" id="pocacancelBttn" class="btn-danger btn-lg" onClick="wannaSeeCSR('#pocaForm','Please ask any CSR to assist you with filling out a POCA form')">I want to do this in branch</button>
											--->
                                            
 											 	<div ng-if="inTwo.CODE == 'POCA'" ng-repeat="inTwo in client_locks"  >
                                            		<button type="submit" id="pocaBttn" class="btn-clickAndGoYellow btn-lg pull-right"  ng-click="submitPoca( pocaForm.$valid, inTwo.ID)" >Proceed<span class="hidden-xs">, I verify that all this information is correct</span></button>
                                            	</div>
                                            
                                           
                                     </form>      
                                     
                                 </div><!---end of poca form--->
                              </div>
                         </div>
                     </div>       
                
                
                
   		
   
   
   
  
              
              <div id="personalInformationForm"   ng-show="lockSwitch=='AU'" ><!--- container for supporting divs   --->
                    
                    <div class="row"><!--- row for supporting divs--->
                        <div  class="col-sm-12  form-box">             
                             <div id="" class="kioskGeneralForm wrapper" style="display:;"> <!---start of personal information  form--->
                                     <form  name="renewalForm"  novalidate>    
                                        <span  id="piPolicyNumber" style="display:none"></span>
                                            1) Have any of the following changed?
                                            <br/>
                                            
                                            <div style="margin-left:30px;">
                                            
                                             
                                                <div class="row" >
                                                	<div ng-show="renewalForm.$submitted || renewalForm.piemaildifferent.$touched" class="text-danger">
                                                      <div ng-show="renewalForm.piemaildifferent.$error.required"><i class="fa fa-asterisk"></i> This field is required</div>
                                                    </div>
                                                	<div class="col-xs-5 col-sm-5 col-md-5 col-lg-5">
                                                    	<span class="text-danger" ng-show="renewalForm.piemaildifferent.$error.required"><i class="fa fa-asterisk"></i> </span>
                                                        a) Email address: {{piEmailAddressText}} 
                                                        <br/>
                                                        <span class="clickAndGoBlueText"> {{user.emailAddress}} </span>
                                                    </div>
                                                    <div class="col-xs-7 col-sm-7 col-md-7 col-lg-7">  
                                                    
                                                        
                                                        <input type="radio" ng-model="renewalFormUser.piemaildifferent" name="piemaildifferent" value="no"  ng-required="!renewalFormUser.piemaildifferent">No 
                                                        <input type="radio"  ng-model="renewalFormUser.piemaildifferent" name="piemaildifferent" value="Yes"  ng-required="!renewalFormUser.piemaildifferent">Yes
                                                    </div>
                                                 </div>   
                                                    <div ng-show="renewalFormUser.piemaildifferent == 'Yes'" class="fadeIn">
                                                    	<div ng-show="renewalForm.$submitted || renewalForm.piEmailAddress.$touched" class="text-danger">
                                                          <div ng-show="renewalForm.piEmailAddress.$error.required || renewalForm.piEmailAddress.$error.pattern"><i class="fa fa-asterisk"></i> Please enter a valid email adddress</div>
                                                        </div>
                                                        If Yes, enter your new email: 
                                                        <input type="text" ng-required="renewalFormUser.piemaildifferent == 'Yes'" ng-pattern="/^[_a-z0-9]+(\.[_a-z0-9]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,4})$/"  ng-model="renewalFormUser.piEmailAddress" name="piEmailAddress" class="form-control"  placeholder="Email" autocomplete="off"/>
                                                    </div >
                                                    <br/>
                                               
                                                <div class="row">
                                                    <div ng-show="renewalForm.$submitted || renewalForm.pimailingdifferent.$touched" class="text-danger">
                                                      <div ng-show="renewalForm.pimailingdifferent.$error.required"><i class="fa fa-asterisk"></i> This field is required</div>
                                                    </div>
                                                    <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5">
                                                    	<span class="text-danger" ng-show="renewalForm.pimailingdifferent.$error.required"><i class="fa fa-asterisk"></i> </span>
                                                        b) Mailing Address: 
                                                        <br/>
                                                        <span class="clickAndGoBlueText"> {{user.mailingAddr}} </span>
                                                    </div>
                                                    <div class="col-xs-7 col-sm-7 col-md-7 col-lg-7">  
                                                        <input type="radio" ng-model="renewalFormUser.pimailingdifferent" name="pimailingdifferent" value="no"  ng-required="!renewalFormUser.pimailingdifferent">No 
                                                        <input type="radio" ng-model="renewalFormUser.pimailingdifferent" name="pimailingdifferent" value="Yes"  ng-required="!renewalFormUser.pimailingdifferent">Yes
                                                     </div>
                                                </div>    
                                                    <div  ng-show="renewalFormUser.pimailingdifferent == 'Yes'" class="fadeIn">
                                                    	<div ng-show="renewalForm.$submitted || renewalForm.pimailingAddr.$touched" class="text-danger">
                                                          <div ng-show="renewalForm.pimailingAddr.$error.required"><i class="fa fa-asterisk"></i> Please tell us your new address</div>
                                                        </div>
                                                        If Yes, enter your new mailing address <input type="text" ng-required="renewalFormUser.pimailingdifferent  == 'Yes'"  ng-model="renewalFormUser.pimailingAddr" name="pimailingAddr" class="form-control"  placeholder="Mailing Address" autocomplete="off"/>
                                                    </div >
                                                    <br/>
                                                 
                                                 
                                                 <div class="row">  
                                                 	<div ng-show="renewalForm.$submitted || renewalForm.pinumbersdifferent.$touched" class="text-danger">
                                                      <div ng-show="renewalForm.pinumbersdifferent.$error.required"><i class="fa fa-asterisk"></i> This field is required</div>
                                                    </div>
                                                    <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5">
                                                       	<span class="text-danger" ng-show="renewalForm.pinumbersdifferent.$error.required"><i class="fa fa-asterisk"></i> </span>
                                                        c) Telephone numbers: {{pinumbersdifferentText}} 
                                                        <br/>
                                                        <span class="clickAndGoBlueText"> {{user.HomeNumber | telFilter}} {{user.WorkNumber | telFilter}} {{user.CellNumber | telFilter}} </span>
                                                    </div>   
                                                    <div class="col-xs-7 col-sm-7 col-md-7 col-lg-7">   
                                                        <input type="radio" ng-model="renewalFormUser.pinumbersdifferent"  name="pinumbersdifferent" value="no" ng-required="!renewalFormUser.pinumbersdifferent">No 
                                                        <input type="radio" ng-model="renewalFormUser.pinumbersdifferent"   name="pinumbersdifferent" value="Yes" ng-required="!renewalFormUser.pinumbersdifferent">Yes
                                                   	</div>
                                                 </div>   
                                                    <div  ng-show="renewalFormUser.pinumbersdifferent == 'Yes'" class="fadeIn">
                                                        <div ng-show="renewalForm.$submitted || renewalForm.pinumbers.$touched" class="text-danger">
                                                          <div ng-show="renewalForm.pinumbers.$error.required"><i class="fa fa-asterisk"></i> Please tell us your new number. Enter digits ONLY.</div>
                                                        </div>
                                                        If Yes, enter your new number. Enter digits ONLY <input type="text"  ng-required="renewalFormUser.pinumbersdifferent == 'Yes'" ng-model="renewalFormUser.pinumbers" name="pinumbers" class="form-control"  placeholder="number" autocomplete="off"/>
                                                    </div >
                                                    <br/>
                                                
                                                <div class="row">
                                                	<div ng-show="renewalForm.$submitted || renewalForm.piresidencedifferent.$touched" class="text-danger">
                                                      <div ng-show="renewalForm.piresidencedifferent.$error.required"><i class="fa fa-asterisk"></i> This field is required</div>
                                                    </div>
                                                    <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5">
                                                        <span class="text-danger" ng-show="renewalForm.piresidencedifferent.$error.required"><i class="fa fa-asterisk"></i> </span>
                                                        d) Place of Residence: {{piaddr1Text}} 
                                                        <br/>
                                                        <span class="clickAndGoBlueText">
                                                        {{user.homeAddrORIG}}  
                                                        <!--{{user.addr1}} -->
                                                        </span>
                                                    </div>
                                                    <div class="col-xs-7 col-sm-7 col-md-7 col-lg-7">       
                                                        <input type="radio" ng-model="renewalFormUser.piresidencedifferent" name="piresidencedifferent" value="no"  ng-required="!renewalFormUser.piresidencedifferent">No 
                                                        <input type="radio" ng-model="renewalFormUser.piresidencedifferent"  name="piresidencedifferent" value="Yes"  ng-required="!renewalFormUser.piresidencedifferent">Yes
                                                     </div>
                                                </div>      
                                                    <div  ng-show="renewalFormUser.piresidencedifferent == 'Yes'" class="fadeIn">
                                                    	<div ng-show="renewalForm.$submitted || renewalForm.piresidence.$touched" class="text-danger">
                                                          <div ng-show="renewalForm.piresidence.$error.required"><i class="fa fa-asterisk"></i> Please tell us your new address</div>
                                                        </div>
                                                        If Yes, enter your new address: <input type="text"  ng-required="renewalFormUser.piresidencedifferent == 'Yes'" ng-model="renewalFormUser.piresidence"    name="piresidence" class="form-control"  placeholder="Permanent Address" autocomplete="off"/>
                                                    </div >
                                                    <br/>
                                                   
                                                
                                                
                                         </div>    
                                        <hr/>
                                        <div ng-show="renewalForm.$submitted || renewalForm.pioccupationdifferent.$touched" class="text-danger">
                                              <div ng-show="renewalForm.pioccupationdifferent.$error.required"><i class="fa fa-asterisk"></i> This field is required</div>
                                            </div>
                                        <div class="row">
                                            <div class="col-xs-9 col-sm-9 col-md-9 col-lg-9">
                                                <span class="text-danger" ng-show="renewalForm.pioccupationdifferent.$error.required"><i class="fa fa-asterisk"></i> </span>
                                                2) Has your business or profession changed? {{piEnteryourOccupationText}} 
                                                <br/>
                                                <span class="clickAndGoBlueText"> {{user.EnteryourOccupation}} </span>
                                             </div>
                                             <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3">  
                                                <input type="radio" ng-model="renewalFormUser.pioccupationdifferent"  name="pioccupationdifferent"  value="no" ng-required="!renewalFormUser.pioccupationdifferent">No 
                                                <input type="radio" ng-model="renewalFormUser.pioccupationdifferent"   name="pioccupationdifferent" value="Yes" ng-required="!renewalFormUser.pioccupationdifferent">Yes
                                             </div>
                                        </div>     
                                        <div  ng-show="renewalFormUser.pioccupationdifferent == 'Yes'" class="fadeIn">
                                            <div ng-show="renewalForm.$submitted || renewalForm.pioccupation.$touched" class="text-danger">
                                              <div ng-show="renewalForm.pioccupation.$error.required"><i class="fa fa-asterisk"></i> Please tell us your new profession</div>
                                            </div>
                                            If Yes, enter business or profession: <input type="text" ng-required="renewalFormUser.pioccupationdifferent == 'Yes'" ng-model="renewalFormUser.pioccupation"  name="pioccupation" class="form-control"  placeholder="business or profession" autocomplete="off"/>
                                        </div >
                                        <br/>
                                        
                                      
                                       
                                        <div ng-show="renewalForm.$submitted || renewalForm.piemployerdifferent.$touched" class="text-danger">
                                          <div ng-show="renewalForm.piemployerdifferent.$error.required"><i class="fa fa-asterisk"></i> This field is required</div>
                                        </div>
                                        <div class="row">
                                            <div class="col-xs-9 col-sm-9 col-md-9 col-lg-9">
                                            	<span class="text-danger" ng-show="renewalForm.piemployerdifferent.$error.required"><i class="fa fa-asterisk"></i> </span>
                                                3) Has your Business/Employer's Name & Address changed? {{piEmployeraddr1Text}} 
                                                <br/>
                                                <span class="clickAndGoBlueText"> {{user.Employeraddr1}} </span>
                                             </div>
                                             <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3">   
                                                <input type="radio" ng-model="renewalFormUser.piemployerdifferent" name="piemployerdifferent" value="no"  ng-required="!renewalFormUser.piemployerdifferent">No 
                                                <input type="radio"ng-model="renewalFormUser.piemployerdifferent" name="piemployerdifferent" value="Yes"    ng-required="!renewalFormUser.piemployerdifferent" />Yes
                                        	</div>
                                        </div> 
                                        <div  ng-show="renewalFormUser.piemployerdifferent == 'Yes'" class="fadeIn">
                                        	<br/> 
                                            <div ng-show="renewalForm.$submitted || renewalForm.piemployer.$touched" class="text-danger">
                                              <div ng-show="renewalForm.piemployer.$error.required"><i class="fa fa-asterisk"></i> Please tell us your employer's new name and address</div>
                                            </div>
                                            If Yes, enter your Business/Employer's Name & Address: <input type="text" ng-required="renewalFormUser.piemployerdifferent == 'Yes'" ng-model="renewalFormUser.piemployer"  name="piemployer" class="form-control"  placeholder="Business/Employer's Name & Address" autocomplete="off"/>
                                        </div >
                                        
                                        <br/>
                                        <hr/>
                                        <div ng-show="renewalForm.$submitted || renewalForm.piusagedifferent.$touched" class="text-danger">
                                          <div ng-show="renewalForm.piusagedifferent.$error.required"><i class="fa fa-asterisk"></i> This field is required</div>
                                        </div>
                                        <div class="row">
                                            <div class="col-xs-9 col-sm-9 col-md-9 col-lg-9">
                                            	<span class="text-danger" ng-show="renewalForm.piusagedifferent.$error.required"><i class="fa fa-asterisk"></i> </span>
                                                4) Has the vehicle been used or is it intended to be used for any purpose other than what was previously declared? 
                                            </div>
                                            <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3">    
                                                <input type="radio" ng-model="renewalFormUser.piusagedifferent" name="piusagedifferent"  value="no"   ng-required="!renewalFormUser.piusagedifferent">No 
                                                <input type="radio" ng-model="renewalFormUser.piusagedifferent" name="piusagedifferent" value="Yes"   ng-required="!renewalFormUser.piusagedifferent">Yes
                                            </div>
                                        </div>  
                                        
                                        <div  ng-show="renewalFormUser.piusagedifferent == 'Yes'" class="fadeIn">
                                         	<br/> 
                                            <div ng-show="renewalForm.$submitted || renewalForm.piusage.$touched" class="text-danger">
                                              <div ng-show="renewalForm.piusage.$error.required"><i class="fa fa-asterisk"></i> Please tell us the vehicle's intended use</div>
                                            </div>
                                            If Yes, what is the intended use: <input type="text" ng-required="renewalFormUser.piusagedifferent == 'Yes'"  ng-model="renewalFormUser.piusage" name="piusage" class="form-control"  placeholder="intended use" autocomplete="off"/>
                                        </div >
                                        
                                        <br/>
                                        <hr/>
                                        <div ng-show="renewalForm.$submitted || renewalForm.piownerdifferent.$touched" class="text-danger">
                                          <div ng-show="renewalForm.piownerdifferent.$error.required"><i class="fa fa-asterisk"></i> This field is required</div>
                                        </div>
                                        <div class="row">
                                            <div class="col-xs-9 col-sm-9 col-md-9 col-lg-9">
                                            	<span class="text-danger" ng-show="renewalForm.piownerdifferent.$error.required"><i class="fa fa-asterisk"></i> </span>
                                                5) Are you still the owner of the vehicle? 
                                             </div>  
                                             <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3"> 
                                             <!---
											 	ideally these would be true false
												
												for this question the values should be switched radio bttn Yes would be true radio button no would be false
												having a false in ur anser array would fail the passing of renewal questionnare
												
												keeping it like this cause of kiosk
											 --->
                                                <input type="radio" ng-model="renewalFormUser.piownerdifferent"  name="piownerdifferent" value="no"  ng-required="!renewalFormUser.piownerdifferent">No 
                                                <input type="radio" ng-model="renewalFormUser.piownerdifferent"  name="piownerdifferent"  value="Yes"  ng-required="!renewalFormUser.piownerdifferent">Yes
                                        	</div>
                                        </div>
                                        <div  ng-show="renewalFormUser.piownerdifferent == 'no'" class="fadeIn">
                                           <br/> 
                                           <div ng-show="renewalForm.$submitted || renewalForm.piowner.$touched" class="text-danger">
                                              <div ng-show="renewalForm.piowner.$error.required"><i class="fa fa-asterisk"></i> Please tell us who the new owner is</div>
                                            </div>
                                            If no, who is the owner: <input type="text"  ng-required="renewalFormUser.piownerdifferent == 'no'" name="piowner" ng-model="renewalFormUser.piowner" class="form-control"  placeholder="owner's name" autocomplete="off"/>
                                        </div >
                                        
                                        <br/> 
                                        <hr/>
                                        
                                        <div ng-show="renewalForm.$submitted || renewalForm.piinterestdifferent.$touched" class="text-danger">
                                          <div ng-show="renewalForm.piinterestdifferent.$error.required"><i class="fa fa-asterisk"></i> This field is required</div>
                                        </div>
                                        <div class="row">
                                            <div class="col-xs-9 col-sm-9 col-md-9 col-lg-9">
                                            	<span class="text-danger" ng-show="renewalForm.piinterestdifferent.$error.required"><i class="fa fa-asterisk"></i> </span>
                                                6) Does any other party, apart from an existing mortgagee, have an interest in the vehicle that is being insured? 
                                             </div>   
                                             <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3"> 
                                                <input type="radio" ng-model="renewalFormUser.piinterestdifferent" name="piinterestdifferent" value="no" ng-required="!renewalFormUser.piinterestdifferent">No 
                                                <input type="radio" ng-model="renewalFormUser.piinterestdifferent"  name="piinterestdifferent" value="Yes" ng-required="!renewalFormUser.piinterestdifferent">Yes
                                       
                                       		</div>
                                        </div>
                                        <div  ng-show="renewalFormUser.piinterestdifferent == 'Yes'" class="fadeIn">
                                        	<br/> 
                                            <div ng-show="renewalForm.$submitted || renewalForm.piinterest.$touched" class="text-danger">
                                              <div ng-show="renewalForm.piinterest.$error.required"><i class="fa fa-asterisk"></i> Please tell us the name</div>
                                            </div>
                                            If Yes, name party: <input type="text" ng-required="renewalFormUser.piinterestdifferent == 'Yes'" name="piinterest" ng-model="renewalFormUser.piinterest" class="form-control"  placeholder="party's name" autocomplete="off"/>
                                        </div >
                                        
                                        <br/> 
                                        <hr/>
                                        <div ng-show="renewalForm.$submitted || renewalForm.picustodydifferent.$touched" class="text-danger">
                                          <div ng-show="renewalForm.picustodydifferent.$error.required"><i class="fa fa-asterisk"></i> This field is required</div>
                                        </div>
                                        <div class="row">
                                        <!---
											 	ideally these would be true false
												
												for this question the values should be switched radio bttn Yes would be true radio button no would be false
												having a false in ur anser array would fail the passing of renewal questionnare
												
												keeping it like this cause of kiosk
											 --->
                                            <div class="col-xs-9 col-sm-9 col-md-9 col-lg-9">
                                                <span class="text-danger" ng-show="renewalForm.picustodydifferent.$error.required"><i class="fa fa-asterisk"></i> </span>
                                                7) Do you have complete custody and control of the insured vehicle? 
                                             </div> 
                                             <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3">  
                                                <input type="radio" ng-model="renewalFormUser.picustodydifferent" name="picustodydifferent" value="no"  ng-required="!renewalFormUser.picustodydifferent">No 
                                                <input type="radio" ng-model="renewalFormUser.picustodydifferent"  name="picustodydifferent" value="Yes"  ng-required="!renewalFormUser.picustodydifferent"/>Yes
                                        	</div>
                                        </div>
                                        <div  ng-show="renewalFormUser.picustodydifferent == 'no'" class="fadeIn">
                                        	<br/> 
                                            <div ng-show="renewalForm.$submitted || renewalForm.picustody.$touched" class="text-danger">
                                              <div ng-show="renewalForm.picustody.$error.required"><i class="fa fa-asterisk"></i> Please tell us who has cutody</div>
                                            </div>
                                            If no, who else has custody? <input type="text"  ng-required="renewalFormUser.picustodydifferent == 'no'" name="picustody" ng-model="renewalFormUser.picustody" class="form-control"  placeholder="person's name" autocomplete="off"/>
                                        </div >
                                        
                                        <br/> 
                                        <hr/>
                                        <div ng-show="renewalForm.$submitted || renewalForm.pifineddifferent.$touched" class="text-danger">
                                          <div ng-show="renewalForm.pifineddifferent.$error.required"><i class="fa fa-asterisk"></i> This field is required</div>
                                        </div>
                                        <div class="row">
                                            <div class="col-xs-9 col-sm-9 col-md-9 col-lg-9">
                                            	<span class="text-danger" ng-show="renewalForm.pifineddifferent.$error.required"><i class="fa fa-asterisk"></i> </span>
                                                8) Have you or any regular driver been fined, had their licence endorsed/revoked, or been prosecuted for a motoring offence? 
                                            </div>   
                                            <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3">   
                                                <input type="radio" ng-model="renewalFormUser.pifineddifferent" name="pifineddifferent" value="no" ng-required="!renewalFormUser.pifineddifferent">No 
                                                <input type="radio" ng-model="renewalFormUser.pifineddifferent" name="pifineddifferent" value="Yes" ng-required="!renewalFormUser.pifineddifferent" />Yes
                                        	</div>
                                        </div>
                                        <div  ng-show="renewalFormUser.pifineddifferent == 'Yes'" class="fadeIn">
                                        	<br/> 
                                            <div ng-show="renewalForm.$submitted || renewalForm.pifined.$touched" class="text-danger">
                                              <div ng-show="renewalForm.pifined.$error.required"><i class="fa fa-asterisk"></i> Please tell us about the offense</div>
                                            </div>
                                            If Yes, name person and describe: <input type="text" ng-required="renewalFormUser.pifineddifferent == 'Yes'" name="pifined" class="form-control"  ng-model="renewalFormUser.pifined"  placeholder="person's name and description" autocomplete="off"/>
                                        </div >
                                        
                                        <br/> 
                                        <hr/>
                                    	<div ng-show="renewalForm.$submitted || renewalForm.pisickdifferent.$touched" class="text-danger">
                                          <div ng-show="renewalForm.pisickdifferent.$error.required"><i class="fa fa-asterisk"></i> This field is required</div>
                                        </div>
                                        <div class="row">
                                            <div class="col-xs-9 col-sm-9 col-md-9 col-lg-9">
                                            	<span class="text-danger" ng-show="renewalForm.pisickdifferent.$error.required"><i class="fa fa-asterisk"></i> </span>
                                                9) Do you or any regular driver suffer from any illness or medical condition, whether physical or mental, including but not limited to, diabetes, hypertension, epilepsy, stroke, heart condition, fainting spells, hallucinations, defective vision or hearing? 
                                             </div>
                                             <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3">    
                                                <input type="radio" ng-model="renewalFormUser.pisickdifferent" name="pisickdifferent"  value="no"  ng-required="!renewalFormUser.pisickdifferent">No 
                                                <input type="radio" ng-model="renewalFormUser.pisickdifferent"  name="pisickdifferent" value="Yes"  ng-required="!renewalFormUser.pisickdifferent">Yes
                                        	</div>
                                        </div>
                                        <div  ng-show="renewalFormUser.pisickdifferent == 'Yes'" class="fadeIn">
                                        	<br/> 
                                            <div ng-show="renewalForm.$submitted || renewalForm.pisick.$touched" class="text-danger">
                                              <div ng-show="renewalForm.pisick.$error.required"><i class="fa fa-asterisk"></i> Please tell us the driver's name and describe</div>
                                            </div>
                                            If Yes, name person and describe: <input type="text" ng-required="renewalFormUser.pisickdifferent == 'Yes'" name="pisick"  ng-model="renewalFormUser.pisick" class="form-control"  placeholder="person's name and description" autocomplete="off"/>
                                        </div >
                                        
                                        <br/>
                                        <hr/>
                                        <div ng-show="renewalForm.$submitted || renewalForm.piaccidentdifferent.$touched" class="text-danger">
                                          <div ng-show="renewalForm.piaccidentdifferent.$error.required"><i class="fa fa-asterisk"></i> This field is required</div>
                                        </div>
                                        <div class="row">
                                            <div class="col-xs-9 col-sm-9 col-md-9 col-lg-9">
                                                <span class="text-danger" ng-show="renewalForm.piaccidentdifferent.$error.required"><i class="fa fa-asterisk"></i> </span>
                                                10) Have you had any accidents you have not advised us of? 
                                             </div>
                                             <div class="col-xs-3 col-sm-3 col-md-3 col-lg-3">   
                                                <input type="radio" ng-model="renewalFormUser.piaccidentdifferent" name="piaccidentdifferent" value="no" ng-required="!renewalFormUser.piaccidentdifferent">No 
                                                <input type="radio" ng-model="renewalFormUser.piaccidentdifferent" name="piaccidentdifferent" value="Yes" ng-required="!renewalFormUser.piaccidentdifferent">Yes
                                        	</div>
                                        </div>
                                        <div  ng-show="renewalFormUser.piaccidentdifferent == 'Yes'" class="fadeIn">
                                        	<br/> 
                                            <div ng-show="renewalForm.$submitted || renewalForm.piaccident.$touched" class="text-danger">
                                              <div ng-show="renewalForm.piaccident.$error.required"><i class="fa fa-asterisk"></i> Please tell us about the accidents</div>
                                            </div>
                                            If Yes, please describe: <input type="text" ng-required="renewalFormUser.piaccidentdifferent == 'Yes'" name="piaccident"  ng-model="renewalFormUser.piaccident" class="form-control"  placeholder="enter description" autocomplete="off"/>
                                        </div >
                                        
                                        <br/>
                                        <hr/>
                                        <div ng-show="renewalForm.$submitted || renewalForm.piyoungMledifferent.$touched" class="text-danger">
                                          <div ng-show="renewalForm.piyoungMledifferent.$error.required"><i class="fa fa-asterisk"></i> This field is required</div>
                                        </div>
                                        <div class="row">
                                            <div class="col-xs-9 col-sm-9 col-md-9 col-lg-9">
                                        		<span class="text-danger" ng-show="renewalForm.piyoungMledifferent.$error.required"><i class="fa fa-asterisk"></i> </span>
                                                <!---11) Will any males under 30, who were not previously declared, drive the insured vehicle? --->
                                                12) {{renewalFormUser.maleDriverAge || 'Will any males under 30, who were not previously declared, drive the insured vehicle?'}}
                                        	</div>
                                        	<div class="col-xs-3 col-sm-3 col-md-3 col-lg-3">  
                                                <input type="radio" ng-model="renewalFormUser.piyoungMledifferent" name="piyoungMledifferent" value="no" ng-required="!renewalFormUser.piyoungMledifferent">No 
                                                <input type="radio" ng-model="renewalFormUser.piyoungMledifferent"  name="piyoungMledifferent" value="Yes" ng-required="!renewalFormUser.piyoungMledifferent">Yes
                                        	</div>
                                        </div>
                                        <div  ng-show="renewalFormUser.piyoungMledifferent == 'Yes'" class="fadeIn">
                                        	<br/> 
                                            <div ng-show="renewalForm.$submitted || renewalForm.piyoungMl.$touched" class="text-danger">
                                              <div ng-show="renewalForm.piyoungMl.$error.required"><i class="fa fa-asterisk"></i> Please tell us the person's name</div>
                                            </div>
                                            If Yes, name person: <input type="text"  ng-required="renewalFormUser.piyoungMledifferent == 'Yes'" name="piyoungMl"  ng-model="renewalFormUser.piyoungMl"  class="form-control"  placeholder="person's name" autocomplete="off"/>
                                        </div >
                                        
                                        <br/>
                                        <hr/>
                                        
                                        <div ng-show="renewalForm.$submitted || renewalForm.piyoungFemaledifferent.$touched" class="text-danger">
                                          <div ng-show="renewalForm.piyoungFemaledifferent.$error.required"><i class="fa fa-asterisk"></i> This field is required</div>
                                        </div>
                                        <div class="row">
                                            <div class="col-xs-9 col-sm-9 col-md-9 col-lg-9">
                                                <span class="text-danger" ng-show="renewalForm.piyoungFemaledifferent.$error.required"><i class="fa fa-asterisk"></i> </span>
                                                <!---12) Will any females under 20, who were not previously declared, drive the insured vehicle? --->
                                                12) {{renewalFormUser.femaleDriverAge || 'Will any females under 20, who were not previously declared, drive the insured vehicle?'}}
                                            </div>
                                        	<div class="col-xs-3 col-sm-3 col-md-3 col-lg-3">    
                                               
                                                <input type="radio" ng-model="renewalFormUser.piyoungFemaledifferent" name="piyoungFemaledifferent" value="no" ng-required="!renewalFormUser.piyoungFemaledifferent">No 
                                                <input type="radio" ng-model="renewalFormUser.piyoungFemaledifferent" name="piyoungFemaledifferent" value="Yes" ng-required="!renewalFormUser.piyoungFemaledifferente">Yes
                                        
                                        	</div>
                                        </div>
                                        <div  ng-show="renewalFormUser.piyoungFemaledifferent == 'Yes'" class="fadeIn">
                                        	<br/> 
                                            <div ng-show="renewalFormUser.$submitted || renewalForm.piyoungFemale.$touched" class="text-danger">
                                              <div ng-show="renewalForm.piyoungFemale.$error.required"><i class="fa fa-asterisk"></i> Please tell us the person's name</div>
                                            </div>
                                            If Yes, name person: <input type="text"  ng-required="renewalFormUser.piyoungFemale == 'Yes'" name="piyoungFemale"  ng-model="renewalFormUser.piyoungFemale"   class="form-control"  placeholder="person's name" autocomplete="off"/>
                                        </div >
                                        
                                        <br/>
                                         <!---
											
											ERROR CHECKING
											
                                            renewalForm.$valid = {{renewalForm.$valid}}<br>
                                            errors: {{renewalForm.$error.required}}
                                         --->  
                                            <br/>
                                            <uib-alert  type="warning" ng-show="renewalForm.$invalid" ><i class="fa fa-info-circle"></i> You must fill out all the required form fields before proceeding</uib-alert>
                                            
                                            <br/>
 											 	<div ng-if="inTwo.CODE == 'AU'" ng-repeat="inTwo in client_locks"  >
                                        			<button type="submit"  class="btn-clickAndGoYellow btn-lg pull-right"  ng-click="submitRenewalQuest(renewalFormUser, renewalForm.$valid,inTwo.ID )">Proceed<span class="hidden-xs">, I verify that all this information is correct</span></button>
                                        		</div>
                                        <br/>
                                     </form>   
                             </div><!---end of personal information form--->
                        </div><!--- /wrapper Bottom for supporting divs--->
                    </div>
                </div><!--- /row for supporting divs--->
            </div><!--- / container for supporting divs ---> 
</div><!--- / lock details--->                
  
  
                <br/><br/>