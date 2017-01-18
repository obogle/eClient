<!---
	Name:				Alyssa Morgan
	Date:				September 24, 2015
	Modifications:		
						
	Description:		


--->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="//www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<cfinclude template="../header.cfm">
	
	<title>ICWI Client Portal</title>
    
    <script>
		
		$( document ).ready(function() {
			
			//use strength for password checker
			$('#regPassword').strength();
			
			
			$("#toggleHelp").click(function(){
				$("#helpDiv").slideToggle();
			});
		
		
			$('#regEmail').blur(function() {
				$('#emailError').slideUp();
				var email = $('#regEmail').val();
				
				if((email != ''))
				{ 
					$.ajax({
					type: "POST",
					url: "check_email.cfc?method=checkEmail",
					data: ({
						email_address:email
						
					}),
					dataType: "text",
						success: function(xml)
						{
							$(xml).find('email_check').each(function(){
								 clientHasFail=$(xml).find("email_message").text();
							});
							
							if(clientHasFail.length == 0)
							{
								$('#emailError').slideUp();
								
							}else{
								//if no querry returns a result
								$( "#regEmail" ).val('');
								
								$( "#emailError").slideUp(500, function(){
									$( "#emailError").removeClass();
									$( "#emailError").addClass("");
									$(xml).find('email_check').each(function(){
										$( "#emailError").html('  <div class="alert alert-danger"><i class="fa fa-exclamation-triangle" fa-2x" aria-hidden="true"></i>  ' +$(this).find('email_message').text()+'</div><br/>');
									});
									$( "#emailError").slideDown(500);
								});
							}
						
						}
					});
				}
			});
			
			$('#securityQuestionValidate').change(function() {
			   var securityQuest = $('#securityQuestionValidate').val();
			   var sequrityQuestSplit =  securityQuest.split(',')
			   var shouldBeOwnQuestion = sequrityQuestSplit[1]
			   
			   
			   if (shouldBeOwnQuestion == 'True'){
				   $('#myOwnQuestion').slideDown();
					$('#regQuestion').removeClass("mustValidate");
					$( "#regQuestion").addClass("mustValidate");
			   }else{
				     $('#myOwnQuestion').slideUp();
					$('#regQuestion').removeClass("mustValidate");   
					$('#myOwnQuestion').slideUp();
			   }
				
			});
			
			
		});<!--- doc ready --->
		
		
		<!---open Registration--->
		function openRegistration(){
			
			$( "#loginOrregisterDiv").slideUp(1000, function(){
				$( "#registrationForm").delay(500).slideDown(1000, function(){
				});
			});
		}
		<!--- /open Registration--->
		
		
		
		<!---mainStart--->
			var globalPolicy = '';
			var globalClient = '';
			var globalSecurityQuestion = '';
			var globalSecurityCode = '';
			var webServiceURL = '//ebrokertest.icwi.local/rest/services/';
			
			
			function mainStart(){ 
					
					$('.form-submit').hide();
					$('.fakeForm-submit').show();
					
					var policyNumber = $( "#policyNumber" ).val().replace( /[^0-9]/g, '');
					<!---var idTypeSelect = $( "#idTypeSelect" ).val();
					var idNum = $( "#idNum" ).val(); --->
					
					if((policyNumber != '') <!---&& (idTypeSelect != '')&& (idNum != '')---> )
					{ 
					
					    $( "#usrError").html('<div class="clickAndGoBlueText text-center" ><h3><i class="fa fa-spinner fa-pulse fa-2x fa-fw margin-bottom"></i> Getting your details...</h3><br/></div>')
						$.ajax({
							
						type: "GET",
						url: webServiceURL + "authLvI/" + policyNumber ,
						dataType: "xml",						
							success: function(xml)
							{
								$(xml).find('client_detail').each(function(){
									 clientHasFail=$(xml).find("client_fail").text();
								});
								if(clientHasFail.length == 0)
								{
									$( "#usrError").slideUp(500, function(){
										$( "#usrError").removeClass();
										$( "#usrError").addClass("");
										$(xml).find('client_detail').each(function(){
											$( "#usrError").html('<div class="alert alert-success"><i class="fa fa-check-square fa-2x" aria-hidden="true"></i>    '+$(this).find('client_pass').text()+'</div><br/>');
											$('#securityQuestion').html($(this).find('client_question').text())
											
											$( "#usrError").slideDown(500);
											
											globalPolicy = policyNumber;
											globalSecurityQuestion =$(this).find('client_question').text();
											globalSecurityCode =$(this).find('client_code').text();									
										});
										
									});
									$('.fakeForm-submit').hide();
								    $('.form-submit').show();
									window.scrollTo(0, 0);
									
								}else{
									//if no querry returns a result
									$( "#idNum" ).val('');
									$( "#idTypeSelect" ).val('');
									$( "#policyNumber" ).val('');
									
									$( "#usrError").slideUp(500, function(){
										$( "#usrError").removeClass();
										$( "#usrError").addClass("");
										$(xml).find('client_detail').each(function(){
											$( "#usrError").html(' <div class="alert alert-danger"><i class="fa fa-exclamation-triangle" fa-2x" aria-hidden="true"></i>  You entered the policy number: '+policyNumber+ <!---', ID type: '+idTypeSelect+', ID number: '+idNum+ --->  '<br/>' +$(this).find('client_fail').text()+'</div><br/>');
										});
										$( "#usrError").slideDown(500);
										$('.form-submit').hide();
									});
								}
							
							}
						});
					}
					
				};
		<!---/mainStart--->
		
		<!---disableEmail for testing--->
		function disableEmail(){ 
				var email = $( "#disableEmail" ).val();
				if((email != ''))
				{ 
					$.ajax({
					type: "POST",
					url: "disable_email.cfc?method=disableEmail",
					data: ({
						email_address:email
						
					}),
					dataType: "text",
						success: function(xml)
						{
							$( "#disableEmailMessage").slideUp(500, function(){
								$(xml).find('email_check').each(function(){
									$( "#disableEmailMessage").html($(this).find('email_message').text());
								});
								$( "#disableEmailMessage").slideDown(500);
							});
						
						}
					});
				}
			};
		
		<!--- check security answer--->
		
			function checkSecurityAnswer(){ 
				$('.security-Check').show();
				$('.registerSubmit').hide();
				var answerStr = $( "#securityAnswer" ).val();
				var answer = answerStr.split('/').join('');
				
				if((answer != ''))
				{ 
					$.ajax({
					type: "GET",
					url: webServiceURL + "authLvII/" + globalPolicy + "/" + globalSecurityCode + "/" + answer,
					dataType: "xml",
						success: function(xml)
						{
							$(xml).find('auth_detail').each(function(){
								 clientHasFail=$(xml).find("auth_fail").text();
							});
							if(clientHasFail.length == 0)
							{
								$( "#securityAnswerMessage").slideUp(500, function(){
									$( "#securityAnswerMessage").removeClass();
									$( "#securityAnswerMessage").addClass("");
									$(xml).find('auth_detail').each(function(){
										$( "#securityAnswerMessage").html('<div class="alert alert-success"><i class="fa fa-check-square" fa-2x" aria-hidden="true"></i> '+$(this).find('auth_pass').text())+'</div><br/>';
										globalClient =$(this).find('clnt_no').text();
										$("#clientNumber").val($(this).find('clnt_no').text());
										
									});
								});
								$( "#securityAnswerMessage").slideDown(500);
								$('#otherRegistrationQuestions').slideDown(500);
								$('#securityQuestionArea').slideUp(500);
								
								
								
								
								$('.security-Check').hide();
								$('.registerSubmit').show();
								
							}else{
								//if no querry returns a result
								$( "#securityAnswer" ).val('');
								
								$('#otherRegistrationQuestions').slideUp(500);
								$('#securityQuestionArea').slideDown(500);
								$( "#securityAnswerMessage").slideUp(500, function(){
									$( "#securityAnswerMessage").removeClass();
									$( "#securityAnswerMessage").addClass("");
									$(xml).find('auth_detail').each(function(){
										$( "#securityAnswerMessage").html(' <div class="alert alert-danger"><i class="fa fa-exclamation-triangle" fa-2x" aria-hidden="true"></i> ' +$(this).find('auth_fail').text()+'</div><br/>');
									});
									$( "#securityAnswerMessage").slideDown(500);
									$('.registerSubmit').hide();
								});
							}
						
						}
					});
				}
				
			};
		<!--- / check security answer--->
		
		
		
													
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

    
 <cfquery name="getIDtype" datasource="icwi_mysql_client_dsn"> 
    SELECT id_type_id, id_type_name
    FROM icwi_id_type
 </cfquery>
 
 <cfquery name="getSecurityQuestion" datasource="icwi_mysql_client_dsn"> 
    SELECT security_id, security_question, own_question
    FROM icwi_security_questions
  </cfquery>
