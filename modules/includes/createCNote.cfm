<!---
	Cold Fusion Template: 
	Author:			Omari K. Bogle
	Date:			17-06-2015
	Modified:		

	Description:	This CF Template creates cover note based on supplied information
	
	Parameters:		cover_note_type, srcId, date_of_issue, insureds_name, address1, address2,
						policy_number, item_number, effective_from, effective_days, effective_to, make_model_type, year_of_man, 
							hp_cc, seating, estimated_value, reg_number, type_of_policy, class_of_policy, 
								type_of_cover, uses, alterations
	
// --->

<!--- form values required from Alyssa ---> 
<cfset Form.policy_number = "#Arguments.policy_number#">
<cfset Form.rnwl_mth = "">
<!--- <cfset request.Today = DateFormat(NOW(),"yyyy-mm-dd") & ' ' & TimeFormat(NOW(),'HH:mm:ss')> --->
<cfset request.Today = #getDateTime.datetime#>

<!--- defaults policy query --->
<cfquery name="getSelectedItemForRenewalCN" datasource="#datasourceII#">
    SELECT '' AS branch_id, '' AS branch_name, pp.src_type, pp.src_id, sn.src_name,  
    c.clnt_no, c.clnt_type, c.occupation, ca.addr_no, ca.addr_line_1, ca.addr_line_2, 
    ca.addr_city, pp.clnt_name AS name_mail, pp.plcy_no, GROUP_CONCAT(pp.item_no) AS item_no, GROUP_CONCAT(pi.risk_item_no) AS risk_item_no, pp.scheme_id, 
    DATE(pp.next_debit_date) AS rnwl_dt_time, pp.exp_debit_date AS effective_to, pp.pymt_plan AS prem_period, pp.period_no AS pymt_plan, 
    rn.cert_code, pi.cert_id, pi.react_yn, COUNT(*) AS total_risks, p.currency_id,
    GROUP_CONCAT(CONCAT(pi.yr_of_mfe,' ',pi.make,' ',pi.model)) AS vehicle_make_model_type,
    GROUP_CONCAT(pi.yr_of_mfe) AS vehicle_year_of_man,
    GROUP_CONCAT(pi.make) AS vehicle_make, 
    GROUP_CONCAT(pi.model) AS vehicle_model, 
    GROUP_CONCAT(pi.reg_no) AS vehicle_registration,
    GROUP_CONCAT(pi.chassis_no) AS vehicle_chassis_number,
    GROUP_CONCAT(pi.cc_hp) AS vehicle_hp_cc,
    GROUP_CONCAT(bt.body_descr) AS vehicle_body_type,
    GROUP_CONCAT(pi.seating_cap) AS vehicle_seating,
    GROUP_CONCAT(pi.colour) AS vehicle_colour,
    GROUP_CONCAT(rn.narrative5) AS narrative5,
    GROUP_CONCAT(rn.narrative6) AS narrative6,
    GROUP_CONCAT(pp.annual_net_prem) AS premium, 
    GROUP_CONCAT(pp.si_amt) AS si_amt, 
    pi.open_or_restr AS type_of_policy, sc.sub_class_descr AS form_of_policy, mc.cover_descr, usage_name, sn.country_id,
    pp.period_descr, pp.next_debit_period AS rnwl_mth
    FROM crm_payment_plans AS pp
    LEFT OUTER JOIN crm_plcy_item AS pi ON pp.plcy_no = pi.plcy_no AND pp.item_no = pi.item_no
    LEFT OUTER JOIN crm_body_types AS bt ON pi.body_type = bt.body_type
    LEFT OUTER JOIN crm_motor_cover AS mc ON pi.cover = mc.cover
    LEFT OUTER JOIN crm_rnwl_narratives AS rn ON pp.plcy_no = rn.plcy_no AND pp.item_no = rn.item_no
    LEFT OUTER JOIN crm_policy AS p ON pp.plcy_no = p.plcy_no
    LEFT OUTER JOIN crm_sub_class_names sc ON p.class_id = sc.class_id AND p.sub_class_id = sc.sub_class_id
    LEFT OUTER JOIN crm_usage u ON pi.usages = u.usage_id
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
			    LEFT OUTER JOIN crm_policy AS p ON pp.plcy_no = p.plcy_no
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

<!---Secondary query --->
<cfif getSelectedItemForRenewalCN.recordcount eq 0>
    <cfquery name="getSelectedItemForRenewalCN" datasource="#datasourceII#">
        SELECT '' AS branch_id, '' AS branch_name, ro.src_type, ro.src_id, sn.src_name,  
        c.clnt_no, c.clnt_type, c.occupation, ca.addr_no, ca.addr_line_1, ca.addr_line_2, 
        ca.addr_city, ro.name_mail, ro.plcy_no, GROUP_CONCAT(ri.item_no) AS item_no, GROUP_CONCAT(pi.risk_item_no) AS risk_item_no, ro.scheme_id, 
        DATE(ro.rnwl_dt_time) AS rnwl_dt_time, '' AS effective_to, ro.prem_period, 1 AS pymt_plan, 
        rn.cert_code, pi.cert_id, pi.react_yn, COUNT(*) AS total_risks, p.currency_id,
        GROUP_CONCAT(CONCAT(pi.yr_of_mfe,' ',pi.make,' ',pi.model)) AS vehicle_make_model_type,
        GROUP_CONCAT(pi.yr_of_mfe) AS vehicle_year_of_man,
        GROUP_CONCAT(pi.make) AS vehicle_make, 
        GROUP_CONCAT(pi.model) AS vehicle_model, 
        GROUP_CONCAT(pi.reg_no) AS vehicle_registration,
        GROUP_CONCAT(pi.chassis_no) AS vehicle_chassis_number,
        GROUP_CONCAT(pi.cc_hp) AS vehicle_hp_cc,
        GROUP_CONCAT(bt.body_descr) AS vehicle_body_type,
        GROUP_CONCAT(pi.seating_cap) AS vehicle_seating,
        GROUP_CONCAT(pi.colour) AS vehicle_colour,
        GROUP_CONCAT(rn.narrative5) AS narrative5,
        GROUP_CONCAT(rn.narrative6) AS narrative6,
        GROUP_CONCAT(ri.annual_net_prem) AS premium, 
        GROUP_CONCAT(ri.si_amt) AS si_amt, 
        pi.open_or_restr AS type_of_policy, sc.sub_class_descr AS form_of_policy, mc.cover_descr, usage_name, sn.country_id,
        ppt.pterm_desc as period_descr, ro.rnwl_mth
        FROM crm_renewal_offer AS ro
        INNER JOIN crm_rnwl_item AS ri ON ro.rnwl_mth = ri.rnwl_mth AND ro.plcy_no = ri.plcy_no
        LEFT OUTER JOIN crm_plcy_item AS pi ON ri.plcy_no = pi.plcy_no AND ri.item_no = pi.item_no
        LEFT OUTER JOIN crm_body_types AS bt ON pi.body_type = bt.body_type
        LEFT OUTER JOIN crm_motor_cover AS mc ON pi.cover = mc.cover
        LEFT OUTER JOIN crm_rnwl_narratives AS rn ON ri.plcy_no = rn.plcy_no AND ri.item_no = rn.item_no
        LEFT OUTER JOIN crm_policy AS p ON ro.plcy_no = p.plcy_no
        LEFT OUTER JOIN crm_sub_class_names sc ON p.class_id = sc.class_id AND p.sub_class_id = sc.sub_class_id
        LEFT OUTER JOIN crm_usage u ON pi.usages = u.usage_id
        LEFT OUTER JOIN crm_client_addr AS ca ON p.clnt_no = ca.clnt_no AND p.addr_no = ca.addr_no
        LEFT OUTER JOIN crm_client AS c ON ro.clnt_no = c.clnt_no
        INNER JOIN crm_source_names AS sn ON ro.src_type = sn.src_type AND ro.src_id = sn.src_id
        LEFT JOIN rating_engine.territory AS t ON sn.country_id = t.territory_code
        LEFT OUTER JOIN rating_engine.payment_plan AS pp ON ro.prem_period = pp.paymentplan_code AND ro.src_type = pp.src_type AND pp.territory_id = t.territory_id AND pi.cover = cover_code
    	LEFT OUTER JOIN rating_engine.payment_plan_terms AS ppt ON pp.paymentplan_id = ppt.paymentplan_id AND ppt.pterm_pos = 1
        LEFT JOIN icwi_broker.icwi_cover_notes_issued AS cn ON ri.plcy_no = cn.policy_number AND ri.item_no = cn.item_number AND ri.rnwl_mth = CONCAT(LEFT(RIGHT(cn.cr_stamp,14),2),LEFT(RIGHT(cn.cr_stamp,17),2))
        LEFT JOIN icwi_broker.icwi_certificates_issued AS ct ON ri.plcy_no = ct.policy_number AND ri.item_no = ct.item_number AND ri.rnwl_mth = ct.renewal_month_year
        WHERE ro.src_type IN ('DR','AT')
        <!--- AND ppt.pterm_pos = 1 --->
    	<!--- AND pp.territory_id = 4 --->
        AND ct.policy_number IS NULL
        AND ro.plcy_no = #Form.policy_number#
        GROUP BY ri.plcy_no, ri.rnwl_mth
        ORDER BY ri.plcy_no, ri.item_no
    </cfquery>
</cfif>   

<!--- delete already created cnote ---> 
<cfif getSelectedItemForRenewalCN.recordcount gt 0>
    <cfquery name="deletePreviouslyRenewed" datasource="#datasource#">
    	<!--- DELETE FROM icwi_cover_notes_created WHERE policy_number = #Form.policy_number# AND DATE(NOW()) BETWEEN DATE(effective_from) AND DATE(effective_to) --->
        DELETE FROM icwi_cover_notes_created WHERE policy_number = #Form.policy_number# AND renewal_month_year = '#getSelectedItemForRenewalCN.rnwl_mth#'
    </cfquery>
</cfif>

<!--- Assign effective to date if policy not payment plan extension --->
<!--- <cfif DateCompare( getSelectedItemForRenewalCN.rnwl_dt_time, Now() ) lt 0> --->
<cfset todays_date = DateFormat(request.Today,"yyyy-mm-dd")>
<cfif getSelectedItemForRenewalCN.pymt_plan eq 1>
	<cfset daysLapsed = DateDiff('d', getSelectedItemForRenewalCN.rnwl_dt_time, todays_date)-1> 
<cfelse>
	<cfset daysLapsed = DateDiff('d', getSelectedItemForRenewalCN.rnwl_dt_time, todays_date)>
</cfif>   

