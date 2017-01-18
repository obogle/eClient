<!---
	Cold Fusion Template: 
	Author:			Alyssa Morgan
	Date:			June-2015
	Modified:		

	Description:	
	
	Parameters:		
		
// --->


<cfset totalLossPdfPath = "/home/CFApplications/Broker/PDFs/TotalLoss/">
<cfset pdfPath = "/home/CFApplications/kiosk/modules/renewal_module/Forms/">
<cfset getPdfTemplates.totalLoss_file_name = "icwi_total_loss.pdf">

<!--- Build individual file names--->
<cfset request.totalLosspdfFileName =  'TLOSS_' & DateFormat(Now(),'yyyymmdd') & Arguments.policy_number & '.pdf'>
<cfoutput>            
	<!--- build pdf --->
    <cfpdfform action="populate" source="#Trim(pdfPath)##Trim(getPdfTemplates.totalLoss_file_name)#" destination="#Trim(totalLossPdfPath)##Trim(request.totalLosspdfFileName)#"  overwrite="yes" >
        <cfpdfsubform name="plcy_no">
        	<cfpdfformparam name="plcy_no" value="#Arguments.policy_number#">
            <cfpdfformparam name="lname" value="#getSelectedItemForRenewal.policy_holders_name1# #getSelectedItemForRenewal.policy_holders_name2#">
            <cfpdfformparam name="date" value="#request.date#">
            <cfpdfformparam name="fname" value="#getSelectedItemForRenewal.vehicle_make_model_type#">
            <cfpdfformparam name="mname" value="#getSelectedItemForRenewal.vehicle_chassis_number#">
            <cfpdfformparam name="risk_id" value="#getSelectedItemForRenewal.vehicle_registration#">
            <cfpdfformparam name="icwi_name" value="#icwi_name#">
            <cfpdfformparam name="icwi_address" value="#icwi_address#">
        </cfpdfsubform>
    </cfpdfform> 
</cfoutput>  


