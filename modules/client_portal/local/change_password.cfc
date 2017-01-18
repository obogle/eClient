<!---
	Cold Fusion Template: 
	Author:			Omari K Bogle 
	Date:			13-11-2015
	Modified:		

	Description:	Function to email client for password reset 
	
	Parameters:		user_name
	
// --->

<cfcomponent>
    <cffunction access="remote" name="changePassword" output="false" returntype="xml">
        <cfargument name="code" required="yes" default="33" />
        <cfargument name="new_pwd" required="yes" default="33" />
        <cfargument name="con_pwd" required="yes" default="33" />
        
        <cfset status = "false">
        
        <cfif CompareNoCase(new_pwd,con_pwd) eq 0>
			<!--- Query database for client   --->
            <cfquery name="checkForClient" datasource="ICWI_MySql_Client_DSN">  
                SELECT email_address, policy_number, user_id, security_answer
                FROM icwi_client_users  
                WHERE tmp_key = '#code#'
            </cfquery>
            
            <!--- Check if authentication passed --->
			<cfif checkForClient.recordcount gt 0>
            	<!--- <cfset encrypted_password = HASH(new_pwd,"MD5")> --->
                <cfset encrypted_password = HASH(new_pwd,"SHA-512")>
                <!--- Query database for client's email address --->
                <cfquery name="resetPassword" datasource="ICWI_MySql_Client_DSN" result="updatePassword">  
                    UPDATE icwi_client_users
                    SET reset_flag = 'False',
                    user_password = '#encrypted_password#',
                    lock_counter = 0,
                    tmp_key = NULL
                    WHERE user_id = '#checkForClient.user_id#'
                    <!--- AND disable_account = 'False' --->  
                </cfquery>
                <cfif updatePassword.recordcount gt 0>
                	<cfoutput query="checkForClient">
                        <cfmail to="#checkForClient.email_address#" 
                                from="ICWI Click & Go <do-not-reply@icwi.com>" 
                                server="smtp.gmail.com" 
                                subject="ICWI Click & Go Password Reset"
                                username="do-not-reply@icwi.com"
                                password="Blank123"
                                port="465"
                                useSSL ="yes"
                                type="html">
                        Your password for your ICWI's Click & Go account for policy number <strong>#checkForClient.policy_number#</strong> has been changed.        
                        </cfmail>
                    </cfoutput>
					
                    <cfset status = "true">
                	<cfset message = "Your password has been changed!">
                <cfelse>
                	<cfset message = "There was an issue changing your password. Please contact our customer care center at 1-(888)-920-ICWI for assistance.">    
                </cfif>    
            <cfelse>
            	<cfset message = "Your account has already been reset!">
            </cfif>	
        <cfelse>
        	<cfset message = "Password does not match">
        </cfif>
        
        <cfxml variable="XMLEval">
        <password>
        	<password_info>
            <cfoutput>
            	<password_message>#message#</password_message>
                <cfif status is "true"><status>#status#</status></cfif>
            </cfoutput>    
            </password_info>    
        </password>
        </cfxml>
        <cfset XMLString = toString(XMLEval)>
        
        <cfreturn XMLEval>
    </cffunction>
</cfcomponent>        