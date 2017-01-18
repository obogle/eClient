<!---
	Cold Fusion Template: 
	Author:			Omari K Bogle 
	Date:			25-09-2015
	Modified:		

	Description:	Function which checks if the answer provided is correct 
	
	Parameters:		policy_number, question, answer
	
// --->

<cfcomponent>
    <cffunction access="remote" name="checkEmail" output="false" returntype="xml">
        <cfargument name="email_address" required="yes" default="33933995" />
        
        <!--- Query database for client's policy level 1 authentication --->
        <cfquery name="checkEmail" datasource="ICWI_MySql_Client_DSN">  
            SELECT email_address
            FROM icwi_client_users
            WHERE disable_account = 'False'
            AND email_address = '#email_address#'    
        </cfquery>
        
        <!--- Check if authentication passed --->
        <cfif checkEmail.recordcount gt 0>
        	<cfset message = 'This email address is already registered under another account. Please try registering with another email address.'>
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