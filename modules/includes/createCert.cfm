<!---
	Cold Fusion Template: 
	Author:			Omari K Bogle
	Date:			12-02-2015
	Modified:		07-05-2015 - Omari K. Bogle: Modify to accept annual policies

	Description:	This CF Template creates certificate based on supplied information
	
	Parameters:		certificate_cover, certificate_type, certId, policy_number, item_number, scheme_id, 
						vehicle_make_model_type, vehicle_registration, vehicle_chassis_number, vehicle_body_type, 
							policy_holders_name1, policy_holders_name2, reinstated, 
								payment_option, sequence_number, effective_from, effective_to, 
									payment_plan, premium_period, narrative5, narrative6, comments
								vehicle_inspected, inspected_by, no_damage, no_loss_dec_signed
		
// --->


<!--- form values required from Alyssa ---> 
<cfset Form.policy_number = "#Arguments.policy_number#">
<cfset Form.rnwl_mth = "">
<!---<cfset request.date = DateFormat(NOW(),"yyyy-mm-dd")>--->
<cfset request.date = #DateFormat(getDateTime.datetime,"yyyy-mm-dd")#>

<!--- defaults policy query ---> 
<cfquery name="getSelectedItemForRenewal" datasource="#datasourceII#" result="payment_rnwl">
    SELECT '' AS branch_id, '' AS branch_name, pp.src_type, pp.src_id, sn.src_name, pp.next_debit_period AS rnwl_mth, 
    c.clnt_no, c.clnt_type,  pp.clnt_name AS name_mail, c.occupation, ca.addr_no, ca.addr_line_1, ca.addr_line_2, 
    ca.addr_line_3, ca.addr_city, ca.phone_no, pp.plcy_no, GROUP_CONCAT(pp.item_no) AS item_no, GROUP_CONCAT(pi.risk_item_no) AS risk_item_no, pp.scheme_id, GROUP_CONCAT(pp.si_amt) AS si_amt, 
    GROUP_CONCAT(ROUND(pp.amount_due-(fee_amt+gct_amt+pp.pen_amt),2)) AS annual_net_prem, GROUP_CONCAT(fee_amt) AS fee_amt, GROUP_CONCAT(gct_amt) AS gct_amt, GROUP_CONCAT(pp.annual_net_prem) AS premium, GROUP_CONCAT(pen_amt) AS pen_amt, DATE(pp.next_debit_date) AS rnwl_dt_time, pp.exp_debit_date as effective_to, pp.pymt_plan AS prem_period, pp.period_no AS pymt_plan, 
    rn.cert_code, pi.cover, mc.cover_descr, pi.make, pi.model, pi.yr_of_mfe, pi.reg_no, pi.chassis_no, pi.colour, 
    bt.body_descr, pi.cert_id, p.react_yn, pi.si_amt, p.currency_id, sn.country_id, pi.open_or_restr, pi.cc_hp, 
    pi.seating_cap, p.class_id, p.sub_class_id, GROUP_CONCAT(rn.narrative5) AS narrative5, GROUP_CONCAT(rn.narrative6) AS narrative6, rn.cert_effective_dt, rn.cert_epiry_dt, 
    pp.period_descr, pi.usages, cn.policy_number AS cn_plcy_no, cn.item_number AS cn_item_no,
    ct.policy_number AS ct_plcy_no, ct.item_number AS ct_item_no, c.bal_outstanding, c.bal_outstanding, COUNT(*) AS total_risks,
    DATE(NOW())-DATE(pp.next_debit_date) AS days_lapsed, pp.period_descr, 
    GROUP_CONCAT(CONCAT(pi.yr_of_mfe,' ',pi.make,' ',pi.model)) AS vehicle_make_model_type,
    GROUP_CONCAT(pi.reg_no) AS vehicle_registration,
    GROUP_CONCAT(pi.chassis_no) AS vehicle_chassis_number,
    GROUP_CONCAT(bt.body_descr) AS vehicle_body_type
    FROM crm_payment_plans AS pp
    LEFT OUTER JOIN crm_plcy_item AS pi ON pp.plcy_no = pi.plcy_no AND pp.item_no = pi.item_no
    LEFT OUTER JOIN crm_body_types AS bt ON pi.body_type = bt.body_type
    LEFT OUTER JOIN crm_motor_cover AS mc ON pi.cover = mc.cover
    LEFT OUTER JOIN crm_rnwl_narratives AS rn ON pp.plcy_no = rn.plcy_no AND pp.item_no = rn.item_no
    LEFT OUTER JOIN crm_policy AS p ON pp.plcy_no = p.plcy_no
    LEFT OUTER JOIN crm_client_addr AS ca ON p.clnt_no = ca.clnt_no AND p.addr_no = ca.addr_no
    LEFT OUTER JOIN crm_client AS c ON pp.clnt_no = c.clnt_no
    INNER JOIN crm_source_names AS sn ON pp.src_type = sn.src_type AND pp.src_id = sn.src_id
    LEFT JOIN icwi_broker.icwi_cover_notes_issued AS cn ON pp.plcy_no = cn.policy_number AND pp.item_no = cn.item_number AND pp.next_debit_period = CONCAT(LEFT(RIGHT(cn.cr_stamp,14),2),LEFT(RIGHT(cn.cr_stamp,17),2))
    LEFT JOIN icwi_broker.icwi_certificates_issued AS ct ON pp.plcy_no = ct.policy_number AND pp.item_no = ct.item_number AND pp.next_debit_period = ct.renewal_month_year
    WHERE pp.src_type IN ('DR','AT')	
    AND ct.policy_number IS NULL
    AND pp.plcy_no = #Form.policy_number#
    AND pp.next_debit_period = (SELECT MIN(pp.next_debit_period)
			    FROM crm_payment_plans AS pp
			    LEFT OUTER JOIN crm_plcy_item AS pi ON pp.plcy_no = pi.plcy_no AND pp.item_no = pi.item_no
			    LEFT OUTER JOIN crm_body_types AS bt ON pi.body_type = bt.body_type
			    LEFT OUTER JOIN crm_motor_cover AS mc ON pi.cover = mc.cover
			    LEFT OUTER JOIN crm_rnwl_narratives AS rn ON pp.plcy_no = rn.plcy_no AND pp.item_no = rn.item_no
			    LEFT OUTER JOIN crm_policy AS p ON pp.plcy_no = p.plcy_no
			    LEFT OUTER JOIN crm_client_addr AS ca ON p.clnt_no = ca.clnt_no AND p.addr_no = ca.addr_no
			    LEFT OUTER JOIN crm_client AS c ON pp.clnt_no = c.clnt_no
			    INNER JOIN crm_source_names AS sn ON pp.src_type = sn.src_type AND pp.src_id = sn.src_id
			    LEFT JOIN icwi_broker.icwi_cover_notes_issued AS cn ON pp.plcy_no = cn.policy_number AND pp.item_no = cn.item_number AND pp.next_debit_period = CONCAT(LEFT(RIGHT(cn.cr_stamp,14),2),LEFT(RIGHT(cn.cr_stamp,17),2))
			    LEFT JOIN icwi_broker.icwi_certificates_issued AS ct ON pp.plcy_no = ct.policy_number AND pp.item_no = ct.item_number AND pp.next_debit_period = ct.renewal_month_year
			    WHERE pp.src_type IN ('DR','AT')
                AND ct.policy_number IS NULL	
			    AND pp.plcy_no = #Form.policy_number#
			    GROUP BY pp.plcy_no
			    ORDER BY pp.plcy_no, pp.item_no)
    GROUP BY pp.plcy_no, pp.next_debit_period
    ORDER BY pp.plcy_no, pp.item_no
</cfquery>

