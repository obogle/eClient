<!---
	Cold Fusion Template: 
	Author:			Omari K Bogle 
	Date:			31-05-2016
	Modified:		

	Description:	Web service to get user uploads
	
	Parameters:		policy_number, renewal_period
	
// --->
<cfcomponent>
	<cfset remote.server = 'ebroker.icwi.com'>
	<cffunction access="remote" name="getUserChangeRequests" output="false" returntype="string">
        <cfargument name="branch_id" required="yes" default="ALL" />
        
		<!--- Query database for client change requests --->
        <cfquery name="getUserChangeRequests" datasource="ICWI_MySql_Client_DSN">  
            SELECT u.policy_number, u.client_number, a.account_id, a.mailing_addr, a.other_addr, a.phone_no, a.email, a.created_on, a.modified_on, a.assigned_to
            FROM icwi_client_account a
            INNER JOIN icwi_client_users u ON a.user_id = u.user_id
            WHERE a.change_status = 'Pending'
        </cfquery>
        
        <cfset user_info = [] />
        <cfset obj = []/> 
        <cfset request.assigned_to = ''>
        
        <cfoutput query="getUserChangeRequests">
			<!--- Get client name --->
            <cfset webservice = "https://" & remote.server & "/rest/services/getClient/" & #client_number#>
            <cfhttp url="#webservice#" method="get" result="result" throwonerror="yes" resolveurl="yes">
                <cfhttpparam type="header" name="accept" value="application/xml">
            </cfhttp> 
            <cfset getClient = XMLParse(result.filecontent)>        
            <cfset clntXML = {}>
            <cfset clntXML.name = getClient.client_info.account_details.clnt_name.XmlText>
            
			<!--- Get policy info --->
            <cfset webservice = "https://" & remote.server & "/rest/services/getPolicy/" & #policy_number#>
            <cfhttp url="#webservice#" method="get" result="result" throwonerror="yes" resolveurl="yes">
                <cfhttpparam type="header" name="accept" value="application/xml">
            </cfhttp> 
            <cfset getPolicy = XMLParse(result.filecontent)>        
            <cfset plcyXML = {}>
            <cfset plcyXML.branch = getPolicy.client_info.policy_details.branch_id.XmlText> 
            
            <!--- Get User Information --->
            <cfif assigned_to is not ''>
				<cfset webservice = "https://" & remote.server & "/rest/services/getUser/" & #assigned_to#>
                <cfhttp url="#webservice#" method="get" result="result" throwonerror="yes" resolveurl="yes">
                    <cfhttpparam type="header" name="accept" value="application/xml">
                </cfhttp> 
                <cfset getUsers = XMLParse(result.filecontent)>        
                <cfset userXML = {}>
                <cfset userXML.name = getUsers.user.user_name.XmlText>  
             </cfif>     
            
            <!--- Assignments ---> 
            <cfif assigned_to is not ''>
            	<cfset request.assigned_to = assigned_to>
                <cfset request.assignee = userXML.name>  
            <cfelse>
            	<cfset request.assigned_to = "">
                <cfset request.assignee = "Unassigned">
            </cfif>        
            
            <cfif plcyXML.branch is '#branch_id#'>
				<cfset obj = 
					{	
						changeid: #account_id#,
						plcyno: #policy_number#,
						clntname: #clntXML.name#,
						mailingaddr: #mailing_addr#, 
						homeaddr: #other_addr#, 
						phoneno: #phone_no#,
						emailaddr: #email#,
						branchid: #plcyXML.branch#,
						assignedto: #request.assigned_to#,
						assignee: #request.assignee#
					}		
				/>
				<cfset arrayAppend(user_info, obj) />
        	</cfif>        
        </cfoutput>
        <!--- --->
        <cfif getUserChangeRequests.recordcount eq 0 or ArrayIsEmpty(user_info)>
        	<cfset obj = 
				{	
					message: "There are no changes to make at this time."
				}		
			/>
            <cfset arrayAppend(user_info, obj) />
        </cfif>
        
        <cfset user_info_json = serializeJSON(user_info) />
        
        <cfreturn user_info_json>    
    </cffunction>
</cfcomponent>