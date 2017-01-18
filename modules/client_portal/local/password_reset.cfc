<!---
	Cold Fusion Template: 
	Author:			Omari K Bogle
	Date:			03-10-2015
	Modified:		Alyssa Morgan

	Description:	Function to email client for password reset 
	
	Parameters:		user_name
	
// --->

<cfcomponent>
    <cffunction access="remote" name="resetPasswordLvII" output="false" returntype="xml">
        <cfargument name="user_name" required="yes" default="33" />
        <cfargument name="answer" required="yes" default="33" />
        
        <cfset message = "There was an issue resetting your password. Please contact our customer care center at 1-(888)-920-ICWI for assistance.">  
        <cfset formated_answer = "">
        <cfset formated_security_answer = "">
        
        <!--- Include Random generated code --->
		<cfinclude template="../../eclient_registration/ran_script.cfm">  
        
        <cfset tmp_password = strPassword>
        <!--- <cfset encrypted_password = HASH(tmp_password,"MD5")> --->
        <cfset encrypted_password = HASH(tmp_password,"SHA-512")> 
        
        <!--- Query database for client's email address --->
        <cfquery name="checkForClient" datasource="ICWI_MySql_Client_DSN">  
            SELECT email_address, policy_number, user_id, security_answer
            FROM icwi_client_users  
            WHERE disable_account = 'False' 
            AND (email_address = '#user_name#' or policy_number = '#user_name#')    
        </cfquery>
        
        <!--- Check if authentication passed --->
        <cfif checkForClient.recordcount gt 0>
        	<cfset formated_answer = LCase(answer)>
        	<cfset formated_security_answer = LCase(checkForClient.security_answer)> 
        	<cfif formated_security_answer is formated_answer>
				<!--- Query database for client's email address --->
                <cfquery name="resetPassword" datasource="ICWI_MySql_Client_DSN" result="updatePassword">  
                    UPDATE icwi_client_users
                    SET reset_flag = 'True',
                    user_password = '#encrypted_password#',
                    tmp_key = '#tmp_password#',
                    account_locked = 'False',
                    lock_counter = 0
                    <!--- WHERE (email_address = '#user_name#' or policy_number = '#user_name#') --->
                    <cfif IsNumeric(user_name)>
                        WHERE policy_number = '#user_name#'
                    <cfelse>
                        WHERE email_address = '#user_name#'
                    </cfif>
                    AND disable_account = 'False'  
                </cfquery>
            <cfelse>
            	<cfset status = 'true'>
            	<cfset message = "The security answer you entered is incorrect. Please contact our customer care center at 1-(888)-920-ICWI for assistance."> 	
                <cfset updatePassword.recordcount = 0>
            </cfif>
            
            <cfif updatePassword.recordcount gt 0>
            	<cfoutput query="checkForClient">
                    <cfmail to="#checkForClient.email_address#" 
                            from="ICWI Click and Go <do-not-reply@icwi.com>" 
                            server="smtp.gmail.com" 
                            subject="ICWI Click & Go Password Reset"
                            username="do-not-reply@icwi.com"
                            password="Blank123"
                            port="465"
                            useSSL ="yes"
                            type="html">
                    Your password for your ICWI Click & Go account <!--- for policy number <strong>#checkForClient.policy_number#</strong> --->has been reset.
                    Please click the link below to complete the password reset process:
                    <br/>
                    <a href="http://#CGI.SERVER_NAME#/client/modules/client_portal/##/passwordReset/#tmp_password#" target="_blank"><strong>Password Reset</strong></a>        
                    </cfmail>
                </cfoutput>
                <cfset status = 'true'>
        		<cfset message = 'Your password has been reset! Please check ' & #checkForClient.email_address# & ' to complete the password reset process.'>
            </cfif>    
        </cfif>
        
        <cfxml variable="XMLEval">
        <password>
        	<password_info>
            <cfoutput>
            	<reset_successful>#status#</reset_successful>
                <password_message>#message#</password_message>
            </cfoutput>    
            </password_info>    
        </password>
        </cfxml>
        <cfset XMLString = toString(XMLEval)>
        
        <cfreturn XMLEval>
    </cffunction>
</cfcomponent>        