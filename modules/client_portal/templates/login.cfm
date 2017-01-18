

<div ng-repeat="request in requests">
  {{request.branchName}} {{request.reqNum}} {{request.deets}}
  <br />
</div>
                                    <br/><br/>
                                    <div class="row">
                                    	<div class="col-xs-12 col-sm-4 pull-right">
                                        	<img src="../img/logo.png" style="width:100%; max-height:100px; max-width:100px;" /><img src="../img/Click&Go_only.png" style="width: 100%; max-height:120px; max-width:150px;" />
                                        </div>
                                    </div>
                                   
                                    <br/>
                                    <br/>
                            		<div class="row visible-xs"><!--- segister row xs--->
                                   		<div class="col-xs-12 col-sm-12 ">
                                        	<cfoutput>
                                            	 <a  ng-href="//#CGI.SERVER_NAME#/client/modules/eclient_registration/registration.cfm" class="btn btn-lg btn-block btn-clickAndGoYellow"  role="button" >
                                                 	Click to register-
                                                    <span class="fa-stack  clickAndGoBlueText pull-right">
                                                          <i class="fa fa-circle-thin fa-stack-2x"></i>
                                                          <i class="fa fa-arrow-right fa-stack-1x"></i>
                                                        </span>
                                                 </a>
                                                
                                            </cfoutput>
                                    	</div>
                                    </div><!--- / segister row xs--->
                                    <div class="row"><!--- welcome row--->
                                    	<div class="col-xs-12 col-sm-4 pull-left hidden-xs" style="font-family:Arial, Helvetica, sans-serif; color:#ffffff; font-size:90px; letter-spacing:0.1em;">
                                    		Welcome
                                            <br/><br/><br/>
                                        </div>
                                    </div><!--- / welcome row--->
                                    
                                    <div class="row text-left">
                                    	<div class="col-xs-12 col-sm-7 "><!---login row--->
                                        	<div class="col-xs-12 col-sm-4 pull-left visible-xs" style="font-family:Arial, Helvetica, sans-serif; color:#ffffff; ">
                                                <h2>Log in below</h2>
                                                <hr/>
                                            </div>
                                            <div class="col-xs-12 col-sm-12 ">
                                            	<uib-alert  type="warning" ng-show="showloginError" close="showloginError = false">{{loginError}}</uib-alert>
                                            </div>
                                            
                                            
                                            <form class="" id ="clientLogin" name="myForm" ng-submit="loginSubmit()">
                                            
                                              <div class="col-sm-12">
                                                    <div class="input-group">
                                                        <span class="input-group-addon"><i class="fa fa-envelope-o"></i></span>
                                                        <input style="height:55px;" type="text" class="form-control" ng-model="eClientLoginUsername" id="logInEmail" placeholder="Email or Policy No...">
                                                    </div>
                                              </div>
                                              
                                              <br class="hidden-xs"/><br />
                                                <div class="col-sm-12">
                                                    <div class="input-group">
                                                        <span class="input-group-addon"><i class="fa fa-key"></i></span>
                                                        <input style="height:55px;"  type="password" class="form-control" ng-model="eClientLoginPassword"  id="logInPassword" placeholder="Password...">
                                                        
                                                    </div>
                                                    
                                                </div>
                                              
                                              <br class="hidden-xs"/><br />
                                                <div class="col-xs-12 col-sm-6">
                                                  <!--
                                                  <a  class="btn   btn-lg btn-block btn-clickAndGoBlue" role="button" ng-click="loginSubmit()">
                                                  	Sign In
                                                  	<span class="fa-stack fa-lg ">
                                                      <i class="fa fa-circle-thin fa-stack-2x"></i>
                                                      <i class="fa fa-arrow-right fa-stack-1x"></i>
                                                    </span>
                                                  </a>
                                                  -->
                                                  <input type="submit" class="btn   btn-lg btn-block btn-clickAndGoBlue" value="Sign in"> 
                                                  
                                                  
                                                  <cfoutput>
                                                      <a ng-href="//#CGI.SERVER_NAME#/client/modules/eclient_registration/registration.cfm" class=" clickAndGoYellowLink hidden-xs" >
                                                        Not yet registered? Register now!
                                                         
                                                      </a>
                                                  </cfoutput>
                                                </div>
                                                <div class=" col-xs-12 col-sm-6 ">
                                                  <a href ng-click="forgotPwd()" class="pull-right clickAndGoYellowLink " >
                                                  	Forgot Password?
                                                     
                                                  </a>
                                                </div>
                                                
                                              
                                              <br class="hidden-xs"/>  
                                            </form>
                                        </div><!---/ login row--->
                                        <div class="col-xs-12 col-sm-5 "><!---right of login row--->
                                        
                                        </div><!--- /right of login row--->
                                    </div><!--- / log in section--->
                                    <br/>
                                    
                                    <br/>
                                    
                                    <div class="row text-left"><!---info section row--->
                                    	<div class="col-xs-12 col-sm-6  hidden-xs"><!---info row--->
                                    		<div class="col-sm-12  clickAndGoBlueWell ">	
                                                <div class="col-xs-10">
                                                    <h2>Why use Click & Go?</h2>
                                                </div>
                                                <div class="col-xs-2">
                                                    <!---
                                                    <span class="fa-stack fa-2x clickAndGoYellowText pull-right">
                                                      <i class="fa fa-circle-thin fa-stack-2x"></i>
                                                      <i class="fa fa-hand-o-up fa-stack-1x"></i>
                                                    </span>
                                                    --->
                                                   <img src="//ebroker.icwi.com/email/images/Click&GoHandYellow.png" style="width: 100%; max-height:65px; max-width:95px;" />
                                                </div>
                                                <div class="col-sm-12"> 
                                                    Simplify your life... anytime, anywhere!
                                                     <br class="hidden-xs"/>
                                                        <ul class="list-unstyled col-sm-offset-1 ">
                                                            <li><i class="fa fa-check-circle " style="color:##BED8BE"></i> Renew your policy online </li>
                                                            <li><i class="fa fa-check-circle " style="color:##BED8BE"></i> Report a claim </li>
                                                            <li><i class="fa fa-check-circle " style="color:##BED8BE"></i> Update your personal information </li>
                                                            <li><i class="fa fa-check-circle " style="color:##BED8BE"></i> Save time! </li>
                                                        </ul>
                                                   </div>
                                                </div>
                                                
                                    	</div><!--- / info row--->
                                        <div class="col-xs-12 col-sm-6 hidden-xs"><!---register row--->
                                        	<cfoutput>
                                                <div class="col-sm-12  clickAndGoYellowWell hoverTransition" onclick="location.href='http://#CGI.SERVER_NAME#/client/modules/eclient_registration/registration.cfm'" >
                                                    <div class="col-sm-10">
                                                        <h2>How do I register?</h2>
                                                    </div>
                                                    <div class="col-sm-2">
                                                        <span class="fa-stack fa-2x clickAndGoBlueText pull-right">
                                                          <i class="fa fa-circle-thin fa-stack-2x"></i>
                                                          <i class="fa fa-arrow-right fa-stack-1x"></i>
                                                        </span>
                                                    </div>
                                                    <div class="col-sm-12"> 
                                                        Registration is quick & easy!
                                                         <br class="hidden-xs"/>
                                                            <ul class="list-unstyled col-sm-offset-1 ">
                                                                <li><i class="fa fa-check-circle " ></i> Have your policy and ID numbers handy </li>
                                                                <li><i class="fa fa-check-circle " ></i> Be sure to have an active email address </li>
                                                                <li><i class="fa fa-check-circle " ></i> Think of a unique password </li>
                                                                <li><i class="fa fa-check-circle " ></i> Activate your account! </li>
                                                            </ul>
                                                       </div>
                                                    </div>	
                                                  </div>
                                            </cfoutput>
                                        </div><!--- /registerrow--->
                                    </div><!---info section row--->
                                    
                                    
                                    
                                    
                                    
                                    
                                    <!---
                                    
                                   <div class="visible-xs">
										<cfoutput>
                                            <a  ng-href="http://#CGI.SERVER_NAME#/client/modules/eclient_registration/registration.cfm" class="btn btn-lg btn-block btn-success"  role="button" >Not registered? Register Now!</a>
                                        </cfoutput>
                                        <br/><br/>
                                    </div>
                                    <div class="row text-left well-blue-transparent ">
                                        <div class="col-xs-12  col-sm-6 col-md-5 hidden-xs "> <!---visitors row--->
                                            <h3 style="color:#fff;">Create an Account </h3>
                                            <hr/>
                                            <br class="hidden-xs"/> 
                                            	Signing up with ICWI Click & Go brings convenience to you!
                                             <br class="hidden-xs"/><br class="hidden-xs"/>   
                                                <ul class="list-unstyled col-sm-offset-1 hidden-xs">
                                                    <li><i class="fa fa-check-circle " style="color:##BED8BE"></i> Easy access to your policy information </li>
                                                    <li><i class="fa fa-check-circle " style="color:##BED8BE"></i> Renew your policy online </li>
                                                    <li><i class="fa fa-check-circle " style="color:##BED8BE"></i> Report a claim </li>
                                                    <li><i class="fa fa-check-circle " style="color:##BED8BE"></i> Update your personal information </li>
                                                    
                                                    <li><i class="fa fa-check-circle " style="color:##BED8BE"></i> And much more... </li>
                                                </ul>
                                                <br class="hidden-xs"/>
                                                <cfoutput>
                                                	<a  ng-href="http://#CGI.SERVER_NAME#/client/modules/eclient_registration/registration.cfm" class="btn   btn-lg btn-block btn-success"  role="button" >Register Now!</a>
                                             	</cfoutput>
                                             <br/>
                                             <br/>
                                        </div><!--- / visitors row--->
                                        <div class=" col-sm-2 hidden-xs hidden-sm "> <!---horz divider row--->
                                           <!---<span class="verticalLine" >
                                           	<BR/><BR/><BR/><BR/>--->
                                           </span>
                                        </div><!--- / horz divider  row--->
                                        <div class="col-xs-12 col-sm-6 col-md-5"><!---login row--->
                                        
                                            <h3 style="color:#fff;" class="">Log In</h3>
                                            <hr/>
                                            <br class="hidden-xs"/>

                                            
                                            <uib-alert  type="warning" ng-show="showloginError" close="showloginError = false">{{loginError}}</uib-alert>
                                            
                                            
                                            
                                            <form class="form-horizontal" action="/" id ="clientLogin" name="myForm">

                                              <div class= "col-sm-12">
                                              	 Log in with your email address or policy number, along with the password you provided at registration.
                                                <br class=""/><br class="hidden-xs"/>  
                                              </div>
                                               
                                              <div class="form-group">
                                                <label for="logInEmail" class="col-sm-5 control-label">Email or Policy No.</label>
                                                <div class="col-sm-7 ">
                                                    <div class="input-group">
                                                        <span class="input-group-addon"><i class="fa fa-envelope-o"></i></span>
                                                        <input type="text" class="form-control" ng-model="eClientLoginUsername" id="logInEmail" placeholder="Email or Policy No...">
                                                    </div>
                                                </div>
                                              </div>
                                              <div class="form-group">
                                                <label for="logInPassword" class="col-sm-5    control-label">Password</label>
                                                <div class="col-sm-7">
                                                    <div class="input-group">
                                                        <span class="input-group-addon"><i class="fa fa-key"></i></span>
                                                        <input type="password" class="form-control" ng-model="eClientLoginPassword"  id="logInPassword" placeholder="Password...">
                                                        
                                                    </div>
                                                    <div class="pull-right col-xs-12 col-sm-8">
                                                      <a href ng-click="forgotPwd()" style="color:#ffffff; text-decoration:underline;">Forgot Password?</a>
                                                    </div>
                                                </div>
                                              </div>
                                              <div class="form-group ">
                                              
                                                <div class="col-xs-12 col-sm-12">
                                                  <a  class="btn   btn-lg btn-block btn-success" role="button" ng-click="loginSubmit()">Log In</a>
                                                </div>
                                                
                                              </div>
                                              <br class="hidden-xs"/>  
                                            </form>
                                        </div><!---/ login row--->
                                    
                  </div>             
                 
               </div>   
			   --->   