<body> 
				
                
              
                
                
                
                <div class="container" id="registrationForm" name="registrationForm" style="display:;" novalidate><!--- container for registration form --->
                 
                    <div class="row"><!--- row --->
                        <div class="col-sm-8 col-sm-offset-2 form-box "> 

							<div class="wrapperTop"><!--- wrapper Top --->
                               
                                <div class="form-header" >
                                	<!--<span class="fa-stack clickAndGoYellowText">
                                      <i class="fa fa-circle-thin fa-stack-2x"></i>
                                      <i class="fa fa-hand-o-up fa-stack-1x"></i>
                                    </span>-->
                                    <img src="//ebrokertest.icwi.local/email/images/Click&GoHandYellow.png" height="25px"  width="25px" />
                                     ICWI Click & Go Registration
                                </div>
                                <!---progress bar--->
                                <div class="progress progress-striped active" style="width:100%;margin-bottom: 0px " >
                                    <div class="progress-bar  progress-bar-success" width="40%" value="0" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="min-width: 2em;">0%</div>
                                </div>
                                <div id="progressTitles">
                                	<table id="progressTitlesTable">
                                    	<tr >
                                        </tr>
                                    </table>
                                </div>
                             </div><!--- wrapper Bottom--->
                             <div class="wrapperBottom"><!--- wrapper --->
                     
                     
                     
                     
                                <form role="form" action="registration_complete.cfm" name="complete_reg" method="post" class="registration-form" onsubmit="validateForm('#AccountSetup');" novalidate>  
                                    <fieldset name="policySearch" id="policySearch">
                                        <div class="form-top">
                                            <div class="col-sm-8">
                                            <br/>
                                                <h3><span class="formStepTitle">Policy Details</span> - <span class="formStep"></span></h3>
                                                <!--- <br/>
                                                Test numbers: 35518059 114748365  3889110|| 107502399 33968519--->
                                                
                                                
                                               
                                            </div>
                                            <div class="col-sm-4 hidden-xs text-right">
                                            <br/>
                                            	<i class="fa fa-pencil-square-o fa-5x"></i>
                                            </div>
                                        </div>
										
                                        <div class="form-bottom">
                                            <p id="usrError" class="smallInstructions"></p>

                                            
                                            <!---
											form control version 
											--->
                                        	
                                            
                                            
                                            <div class="form-group row">
												
                                                
                                                 <div class="form-group <!---has-success--->  text-right">
                                                	<div class="col-sm-6">
                                                        <div class="col-sm-12">
                                                            <label for="idNum" class="control-label"> What is your policy number?</label>
                                                        </div>
                                                        
                                                        <div class=" col-sm-12" style="margin-top:-10px;">
                                                         <a href="javascript:void(0)" id="toggleHelp" style="font-weight:normal; text-decoration:underline; font-size:12px;">What is this?</a>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-6">
                                                        <div class="input-group">
                                                            <span class="input-group-addon"><i class="fa fa-asterisk"></i></span>
                                                            <input type="number" name="policyNumber" placeholder="Enter numbers only..." class="form-control mustValidate validateNumbersOnly"  id="policyNumber" autocomplete="off" onchange="mainStart()" >
                                                        
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-sm-12 " id="helpDiv" style="display:none;">
                                                	<hr/>
                                                    What is your policy number?
                                                    <br/><br/>
                                                    Your policy number is located in the top right hand section of your certificate (numbers only).
                                                    <br/><br/>
                                                	 <div class="col-sm-12 text-center"><img src="../img/policyNoExample.png" /></div>
                                                
                                                </div>
                                                
											<!---
                                                <div class="form-group <!---has-success--->  text-right">
                                                	<div class="col-sm-6">
                                                        <div class="col-sm-12">
                                                            <label for="idNum" class="control-label"> What is your policy number?</label>
                                                        </div>
                                                        
                                                        <div class=" col-sm-12" style="margin-top:-10px;">
                                                         <a href="javascript:void(0)" data-toggle="tooltip" data-placement="top" title="Your policy number is located in the top right hand section of your certificate (numbers only)." style="font-weight:normal; text-decoration:underline; font-size:12px;">What is this?</a>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-6">
                                                        <div class="input-group">
                                                            <span class="input-group-addon"><i class="fa fa-asterisk"></i></span>
                                                            <input type="number" name="policyNumber" placeholder="Enter numbers only..." class="form-control mustValidate validateNumbersOnly"  id="policyNumber" autocomplete="off" onchange="mainStart()" >
                                                        
                                                        </div>
                                                    </div>
                                                </div>
                                                
                                                
                                               
                                                <div class="form-group has-success">
                                                    <label for="idTypeSelect" class="col-sm-5 control-label">What ID did you register with?</label>
                                                    <div class="col-sm-7">
                                                        <cfoutput> 
                                                            <div class="input-group">
                                                                <span class="input-group-addon"><i class="fa fa-asterisk"></i></span> 
                                                                <select class="form-control mustValidate" id="idTypeSelect" name="idTypeSelect" onChange="mainStart()">
                                                                    <option value="">--select ID Type--</option>
                                                                   
                                                                    <cfloop query="getIDtype">
                                                                          <option value="#id_type_id#">#id_type_name#</option>      
                                                                    </cfloop>
                                                                </select>
                                                             </div>
                                                        </cfoutput>	
                                                    </div>
                                                </div>
                                            
                                                
                                                <br class="hidden-xs"/><br class="hidden-xs"/><br class="hidden-xs"/>
                                                <div class="form-group <!---has-success---> text-right">
                                                    <div class="col-sm-6">
                                                        <div class="col-sm-12">
                                                            <label for="idNum" class="control-label"> What is your ID number?</label>
                                                        </div>
                                                        <div class=" col-sm-12" style="margin-top:-10px;">
                                                         <a href="javascript:void(0)" data-toggle="tooltip" data-placement="top" title="Your ID number is simply your Driver's Licence number or other National Identification number" style="font-weight:normal; text-decoration:underline; font-size:12px;">What is this?</a>
                                                        </div>
                                                     </div>   
                                                    <div class="col-sm-6">
                                                        <div class="input-group">
                                                            <span class="input-group-addon"><i class="fa fa-asterisk"></i></span>
                                                            <input type="text" name="idNum" placeholder="Enter ID number..." class="form-control mustValidate pull-right"  id="idNum" autocomplete="off" onChange="mainStart()" >
                                                            
                                                        </div>
                                                        
                                                    </div>
                                                </div>
                                                 --->
                                            </div>
                                            <br  class="hidden-xs"/>
                                            <div class="form-group row">
                                                
                                                <div class="col-xs-12 col-sm-6">
                                                    <cfoutput>
                                                     
                                                     <a  href="//#CGI.SERVER_NAME#/client/modules/client_portal/" class="btn  btn-lg btn-clickAndGoBlue btn-block " role="button" >
                                                     	
                                                     	<span class="fa-stack  ">
                                                          <i class="fa fa-circle-thin fa-stack-2x"></i>
                                                          <i class="fa fa-arrow-left fa-stack-1x"></i>
                                                        </span>
                                                        Back 
                                                     </a>
                                                    </cfoutput>
                                                </div>
                                                <br class="visible-xs"/><br class="visible-xs"/>
                                                <div class=" col-xs-12 col-sm-6 form-submit" style="display:none">
                                                    <button type="button" class="btn btn-lg btn-success btn-block btn-next  "  onClick="">
                                                    	Next 
                                                    	<span class="fa-stack ">
                                                          <i class="fa fa-circle-thin fa-stack-2x"></i>
                                                          <i class="fa fa-arrow-right fa-stack-1x"></i>
                                                        </span>
                                                    </button>
                                                 </div>
                                                 <div class=" col-xs-12 col-sm-6 fakeForm-submit">  
                                                    <button type="button" class="btn btn-lg btn-clickAndGoYellow btn-block  " onClick="validateForm('#policySearch');">Search 
                                                    	<span class="fa-stack  ">
                                                          
                                                          <i class="fa fa-search fa-stack-1x"></i>
                                                        </span>
                                                    </button>
                                                  
                                                    
                                                </div>
                                                
                                            </div> 
                                        </div>
										
                                       
                                    </fieldset> 
                                    
                                    <fieldset name="finishRegistration" id="finishRegistration">
                                        <div class="form-top"><!---form top--->
                                           <div class="form-group row">
                                               <div class="col-sm-8">
                                                    <br/>
                                                    <h3><span class="formStepTitle">Validation</span> - <span class="formStep"></span></h3>
                                                    
                                               </div>
                                                <div class="col-sm-4 hidden-xs text-right">
                                                    <br/>
                                                    
                                                    <i class="fa fa-key fa-5x"></i>
                                               
                                                </div>
                                            </div>
                                         </div><!---/ form top--->
                                            
                                        <div class="form-bottom"><!--- form bottom--->
                                          
                                            <div class="form-group row"> <!---form group--->
                                            	<div class="col-sm-12">
                                                    <div id="securityAnswerMessage">
                                                    </div>
                                                    <div id="securityQuestionArea">
                                                        <div id="securityQuestion">
                                                        </div>
                                                     
                                                        <br/>
                                                        <input type="text" name="securityAnswer" placeholder="Enter answer..." class="form-control"  id="securityAnswer" autocomplete="off" onchange="checkSecurityAnswer()" >
                                                        <input type="hidden" name="clientNumber" id="clientNumber" />
                                                         
                                                     </div>
                                                </div>
                                            </div> <!---/ form group--->
                                            
                                            
                                            <div class="row" >
                                       	 		<div class="col-xs-12 col-sm-6">
                                                    <button type="button" class="btn-previous btn  btn-lg btn-clickAndGoBlue btn-block">
                                                    	 
                                                     	<span class="fa-stack  ">
                                                          <i class="fa fa-circle-thin fa-stack-2x"></i>
                                                          <i class="fa fa-arrow-left fa-stack-1x"></i>
                                                        </span>
                                                        Back
                                                    </button>
                                                    <br  class="visible-xs"/>
                                                </div>
                                                
                                        		<div class="col-xs-12 col-sm-6 security-Check">
                                                    <button type="button" class="btn btn-lg btn-clickAndGoYellow btn-block  " onClick="checkSecurityAnswer()">
                                                    	Validate
                                                    	<span class="fa-stack  ">
                                                          
                                                        </span>
                                                    </button>
                                                </div>
                                                <div class="col-xs-12 col-sm-6 registerSubmit" style="display:none" >
                                                    <button type="button" class="btn btn-lg btn-success btn-block   btn-next" onClick="">
                                                    	Next 
                                                        <span class="fa-stack ">
                                                          <i class="fa fa-circle-thin fa-stack-2x"></i>
                                                          <i class="fa fa-arrow-right fa-stack-1x"></i>
                                                        </span>
                                                    </button>
                                                </div>    
                                             </div>
                                        </div> <!--- /form bottom--->
                                      </fieldset>
                                      <fieldset name="AccountSetup" id="AccountSetup">
                                        <div class="form-top"><!---form top--->
                                             <div class="col-sm-8">
                                            	<br/>
                                                <h3><span class="formStepTitle">Account Details</span> - <span class="formStep"></span></h3>
                                                
                                           </div>
                                            <div class="col-sm-4 hidden-xs text-right">
                                            	<br/>
                                            	
                                                <i class="fa fa-user fa-5x"></i>
                                           
                                            </div><!---/ form right--->
                                         </div><!---/ form top--->
                                            
                                        <div class="form-bottom"><!--- form bottom--->
                                            
                                            <div class="form-group row"> <!---form group--->
                                            	<div class="col-sm-12">
                                               
                                                     <div id= "otherRegistrationQuestions" style="display:none">
                                                        <h3>Almost done!  We just need a little more information to finish setting up your account.</h3>
                                                        <br/>
                                                        <!---What email address would you like to be associated with your account?--->
                                                        Please provide us with a valid email address to create your account.  
                                                        <div id="emailError" style="display:none">
                                                        
                                                        </div>
                                                        <input type="email" name="regEmail" placeholder="Enter your email..." class="form-control mustValidate validateEmail"  id="regEmail" autocomplete="off"  >
                                                        
                                                        <br/>
                                                        Create a password for your Click & Go account.
                                                        <input type="password" name="regPassword" placeholder="Enter Your Password..." class="form-control mustValidate"  id="regPassword" autocomplete="off"  >
                                                        
                                                        Confirm password.
                                                        <input type="password" name="regPasswordConfirm" placeholder="Retype your password..." class="form-control mustValidate"  id="regPasswordConfirm" autocomplete="off"  >
                                                        <br/>
                                                        Please choose a security question to help secure your account</label>
                                                        <cfoutput> 
                                                                <select class="form-control mustValidate" id="securityQuestionValidate" name="securityQuestionValidate">
                                                                    <option value="">--select security question--</option>
                                                                   
                                                                    <cfloop query="getSecurityQuestion">
                                                                          <option value="#security_id#,#own_question#">#security_question#</option>      
                                                                    </cfloop>
                                                                </select>
                                                        </cfoutput>	
                                                        <br/>
                                                        
                                                        <div id="myOwnQuestion" style="display:none;">
                                                            Please enter your custom question.
                                                            <input type="text" name="regQuestion" placeholder="Enter Your Question..." class="form-control"  id="regQuestion" autocomplete="off" >
                                                            <br/>
                                                        </div>
                                                        
                                                        What is the answer to your security question?
                                                        <input type="text" name="regAnswer" placeholder="Enter your answer..." class="form-control mustValidate"  id="regAnswer" autocomplete="off"  >
                                                     </div>
                                                 </div>
                                            </div> <!---/ form group--->
                                            
                                            
                                            <div class="row" >
                                       	 		<div class="col-xs-12 col-sm-6">
                                                    <button type="button" class="btn-previous btn  btn-lg btn-clickAndGoBlue btn-block">
                                                    	
                                                     	<span class="fa-stack  ">
                                                          <i class="fa fa-circle-thin fa-stack-2x"></i>
                                                          <i class="fa fa-arrow-left fa-stack-1x"></i>
                                                        </span>
                                                        Back 
                                                    </button>
                                                </div>
                                                
                                        		<div class="col-xs-12 col-sm-6">
                                                    <button type="submit" class="btn  btn-lg btn-block btn-success finishRegisterSubmit"  onclick="checkPasswords('regPassword','regPasswordConfirm'); validateForm('#AccountSetup');">
                                                    	Complete Registration
                                                        <span class="fa-stack  ">
                                                          <i class="fa fa-circle-thin fa-stack-2x"></i>
                                                          <i class="fa fa-check fa-stack-1x"></i>
                                                        </span>
                                                    </button>
                                                </div> 
                                                
                                                
                                        </div> <!--- /form bottom--->
                                      </fieldset>
                                </form>
                                <!---
                                 Functionality to disable email for testing
								 --->
                                <br/><br/>
                                                <div class="well row">
                                                	<hr/>
                                                    <div class="col-sm-12">
                                                        <b>This is not part of the sign up form. For testing only.</b> Already registerd using your email address? Use the form below to deactivate your account so you can register again.
                                                        <br/>  <br/>
                                                     </div>
                                                     
                                                    <div class="col-sm-12 bg-warning" id="disableEmailMessage">
                                                    </div>
                                                    <br/>
                                                    <div class="col-sm-8">
                                                        
                                                        <input type="text" name="disableEmail" id="disableEmail" placeholder="Enter Email Address" class="form-control" autocomplete="off">
                                                    </div>
                                                    <div class="col-sm-4">
                                                        <button type="button" class="btn btn-md btn-info" onClick="disableEmail()">Disable Email</button>
                                                    </div>
                                                </div>   
                                             </div>
											 
                                             
                                
                                 
		                    </div><!--- /wrapper Bottom--->
		                    
                        </div>
                    </div><!--- /row --->
                </div><!--- / container for registration form --->
                
                
              <!---
                <script>
    jQuery(document).ready(function() {
        
        /*
            Fullscreen background
        */
        $.backstretch("http://orig03.deviantart.net/f7f1/f/2014/338/3/8/bjork___wanderlust___mosaic_vector_portrait_by_devilfeel-d88mqbu.png");
        
        $('#top-navbar-1').on('shown.bs.collapse', function(){
            $.backstretch("resize");
        });
        $('#top-navbar-1').on('hidden.bs.collapse', function(){
            $.backstretch("resize");
        });
        
      
        
    });
    </script>
	--->
</body>
</html>
