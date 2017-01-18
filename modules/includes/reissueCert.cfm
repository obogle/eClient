<!---
	Cold Fusion Template: 
	Author:			Omari K. Bogle
	Date:			26-06-2015
	Modified:		

	Description:	This CF Template creates cover note based on supplied information
	
	Parameters:		cover_note_type, srcId, date_of_issue, insureds_name, address1, address2,
						policy_number, item_number, effective_from, effective_days, effective_to, make_model_type, year_of_man, 
							hp_cc, seating, estimated_value, reg_number, type_of_policy, class_of_policy, 
								type_of_cover, uses, alterations
	
// --->

<!--- defaults policy query ---> 
<cfquery name="getCertificateCreated" datasource="#datasource#" result="cert_count">
SELECT c.pdf_file_name
FROM icwi_certificates_created c
WHERE c.policy_number = #policy_number#
AND c.renewal_month_year = #checkRenwal.renewal_month_year#
</cfquery>

<!--- Certificate Path --->
<cfset certificatePath = "../../../Broker/PDFs/Certificates/">
<cfset certUrlPath = "http://ebroker.icwi.com/Broker/PDFs/Certificates/">

<!--- Certificate file name --->
<cfset request.pdfFileName =  getCertificateCreated.pdf_file_name>