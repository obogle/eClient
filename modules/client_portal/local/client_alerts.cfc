<!---
	Cold Fusion Template: 
	Author:			Omari K Bogle 
	Date:			17-02-2016
	Modified:		

	Description:	Function to display all client alerts 
	
	Parameters:		client_number
	
// --->

<cfcomponent>
    <cffunction access="remote" name="clientAlert" output="false" returnformat="json">
        <cfargument name="client_number" required="yes" default="33" /> 
        
        <!--- Default values --->
        <cfset message = ''>
        <cfset alert_details = [] />
        
        <!--- Query database for client change requests --->
        <cfquery name="clientChanges" datasource="ICWI_MySql_Client_DSN">  
            SELECT mailing_addr, other_addr, phone_no, email, a.created_on, a.change_status
            FROM icwi_client_account a
            INNER JOIN icwi_client_users u ON a.user_id = u.user_id
            WHERE change_status != 'Completed'
            AND client_number = '#client_number#'
        </cfquery>
        
        <!--- Check eBroker for renewal notice --->
        <cfset webservice = "https://ebrokertest.icwi.local/rest/services/checkRnwl/" & #client_number#>
        <cfhttp url="#webservice#" method="get" result="result" throwonerror="yes" resolveurl="yes">
        	<cfhttpparam type="header" name="accept" value="application/xml">
        </cfhttp><!---     --->
        <cfset getRnwl = XMLParse(result.filecontent)>        
        <cfset rnwlXML = {}>
        <cfset rnwlNode = xmlSearch(getRnwl,'/rnwl_info/rnwl_details/')> 
        <cfloop from="1" to="#ArrayLen(rnwlNode)#" index="i"> 
			<cfset rnwlXML.message = getRnwl.rnwl_info.rnwl_details[i].rnwl_descr.XmlText>
        	<cfset rnwl_obj = 
                {	
                    tag: 'Renewal Notice',
					data: #rnwlXML.message#
                }
            />
            <cfset arrayAppend(alert_details, rnwl_obj) /> 
        </cfloop>
        
        <!--- JSON --->
        <cfoutput query="clientChanges">
        	<cfset message = 'Your request to change your '>
            <cfif mailing_addr is not '' and phone_no is '' and email is '' and other_addr is ''><!--- mailing --->
            	<cfset message = message & 'mailing address to ' & mailing_addr & " is " & change_status & '.'>
            <cfelseif mailing_addr is not '' and phone_no is not '' and email is '' and other_addr is ''>     
            	<cfset message = message & 'mailing address and contact number is ' & change_status & '.'>
            <cfelseif mailing_addr is not '' and phone_no is not '' and email is not '' and other_addr is ''>     
            	<cfset message = message & 'mailing address, contact number and email address is ' & change_status & '.'> 
            <cfelseif mailing_addr is not '' and phone_no is '' and email is not '' and other_addr is ''>     
            	<cfset message = message & 'mailing address, and email address is ' & change_status & '.'>  
            <cfelseif mailing_addr is not '' and phone_no is not '' and email is not '' and other_addr is not ''>     
            	<cfset message = message & 'mailing address, home address, contact number and email address is ' & change_status & '.'> 
            <cfelseif mailing_addr is not '' and phone_no is '' and email is '' and other_addr is not ''>     
            	<cfset message = message & 'mailing address and home address is ' & change_status & '.'>   
            <cfelseif mailing_addr is not '' and phone_no is not '' and email is '' and other_addr is not ''>     
            	<cfset message = message & 'mailing address, home address and contact number is ' & change_status & '.'>
            <cfelseif mailing_addr is not '' and phone_no is '' and email is not '' and other_addr is not ''>     
            	<cfset message = message & 'mailing address, home address and email address is ' & change_status & '.'>                
            <cfelseif mailing_addr is '' and phone_no is not '' and email is '' and other_addr is ''><!--- phone --->
            	<cfset message = message & 'contact number to ' & phone_no & " is " & change_status & '.'>
            <cfelseif mailing_addr is '' and phone_no is not '' and email is not '' and other_addr is ''>     
            	<cfset message = message & 'contact number and email address is ' & change_status & '.'>  
            <cfelseif mailing_addr is '' and phone_no is not '' and email is not '' and other_addr is not ''>     
            	<cfset message = message & 'contact number, email address and home address is ' & change_status & '.'> 
            <cfelseif mailing_addr is '' and phone_no is not '' and email is '' and other_addr is not ''>     
            	<cfset message = message & 'contact number and home address is ' & change_status & '.'>        
            <cfelseif mailing_addr is '' and phone_no is '' and email is not '' and other_addr is ''><!--- email --->
            	<cfset message = message & 'email address to ' & email & " is " & change_status & '.'> 
            <cfelseif mailing_addr is '' and phone_no is '' and email is not '' and other_addr is not ''>
            	<cfset message = message & 'email address and home address is ' & change_status & '.'>  
            <cfelseif mailing_addr is '' and phone_no is '' and email is '' and other_addr is not ''><!--- other --->
            	<cfset message = message & 'home address to ' & email & " is " & change_status & '.'>        
            </cfif>
            
			<cfset change_obj = 
                {	
                    tag: 'Change Request',
					data: #message#
                }
            />
            <cfset arrayAppend(alert_details, change_obj) /> 
        </cfoutput>
        
        <cfset json = serializeJSON(alert_details) />
    
        <cfreturn json />
    </cffunction>
</cfcomponent>        