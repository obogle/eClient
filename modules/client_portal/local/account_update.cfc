<!---
	Cold Fusion Template: 
	Author:			Omari K Bogle 
	Date:			09-10-2015
	Modified:		

	Description:	Function which checks if the answer provided is correct 
	
	Parameters:		client_number, field, value
	
// --->

<cfcomponent>
    <cffunction access="remote" name="updateAccount" output="false" returntype="xml">
        <cfargument name="client_number" required="yes" default="33" />
        <cfargument name="field_name" required="yes" default="33" />
        <cfargument name="value" required="yes" default="33" />
        <cfargument name="tag" required="yes" default="33" />
        
        <!--- Search for client user_id --->
        <cfquery name="userSearch" datasource="ICWI_MySql_Client_DSN">  
            SELECT user_id
            FROM icwi_client_users u
            WHERE client_number = '#client_number#'  
            GROUP BY client_number  
        </cfquery>
        
        <!--- Checks if client account contains information --->
        <cfquery name="userAccount" datasource="ICWI_MySql_Client_DSN">  
            SELECT a.user_id
            FROM icwi_client_users u
            INNER JOIN icwi_client_account a ON u.user_id = a.user_id
            WHERE client_number = '#client_number#'  
            GROUP BY client_number  
        </cfquery>
        
        <!--- Set Values --->
        <cfset request.datetime = DateFormat(Now(),"yyyy-mm-dd") & ' ' & TimeFormat(Now(),"HH:mm:ss")>
        <cfset request.user = 'user'>
        
        <!--- Check if data in field is different from what currently exisits --->
        <cfif userAccount.recordcount gt 0>         
        	<cfquery name="updateAccount" datasource="ICWI_MySql_Client_DSN" result="updatedata"> 			
				UPDATE icwi_client_account SET 
                <cfif field_name is 'mailing_addr' and value is not ''>
                mailing_addr
                <cfelseif field_name is 'other_addr' and value is not ''>
                other_addr
				<cfelseif field_name is 'phone_no' and value is not ''>
                phone_no
				<cfelseif field_name is 'email' and value is not ''>
                email
                </cfif> = '#value#',     
                modified_on = '#request.datetime#',
                modified_by = '#request.user#'
                WHERE user_id =  #userSearch.user_id#
        	</cfquery>
            <cfif updatedata.recordcount gt 0>
            	<cfif tag is not ''>
            		<cfset message = "Your request to change " & tag & " to '" & value & "' has been submitted.">
                 <cfelse>
                 	<cfset message = "Your request to add '" & value & "' has been submitted.">
                 </cfif> 
                <cfset status = "Success">
            <cfelse>
            	<cfset message = "Update failed! Please try again later">
                <cfset status = "Danger">
            </cfif>
			<!------>
        <cfelse>        
        	<cfquery name="insertAccount" datasource="ICWI_MySql_Client_DSN" result="insertdata"> 			
				INSERT INTO icwi_client_account 
                (
                    user_id, mailing_addr, other_addr, phone_no, email, created_on, 
                    created_by, modified_on, modified_by
                )
                VALUES
                (
                	#userSearch.user_id#,
                    <cfif field_name is 'mailing_addr' and value is not ''>
                    	'#value#',
                    <cfelse>
                    	NULL,    
                    </cfif>
                    <cfif field_name is 'other_addr' and value is not ''>
                    	'#value#',
                    <cfelse>
                    	NULL,    
                    </cfif>
                    <cfif field_name is 'phone_no' and value is not ''>
                    	'#value#',
                    <cfelse>
                    	NULL,    
                    </cfif>
                    <cfif field_name is 'email' and value is not ''>
                    	'#value#',
                    <cfelse>
                    	NULL,    
                    </cfif>
                    '#request.datetime#',
                    '#request.user#',
                    '#request.datetime#',
                    '#request.user#'                    
                ) 
        	</cfquery>            
            <cfif insertdata.recordcount gt 0>
            	<cfif tag is not ''>
            		<cfset message = "Your request to change " & tag & " to '" & value & "' has been submitted.">
                 <cfelse>
                 	<cfset message = "Your request to add '" & value & "' has been submitted.">
                 </cfif>   
                <cfset status = "Success">
            <cfelse>
            	<cfset message = "Update failed! Please try again later">
                <cfset status = "Danger">
            </cfif>
			<!------>
        </cfif>        
        
        <cfxml variable="XMLEval">
        <update>
        	<update_details>
            <cfoutput>
            	<update_message>#message#</update_message>
                <update_status>#status#</update_status>
                <test>#userAccount.recordcount#</test>
            </cfoutput>    
            </update_details>    
        </update>
        </cfxml>
        <cfset XMLString = toString(XMLEval)>
        
        <cfreturn XMLEval>
    </cffunction>
</cfcomponent>        