<cfif getSelectedItemForRenewalCN.pymt_plan eq 1>
	<cfif daysLapsed gte 0>
        <cfset effective_from = DateFormat(request.Today,"dd-mm-yyyy") & ' ' & TimeFormat(request.Today,'HH:mm')>
    <cfelse>
        <cfset effective_from = DateFormat(getSelectedItemForRenewalCN.rnwl_dt_time+1,"dd-mm-yyyy") & ' 00:01'>
    </cfif> 
<cfelse>
	<cfif daysLapsed gt 0>
        <cfset effective_from = DateFormat(request.Today,"dd-mm-yyyy") & ' ' & TimeFormat(request.Today),'HH:mm')>
    <cfelse>
        <cfset effective_from = DateFormat(getSelectedItemForRenewalCN.rnwl_dt_time,"dd-mm-yyyy") & ' 00:01'>
    </cfif> 
</cfif>

<!--- Fetch alteration text for cover notes --->
<cfquery name="checkAlteration" datasource="#datasource#">            
    SELECT GROUP_CONCAT(outstanding_code) AS outstanding_codes, GROUP_CONCAT(cn_alteration) AS alterations, MAX(cn_days) AS cn_days
    FROM icwi_items_outstanding i
    INNER JOIN icwi_outstanding_name o ON i.outstanding_id = o.outstanding_id
    INNER JOIN icwi_outstanding_category_name c ON o.category_id = c.category_id
    INNER JOIN icwi_renewal_granted r ON i.renewal_id = r.renewal_id
    WHERE i.outstanding_yn = 'Y'
    <!--- AND i.tmp_outstanding_yn IN ('N','P') --->
    AND cn_alteration IS NOT NULL
    AND policy_number = #Form.policy_number#
    AND renewal_month_year = #getSelectedItemForRenewalCN.rnwl_mth#
    AND r.system = '#system#'
    ORDER BY o.outstanding_id   
</cfquery>

<!--- setup defaults ---> 

<cfif IsDefined(checkAlteration.cn_days)>
	<cfset effective_days = #checkAlteration.cn_days#>
<cfelse>
	<cfset effective_days = 15>
</cfif>    

<!--- Compare effec time from locks agains cover remainding --->
<cfif getSelectedItemForRenewalCN.pymt_plan gt 1>
	<cfset daysOfCoverRemaining = DateDiff('d', todays_date, getSelectedItemForRenewalCN.effective_to)>
    <cfif daysOfCoverRemaining lt effective_days>
        <cfset effective_days = #daysOfCoverRemaining#>
    </cfif>
</cfif>

<cfparam name="Form.vehicle_make_model_type" default="#getSelectedItemForRenewalCN.vehicle_make_model_type#">
<cfparam name="Form.vehicle_year_of_man" default="#getSelectedItemForRenewalCN.vehicle_year_of_man#">
<cfparam name="Form.vehicle_make" default="#getSelectedItemForRenewalCN.vehicle_make#">
<cfparam name="Form.vehicle_model" default="#getSelectedItemForRenewalCN.vehicle_model#">
<cfparam name="Form.vehicle_registration" default="#getSelectedItemForRenewalCN.vehicle_registration#">
<cfparam name="Form.vehicle_chassis_number" default="#getSelectedItemForRenewalCN.vehicle_chassis_number#">
<cfparam name="Form.vehicle_hp_cc" default="#getSelectedItemForRenewalCN.vehicle_hp_cc#">
<cfparam name="Form.vehicle_body_type" default="#getSelectedItemForRenewalCN.vehicle_body_type#">
<cfparam name="Form.vehicle_seating" default="#getSelectedItemForRenewalCN.vehicle_seating#">
<cfparam name="Form.vehicle_colour" default="#getSelectedItemForRenewalCN.vehicle_colour#">
<cfparam name="Form.narrative5" default="#getSelectedItemForRenewalCN.narrative5#">
<cfparam name="Form.annual_premium" default="#getSelectedItemForRenewalCN.premium#">
<cfparam name="Form.vehicle_estimated_value" default="#getSelectedItemForRenewalCN.si_amt#">


<cfparam name="Form.item_number" default="#getSelectedItemForRenewalCN.item_no#">
<cfparam name="Form.client_number" default="#getSelectedItemForRenewalCN.clnt_no#">
<cfparam name="Form.client_type" default="#getSelectedItemForRenewalCN.clnt_type#">
<cfparam name="Form.insureds_name" default="#getSelectedItemForRenewalCN.name_mail#">
<cfparam name="Form.cover_note_type" default="RN">
<cfparam name="Form.renewal_month_year" default="#getSelectedItemForRenewalCN.rnwl_mth#">
<cfparam name="Form.currency" default="#getSelectedItemForRenewalCN.currency_id#">

<cfparam name="Form.scheme_id" default="#getSelectedItemForRenewalCN.scheme_id#">

<cfparam name="Form.type_of_policy" default="#getSelectedItemForRenewalCN.type_of_policy#">
<cfparam name="Form.class_of_policy" default="#getSelectedItemForRenewalCN.form_of_policy#">
<cfparam name="Form.type_of_cover" default="#getSelectedItemForRenewalCN.cover_descr#">
<!--- <cfparam name="Form.uses" default="#getSelectedItemForRenewalCN.usage_name#"> ---> <!--- Requested by MM; On 2015-10-22 --->
<cfparam name="Form.uses" default="#Trim(getSelectedItemForRenewalCN.narrative6)#">
<cfparam name="Form.country_code" default="#getSelectedItemForRenewalCN.country_id#">
<cfparam name="Form.period_descr" default="#getSelectedItemForRenewalCN.period_descr#">