<cfif getSelectedItemForRenewal.recordcount eq 0>
    <cfquery name="getSelectedItemForRenewal" datasource="#datasourceII#" result="annual_rnwl">
        SELECT '' AS branch_id, '' AS branch_name, ro.src_type, ro.src_id, sn.src_name, ri.rnwl_mth, 
        c.clnt_no, c.clnt_type,  ro.name_mail, c.occupation, ca.addr_no, ca.addr_line_1, ca.addr_line_2, 
        ca.addr_line_3, ca.addr_city, ca.phone_no, ri.plcy_no, GROUP_CONCAT(ri.item_no) AS item_no, GROUP_CONCAT(pi.risk_item_no) AS risk_item_no, ro.scheme_id, GROUP_CONCAT(ri.si_amt) AS si_amt, 
        GROUP_CONCAT(0.00) AS annual_net_prem, GROUP_CONCAT(0.00) AS fee_amt, GROUP_CONCAT(ri.tax) AS gct_amt, GROUP_CONCAT(ri.annual_net_prem) AS premium, GROUP_CONCAT(0.00) AS pen_amt, DATE(ro.rnwl_dt_time) as rnwl_dt_time, '' AS exp_debit_date, ro.prem_period, ro.pymt_plan, 
        rn.cert_code, pi.cover, mc.cover_descr, pi.make, pi.model, pi.yr_of_mfe, pi.reg_no, pi.chassis_no, pi.colour, 
        bt.body_descr, pi.cert_id, p.react_yn, pi.si_amt, p.currency_id, sn.country_id, pi.open_or_restr, pi.cc_hp, 
        pi.seating_cap, p.class_id, p.sub_class_id, GROUP_CONCAT(rn.narrative5) AS narrative5, GROUP_CONCAT(rn.narrative6) AS narrative6, rn.cert_effective_dt, rn.cert_epiry_dt, 
        '' AS period_descr, pi.usages, cn.policy_number AS cn_plcy_no, cn.item_number AS cn_item_no,
        ct.policy_number AS ct_plcy_no, ct.item_number AS ct_item_no, c.bal_outstanding, COUNT(*) AS total_risks,
        DATE(NOW())-DATE(ro.rnwl_dt_time) AS days_lapsed,
        GROUP_CONCAT(CONCAT(pi.yr_of_mfe,' ',pi.make,' ',pi.model)) AS vehicle_make_model_type,
        GROUP_CONCAT(pi.reg_no) AS vehicle_registration,
        GROUP_CONCAT(pi.chassis_no) AS vehicle_chassis_number,
        GROUP_CONCAT(bt.body_descr) AS vehicle_body_type
        FROM crm_renewal_offer AS ro
        LEFT OUTER JOIN crm_rnwl_item AS ri ON ro.rnwl_mth = ri.rnwl_mth AND ro.plcy_no = ri.plcy_no
        LEFT OUTER JOIN crm_plcy_item AS pi ON ri.plcy_no = pi.plcy_no AND ri.item_no = pi.item_no
        LEFT OUTER JOIN crm_body_types AS bt ON pi.body_type = bt.body_type
        LEFT OUTER JOIN crm_motor_cover AS mc ON pi.cover = mc.cover
        LEFT OUTER JOIN crm_rnwl_narratives AS rn ON ri.plcy_no = rn.plcy_no AND ri.item_no = rn.item_no
        LEFT OUTER JOIN crm_policy AS p ON ri.plcy_no = p.plcy_no
        LEFT OUTER JOIN crm_client_addr AS ca ON p.clnt_no = ca.clnt_no AND p.addr_no = ca.addr_no
        LEFT OUTER JOIN crm_client AS c ON ri.item_owner_no = c.clnt_no
        INNER JOIN crm_source_names AS sn ON ro.src_type = sn.src_type AND ro.src_id = sn.src_id
        LEFT JOIN icwi_broker.icwi_cover_notes_issued AS cn ON ri.plcy_no = cn.policy_number AND ri.item_no = cn.item_number AND ro.rnwl_mth = CONCAT(LEFT(RIGHT(cn.cr_stamp,14),2),LEFT(RIGHT(cn.cr_stamp,17),2))
        LEFT JOIN icwi_broker.icwi_certificates_issued AS ct ON ri.plcy_no = ct.policy_number AND ri.item_no = ct.item_number AND ro.rnwl_mth = ct.renewal_month_year
        WHERE ro.src_type IN ('DR','AT')
        AND  ro.offering_rnwl = 'Y'  
        AND ri.debit_raised = 'N'
        AND ro.rnwl_status = 'C'
		AND ro.class_id = 'MV'
        AND ri.plcy_no = #Form.policy_number#<!--- 35570684 --->
        GROUP BY ri.plcy_no
        ORDER BY ri.plcy_no, ri.item_no
    </cfquery>
</cfif>

<!--- delete already created certificates ---> 
<cfif getSelectedItemForRenewal.recordcount gt 0>
    <cfquery name="deletePreviouslyRenewed" datasource="#datasource#">
    	DELETE FROM icwi_certificates_created WHERE policy_number = #Form.policy_number# AND renewal_month_year = '#getSelectedItemForRenewal.rnwl_mth#'
    </cfquery>
</cfif>

<cfif getSelectedItemForRenewal.recordcount>
	<cfif getSelectedItemForRenewal.pymt_plan eq 1>
		<cfset daysLapsed = DateDiff('d', getSelectedItemForRenewal.rnwl_dt_time, request.date)-1>
        <!--- 
        <cfif Arguments.plan_code is not "U">
        	<cfset getSelectedItemForRenewal.prem_period = Arguments.plan_code>
        </cfif>
		--->
    <cfelse>
        <cfset daysLapsed = DateDiff('d', getSelectedItemForRenewal.rnwl_dt_time, request.date)>
    </cfif>
    
	<!--- Assign effective to date if policy not payment plan extension --->
    <cfif getSelectedItemForRenewal.pymt_plan eq 1>
    	<cfif daysLapsed gte 0>
        	<cfset effective_from = DateFormat(request.date,"yyyy-mm-dd") & ' ' & TimeFormat(request.date,'HH:mm')>
        <cfelse>
            <cfset effective_from = DateFormat(getSelectedItemForRenewal.rnwl_dt_time+1,"yyyy-mm-dd") & ' 00:01'>
        </cfif>
		<cfif getSelectedItemForRenewal.prem_period is 'H'>
            <cfset effective_to = #DateAdd('d',-1,DateAdd('m',6,effective_from))#>
        <cfelseif getSelectedItemForRenewal.prem_period is 'T' or getSelectedItemForRenewal.prem_period is 'C' or getSelectedItemForRenewal.prem_period is 'Q'>
            <cfset effective_to = #DateAdd('d',-1,DateAdd('m',3,effective_from))#>    
        <cfelseif getSelectedItemForRenewal.prem_period is 'M'>
            <cfset effective_to = #DateAdd('d',-1,DateAdd('m',1,effective_from))#>
        <cfelse>
            <cfset effective_to = #DateAdd('d',-1,DateAdd('yyyy',1,effective_from))#>
        </cfif>        
    <cfelse>
    	<cfif daysLapsed gt 0>
        	<cfset effective_from = DateFormat(request.date,"yyyy-mm-dd") & ' ' & TimeFormat(request.date,'HH:mm')>
        <cfelse>
        	<cfset effective_from = DateFormat(getSelectedItemForRenewal.rnwl_dt_time,"yyyy-mm-dd") & ' 00:01'>
        </cfif>
    	<cfset effective_to = getSelectedItemForRenewal.effective_to>   
    </cfif>
      

<!--- setup defaults ---> 
<cfset stNrRdThList = "st,nd,rd,th,th,th,th,th,th,th,th,th,th,th,th,th,th,th,th,th,st,nd,rd,th,th,th,th,th,th,th,st">
<cfset request.Today = Now()>
<cfset effective_from = DateFormat(effective_from,"dd-mm-yyyy")>
<cfset effective_to = DateFormat(effective_to,"dd-mm-yyyy")>
<cfset Form.item_number = getSelectedItemForRenewal.item_no>
<cfset Form.item_no = getSelectedItemForRenewal.item_no>
<cfset Form.risk_item_no = getSelectedItemForRenewal.risk_item_no>
<cfset risk_item_no = getSelectedItemForRenewal.risk_item_no>
<cfset Form.certificate_cover = getSelectedItemForRenewal.cover>
<cfset Form.cert_id = getSelectedItemForRenewal.cert_id>
<cfset Form.renewal_month_year = getSelectedItemForRenewal.rnwl_mth>
<cfset request.sbranchId = "">
<!--- <cfset request.ssrcId = getSelectedItemForRenewal.src_id> --->
<!--- <cfset request.ssrcType = getSelectedItemForRenewal.src_type> --->
<cfset request.ssrcId = "999">
<cfset request.ssrcType = "DR">
<cfset Form.payment_plan = getSelectedItemForRenewal.pymt_plan>
<cfset Form.scheme_id = "">
<!--- <cfif DateCompare( getSelectedItemForRenewal.rnwl_dt_time, Now() ) lt 0> --->
<!--- <cfif DateDiff("d", getSelectedItemForRenewal.rnwl_dt_time, Now()) gt 0> --->
<cfset todays_date = DateFormat(request.date,"yyyy-mm-dd")> 
<cfif daysLapsed gt 0>
	<cfset Form.reinstate = "Y">
<cfelse>
	<cfset Form.reinstate = "N">
</cfif>    
<cfset Form.react_yn = getSelectedItemForRenewal.react_yn>
<cfset payment_option = getSelectedItemForRenewal.prem_period>
<cfset Form.premium_period = getSelectedItemForRenewal.prem_period>
<cfset sequence_number = getSelectedItemForRenewal.pymt_plan>
<cfset Form.client_number = getSelectedItemForRenewal.clnt_no>
<cfset Form.comments = "">
<cfset request.userId = 618>
<cfif getSelectedItemForRenewal.react_yn is 'Y'>
	<cfset react = 'REACT'>
<cfelse>
	<cfset react = ''>
</cfif>
<cfif system is 'Kiosk'>
	<cfset request.userId = 618>
    <cfset request.usersFullName = "Kiosk System">
<!--- <cfelseif system is 'eCient'> --->
<cfelse>
	<cfset request.userId = 777>
    <cfset request.usersFullName = "Click&Go System">
</cfif>

