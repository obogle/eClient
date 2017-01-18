<!---
	Cold Fusion Template: 
	Author:			Omari K Bogle 
	Date:			28-09-2015
	Modified:		

	Description:	Script to activate registration user registration 
	
	Parameters:		user_id
	
// --->


<!--- Decode URL Values --->

<cfset userId = URLDecode(URL.userId,"utf-8")>
<cfset activeStatus = URLDecode(URL.activeStatus,"utf-8")>
<!---<cfset userId = HASH(URL.userId,"SHA-512")>
<cfset activeStatus = HASH(URL.activeStatus,"SHA-512")>--->

<!--- Fetch client account --->
<cfquery name="fetchClient" datasource="ICWI_MySql_Client_DSN"> 
	SELECT u.created_on, u.account_locked
    FROM icwi_client_users u
    WHERE u.user_id = #userId#
</cfquery>

<!--- Set expiration to 24hrs --->
<cfif DateDiff("d", fetchClient.created_on, Now()) gt 1 or fetchClient.account_locked is 'False'>
	<cfset isExpired = 'True'>
<cfelse>
	<cfset isExpired = 'False'>
</cfif>    

<!--- Query to update user account field account_locked --->
<cfif isExpired is "False">
    <cfquery name="checkForClient" datasource="ICWI_MySql_Client_DSN"> 
        UPDATE icwi_client_users
        SET account_locked = '#activeStatus#',
        tmp_key = NULL
        WHERE user_id = #userId#
    </cfquery>
</cfif>
<cfoutput> #DateDiff("d", fetchClient.created_on, Now())# </cfoutput>
<!--- Redirect to email page  --->
<cflocation url="http://#CGI.SERVER_NAME#/client/modules/client_portal/">