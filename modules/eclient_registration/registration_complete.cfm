<!---
	Name:				Alyssa Morgan
	Date:				September 28, 2015
	Modifications:		
						
	Description:		


--->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

	<cfinclude template="../header.cfm">
    
	<title>ICWI Client Portal</title>
    
    <script>
		
		$( document ).ready(function() {
			
			
			
		});<!--- doc ready --->
		
		
		
		
		
													
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


<!---f0r functions that need the url params on page load--->
    <cfif isDefined("url.srcCode") AND isDefined("url.srcType")> 
		<cfset srcCodeToSend = '#url.srcCode#'>
        <cfset srcTypeToSend = '#url.srcType#'>
    <cfelse>
        <cfset srcCodeToSend = '999'>
        <cfset srcTypeToSend = 'DR'>
    </cfif>
  
<body>
				
                
               
                <cfinclude template="complete_registration.cfm">
                
                <div class="container" id="registrationForm" style="display:;"><!--- container for registration form --->
                 
                    <div class="row"><!--- row --->
                        <div class="col-sm-8 col-sm-offset-2 form-box "> 

							<div class="wrapperTop"><!--- wrapper Top --->
                               
                                <div class="form-header" >
                                	<img src="http://ebrokertest.icwi.local/email/images/Click&GoHandYellow.png" height="25px"  width="25px" />
                                    ICWI Click & Go Registration
                                 </div>
                               
                             </div><!--- wrapper Bottom--->
                             <div class="wrapperBottom"><!--- wrapper --->
                     
                     			 
                                            <div class="col-sm-7" ><!---form left--->
                                            	
                                                <h2>Just one more step! </h2>
                                                <hr/>
                                                <div class="clickAndGoBlueWell">
                                                	To activate your account, please check your email <i><cfoutput><span class="clickAndGoYellowText">#email_address#</span></cfoutput></i> and click on the link provided by ICWI Click & Go.
                                                </div>
                                               <!--- 
											   <h3>You must check your email and activate your account before logging in</h3>
                                                <br/>
                                                
                                                 <cfoutput>
                                                     <a  href="http://#CGI.SERVER_NAME#/client/modules/client_portal/" class="btn  btn-warning btn-lg " role="button" >Back to Login Page</a>
                                                    </cfoutput>
													--->
                                           </div><!---/ form left--->
                                            <div class="col-sm-5 text-center"><!---form right--->
                                            	<img src="shake-new-mail.gif" />
                                        		
                                                <h4>You've got mail!</h4>
                                            </div><!--- / form right--->
                                        </div> <!--- /form bottom--->                     		
		                    </div><!--- /wrapper Bottom--->
		                    
                        </div>
                    </div><!--- /row --->
                </div><!--- / container for registration form --->
                
                <cfinclude template="../footer.cfm">
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
