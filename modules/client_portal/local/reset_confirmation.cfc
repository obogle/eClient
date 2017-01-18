<!---
	Cold Fusion Template: 
	Author:			Omari K Bogle 
	Date:			03-10-2015
	Modified:		

	Description:	Script to activate registration user registration 
	
	Parameters:		user_id
	
// --->

<cfcomponent>
    <cffunction access="remote" name="resetPassword" output="false" returntype="xml">
        <cfargument name="user_name" required="yes" default="33" />
        <cfargument name="user_password" required="yes" default="33" />
        <cfargument name="request_code" required="yes" default="33" />
        
		<!--- Decode URL Values --->
        <cfset userId = URLDecode(user_name,"utf-8")>
        <cfset request = URLDecode(request_code,"utf-8")>
        
        <!--- Fetch client account --->
        <cfquery name="fetchClient" datasource="ICWI_MySql_Client_DSN"> 
            SELECT u.reset_flag
            FROM icwi_client_users u
            WHERE u.user_id = #userId#
        </cfquery>
        
        <!--- Set expiration to 24hrs --->
        <cfif request is 'PwReset'>
            <cfset reset_flag = 'False'>
            <!--- <cfset encrypt_password = #Hash(user_password,"MD5")#> --->
            <cfset encrypt_password = #Hash(user_password,"SHA-512")#>
            
            <!--- Reset password --->
            <cfquery name="resetPassword" datasource="ICWI_MySql_Client_DSN"> 
                UPDATE icwi_client_users
                SET user_password = '#encrypt_password#',
                    reset_flag = "#reset_flag#"
                WHERE user_id = #userId#
            </cfquery>
            
            <cfif resetPassword.numberOfRowsUpdated gt 0>
                <cfset message = 'Your password has been successfully reset. You may now attempt to login with your new password.'>
            <cfelse>    
                <cfset message = 'Your password reset was unsuccesful. Please contact our customer care center at 1-(888)-920-ICWI for assistance.'>
            </cfif>    
        <cfelse>
            <cfset message = 'The password reset token was invalid. Please contact our customer care center at 1-(888)-920-ICWI for assistance.'>
        </cfif>    

        <cfxml variable="XMLEval">
        <password>
        	<password_info>
            <cfoutput>
            	<password_message>#message#</password_message>
            </cfoutput>    
            </password_info>    
        </password>
        </cfxml>
        <cfset XMLString = toString(XMLEval)>
        
        <cfreturn XMLEval>
    </cffunction>
</cfcomponent>   