<cfset total_risks = getSelectedItemForRenewal.total_risks>
<cfset Form.cert_code = getSelectedItemForRenewal.cert_code>
<cfset Form.period_descr = getSelectedItemForRenewal.period_descr>
<cfset Form.narrative5 = getSelectedItemForRenewal.narrative5>
<cfset Form.narrative6 = getSelectedItemForRenewal.narrative6>
<cfset Form.annual_prem = getSelectedItemForRenewal.premium>
<cfset Form.amt_due = getSelectedItemForRenewal.annual_net_prem>
<cfset Form.late_fee = getSelectedItemForRenewal.pen_amt>
<cfset Form.facility_fee = getSelectedItemForRenewal.fee_amt>
<cfset Form.stamp_duty = 0.00>
<cfset Form.tax = getSelectedItemForRenewal.gct_amt>
<cfset Form.vehicle_make_model_type = getSelectedItemForRenewal.vehicle_make_model_type>
<cfset Form.vehicle_registration = getSelectedItemForRenewal.vehicle_registration>
<cfset Form.vehicle_chassis_number = getSelectedItemForRenewal.vehicle_chassis_number>
<cfset Form.vehicle_body_type = getSelectedItemForRenewal.vehicle_body_type>
<cfset days_lapsed = getSelectedItemForRenewal.days_lapsed>
<cfset getBrokerInfo.src_name = "Direct Business">
<cfset certificatePdfPath = "/home/CFApplications/Broker/PDFs/Certificates/">
<cfset certificatePath = "../../../../../home/CFApplications/Broker/PDFs/Certificates/">
<cfset pdfPath = "/home/CFApplications/Broker/Certificates/">
<cfset certUrlPath = "//ebrokertest.icwi.local/Broker/PDFs/Certificates/">

