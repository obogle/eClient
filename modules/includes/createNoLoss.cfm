<!---
	Cold Fusion Template: 
	Author:			Alyssa Morgan
	Date:			June-2015
	Modified:		

	Description:	This CF Template creates no loss form based on supplied information
	
	Parameters:		
		
// --->


<cfset noLossPdfPath = "/home/CFApplications/Broker/PDFs/NoLoss/">
<cfset pdfPath = "/home/CFApplications/kiosk/modules/renewal_module/Forms/">
<cfset getPdfTemplates.noLoss_file_name = "icwi_noLoss.pdf">

<!--- Build individual file names--->
<cfset request.noLosspdfFileName =  'noLoss_' & DateFormat(Now(),'yyyymmdd') & Arguments.policy_number & '.pdf'>
<cfoutput>            
	<!--- build pdf --->
    <cfpdfform action="populate" source="#Trim(pdfPath)##Trim(getPdfTemplates.noLoss_file_name)#" destination="#Trim(noLossPdfPath)##Trim(request.noLosspdfFileName)#"  overwrite="yes" >
        <cfpdfsubform name="plcy_no">
        	<cfpdfformparam name="plcy_no" value="#Arguments.policy_number#">
            <cfpdfformparam name="clientName" value="#getSelectedItemForRenewal.policy_holders_name1# #getSelectedItemForRenewal.policy_holders_name2#">
            <cfpdfformparam name="date" value="#request.date#">
            <cfpdfformparam name="icwi_name" value="#icwi_name#">
            <cfpdfformparam name="icwi_address" value="#icwi_address#">
        </cfpdfsubform>
    </cfpdfform> 
+</cfoutput>  


