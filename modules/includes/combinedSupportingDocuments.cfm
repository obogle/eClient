<!---
	Cold Fusion Template: 
	Author:			Omari K Bogle & Alyssa Morgan
	Date:			05-06-2015
	Modified:	

	Description:	This CF Template combineds all supporting documents to be printed
	
	Parameters:		issuedId
	
// --->


<cfoutput>
	<!--- Build combined document file names
	<cfset request.pdfFileName =  'RENEWAL_DOC_' & DateFormat(NOW(),'yyyymmdd') & Arguments.policy & '.pdf'>
	--->
    <cfset request.pdfFileName =  'RENEWAL_DOC_' & renewal_month_year & Arguments.policy_number & '.pdf'>
    
    <cfset combinedPdfPath = "/home/CFApplications/Broker/PDFs/Combined/">
            
	<!--- poca compliance form --->
    <cfset poca_form = '/home/CFApplications/Broker/PDFs/POCA/' & 'POCA_' & DateFormat(request.Today,'yyyy') & Arguments.policy_number & '.pdf'>
    <cfset poca_form_p2 = '/home/CFApplications/Broker/PDFs/POCA/' & 'POCA_' & DateFormat(request.Today,'yyyy') & Arguments.policy_number & 'page2.pdf'>
    
	<!--- payment plan agreement --->
    <cfset payment_plan_agreement = '/home/CFApplications/Broker/PDFs/PaymentPlan/' & 'PP_' & Arguments.policy_number & DateFormat(request.Today,'yyyymmdd') & TimeFormat(request.Today,'HHmmss') & '.pdf'>
    
    <!--- payment plan schedule --->
    <cfset payment_plan_schedule = '/home/CFApplications/Broker/PDFs/PaymentPlan/' & 'PPS_' & Arguments.policy_number & DateFormat(request.Today,'yyyymmdd') & TimeFormat(request.Today,'HHmmss') & '.pdf'>
    
    <!--- private car warranty --->
    <!---
    <cfset private_car_warranty = '/home/CFApplications/Broker/PDFs/PvtCarWarranty/' & 'PCW_' & DateFormat(request.Today,'yyyymmdd') & Arguments.policy_number & '.pdf'>
    <cfset business_use_warranty = '/home/CFApplications/Broker/PDFs/PvtCarWarranty/' & 'BUW_' & DateFormat(request.Today,'yyyymmdd') & Arguments.policy_number & '.pdf'>
    --->
    <!--- no loss declaration --->
    <cfset no_loss_declaration = '/home/CFApplications/Broker/PDFs/NoLoss/' & 'noLoss_' & DateFormat(request.Today,'yyyymmdd') & Arguments.policy_number & '.pdf'>
    
    <!--- total loss --->
    <cfset total_loss = '/home/CFApplications/Broker/PDFs/TotalLoss/' & 'TLOSS_' & DateFormat(request.Today,'yyyymmdd') & Arguments.policy_number & '.pdf'>
    
    <!--- renewal questionaire--->
    <cfset renewal_questionaire = '/home/CFApplications/Broker/PDFs/AccountUpdate/' & 'RenewalQuestionnaire_' & DateFormat(request.Today,'yyyy') & Arguments.policy_number & '.pdf'>
    
    <!--- Create list of documents to check if they exist --->
    <!---
    <cfset document_list = poca_form & "," & poca_form_p2 & "," & payment_plan_agreement & "," & payment_plan_schedule & "," & private_car_warranty & "," & no_loss_declaration & "," & business_use_warranty & "," & total_loss & "," & renewal_questionaire>
	--->
    <cfset document_list = poca_form & "," & poca_form_p2 & "," & payment_plan_agreement & "," & payment_plan_schedule & "," & no_loss_declaration & "," & total_loss & "," & renewal_questionaire>
    <cfset list_len = ListLen(document_list, ",")>
    
    <!--- Combine PDFs ---> 
    <cfset counter = 0>
    <cfloop index="d" from="1" to="#list_len#">
		<!--- Check if documents exisit --->
        <cfset doc = ListGetAt(document_list,d)>
		<cfif FileExists(doc)>
            <cfset counter = counter + 1>
        </cfif>
    </cfloop>
    <cfif counter gt 0>
    <cfpdf action="merge" destination="#Trim(combinedPdfPath)##Trim(request.pdfFileName)#" overwrite="yes">
        <cfloop index="d" from="1" to="#list_len#">     
            <!--- Check if documents exisit --->
            <cfset document = ListGetAt(document_list,d)>
            <cfif FileExists(document)> 
                <cfpdfparam source="#document#">     
            </cfif>
        </cfloop>    
	</cfpdf>
    </cfif>
</cfoutput>    