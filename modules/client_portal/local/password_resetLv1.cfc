<!---
	Cold Fusion Template: 
	Author:			Omari K Bogle 
	Date:			03-10-2015
	Modified:		

	Description:	Function to email client for password reset 
	
	Parameters:		user_name
	
// --->

<cfcomponent>
    <cffunction access="remote" name="resetPasswordLvI" output="false" returntype="xml">
        <cfargument name="user_name" required="yes" default="33" />
        
        <!--- Query database for client's email address --->
        <cfquery name="checkForClient" datasource="ICWI_MySql_Client_DSN">  
            SELECT email_address, policy_number, user_id, s.security_id, s.own_question,
            CASE WHEN s.own_question = 'True' THEN u.own_question
            ELSE security_question END AS security_question
            FROM icwi_client_users u
            INNER JOIN icwi_security_questions s ON u.security_id = s.security_id 
            WHERE ( policy_number = '#user_name#' OR email_address = '#user_name#')
            AND disable_account = 'False'  
        </cfquery>
        
        <!--- Check if authentication passed --->
        <cfif checkForClient.recordcount gt 0>
            	<cfset message = ''>
                <cfset question = checkForClient.security_question>  
                <cfset status = 'true'> 
        <cfelse>
        	<!--- <cfset message = 'The email/policy number provided is not registered. Please contact our customer care center at 1-(888)-920-ICWI for assistance.'> --->
            <cfset message = 'The email address or policy number provided is not registered. Please contact our Customer Care Center at 1-(888)-920-ICWI for assistance.'>
            <cfset question = ''>
            <cfset status = 'false'>
        </cfif>
        
        <cfxml variable="XMLEval">
        <question>
        	<question_info>
            <cfoutput>
            	<message>#message#</message>
                <cfif checkForClient.recordcount gt 0>
                	<quest>#question#</quest>
                    <status>#status#</status>
                </cfif>    
            </cfoutput>    
            </question_info>    
        </question>
        </cfxml>
        <cfset XMLString = toString(XMLEval)>
        
        <cfreturn XMLEval>
    </cffunction>
</cfcomponent>        