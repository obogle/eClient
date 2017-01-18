<!---
	Cold Fusion Template: 
	Author:			Omari K Bogle 
	Date:			03-12-2015
	Modified:		Alyssa Morgan HTML email for client

	Description:	Script to store client payment option and details 
	
	Parameters:		user_id
	
// --->

<cfcomponent>
	<!--- Define remote server --->
    <cfset remote.server = "ebrokertest.icwi.local">
    
    <!--- Function --->
    <cffunction access="remote" name="saveTransaction" output="false" returntype="xml">
    	<cfargument name="client_number" required="yes" default="33" />
        <cfargument name="policy_number" required="yes" default="33" />
        <cfargument name="pymt_id" required="yes" default="33" />
        <cfargument name="dev_id" required="yes" default="33" />
        <cfargument name="dev_code" required="yes" default="33" />
        <cfargument name="apt_dt" required="yes" default="33" />
        <cfargument name="branch_id" required="yes" default="33" />
        <cfargument name="addr_1" required="no" default="" />
        <cfargument name="addr_2" required="no" default="" />
        <cfargument name="country" required="no" default="" />
        <cfargument name="parish" required="no" default="" />
        <cfargument name="town" required="no" default="" />
        <cfargument name="phone_number" required="no" default="" />
        <cfargument name="term_amt" required="yes" default="33" />
        <cfargument name="misc_fee" required="yes" default="33" />
        <cfargument name="misc_text" required="yes" default="33" />
        <cfargument name="tax_amt" required="yes" default="33" />
        <cfargument name="stamp_duty" required="yes" default="33" />
        <cfargument name="total_payment" required="yes" default="33" />
        <cfargument name="currency" required="yes" default="33" />
        <cfargument name="tax_label" required="yes" default="33" />
        <cfargument name="dev_name" required="yes" default="33" />
        <cfargument name="pic_name" required="no" default="" />
        <cfargument name="trans_status" required="no" default="33" />
        <cfargument name="plan_code" required="yes" default="33" />
        <cfargument name="renewal_month_year" required="yes" default="33" />
        <cfargument name="system" required="yes" default="33" />
        <cfargument name="card_name" required="yes" default="pnptest" />
        <cfargument name="card_number" required="yes" default="4111111111111111"/>
        <cfargument name="card_exp" required="yes" default="05/05"/>
        <cfargument name="card_cvv" required="yes" default="1111"/>
        <cfargument name="card_amount" required="yes" default="1.00"/> 
        <cfargument name="merchant" required="yes" default="pnptest"/>
        <cfargument name="trans_type" required="yes" default="Renew"/>
        
        <!--- Branch details ---> 
		<cfif IsNumeric(branch_id)>
            <cfset webservice = "https://" & remote.server & "/rest/services/getBranchById/" & #branch_id#>
        <cfelse>
            <cfset webservice = "https://" & remote.server & "/rest/services/getSourceById/" & #branch_id#>
        </cfif>    
        <cfhttp url="#webservice#" method="get" result="result" throwonerror="yes" resolveurl="yes">
            <cfhttpparam type="header" name="accept" value="application/xml">
        </cfhttp> 
        <cfset getBranch = XMLParse(result.filecontent)>        
        <cfset messageXML = {}>
        <cfset messageXML.address = getBranch.branch.branch_detail.branch_address.XmlText>
        <cfset messageXML.name = getBranch.branch.branch_detail.branch_name.XmlText>
        <cfset messageXML.phone = getBranch.branch.branch_detail.branch_phone.XmlText>
        <cfset messageXML.email = getBranch.branch.branch_detail.branch_email.XmlText>
        <cfif messageXML.email is ''>
        	<cfset messageXML.email = 'telestaff@icwi.com'>
        </cfif>
        
        <cfset request.branchemail = #messageXML.email#>
        
        <!--- Set default values --->
        <cfset plugnplay.message = 'none'>
        <cfset new_card_name = card_name> 
		
		<!--- Clean up fields --->
        <!---
        <cfset text_fields = 'dev_id;' & dev_id & ',' & 
						 'dev_code;' & dev_code & ',' & 
						 'apt_dt;' & apt_dt & ',' & 
						 'branch_id;' & branch_id & ',' & 
						 'addr_1;' & addr_1 & ',' & 
						 'addr_2;' & addr_2 & ',' & 
						 'country;' & country & ',' & 
						 'parish;' & parish & ',' & 
						 'town;' & town & ',' &
						 'phone_number;' & phone_number & ',' &  
						 'term_amt;' & term_amt & ',' & 
						 'misc_fee;' & misc_fee & ',' & 
						 'misc_text;' & misc_text & ',' & 
						 'tax_amt;' & tax_amt & ',' & 
						 'stamp_duty;' & stamp_duty & ',' & 
						 'total_payment;' & total_payment & ',' & 
						 'currency;' & currency & ',' & 
						 'dev_name;' & dev_name & ',' & 
						 'pic_name;' & pic_name>
                         
		<cfset no_fields = ListLen(text_fields, ",")>
        --->
        <cfif trans_type is 'Renew'>
        	<cfset request.trans_type = 'RN'>
        <cfelse>
        	<cfset request.trans_type = 'EA'>
        </cfif>    
        
        <!--- Premium details --->
        <cfset fees = misc_fee>
		<cfset request.premium = DollarFormat(term_amt)>
        <cfset request.fees = DollarFormat(fees)>
        <cfset request.tax = DollarFormat(tax_amt)>
        <cfset request.stamp_duty = DollarFormat(stamp_duty)>
        <cfset request.total = DollarFormat(total_payment) & ' ' & currency>
        <cfset request.amt_due = term_amt+fees>
        <!--- <cfset request.stamp_duty = 0.00> --->
        
        <cfset service_charge = 0.00>
        <cfset late_fee = 0.00>
        <cfif misc_text is 'Service Charge:'>
        	<cfset service_charge = misc_fee>	
        <cfelse>
        	<cfset late_fee = misc_fee>
        </cfif>
        <!---
        <cfloop index="d" from="1" to="#no_fields#">     
			<!--- Check if field populated --->
            <cfset lable = ListGetAt(ListGetAt(text_fields,d),1,';','yes')>
            <cfset field = ListGetAt(ListGetAt(text_fields,d),2,';','yes')>
            <cfif field is 'undefined'> 
                <cfset '#lable#' = ''>
            <cfelse>
                <cfset '#lable#' = field>        
            </cfif>
        </cfloop> 
        --->                         
        <!--- Handling delivery --->
		<cfif dev_code is 'PU'>
        	<cfset request.location = "" & messageXML.name & "<br/>Address: " & messageXML.address & "<br/>Phone: " & messageXML.phone & "<br/>Email: " & messageXML.email>
            <cfset location_id = ""> 
            <cfset new_card_name = card_name>
            <cfset request.pic_dev_name = pic_name>
            <cfset request.apt_dt = apt_dt>
       <cfelseif dev_code is 'DL'>
       		<!--- Store delivery address --->
       		<cfquery name="saveLocation" datasource="ICWI_MySql_Client_DSN" result="savedLoc"> 
                INSERT INTO icwi_delivery_locations 
                (
                    name, addr_1, addr_2, country, parish, town
                )
                VALUES 
                (
                    <cfif dev_name is not ''>
                    	'#dev_name#',
                    <cfelse>
                    	NULL,
                    </cfif>
					<cfif addr_1 is not ''>
                    	'#addr_1#',
                    <cfelse>
                    	NULL,
                    </cfif>
                    <cfif addr_2 is not ''>
                    	'#addr_2#',
                    <cfelse>
                    	NULL,
                    </cfif>
                    <cfif country is not ''>
                    	'#country#',
                    <cfelse>
                    	NULL,
                    </cfif>
                    <cfif parish is not ''>
                    	'#parish#',
                    <cfelse>
                    	NULL,
                    </cfif>
                    <cfif town is not ''>
                    	'#town#'
                    <cfelse>
                    	NULL
                    </cfif>
                )
            </cfquery>
            
            <cfquery name="getLocationId" datasource="ICWI_MySql_Client_DSN"> 
                SELECT MAX(loc_id) as new_loc_id FROM icwi_delivery_locations
            </cfquery>
            <cfset location_id = getLocationId.new_loc_id>
            
            <cfif addr_2 is not "">
                <cfset address_string = addr_1 & ", " & addr_2>
            <cfelse>
                <cfset address_string = addr_1>
            </cfif>    
            <cfset request.location = "<strong>Deliver to:</strong><br/>Name: " & dev_name & "<br/>Address: " & address_string & "<br/>Town: " & town & "<br/>Parish: " & parish & "<br/>Country: " & country>	
            <!--- <cfset location_id = ""> --->
            
            <!--- Reset card_name --->
            <cfif card_name is ''>
            	<cfif dev_code is 'DL'>
            		<cfset new_card_name = dev_name>
                <cfelse>
                	<cfset new_card_name = pic_name>
                </cfif>    
            </cfif>
            <cfset request.pic_dev_name = dev_name>
            <cfset request.apt_dt = apt_dt>
       <cfelse>
            <cfset request.location = "None">
            <cfset location_id = ""> 
            <cfset new_card_name = card_name>
            <cfset request.pic_dev_name = "">
            <cfset request.apt_dt = DateFormat(Now(),"yyyy-mm-dd") & ' ' & TimeFormat(Now(),"HH:mm:ss")>
       </cfif>
        
        <!--- get user id --->
        <cfquery name="user" datasource="ICWI_MySql_Client_DSN"> 
            SELECT user_id, email_address, client_number
            FROM icwi_client_users u
            WHERE u.client_number = '#client_number#'
            AND u.disable_account = 'False'
        </cfquery>
        
        <!--- get trans id --->
        <cfquery name="getId" datasource="ICWI_MySql_Client_DSN"> 
            SELECT MAX(trans_id) as last_trans_id FROM icwi_tansactions
        </cfquery>
        
        <!--- Set variables --->
        <cfset request.datetime = DateFormat(Now(),"yyyy-mm-dd") & ' ' & TimeFormat(Now(),"HH:mm:ss")>
        <cfset request.status = 'PP'>
        <cfset request.clientip = CGI.REMOTE_ADDR>
        <cfset staus = 'Failed'>
        <cfif getId.last_trans_id is ''>
        	<cfset request.transid = 0>
        <cfelse>
        	<cfset request.transid = getId.last_trans_id + 1>
        </cfif> 
        <cfif request.apt_dt is not ''>
            <cfset request.aptdate = DateFormat(request.apt_dt,"yyyy-mm-dd")> 
        	<cfset request.aptdate = request.aptdate & ' ' & TimeFormat(request.apt_dt,"HH:mm:ss")> 
        <cfelse>
            <cfset request.aptdate = ""> 
        	<cfset request.aptdate = ""> 
        </cfif> 
        
        <cfset request.paymentcode = ""> 
       
        <!--- get user id --->
        <cfquery name="paymentCode" datasource="ICWI_MySql_Client_DSN"> 
            SELECT pymt_code, country_id
            FROM icwi_payment_options
            WHERE pymt_id = #pymt_id#
        </cfquery>
        
        <cfset request.paymentcode = paymentCode.pymt_code>
        <cfset request.rnwl = 'true'>
        
        <!--- Create transaction based on payment method --->
        <cfif request.paymentcode is 'IB'> <!--- Payment will be made in branch --->   
            <cfset request.status = 'RR'><!--- Set status to Request Received --->
            <cfset request.rnwl = 'false'>
        <cfelseif request.paymentcode is 'PP'> <!--- Payment will be made over the phone ---> 
            <cfset request.status = 'PP'><!--- Set status to Request Received --->
            <cfset request.rnwl = 'false'>
        <cfelse> <!--- Payment will be made online ---> 
        	<cfif trans_status is 'true'>
        		<cfset request.status = 'PS'><!--- Set status to Payment Successful --->
            <cfelse>
            	<cfset request.status = 'PF'><!--- Set status to Payment Failed --->
                <cfset request.rnwl = 'false'>
            </cfif>	    
        </cfif>
        
        <!--- Determine if policy should be renewed --->
        <cfif request.rnwl is 'true'>
        	<cfset request.orderid = request.transid & '-' & policy_number>
        	<!--- Call PlugnPay custom tag with these values --->
            <!--- card amount: "1.00" --->
            <!--- merchant: "pnptest" --->
            <!--- card number: "4111111111111111" --->
            <!--- card expiration: "05/05" --->
            <!--- card name: "pnptest" --->
            <!--- card cvv: "1111" --->
            
            <cfif request.paymentcode is 'OP'>                 
				<!--- Check if the card was charged for the same renewal period --->
                <cfquery name="checkForPayment" datasource="ICWI_MySql_Client_DSN"> 
                    SELECT log_id
                    FROM icwi_trans_payment_log
                    WHERE policy_number = '#policy_number#'
                    AND renewal_month_year = '#renewal_month_year#'
                    AND cancelled_yn = 'N'
                    AND pnp_status = 'success'
                </cfquery>
            
				<cfif checkForPayment.recordcount eq 0>
                    <CF_PlugnPay
                    MERCHANT="#merchant#"
                    PUBLISHER_EMAIL="plugnpay@icwi.com"
                    CARD_NUMBER="#card_number#"
                    CARD_EXP="#card_exp#"
                    CARD_AMOUNT="#total_payment#"
                    CARD_NAME="#new_card_name#"
                    CARD_ADDRESS1="N/A"
                    CARD_ADDRESS2="N/A"
                    CARD_CITY="N/A"
                    CARD_STATE="N/A"
                    CARD_ZIP="11788"
                    CARD_COUNTRY="US"
                    ORDERID="#request.orderid#"
                    XTRAFIELDS="CARD_CVV:ADDRESS1:ADDRESS2"
                    CARD_CVV="#card_cvv#"
                    ADDRESS1="N/A"
                    ADDRESS2="N/A"
                    > 
                    
                    <cfset plugnplay.message = #StructFind(pnpStruct, "FINALSTATUS")#>
                    <!--- <cfset plugnplay.authcode = #StructFind(pnpStruct, "AUTH-CODE")#>  --->
                    
                   
                    <!--- Save record of payment --->
                    <cfquery name="savePymtTrans" datasource="ICWI_MySql_Client_DSN" result="savedPay"> 
                        INSERT INTO icwi_trans_payment_log 
                        (
                            trans_id, policy_number, renewal_month_year, order_id, pnp_status, created_on
                        )
                        VALUES 
                        (
                            '#request.transid#',
                            '#policy_number#',
                            '#renewal_month_year#',
                            '#request.orderid#',
                            '#plugnplay.message#',
                            '#request.datetime#'
                        )
                    </cfquery>
                    
                    <!--- Update transaction status --->
                    <cfif plugnplay.message is not 'success'>
                    	<cfset request.status = 'PF'> 
                    <cfelse>
                    	<cfset pymt_type = 'cc'>
						<cfset sig_user_id = '777'>
                        <cfset card_no = Right(card_number,4)>
                        
                        <cfset webservice = "https://" & remote.server & "/rest/services/createReceiptTEST/" & #policy_number# & "/" & #renewal_month_year# & "/" & #request.orderid# & "/" & #sig_user_id# & "/RN/" & #branch_id# & "/" & #request.amt_due# & "/" & #tax_amt# & "/" & #stamp_duty# & "/" & #total_payment# & "/" & #pymt_type# & "/undefined/undefined/" & #card_no# & "/undefined/undefined/undefined/undefined/undefined">
                       <cfhttp url="#webservice#" method="get" result="result" throwonerror="yes" resolveurl="yes">
                            <cfhttpparam type="header" name="accept" value="application/xml">
                        </cfhttp> 
                        <cfset createReceipt = XMLParse(result.filecontent)>        
                        <cfset receiptXML = {}>
                        <cfset receiptXML.document = createReceipt.receipt.receipt_detail.file_path.XmlText>       
                    </cfif>    
                </cfif>
            </cfif>    
			<!---<cfset plugnplay.message = "success"---> 
         </cfif>
         
         <!---Define transaction status --->
		
        <cfif trans_status is 'true' and (plugnplay.message is 'success' or plugnplay.message is 'none')>
            <cfset trans_status = 'true'>
            <cfset request.message = 'Thank you! Your payment was successful.'>
        <cfelseif plugnplay.message is not 'success' and plugnplay.message is not 'none'>
            <cfset trans_status = 'false'>
            <!--- <cfset request.message = 'Unfortunately there was an issue processing your transaction. Please check your card information and try again.'> --->
            <cfset request.message = 'Oops! There was error processing your payment. Please check your credit card details and try again. If the problem persists, please call 1-888-920-ICWI. Our call centre opening hours are between 7:30am – 5:00pm Monday – Friday.'>             
        <cfelse>
            <cfset trans_status = 'false'>
            <!--- <cfset request.message = 'Unfortunately there was an issue processing your transaction. Please contact us at 1(888)920-ICWI for further details.'> --->
            <cfset request.message = 'Oops! There was error processing your payment. If the problem persists, please call 1-888-920-ICWI. Our call centre opening hours are between 7:30am – 5:00pm Monday – Friday.'> 
        </cfif> 
        
        <cfset request.comment = 'A transaction has just been done on ClickandGo. PNP CODE: ' & plugnplay.message>
       
       <cfif trans_status is 'true'> 
       		<!--- Create transaction number --->
            <cfset request.trans = request.paymentcode & dev_code & '-' & request.transid>
            
            <!--- Create cert/cnote --->
			<cfset webservice = "https://" & remote.server & "/rest/services/createCertCnote/" & #policy_number# & "/" & #system#>
             <cfhttp url="#webservice#" method="get" result="result" throwonerror="yes" resolveurl="yes">
                <cfhttpparam type="header" name="accept" value="application/xml">
            </cfhttp> 
            <cfset createCertCnote = XMLParse(result.filecontent)>        
            <cfset docXML = {}>
            <cfset docXML.recordcount = createCertCnote.cert.cert_detail.recordcount.XmlText>
            <cfset docXML.document = createCertCnote.cert.cert_detail.pdf.XmlText>
            <cfset docXML.type = createCertCnote.cert.cert_detail.type.XmlText>
            <cfset docXML.effective_from = createCertCnote.cert.cert_detail.effective_from.XmlText>
            
            <cfif docXML.type is not 'reissue'>
				<!--- Create update cert/ cnote & generate supporting documents --->
            	<cfset webservice = "https://" & remote.server & "/rest/services/createRnwlDoc/" & #policy_number# & "/" & #renewal_month_year# & "/" & #plan_code# & "/" & #system#>
                 <cfhttp url="#webservice#" method="get" result="result" throwonerror="yes" resolveurl="yes">
                    <cfhttpparam type="header" name="accept" value="application/xml">
                </cfhttp> 
                <cfset createRnwlDoc = XMLParse(result.filecontent)>        
                <cfset rnwlXML = {}>
                <cfset rnwlXML.document = createRnwlDoc.update.update_detail.combined.XmlText>
            
            	<!--- Create receipt --->
				<!---
                <cfif plugnplay.message is 'success'>
					<cfset pymt_type = 'cc'>
                    <cfset sig_user_id = '777'>
                    <cfset card_no = Right(card_number,4)>
                    
                    <cfset webservice = "https://" & remote.server & "/rest/services/createReceiptTEST/" & #policy_number# & "/" & #renewal_month_year# & "/" & #request.orderid# & "/" & #sig_user_id# & "/RN/" & #branch_id# & "/" & #request.amt_due# & "/" & #tax_amt# & "/" & #stamp_duty# & "/" & #total_payment# & "/" & #pymt_type# & "/undefined/undefined/" & #card_no# & "/undefined/undefined/undefined/undefined/undefined">
                   <cfhttp url="#webservice#" method="get" result="result" throwonerror="yes" resolveurl="yes">
                        <cfhttpparam type="header" name="accept" value="application/xml">
                    </cfhttp> 
                    <cfset createReceipt = XMLParse(result.filecontent)>        
                    <cfset receiptXML = {}>
                    <cfset receiptXML.document = createReceipt.receipt.receipt_detail.file_path.XmlText>					
                </cfif>--->    
            </cfif>    
        </cfif>         
         
        <!--- Check eClient for client --->
		<cfset webservice = "https://" & remote.server & "/rest/services/getClientII/" & #client_number#> <!--- A light version of getClient built for speed --->
         <cfhttp url="#webservice#" method="get" result="result" throwonerror="yes" resolveurl="yes">
            <cfhttpparam type="header" name="accept" value="application/xml">
        </cfhttp> 
        <cfset getClient = XMLParse(result.filecontent)>        
        <cfset messageXML = {}>
        <cfset messageXML.client = getClient.client_info.account_details.clnt_name.XmlText>
        <cfset messageXML.branch = getClient.client_info.account_details.branch.XmlText>
        <cfset messageXML.country = getClient.client_info.account_details.country_id.XmlText>
        
        <!--- Get renewal date --->
		<cfset webservice = "https://" & remote.server & "/rest/services/checkRnwlPolicyXML/" & #policy_number# & "/" & #renewal_month_year#>
         <cfhttp url="#webservice#" method="get" result="result" throwonerror="yes" resolveurl="yes">
            <cfhttpparam type="header" name="accept" value="application/xml">
        </cfhttp> 
        <cfset checkRnwlPolicyXML = XMLParse(result.filecontent)>        
        <cfset checkRnwlXML = {}>
        <cfset checkRnwlXML.rnwl_dt = checkRnwlPolicyXML.rnwl.rnwl_detail.rnwl_dt.XmlText>
        <cfset renewal_dt = DateFormat(checkRnwlXML.rnwl_dt, "yyyy-mm-dd") & ' ' & TimeFormat(checkRnwlXML.rnwl_dt, "HH:mm:ss")>
        
        
        <!--- Added for testing --->
        <!---
        <cfset messageXML.client = 'John Brown'>
        --->        
		 <!--- Create transaction --->
         <cfquery name="savePayment" datasource="ICWI_MySql_Client_DSN" result="saved"> 
                INSERT INTO icwi_tansactions 
                (
                    trans_period, trans_type, trans_dt, trans_status, user_id, user_ip, renewal_dt, territory_id,
                    pymt_id, dev_id, apt_dt, branch_id, loc_id, client_number, policy_number, term_amt, callback_number,
                    late_fee, service_charge, tax_amt, stamp_duty, total_payment, currency_id, declined_yn, pic_dev_name 
                )
                VALUES 
                (
                    '#renewal_month_year#',
                    '#request.trans_type#',
                    '#request.datetime#',
                    '#request.status#',
                    #user.user_id#,
                    '#request.clientip#',
                    '#renewal_dt#',
                    '#paymentCode.country_id#',
                    #pymt_id#,
                    <cfif dev_id is not ''>
                        '#dev_id#',
                    <cfelse>
                        NULL,
                    </cfif>
                    <cfif request.aptdate is not ''>
                        '#request.aptdate#',
                    <cfelse>
                        NULL,
                    </cfif>
                    <cfif branch_id is not ''>
                        '#branch_id#',
                    <cfelse>
                        '#messageXML.branch#',
                    </cfif>
                    <cfif location_id is not ''>
                        #location_id#,
                    <cfelse>
                        NULL,
                    </cfif>
                    #client_number#,
                    #policy_number#,
                    #term_amt#,
                    <cfif phone_number is not ''>
                    	'#phone_number#',
                    <cfelse>
                    	NULL,
                    </cfif>
                    #late_fee#,
                    #service_charge#,
                    #tax_amt#,
                    #stamp_duty#,
                    #total_payment#,
                    '#currency#',
                    <cfif trans_status is 'true'>
                    	'N',
                    <cfelse>
                    	'Y',
                    </cfif>
                    <cfif request.pic_dev_name is not "">
                    	'#request.pic_dev_name#'
                    <cfelse>
                   		NULL
                    </cfif>
                )
            </cfquery>
            
            <cfquery name="saveProcess" datasource="ICWI_MySql_Client_DSN" result="savedPro"> 
                INSERT INTO icwi_process_log 
                (
                    trans_id, status_code, status_date, user_id, comment
                )
                VALUES 
                (
                    #request.transid#,
                    '#request.status#',
                    '#request.datetime#',
                    NULL,
                    '#request.comment#'
                )
            </cfquery>
            
            <!--- Add renewal branch to renewal --->
            <cfif saved.recordcount gt 0>
            	<cfset webservice = "https://" & remote.server & "/rest/services/saveRnwlBranch/" & #policy_number# & "/" & #renewal_month_year# & "/" & #branch_id#>
                <cfhttp url="#webservice#" method="get" result="result" throwonerror="yes" resolveurl="yes">
                    <cfhttpparam type="header" name="accept" value="application/xml">
                </cfhttp> 
                <cfset saveRnwlBranch = XMLParse(result.filecontent)>        
                <cfset rnwlXML = {}>
                <cfset rnwlNode = xmlSearch(saveRnwlBranch,'/rnwl_branch/rnwl_details/')> 
                <cfloop from="1" to="#arraylen(rnwlNode)#" index="i"> 
                    <cfset rnwlXML.rows = saveRnwlBranch.rnwl_branch.rnwl_details.rows.XmlText>
                </cfloop>	
            </cfif>
            
            <!--- Documents that require wet signature --->
            <cfset webservice = "https://" & remote.server & "/rest/services/getSupportingDoc/" & #policy_number# & "/" & #renewal_month_year#>
            <cfhttp url="#webservice#" method="get" result="result" throwonerror="yes" resolveurl="yes">
            	<cfhttpparam type="header" name="accept" value="application/xml">
            </cfhttp>
            <cfset getSupportingDoc = XMLParse(result.FileContent)>
            <cfset supportingXML = {}>            
            <cfset supportingXML.combo = getSupportingDoc.supporting.supporting_details.combo.XmlText>
            <cfif supportingXML.combo is not "">
            	<cfset supportingXML.comboname = getSupportingDoc.supporting.supporting_details.combo.name.XmlText>
            	<cfset supportingXML.combolink = getSupportingDoc.supporting.supporting_details.combo.link.XmlText>
            </cfif>  
            
            <!--- Check eClient for document --->
            <cfif plugnplay.message is 'success'>
				<cfset webserviceII = "https://" & remote.server & "/rest/services/getCertCnote/" & #policy_number# & "/" & #renewal_month_year# & "/client">
                 <cfhttp url="#webserviceII#" method="get" result="resultII" throwonerror="yes" resolveurl="yes">
                    <cfhttpparam type="header" name="accept" value="application/xml">
                </cfhttp> 
                <cfset getCertCnote = XMLParse(resultII.filecontent)>        
                <cfset certXML = {}>
                <cfset certXML.label = getCertCnote.documents.documents_detail.document_header.XmlText>
                <cfset certXML.pdf = getCertCnote.documents.documents_detail.document_issued.XmlText>
                <cfset certXML.thumbnail = getCertCnote.documents.documents_detail.document_thumbnail.XmlText>
                <cfset certXML.cert = getCertCnote.documents.documents_detail.cert_issued.XmlText>
                <cfset certXML.cnote = getCertCnote.documents.documents_detail.cnote_issued.XmlText>  
			<cfelse>
            	<cfset certXML.label = "Document pending payment">
                <cfset certXML.pdf = "">  
                <cfset certXML.thumbnail = "http://clickandgo.icwi.com/client/modules/img/nocert_thumpnail.jpg"> 
                <cfset certXML.cert = "False">
                <cfset certXML.cnote = "False"> 
            </cfif>
            
            <!--- Build client message based on territory --->
			<cfset request.clntmessage = messageXML.client & ", thank you for using ICWI Click & Go! Attached is a summary of your transaction">
            <cfif certXML.cert is "True">
                <cfset request.clntmessage = request.clntmessage & ", as well as a copy of your Certificate of Insurance.">
                <cfif messageXML.country is 'JAM'>
                    <cfset request.clntmessage = request.clntmessage & " Remember, you are required by law to have an original Certificate.">
                </cfif>		
            <cfelseif certXML.cnote is "True">
                <cfset request.clntmessage = request.clntmessage & ", as well as a copy of your motor vehicle Cover Note.">
                <cfif messageXML.country is 'JAM'>
                    <cfset request.clntmessage = request.clntmessage & " Remember, you are required by law to have an original Cover Note.">
                </cfif>	
            <cfelse>
                <cfset request.clntmessage = request.clntmessage & ".">		    
            </cfif> 
            
			<!--- Send Email To customer based on payment type --->
            <cfif saved.recordcount gt 0 and trans_status is 'true'>
            	<cfset request.status = ''>
                <cfset staus = 'Success'>
                
                <!--- Check if proof of ID & Address was uploaded by user --->
                <cfquery name="checkForPoca" datasource="ICWI_MySql_Client_DSN"> 
                    SELECT COUNT(*) AS poca_count, document_type 
                    FROM icwi_uploads
                    WHERE document_type IN ('POI','POA')
                    AND policy_number = #policy_number#
                    AND renewal_period = '#renewal_month_year#'
                </cfquery>
                
                <!--- Construct message --->
                <cfset poca_note = "NB: You are required to provide ">
                <cfif checkForPoca.poca_count eq 1>
                	<cfif checkForPoca.document_type is 'POI'>   
                		<cfset poca_note = poca_note & "proof of address along with your completed POCA Form.">
                    <cfelse>
                    	<cfset poca_note = poca_note & "proof of identification along with your completed POCA Form.">
                    </cfif>    
                 <cfelse>
                 		<cfset poca_note = poca_note & "proof of identification and address along with your completed POCA Form.">
                 </cfif>   
                
                <!--- Check if POCA Lock exisit --->
				<cfset webservice = "https://" & remote.server & "/rest/services/getLockDetails/" & #policy_number# & "/" & #renewal_month_year# & "/POCA">
                <cfhttp url="#webservice#" method="get" result="result" throwonerror="yes" resolveurl="yes">
                    <cfhttpparam type="header" name="accept" value="application/xml">
                </cfhttp> 
                <cfset getLockDetails = XMLParse(result.filecontent)>        
                <cfset lockXML = {}>
            	 
                <cfset lockNode = xmlSearch(getLockDetails,'/lock_info/lock_details/lock_name/')> 
                <cfset lockXML.name = getLockDetails.lock_info.lock_details.lock_name.XmlText>
                <!---
                <cfloop from="1" to="#ArrayLen(lockNode)#" index="i"> 
                    <cfset pocaDue = "True">
                </cfloop>
                <cfif ArrayLen(lockNode) eq 0>
                	<cfset pocaDue = "False">
                </cfif>
                --->
                <cfif lockXML.name is "">
                	<cfset pocaDue = "False">
                <cfelse>
                	<cfset pocaDue = "True">
                </cfif>
                <cfoutput query="user">
                    <cfmail to="#user.email_address#"
                    		bcc="#request.branchemail#" 
                            from="ICWI Click & Go <do-not-reply@icwi.com>" 
                            subject="ICWI Click & Go Confirmation"
                            <!---
                            server="smtp.gmail.com" 
                            username="do-not-reply@icwi.com"
                            password="Blank123"
                            port="465"
                            useSSL ="yes"
							--->
                            type="html"
                            failto="obogle@icwi.com">
                            
                    <!--- File attachment of cert/cnote ---> 
                    <cfif trans_status is 'true' and docXML.recordcount is not '0' and plugnplay.message is 'success'>
                    	<!--- Removed for testing --->
                        <!---<cfmailparam file="#docXML.document#" />  --->
                        <!--- <cfmailparam file="#receiptXML.document#" /> --->
                    </cfif>      
                    <!---start HTML email--->
                    <!--- <cfinclude template="includes/email.cfm"> --->
                    
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Renewal Receipt</title>
</head>

