<!---
	Name:				Alyssa Morgan
	Date:				September 24, 2015
	Modifications:		
						
	Description:		


--->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

	
	<title>ICWI Client Portal</title>
    
    <script>
		
		$( document ).ready(function() {
			
			//use strength for password checker
			$('#regPassword').strength();
			
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
									$( "#emailError").addClass("errors");
									$(xml).find('email_check').each(function(){
										$( "#emailError").html(' <img src="../img/warning.png" width="100px" height="80px" style="padding-right:10px;" align="left"/><br/>' +$(this).find('email_message').text());
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
		
		
		<!---logIn --->
		
		function logIn(){
			$('#signInError').html('<div style="text-align:center;color:#006;"><img src="../img/loadingSpiral.gif"><br/>Getting account details</div><br/>')	
			$('#signInError').slideDown();
			var user_name = $( "#logInEmail" ).val();
			var user_password = $( "#logInPassword" ).val();
			
				if((user_password != '') && (user_name != ''))
				{ 
					$.ajax({
					type: "POST",
					url: "process_login.cfc?method=verifyCredentials",
					data: ({
						user_name: user_name,
						user_password : user_password
						
					}),
					dataType: "text",
						success: function(xml)
						{
							$(xml).find('login_check').each(function(){
								 clientHasFail=$(xml).find("login_message").text();
								 
							});
							alert($clientHasFail)
							if(clientHasFail.length == 0)
							{
								<cfoutput> window.location.href = "#homePage#";</cfoutput>
								
							}else{
								
								
								$( "#signInError").slideUp(500, function(){
									$( "#signInError").removeClass();
									$( "#signInError").addClass("errors");
									$(xml).find('login_check').each(function(){
										$( "#signInError").html(' <img src="../img/warning.png" width="100px" height="80px" style="padding-right:10px;" align="left"/><br/>' +$(this).find('login_message').text());
									});
									$( "#signInError").slideDown(500);
								});
							}
						
						}
					});
				}else{
					$( "#signInError").slideUp(500, function(){
									$( "#signInError").removeClass();
									$( "#signInError").addClass("errors");
									$( "#signInError").html(' <img src="../img/warning.png" width="100px" height="80px" style="padding-right:10px;" align="left"/><br/> Please fill in all fields');
									$( "#signInError").slideDown(500);
								});
				}
			
		}
		<!---/ login--->
		
		<!---mainStart--->
			var globalPolicy = '';
			var globalSecurityQuestion = '';
			var webServiceURL = 'http://ebroker.icwi.local/rest/services/';
			
			
			function mainStart(){ 
					
					$('.form-submit').hide();
					$('.fakeForm-submit').show();
					
					var policyNumber = $( "#policyNumber" ).val().replace( /[^0-9]/g, '');
					var idTypeSelect = $( "#idTypeSelect" ).val();
					var idNum = $( "#idNum" ).val();
					
					if((policyNumber != '') && (idTypeSelect != '')&& (idNum != '') )
					{ /*
						$.ajax({
							
						type: "POST",
						url: "authentication.cfc?method=userAuthenticationLvl1",
						data: ({
							policy_number: policyNumber,
							id_number:idNum,
							id_type: idTypeSelect
							
						}),*/
						$.ajax({
							
						type: "GET",
						contentType: 'application/xml',
						url: webServiceURL + "authLvI/" + policyNumber + "/" + idNum,
						dataType: "xml",
						/*data: ({
							policy_number: policyNumber,
							id_number:idNum,
							id_type: idTypeSelect
						*/	
						}),
						//dataType: "text",
							success: function(xml)
							{
								$(xml).find('client_detail').each(function(){
									 clientHasFail=$(xml).find("client_fail").text();
								});
								if(clientHasFail.length == 0)
								{
									$( "#usrError").slideUp(500, function(){
										$( "#usrError").removeClass();
										$( "#usrError").addClass("success");
										$(xml).find('client_detail').each(function(){
											$( "#usrError").html('<div><img src="../img/success-icon.png" width="200px" height="110px" style="padding-right:10px;" align="left"/><br/>'+$(this).find('client_pass').text()+'</div><br/>');
											$('#securityQuestion').html($(this).find('client_question').text())
											
											$( "#usrError").slideDown(500);
											
											globalPolicy = policyNumber;
											globalSecurityQuestion =$(this).find('client_question').text();
										});
										
									});
									$('.fakeForm-submit').hide();
								    $('.form-submit').show();
									
								}else{
									//if no querry returns a result
									$( "#idNum" ).val('');
									$( "#idTypeSelect" ).val('');
									$( "#policyNumber" ).val('');
									
									$( "#usrError").slideUp(500, function(){
										$( "#usrError").removeClass();
										$( "#usrError").addClass("errors");
										$(xml).find('client_detail').each(function(){
											$( "#usrError").html(' <img src="../img/warning.png" width="100px" height="80px" style="padding-right:10px;" align="left"/>You entered the Policy number: '+policyNumber+', ID type: '+idTypeSelect+ ', ID number: '+idNum+ '<br/>' +$(this).find('client_fail').text());
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
		
		<!--- check security answer--->
		
			function checkSecurityAnswer(){ 
				$('.security-Check').show();
				$('.registerSubmit').hide();
				$( "#securityAnswerMessage").slideUp(500);
				var answer = $( "#securityAnswer" ).val();
				
				if((answer != ''))
				{ 
					$.ajax({
					type: "POST",
					url: "auth_question.cfc?method=userAuthenticationLvl2",
					data: ({
						policy_number: globalPolicy,
						answer : answer,
						question: globalSecurityQuestion
						
					}),
					dataType: "text",
						success: function(xml)
						{
							$(xml).find('auth_detail').each(function(){
								 clientHasFail=$(xml).find("auth_fail").text();
							});
							if(clientHasFail.length == 0)
							{
								$( "#securityAnswerMessage").slideUp(500, function(){
									$( "#securityAnswerMessage").removeClass();
									$( "#securityAnswerMessage").addClass("success");
									$(xml).find('auth_detail').each(function(){
										$( "#securityAnswerMessage").html('<img src="../img/success-icon.png" width="200px" height="110px" style="padding-right:10px;" align="left"/><br/><br/>'+$(this).find('auth_pass').text())+'<br/><br/>';
										
									});
								});
								$( "#securityAnswerMessage").slideDown(500);
								$('#otherRegistrationQuestions').slideDown(500);
								
								
								$('.security-Check').hide();
								$('.registerSubmit').show();
								
							}else{
								//if no querry returns a result
								$( "#securityAnswer" ).val('');
								
								$('#otherRegistrationQuestions').slideUp(500);
								
								$( "#securityAnswerMessage").slideUp(500, function(){
									$( "#securityAnswerMessage").removeClass();
									$( "#securityAnswerMessage").addClass("errors");
									$(xml).find('auth_detail').each(function(){
										$( "#securityAnswerMessage").html(' <img src="../img/warning.png" width="100px" height="80px" style="padding-right:10px;" align="left"/><br/>' +$(this).find('auth_fail').text());
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
</head>
<!---
<cfoutput>
	  <cfset session.allowin = "false" />
	  <cfset session.user_id = "0" />
      <cfset session.user_name = "" />
      <cfset session.user_role = "" />
      <cfset session.territory_id = "0" />
</cfoutput>
--->
<!---f0r functions that need the url params on page load--->
    <cfif isDefined("url.srcCode") AND isDefined("url.srcType")> 
		<cfset srcCodeToSend = '#url.srcCode#'>
        <cfset srcTypeToSend = '#url.srcType#'>
    <cfelse>
        <cfset srcCodeToSend = '999'>
        <cfset srcTypeToSend = 'DR'>
    </cfif>
    
 <cfquery name="getIDtype" datasource="icwi_mysql_client_dsn"> 
 
    SELECT id_type_id, id_type_name
    FROM icwi_id_type
 </cfquery>
 
 <cfquery name="getSecurityQuestion" datasource="icwi_mysql_client_dsn"> 
    SELECT security_id, security_question, own_question
    FROM icwi_security_questions
  </cfquery>
<body>
				
                
                <div class="container " id="loginOrregisterDiv" style="display:;"><!--- login or register --->
                        <div class="row"><!--- row login or register--->
                            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 form-box">               
                                <div class="wrapperTop"><!--- wrapper Top --->
                                
                                	<div class="form-header" style="padding:20px 0px 10px 10px"><h3><i class="fa fa-smile-o"></i> <span class="hidden-xs">Welcome to </span>ICWI's Client Portal</h3></div>
                                
                             </div><!--- wrapper Top --->
                             <div class="wrapperBottom"><!--- wrapper Bottom--->
                                    <br/>
                                    <div class="row" >
                                        <div class="col-xs-12 col-sm-6 col-md-7 col-lg-7">
                                            <h3 style="color:#006;">First Time Visitors </h3>
                                            <hr/>
                                            <br/>
                                                Using the ICWI client portal you can:
                                                <br/><br/>
                                                <ul class="list-unstyled col-sm-offset-1">
                                                     <li><i class="fa fa-check-circle text-success"></i> In commodo rhoncus metus, et fermentum elit rutrum et. </li>
                                                    <li><i class="fa fa-check-circle text-success"></i> Cras nec vulputate metus, imperdiet congue massa. Etiam vitae tellus maximus, elementum ex ut, blandit tortor.</li>
                                                    <li><i class="fa fa-check-circle text-success"></i> Ut tristique vehicula metus eget elementum. </li>
                                                    <li><i class="fa fa-check-circle text-success"></i> And much more... </li>
                                                </ul>
                                               
                                                <br/>
                                                <a href="#" class="btn  btn-success btn-lg btn-block" role="button" onClick="openRegistration()">Register Now!</a>
                                             <br/>
                                             <br/>
                                        </div>
                                        <div class="col-xs-12 col-sm-6 col-md-5 col-lg-5">
                                        
                                            <h3 style="color:#006;">Returning Guests</h3>
                                            <hr/>
                                            <br/>

                                            Already have an account? Just login below.
                                            <br/>
                                            <br/>
                                            <div id="signInError" style="display:none">;
                                            </div>
                                            <form class="form-horizontal"name="process_login" action="process_login.cfm" method="post">
                                              <div class="form-group">
                                                <label for="logInEmail" class="col-sm-3 control-label">Email or Policy No.</label>
                                                <div class="col-sm-9">
                                                    <div class="input-group">
                                                        <span class="input-group-addon"><i class="fa fa-envelope-o"></i></span>
                                                        <input type="text" class="form-control" name="logInEmail" id="logInEmail" placeholder="Email...">
                                                    </div>
                                                </div>
                                              </div>
                                              <div class="form-group">
                                                <label for="logInPassword" class="col-sm-3 control-label">Password</label>
                                                <div class="col-sm-9">
                                                    <div class="input-group">
                                                        <span class="input-group-addon"><i class="fa fa-key"></i></span>
                                                        <input type="password" class="form-control" name="logInPassword" id="logInPassword" placeholder="Password...">
                                                    </div>
                                                </div>
                                              </div>
                                              
                                              <div class="form-group">
                                                <div class="col-sm-offset-3 col-sm-10">
                                                  <a href="#" class="btn btn-info btn-lg" role="button" onClick="logIn()">Sign In</a>
                                                </div>
                                              </div>
                                            </form>
                                        </div>
                                    </div>
                                 </div><!--- / wrapper--->
                             </div>
                         </div>
                     </div>     <!--- / login or register --->
                
                
                
                <div class="container" id="registrationForm" name="registrationForm" style="display:none;" novalidate><!--- container for registration form --->
                 
                    <div class="row"><!--- row --->
                        <div class="col-sm-8 col-sm-offset-2 form-box "> 

							<div class="wrapperTop"><!--- wrapper Top --->
                               
                                <div class="form-header" ><i class="fa fa-smile-o"></i> ICWI Client Portal Registration</div>
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
                     
                     
                     
                     
                                <form role="form" action="complete_registration.cfm" name="complete_reg" method="post" class="registration-form" novalidate>  
                                    <fieldset name="finishRegistration" id="policySearch">
                                     	<cfinclude template="../URLParams.cfm">
                                        <div class="form-top">
                                            <div class="form-top-left">
                                                <h3><span class="formStepTitle">Account Details</span> <span class="formStep"></span></h3>
                                                <p>Please enter the Policy number, ID Type and ID Number associated with your ICWI account
                                                <br/>
                                                Test numbers: 35518059 114748365  3889110||<!---  107502399 33968519--->
                                                </p>
                                               
                                            </div>
                                            <div class="form-top-right">
                                            	<i class="fa fa-pencil-square-o"></i>
                                            </div>
                                        </div>
										
                                        <div class="form-bottom">
                                         	<p id="usrError" class="smallInstructions">
                                            </p>

                                            
                                            <!---
											form control version 
											--->
                                            <div class="form-group has-success">
                                                <label  for="policyNumber"  class="col-sm-5 control-label">What is your policy number?</label>
                                                <div class="col-sm-7">
                                                	<div class="input-group">
                                                        <span class="input-group-addon"><i class="fa fa-asterisk"></i></span>
                                                        <input type="number" name="policyNumber" placeholder="Enter Your Policy Number..." class="form-control mustValidate validateNumbersOnly"  id="policyNumber" autocomplete="off" onchange="mainStart()" >
                                                    
                                                	</div>
                                                </div>
                                            </div>
                                            <br  class="hidden-xs"/><br  class="hidden-xs"/><br  class="hidden-xs"/>
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
                                            <div class="form-group has-success">
                                                <label for="idNum" class="col-sm-5 control-label">What is the ID number?</label>
                                                <div class="col-sm-7">
                                                	<div class="input-group">
                                                        <span class="input-group-addon"><i class="fa fa-asterisk"></i></span>
                                                		<input type="text" name="idNum" placeholder="Enter ID Number..." class="form-control mustValidate"  id="idNum" autocomplete="off" onChange="mainStart()" >
                                            		</div>
                                                </div>
                                            </div>
                                           
                                            <br  class="hidden-xs"/><br  class="hidden-xs"/><br  class="hidden-xs"/>
                                            <div class="form-group">
                                                <div class="col-sm-offset-5 col-sm-10">
                                                    <button type="button" class="btn btn-info btn-lg fakeForm-submit " onClick="validateForm('#policySearch');">Search For Policy</button>
                                                    <button type="button" class="btn btn-next form-submit btn-success " style="display:none" onClick="">Next</button>
                                                </div>
                                            </div> 
                                        </div>
										
                                       
                                    </fieldset> 
                                    
                                    <fieldset name="finishRegistration" id="finishRegistration">
                                        <div class="form-top"><!---form top--->
                                            <div class="form-top-left"><!---form left--->
                                            	
                                                <h3><span class="formStepTitle">Confirm Policy</span> <span class="formStep"></span></h3>
                                           		<p>
                                                	We are tryiong to verify your identity. Please answer the question below to confirm.
                                                </p>
                                           </div><!---/ form left--->
                                            <div class="form-top-right"><!---form right--->
                                            	
                                                <i class="fa fa-key"></i>
                                           
                                            </div><!---/ form right--->
                                         </div><!---/ form top--->
                                            
                                        <div class="form-bottom"><!--- form bottom--->
                                            
                                            <div class="form-group"> <!---form group--->
                                            	<div id="securityAnswerMessage">
                                                </div>
                                                <div id="securityQuestion">
                                                </div>
                                                <br/>
                                                <input type="text" name="securityAnswer" placeholder="Enter Your Answer..." class="form-control"  id="securityAnswer" autocomplete="off" onchange="checkSecurityAnswer()" >
                                                 
                                                 <div id= "otherRegistrationQuestions" style="display:none">
                                                 	<hr/>
                                                    <h3>We need a little more information to finish setting up your account...</h3>
                                                    <br/>
                                                    What email address would you like to be associated with your account?
                                                    <div id="emailError" style="display:none">
                                                    
                                                    </div>
                                                    <input type="email" name="regEmail" placeholder="Enter Your Email..." class="form-control mustValidate validateEmail"  id="regEmail" autocomplete="off"  >
                                                    
                                                    <br/>
                                                    Please enter your password
                                                 	<input type="password" name="regPassword" placeholder="Enter Your Password..." class="form-control mustValidate"  id="regPassword" autocomplete="off"  >
                                                     <br/>
                                                    Confirm password
                                                 	<input type="password" name="regPasswordConfirm" placeholder="Retype Your Password..." class="form-control mustValidate"  id="regPasswordConfirm" autocomplete="off"  >
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
                                                    	Please enter your custom question
                                                        <input type="text" name="regQuestion" placeholder="Enter Your Question..." class="form-control"  id="regQuestion" autocomplete="off" >
                                                        <br/>
                                                    </div>
                                                    
                                                    What is the answer to your security question?
                                                    <input type="text" name="regAnswer" placeholder="Enter Your Answer..." class="form-control mustValidate"  id="regAnswer" autocomplete="off"  >
                                                 </div>
                                            </div> <!---/ form group--->
                                            
                                            <br/><br/>
                                            <div class="row" >
                                       	 		<div class="col-xs-4 col-sm-4 col-md-4 col-lg-4">
                                                    <button type="button" class="btn btn-previous">Previous</button>
                                                </div>
                                        		<div class="col-xs-8 col-sm-8 col-md-8 col-lg-8">
                                                    <button type="button" class="btn btn-info btn-lg security-Check" onClick="checkSecurityAnswer()">Submit Answer</button>
                                                    <button type="submit" class="btn registerSubmit" style="background-color:#093;display:none;"  onClick="checkPasswords('regPassword','regPasswordConfirm');validateForm('#finishRegistration');">Complete Registration</button>
                                                </div>    
                                        </div> <!--- /form bottom--->
                                      </fieldset>
                                </form>
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
