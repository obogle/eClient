<!---
	Cold Fusion Template: 
	Author:			Omari K Bogle 
	Date:			02-12-2015
	Modified:		

	Description:	Script to fetch payment options 
	
	Parameters:		
	
// --->

<cfcomponent>
    <cffunction access="remote" name="fetchPaymentOptions" output="false" returnformat="json">
    	<cfargument name="territory_id" required="yes" default="33" />
        
        <!--- Fetch client account --->
        <cfquery name="fetchPaymentOptions" datasource="ICWI_MySql_Client_DSN"> 
            SELECT pymt_id, pymt_code, pymt_name, pymt_desc, selected, disclaimer
            FROM icwi_payment_options
            WHERE active_yn = 'Y'
            AND country_id = #territory_id#
        </cfquery>
        
        <!--- JSON --->
        <cfset payment_details = [] />
        <cfset default = "">
        
        <cfoutput query="fetchPaymentOptions">        
			<!--- set default --->
            <cfif fetchPaymentOptions.selected is 'Y'>
                <cfset default = #fetchPaymentOptions.pymt_id#>
            </cfif>
        </cfoutput>    
        
        <cfoutput query="fetchPaymentOptions">
        	<!--- create icons --->
            <cfif pymt_code is 'OP'>
        		<cfset icon = "fa fa-credit-card">
            <cfelseif pymt_code is 'IB'>   
            	<cfset icon = "fa fa-building"> 
            <cfelseif pymt_code is 'PP'> 
             	<cfset icon = "fa fa-phone">   
            <cfelse>
            	<cfset icon = "">
            </cfif> 
            
                
        	<cfset obj = 
					{	
						id: #pymt_id#,
						code: #pymt_code#,
						icon: #icon#,
						default: #default#,
						name: 'pymt_id', 
						heading: #pymt_name#,
						details: #pymt_desc#,
						disclaimer: #disclaimer#
					}
				/>
        	<cfset arrayAppend(payment_details, obj) />
        </cfoutput>  
        
        <cfset json = serializeJSON(payment_details) />
        <cfreturn json />
    </cffunction>
</cfcomponent>   