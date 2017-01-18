<!---
	Cold Fusion Template: 
	Author:			Omari K Bogle 
	Date:			28-09-2015
	Modified:		

	Description:	Script to activate registration user registration 
	
	Parameters:		user_id
	
// --->

<cfcomponent>
    <cffunction access="remote" name="clientRegistration" output="false" returntype="xml">
        <cfargument name="tmp_code" required="yes" default="33" />
        
        <cfset isExpired = 'false'>
		<cfset active = 'false'> 
        <cfset message = 'There was an issue confirming your registration. Please contact our customer care center at 1-(888)-920-ICWI for assistance.'>
        
        <!--- Fetch client account --->
        <cfquery name="fetchClient" datasource="ICWI_MySql_Client_DSN"> 
            SELECT u.created_on, u.user_id
            FROM icwi_client_users u
            WHERE u.tmp_key = '#tmp_code#'
        </cfquery>
        
        <!--- Set expiration to 24hrs --->
        <cfif fetchClient.recordcount gt 0 and DateDiff("d", fetchClient.created_on, Now()) gt 1>
			<cfset isExpired = 'true'>
            <cfset message = 'Your registration token has expired. Please contact our customer care center at 1-(888)-920-ICWI for assistance.'>
        </cfif> 
        
        <!--- Query to update user account field account_locked --->
        <cfif isExpired is "false" and fetchClient.recordcount gt 0>
        	<cfquery name="registerClient" datasource="ICWI_MySql_Client_DSN" result="updateCount"> 
                UPDATE icwi_client_users
                SET account_locked = 'False',
                tmp_key = NULL
                WHERE user_id = #fetchClient.user_id#
            </cfquery>            
            <cfif updateCount.recordcount gt 0>
            	<cfset message = 'Your account has been successfully created. You may now login.'>
                <cfset active = 'true'>
            </cfif>  
        <cfelse>
        	<cfset updateCount.recordcount = 0>    
        </cfif>   

        <cfxml variable="XMLEval">
        <registration>
        	<registration_info>
            <cfoutput>
            	<registration_message>#message#</registration_message>
                <cfif updateCount.recordcount gt 0><active>#active#</active></cfif>
            </cfoutput>    
            </registration_info>    
        </registration>
        </cfxml>
        <cfset XMLString = toString(XMLEval)>
        
        <cfreturn XMLEval>
    </cffunction>
</cfcomponent>   