<body bgcolor="##ffffff">

<!--8d8e90-->
<table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="##ffffff">
  <tr>
    <td><table width="650px" border="0" cellspacing="0" cellpadding="0" bgcolor="##FFFFFF" align="center">
        <!---BANNER--->
        <tr bgcolor="##004059">
          <td ><table width="100%" border="0" cellspacing="0" cellpadding="0" style="padding:10px;">
              <tr>
                <td width="395"><a href= "http://www.icwi.com" target="_blank"><img src="https://ebroker.icwi.com/email/images/Click&Go_logoWhite_Horizontal.png" width="101" height="40"  border="0" alt=""/></a>
                <br/><br/>
                </td>
                <td width="203"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td height="46" align="right" valign="middle"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td width="67%" align="right"><font style="font-family:'Myriad Pro', Helvetica, Arial, sans-serif; color:##68696a; font-size:8px; "><a style="display:inline;width:16px;border-style:none!important;border:0!important" href="http://www.icwi.com" target="_blank"><b><font size="2" color="##ffffff">icwi.com</font></b> </a></font> <b style="color:##ffffff">|</b> 
</td>
                            <td width="29%" align="right"><font style="font-family:'Myriad Pro', Helvetica, Arial, sans-serif; color:##68696a; font-size:8px"><a style="display:inline;width:16px;border-style:none!important;border:0!important" href="http://icwi.com/jamaica/contact-us/" target="_blank"><b><font size="2" color="##ffffff">Contact us</font></b></a>
