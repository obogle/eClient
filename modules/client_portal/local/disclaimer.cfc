<!---
	Cold Fusion Template: 
	Author:			Omari K Bogle 
	Date:			02-08-2016
	Modified:		

	Description:	Script to fetch disclaimers for the various territories 
	
	Parameters:		territory_id
	 
// --->

<cfcomponent>
    <cffunction access="remote" name="getDisclaimer" output="false" returnformat="json">
    	<cfargument name="territory_id" required="yes" default="4" />
        
        <!--- Fetch operating --->
        <cfquery name="getDisclaimer" datasource="ICWI_MySql_Client_DSN"> 
            SELECT name, message
            FROM icwi_disclaimer
            WHERE territory_id = #territory_id#
        </cfquery>
        
        <!--- JSON --->
        <cfset disclaimer_details = [] />
        
       	<cfoutput query="getDisclaimer">
        	<cfset obj = 
				{	
					name: #name#,
					message: #message#
				}
			/>      
        	<cfset arrayAppend(disclaimer_details, obj) />        
        </cfoutput>
        
        <cfset json = serializeJSON(disclaimer_details) />
    
        <cfreturn json />
    </cffunction>
</cfcomponent>   