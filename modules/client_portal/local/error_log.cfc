<!---
	Cold Fusion Template: 
	Author:			Omari K Bogle 
	Date:			15-03-2016
	Modified:		

	Description:	Script to fetch branch pickup days and time 
	
	Parameters:		branch_id, date_time
	 
// --->

<cfcomponent>
    <cffunction access="remote" name="errorLog" output="false" returnformat="plain">
    	<cfargument name="function_name" required="yes" default="save_transaction" />
        <cfargument name="function_string" required="yes" default="33" />
        <cfargument name="client_number" required="yes" default="33" />
        
        <!--- Defind values --->
        <cfset request.datetime = DateFormat(Now(),"yyyy-mm-dd") & ' ' & TimeFormat(Now(),"HH:mm:ss")>
        <cfset request.string = Replace(function_string,"|icwi|","&","ALL")>
        
        <!--- Store access attempt in log --->
        <cfquery name="saveAccessAttempt" datasource="ICWI_MySql_Client_DSN">
            INSERT INTO icwi_error_log 
            (
                func_serv_name, func_serv_call, created_dt, client_number
            )
            VALUES 
            (
                "#function_name#", "#request.string#", "#request.datetime#", "#client_number#"
            ) 
        </cfquery>
        
        <!--- Store access attempt in log --->
        <cfquery name="errorRefNumber" datasource="ICWI_MySql_Client_DSN">
           SELECT MAX(log_id) as error_code
           FROM icwi_error_log 
           WHERE client_number = "#client_number#" 
        </cfquery>
        
        <cfoutput>
            <cfmail to="appdev@icwi.com" 
                    from="ICWI Click and Go <do-not-reply@icwi.com>" 
                    server="smtp.gmail.com" 
                    subject="Click and Go Error Log"
                    username="do-not-reply@icwi.com"
                    password="Blank123"
                    port="465"
                    useSSL ="yes"
                    type="html">
            A "#function_name#" error has been recorded - Error code: #errorRefNumber.error_code#. 
            <br/>
            Please check the error log table for further details        
            </cfmail>
        </cfoutput>       
        
        <cfxml variable="XMLEval">
            <error>
                <error_detail>
                <cfoutput query="errorRefNumber">
                    <error_code>#error_code#</error_code>
                </cfoutput>    
                </error_detail>
            </error>
        </cfxml>
        <cfset XMLString = toString(XMLEval)>
        
        <cfreturn XMLEval>
    </cffunction>
</cfcomponent>           