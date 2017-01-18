<!---
	Cold Fusion Template: 
	Author:			Omari K. Bogle
	Date:			2015-09-26
	Modified:		Omari K. Bogle - 2015-09-28 -> Add query to verify user account
												-> Set session variable user_id, email, policy
					Omari K. Bogle - 2015-09-28 -> Add disable feature
												-> Add lock counter

	Description:		
	Parameters:		
--->
<!--- <cfinclude template="header.cfm"> --->

<cfset user_name = #Form.logInEmail#>
<!--- <cfset encrypt_password = #Hash(Form.logInPassword,"MD5")#> --->
<cfset encrypt_password = #Hash(Form.logInPassword,"SHA-512")#>
<cfset clientip = CGI.REMOTE_ADDR>
<cfset browserused = CGI.HTTP_USER_AGENT>
<cfset request.datetime = DateFormat(Now(),"yyyy-mm-dd") & ' ' & TimeFormat(Now(),"HH:mm:ss")>
<cfset counter = 0>
<cfset lock = 5>
<cfset countdown = 5>

<!--- Get all records from the database that match this users credentials --->
<cfquery name="qVerify" datasource="ICWI_MySql_Client_DSN">
   	SELECT user_id, policy_number, client_number, email_address, account_locked, disable_account, reset_flag
    FROM icwi_client_users
    WHERE ( policy_number = '#user_name#' OR email_address = '#user_name#')
    AND user_password = '#encrypt_password#'
    AND disable_account = 'False'
</cfquery>

<!--- Check for lock counter --->
<cfquery name="lockCheck" datasource="ICWI_MySql_Client_DSN">
   	SELECT user_id, account_locked, lock_counter
    FROM icwi_client_users
    WHERE ( policy_number = '#user_name#' OR email_address = '#user_name#')
    AND disable_account = 'False'
</cfquery>
   

<cfif qVerify.RecordCount gt 0 and qVerify.account_locked is "False" and qVerify.disable_account is "False">
   <cfoutput>
   		<!--- This user has logged in correctly, change the value of the session.allowin value --->
       <cfset session.allowin = "true">
       <cfset session.user_id = qVerify.user_id>
       <cfset session.client_number = qVerify.client_number>
       <cfset session.policy_number = qVerify.policy_number>
       <cfset session.email_address = qVerify.email_address>
       <cfset session.client_name = ''> 
       <cfset access_status = "Successful"> 
   </cfoutput>
   
    <!--- Store login attempt --->
    <cfquery name="updateUser" datasource="ICWI_MySql_Client_DSN">
        UPDATE icwi_client_users
        SET lock_counter = #counter#,
        modified_on = '#request.datetime#'
        WHERE user_id = '#qVerify.user_id#'  
    </cfquery>
<cfelse>
	<!--- this user did not log in correctly, alert and redirect to the login page --->
    <cfset session.allowin = "false">
    <cfset access_status = "Failed">
    
    <!--- Store login attempt --->
    <cfif lockCheck.recordcount gt 0>
    	<cfset counter = lockCheck.lock_counter + 1>
        
        <cfquery name="updateUser" datasource="ICWI_MySql_Client_DSN">
            UPDATE icwi_client_users
            SET lock_counter = #counter#,
            <cfif counter gte 5>
            	account_locked = 'True',
            </cfif>    
            modified_on = '#request.datetime#'
            WHERE user_id = '#lockCheck.user_id#'  
        </cfquery>
        <cfset countdown = lock - counter>
    </cfif>       
</cfif>

<!--- Store access attempt in log --->
<cfquery name="saveAccessAttempt" datasource="ICWI_MySql_Client_DSN">
    INSERT INTO icwi_access_log 
    (
        user_name, ip_address, browser_used, access_status, access_on
    )
    VALUES 
    (
        '#user_name#', '#clientip#', '#browserused#', '#access_status#', '#request.datetime#'
    ) 
</cfquery>