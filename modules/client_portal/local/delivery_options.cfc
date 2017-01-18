<!---
	Cold Fusion Template: 
	Author:			Omari K Bogle 
	Date:			02-12-2015
	Modified:		

	Description:	Script to fetch delivery options 
	
	Parameters:		pymt_id
	 
// --->

<cfcomponent>
    <cffunction access="remote" name="fetchDeliveryOptions" output="false" returnformat="json">
    	<cfargument name="pymt_id" required="yes" default="33" />
        
        <!--- Fetch client account --->
        <cfquery name="fetchDeliveryOptions" datasource="ICWI_MySql_Client_DSN"> 
            SELECT dev_id, dev_code, dev_name, dev_descr, selected
            FROM icwi_delivery_options
            WHERE active_yn = 'Y'
            AND pymt_id = #pymt_id#
        </cfquery>
        
        <!--- JSON --->
        <cfset delivery_details = [] />
        <cfset default = "">
        
        <cfoutput query="fetchDeliveryOptions">
			<!--- set default --->
            <cfif fetchDeliveryOptions.selected is 'Y'>
                <cfset default = #fetchDeliveryOptions.dev_code#>
            </cfif>
		</cfoutput>            
        
        <cfoutput query="fetchDeliveryOptions">
            
        	<!--- create icons --->
            <cfif dev_code is 'DL'>
        		<cfset icon = "fa fa-motorcycle">
            <cfelseif dev_code is 'PU'> 
            	<cfset icon = "fa fa-building">   
            <cfelse>
            	<cfset icon = "">
            </cfif>    
        	<cfset obj = 
					{	
						id: #dev_id#,
						code: #dev_code#,
						icon: #icon#,
						default: #default#,
						name: 'dev_id', 
						options: #dev_code#,
						heading: #dev_name#,
						details: #dev_descr#
					}
				/>
        	<cfset arrayAppend(delivery_details, obj) />        
        </cfoutput>
        
        <cfset json = serializeJSON(delivery_details) />
    
        <cfreturn json />
    </cffunction>
</cfcomponent>   