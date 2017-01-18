<!---
	Cold Fusion Template: 
	Author:			Omari K Bogle 
	Date:			29-09-2015
	Modified:		Alyssa Morgan
					changng for use in angularja service

	Description:	Function which checks if the user credentials are correct 
	
	Parameters:		policy_number or email_address, password
	
// --->

<cfcomponent>
    <cffunction access="remote" name="verifyCredentials" output="false" returntype="xml">
        <cfargument name="user_name" required="yes" default="33" />
        <cfargument name="user_password" required="yes" default="33"/>
        
        <!--- Set default values --->
        <cfset Form.logInEmail = user_name>
        <cfset Form.logInPassword = user_password>  
        <cfset bla = "a">      
        <cfset blabla = #Hash(bla,"MD5")#>
        
        <!--- Include login check script --->
        <cfinclude template="process_login.cfm">
        
        <!--- Check if authentication passed --->
        <cfif qVerify.RecordCount gt 0 and qVerify.account_locked is "False" and qVerify.disable_account is "False">
        	<cfset error_message = "">
        <cfelseif qVerify.RecordCount gt 0 and (qVerify.account_locked is "True" or qVerify.disable_account is "True") and qVerify.reset_flag is 'True'>
        	<cfset error_message = "Please note that your account has been disabled. In order to reactivate your account, please reset your password."> 
        <cfelseif qVerify.RecordCount gt 0 and (qVerify.account_locked is "True" or qVerify.disable_account is "True") and qVerify.reset_flag is 'False'>
        	<!--- <cfset error_message = "Please note that your account is not active. If you have not completed the registration process, please check your email and click the link provided."> --->
            <cfset error_message = "Registration is almost complete. Please check your email and click on the link provided to activate your account.">        
        <cfelseif lockCheck.RecordCount gt 0 and lockCheck.account_locked is "True" and counter gte 5>
        	<cfset error_message = "Please note that your account has been disabled due to too many incorrect attempts. In order to reactivate your account, please reset your password.">     
        <cfelse>
        	<cfif lockCheck.recordcount gt 0 and counter gte 3>
        		<!--- <cfset error_message = "Sorry, the email address/policy number and password entered is invalid! After " & countdown & " more attempt(s), your account will be disabled."> --->
                <cfset error_message = "The login information you entered does not match our records. Please try again. After " & countdown & " more attempt(s), your account will be disabled.">
            <cfelse>
            	<!--- <cfset error_message = "Sorry, the email address/policy number and password entered is invalid!"> --->
                <cfset error_message = "The login information you entered does not match our records. Please try again.">
            </cfif>    
        </cfif>
        
        <cfxml variable="XMLEval">
        <login>
        	<login_check>
            <cfoutput>
            	<cfif error_message is not ''>
                    <data>#error_message#</data>
                <cfelse>
                	<userVerified>true</userVerified>
                	<data>#session.client_number#</data>   
                </cfif>    
            </cfoutput>    
            </login_check>    
        </login>
        </cfxml>
        <cfset XMLString = toString(XMLEval)>
        
        <cfreturn XMLEval>
    </cffunction>
</cfcomponent>        