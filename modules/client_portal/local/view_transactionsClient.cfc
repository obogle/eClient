<!---
	Cold Fusion Template: 
	Author:			Omari K Bogle
	Date:			22-12-2015
	Modified:		

	Description:	Script to fetch transactions for a specified client 
	
	Parameters:		pymt_id
	 
// --->

<cfcomponent>
	<cfset remote.server = 'ebrokertest.icwi.local'>
    <cffunction access="remote" name="viewTransClient" output="false" returnformat="json">
    	<cfargument name="client_number" required="yes" default="33" />
        
        <!--- Fetch client account --->
        <cfquery name="viewTransClient" datasource="ICWI_MySql_Client_DSN"> 
            SELECT p.pymt_code, d.dev_code, t.trans_id, t.trans_period, p.pymt_name, d.dev_name, t.policy_number, t.branch_id, t.territory_id,
                   l.addr_1, l.addr_2, l.name, l.town, l.parish, l.country, trans_dt, t.trans_status as status_code, s.status_name AS trans_status, t.apt_dt,
                   currency_id, term_amt, late_fee, service_charge, tax_amt, total_payment, d.dev_id, sd.status_decr, t.cancelled_yn
            FROM icwi_tansactions t
            INNER JOIN icwi_payment_options p ON t.pymt_id = p.pymt_id
            INNER JOIN icwi_delivery_options d ON t.dev_id = d.dev_id
            LEFT JOIN icwi_delivery_locations l ON t.loc_id = l.loc_id
            LEFT JOIN icwi_trans_status s ON t.trans_status = s.status_code AND t.dev_id = s.dev_id
            LEFT JOIN icwi_trans_status_desc sd ON s.status_code = sd.status_code AND t.territory_id = sd.territory_id
            WHERE t.client_number = #client_number#
            ORDER BY trans_dt DESC
            LIMIT 0, 4
        </cfquery>
        
        <!--- JSON --->
        <cfset trans_details = [] />
        <cfset default = "False">
        <cfset counter = 1>
        
        <cfif viewTransClient.recordcount eq 0>
        	<cfset obj = 
					{	
						message: "You do not have any online transactions at this time."
					}
			/>
            <cfset arrayAppend(trans_details, obj) />
        </cfif>         
        
        <cfoutput query="viewTransClient"> 
        	<!--- set values --->   
            <cfset request.trans_no = pymt_code & dev_code & "-" & trans_id>
            <cfset request.term_amt = DollarFormat(term_amt)>
            <cfset request.fees = DollarFormat(late_fee + service_charge)>
            <cfset request.tax_amt = DollarFormat(tax_amt)>
            <cfset request.total_payment = DollarFormat(total_payment) & " " & currency_id>
            <cfset request.trans_date = DateFormat(trans_dt,"mmmm d, yyyy")>
            <cfset request.appointment = DateFormat(apt_dt,"mmmm d, yyyy") & " at " & TimeFormat(apt_dt,"h:mm tt")>
            <cfif cancelled_yn is 'Y'>
            	<cfset request.cancelled = 'True'>
            <cfelse>
            	<cfset request.cancelled = 'False'>
            </cfif>    
            
            <!--- Check eClient for document --->
			<!--- set default --->
            <cfif counter eq 1>
                <cfset default = "True">
            <cfelse>
            	<cfset default = "False">
            </cfif>
            <cfset counter = counter + 1>
                  
        	<!--- create icons --->
            <cfif dev_code is 'DL'>
        		<cfset dev_icon = "fa fa-truck">
            <cfelseif dev_code is 'PU'> 
            	<cfset dev_icon = "fa fa-building">   
            <cfelse>
            	<cfset dev_icon = "">
            </cfif> 
            
            <cfif pymt_code is 'OP'>
        		<cfset pymt_icon = "fa fa-credit-card">
            <cfelseif pymt_code is 'IB'>   
            	<cfset pymt_icon = "fa fa-building"> 
            <cfelseif pymt_code is 'PP'> 
             	<cfset pymt_icon = "fa fa-phone">   
            <cfelse>
            	<cfset pymt_icon = "">
            </cfif> 
            
            <cfif dev_code is 'PU'>
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
                <!--- --->
                <cfset messageXML.address = getBranch.branch.branch_detail.branch_address.XmlText>
                <cfset messageXML.name = getBranch.branch.branch_detail.branch_name.XmlText>
                <cfset messageXML.phone = getBranch.branch.branch_detail.branch_phone.XmlText>
                <cfset messageXML.email = getBranch.branch.branch_detail.branch_email.XmlText>
                
                <cfset request.lable = "Pickup From">
                <cfset request.location = "Branch: " & messageXML.name & "\nAddress: " & messageXML.address & "\nPhone: " & messageXML.phone & "\nEmail: " & messageXML.email>
                <cfset request.tabI = "Branch">
                <cfset request.tabII = "Address">
                <cfset request.tabIII = "Phone">
                <cfset request.tabIV = "Email">
                <cfset request.name = messageXML.name>
                <cfset request.address = messageXML.address>
                <cfset request.detailI = messageXML.phone>
                <cfset request.detailII = messageXML.email>
            <cfelseif dev_code is 'DL'>	
            	<cfif addr_2 is not "">
					<cfset address_string = addr_1 & ", " & addr_2>
                <cfelse>
                    <cfset address_string = addr_1>
                </cfif> 
            	<cfset request.lable = "Deliver To">
            	<cfset request.location = "Name: " & name & "\nAddress: " & address_string & "\nTown: " & town & "\nParish: " & parish & "\nCountry: " & country>  
                <cfset request.tabI = "Name">
                <cfset request.tabII = "Address">
                <cfset request.tabIII = "Town">
                <cfset request.tabIV = "Parish">
                <cfset request.name = name>
                <cfset request.address = address_string>
                <cfset request.detailI = town>
                <cfset request.detailII = parish>  
            <cfelse>
            	<cfset request.lable = "Deliver To">
            	<cfset request.location = "No location was defined">
                <cfset request.tabI = "">
                <cfset request.tabII = "">
                <cfset request.tabIII = "">
                <cfset request.tabIV = "">
                <cfset request.name = "">
                <cfset request.address = "">
                <cfset request.detailI = "">
                <cfset request.detailII = "">
            </cfif>   
            
            <cfset obj = 
					{	
						heading: "Transaction Number: " & #request.trans_no#,
						date: "Date: " & #request.trans_date#,
						total: "Total: " & #request.total_payment#,
						link: 'true',
						pos: #default#,
						policy: #policy_number#,
						period: #trans_period#,
						method: #dev_name#,
						cancelled: #request.cancelled#,
						details: [
							{	
								tag: 'Policy Number', 
								link: 'false',
								data: #policy_number#
							},
							{	
								tag: #trans_status#, 
								link: 'false',
								data: #status_decr#
							},						
							{	
								tag: 'Appointment Details', 
								link: 'false',
								data: #request.appointment#
							},
							{	
								tag: 'Payment Method', 
								link: 'false',
								data: #pymt_name#
							}
						],
						delivery: [
							{
								tag: #request.tabI#,
								data: #request.name#	
							},
							{
								tag: #request.tabII#,
								data: #request.address#	
							},
							{
								tag: #request.tabIII#,
								data: #request.detailI#	
							},
							{
								tag: #request.tabIV#,
								data: #request.detailII#	
							}
						],
						payment: [
							{
								tag: 'Term',
								data: #request.term_amt#	
							},
							{
								tag: 'Fees',
								data: #request.fees#	
							},
							{
								tag: 'Tax',
								data: #request.tax_amt#	
							},
							{
								tag: 'Total',
								data: #request.total_payment#	
							}
						]
					}
				/>
            
            <cfset status = "status">
            <cfset obj[status] = []>
            <cfset status_obj = "">
			<!--- Fetch transaction status --->
            <cfquery name="allTransStatus" datasource="ICWI_MySql_Client_DSN"> 
                SELECT order_disp, s.status_code as status_codes, s.status_name, d.status_decr
                FROM icwi_trans_status s
                INNER JOIN icwi_trans_status_desc d ON s.status_code = d.status_code
                WHERE(display_yn = 'Y' OR s.status_code = '#status_code#') 
                AND dev_id = #dev_id#
                AND d.territory_id = #territory_id#
                ORDER BY order_disp
            </cfquery>
            
            <cfset request.count = 1>
            <cfset request.lenght = allTransStatus.recordcount>
            <cfset request.percentage = (request.count/request.lenght)*100>
            <cfset request.order = 0>
            <cfset request.default = request.lenght + 1>
            <cfset request.progress = 'primary'>
            <cfloop query="allTransStatus">
            	<!--- Set order --->
                <cfif IsNumeric(order_disp)>
                	<cfset request.order = order_disp>
                </cfif> 
                
                <!--- Set current state --->
                <cfif status_codes is viewTransClient.status_code>
                    <cfset request.state = 'true'>
                    <cfset request.default = request.order>
                <cfelse>
                    <cfset request.state = 'false'>
                </cfif>
                
                <!--- Progress bar --->                 
                <cfset request.percentage = (request.count/request.lenght)*100>
                <cfset request.count = request.count + 1>
                
                
                <cfif request.order gt request.default>
                	 <cfset request.progress = 'default'> 
                </cfif>
                
            	<cfset status_obj =
					{
						id: #request.order#,
						code: #status_codes#,
						name: #status_name#,
						desc: #status_decr#,
						default: #request.state#,
						progress: #request.progress#,
						bar: #NumberFormat(request.percentage,"00")#
					}               
				/>
				<cfset arrayAppend(obj[status], status_obj) />
            </cfloop>  
            
            <cfset uploads = "uploads">
            <cfset obj[uploads] = []>
            <cfset uploads_obj = "">
            
            <!--- Query database for client uploads --->
            <cfquery name="getUploads" datasource="ICWI_MySql_Client_DSN">  
                SELECT document_type, upload_file, modified_on, policy_number, renewal_period
                FROM icwi_uploads
                WHERE policy_number = '#policy_number#'
                AND renewal_period = '#trans_period#'
            </cfquery>
            
            <cfset pdfFilePath = "http://clickandgo.icwi.com/client/modules/uploads/" & policy_number & "/" & trans_period & "/">
            
            <cfloop query="getUploads">
            	<!--- Get Lock details --->
				<cfset webservice = "https://" & remote.server & "/rest/services/getLockDetails/" & #policy_number# & "/" & #renewal_period# & "/" & #document_type#>
                <cfhttp url="#webservice#" method="get" result="result" throwonerror="yes" resolveurl="yes">
                    <cfhttpparam type="header" name="accept" value="application/xml">
                </cfhttp> 
                <cfset getLockDetails = XMLParse(result.filecontent)>        
                <cfset lockXML = {}>
                <cfset lockXML.name = getLockDetails.lock_info.lock_details.lock_name.XmlText>
                
            	<cfset uploads_obj =
					{	
						name: "Client uploaded: " & #lockXML.name#, 
						link: #pdfFilePath# & #upload_file#, 
						date: #DateFormat(modified_on,"yyyy-mm-dd")# & " " & #TimeFormat(modified_on,"HH:mm:ss")#
					}               
				/>
            	<cfset arrayAppend(obj[uploads], uploads_obj) />
            </cfloop>
            
            <cfset receipt = "receipt">
            <cfset obj[receipt] = []>
            <cfset receipt_obj = "">
            
            <!--- Get Receipt details --->
            <cfset webservice = "https://" & remote.server & "/rest/services/getReceiptXML/" & #policy_number# & "/" & #trans_period#>
            <cfhttp url="#webservice#" method="get" result="result" throwonerror="yes" resolveurl="yes">
            	<cfhttpparam type="header" name="accept" value="application/xml">
            </cfhttp>
            <cfset getReceipt = XMLParse(result.FileContent)>
            <cfset receiptXML = {}>
            <cfset receiptXML.count = getReceipt.receipt.XmlText>
            <cfif receiptXML.count gt 0>
				<cfset receiptXML.name = getReceipt.receipt.receipt_detail.name.XmlText>
                <cfset receiptXML.link = getReceipt.receipt.receipt_detail.link.XmlText>
                <cfset receiptXML.date = getReceipt.receipt.receipt_detail.date.XmlText>
                
                <cfset receipt_obj =
                    {	
                        name: #receiptXML.name# & " for payment",
                        link: #receiptXML.link#,
                        date: #receiptXML.date#
                    }               
                />
                <cfset arrayAppend(obj[receipt], receipt_obj) />
            </cfif>
            <cfset supporting = "supporting">
            <cfset obj[supporting] = []>
            <cfset supporting_combo_obj = "">
            <cfset supporting_renewal_obj = "">
            <cfset supporting_poca_obj = "">
            
            <!--- Get Supporting document details --->
            <cfset webservice = "https://" & remote.server & "/rest/services/getSupportingDoc/" & #policy_number# & "/" & #trans_period#>
            <cfhttp url="#webservice#" method="get" result="result" throwonerror="yes" resolveurl="yes">
            	<cfhttpparam type="header" name="accept" value="application/xml">
            </cfhttp>
            <cfset getSupportingDoc = XMLParse(result.FileContent)>
            <cfset supportingXML = {}>
            
            <cfset supportingXML.combo = getSupportingDoc.supporting.supporting_details.combo.XmlText>
            <cfset supportingXML.renewal = getSupportingDoc.supporting.supporting_details.renewal.XmlText>
            <cfset supportingXML.poca = getSupportingDoc.supporting.supporting_details.poca.XmlText>
            <cfset supportingXML.poca2 = getSupportingDoc.supporting.supporting_details.poca2.XmlText>
            
            <!--- Combined documents--->
            <cfif supportingXML.combo is not "">
            	<cfset supportingXML.comboname = getSupportingDoc.supporting.supporting_details.combo.name.XmlText>
            	<cfset supportingXML.combolink = getSupportingDoc.supporting.supporting_details.combo.link.XmlText>
				<cfset supporting_combo_obj =
                    {	
                        name: #supportingXML.comboname#,
                        link: #supportingXML.combolink#
                    }               
                />
                <cfset arrayAppend(obj[supporting], supporting_combo_obj) />
            </cfif>  
            
            <!--- Renewal documents--->
            <cfif supportingXML.renewal is not "">
            	<cfset supportingXML.renewalname = getSupportingDoc.supporting.supporting_details.renewal.name.XmlText>
            	<cfset supportingXML.renewallink = getSupportingDoc.supporting.supporting_details.renewal.link.XmlText>
				<cfset supporting_renewal_obj =
                    {	
                        name: #supportingXML.renewalname#,
                        link: #supportingXML.renewallink#
                    }               
                />
                <cfset arrayAppend(obj[supporting], supporting_renewal_obj) />
            </cfif>
            
            <!--- Poca documents--->
            <cfif supportingXML.poca is not "">
            	<cfset supportingXML.pocaname = getSupportingDoc.supporting.supporting_details.poca.name.XmlText>
            	<cfset supportingXML.pocalink = getSupportingDoc.supporting.supporting_details.poca.link.XmlText>
				<cfset supporting_poca_obj =
                    {	
                        name: #supportingXML.pocalname#,
                        link: #supportingXML.pocallink#
                    }               
                />
                <cfset arrayAppend(obj[supporting], supporting_poca_obj) />
            </cfif>
            
            <!--- Poca 2 documents--->
            <cfif supportingXML.poca2 is not "">
            	<cfset supportingXML.poca2name = getSupportingDoc.supporting.supporting_details.poca2.name.XmlText>
           		<cfset supportingXML.poca2llink = getSupportingDoc.supporting.supporting_details.poca2.link.XmlText>
				<cfset supporting_poca2_obj =
                    {	
                        name: #supportingXML.poca2name#,
                        link: #supportingXML.poca2link#
                    }               
                />
                <cfset arrayAppend(obj[supporting], supporting_poca2_obj) />
            </cfif>  
            
              
        	<cfset arrayAppend(trans_details, obj) />        
        </cfoutput>
        
        <cfset json = serializeJSON(trans_details) />
    
        <cfreturn json />
        
    </cffunction>
</cfcomponent>   