</td>
                            <td width="4%">&nbsp;</td>
                          </tr>
                        </table></td>
                    </tr>
                    <!---
                    <tr>
                      <td height="30"><img src="https://ebroker.icwi.com/email/images/blueBorder.jpg" width="393" height="30" border="0" alt=""/></td>
                    </tr>
					--->
                  </table></td>
              </tr>
            </table></td>
            
        </tr>
        <!---/ BANNER--->
  		<tr >
            <td>&nbsp;</td>
          </tr>
        
        
                  
        <tr>
          <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                
                <td width="58%" align="left" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td>&nbsp;</td>
                  </tr>
                  <tr>
                    <td align="left" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td width="95%"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td height="35" align="left" valign="middle" ><font style="font-family:Verdana, Geneva, sans-serif; color:##777777; font-size:25px"><strong>Transaction Details</strong></font></td>
                          </tr>
                          <tr>
                            <td height="20"></td>
                          </tr>
                          <tr>
                            <td align="left" valign="top"><font style="font-family: Verdana, Geneva, sans-serif; color:##777777; font-size:13px; line-height:21px">#request.clntmessage#</font></td>
                          </tr>
                          <tr>
                            <td align="left" valign="top"><font style="font-family: Verdana, Geneva, sans-serif; color:##777777; font-size:13px; line-height:21px">Look out for another email from us with an update on the status of your insurance document.</font></td>
                          </tr>
                          <tr>
                            <td height="20"></td>
                          </tr>
                          
                          <tr>
								<cfif supportingXML.combo is not "">                                        
                                    <font style="font-family: Verdana, Geneva, sans-serif; font-size:16px;color:##777777;"><strong>Outstanding Documents</strong></font> <br />
                                    <br/><br/>
                                    <font style="color:##F00;"><strong>Please find the documents that require the insured(s) signature <a href="#supportingXML.combolink#">here</a>; please print, sign and hand them in. If you were prompted to submit any other documents, don't forget to bring them in! We'll need them in order to issue your Certificate.
                                    </strong></font>
                                </cfif> 
                                <cfif checkForPoca.poca_count lt 2 and pocaDue is 'True'>
                                    <cfif supportingXML.combo is "">
                                        <font style="font-family: Verdana, Geneva, sans-serif; font-size:16px;color:##777777;"><strong>Outstanding Documents</strong></font> <br />
                                        <br/>
                                    <cfelse>
                                        <br/>
                                        <br/>    
                                    </cfif> 
                                    <font style="color:##F00;"><strong>#poca_note#</strong></font>
                                </cfif>
                                <br/><br/>
                          </tr>
                          <tr>
                          	<font style="font-family: Verdana, Geneva, sans-serif; font-size:18px;color:##777777;"><strong>Reference No. #request.trans#</strong></font> <br />
                          </tr>
                         
                          <tr>
                            <td><table width="100%" border="0" cellspacing="0" cellpadding="0">


                              <tr>
                                <td width="43%">
                                <cfif plugnplay.message is 'success'>
                                    <br/>
                                    <font style="font-family:Verdana, Geneva, sans-serif; color:##05bcda; font-size:12px; line-height:20px; text-align:center">
    <a href= "#certXML.pdf#" style="color:##0A98D6; text-decoration:underline"><strong><cfif certXML.pdf IS NOT "">Click to view your </cfif>#certXML.label#</strong></a>
                                    <img src="#certXML.thumbnail#" width="140" height="260" border="0" alt=""/></font></td>
                                <cfelse>
                                	<font style="text-align:center"><strong> #certXML.label#</strong></a>
                                    <img src="#certXML.thumbnail#" width="140" height="230" border="0" alt=""/>
                                </cfif>
                                
                                <td width="57%" align="left" valign="top">
                                  <br/>
                                  <font style="font-family: Verdana, Geneva, sans-serif;color:##777777; font-size:14px"><strong>Policy Number:</strong></font> <br /><br />
                                  <font style="font-family: Verdana, Geneva, sans-serif; color:##777777; font-size:12px; line-height:21px"> #policy_number#</font>
                                  <br/><br/>
                                  
                                  <font style="font-family: Verdana, Geneva, sans-serif;color:##777777; font-size:14px"><strong>Pick up Location:</strong></font> <br /><br />
                                  <font style="font-family: Verdana, Geneva, sans-serif; color:##777777; font-size:12px; line-height:21px"> #request.location#</font>
                                  
                                  <br/><br/>
                                  <font style="font-family: Verdana, Geneva, sans-serif;color:##777777; font-size:14px"><strong>Payment Breakdown:</strong></font> <br /><br />
                                  <font style="font-family: Verdana, Geneva, sans-serif; color:##777777; font-size:12px; line-height:21px; text-align:right"> Premium: #request.premium# </font>
                                  <br/>
                                  <font style="font-family: Verdana, Geneva, sans-serif; color:##777777; font-size:12px; line-height:21px; text-align:right"> Fees: #request.fees#  </font>
                                  <br/>
                                  <cfif request.tax gt 0>
                                  	<font style="font-family: Verdana, Geneva, sans-serif; color:##777777; font-size:12px; line-height:21px;text-align:right"> Tax: #request.tax# </font>
                                  	<br/>
                                  </cfif>
                                  <cfif request.stamp_duty gt 0>
                                  	<font style="font-family: Verdana, Geneva, sans-serif; color:##777777; font-size:12px; line-height:21px;text-align:right"> Stamp Duty: #request.stamp_duty# </font>
                                  	<br/>
                                  </cfif>
                                  <br/>
                                  
                                  <font style="font-family: Verdana, Geneva, sans-serif; color:##777777; font-size:12px; line-height:21px; text-align:right"><strong> Total: #request.total#</strong></font>
                                </td>
                              </tr>
                            </table></td>
                          </tr>
                        </table></td>
                        <td width="5%" style="border-right:2px dashed ##95989a">&nbsp;</td>
                      </tr>
                    </table></td>
                  </tr>
                 
                </table></td>
                
                <td width="42%" align="left" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td width="100%" align="left" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td height="10"> </td>
                      </tr>
                      <tr>
                        <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <!---
                          <tr>
                              <td height="30"><img src="https://ebroker.icwi.com/email/images/blueBorder.jpg" width="393" height="30" border="0" alt=""/></td>
                          </tr>
						  --->
                          <tr>
                          	<td width="88%"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                                
                            </table></td>
                            <!---<td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                              <tr>
                                <td width="12%">&nbsp;</td>
                                <td width="88%" bgcolor="##0A98D6"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                                  <tr>
                                    <td width="5%"></td>
                                    <td width="90%" height="10"></td>
                                    <td width="5%"></td>
                                  </tr>
                                  <tr>
                                    <td>&nbsp;</td>
                                    <td align="center"><font style="font-family:Verdana, Geneva, sans-serif; color:##ffffff; font-size:16px"><strong>VIEW ACCOUNT</strong></font></td>
                                    <td>&nbsp;</td>
                                  </tr>
                                  <tr>
                                    <td></td>
                                    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                                      <tr>
                                        <td height="5" style="border-bottom:1px solid ##ffffff"></td>
                                      </tr>
                                      <tr>
                                        <td height="5"></td>
                                      </tr>
                                    </table></td>
                                    <td></td>
                                  </tr>
                                  <tr>
                                    <td>&nbsp;</td>
                                    <td align="left" valign="top"><font style="font-family: Verdana, Geneva, sans-serif; color:##ffffff; font-size:12px; line-height:21px"><br/>If you would like to go back and view your account, please click'Sign in' below.</td>
                                    <td>&nbsp;</td>
                                  </tr>
                                  <tr>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                  </tr>
                                  <tr>
                                    <td>&nbsp;</td>
                                    <td align="center"><a href="http://yourlink" target="_blank"><img src="http://www.fergusfallsymca.org/fergusfallsymca/site_files/editor_files/image/image/membership/go-to-my-account-button.jpg" alt="view more offers" width="129" height="43" style="display:block" border="0"/></a></td>
                                    <td>&nbsp;</td>
                                  </tr>
                                  <tr>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                  </tr>
                                </table></td>
                                <td width="9%" >&nbsp;</td>
                              </tr>
                            </table></td>--->
                          </tr>
                          <tr>
                            <td height="10"> </td>
                          </tr>
                          <tr>
                            <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                              <tr>
                                <td width="12%">&nbsp;</td>
                                
                                
                                
                                <td width="88%"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                                	<!---
									<cfif supportingXML.combo is not "">                                        
                                        <font style="font-family: Verdana, Geneva, sans-serif; font-size:16px;color:##777777;"><strong>Outstanding Documents</strong></font> <br />
                                        <br/>
                                        <font style="color:##F00;"><strong>If someone other than the insured is collecting the insurance documents, the following need to be printed and signed by the insured:</strong></font> <a href="#supportingXML.combolink#">Click here</a>.
                                    </cfif> 
                                    <cfif checkForPoca.recordcount lt 2 and pocaDue is 'True'>
                                    	<cfif supportingXML.combo is "">
                                            <font style="font-family: Verdana, Geneva, sans-serif; font-size:16px;color:##777777;"><strong>Outstanding Documents</strong></font> <br />
                                            <br/>
                                        <cfelse>
                                        	<br/>
                                            <br/>    
                                        </cfif>    
                                        <font style="color:##F00;"><strong>NB: You are required to provide proof of identification and address along with your completed POCA Form.</strong></font>
                                    </cfif>
                                    <br/><br/>
									--->
                                    <a href="http://clickandgo.icwi.com" ><img src="https://ebroker.icwi.com/email/images/ViewAccount_Tile+Button.png" /></a>
                                    <br/><br/>
                                	<img src="https://ebroker.icwi.com/email/images/Need_help_tile.png" />
                                    
                                    <cfif plugnplay.message is 'success' and receiptXML.document is not ''>
                                        <br/><br/>
                                        <h3 style="color:##777777">Click the icon below to view your receipt</h3>
                                        <br/>
                                    	
                                        <a href="#receiptXML.document#">
                                            <img src="http://clickandgo.icwi.com/client/modules/img/receiptIcon.png" width="50" height="50">
                                            <br/>
                                            Receipt of payment
                                         </a>
                                          
                                	</cfif>
                                     
                                </table></td>
                                
                                <td width="9%" >&nbsp;</td>
                              </tr>
                            </table></td>
                          </tr>
                          <tr>
                            <td>&nbsp;</td>
                          </tr>
                        </table></td>
                      </tr>
                    </table></td>
                    
                  </tr>
                </table></td>
              </tr>
            </table></td>
        </tr>
        <tr>
          <td>&nbsp;</td>
        </tr>
       
        <tr>
            <!---<td align="center" style="background-image:url('https://ebroker.icwi.com/email/images/ReferToAfreind.jpg');background-size: 720px 222px; background-repeat: no-repeat; width: 720px; height: 222px;">
           <a href= "http://yourlink" target="_blank"><img src="http://esskaypacks.in/wp-content/uploads/2013/04/just-relax-208977.jpg" alt="" width="598" height="269" border="0"/></a>--->
           <td  <td align="center">
            <img src="https://ebroker.icwi.com/email/images/ReferToAfreind.jpg" width: 650px; height: 200px;>
          </td>
        </tr>
        
        <tr>
          <td><table width="100%" border="0" cellspacing="0" cellpadding="0" style="color##ffffff; padding:10px;">
             
            <tr bgcolor="##004059">
                <td height="40" width="500" colspan="5" style="padding:10px;">
                	<span style="color:##ffffff">Copyright <cfoutput>#year(now())#</cfoutput> | All Rights Reserved</span>
                </td>
                <td>
                <a style="display:inline;width:16px;border-style:none!important;border:0!important" href="http://www.facebook.com/icwigroup" target="_blank"><img width="30" height="30" border="0" style="display:inline" src="http://icwi.com/jamaica/files/2016/03/FB_flatwhite.png" alt="facebook"></a> 
                <a style="display:inline;width:16px;border-style:none!important;border:0!important" href="https://twitter.com/icwi_jamaica" target="_blank"><img width="26" height="26" border="0" style="display:inline" src="http://icwi.com/jamaica/files/2016/03/Twitter_whiteflat.png" alt="twitter"></a>
                </td>
            </tr>

          </table></td>
        </tr>
        <tr>
          <td>&nbsp;</td>
        </tr>
       <tr>
          <td style="font-size:10px;font-weight:normal;color:##808080;font-family:Helvetica,Arial,sans-serif">
          	
            You have received this email because you are a client of ICWI and as such we are permitted under the terms of our contract with you to send you correspondence, or you have chosen to receive this communication.
            <br><br>
            <!---
            <cfif request.paymentcode is 'OP'> 
            	<b>About Your Transaction</b> 
                Authorization number: #plugnplay.authcode# Merchant number: #merchant# Order number: #request.orderid# Processing date: #request.datetime# Company trade name: The Insurance Company of the West Indies. Branch address: #messageXML.address#
                <br/><br/>
            </cfif>
			--->
            <b>To Contact Us </b>
            <br>
            Please do not reply to this email. If you need assistance, please call 1.888.920.ICWI(4294) or email us at <a href="mailto:telestaff@icwi.com" style="color:##006;text-decoration:none" target="_blank">telestaff@icwi.com</a> and one of our friendly Customer Care Representatives will be happy to assist. Our call centre opening hours are between 7:30am – 5:00pm Monday – Friday.
            <br><br>
            <b>Privacy</b>
            <br>
            ICWI is committed to protecting your privacy. You can learn more about ICWI's Privacy Policy at <a href="http://icwi.com/privacy" target="_blank">http://icwi.com/privacy</a>.
            <br><br>
          </td>

        </tr>
        <tr>
       
        <tr>
          <td>&nbsp;</td>
        </tr>
      </table></td>
  </tr>
</table>
</body>
</html>                           
                   <!---end HTML email --->     
                    </cfmail>
                </cfoutput>  
            </cfif>
        
        <cfxml variable="XMLEval">
        <payment>
        	<payment_info>
            <cfoutput>
            	<payment_status>#request.message#</payment_status> 
                <trans_id>#request.transid#</trans_id>  
                <trans_success>#trans_status#</trans_success> 
                <trans_saved>#saved.recordcount#</trans_saved> 
                <plugnplay>#plugnplay.message#</plugnplay>  
                <test></test>          
            </cfoutput>    
            </payment_info>    
        </payment>
        </cfxml>
        <cfset XMLString = toString(XMLEval)>
        
        <cfreturn XMLEval>
    </cffunction>
</cfcomponent>   