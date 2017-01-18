<!---
	Cold Fusion Template: 
	Author:			Omari K Bogle 
	Date:			25-09-2015
	Modified:		

	Description:	Function which checks if the answer provided is correct 
	
	Parameters:		email_address
	
// --->

<cfcomponent>
    <cffunction access="remote" name="checkEmail" output="false" returntype="xml">
        <cfargument name="email_address" required="yes" default="33" />
        
        <!--- Query database for client's policy level 1 authentication --->
        <cfquery name="checkEmail" datasource="ICWI_MySql_Client_DSN">  
            SELECT email_address
            FROM icwi_client_users
            WHERE email_address = '#email_address#'    
        </cfquery>
        
        <!--- Check if authentication passed --->
        <cfif checkEmail.recordcount gt 0>
        	<!--- <cfset message = 'This email address is already registered under another account. Please try registering with another email address.'> --->
            <cfset message = 'Sorry, this email address is already in use on another account. Please try again.'>
        <cfelse>
        	<cfset message = ''>
        </cfif>
        
        <cfxml variable="XMLEval">
        <email>
        	<email_check>
            <cfoutput>
            	<email_message>#message#</email_message>
            </cfoutput>    
            </email_check>    
        </email>
        </cfxml>
        <cfset XMLString = toString(XMLEval)>
        
        <cfreturn XMLEval>
    </cffunction>
</cfcomponent>        