<cfloop list = "#Form.item_number#" index = "item_number">
	<cfset "Form.risk_item_no_#item_number#" = ListGetAt(getSelectedItemForRenewalCN.risk_item_no,#item_number#)>
    <cfset "Form.vehicle_make_model_type_#item_number#" = ListGetAt(getSelectedItemForRenewalCN.vehicle_make_model_type,#item_number#,",","yes")>
    <cfset "Form.vehicle_year_of_man_#item_number#" = ListGetAt(getSelectedItemForRenewalCN.vehicle_year_of_man,#item_number#,",","yes")>
    <cfset "Form.vehicle_make_#item_number#" = ListGetAt(getSelectedItemForRenewalCN.vehicle_make,#item_number#,",","yes")>
    <cfset "Form.vehicle_model_#item_number#" = ListGetAt(getSelectedItemForRenewalCN.vehicle_model,#item_number#)>
	<cfset "Form.vehicle_registration_#item_number#" = ListGetAt(getSelectedItemForRenewalCN.vehicle_registration,#item_number#)>
    <cfset "Form.vehicle_chassis_number_#item_number#" = ListGetAt(getSelectedItemForRenewalCN.vehicle_chassis_number,#item_number#)>
    <cfif getSelectedItemForRenewalCN.vehicle_hp_cc is not ''>
		<cfset "Form.vehicle_hp_cc_#item_number#" = ListGetAt(getSelectedItemForRenewalCN.vehicle_hp_cc,#item_number#,",","yes")>
    <cfelse>
    	<cfset "Form.vehicle_hp_cc_#item_number#" = "">
    </cfif>
	<cfif getSelectedItemForRenewalCN.vehicle_body_type is not ''>
		<cfset "Form.vehicle_body_type_#item_number#" = ListGetAt(getSelectedItemForRenewalCN.vehicle_body_type,#item_number#,",","yes")>
    <cfelse>
    	<cfset "Form.vehicle_body_type_#item_number#" = "">
    </cfif>	
    <cfif getSelectedItemForRenewalCN.vehicle_seating is not ''>
		<cfset "Form.vehicle_seating_#item_number#" = ListGetAt(getSelectedItemForRenewalCN.vehicle_seating,#item_number#,",","yes")>
    <cfelse>
    	<cfset "Form.vehicle_seating_#item_number#" = "">
    </cfif>
	<cfif getSelectedItemForRenewalCN.vehicle_colour is not ''>
		<cfset "Form.vehicle_colour_#item_number#" = ListGetAt(getSelectedItemForRenewalCN.vehicle_colour,#item_number#)>
    <cfelse>
    	<cfset "Form.vehicle_colour_#item_number#" = "">
    </cfif>    
    <cfset "Form.narrative5_#item_number#" = ListGetAt(getSelectedItemForRenewalCN.narrative5,#item_number#)>
    <cfset "Form.annual_prem_#item_number#" = ListGetAt(getSelectedItemForRenewalCN.premium,#item_number#)>
    <cfset "Form.si_amt_#item_number#" = ListGetAt(getSelectedItemForRenewalCN.si_amt,#item_number#)>
</cfloop>

<!--- Cover note --->
<cfset covernotePdfPath = "/home/CFApplications/Broker/PDFs/CoverNotes/">
<cfset covernotePath = "../../../../../home/CFApplications/Broker/PDFs/CoverNotes/">
<cfset pdfPath = "/home/CFApplications/Broker/CoverNotes/">
<cfset cnoteUrlPath = "//ebrokertest.icwi.local/Broker/PDFs/CoverNotes/">

<!--- Assign alteration --->
<cfif IsDefined("checkAlteration.alterations")>
	<cfset Form.alterations = Replace(checkAlteration.alterations,",",", ","All")>
    <!---
    <cfif ListContains(checkAlteration.outstanding_codes,"POCA") gt 0>
   		<cfset Form.alterations =  Form.alterations & ', PENDING PROOF OF ADDRESS'>
    </cfif>
	--->
<cfelse>
	<cfset Form.alterations = "">    
</cfif> 

<cfset Form.comments = "">

<!--- Define Address 1 & 2 --->
<cfset Form.address1 = "">
<cfset Form.address2 = getSelectedItemForRenewalCN.addr_city>

<cfif getSelectedItemForRenewalCN.addr_line_1 is not "">
	<cfset Form.address1 = getSelectedItemForRenewalCN.addr_line_1>
<cfelseif getSelectedItemForRenewalCN.addr_line_1 is not "" and getSelectedItemForRenewalCN.addr_line_2 is not "">
	<cfset Form.address1 = Form.address1 & ", " & getSelectedItemForRenewalCN.addr_line_1>
<cfelse>
	<cfset Form.address1 = getSelectedItemForRenewalCN.addr_line_2>    
</cfif>

<cfset request.sbranchId = "">
<!--- <cfset request.ssrcId = getSelectedItemForRenewalCN.src_id> --->
<!--- <cfset request.ssrcType = getSelectedItemForRenewalCN.src_type> --->
<cfset request.ssrcId = "999">
<cfset request.ssrcType = "DR">


<cfif system is 'Kiosk'>
	<cfset request.userId = 618>
    <cfset request.usersFullName = "Kiosk System">
<!--- <cfelseif system is 'eCient'> --->
<cfelse>
	<cfset request.userId = 777>
    <cfset request.usersFullName = "Click&Go System">
</cfif>

<!--- Define number naming --->
<cfset numberList = "one,two,three,four,five,six,seven,eight,nine,ten," & 
		"eleven,twelve,thirteen,fourteen,fifteen,sixteen,seventeen,eighteen,nineteen,twenty," & 
		"twenty one,twenty two,twenty three,twenty four,twenty five,twenty six,twenty seven,twenty eight,twenty nine,thirty," &
		"thirty one,thirty two,thirty three,thirty four,thirty five,thirty six,thirty seven,thirty eight,thirty nine,forty," &
		"forty one,forty two,forty three,forty four,forty five,forty six,forty seven,forty eight,forty nine,fifty," &
		"fifty one,fifty two,fifty three,fifty four,fifty five,fifty six,fifty seven,fifty eight,fifty nine,sixty," &
		"sixty one,sixty two,sixty three,sixty four,sixty five,sixty six,sixty seven,sixty eight,sixty nine,seventy," &
		"seventy one,seventy two,seventy three,seventy four,seventy five,seventy six,seventy seven,seventy eight,seventy nine,eighty," &
		"eighty one,eighty two,eighty three,eighty four,eighty five,eighty six,eighty seven,eighty eight,eighty nine,ninety">
<cfset numbersList = "first,second,third,fourth,fivth,sixth,seventh,eightth,nineth,tenth," & 
		"eleventh,twelveth,thirteenth,fourteenth,fifteenth,sixteenth,seventeenth,eighteenth,nineteenth,twentyth," & 
		"twenty first,twenty second,twenty third,twenty fourth,twenty fiveth,twenty sixth,twenty seventh,twenty eightth,twenty nineth,thirtieth," &
		"thirty first,thirty second,thirty third,thirty fourth,thirty fiveth,thirty sixth,thirty seventh,thirty eightth,thirty nineth,fortieth," & 
		"forty first,forty second,forty third,forty fourth,forty fiveth,forty sixth,forty seventh,forty eightth,forty nineth,fiftieth," & 
		"fifty first,fifty second,fifty third,fifty fourth,fifty fiveth,fifty sixth,fifty seventh,fifty eightth,fifty nineth,sixtieth," & 
		"sixty first,sixty second,sixty third,sixty fourth,sixty fiveth,sixty sixth,sixty seventh,sixty eightth,sixty nineth,seventieth," & 
		"seventy first,seventy second,seventy third,seventy fourth,seventy fiveth,seventy sixth,seventy seventh,seventy eightth,seventy nineth,eightieth," & 
		"eighty first,eighty second,eighty third,eighty fourth,eighty fiveth,eighty sixth,eighty seventh,eighty eightth,eighty nineth,ninetieth">
		
<!--- build period message --->		
<cfif effective_days eq 1>
	<cfset request.periodMessage = "for " & ListGetAt(numberList,effective_days) & 
		" day, that is to say from the above stated time and date to the same time on the "
		& ListGetAt(numbersList,effective_days) & " day after such date.">
<cfelseif effective_days eq 365>
	<cfset request.periodMessage = "">        
<cfelse>
	<cfset request.periodMessage = "for " & ListGetAt(numberList,effective_days) & 
		" days, that is to say from the above stated time and date to the same time on the "
		& ListGetAt(numbersList,effective_days) & " day after such date.">
</cfif>

<!--- build restrictions message --->
<cfset request.restrictionsMessage = Trim(getSelectedItemForRenewalCN.narrative5)>  

<!--- calculate effective from date ---> 
<cfset request.effectiveFromDate = Mid(effective_from,7,4) & '-' & Mid(effective_from,4,2) & '-' & Left(effective_from,2) & ' ' & Left(Right(effective_from,5),5)>

<cfif (form.country_code) is "BVI">
	<!--- calculate effective to date based on effective from date plus number of days --->
    <cfset request.effectiveToDate = Mid(new_effective_to,7,4) & '-' & Mid(new_effective_to,4,2) & '-' & Left(new_effective_to,2) & ' 23:59'>
    <!--- calculate annual effective to date based on effective from date plus 1 year - 1 day --->
    <cfset request.effectiveAnnualToDate = Mid(new_effective_to,7,4) & '-' & Mid(new_effective_to,4,2) & '-' & Left(new_effective_to,2)>
<cfelse>
	<!--- calculate effective to date based on effective from date plus number of days --->
    <cfset request.effectiveToDate = DateAdd('d', effective_days, DateFormat(request.effectiveFromDate,"yyyy-mm-dd")) & ' ' & Left(Right(effective_from,5),5)>
    <!--- <cfset request.effectiveToDate = DateFormat(request.effectiveToDate,"yyyy-mm-dd") & ' 23:59'> --->
    <!--- calculate annual effective to date based on effective from date plus 1 year - 1 day --->
    <cfset request.effectiveAnnualToDate = DateAdd('d', -1, DateAdd('yyyy', 1, request.effectiveFromDate))>
</cfif>

<cftransaction action="BEGIN">

<!--- generate previous cover note number is applicable --->
<cfset request.previousCoverNoteNumberString = "">

<cfset request.clientNumber = Form.client_number>
<cfset request.policyNumber = Form.policy_number>
<cfset request.itemNumber = Form.item_number>

<!--- Loop cert --->
<cfif getSelectedItemForRenewalCN.total_risks gt 1>
	<cfloop list = "#Form.item_number#" index = "item_number">
		<!--- generate unique cover note number --->
        
        <!--- get next cover note number --->
        <cfquery datasource="#datasource#" name="getCoverNoteNumber">
            select ifnull(max(cover_note_number),0) + 1 as nextNumber
            
            from icwi_cover_notes_issued
            
            <cfif IsNumeric(request.sbranchId)>
                where cover_note_branch_id = <cfqueryparam value="#request.sbranchId#" cfsqltype="CF_SQL_INTEGER" maxlength="4">
            <cfelse>
                where cover_note_src_type = <cfqueryparam value="#request.ssrcType#" cfsqltype="CF_SQL_CHAR" maxlength="2">
                    and cover_note_src_id = <cfqueryparam value="#request.ssrcId#" cfsqltype="CF_SQL_CHAR" maxlength="3">
            </cfif>
        </cfquery>

		<cfset request.coverNoteNumber = Trim(getCoverNoteNumber.nextNumber)>
		<cfif IsNumeric(request.sbranchId)>
            <cfset request.coverNoteNumberString = Right('000#Trim(request.sbranchId)#',3) & 'CN' & Right('000000#Trim(request.coverNoteNumber)#', 6)>
        <cfelse>
            <cfset request.coverNoteNumberString = Trim(UCase(request.ssrcId)) & 'CN' & Right('000000#Trim(request.coverNoteNumber)#', 6)>
        </cfif>
        

		<!--- create unique cover note file name --->
        <cfset request.pdfFileName = 'CNOTE_' & Form.policy_number & DateFormat(request.Today,'yyyymmdd') & TimeFormat(request.Today,'HHmmss') & '.pdf'>
        
        <!--- Build dynamic variables for query --->
		<cfset vehicle_make_model_typeII = Evaluate("vehicle_make_model_type" & "_" & "#item_number#")>
        <cfset veh_yearII = Evaluate("vehicle_year_of_man" & "_" & "#item_number#")>
		<cfset veh_makeII = Evaluate("vehicle_make" & "_" & "#item_number#")>
        <cfset veh_modelII = Evaluate("vehicle_model" & "_" & "#item_number#")>
        <cfset veh_regII = Evaluate("vehicle_registration" & "_" & "#item_number#")>
        <cfset veh_chassisII = Evaluate("vehicle_chassis_number" & "_" & "#item_number#")>
        <cfset vehicle_hp_ccII = Evaluate("vehicle_hp_cc" & "_" & "#item_number#")>
        <cfset veh_bodyII = Evaluate("vehicle_body_type" & "_" & "#item_number#")>
        <cfset vehicle_seatingII = Evaluate("vehicle_seating" & "_" & "#item_number#")>
        <cfset vehicle_colourII = Evaluate("vehicle_colour" & "_" & "#item_number#")>
        <cfset narr5II = Evaluate("narrative5" & "_" & "#item_number#")>
        <cfset annual_premII = Evaluate("annual_prem" & "_" & "#item_number#")>
        <cfset si_amtII = Evaluate("si_amt" & "_" & "#item_number#")>
        
		<!--- save cover issued details --->
        <cfif system is not 'kiosk' and system is not 'eclient'>
            <cfquery datasource="#datasource#" name="saveCoverNoteIssued" result="cnote_count">
                insert into icwi_cover_notes_issued
                    (
                    previous_sequence_number, cover_note_branch_id, cover_note_src_type, cover_note_src_id, 
                    cover_note_number, previous_cover_note_number, cover_note_type, date_of_issue, 
                        client_type, insureds_name, address1, address2, temp_client_number, temp_policy_number, temp_item_number, 
                            client_number, policy_number, item_number, scheme_id, renewal_month_year, 
                                effective_from, efective_days, effective_to, vehicle_mvid, 
                                    vehicle_make_model_type, vehicle_make, vehicle_model, vehicle_mark, vehicle_body_type, 
                                        vehicle_year_of_man, vehicle_hp_cc, vehicle_seating, vehicle_colour, currency, vehicle_estimated_value, annual_premium, 
                                            vehicle_registration, vehicle_chassis_number, type_of_policy, form_of_policy, type_of_cover, uses, alterations, 
                                                drivers_the_insured, drivers_include_exclude, drivers_include_exclude_text, restrictions,
                                                    their_reference, declined_name, declined_registration, declined_chassis_number, user_id, pdf_file_name, cr_stamp
                    )
                values
                    (
                    <cfqueryparam value="" cfsqltype="CF_SQL_INTEGER" null="yes">,
                <cfif IsNumeric(request.sbranchId)>
                    <cfqueryparam value="#request.sbranchId#" cfsqltype="CF_SQL_INTEGER" maxlength="4">,
                    null,
                    null,
                <cfelse>
                    null,
                    <cfqueryparam value="#request.ssrcType#" cfsqltype="CF_SQL_CHAR" maxlength="2">,
                    <cfqueryparam value="#request.ssrcId#" cfsqltype="CF_SQL_CHAR" maxlength="3">,
                </cfif>
                
                    <cfqueryparam value="#request.coverNoteNumber#" cfsqltype="CF_SQL_INTEGER" maxlength="6">,
                    <cfqueryparam value="" cfsqltype="CF_SQL_INTEGER" null="yes">,
                    <cfqueryparam value="#Form.cover_note_type#" cfsqltype="CF_SQL_CHAR" maxlength="2">,
                    <cfqueryparam value="#request.Today#" cfsqltype="CF_SQL_TIMESTAMP">,
            
                    <cfqueryparam value="#Form.client_type#" cfsqltype="CF_SQL_CHAR" maxlength="1">,
                    <cfqueryparam value="#Form.insureds_name#" cfsqltype="CF_SQL_VARCHAR" maxlength="60">,
                    <cfqueryparam value="#Form.address1#" cfsqltype="CF_SQL_VARCHAR" maxlength="100">,
                    <cfqueryparam value="#Form.address2#" cfsqltype="CF_SQL_VARCHAR" maxlength="100">,
                    <cfqueryparam value="" cfsqltype="CF_SQL_INTEGER" null="Yes">,
                    <cfqueryparam value="" cfsqltype="CF_SQL_INTEGER" null="Yes">,
                    <cfqueryparam value="" cfsqltype="CF_SQL_INTEGER" null="Yes">,
                    
                    <cfqueryparam value="#Form.client_number#" cfsqltype="CF_SQL_VARCHAR" maxlength="9">,
                    <cfqueryparam value="#Form.policy_number#" cfsqltype="CF_SQL_INTEGER" maxlength="9">,
                    <cfqueryparam value="#item_number#" cfsqltype="CF_SQL_INTEGER" maxlength="4">,
                    <cfqueryparam value="" cfsqltype="CF_SQL_CHAR" null="yes">,
                    <cfqueryparam value="#Form.renewal_month_year#" cfsqltype="CF_SQL_CHAR" maxlength="4">,
            
                    <cfqueryparam value="#request.effectiveFromDate#" cfsqltype="CF_SQL_TIMESTAMP">,
                    <cfqueryparam value="#effective_days#" cfsqltype="CF_SQL_INTEGER" maxlength="3">,
                    <cfqueryparam value="#request.effectiveToDate#" cfsqltype="CF_SQL_TIMESTAMP">,      
                    <cfqueryparam value="" cfsqltype="CF_SQL_VARCHAR" null="yes">,
                    
                    <cfqueryparam value="#vehicle_make_model_typeII#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,        
                    <cfqueryparam value="#veh_makeII#" cfsqltype="CF_SQL_VARCHAR" maxlength="20">,
                    <cfqueryparam value="#veh_modelII#" cfsqltype="CF_SQL_VARCHAR" maxlength="20">,
                    <cfqueryparam value="" cfsqltype="CF_SQL_VARCHAR" null="yes">,
                    <cfqueryparam value="#veh_bodyII#" cfsqltype="CF_SQL_VARCHAR" maxlength="25">,
            
                    <cfqueryparam value="#veh_yearII#" cfsqltype="CF_SQL_INTEGER" maxlength="4">,
                <cfif IsNumeric(vehicle_hp_ccII)>
                    <cfqueryparam value="#vehicle_hp_ccII#" cfsqltype="CF_SQL_INTEGER" maxlength="6">,
                <cfelse>
                    null, 
                </cfif>
                <cfif IsNumeric(vehicle_seatingII)>
                    <cfqueryparam value="#vehicle_seatingII#" cfsqltype="CF_SQL_INTEGER" maxlength="3">,
                <cfelse>
                    null, 
                </cfif>
                    <cfqueryparam value="#vehicle_colourII#" cfsqltype="CF_SQL_VARCHAR" maxlength="20">,
                    <cfqueryparam value="#Form.currency#" cfsqltype="CF_SQL_CHAR" maxlength="5">,
                <cfif IsNumeric(si_amtII)>
                    <cfqueryparam value="#si_amtII#" cfsqltype="CF_SQL_MONEY" maxlength="12">,
                <cfelse>
                    null, 
                </cfif>
                    <cfqueryparam value="#annual_premII#" cfsqltype="CF_SQL_MONEY" maxlength="12">,
                    
                    <cfqueryparam value="#veh_regII#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
                    <cfqueryparam value="#veh_chassisII#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,            
                    <cfqueryparam value="R" cfsqltype="CF_SQL_CHAR" maxlength="1">,<!--- #Form.type_of_policy# --->
                    <cfqueryparam value="#Form.class_of_policy#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
                    <cfqueryparam value="#Form.type_of_cover#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,            
                    <cfqueryparam value="#Form.uses#" cfsqltype="CF_SQL_VARCHAR" maxlength="10000">,
                    <cfqueryparam value="#Form.alterations#" cfsqltype="CF_SQL_VARCHAR" maxlength="10000">,
                    
                    <cfqueryparam value="" cfsqltype="CF_SQL_INTEGER" null="Yes">,
                    <cfqueryparam value="" cfsqltype="CF_SQL_INTEGER" null="Yes">,
                    <cfqueryparam value="" cfsqltype="CF_SQL_INTEGER" null="Yes">,
                    <cfqueryparam value="" cfsqltype="CF_SQL_INTEGER" null="Yes">,
                    
                    <cfqueryparam value="" cfsqltype="CF_SQL_INTEGER" null="Yes">,        
                    <cfqueryparam value="" cfsqltype="CF_SQL_INTEGER" null="Yes">,
                    <cfqueryparam value="" cfsqltype="CF_SQL_INTEGER" null="Yes">,
                    <cfqueryparam value="" cfsqltype="CF_SQL_INTEGER" null="Yes">,                
                    <cfqueryparam value="#request.userId#" cfsqltype="CF_SQL_INTEGER" maxlength="4">,
                    <cfqueryparam value="#request.pdfFileName#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
                    <cfqueryparam value="#request.Today#" cfsqltype="CF_SQL_TIMESTAMP">
                    )
            </cfquery>
        </cfif>
        
        <!--- save cover created details --->
        <cfquery datasource="#datasource#" name="saveCoverNoteCreated" result="cnote_count">
            insert into icwi_cover_notes_created
                (
                previous_sequence_number, cover_note_branch_id, cover_note_src_type, cover_note_src_id, 
                cover_note_number, previous_cover_note_number, cover_note_type, date_of_issue, 
                    client_type, insureds_name, address1, address2, temp_client_number, temp_policy_number, temp_item_number, 
                        client_number, policy_number, item_number, scheme_id, renewal_month_year, 
                            effective_from, efective_days, effective_to, vehicle_mvid, 
                                vehicle_make_model_type, vehicle_make, vehicle_model, vehicle_mark, vehicle_body_type, 
                                    vehicle_year_of_man, vehicle_hp_cc, vehicle_seating, vehicle_colour, currency, vehicle_estimated_value, annual_premium, 
                                        vehicle_registration, vehicle_chassis_number, type_of_policy, form_of_policy, type_of_cover, uses, alterations, 
                                            drivers_the_insured, drivers_include_exclude, drivers_include_exclude_text, restrictions,
                                                their_reference, declined_name, declined_registration, declined_chassis_number, user_id, pdf_file_name, cr_stamp
                )
            values
                (
            	<cfqueryparam value="" cfsqltype="CF_SQL_INTEGER" null="yes">,
            <cfif IsNumeric(request.sbranchId)>
                <cfqueryparam value="#request.sbranchId#" cfsqltype="CF_SQL_INTEGER" maxlength="4">,
                null,
                null,
            <cfelse>
                null,
                <cfqueryparam value="#request.ssrcType#" cfsqltype="CF_SQL_CHAR" maxlength="2">,
                <cfqueryparam value="#request.ssrcId#" cfsqltype="CF_SQL_CHAR" maxlength="3">,
            </cfif>
            
                <cfqueryparam value="#request.coverNoteNumber#" cfsqltype="CF_SQL_INTEGER" maxlength="6">,
            	<cfqueryparam value="" cfsqltype="CF_SQL_INTEGER" null="yes">,
                <cfqueryparam value="#Form.cover_note_type#" cfsqltype="CF_SQL_CHAR" maxlength="2">,
                <cfqueryparam value="#request.Today#" cfsqltype="CF_SQL_TIMESTAMP">,
        
                <cfqueryparam value="#Form.client_type#" cfsqltype="CF_SQL_CHAR" maxlength="1">,
                <cfqueryparam value="#Form.insureds_name#" cfsqltype="CF_SQL_VARCHAR" maxlength="60">,
                <cfqueryparam value="#Form.address1#" cfsqltype="CF_SQL_VARCHAR" maxlength="100">,
                <cfqueryparam value="#Form.address2#" cfsqltype="CF_SQL_VARCHAR" maxlength="100">,
                <cfqueryparam value="" cfsqltype="CF_SQL_INTEGER" null="Yes">,
                <cfqueryparam value="" cfsqltype="CF_SQL_INTEGER" null="Yes">,
                <cfqueryparam value="" cfsqltype="CF_SQL_INTEGER" null="Yes">,
                
                <cfqueryparam value="#Form.client_number#" cfsqltype="CF_SQL_VARCHAR" maxlength="9">,
                <cfqueryparam value="#Form.policy_number#" cfsqltype="CF_SQL_INTEGER" maxlength="9">,
                <cfqueryparam value="#item_number#" cfsqltype="CF_SQL_INTEGER" maxlength="4">,
                <cfqueryparam value="" cfsqltype="CF_SQL_CHAR" null="yes">,
                <cfqueryparam value="#Form.renewal_month_year#" cfsqltype="CF_SQL_CHAR" maxlength="4">,
        
                <cfqueryparam value="#request.effectiveFromDate#" cfsqltype="CF_SQL_TIMESTAMP">,
                <cfqueryparam value="#effective_days#" cfsqltype="CF_SQL_INTEGER" maxlength="3">,
                <cfqueryparam value="#request.effectiveToDate#" cfsqltype="CF_SQL_TIMESTAMP">,      
                <cfqueryparam value="" cfsqltype="CF_SQL_VARCHAR" null="yes">,
                
                <cfqueryparam value="#vehicle_make_model_typeII#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,        
                <cfqueryparam value="#veh_makeII#" cfsqltype="CF_SQL_VARCHAR" maxlength="20">,
                <cfqueryparam value="#veh_modelII#" cfsqltype="CF_SQL_VARCHAR" maxlength="20">,
                <cfqueryparam value="" cfsqltype="CF_SQL_VARCHAR" null="yes">,
                <cfqueryparam value="#veh_bodyII#" cfsqltype="CF_SQL_VARCHAR" maxlength="25">,
        
                <cfqueryparam value="#veh_yearII#" cfsqltype="CF_SQL_INTEGER" maxlength="4">,
            <cfif IsNumeric(vehicle_hp_ccII)>
                <cfqueryparam value="#vehicle_hp_ccII#" cfsqltype="CF_SQL_INTEGER" maxlength="6">,
            <cfelse>
                null, 
            </cfif>
            <cfif IsNumeric(vehicle_seatingII)>
                <cfqueryparam value="#vehicle_seatingII#" cfsqltype="CF_SQL_INTEGER" maxlength="3">,
            <cfelse>
                null, 
            </cfif>
                <cfqueryparam value="#vehicle_colourII#" cfsqltype="CF_SQL_VARCHAR" maxlength="20">,
                <cfqueryparam value="#Form.currency#" cfsqltype="CF_SQL_CHAR" maxlength="5">,
            <cfif IsNumeric(si_amtII)>
                <cfqueryparam value="#si_amtII#" cfsqltype="CF_SQL_MONEY" maxlength="12">,
            <cfelse>
                null, 
            </cfif>
                <cfqueryparam value="#annual_premII#" cfsqltype="CF_SQL_MONEY" maxlength="12">,
                
                <cfqueryparam value="#veh_regII#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
                <cfqueryparam value="#veh_chassisII#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,            
                <cfqueryparam value="R" cfsqltype="CF_SQL_CHAR" maxlength="1">,<!--- #Form.type_of_policy# --->
                <cfqueryparam value="#Form.class_of_policy#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
                <cfqueryparam value="#Form.type_of_cover#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,            
                <cfqueryparam value="#Form.uses#" cfsqltype="CF_SQL_VARCHAR" maxlength="10000">,
                <cfqueryparam value="#Form.alterations#" cfsqltype="CF_SQL_VARCHAR" maxlength="10000">,
                
                <cfqueryparam value="" cfsqltype="CF_SQL_INTEGER" null="Yes">,
                <cfqueryparam value="" cfsqltype="CF_SQL_INTEGER" null="Yes">,
                <cfqueryparam value="" cfsqltype="CF_SQL_INTEGER" null="Yes">,
                <cfqueryparam value="" cfsqltype="CF_SQL_INTEGER" null="Yes">,
                
                <cfqueryparam value="" cfsqltype="CF_SQL_INTEGER" null="Yes">,        
                <cfqueryparam value="" cfsqltype="CF_SQL_INTEGER" null="Yes">,
                <cfqueryparam value="" cfsqltype="CF_SQL_INTEGER" null="Yes">,
                <cfqueryparam value="" cfsqltype="CF_SQL_INTEGER" null="Yes">,                
                <cfqueryparam value="#request.userId#" cfsqltype="CF_SQL_INTEGER" maxlength="4">,
                <cfqueryparam value="#request.pdfFileName#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
                <cfqueryparam value="#request.Today#" cfsqltype="CF_SQL_TIMESTAMP">
                )
        </cfquery>

		<!--- get last created_sequence_number --->
        <cfquery datasource="#datasource#" name="getCreatedSequenceNumber">
            select LAST_INSERT_ID() as nextID
        </cfquery>	
	


		<!--- build commentary string --->
        <cfset request.commentaryString = "">
        <cfif Trim(Form.comments) is not "">
            <cfset request.commentaryString = Trim(Form.comments) & Chr(13) & Chr(10)>
        </cfif>
        <cfset request.commentaryString = request.commentaryString & "Cover Note: #Trim(request.coverNoteNumberString)#">
        
        <!--- save commentary --->
        <cfquery datasource="#datasource#" name="saveCoverNoteCommentary">
            insert into icwi_broker_commentary
                ( 
                branch_id, src_type, src_id, 
                    temp_client_number, temp_policy_number, temp_item_number, 
                        client_number, policy_number, item_number, 
                            cover_note_number, pdf_file_name, commentary, broker_user, cr_stamp
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
        
                <cfqueryparam value="" cfsqltype="CF_SQL_INTEGER" null="Yes">,
                <cfqueryparam value="" cfsqltype="CF_SQL_INTEGER" null="Yes">,
                <cfqueryparam value="" cfsqltype="CF_SQL_INTEGER" null="Yes">,
                
                <cfqueryparam value="#Form.client_number#" cfsqltype="CF_SQL_INTEGER" maxlength="9">,
                
                <cfqueryparam value="#Form.policy_number#" cfsqltype="CF_SQL_INTEGER" maxlength="9">,
                <cfqueryparam value="#item_number#" cfsqltype="CF_SQL_INTEGER" maxlength="4">,
            
                <cfqueryparam value="#request.coverNoteNumber#" cfsqltype="CF_SQL_INTEGER" maxlength="6">,
                <cfqueryparam value="#request.pdfFileName#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
                <cfqueryparam value="#request.commentaryString#" cfsqltype="CF_SQL_VARCHAR" maxlength="2000">,
                <cfqueryparam value="#request.userId#" cfsqltype="CF_SQL_INTEGER" maxlength="4">,
                <cfqueryparam value="#request.Today#" cfsqltype="CF_SQL_TIMESTAMP">
                )	
        </cfquery>
	</cfloop>
<cfelse>
	<!--- generate unique cover note number --->
    
    <!--- get next cover note number --->
    <cfquery datasource="#datasource#" name="getCoverNoteNumber">
        select ifnull(max(cover_note_number),0) + 1 as nextNumber
        
        from icwi_cover_notes_issued
        
        <cfif IsNumeric(request.sbranchId)>
            where cover_note_branch_id = <cfqueryparam value="#request.sbranchId#" cfsqltype="CF_SQL_INTEGER" maxlength="4">
        <cfelse>
            where cover_note_src_type = <cfqueryparam value="#request.ssrcType#" cfsqltype="CF_SQL_CHAR" maxlength="2">
                and cover_note_src_id = <cfqueryparam value="#request.ssrcId#" cfsqltype="CF_SQL_CHAR" maxlength="3">
        </cfif>
    </cfquery>

    <cfset request.coverNoteNumber = Trim(getCoverNoteNumber.nextNumber)>
    <cfif IsNumeric(request.sbranchId)>
        <cfset request.coverNoteNumberString = Right('000#Trim(request.sbranchId)#',3) & 'CN' & Right('000000#Trim(request.coverNoteNumber)#', 6)>
    <cfelse>
        <cfset request.coverNoteNumberString = Trim(UCase(request.ssrcId)) & 'CN' & Right('000000#Trim(request.coverNoteNumber)#', 6)>
    </cfif>
    

    <!--- create unique cover note file name --->
    <cfset request.pdfFileName = 'CNOTE_' & Form.policy_number & DateFormat(request.Today,'yyyymmdd') & TimeFormat(request.Today,'HHmmss') & '.pdf'>
    
    <!--- save cover issued details --->
    <cfif system is not 'kiosk' and system is not 'eclient'>
        <cfquery datasource="#datasource#" name="saveCoverNoteIssued" result="cnote_count">
            insert into icwi_cover_notes_issued
                (
                previous_sequence_number, cover_note_branch_id, cover_note_src_type, cover_note_src_id, 
                cover_note_number, previous_cover_note_number, cover_note_type, date_of_issue, 
                    client_type, insureds_name, address1, address2, temp_client_number, temp_policy_number, temp_item_number, 
                        client_number, policy_number, item_number, scheme_id, renewal_month_year, 
                            effective_from, efective_days, effective_to, vehicle_mvid, 
                                vehicle_make_model_type, vehicle_make, vehicle_model, vehicle_mark, vehicle_body_type, 
                                    vehicle_year_of_man, vehicle_hp_cc, vehicle_seating, vehicle_colour, currency, vehicle_estimated_value, annual_premium, 
                                        vehicle_registration, vehicle_chassis_number, type_of_policy, form_of_policy, type_of_cover, uses, alterations, 
                                            drivers_the_insured, drivers_include_exclude, drivers_include_exclude_text, restrictions,
                                                their_reference, declined_name, declined_registration, declined_chassis_number, user_id, pdf_file_name, cr_stamp
                )
            values
                (
                <cfqueryparam value="" cfsqltype="CF_SQL_INTEGER" null="yes">,
            <cfif IsNumeric(request.sbranchId)>
                <cfqueryparam value="#request.sbranchId#" cfsqltype="CF_SQL_INTEGER" maxlength="4">,
                null,
                null,
            <cfelse>
                null,
                <cfqueryparam value="#request.ssrcType#" cfsqltype="CF_SQL_CHAR" maxlength="2">,
                <cfqueryparam value="#request.ssrcId#" cfsqltype="CF_SQL_CHAR" maxlength="3">,
            </cfif>
                <cfqueryparam value="#request.coverNoteNumber#" cfsqltype="CF_SQL_INTEGER" maxlength="6">,
                <cfqueryparam value="" cfsqltype="CF_SQL_INTEGER" null="yes">,
                
                <cfqueryparam value="#Form.cover_note_type#" cfsqltype="CF_SQL_CHAR" maxlength="2">,
                <cfqueryparam value="#request.Today#" cfsqltype="CF_SQL_TIMESTAMP">,
        
                <cfqueryparam value="#Form.client_type#" cfsqltype="CF_SQL_CHAR" maxlength="1">,
                <cfqueryparam value="#Form.insureds_name#" cfsqltype="CF_SQL_VARCHAR" maxlength="150">,
                <cfqueryparam value="#Form.address1#" cfsqltype="CF_SQL_VARCHAR" maxlength="100">,
                <cfqueryparam value="#Form.address2#" cfsqltype="CF_SQL_VARCHAR" maxlength="100">,
                <cfqueryparam value="" cfsqltype="CF_SQL_INTEGER" null="Yes">,
                <cfqueryparam value="" cfsqltype="CF_SQL_INTEGER" null="Yes">,
                <cfqueryparam value="" cfsqltype="CF_SQL_INTEGER" null="Yes">,
                <cfqueryparam value="#Form.client_number#" cfsqltype="CF_SQL_VARCHAR" maxlength="9">,
                <cfqueryparam value="#Form.policy_number#" cfsqltype="CF_SQL_INTEGER" maxlength="9">,
                <cfqueryparam value="#Form.item_number#" cfsqltype="CF_SQL_INTEGER" maxlength="4">,
                <cfqueryparam value="" cfsqltype="CF_SQL_CHAR" null="yes">,
                <cfqueryparam value="#Form.renewal_month_year#" cfsqltype="CF_SQL_CHAR" maxlength="4">,
        
                <cfqueryparam value="#request.effectiveFromDate#" cfsqltype="CF_SQL_TIMESTAMP">,
                <cfqueryparam value="#effective_days#" cfsqltype="CF_SQL_INTEGER" maxlength="3">,
                <cfqueryparam value="#request.effectiveToDate#" cfsqltype="CF_SQL_TIMESTAMP">,
        
                <cfqueryparam value="" cfsqltype="CF_SQL_VARCHAR" null="yes">,
                <cfqueryparam value="#Form.vehicle_make_model_type#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
        
                <cfqueryparam value="#Form.vehicle_make#" cfsqltype="CF_SQL_VARCHAR" maxlength="20">,
                <cfqueryparam value="#Form.vehicle_model#" cfsqltype="CF_SQL_VARCHAR" maxlength="20">,
                <cfqueryparam value="" cfsqltype="CF_SQL_VARCHAR" null="yes">,
                <cfqueryparam value="#Form.vehicle_body_type#" cfsqltype="CF_SQL_VARCHAR" maxlength="25">,
        
                <cfqueryparam value="#Form.vehicle_year_of_man#" cfsqltype="CF_SQL_INTEGER" maxlength="4">,
            <cfif IsNumeric(Form.vehicle_hp_cc)>
                <cfqueryparam value="#Form.vehicle_hp_cc#" cfsqltype="CF_SQL_INTEGER" maxlength="6">,
            <cfelse>
                null, 
            </cfif>
            <cfif IsNumeric(Form.vehicle_seating)>
                <cfqueryparam value="#Form.vehicle_seating#" cfsqltype="CF_SQL_INTEGER" maxlength="3">,
            <cfelse>
                null, 
            </cfif>
                <cfqueryparam value="#Form.vehicle_colour#" cfsqltype="CF_SQL_VARCHAR" maxlength="20">,
                <cfqueryparam value="#Form.currency#" cfsqltype="CF_SQL_CHAR" maxlength="5">,
            <cfif IsNumeric(Form.vehicle_estimated_value)>
                <cfqueryparam value="#Form.vehicle_estimated_value#" cfsqltype="CF_SQL_MONEY" maxlength="12">,
            <cfelse>
                null, 
            </cfif>
                <cfqueryparam value="#Form.annual_premium#" cfsqltype="CF_SQL_MONEY" maxlength="12">,
                <cfqueryparam value="#Form.vehicle_registration#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
                <cfqueryparam value="#Form.vehicle_chassis_number#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
            
                <cfqueryparam value="#Form.type_of_policy#" cfsqltype="CF_SQL_CHAR" maxlength="1">,
                <cfqueryparam value="#Form.class_of_policy#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
                <cfqueryparam value="#Form.type_of_cover#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
            
                <cfqueryparam value="#Form.uses#" cfsqltype="CF_SQL_VARCHAR" maxlength="4000">,
                <cfqueryparam value="#Form.alterations#" cfsqltype="CF_SQL_VARCHAR" maxlength="10000">,
                
                <cfqueryparam value="" cfsqltype="CF_SQL_INTEGER" null="Yes">,
                <cfqueryparam value="" cfsqltype="CF_SQL_INTEGER" null="Yes">,
                <cfqueryparam value="" cfsqltype="CF_SQL_INTEGER" null="Yes">,
                <cfqueryparam value="" cfsqltype="CF_SQL_INTEGER" null="Yes">,
                
                <cfqueryparam value="" cfsqltype="CF_SQL_INTEGER" null="Yes">,
        
                <cfqueryparam value="" cfsqltype="CF_SQL_INTEGER" null="Yes">,
                <cfqueryparam value="" cfsqltype="CF_SQL_INTEGER" null="Yes">,
                <cfqueryparam value="" cfsqltype="CF_SQL_INTEGER" null="Yes">,
                
                <cfqueryparam value="#request.userId#" cfsqltype="CF_SQL_INTEGER" maxlength="4">,
                <cfqueryparam value="#request.pdfFileName#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
                <cfqueryparam value="#request.Today#" cfsqltype="CF_SQL_TIMESTAMP">
                )
        </cfquery>
    </cfif>
    
    <!--- save cover created details --->
    <cfquery datasource="#datasource#" name="saveCoverNoteCreated" result="cnote_count">
        insert into icwi_cover_notes_created
            (
            previous_sequence_number, cover_note_branch_id, cover_note_src_type, cover_note_src_id, 
            cover_note_number, previous_cover_note_number, cover_note_type, date_of_issue, 
                client_type, insureds_name, address1, address2, temp_client_number, temp_policy_number, temp_item_number, 
                    client_number, policy_number, item_number, scheme_id, renewal_month_year, 
                        effective_from, efective_days, effective_to, vehicle_mvid, 
                            vehicle_make_model_type, vehicle_make, vehicle_model, vehicle_mark, vehicle_body_type, 
                                vehicle_year_of_man, vehicle_hp_cc, vehicle_seating, vehicle_colour, currency, vehicle_estimated_value, annual_premium, 
                                    vehicle_registration, vehicle_chassis_number, type_of_policy, form_of_policy, type_of_cover, uses, alterations, 
                                        drivers_the_insured, drivers_include_exclude, drivers_include_exclude_text, restrictions,
                                            their_reference, declined_name, declined_registration, declined_chassis_number, user_id, pdf_file_name, cr_stamp
            )
        values
            (
        	<cfqueryparam value="" cfsqltype="CF_SQL_INTEGER" null="yes">,
        <cfif IsNumeric(request.sbranchId)>
            <cfqueryparam value="#request.sbranchId#" cfsqltype="CF_SQL_INTEGER" maxlength="4">,
            null,
            null,
        <cfelse>
            null,
            <cfqueryparam value="#request.ssrcType#" cfsqltype="CF_SQL_CHAR" maxlength="2">,
            <cfqueryparam value="#request.ssrcId#" cfsqltype="CF_SQL_CHAR" maxlength="3">,
        </cfif>
            <cfqueryparam value="#request.coverNoteNumber#" cfsqltype="CF_SQL_INTEGER" maxlength="6">,
        	<cfqueryparam value="" cfsqltype="CF_SQL_INTEGER" null="yes">,
            
            <cfqueryparam value="#Form.cover_note_type#" cfsqltype="CF_SQL_CHAR" maxlength="2">,
            <cfqueryparam value="#request.Today#" cfsqltype="CF_SQL_TIMESTAMP">,
    
            <cfqueryparam value="#Form.client_type#" cfsqltype="CF_SQL_CHAR" maxlength="1">,
            <cfqueryparam value="#Form.insureds_name#" cfsqltype="CF_SQL_VARCHAR" maxlength="150">,
            <cfqueryparam value="#Form.address1#" cfsqltype="CF_SQL_VARCHAR" maxlength="100">,
            <cfqueryparam value="#Form.address2#" cfsqltype="CF_SQL_VARCHAR" maxlength="100">,
            <cfqueryparam value="" cfsqltype="CF_SQL_INTEGER" null="Yes">,
            <cfqueryparam value="" cfsqltype="CF_SQL_INTEGER" null="Yes">,
            <cfqueryparam value="" cfsqltype="CF_SQL_INTEGER" null="Yes">,
            <cfqueryparam value="#Form.client_number#" cfsqltype="CF_SQL_VARCHAR" maxlength="9">,
            <cfqueryparam value="#Form.policy_number#" cfsqltype="CF_SQL_INTEGER" maxlength="9">,
            <cfqueryparam value="#Form.item_number#" cfsqltype="CF_SQL_INTEGER" maxlength="4">,
            <cfqueryparam value="" cfsqltype="CF_SQL_CHAR" null="yes">,
            <cfqueryparam value="#Form.renewal_month_year#" cfsqltype="CF_SQL_CHAR" maxlength="4">,
    
            <cfqueryparam value="#request.effectiveFromDate#" cfsqltype="CF_SQL_TIMESTAMP">,
            <cfqueryparam value="#effective_days#" cfsqltype="CF_SQL_INTEGER" maxlength="3">,
            <cfqueryparam value="#request.effectiveToDate#" cfsqltype="CF_SQL_TIMESTAMP">,
    
            <cfqueryparam value="" cfsqltype="CF_SQL_VARCHAR" null="yes">,
            <cfqueryparam value="#Form.vehicle_make_model_type#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
    
            <cfqueryparam value="#Form.vehicle_make#" cfsqltype="CF_SQL_VARCHAR" maxlength="20">,
            <cfqueryparam value="#Form.vehicle_model#" cfsqltype="CF_SQL_VARCHAR" maxlength="20">,
            <cfqueryparam value="" cfsqltype="CF_SQL_VARCHAR" null="yes">,
            <cfqueryparam value="#Form.vehicle_body_type#" cfsqltype="CF_SQL_VARCHAR" maxlength="25">,
    
            <cfqueryparam value="#Form.vehicle_year_of_man#" cfsqltype="CF_SQL_INTEGER" maxlength="4">,
        <cfif IsNumeric(Form.vehicle_hp_cc)>
            <cfqueryparam value="#Form.vehicle_hp_cc#" cfsqltype="CF_SQL_INTEGER" maxlength="6">,
        <cfelse>
            null, 
        </cfif>
        <cfif IsNumeric(Form.vehicle_seating)>
            <cfqueryparam value="#Form.vehicle_seating#" cfsqltype="CF_SQL_INTEGER" maxlength="3">,
        <cfelse>
            null, 
        </cfif>
            <cfqueryparam value="#Form.vehicle_colour#" cfsqltype="CF_SQL_VARCHAR" maxlength="20">,
            <cfqueryparam value="#Form.currency#" cfsqltype="CF_SQL_CHAR" maxlength="5">,
        <cfif IsNumeric(Form.vehicle_estimated_value)>
            <cfqueryparam value="#Form.vehicle_estimated_value#" cfsqltype="CF_SQL_MONEY" maxlength="12">,
        <cfelse>
            null, 
        </cfif>
            <cfqueryparam value="#Form.annual_premium#" cfsqltype="CF_SQL_MONEY" maxlength="12">,
            <cfqueryparam value="#Form.vehicle_registration#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
            <cfqueryparam value="#Form.vehicle_chassis_number#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
        
            <cfqueryparam value="#Form.type_of_policy#" cfsqltype="CF_SQL_CHAR" maxlength="1">,
            <cfqueryparam value="#Form.class_of_policy#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
            <cfqueryparam value="#Form.type_of_cover#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
        
            <cfqueryparam value="#Form.uses#" cfsqltype="CF_SQL_VARCHAR" maxlength="4000">,
            <cfqueryparam value="#Form.alterations#" cfsqltype="CF_SQL_VARCHAR" maxlength="10000">,
            
            <cfqueryparam value="" cfsqltype="CF_SQL_INTEGER" null="Yes">,
            <cfqueryparam value="" cfsqltype="CF_SQL_INTEGER" null="Yes">,
            <cfqueryparam value="" cfsqltype="CF_SQL_INTEGER" null="Yes">,
            <cfqueryparam value="" cfsqltype="CF_SQL_INTEGER" null="Yes">,
            
            <cfqueryparam value="" cfsqltype="CF_SQL_INTEGER" null="Yes">,
    
            <cfqueryparam value="" cfsqltype="CF_SQL_INTEGER" null="Yes">,
            <cfqueryparam value="" cfsqltype="CF_SQL_INTEGER" null="Yes">,
            <cfqueryparam value="" cfsqltype="CF_SQL_INTEGER" null="Yes">,
            
            <cfqueryparam value="#request.userId#" cfsqltype="CF_SQL_INTEGER" maxlength="4">,
            <cfqueryparam value="#request.pdfFileName#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
            <cfqueryparam value="#request.Today#" cfsqltype="CF_SQL_TIMESTAMP">
            )
    </cfquery>

    <!--- get last created_sequence_number --->
    <cfquery datasource="#datasource#" name="getCreatedSequenceNumber">
        select LAST_INSERT_ID() as nextID
    </cfquery>	


    <!--- build commentary string --->
    <cfset request.commentaryString = "">
    <cfif Trim(Form.comments) is not "">
        <cfset request.commentaryString = Trim(Form.comments) & Chr(13) & Chr(10)>
    </cfif>
    <cfset request.commentaryString = request.commentaryString & "Cover Note: #Trim(request.coverNoteNumberString)#">
    
    <!--- save commentary --->
    <cfquery datasource="#datasource#" name="saveCoverNoteCommentary">
        insert into icwi_broker_commentary
            ( 
            branch_id, src_type, src_id, 
                temp_client_number, temp_policy_number, temp_item_number, 
                    client_number, policy_number, item_number, 
                        cover_note_number, pdf_file_name, commentary, broker_user, cr_stamp
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
    
            <cfqueryparam value="" cfsqltype="CF_SQL_INTEGER" null="Yes">,
            <cfqueryparam value="" cfsqltype="CF_SQL_INTEGER" null="Yes">,
            <cfqueryparam value="" cfsqltype="CF_SQL_INTEGER" null="Yes">,
            
            <cfqueryparam value="#Form.client_number#" cfsqltype="CF_SQL_INTEGER" maxlength="9">,
            
            <cfqueryparam value="#Form.policy_number#" cfsqltype="CF_SQL_INTEGER" maxlength="9">,
            <cfqueryparam value="#Form.item_number#" cfsqltype="CF_SQL_INTEGER" maxlength="4">,
        
            <cfqueryparam value="#request.coverNoteNumber#" cfsqltype="CF_SQL_INTEGER" maxlength="6">,
            <cfqueryparam value="#request.pdfFileName#" cfsqltype="CF_SQL_VARCHAR" maxlength="50">,
            <cfqueryparam value="#request.commentaryString#" cfsqltype="CF_SQL_VARCHAR" maxlength="2000">,
            <cfqueryparam value="#request.userId#" cfsqltype="CF_SQL_INTEGER" maxlength="4">,
            <cfqueryparam value="#request.Today#" cfsqltype="CF_SQL_TIMESTAMP">
            )	
    </cfquery>	    
</cfif>    
</cftransaction>


<!--- BRITISH VIRGIN ISLANDS --->
<cfif (form.country_code) is "BVI">
	<cfset request.bviPeriodOfInsurance = "Proposed Period Of Insurance: From: ">
	<cfset request.bviPeriodOfInsurance =  request.bviPeriodOfInsurance & DateFormat(request.effectiveFromDate,'ddd mmm d yyyy') & " " & TimeFormat(request.effectiveFromDate,'HH:mm')>
	<cfset request.bviPeriodOfInsurance =  request.bviPeriodOfInsurance & " To: " & DateFormat(request.effectiveAnnualToDate,'ddd mmm d yyyy') & " midnight ">
</cfif>


<!--- build initials string --->
<cfset initialsStr = Right('0000'&request.userId,4)>
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


<!--- get pdf templates --->
<cfquery datasource="ICWI_MySql_Broker_Security_DSN" name="getPdfTemplates">
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

<!--- include queries get cover note template file name --->
<!--- Modified for testing --->
<cfif getPdfTemplates.country_id is 'JAM'>
	<cfset getPdfTemplates.cover_note_file_name = "icwi_cover_note_jam_dr.pdf">
<cfelseif getPdfTemplates.country_id is 'SKN'>
	<cfset getPdfTemplates.cover_note_file_name = "icwi_cover_note_cay_dr.pdf"> 
<cfelseif getPdfTemplates.country_id is 'CAY'>
	<cfset getPdfTemplates.cover_note_file_name = "icwi_cover_note_cay_dr.pdf">        
</cfif>    
<!--- <cfset getPdfTemplates.cover_note_file_name = "icwi_cover_note_jam_dr_test.pdf"> --->
<cfset request.pdfCoverNoteTemplate = Trim(getPdfTemplates.cover_note_file_name)>

<!--- include query to get branch / broker's full name and address --->
<cfif IsNumeric(request.sbranchId)>
	<!--- get selected branch --->
    <cfquery datasource="#datasourceII#" name="getBranchInfo">
        select *
        from crm_branch
        where branch_id = <cfqueryparam value="#request.sbranchId#" cfsqltype="CF_SQL_INTEGER" maxlength="4">
    </cfquery>
<cfelse>
	<!--- get selected broker --->
    <cfquery datasource="#datasourceII#" name="getBrokerInfo">
        select *
        from crm_source_names
        where src_type = <cfqueryparam value="#request.ssrcType#" cfsqltype="CF_SQL_CHAR" maxlength="2"> 
        and src_id = <cfqueryparam value="#request.ssrcId#" cfsqltype="CF_SQL_CHAR" maxlength="3">
    </cfquery>
</cfif>

<!--- Define Address info for BVI & SKN --->
<cfif IsNumeric(request.sbranchId)>
	<cfset request.contact_info = "Tel: " & getBranchInfo.phone_no>
	<cfif getBranchInfo.fax_no is not ''>
        <cfset request.contact_info = request.contact_info & ", Fax: " & getBranchInfo.fax_no>
    </cfif>
    <cfset request.mail_address = getBranchInfo.addr_line_1 & ", " & getBranchInfo.addr_city>
<cfelse>
	<cfset request.contact_info = "Tel: " & getBrokerInfo.phone_no>
	<cfif getBrokerInfo.fax_no is not ''>
        <cfset request.contact_info = request.contact_info & ", Fax: " & getBrokerInfo.fax_no>
    </cfif>
    
    <cfif getBrokerInfo.email_addr is not ''>
        <cfset request.contact_info = request.contact_info & ", Email: " & getBrokerInfo.email_addr>
    </cfif>
    <cfset request.mail_address = getBrokerInfo.mail_address>
</cfif>

<!--- build pdf --->
<cfif getSelectedItemForRenewalCN.total_risks gt 1>
	<cfloop list = "#Form.item_number#" index = "item_number">
    
    <!--- get next cover note number --->
    <cfquery datasource="#datasource#" name="getCoverNoteNumber">
        select ifnull(max(cover_note_number),0) + 1 as nextNumber
        
        from icwi_cover_notes_issued
        
        <cfif IsNumeric(request.sbranchId)>
            where cover_note_branch_id = <cfqueryparam value="#request.sbranchId#" cfsqltype="CF_SQL_INTEGER" maxlength="4">
        <cfelse>
            where cover_note_src_type = <cfqueryparam value="#request.ssrcType#" cfsqltype="CF_SQL_CHAR" maxlength="2">
                and cover_note_src_id = <cfqueryparam value="#request.ssrcId#" cfsqltype="CF_SQL_CHAR" maxlength="3">
        </cfif>
    </cfquery>

    <cfset request.coverNoteNumber = Trim(getCoverNoteNumber.nextNumber)>
    <cfif IsNumeric(request.sbranchId)>
        <cfset request.coverNoteNumberString = Right('000#Trim(request.sbranchId)#',3) & 'CN' & Right('000000#Trim(request.coverNoteNumber)#', 6)>
    <cfelse>
        <cfset request.coverNoteNumberString = Trim(UCase(request.ssrcId)) & 'CN' & Right('000000#Trim(request.coverNoteNumber)#', 6)>
    </cfif>
        
	<!--- create unique cover note file name --->
	<cfset request.pdfFileNameII = 'CNOTE_' & Form.policy_number & DateFormat(request.Today,'yyyymmdd') & TimeFormat(request.Today,'HHmmss') & '_' & item_number & '.pdf'>
    <cfset request.pdfFileName = 'CNOTE_' & Form.policy_number & DateFormat(request.Today,'yyyymmdd') & TimeFormat(request.Today,'HHmmss') & '.pdf'>
    
    <!--- Build dynamic variables for query --->
    <cfset vehicle_make_model_typeII = Evaluate("vehicle_make_model_type" & "_" & "#item_number#")>
    <cfset veh_yearII = Evaluate("vehicle_year_of_man" & "_" & "#item_number#")>
    <cfset veh_makeII = Evaluate("vehicle_make" & "_" & "#item_number#")>
    <cfset veh_modelII = Evaluate("vehicle_model" & "_" & "#item_number#")>
    <cfset veh_regII = Evaluate("vehicle_registration" & "_" & "#item_number#")>
    <cfset veh_chassisII = Evaluate("vehicle_chassis_number" & "_" & "#item_number#")>
    <cfset vehicle_hp_ccII = Evaluate("vehicle_hp_cc" & "_" & "#item_number#")>
    <cfset veh_bodyII = Evaluate("vehicle_body_type" & "_" & "#item_number#")>
    <cfset vehicle_seatingII = Evaluate("vehicle_seating" & "_" & "#item_number#")>
    <cfset vehicle_colourII = Evaluate("vehicle_colour" & "_" & "#item_number#")>
    <cfset narr5II = Evaluate("narrative5" & "_" & "#item_number#")>
    <cfset annual_premII = Evaluate("annual_prem" & "_" & "#item_number#")>
    <cfset si_amtII = Evaluate("si_amt" & "_" & "#item_number#")>
	
        <cfpdfform action="populate" source="#Trim(pdfPath)##request.pdfCoverNoteTemplate#" destination="#Trim(covernotePdfPath)##Trim(request.pdfFileNameII)#" overwrite="yes">
            <cfpdfsubform name="mail_address">
                <!--- Address and contact information for BVI & SKN Agents --->
                <cfif (form.country_code) is "BVI" or (form.country_code) is "SKN">
                    <cfpdfformparam name="mail_address" value="#Trim(request.mail_address)#">
                    <cfpdfformparam name="contact_info" value="#Trim(request.contact_info)#">
                </cfif>
                
                <cfif IsNumeric(request.sbranchId)>
                    <cfpdfformparam name="branch_name" value="Serviced By: #Trim(getBranchInfo.branch_name)# Branch">
                <cfelse>
                    <cfpdfformparam name="branch_name" value="Serviced By: #Trim(getBrokerInfo.src_name)#">
                </cfif>
                
                <cfpdfformparam name="cover_note_no" value="#Trim(request.coverNoteNumberString)#">
                <cfpdfformparam name="date" value="#DateFormat(request.Today,'ddd mmm d yyyy')#">
                <!--- Removed for testing --->
                <!------>
                <cfpdfformparam name="insureds_name" value="#Trim(Form.insureds_name)#">
                <cfpdfformparam name="address1" value="#Trim(Form.address1)#">
                <cfpdfformparam name="address2" value="#Trim(Form.address2)#">
            	
				
                <!--- test if scheme id specified - also ignore type N --->
                <cfif (Trim(Form.scheme_id) is "") or (Trim(Form.scheme_id) is "N")>
                    <cfpdfformparam name="policy_number" value="#Trim(Form.policy_number)#/#item_number#">
                <cfelse>
                    <cfpdfformparam name="policy_number" value="#Trim(Form.policy_number)#/#item_number#/#Trim(Form.scheme_id)#">
                </cfif>
            
                <cfpdfformparam name="effective_from" value="#DateFormat(request.effectiveFromDate,'ddd mmm d yyyy')# #TimeFormat(request.effectiveFromDate,'hh:mm tt')#">
                <cfpdfformparam name="effective_to" value="#DateFormat(request.effectiveToDate,'ddd mmm d yyyy')# #TimeFormat(request.effectiveFromDate,'hh:mm tt')#">
                <!--- <cfpdfformparam name="effective_to" value="#DateFormat(request.effectiveToDate,'ddd mmm d yyyy')# 11:59 PM"> --->
                <cfpdfformparam name="period_message" value="#Trim(request.periodMessage)#">
                <cfpdfformparam name="vehicle_make_model_type" value="#Trim(vehicle_make_model_typeII)#">
                <cfpdfformparam name="vehicle_body_type" value="#Trim(veh_bodyII)#">
                <cfpdfformparam name="vehicle_year_of_man" value="#Trim(veh_yearII)#">
                <cfpdfformparam name="vehicle_hp_cc" value="#Trim(vehicle_hp_ccII)#">
                <cfpdfformparam name="vehicle_seating" value="#Trim(vehicle_seatingII)#">
                <cfif IsNumeric(si_amtII) and si_amtII gt 0>
                    <cfpdfformparam name="vehicle_estimated_value" value="#Trim(Form.currency)# #DollarFormat(si_amtII)#">
                <cfelse>
                	<cfpdfformparam name="vehicle_estimated_value" value="N/A">    
                </cfif>
                <!--- Removed for testing --->
                <!------>
                <cfpdfformparam name="vehicle_reg_chassis" value="#Trim(veh_regII)# / #Trim(veh_chassisII)#">
				
                <cfpdfformparam name="class_of_policy" value="#Trim(Form.class_of_policy)#">
                <cfpdfformparam name="type_of_cover" value="#Trim(Form.type_of_cover)#">
                
                <cfpdfformparam name="uses" value="#Trim(Form.uses)#">
                <!--- 
                <cfif getSelectedItemForRenewalCN.prem_period is not 'A'>
                    <cfpdfformparam name="period_descr" value="#Trim(Form.period_descr)#">
                </cfif>
                --->
                <cfpdfformparam name="period_descr" value="#Trim(Form.period_descr)#">
                   
                <cfpdfformparam name="alterations" value="#Trim(Form.alterations)#">
                <cfpdfformparam name="restrictions_message" value="#Trim(request.restrictionsMessage)#">
                
                <cfif IsNumeric(request.sbranchId)>
                    <cfpdfformparam name="branch_name2" value="#Trim(getBranchInfo.branch_name)# Branch">
                <cfelse>
                    <cfpdfformparam name="branch_name2" value="#Trim(getBrokerInfo.src_name)#">
                </cfif>
        
                <!--- BRITISH VIRGIN ISLANDS --->
                <cfif (form.country_code) is "BVI">
                    <cfpdfformparam name="period_of_insurance" value="#Trim(request.bviPeriodOfInsurance)#">
                </cfif>
                <cfpdfformparam name="initials" value="#Trim(initialsStr)#">
            </cfpdfsubform>
        </cfpdfform>
	</cfloop>       
    
    <!--- Combine PDFs ---> 
    <cfpdf action="merge" destination="#Trim(covernotePdfPath)##Trim(request.pdfFileName)#" overwrite="yes">
         <cfloop list = "#Form.item_number#" index = "item_number">
            <!--- Build individual file names--->
            <cfset request.pdfFileNameII =  'CNOTE_' & Form.policy_number & DateFormat(request.Today,'yyyymmdd') & TimeFormat(request.Today,'HHmmss') & '_' & item_number & '.pdf'>
        
            <!--- Loop individual files--->
            <cfpdfparam source="#Trim(covernotePdfPath)##Trim(request.pdfFileNameII)#">
        </cfloop>
    </cfpdf> 
    <!--- 
    <cfif StructKeyExists(Form,"item_no")>
        <cfloop list = "#Form.item_number#" index = "item_number">
            <!--- Build individual file names--->
            <cfset request.pdfFileNameIII =  'CNOTE_' & Form.policy_number & DateFormat(request.Today,'yyyymmdd') & TimeFormat(request.Today,'HHmmss') & '_' & item_number & '.pdf'>
            
            <!--- Delete files --->
           <cffile action="delete" file="#Trim(certificatePdfPath)##Trim(request.pdfFileNameIII)#" >
        </cfloop>
    </cfif>
	--->
    <cfset request.pdfFileNameCN = Trim(request.pdfFileName)>
<cfelse>
        <cfpdfform action="populate" source="#Trim(pdfPath)##request.pdfCoverNoteTemplate#" destination="#Trim(covernotePdfPath)##Trim(request.pdfFileName)#" overwrite="yes">
            <cfpdfsubform name="mail_address">
                <!--- Address and contact information for BVI & SKN Agents --->
                <cfif (form.country_code) is "BVI" or (form.country_code) is "SKN">
                    <cfpdfformparam name="mail_address" value="#Trim(request.mail_address)#">
                    <cfpdfformparam name="contact_info" value="#Trim(request.contact_info)#">
                </cfif>
                
                <cfif IsNumeric(request.sbranchId)>
                    <cfpdfformparam name="branch_name" value="Serviced By: #Trim(getBranchInfo.branch_name)# Branch">
                <cfelse>
                    <cfpdfformparam name="branch_name" value="Serviced By: #Trim(getBrokerInfo.src_name)#">
                </cfif>
                
                <cfpdfformparam name="cover_note_no" value="#Trim(request.coverNoteNumberString)#">
                <cfpdfformparam name="date" value="#DateFormat(request.Today,'ddd mmm d yyyy')#">
                <!--- Removed for testing --->
                <!------>
                <cfpdfformparam name="insureds_name" value="#Trim(Form.insureds_name)#">
                <cfpdfformparam name="address1" value="#Trim(Form.address1)#">
                <cfpdfformparam name="address2" value="#Trim(Form.address2)#">
            	
                
                <!--- test if scheme id specified - also ignore type N --->
                <cfif (Trim(Form.scheme_id) is "") or (Trim(Form.scheme_id) is "N")>
                    <cfpdfformparam name="policy_number" value="#Trim(Form.policy_number)#/#Trim(Form.item_number)#">
                <cfelse>
                    <cfpdfformparam name="policy_number" value="#Trim(Form.policy_number)#/#Trim(Form.item_number)#/#Trim(Form.scheme_id)#">
                </cfif>
            
                <cfpdfformparam name="effective_from" value="#DateFormat(request.effectiveFromDate,'ddd mmm d yyyy')# #TimeFormat(request.effectiveFromDate,'hh:mm tt')#">
                <cfpdfformparam name="effective_to" value="#DateFormat(request.effectiveToDate,'ddd mmm d yyyy')# #TimeFormat(request.effectiveFromDate,'hh:mm tt')#">
                <!--- <cfpdfformparam name="effective_to" value="#DateFormat(request.effectiveToDate,'ddd mmm d yyyy')# 11:59 PM"> --->
                <cfpdfformparam name="period_message" value="#Trim(request.periodMessage)#">
                <cfpdfformparam name="vehicle_make_model_type" value="#Trim(Form.vehicle_make_model_type)#">
                <cfpdfformparam name="vehicle_body_type" value="#Trim(Form.vehicle_body_type)#">
                <cfpdfformparam name="vehicle_year_of_man" value="#Trim(Form.vehicle_year_of_man)#">
                <cfpdfformparam name="vehicle_hp_cc" value="#Trim(Form.vehicle_hp_cc)#">
                <cfpdfformparam name="vehicle_seating" value="#Trim(Form.vehicle_seating)#">
                <cfif IsNumeric(Form.vehicle_estimated_value) and Form.vehicle_estimated_value gt 0>
                    <cfpdfformparam name="vehicle_estimated_value" value="#Trim(Form.currency)# #DollarFormat(Form.vehicle_estimated_value)#">
                <cfelse>
                	<cfpdfformparam name="vehicle_estimated_value" value="N/A">    
                </cfif>
                <!--- Removed for testing --->
                <!------>
                <cfpdfformparam name="vehicle_reg_chassis" value="#Trim(Form.vehicle_registration)# / #Trim(Form.vehicle_chassis_number)#">
				
                <cfpdfformparam name="class_of_policy" value="#Trim(Form.class_of_policy)#">
                <cfpdfformparam name="type_of_cover" value="#Trim(Form.type_of_cover)#">
                
                <cfpdfformparam name="uses" value="#Trim(Form.uses)#">
                
                <cfif getSelectedItemForRenewalCN.prem_period is not 'A'>
                    <cfpdfformparam name="period_descr" value="#Trim(Form.period_descr)#">
                </cfif>
                
                   
                <cfpdfformparam name="alterations" value="#Trim(Form.alterations)#">
                <cfpdfformparam name="restrictions_message" value="#Trim(request.restrictionsMessage)#">
                
                <cfif IsNumeric(request.sbranchId)>
                    <cfpdfformparam name="branch_name2" value="#Trim(getBranchInfo.branch_name)# Branch">
                <cfelse>
                    <cfpdfformparam name="branch_name2" value="#Trim(getBrokerInfo.src_name)#">
                </cfif>
        
                <!--- BRITISH VIRGIN ISLANDS --->
                <cfif (form.country_code) is "BVI">
                    <cfpdfformparam name="period_of_insurance" value="#Trim(request.bviPeriodOfInsurance)#">
                </cfif>
                <cfpdfformparam name="initials" value="#Trim(initialsStr)#">
            </cfpdfsubform>
        </cfpdfform> 
        
        <cfset request.pdfFileNameCN = Trim(request.pdfFileName)>
</cfif>
<!---
<cfpdf action="protect" permissions="AllowPrinting,AllowDegradedPrinting,AllowSecure" source="#Trim(covernotePdfPath)##Trim(request.pdfFileName)#" newOwnerPassword="private" destination="#Trim(covernotePdfPath)##Trim(request.pdfFileName)#" overwrite="yes"></cfpdf>--->