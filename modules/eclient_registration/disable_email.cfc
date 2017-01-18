<!---
	Cold Fusion Template: 
	Author:			Alyssa Morgan
	Date:			feb 18, 2016
	Modified:		

	Description:	Function which disables email so user can re register for testing
	
	Parameters:		email
	
// --->

<cfcomponent>
    <cffunction access="remote" name="disableEmail" output="false" returntype="xml">
        <cfargument name="email_address" required="yes" default="amorgan.edu@gmail.com" />
        
        <!--- Query database for email--->
        <cfquery name="checkEmail" datasource="ICWI_MySql_Client_DSN">  
            SELECT email_address
            FROM icwi_client_users
            WHERE email_address = '#email_address#'    
        </cfquery>
        
        <!--- Check if authentication passed --->
        <cfif checkEmail.recordcount gt 0>
        	
			<!--- disable email--->
            <cfquery name="checkEmail" datasource="ICWI_MySql_Client_DSN">  
                UPDATE icwi_client_users
				SET disable_account = "True"
                WHERE email_address = '#email_address#'    
            </cfquery>
			
			<cfset message = 'Email has been disabled'>
        <cfelse>
        	<cfset message = 'That email was not registered'>
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