  <div class="well-blue-transparent">
                                    <br/>
                                    
                                    <div class="row  text-left " >
                                        <div class="col-sm-offset-2  col-xs-2 col-sm-2 col-md-2 col-lg-2 hidden-xs text-info" ng-init="message='Enter your new password below:'">
                                         	<br />
                                         	<img src="../img/logo.png" style="width: 100%; max-height:200px; max-width:130px; " /><br/>
                                         </div>  
                                         
                                         <div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">  
                                            <div>
                                                <h2 style="color:#fff;">Password Reset</h2>
                                                <hr />
                                                <br/>
                                                
                                                 <uib-alert ng-show="showMessage" type="{{classText}}" style="font-size:20px;"><i class="fa fa-info-circle"></i> {{message}} <br/></uib-alert>
                                                
                                                <div ng-show="dontHideLoginStuff" ng-init="dontHideLoginStuff=true">
                                                    <label>Enter new password</label>
                                                    <input type="password" id="password" class="form-control" ng-model="password" /><br/>
                                                    
                                                    <br />
                                                    <label>Retype password</label>
                                                    <input type="password" id="password2" class="form-control" ng-model="password2" /><br/>
                                                    <br />
                                                     <a class="btn btn-info btn-lg" role="button" ng-click="triggerChangePwd()">Reset Password</a>
                                                </div>
                                                 <div ng-show="!dontHideLoginStuff">  
                                                   <span  style="font-size:20px;">
                                                        <br />
                                                        You will be redirected automatically to the login page in <b>{{countDown}}</b> seconds.
                                                    </span>
                                                </div>
                                                <br/><br/>
                                            </div>
                                        </div>   
                                          
                                        
                                    </div>
                                
            </div>         
                     