<cfloop list = "#Form.item_no#" index = "item_number">
	<cfset "Form.risk_item_no_#item_number#" = ListGetAt(getSelectedItemForRenewal.risk_item_no,#item_number#)>
    <cfset "Form.vehicle_make_model_type_#item_number#" = ListGetAt(getSelectedItemForRenewal.vehicle_make_model_type,#item_number#,",","yes")>
    <cfset "Form.vehicle_registration_#item_number#" = ListGetAt(getSelectedItemForRenewal.vehicle_registration,#item_number#,",","yes")>
    <cfset "Form.vehicle_chassis_number_#item_number#" = ListGetAt(getSelectedItemForRenewal.vehicle_chassis_number,#item_number#,",","yes")>
    <cfset "Form.vehicle_body_type_#item_number#" = ListGetAt(getSelectedItemForRenewal.vehicle_body_type,#item_number#,",","yes")>
    <cfset "Form.narrative5_#item_number#" = ListGetAt(getSelectedItemForRenewal.narrative5,#item_number#,",","yes")>
    <cfset "Form.narrative6_#item_number#" = ListGetAt(getSelectedItemForRenewal.narrative6,#item_number#,",","yes")>
    <cfset "Form.annual_prem_#item_number#" = ListGetAt(getSelectedItemForRenewal.premium,#item_number#)>
    <cfset "Form.amt_due_#item_number#" = ListGetAt(getSelectedItemForRenewal.annual_net_prem,#item_number#)>
    <cfset "Form.late_fee_#item_number#" = ListGetAt(getSelectedItemForRenewal.pen_amt,#item_number#)>
    <cfset "Form.facility_fee_#item_number#" = ListGetAt(getSelectedItemForRenewal.fee_amt,#item_number#)>
    <cfset "Form.stamp_duty_#item_number#" = 0.00>
    <cfset "Form.tax_#item_number#" = ListGetAt(getSelectedItemForRenewal.gct_amt,#item_number#)>
    <!---
    	<cfset "Form.amt_due_#item_number#" = Evaluate("Form.amt_due_#item_number#") - Evaluate("Form.late_fee_#item_number#") + Evaluate("Form.facility_fee_#item_number#") + Evaluate("Form.stamp_duty_#item_number#") + Evaluate("Form.tax_#item_number#")>
	--->
</cfloop>

<!--- make sure policy holders name is not gt than 40 characters long --->
<cfif Len(Trim(getSelectedItemForRenewal.name_mail)) gt 40>
	<cfloop index="i" from="40" to="1" step="-1">
		<cfif Mid(getSelectedItemForRenewal.name_mail,#i#,1) is " ">
			<cfset request.policy_holders_name1 = Left(getSelectedItemForRenewal.name_mail, i)>
			<cfset request.policy_holders_name2 = Mid(getSelectedItemForRenewal.name_mail, i + 1, Len(Trim(getSelectedItemForRenewal.name_mail)) - i)>
			<cfbreak>
		</cfif>
	</cfloop>
<cfelse>
	<cfset request.policy_holders_name1 = Trim(getSelectedItemForRenewal.name_mail)>
    <cfset request.policy_holders_name2 = "">
</cfif>

<cfset Form.policy_holders_name1 = request.policy_holders_name1>
<cfset Form.policy_holders_name2 = request.policy_holders_name2>

<cfif days_lapsed lt 0>
	<cfset days_lapsed = 0>
</cfif>    

<cfif Form.payment_plan eq 1>
	<cfif daysLapsed gte 0>
        <cfset request.effectiveFromDate = Mid(effective_from,7,4) & '-' & Mid(effective_from,4,2) & '-' & Left(effective_from,2) & ' ' & TimeFormat(request.date,'HH:mm:ss')>
    <cfelse>
        <cfset request.effectiveFromDate = Mid(effective_from,7,4) & '-' & Mid(effective_from,4,2) & '-' & Left(effective_from,2) & ' 00:01:00'>
    </cfif> 
<cfelse>
	<cfif daysLapsed gt 0>
        <cfset request.effectiveFromDate = Mid(effective_from,7,4) & '-' & Mid(effective_from,4,2) & '-' & Left(effective_from,2) & ' ' & TimeFormat(request.date,'HH:mm:ss')>
    <cfelse>
        <cfset request.effectiveFromDate = Mid(effective_from,7,4) & '-' & Mid(effective_from,4,2) & '-' & Left(effective_from,2) & ' 00:01:00'>
    </cfif> 
</cfif>
<cfset stDay = Left(effective_from,2)>
<cfset stMonth = Mid(effective_from,4,2)>
<cfset stYear = Mid(effective_from,7,4)>
<cfset request.effectiveFromDateString = NumberFormat(stDay) & ListGetAt(stNrRdThList,stDay) & ' ' & MonthAsString(stMonth) & ' ' & stYear>
<cfset request.effectiveToDate = Mid(effective_to,7,4) & '-' & Mid(effective_to,4,2) & '-' & Left(effective_to,2)>
<cfset stDay = Left(effective_to,2)>
<cfset stMonth = Mid(effective_to,4,2)>
<cfset stYear = Mid(effective_to,7,4)>
<cfset request.effectiveToDateString = NumberFormat(stDay) & ListGetAt(stNrRdThList,stDay) & ' ' & MonthAsString(stMonth) & ' ' & stYear>

<cfset request.issuedDateString = Day(request.Today) & ListGetAt(stNrRdThList,Day(request.Today)) & ' day of ' & MonthAsString(Month(request.Today)) & ' ' & Year(request.Today)>
<cftransaction action="BEGIN">

<!--- get next certificate number --->
<cfquery name="getCertificateNumber" datasource="#datasource#">
	select ifnull(max(certificate_number),0) + 1 as nextNumber
	
	from icwi_certificates_issued
	
	<cfif IsNumeric(request.sbranchId)>
		where certificate_branch_id = <cfqueryparam value="#request.sbranchId#" cfsqltype="CF_SQL_INTEGER" maxlength="4">
	<cfelse>
		where certificate_src_type = <cfqueryparam value="#request.ssrcType#" cfsqltype="CF_SQL_CHAR" maxlength="2">
		and certificate_src_id = <cfqueryparam value="#request.ssrcId#" cfsqltype="CF_SQL_CHAR" maxlength="3">
	</cfif>
</cfquery>

<!--- generate unique certificate number --->
<cfset request.certificateNumber = getCertificateNumber.nextNumber>
<cfif IsNumeric(request.sbranchId)>
	<cfset request.nextCertificateNumberString = #Right('000' & Trim(request.sbranchId),3)# & 'CT' & Right('000000#Trim(request.certificateNumber)#', 6)>
<cfelse>
	<cfset request.nextCertificateNumberString = Trim(UCase(request.ssrcId)) & 'CT' & Right('000000#Trim(request.certificateNumber)#', 6)>
</cfif>

<!--- build policy number string --->
<cfset request.PolicyNumberString = Trim(Form.policy_number) & '/' & Trim(Form.item_number)>
<cfif Trim(Form.scheme_id) is not "">
	<cfset request.PolicyNumberString = request.PolicyNumberString & '/' & Trim(Form.scheme_id)>
</cfif>

<!--- set certificate type - NW - New, RN|RE - Renewal, EA|RI - Reinstated --->
<cfif Form.reinstate is 'Y'>
	<cfset request.certificate_type = "EA">
<cfelse>
	<cfset request.certificate_type = "RN">
</cfif>

<!--- set certificate sequence - A1,H1,H2,Q1,Q2,Q3,Q4,T1,T2 from payment_option and sequence_number --->
<cfset request.certificate_sequence = #Trim(payment_option)# & #Trim(sequence_number)#>

<!--- create unique certificate file name --->
<cfset request.pdfFileName =  'CERT_' & Form.policy_number & DateFormat(request.Today,'yyyymmdd') & TimeFormat(request.Today,'HHmmss') & '.pdf'>

<!--- setup defaults --->
<cfparam name="Form.vehicle_inspected" default="N">
<cfparam name="Form.inspected_by" default="">
<cfparam name="Form.no_damage" default="N">
<cfparam name="Form.no_loss_dec_signed" default="N">

<cfif total_risks eq 1>	
    <!--- save certificate issued --->
    <cfif system is not 'kiosk' and system is not 'eclient'>
        <cfquery name="saveCertificateIssued" datasource="#datasource#" result="cert_count">
            insert into icwi_certificates_issued
                (
                certificate_branch_id, certificate_src_type, certificate_src_id, certificate_number, certificate_type, 
                    certificate_sequence, certificate_cover, 
                    cert_id, client_number, policy_number, item_number, risk_item_number, scheme_id, renewal_month_year, 
                        vehicle_make_model_type, vehicle_registration, vehicle_chassis_number, vehicle_body_type,
                            policy_holders_name1, policy_holders_name2, annual_prem, amt_due, late_fee, facility_fee, stamp_duty, tax,
                                reinstated, vehicle_inspected, inspected_by, no_damage, no_loss_dec_signed, 
                                      effective_from, effective_to, 
                                            payment_plan, premium_period, narrative5, narrative6, 
                                                date_of_issue, user_id, react_yn, pdf_file_name, system, cr_stamp 
                )
            values
                (
            <cfif IsNumeric(request.sbranchId)>
                <cfqueryparam value="#request.sbranchId#" cfsqltype="CF_SQL_INTEGER" maxlength="4">,
                null,
                null,
            <cfelse>
                null,
                <cfqueryparam value="#request.ssrcType#" cfsqltype="CF_SQL_CHAR" maxlength="2">,
                <cfqueryparam value="#request.ssrcId#" cfsqltype="CF_SQL_CHAR" maxlength="3">,
            </cfif>
                <cfqueryparam value="#request.certificateNumber#" cfsqltype="CF_SQL_INTEGER" maxlength="6">,
                <cfqueryparam value="#request.certificate_type#" cfsqltype="CF_SQL_CHAR" maxlength="2">,
                <cfqueryparam value="#request.certificate_sequence#" cfsqltype="CF_SQL_CHAR" maxlength="2">,
                <cfqueryparam value="#Form.certificate_cover#" cfsqltype="CF_SQL_CHAR" maxlength="2">,
        
                <cfqueryparam value="#Form.cert_id#" cfsqltype="CF_SQL_VARCHAR" maxlength="8">,
                <cfqueryparam value="#Form.client_number#" cfsqltype="CF_SQL_VARCHAR" maxlength="9">,
                <cfqueryparam value="#Form.policy_number#" cfsqltype="CF_SQL_INTEGER" maxlength="9">,
                <cfqueryparam value="#Form.item_number#" cfsqltype="CF_SQL_INTEGER" maxlength="4">,
                <cfqueryparam value="#VAL(Form.risk_item_no)#" cfsqltype="CF_SQL_INTEGER" maxlength="10">,
                <cfqueryparam value="#Form.scheme_id#" cfsqltype="CF_SQL_CHAR" maxlength="3">,
                <cfqueryparam value="#Form.renewal_month_year#" cfsqltype="CF_SQL_CHAR" maxlength="4">,
                
                <cfqueryparam value="#Form.vehicle_make_model_type#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
                <cfqueryparam value="#Form.vehicle_registration#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
                <cfqueryparam value="#Form.vehicle_chassis_number#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
                <cfqueryparam value="#Form.vehicle_body_type#" cfsqltype="CF_SQL_VARCHAR" maxlength="30">,
        
                <cfqueryparam value="#Form.policy_holders_name1#" cfsqltype="CF_SQL_VARCHAR" maxlength="60">,
                <cfqueryparam value="#Form.policy_holders_name2#" cfsqltype="CF_SQL_VARCHAR" maxlength="60">,
                <cfqueryparam value="#NumberFormat(Form.annual_prem,'9.99')#" cfsqltype="CF_SQL_MONEY" maxlength="12">,
                <cfqueryparam value="#NumberFormat(Form.amt_due,'9.99')#" cfsqltype="CF_SQL_MONEY" maxlength="12">,
                <cfqueryparam value="#NumberFormat(Form.late_fee,'9.99')#" cfsqltype="CF_SQL_MONEY" maxlength="12">,
                <cfqueryparam value="#NumberFormat(Form.facility_fee,'9.99')#" cfsqltype="CF_SQL_MONEY" maxlength="12">,
                <cfqueryparam value="#NumberFormat(Form.stamp_duty,'9.99')#" cfsqltype="CF_SQL_MONEY" maxlength="12">,
                <cfqueryparam value="#NumberFormat(Form.tax,'9.99')#" cfsqltype="CF_SQL_MONEY" maxlength="12">,
        
                <cfqueryparam value="#Form.reinstate#" cfsqltype="CF_SQL_CHAR" maxlength="1">,
                <cfqueryparam value="#Form.vehicle_inspected#" cfsqltype="CF_SQL_CHAR" maxlength="1">,
                <cfqueryparam value="#Form.inspected_by#" cfsqltype="CF_SQL_VARCHAR" maxlength="30">,
                <cfqueryparam value="#Form.no_damage#" cfsqltype="CF_SQL_CHAR" maxlength="1">,
                <cfqueryparam value="#Form.no_loss_dec_signed#" cfsqltype="CF_SQL_CHAR" maxlength="1">,
                
                <cfqueryparam value="#request.effectiveFromDate#" cfsqltype="CF_SQL_TIMESTAMP">,
                <cfqueryparam value="#request.effectiveToDate#" cfsqltype="CF_SQL_TIMESTAMP">,
        
                <cfqueryparam value="#Form.payment_plan#" cfsqltype="CF_SQL_INTEGER" maxlength="4">,
                <cfqueryparam value="#Form.premium_period#" cfsqltype="CF_SQL_CHAR" maxlength="1">,
                
                <cfqueryparam value="#Form.narrative5#" cfsqltype="CF_SQL_VARCHAR" maxlength="10000">,
                <cfqueryparam value="#Form.narrative6#" cfsqltype="CF_SQL_VARCHAR" maxlength="10000">,
                
                <cfqueryparam value="#request.Today#" cfsqltype="CF_SQL_TIMESTAMP">,
                <cfqueryparam value="#request.userId#" cfsqltype="CF_SQL_INTEGER" maxlength="4">,
                <cfqueryparam value="#Form.react_yn#" cfsqltype="CF_SQL_CHAR" maxlength="1">,
            
                <cfqueryparam value="#request.pdfFileName#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
                <cfqueryparam value="#system#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
                <cfqueryparam value="#request.Today#" cfsqltype="CF_SQL_TIMESTAMP">
                )
        </cfquery>
    </cfif>
        
	<!--- save certificate created --->
    <cfquery name="saveCertificateCreated" datasource="#datasource#" result="cert_count">
        insert into icwi_certificates_created
            (
            certificate_branch_id, certificate_src_type, certificate_src_id, certificate_number, certificate_type, 
                certificate_sequence, certificate_cover, 
                cert_id, client_number, policy_number, item_number, risk_item_number, scheme_id, renewal_month_year, 
                    vehicle_make_model_type, vehicle_registration, vehicle_chassis_number, vehicle_body_type,
                        policy_holders_name1, policy_holders_name2, annual_prem, amt_due, late_fee, facility_fee, stamp_duty, tax,
                        	reinstated, vehicle_inspected, inspected_by, no_damage, no_loss_dec_signed, 
                                  effective_from, effective_to, 
                                        payment_plan, premium_period, narrative5, narrative6, 
                                            date_of_issue, user_id, react_yn, pdf_file_name, system, cr_stamp 
            )
        values
            (
        <cfif IsNumeric(request.sbranchId)>
            <cfqueryparam value="#request.sbranchId#" cfsqltype="CF_SQL_INTEGER" maxlength="4">,
            null,
            null,
        <cfelse>
            null,
            <cfqueryparam value="#request.ssrcType#" cfsqltype="CF_SQL_CHAR" maxlength="2">,
            <cfqueryparam value="#request.ssrcId#" cfsqltype="CF_SQL_CHAR" maxlength="3">,
        </cfif>
            <cfqueryparam value="#request.certificateNumber#" cfsqltype="CF_SQL_INTEGER" maxlength="6">,
            <cfqueryparam value="#request.certificate_type#" cfsqltype="CF_SQL_CHAR" maxlength="2">,
            <cfqueryparam value="#request.certificate_sequence#" cfsqltype="CF_SQL_CHAR" maxlength="2">,
            <cfqueryparam value="#Form.certificate_cover#" cfsqltype="CF_SQL_CHAR" maxlength="2">,
    
            <cfqueryparam value="#Form.cert_id#" cfsqltype="CF_SQL_VARCHAR" maxlength="8">,
            <cfqueryparam value="#Form.client_number#" cfsqltype="CF_SQL_VARCHAR" maxlength="9">,
            <cfqueryparam value="#Form.policy_number#" cfsqltype="CF_SQL_INTEGER" maxlength="9">,
            <cfqueryparam value="#Form.item_number#" cfsqltype="CF_SQL_INTEGER" maxlength="4">,
            <cfqueryparam value="#VAL(Form.risk_item_no)#" cfsqltype="CF_SQL_INTEGER" maxlength="10">,
            <cfqueryparam value="#Form.scheme_id#" cfsqltype="CF_SQL_CHAR" maxlength="3">,
            <cfqueryparam value="#Form.renewal_month_year#" cfsqltype="CF_SQL_CHAR" maxlength="4">,
            
            <cfqueryparam value="#Form.vehicle_make_model_type#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
            <cfqueryparam value="#Form.vehicle_registration#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
            <cfqueryparam value="#Form.vehicle_chassis_number#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
            <cfqueryparam value="#Form.vehicle_body_type#" cfsqltype="CF_SQL_VARCHAR" maxlength="30">,
    
            <cfqueryparam value="#Form.policy_holders_name1#" cfsqltype="CF_SQL_VARCHAR" maxlength="60">,
            <cfqueryparam value="#Form.policy_holders_name2#" cfsqltype="CF_SQL_VARCHAR" maxlength="60">,
            <cfqueryparam value="#NumberFormat(Form.annual_prem,'9.99')#" cfsqltype="CF_SQL_MONEY" maxlength="12">,
            <cfqueryparam value="#NumberFormat(Form.amt_due,'9.99')#" cfsqltype="CF_SQL_MONEY" maxlength="12">,
            <cfqueryparam value="#NumberFormat(Form.late_fee,'9.99')#" cfsqltype="CF_SQL_MONEY" maxlength="12">,
            <cfqueryparam value="#NumberFormat(Form.facility_fee,'9.99')#" cfsqltype="CF_SQL_MONEY" maxlength="12">,
            <cfqueryparam value="#NumberFormat(Form.stamp_duty,'9.99')#" cfsqltype="CF_SQL_MONEY" maxlength="12">,
            <cfqueryparam value="#NumberFormat(Form.tax,'9.99')#" cfsqltype="CF_SQL_MONEY" maxlength="12">,
    
            <cfqueryparam value="#Form.reinstate#" cfsqltype="CF_SQL_CHAR" maxlength="1">,
            <cfqueryparam value="#Form.vehicle_inspected#" cfsqltype="CF_SQL_CHAR" maxlength="1">,
            <cfqueryparam value="#Form.inspected_by#" cfsqltype="CF_SQL_VARCHAR" maxlength="30">,
            <cfqueryparam value="#Form.no_damage#" cfsqltype="CF_SQL_CHAR" maxlength="1">,
            <cfqueryparam value="#Form.no_loss_dec_signed#" cfsqltype="CF_SQL_CHAR" maxlength="1">,
            
            <cfqueryparam value="#request.effectiveFromDate#" cfsqltype="CF_SQL_TIMESTAMP">,
            <cfqueryparam value="#request.effectiveToDate#" cfsqltype="CF_SQL_TIMESTAMP">,
    
            <cfqueryparam value="#Form.payment_plan#" cfsqltype="CF_SQL_INTEGER" maxlength="4">,
            <cfqueryparam value="#Form.premium_period#" cfsqltype="CF_SQL_CHAR" maxlength="1">,
            
            <cfqueryparam value="#Form.narrative5#" cfsqltype="CF_SQL_VARCHAR" maxlength="10000">,
            <cfqueryparam value="#Form.narrative6#" cfsqltype="CF_SQL_VARCHAR" maxlength="10000">,
            
            <cfqueryparam value="#request.Today#" cfsqltype="CF_SQL_TIMESTAMP">,
            <cfqueryparam value="#request.userId#" cfsqltype="CF_SQL_INTEGER" maxlength="4">,
            <cfqueryparam value="#Form.react_yn#" cfsqltype="CF_SQL_CHAR" maxlength="1">,
        
            <cfqueryparam value="#request.pdfFileName#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
            <cfqueryparam value="#system#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
            <cfqueryparam value="#request.Today#" cfsqltype="CF_SQL_TIMESTAMP">
            )
    </cfquery>
</cfif>

<!--- get last created_sequence_number --->
<cfquery name="getCreatedSequenceNumber" datasource="#datasource#">
	select LAST_INSERT_ID() as nextID
</cfquery>	

<!--- build commentary string --->
<cfset request.clientNumber = Form.client_number>
<cfset request.policyNumber = Trim(Form.policy_number)>
<cfset request.itemNumber = Trim(Form.item_number)>
<cfset request.commentaryString = "">
<cfif Trim(Form.comments) is not "">
	<cfset request.commentaryString = Trim(Form.comments) & Chr(13) & Chr(10)>
</cfif>
<cfset request.commentaryString = request.commentaryString & "Certificate: #Trim(request.nextCertificateNumberString)#">

<!--- Loop commentary --->
<cfif total_risks gt 1>
	<cfif StructKeyExists(Form,"item_no")>
        <cfloop list = "#Form.item_no#" index = "item_number">
            <cfset request.certificateNumber = Trim(request.certificateNumber)>
            
            <!--- save commentary --->
            <cfquery name="saveCertificateCommentary" datasource="#datasource#">
                insert into icwi_broker_commentary
                    ( 
                    branch_id, src_type, src_id, 
                        client_number, policy_number, item_number, 
                            certificate_number, commentary, broker_user, cr_stamp
                    )
                values
                    (
                <cfif IsNumeric(request.sbranchId)>
                    <cfqueryparam value="#request.sbranchId#" cfsqltype="CF_SQL_INTEGER" maxlength="4">,
                    null,
                    null,
                <cfelse>
                    null,
                    <cfqueryparam value="#request.ssrcType#" cfsqltype="CF_SQL_CHAR" maxlength="2">,
                    <cfqueryparam value="#request.ssrcId#" cfsqltype="CF_SQL_CHAR" maxlength="3">,
                </cfif>
                    
                    <cfqueryparam value="#request.clientNumber#" cfsqltype="CF_SQL_VARCHAR" maxlength="9">,
                    <cfqueryparam value="#request.policyNumber#" cfsqltype="CF_SQL_INTEGER" maxlength="9">,
                    <cfqueryparam value="#item_number#" cfsqltype="CF_SQL_INTEGER" maxlength="4">,
                    
                    <cfqueryparam value="#request.certificateNumber#" cfsqltype="CF_SQL_INTEGER" maxlength="6">,
                    <cfqueryparam value="#request.commentaryString#" cfsqltype="CF_SQL_VARCHAR" maxlength="2000">,
                    <cfqueryparam value="#request.userId#" cfsqltype="CF_SQL_INTEGER" maxlength="4">,
                    <cfqueryparam value="#request.Today#" cfsqltype="CF_SQL_TIMESTAMP">
                    )	
            </cfquery>
            <cfset request.certificateNumber = request.certificateNumber + 1>
        </cfloop>
    </cfif>		
<cfelse>
	<cfset request.certificateNumber = Trim(request.certificateNumber)>
    
    <!--- save commentary --->
    <cfquery name="saveCertificateCommentary" datasource="#datasource#">
        insert into icwi_broker_commentary
            ( 
            branch_id, src_type, src_id, 
                client_number, policy_number, item_number, 
                    certificate_number, commentary, broker_user, cr_stamp
            )
        values
            (
        <cfif IsNumeric(request.sbranchId)>
            <cfqueryparam value="#request.sbranchId#" cfsqltype="CF_SQL_INTEGER" maxlength="4">,
            null,
            null,
        <cfelse>
            null,
            <cfqueryparam value="#request.ssrcType#" cfsqltype="CF_SQL_CHAR" maxlength="2">,
            <cfqueryparam value="#request.ssrcId#" cfsqltype="CF_SQL_CHAR" maxlength="3">,
        </cfif>
            
            <cfqueryparam value="#request.clientNumber#" cfsqltype="CF_SQL_VARCHAR" maxlength="9">,
            <cfqueryparam value="#request.policyNumber#" cfsqltype="CF_SQL_INTEGER" maxlength="9">,
            <cfqueryparam value="#request.itemNumber#" cfsqltype="CF_SQL_INTEGER" maxlength="4">,
            
            <cfqueryparam value="#request.certificateNumber#" cfsqltype="CF_SQL_INTEGER" maxlength="6">,
            <cfqueryparam value="#request.commentaryString#" cfsqltype="CF_SQL_VARCHAR" maxlength="2000">,
            <cfqueryparam value="#request.userId#" cfsqltype="CF_SQL_INTEGER" maxlength="4">,
            <cfqueryparam value="#request.Today#" cfsqltype="CF_SQL_TIMESTAMP">
            )	
    </cfquery>
</cfif>
</cftransaction>	

<!--- build initials string --->
<cfset initialsStr = "ICWI eClient">
<!---
<cfset spaceMarker = 0>
<cfloop index="i" from="1" to="#Len(Trim(request.usersFullName))#">
	<cfif i eq 1>
		<cfset initialsStr = initialsStr & UCase(Mid(request.usersFullName,i,1))>
	<cfelse>
		<cfif spaceMarker gt 0 and Mid(request.usersFullName,i,1) is not " ">
			<cfset initialsStr = initialsStr & UCase(Mid(request.usersFullName,i,1))>
		</cfif>
		<cfif Mid(request.usersFullName,i,1) is " ">
			<cfset spaceMarker = i>
		<cfelse>
			<cfset spaceMarker = 0>
		</cfif>
	</cfif>
</cfloop>
--->
<!--- get pdf templates --->
<cfquery name="getPdfTemplates" datasource="ICWI_MySql_Broker_Security_DSN">
	select branch_id, src_type, src_id, country_id, default_currency, security_paper_used, cover_note_file_name, certificate_file_name
	
	from icwi_configuration
	
	<cfif IsNumeric(request.sbranchId)>
		where branch_id = <cfqueryparam value="#request.sbranchId#" cfsqltype="CF_SQL_INTEGER" maxlength="4">
	<cfelse>
		where src_type = <cfqueryparam value="#request.ssrcType#" cfsqltype="CF_SQL_CHAR" maxlength="2">
			and src_id = <cfqueryparam value="#request.ssrcId#" cfsqltype="CF_SQL_CHAR" maxlength="3">
	</cfif>
	limit 1
</cfquery>

<!--- include queries get certificate template file name --->
<!--- Modified for testing --->
<cfif getPdfTemplates.country_id is 'JAM'>
	<cfset getPdfTemplates.certificate_file_name = "icwi_certificate_of_insurance_jam_dr.pdf">
<cfelseif getPdfTemplates.country_id is 'SKN'>
	<cfset getPdfTemplates.certificate_file_name = "icwi_certificate_of_insurance_cay_dr.pdf"> 
<cfelseif getPdfTemplates.country_id is 'CAY'>
	<cfset getPdfTemplates.certificate_file_name = "icwi_certificate_of_insurance_cay_dr.pdf">        
</cfif>    
        
<!--- <cfset getPdfTemplates.certificate_file_name = "icwi_certificate_of_insurance_jam_dr_test.pdf"> --->
<cfset request.pdfCertificateTemplate = Trim(getPdfTemplates.certificate_file_name)>

<!--- include query to get branch / broker's full name and address --->
<cfif IsNumeric(request.sbranchId)>
	<!--- get selected branch --->
    <cfquery name="getBranchInfo" datasource="#datasourceII#">
        select *
        
        from crm_branch
    
        where branch_id = <cfqueryparam value="#request.sbranchId#" cfsqltype="CF_SQL_INTEGER" maxlength="4">
    </cfquery>
<cfelse>
	<!--- get selected broker --->
    <cfquery name="getBranchInfo" datasource="#datasourceII#">
        select *
        
        from crm_source_names
    
        where src_type = <cfqueryparam value="#request.ssrcType#" cfsqltype="CF_SQL_CHAR" maxlength="2"> 
            and src_id = <cfqueryparam value="#request.ssrcId#" cfsqltype="CF_SQL_CHAR" maxlength="3">
    </cfquery>
</cfif>

<!--- Loop cert --->
<cfif total_risks gt 1>
	<cfif StructKeyExists(Form,"item_no")>
        <cfloop list = "#Form.item_no#" index = "item_number">
            
            <!--- Build individual file names--->
            <cfset request.pdfFileNameII =  'CERT_' & Form.policy_number & DateFormat(request.Today,'yyyymmdd') & TimeFormat(request.Today,'HHmmss') & '_' & item_number & '.pdf'>
            
            <!--- build policy number string --->
            <cfset request.PolicyNumberStringII = Trim(Form.policy_number) & '/' & Trim(item_number)>
            <cfif Trim(Form.scheme_id) is not "">
                <cfset request.PolicyNumberStringII = request.PolicyNumberStringII & '/' & Trim(Form.scheme_id)>
            </cfif>
            
            <!--- get next certificate number --->
            <cfquery name="getCertificateNumber" datasource="#datasource#">
                select ifnull(max(certificate_number),0) + 1 as nextNumber
                
                from icwi_certificates_issued
                
                <cfif IsNumeric(request.sbranchId)>
                    where certificate_branch_id = <cfqueryparam value="#request.sbranchId#" cfsqltype="CF_SQL_INTEGER" maxlength="4">
                <cfelse>
                    where certificate_src_type = <cfqueryparam value="#request.ssrcType#" cfsqltype="CF_SQL_CHAR" maxlength="2">
                    and certificate_src_id = <cfqueryparam value="#request.ssrcId#" cfsqltype="CF_SQL_CHAR" maxlength="3">
                </cfif>
            </cfquery>

            <!--- generate unique certificate number --->
            <cfset request.certificateNumberII = getCertificateNumber.nextNumber>
            <cfif IsNumeric(request.sbranchId)>
                <cfset request.nextCertificateNumberStringII = #Right('000' & Trim(request.sbranchId),3)# & 'CT' & Right('000000#Trim(request.certificateNumberII)#', 6)>
            <cfelse>
                <cfset request.nextCertificateNumberStringII = Trim(UCase(request.ssrcId)) & 'CT' & Right('000000#Trim(request.certificateNumberII)#', 6)>
            </cfif>
            <cfset "cert_num_#item_number#" = request.nextCertificateNumberStringII>
            
            
            
            <!--- Build dynamic variables for query --->
            <cfset risk_item_number = Evaluate("risk_item_no" & "_" & "#item_number#")>
            <cfset veh_makeII = Evaluate("vehicle_make_model_type" & "_" & "#item_number#")>
            <cfset veh_regII = Evaluate("vehicle_registration" & "_" & "#item_number#")>
            <cfset veh_chassisII = Evaluate("vehicle_chassis_number" & "_" & "#item_number#")>
            <cfset veh_bodyII = Evaluate("vehicle_body_type" & "_" & "#item_number#")>
            <cfset narr5II = Evaluate("narrative5" & "_" & "#item_number#")>
            <cfset narr6II = Evaluate("narrative6" & "_" & "#item_number#")>
            <cfset annual_premII = Evaluate("annual_prem" & "_" & "#item_number#")>
			<cfset amt_dueII = Evaluate("amt_due" & "_" & "#item_number#")>
            <cfset late_feeII = Evaluate("late_fee" & "_" & "#item_number#")>
            <cfset facility_feeII = Evaluate("facility_fee" & "_" & "#item_number#")>
            <cfset stamp_dutyII = Evaluate("stamp_duty" & "_" & "#item_number#")>
            <cfset taxII = Evaluate("tax" & "_" & "#item_number#")>
            
            <!--- save certificate issued --->
            <cfif system is not 'kiosk' and system is not 'eclient'>
                <cfquery name="saveCertificateIssued" datasource="#datasource#" result="cert_count">
                    insert into icwi_certificates_issued
                        (
                        certificate_branch_id, certificate_src_type, certificate_src_id, certificate_number, certificate_type, 
                            certificate_sequence, certificate_cover, 
                            cert_id, client_number, policy_number, item_number, risk_item_number, scheme_id, renewal_month_year, 
                                vehicle_make_model_type, vehicle_registration, vehicle_chassis_number, vehicle_body_type,
                                        policy_holders_name1, policy_holders_name2, annual_prem, amt_due, late_fee, facility_fee, stamp_duty, tax,
                                            reinstated, vehicle_inspected, inspected_by, no_damage, no_loss_dec_signed, 
                                                effective_from, effective_to, 
                                                    payment_plan, premium_period, narrative5, narrative6, 
                                                        date_of_issue, user_id, react_yn, pdf_file_name, system, cr_stamp 
                        )
                    values
                        (
                    <cfif IsNumeric(request.sbranchId)>
                        <cfqueryparam value="#request.sbranchId#" cfsqltype="CF_SQL_INTEGER" maxlength="4">,
                        null,
                        null,
                    <cfelse>
                        null,
                        <cfqueryparam value="#request.ssrcType#" cfsqltype="CF_SQL_CHAR" maxlength="2">,
                        <cfqueryparam value="#request.ssrcId#" cfsqltype="CF_SQL_CHAR" maxlength="3">,
                    </cfif>
                        <cfqueryparam value="#request.certificateNumberII#" cfsqltype="CF_SQL_INTEGER" maxlength="7">,
                        <cfqueryparam value="#request.certificate_type#" cfsqltype="CF_SQL_CHAR" maxlength="2">,
                        <cfqueryparam value="#request.certificate_sequence#" cfsqltype="CF_SQL_CHAR" maxlength="2">,
                        <cfqueryparam value="#Form.certificate_cover#" cfsqltype="CF_SQL_CHAR" maxlength="2">,
                
                        <cfqueryparam value="#Form.cert_id#" cfsqltype="CF_SQL_VARCHAR" maxlength="8">,
                        <cfqueryparam value="#Form.client_number#" cfsqltype="CF_SQL_VARCHAR" maxlength="9">,
                        <cfqueryparam value="#Form.policy_number#" cfsqltype="CF_SQL_INTEGER" maxlength="9">,
                        <cfqueryparam value="#item_number#" cfsqltype="CF_SQL_INTEGER" maxlength="4">,
                        <cfqueryparam value="#VAL(risk_item_number)#" cfsqltype="CF_SQL_INTEGER" maxlength="10">,
                        <cfqueryparam value="#Form.scheme_id#" cfsqltype="CF_SQL_CHAR" maxlength="3">,
                        <cfqueryparam value="#Form.renewal_month_year#" cfsqltype="CF_SQL_CHAR" maxlength="4">,
                        
                        <cfqueryparam value="#veh_makeII#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
                        <cfqueryparam value="#veh_regII#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
                        <cfqueryparam value="#veh_chassisII#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
                        <cfqueryparam value="#veh_bodyII#" cfsqltype="CF_SQL_VARCHAR" maxlength="30">,
                
                        <cfqueryparam value="#Form.policy_holders_name1#" cfsqltype="CF_SQL_VARCHAR" maxlength="60">,
                        <cfqueryparam value="#Form.policy_holders_name2#" cfsqltype="CF_SQL_VARCHAR" maxlength="60">,
                        <cfqueryparam value="#annual_premII#" cfsqltype="CF_SQL_MONEY" maxlength="12">,
                        <cfqueryparam value="#amt_dueII#" cfsqltype="CF_SQL_MONEY" maxlength="12">,
                        <cfqueryparam value="#late_feeII#" cfsqltype="CF_SQL_MONEY" maxlength="12">,
                        <cfqueryparam value="#facility_feeII#" cfsqltype="CF_SQL_MONEY" maxlength="12">,
                        <cfqueryparam value="#stamp_dutyII#" cfsqltype="CF_SQL_MONEY" maxlength="12">,
                        <cfqueryparam value="#taxII#" cfsqltype="CF_SQL_MONEY" maxlength="12">,
                
                        <cfqueryparam value="#Form.reinstate#" cfsqltype="CF_SQL_CHAR" maxlength="1">,
                        <cfqueryparam value="#Form.vehicle_inspected#" cfsqltype="CF_SQL_CHAR" maxlength="1">,
                        <cfqueryparam value="#Form.inspected_by#" cfsqltype="CF_SQL_VARCHAR" maxlength="30">,
                        <cfqueryparam value="#Form.no_damage#" cfsqltype="CF_SQL_CHAR" maxlength="1">,
                        <cfqueryparam value="#Form.no_loss_dec_signed#" cfsqltype="CF_SQL_CHAR" maxlength="1">,
                        
                        <cfqueryparam value="#request.effectiveFromDate#" cfsqltype="CF_SQL_TIMESTAMP">,
                        <cfqueryparam value="#request.effectiveToDate#" cfsqltype="CF_SQL_TIMESTAMP">,
                
                        <cfqueryparam value="#Form.payment_plan#" cfsqltype="CF_SQL_INTEGER" maxlength="4">,
                        <cfqueryparam value="#Form.premium_period#" cfsqltype="CF_SQL_CHAR" maxlength="1">,
                        
                        <cfqueryparam value="#narr5II#" cfsqltype="CF_SQL_VARCHAR" maxlength="4000">,
                        <cfqueryparam value="#narr6II#" cfsqltype="CF_SQL_VARCHAR" maxlength="4000">,
                        
                        <cfqueryparam value="#request.Today#" cfsqltype="CF_SQL_TIMESTAMP">,
                        <cfqueryparam value="#request.userId#" cfsqltype="CF_SQL_INTEGER" maxlength="4">,
                        <cfqueryparam value="#Form.react_yn#" cfsqltype="CF_SQL_CHAR" maxlength="1">,
                        
                        <cfqueryparam value="#request.pdfFileName#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
                        <cfqueryparam value="#system#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
                        <cfqueryparam value="#request.Today#" cfsqltype="CF_SQL_TIMESTAMP">
                        )
                </cfquery>	
            </cfif>
            
			<!--- save certificate created --->
            <cfquery name="saveCertificateCreated" datasource="#datasource#" result="cert_count">
                insert into icwi_certificates_created
                    (
                    certificate_branch_id, certificate_src_type, certificate_src_id, certificate_number, certificate_type, 
                        certificate_sequence, certificate_cover, 
                        cert_id, client_number, policy_number, item_number, risk_item_number, scheme_id, renewal_month_year, 
                            vehicle_make_model_type, vehicle_registration, vehicle_chassis_number, vehicle_body_type,
                                    policy_holders_name1, policy_holders_name2, annual_prem, amt_due, late_fee, facility_fee, stamp_duty, tax,
                        				reinstated, vehicle_inspected, inspected_by, no_damage, no_loss_dec_signed, 
                                            effective_from, effective_to, 
                                                payment_plan, premium_period, narrative5, narrative6, 
                                                    date_of_issue, user_id, react_yn, pdf_file_name, system, cr_stamp 
                    )
                values
                    (
                <cfif IsNumeric(request.sbranchId)>
                    <cfqueryparam value="#request.sbranchId#" cfsqltype="CF_SQL_INTEGER" maxlength="4">,
                    null,
                    null,
                <cfelse>
                    null,
                    <cfqueryparam value="#request.ssrcType#" cfsqltype="CF_SQL_CHAR" maxlength="2">,
                    <cfqueryparam value="#request.ssrcId#" cfsqltype="CF_SQL_CHAR" maxlength="3">,
                </cfif>
                    <cfqueryparam value="#request.certificateNumberII#" cfsqltype="CF_SQL_INTEGER" maxlength="7">,
                    <cfqueryparam value="#request.certificate_type#" cfsqltype="CF_SQL_CHAR" maxlength="2">,
                    <cfqueryparam value="#request.certificate_sequence#" cfsqltype="CF_SQL_CHAR" maxlength="2">,
                    <cfqueryparam value="#Form.certificate_cover#" cfsqltype="CF_SQL_CHAR" maxlength="2">,
            
                    <cfqueryparam value="#Form.cert_id#" cfsqltype="CF_SQL_VARCHAR" maxlength="8">,
                    <cfqueryparam value="#Form.client_number#" cfsqltype="CF_SQL_VARCHAR" maxlength="9">,
                    <cfqueryparam value="#Form.policy_number#" cfsqltype="CF_SQL_INTEGER" maxlength="9">,
                    <cfqueryparam value="#item_number#" cfsqltype="CF_SQL_INTEGER" maxlength="4">,
                    <cfqueryparam value="#VAL(risk_item_number)#" cfsqltype="CF_SQL_INTEGER" maxlength="10">,
                    <cfqueryparam value="#Form.scheme_id#" cfsqltype="CF_SQL_CHAR" maxlength="3">,
                    <cfqueryparam value="#Form.renewal_month_year#" cfsqltype="CF_SQL_CHAR" maxlength="4">,
                    
                    <cfqueryparam value="#veh_makeII#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
                    <cfqueryparam value="#veh_regII#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
                    <cfqueryparam value="#veh_chassisII#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
                    <cfqueryparam value="#veh_bodyII#" cfsqltype="CF_SQL_VARCHAR" maxlength="30">,
            
                    <cfqueryparam value="#Form.policy_holders_name1#" cfsqltype="CF_SQL_VARCHAR" maxlength="60">,
                    <cfqueryparam value="#Form.policy_holders_name2#" cfsqltype="CF_SQL_VARCHAR" maxlength="60">,
                    <cfqueryparam value="#annual_premII#" cfsqltype="CF_SQL_MONEY" maxlength="12">,
                    <cfqueryparam value="#amt_dueII#" cfsqltype="CF_SQL_MONEY" maxlength="12">,
                    <cfqueryparam value="#late_feeII#" cfsqltype="CF_SQL_MONEY" maxlength="12">,
                    <cfqueryparam value="#facility_feeII#" cfsqltype="CF_SQL_MONEY" maxlength="12">,
                    <cfqueryparam value="#stamp_dutyII#" cfsqltype="CF_SQL_MONEY" maxlength="12">,
                    <cfqueryparam value="#taxII#" cfsqltype="CF_SQL_MONEY" maxlength="12">,
            
                    <cfqueryparam value="#Form.reinstate#" cfsqltype="CF_SQL_CHAR" maxlength="1">,
                    <cfqueryparam value="#Form.vehicle_inspected#" cfsqltype="CF_SQL_CHAR" maxlength="1">,
                    <cfqueryparam value="#Form.inspected_by#" cfsqltype="CF_SQL_VARCHAR" maxlength="30">,
                    <cfqueryparam value="#Form.no_damage#" cfsqltype="CF_SQL_CHAR" maxlength="1">,
                    <cfqueryparam value="#Form.no_loss_dec_signed#" cfsqltype="CF_SQL_CHAR" maxlength="1">,
                    
                    <cfqueryparam value="#request.effectiveFromDate#" cfsqltype="CF_SQL_TIMESTAMP">,
                    <cfqueryparam value="#request.effectiveToDate#" cfsqltype="CF_SQL_TIMESTAMP">,
            
                    <cfqueryparam value="#Form.payment_plan#" cfsqltype="CF_SQL_INTEGER" maxlength="4">,
                    <cfqueryparam value="#Form.premium_period#" cfsqltype="CF_SQL_CHAR" maxlength="1">,
                    
                    <cfqueryparam value="#narr5II#" cfsqltype="CF_SQL_VARCHAR" maxlength="4000">,
                    <cfqueryparam value="#narr6II#" cfsqltype="CF_SQL_VARCHAR" maxlength="4000">,
                    
                    <cfqueryparam value="#request.Today#" cfsqltype="CF_SQL_TIMESTAMP">,
                    <cfqueryparam value="#request.userId#" cfsqltype="CF_SQL_INTEGER" maxlength="4">,
                    <cfqueryparam value="#Form.react_yn#" cfsqltype="CF_SQL_CHAR" maxlength="1">,
                    
                    <cfqueryparam value="#request.pdfFileName#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
                    <cfqueryparam value="#system#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
                    <cfqueryparam value="#request.Today#" cfsqltype="CF_SQL_TIMESTAMP">
                    )
            </cfquery>
            
            <!--- get last created_sequence_number --->
            <cfquery name="getCreatedSequenceNumber" datasource="#datasource#">
                select LAST_INSERT_ID() as nextID
            </cfquery>	
            
            <!--- save certificate details --->
            <!--- <cfset request.certificateNextIssuedID = getIssuedSequenceNumber.nextID> --->
            <cfset request.certificateNextCreatedID = getCreatedSequenceNumber.nextID>
            
            <cfset "cert_ids_#item_number#" = request.certificateNumberII>
            <!--- <cfset "cert_next_issued_#item_number#" = request.certificateNextIssuedID> --->
            <cfset "cert_next_created_#item_number#" = request.certificateNextCreatedID>
            
    <!--- build pdf individual pdfs--->
    <cfpdfform action="populate" source="#Trim(pdfPath)##Trim(getPdfTemplates.certificate_file_name)#" destination="#Trim(certificatePdfPath)##Trim(request.pdfFileNameII)#">
        <cfpdfsubform name="cert_code">
            <cfpdfformparam name="cert_code" value="#Trim(Form.cert_code)#">
            <cfpdfformparam name="cert_no" value="#Trim(request.nextCertificateNumberStringII)#">
            <cfpdfformparam name="policy_no" value="#Trim(request.PolicyNumberStringII)#">
            <cfpdfformparam name="vehicle_make_model_type" value="#veh_makeII#">
            <!--- Removed for testing --->
            <!------>
            <cfpdfformparam name="vehicle_registration" value="Registration: #veh_regII#">
            <cfpdfformparam name="vehicle_chassis_number" value="Chassis: #veh_chassisII#">
			
            <cfpdfformparam name="vehicle_body_type" value="Type of Body: #veh_bodyII#">
            <!--- Removed for testing --->
            <!------>
            <cfpdfformparam name="policy_holders_name1" value="#Trim(Form.policy_holders_name1)#">
            <cfpdfformparam name="policy_holders_name2" value="#Trim(Form.policy_holders_name2)#">
			
            <cfset effective = #effective_from#> 
            <cfset today = #DateFormat(request.date, "dd-mm-yyyy")#> 
            <cfset time = #TimeFormat(request.date, 'hh:mm tt')#> 
            <!--- <cfif datecompare(effective, today, "d") eq 0> --->
            <cfif Form.payment_plan eq 1>
				<cfif daysLapsed gte 0>
                    <cfpdfformparam name="effective_from" value="#Trim(request.effectiveFromDateString)# at #time#">
                <cfelse>
                    <cfpdfformparam name="effective_from" value="#Trim(request.effectiveFromDateString)# at 12:01 AM">
                </cfif>
            <cfelse>
            	<cfif daysLapsed gt 0>
                    <cfpdfformparam name="effective_from" value="#Trim(request.effectiveFromDateString)# at #time#">
                <cfelse>
                    <cfpdfformparam name="effective_from" value="#Trim(request.effectiveFromDateString)# at 12:01 AM">
                </cfif>
            </cfif>    
            <cfpdfformparam name="effective_to" value="#Trim(request.effectiveToDateString)# at 11:59 PM">
            <cfpdfformparam name="period_descr" value="#Trim(Form.period_descr)#">
            <cfpdfformparam name="narrative5" value="#narr5II#">
            <cfpdfformparam name="narrative6" value="#narr6II#">
            <cfpdfformparam name="issued_date" value="#Trim(request.issuedDateString)#">
            <cfif IsNumeric(request.sbranchId)>
                <cfpdfformparam name="branch_name" value="Serviced By: #Trim(getBranchInfo.branch_name)# Branch">
            <cfelse>
                <cfpdfformparam name="branch_name" value="Serviced By: #Trim(getBrokerInfo.src_name)#">
            </cfif>
    
            <cfpdfformparam name="initials" value="#Trim(initialsStr)#">
            <cfpdfformparam name="react" value="#Trim(react)#">
        </cfpdfsubform>
    </cfpdfform> 
        </cfloop>
    </cfif> 
    <!--- Combine PDFs ---> 
    <cfpdf action="merge" destination="#Trim(certificatePdfPath)##Trim(request.pdfFileName)#" overwrite="yes">
        <cfif StructKeyExists(Form,"item_no")>
            <cfloop list = "#Form.item_no#" index = "item_number">
                <!--- Build individual file names--->
                <cfset request.pdfFileNameII =  'CERT_' & Form.policy_number & DateFormat(request.Today,'yyyymmdd') & TimeFormat(request.Today,'HHmmss') & '_' & item_number & '.pdf'>
            
                <!--- Loop individual files--->
                <cfpdfparam source="#Trim(certificatePdfPath)##Trim(request.pdfFileNameII)#">
            </cfloop>
        </cfif>
    </cfpdf>
    <!--- 
    <cfif StructKeyExists(Form,"item_no")>
        <cfloop list = "#Form.item_no#" index = "item_number">
            <!--- Build individual file names--->
            <cfset request.pdfFileNameIII =  'CERT_' & Form.policy_number & DateFormat(request.Today,'yyyymmdd') & TimeFormat(request.Today,'HHmmss') & '_' & item_number & '.pdf'>
            
            <!--- Delete files --->
           <cffile action="delete" file="#Trim(certificatePdfPath)##Trim(request.pdfFileNameIII)#" >
        </cfloop>
    </cfif>
	--->
<cfelse>
	<!--- build pdf --->
    <cfpdfform action="populate" source="#Trim(pdfPath)##Trim(getPdfTemplates.certificate_file_name)#" destination="#Trim(certificatePdfPath)##Trim(request.pdfFileName)#" overwrite="yes">
        <cfpdfsubform name="cert_code">
            <cfpdfformparam name="cert_code" value="#Trim(Form.cert_code)#">
            <cfpdfformparam name="cert_no" value="#Trim(request.nextCertificateNumberString)#">
            <cfpdfformparam name="policy_no" value="#Trim(request.PolicyNumberString)#">
            <cfpdfformparam name="vehicle_make_model_type" value="#Trim(Form.vehicle_make_model_type)#">
            <!--- Removed for testing --->
            <!------>
            <cfpdfformparam name="vehicle_registration" value="Registration: #Trim(Form.vehicle_registration)#">
            <cfpdfformparam name="vehicle_chassis_number" value="Chassis: #Trim(Form.vehicle_chassis_number)#">
			
            <cfpdfformparam name="vehicle_body_type" value="Type of Body: #Trim(Form.vehicle_body_type)#">
            <!--- Removed for testing --->
            <!------>
            <cfpdfformparam name="policy_holders_name1" value="#Trim(Form.policy_holders_name1)#">
            <cfpdfformparam name="policy_holders_name2" value="#Trim(Form.policy_holders_name2)#">
			
            <cfset effective = #effective_from#> 
            <cfset today = #DateFormat(request.date, "dd-mm-yyyy")#> 
            <cfset time = #TimeFormat(request.date, 'hh:mm tt')#> 
            <!--- <cfif datecompare(effective, today, "d") eq 0> --->
            <cfif Form.payment_plan eq 1>
				<cfif daysLapsed gte 0>
                    <cfpdfformparam name="effective_from" value="#Trim(request.effectiveFromDateString)# at #time#">
                <cfelse>
                    <cfpdfformparam name="effective_from" value="#Trim(request.effectiveFromDateString)# at 12:01 AM">
                </cfif>
            <cfelse>
            	<cfif daysLapsed gt 0>
                    <cfpdfformparam name="effective_from" value="#Trim(request.effectiveFromDateString)# at #time#">
                <cfelse>
                    <cfpdfformparam name="effective_from" value="#Trim(request.effectiveFromDateString)# at 12:01 AM">
                </cfif>
            </cfif>
            <cfpdfformparam name="effective_to" value="#Trim(request.effectiveToDateString)# at 11:59 PM">
            <cfpdfformparam name="period_descr" value="#Trim(Form.period_descr)#">
            <cfpdfformparam name="narrative5" value="#Trim(Form.narrative5)#">
            <cfpdfformparam name="narrative6" value="#Trim(Form.narrative6)#">
            <cfpdfformparam name="issued_date" value="#Trim(request.issuedDateString)#">
            <cfif IsNumeric(request.sbranchId)>
                <cfpdfformparam name="branch_name" value="Serviced By: #Trim(getBranchInfo.branch_name)# Branch">
            <cfelse>
                <cfpdfformparam name="branch_name" value="Serviced By: #Trim(getBrokerInfo.src_name)#">
            </cfif>
            <cfpdfformparam name="initials" value="#Trim(initialsStr)#">
            <cfpdfformparam name="react" value="#Trim(react)#">
        </cfpdfsubform>
    </cfpdfform> 
    
</cfif>   

<cfelse>
	<cfset certificatePath = "">
    <cfset request.pdfFileName = "">
</cfif>