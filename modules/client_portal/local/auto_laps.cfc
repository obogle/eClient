<!---
	Cold Fusion Template: 
	Author:			Omari K Bogle 
	Date:			28-07-2016
	Modified:		

	Description:	Script to automatically laps transactions that appointment date have passed 
	
	Parameters:		
	
// --->

<cfcomponent>
    <cffunction access="remote" name="autoLaps" output="false" returntype="xml">
    
    <!--- Current date and time --->
    <cfset request.datetime = DateFormat(Now(),"yyyy-mm-dd") & ' ' & TimeFormat(Now(),"HH:mm:ss")>
    <cfset request.date = DateFormat(Now(),"yyyy-mm-dd")>
    <cfset status = 'false'>
    <cfset request.user_id = 290>

    
    <!--- Fetch transactions to be assessed for auto lapsing --->
    <cfquery name="transToLaps" datasource="ICWI_MySql_Client_DSN"> 
        SELECT trans_id, trans_dt, renewal_dt, apt_dt, pymt_code, policy_number, trans_type
        FROM icwi_tansactions t
        INNER JOIN icwi_payment_options p ON t.pymt_id = p.pymt_id
        WHERE completed_on IS NULL <!--- Active transaction --->
        AND (p.pymt_code = 'IB'  
        OR p.pymt_code = 'PP' AND t.trans_status = 'PP' <!--- In branch and over the phone transaction still in payment pending --->
        OR p.pymt_code = 'OP' AND t.trans_status = 'PF') <!--- Online transaction which payment failed --->
        AND renewal_dt IS NOT NULL
        AND cancelled_yn = 'N'
        <!--- AND trans_id = 185  --->
    </cfquery>
    
	<cfoutput query="transToLaps">	
    	<!--- Get policy renewal date --->
        <!---
		<cfset webservice = "https://ebroker.icwi.com/rest/services/getPolicy/" & #policy_number#>
        <cfhttp url="#webservice#" method="get" result="result" throwonerror="yes" resolveurl="yes">
            <cfhttpparam type="header" name="accept" value="application/xml">
        </cfhttp>
        <cfset getPolicy = XMLParse(result.filecontent)>        
        <cfset policyXML = {}>
        <cfset policyXML.rnwl_dt = getPolicy.client_info.policy_details.expiry_dt_time.XmlText> 
        --->
        
        <cfset daysLapsedIB = DateDiff('d', request.date, apt_dt)> <!--- Number of days between current date and appointment date --->
        <cfset daysLapsedPP = DateDiff('d', renewal_dt, apt_dt)> <!--- Number of days between renewal date and appointment date --->
        <cfset daysLapsedPlcy = DateDiff('d', renewal_dt, trans_dt)>  <!--- Number of days between renewal date and transaction date --->
        <cfset daysLapsedTrans = DateDiff('d', trans_dt, apt_dt )>  <!--- Number of days between transaction date and appointment date --->
        <cfset daysLapsed = DateDiff('d', DateFormat(apt_dt,"yyyy-mm-dd"), DateFormat(request.date,"yyyy-mm-dd"))>
        
		<!--- Determine if the transaction should be lapsed/cancelled --->
        <!--- 
		<cfif daysLapsed gt 0>
        	<cfset status = 'true'>
        </cfif>
		--->
         
        <cfif pymt_code is 'IB' and daysLapsedIB gt 0> <!--- Lapse policy if appointment date has past for In Branch--->
        	<cfset status = 'true'>
        <cfelseif pymt_code is 'PP' and (daysLapsedPlcy lte 0 and daysLapsedPP gt 0)> <!--- Lapse policy if renewal was on time but appointment date was beyond renewal date for Pay over the Phone --->
        	<cfset status = 'true'>
        <cfelseif pymt_code is 'PP' and (daysLapsedPlcy gt 0 and daysLapsedTrans gt 5 and trans_type is 'RN')> <!--- Lapse policy if renewal was late and appointment date was 60 beyond appointment date for Pay over the Phone renewal --->
        <cfelseif pymt_code is 'PP' and (daysLapsedPlcy gt 0 and daysLapsedTrans gt 5 and trans_type is 'EA')> <!--- Lapse policy if renewal was late and appointment date was 10 beyond appointment date for Pay over the Phone extension --->
        	<cfset status = 'true'>
        <cfelseif pymt_code is 'OP'> <!--- Lapse policy if renewal was Pay online and payment failed --->
        	<cfset status = 'true'>    
        </cfif>
        	
            
		<!--- Cancel policies --->
		<cfif status is 'true'>
			<cfset status_code = "CN">
            <!---
            <cfset webservice = "https://clickandgo.icwi.com/rest/services/updateStatus/" & #trans_id# & "/" & #status_code# & "/" & #request.user_id#>
            <cfhttp url="#webservice#" method="get" result="result" throwonerror="yes" resolveurl="yes">
                <cfhttpparam type="header" name="accept" value="application/xml">
            </cfhttp>
            <cfset updateStatus = XMLParse(result.filecontent)>        
            <cfset updateXML = {}>
            --->
            <!--- Update status --->
            <cfquery name="updateTrans" datasource="ICWI_MySql_Client_DSN" result="update"> 
                UPDATE icwi_tansactions SET 
                    cancelled_yn = 'Y'
                WHERE trans_id = #trans_id#
            </cfquery>
            
            <!--- Fetch policies that effective date has passed --->
            <cfquery name="lapsLog" datasource="ICWI_MySql_Client_DSN" result="insert"> 
                INSERT INTO  icwi_lapsed_log  
                (
                    trans_id, effective_date, lapsed_date
                )
                VALUES 
                ( 
                    #trans_id#, '#renewal_dt#', '#request.datetime#'
                )
            </cfquery>
            <cfset insert.recordcount = 0>
     	<cfelse>
        	<cfset insert.recordcount = 0>
        </cfif>
     </cfoutput>
         
        <cfxml variable="XMLEval">
        <lapse>
        	<script_details>
            <cfoutput>
            	<cfif transToLaps.recordcount gt 0>
					<status>Successfully lapsed #insert.recordcount# transactions of #transToLaps.recordcount# found.</status>
					<test>pymt_code: #transToLaps.pymt_code#; daysLapsedIB: #daysLapsedIB#; daysLapsedPP: #daysLapsedPP#; daysLapsedPlcy: #daysLapsedPlcy#; daysLapsedTrans: #daysLapsedTrans#; renewal_dt: #transToLaps.renewal_dt#</test>
				</cfif>
            </cfoutput>    
            </script_details>    
        </lapse>
        </cfxml>
        <cfset XMLString = toString(XMLEval)>
        
        <cfreturn XMLEval>
    </cffunction>
</cfcomponent>   