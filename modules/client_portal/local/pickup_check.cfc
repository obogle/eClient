<!---
	Cold Fusion Template: 
	Author:			Omari K Bogle 
	Date:			15-03-2016
	Modified:		

	Description:	Script to fetch branch pickup days and time 
	
	Parameters:		branch_id, date_time
	 
// --->

<cfcomponent>
    <cffunction access="remote" name="pickUpChecker" output="false" returnformat="json">
    	<cfargument name="branch_id" required="yes" default="33" />
        <cfargument name="date_time" required="yes" default="33" />
        <cfargument name="dev_code" required="yes" default="33" />
        <cfargument name="pymt_code" required="yes" default="33" />
        <cfargument name="policy_no" required="yes" default="33" />
        <!--- <cfargument name="rnwl_type" required="yes" default="33" /> --->
        <cfargument name="rnwl_period" required="yes" default="33" />
             
        <!--- Fetch operating --->
        <cfquery name="getBranchDayTime" datasource="ICWI_MySql_Client_DSN"> 
            SELECT d.day_id, d.day_name, t.open_time, t.close_time
            FROM icwi_operations o
            INNER JOIN icwi_operation_day d ON o.day_id = d.day_id
            INNER JOIN icwi_operation_time t ON o.time_id = t.time_id
            <cfif IsNumeric(branch_id)>
            	<cfset request.branch_id = #branch_id#>
            	WHERE o.branch_id = '#request.branch_id#'
			<cfelseif branch_id is 'undefined'>
            	<!--- Fetch policy branch --->
                <cfset webservice = "https://ebrokertest.icwi.local/rest/services/getPolicy/" & policy_no>
                <cfhttp url="#webservice#" method="get" result="result" throwonerror="yes" resolveurl="yes">
                    <cfhttpparam type="header" name="accept" value="application/xml">
                </cfhttp> 
                <cfset getPolicyBranch = XMLParse(result.filecontent)>        
                <cfset policyBranchXML = {}>
                <cfset policyBranchXML.branch = getPolicyBranch.client_info.policy_details.branch_id.XmlText>
                <cfset policyBranchXML.country = getPolicyBranch.client_info.policy_details.country_id.XmlText>
                <cfset policyBranchXML.territory = getPolicyBranch.client_info.policy_details.territory_id.XmlText>
                <cfif policyBranchXML.country is 'JAM'>
            		<cfset request.branch_id = 1>
                <cfelse>
                	<cfset request.branch_id = policyBranchXML.branch>
                </cfif>    
            	WHERE o.branch_id = #request.branch_id#
            <cfelse>
            	<cfset request.branch_id = #branch_id#>
            	WHERE CONCAT(o.src_type,o.src_id) = '#request.branch_id#'                
            </cfif>   
            AND dev_code = '#dev_code#' 
        </cfquery>
        
        <!--- Build operational hours message --->
        <!--- Limitations: 1. Does not consider different opening hours --->
        <cfset operational_days = getBranchDayTime.recordcount>
        <cfset operational_messages = "">
        <cfset delivery_hours = "">
        <cfset weekdays_list = "">
        <cfset weekenddays_list = "">
        <cfset rowcounter = 0>
        <cfset weekday_start = ''>
        <cfset weekday_end = ''>
        <cfset weekend_start = ''>
        <cfset weekend_end = ''>
        <cfset weekday_hours = ''>
        <cfset weekend_hours = ''>    
        <cfset status = "">
        <cfset message = "">    
        <cfset check = "true">
        <cfset disclaimer = "">
        
        <!--- Store branch opening days --->
        <cfset weekdays_list = ValueList(getBranchDayTime.day_id)>
        <cfset weekdays_listII = ValueList(getBranchDayTime.day_id)>
        
        <!--- Check if branch opens on weekends --->
        <cfset sun = ListContains(weekdays_list,1)>
        <cfset sat = ListContains(weekdays_list,7)>
        <cfif sun gt 0>
        	<cfset weekdays_list = ListDeleteAt(weekdays_list, sun)>	
        	<cfset weekenddays_list = ListAppend(weekenddays_list, 1)>	
        </cfif>
        <cfif sat gt 0>
        	<cfset weekdays_list = ListDeleteAt(weekdays_list, sat)>	
            <cfset weekenddays_list = ListAppend(weekenddays_list, 7)>
        </cfif>
        
        <!--- Find first and last operational week day --->
        <cfset first_day = ArrayMin(ListToArray(weekdays_list))>
        <cfset last_day = ArrayMax(ListToArray(weekdays_list))>
        <cfif first_day is last_day>
        	<cfset first_day = "">
        </cfif>
        
        <!--- Find first and last operational weekend day --->
        <cfset first_weekend_day = ArrayMin(ListToArray(weekenddays_list))>
        <cfset last_weekend_day = ArrayMax(ListToArray(weekenddays_list))>
        <cfif first_weekend_day is last_weekend_day>
        	<cfset first_weekend_day = "">
        </cfif>
        
        <cfloop query="getBranchDayTime">
        	<!--- Track record count --->
        	<cfset rowcounter ++ />
            
            <!--- Set first weekday --->
            <cfif day_id eq first_day>
            	<cfset weekday_start = day_name>
            </cfif>
            
            <!--- Set last weekday --->
            <cfif day_id eq last_day>
            	<cfset weekday_end = day_name>
                <cfset weekday_hours = TimeFormat(open_time, "h:mm tt") & ' - ' & TimeFormat(close_time, "h:mm tt")>
                <cfset delivery_hours = TimeFormat(open_time, "h:mm tt") & ' - ' & TimeFormat(close_time, "h:mm tt")>
            </cfif>
            
            <!--- Set first weekend --->
            <cfif day_id eq first_weekend_day>
            	<cfset weekend_start = day_name>
            </cfif>
            
            <!--- Set last weekend --->
            <cfif day_id eq last_weekend_day>
            	<cfset weekend_end = day_name>
                <cfset weekend_hours = TimeFormat(open_time, "h:mm tt") & ' - ' & TimeFormat(close_time, "h:mm tt")>
                <cfset delivery_hours = TimeFormat(open_time, "h:mm tt") & ' - ' & TimeFormat(close_time, "h:mm tt")>
            </cfif>
            
            <!--- Set message --->
            <cfif rowcounter eq operational_days>
            	<!--- Weekdays --->
            	<cfif weekday_start is not ''>
					<cfset operational_messages = weekday_start>
                </cfif>  
                <cfif weekday_end is not ''>
					<cfset operational_messages = operational_messages & " - " & weekday_end & " " & weekday_hours>
                <cfelse>
                	<cfset operational_messages = operational_messages & " " & weekday_hours>	    
                </cfif> 
                
                <!--- Weekend --->
                <cfif weekend_start is not ''>
					<cfset operational_messages = operational_messages & " & " & weekend_start>
                </cfif>  
                <cfif weekend_end is not '' and weekend_start is not ''>
					<cfset operational_messages = operational_messages & " - " & weekend_end & " " & weekend_hours>
                <cfelseif weekend_end is not '' and weekend_start is ''>
                	<cfset operational_messages = operational_messages & " & " & weekend_end & " " & weekend_hours>	    
                </cfif>
            </cfif>    
        </cfloop>
        
        <!--- Setup pickup date & time --->
        <cfset dd = DateFormat(date_time,"dd")>
        <cfset mm = DateFormat(date_time,"mm")>
        <cfset yyyy = DateFormat(date_time,"yyyy")>
        <cfif dev_code is "DL">
        	<cfset pickup_time = "17:00:00">
        <cfelse>    
            <cfset pickup_time = TimeFormat(date_time,"HH:mm:ss")>
        </cfif>    
        <cfset return_datetime = "You entered " & DateFormat(date_time,"dddd mmmm d, yyyy") & " at " & TimeFormat(date_time,"h:mm tt") & ".">
        
        <!--- Create day of week value --->
		<cfset Date = CreateDate(yyyy, mm, dd)>
        <cfset day_of_week = DayOfWeek(Date)>
        <cfset day_of_week_string = DayOfWeekAsString(day_of_week)>
        
        <!--- Fetch operating --->
        <cfquery name="checkBranchDayTime" datasource="ICWI_MySql_Client_DSN"> 
            SELECT d.day_id, d.day_name, t.open_time, t.close_time
            FROM icwi_operations o
            INNER JOIN icwi_operation_day d ON o.day_id = d.day_id
            INNER JOIN icwi_operation_time t ON o.time_id = t.time_id
            <cfif IsNumeric(request.branch_id)>
            	WHERE o.branch_id = '#request.branch_id#'
            <cfelse>
            	WHERE CONCAT(o.src_type,o.src_id) = '#request.branch_id#'                
            </cfif> 
            AND d.day_id = '#day_of_week#'
			AND '#pickup_time#' BETWEEN t.open_time AND t.close_time
        </cfquery>
        
        <!--- JSON --->
        <cfset operating_details = [] />
        
        <!--- Fetch renewal date --->
        <cfset webservice = "https://ebrokertest.icwi.local/rest/services/checkRnwlPolicyXML/" & policy_no & "/" & rnwl_period>
        <cfhttp url="#webservice#" method="get" result="result" throwonerror="yes" resolveurl="yes">
            <cfhttpparam type="header" name="accept" value="application/xml">
        </cfhttp> 
        <cfset getPolicy = XMLParse(result.filecontent)>        
        <cfset policyXML = {}>
        <cfset policyXML.rnwl_dt = getPolicy.rnwl.rnwl_detail.rnwl_dt.XmlText>
        <cfset policyXML.rnwl_type = getPolicy.rnwl.rnwl_detail.rnwl_type.XmlText>
            
        <cfif pymt_code is 'IB'>
			<!--- Days the policy lapsed --->
            <cfset apt_dt = DateFormat(date_time,"yyyy-mm-dd")>
            <cfset today_dt = DateFormat(NOW(),"yyyy-mm-dd")>
            <cfset daysBtwnRnwlAndApt = DateDiff('d', policyXML.rnwl_dt, apt_dt)> <!--- Number of days between renewal date and appointment date --->
            <cfset daysPlcyLapsed = DateDiff('d', policyXML.rnwl_dt, today_dt)>  <!--- Number of days between renewal date and today's date --->
            <cfset daysBtwnTodayAndApt = DateDiff('d', today_dt, apt_dt)>  <!--- Number of days between today's date and appointment date --->
        <cfelse>
            <cfset daysBtwnRnwlAndApt = 0>
            <cfset daysPlcyLapsed = 0> 
            <cfset daysBtwnTodayAndApt = 0>      
        </cfif>
        
       	<!--- Fetch branch name ---> 
        <cfif IsNumeric(request.branch_id)>
        	<cfset webservice = "https://ebrokertest.icwi.local/rest/services/getBranchById/" & #request.branch_id#>
         <cfelse>
         	<cfset webservice = "https://ebrokertest.icwi.local/rest/services/getSourceById/" & #request.branch_id#>
         </cfif>
        <cfhttp url="#webservice#" method="get" result="result" throwonerror="yes" resolveurl="yes">
            <cfhttpparam type="header" name="accept" value="application/xml">
        </cfhttp> 
        <cfset getBranch = XMLParse(result.filecontent)>        
        <cfset messageXML = {}>
        <cfset messageXML.name = getBranch.branch.branch_detail.branch_name.XmlText>
        <cfif IsNumeric(request.branch_id)>
        	<cfset messageXML.name = messageXML.name & ' branch'>
        <cfelse>
        	<cfset messageXML.name = messageXML.name & ' agent office'>
        </cfif>    
        <cfset messageXML.code = getBranch.branch.branch_detail.branch_code.XmlText>
        
        <!--- Fetch public holidays --->
        <cfquery name="getPublicHolidays" datasource="ICWI_MySql_Client_DSN"> 
            SELECT holiday_name
            FROM icwi_holidays h
            WHERE country_id = '#messageXML.code#'
            AND holiday_date = '#DateFormat(date_time,"yyyy-mm-dd")#'
        </cfquery>
        
        <!--- Fetch alternate payment options for the territory --->
        <cfquery name="getTerritoryPymtOptions" datasource="ICWI_MySql_Client_DSN"> 
            SELECT GROUP_CONCAT(pymt_code) AS pymt_code
            FROM icwi_payment_options
            WHERE country_id = 3
            AND active_yn = 'Y'
            GROUP BY country_id
        </cfquery>
        
        <!--- Set default threshole based on delivery --->
        <cfif  dev_code is 'DL'>
        	<cfset default_threshole = 24>
        <cfelse>
        	<cfset default_threshole = 3>
        </cfif>    
        
        <!--- Check if day and time entered is available --->
        <cfset datetime = DateFormat(Now(), "yyyy-mm-dd") & ' ' & TimeFormat(Now(), "HH:mm:ss")> <!--- Current date & time --->
        <!--- Determine how many hours are between the current date & time and the date & time selected by the user --->
        <cfif  dev_code is 'DL'>
        	<cfset datetime_threshole = DateDiff('h', DateFormat(datetime,"yyyy-mm-dd"), DateFormat(date_time,"yyyy-mm-dd"))>
        <cfelse>
        	<cfset datetime_threshole = DateDiff('h', datetime, date_time)>
        </cfif>  
        <cfif daysPlcyLapsed gt 0 and daysBtwnTodayAndApt gt 5> <!--- Late renewals with apt date over five days --->
        	<cfset status = "false">
            <cfset check = "false">
            <cfif policyXML.rnwl_type is 'Renew'>
            	<cfset message = "Oops! " & return_datetime & " Renewals are allowed for up to 5 days past the renewal date. The appointment date you selected is past this threshold. Please select an earlier date or change your payment option to 'online'"> 
            <cfelse>
            	<cfset message = "Oops! " & return_datetime & " Payment plan extensions are allowed for up to 5 days past the renewal date. The appointment date you selected is past this threshold. Please select an earlier date or change your payment option to 'online'"> 
            </cfif> 
            
            <!--- Apply message if pay by phone option is available for the territory --->
        	<cfif ListContains(getTerritoryPymtOptions.pymt_code, 'PP') neq 0>  
            	<cfset message = message & " or over the phone"> 
            </cfif>
            
        <cfelseif daysPlcyLapsed lte 0 and daysBtwnRnwlAndApt gt 0> <!--- Ontime renewals with apt date after the rnwl date --->
        	<cfset status = "false">
            <cfset check = "false">	
            
            <!--- Default message --->
            <cfset message = "Oops! " & return_datetime & " The date you selected would be after your renewal date '" & DateFormat(policyXML.rnwl_dt,"mmmm d, yyyy") & "'. Please select another date before your renewal date or change your payment option to 'online'">
            
            <!--- Apply message if pay by phone option is available for the territory --->
        	<cfif ListContains(getTerritoryPymtOptions.pymt_code, 'PP') neq 0>  
            	<cfset message = message & " or over the phone"> 
            </cfif>  
        
            <!---
			<cfif messageXML.code is 'JAM'>  
                <cfset message = "Oops! " & return_datetime & " The date you selected would be after your renewal date '" & DateFormat(policyXML.rnwl_dt,"mmmm d, yyyy") & "'. Please select another date before your renewal date or change your payment option to 'online' or over the phone">    
            <cfelse>
                <cfset message = "Oops! " & return_datetime & " The date you selected would be after your renewal date '" & DateFormat(policyXML.rnwl_dt,"mmmm d, yyyy") & "'. Please select another date before your renewal date or change your payment option to 'online'">
            </cfif>
        	--->
        </cfif>
		<!---
		<cfif daysBtwnRnwlAndApt gt 0 and ((daysBtwnTodayAndApt gt 5 and policyXML.rnwl_type is 'Renew') or (daysBtwnTodayAndApt gt 5 and policyXML.rnwl_type is 'Extend'))> <!--- date for in branch payment type --->
        	<cfset status = "false">
            <cfset check = "false">
            <cfif daysPlcyLapsed lte 0>
            	<cfset message = "Oops! " & return_datetime & " The date you selected would be after your renewal date '" & DateFormat(policyXML.rnwl_dt,"mmmm d, yyyy") & "'. Please select another date before your renewal date or change your payment option to online or over the phone."> 
            <cfelseif daysPlcyLapsed gt 0 and daysBtwnTodayAndApt gt 5 and policyXML.rnwl_type is 'Renew'>
            	<cfset message = "Oops! " & return_datetime & " Renewals are allowed for up to 5 days past the renewal date. The appointment date you selected is past this threshold. Please select an earlier date or change your payment optionto online or over the phone"> 
            <cfelseif daysPlcyLapsed lt 10 and daysBtwnTodayAndApt gt 5 and policyXML.rnwl_type is 'Extend'>
            	<cfset message = "Oops! " & return_datetime & " Payment plan extensions are allowed for up to 5 days past the renewal date. The appointment date you selected is past this threshold. Please select an earlier date or change your payment option to online or over the phone."> 
            </cfif> 
        </cfif>       
        --->
        
        <!--- Disclaimer --->
        <cfif policyXML.rnwl_type is "Renew" and pymt_code is not "OP">  
			<cfset disclaimer = "Please ensure payment is made by the appointed time otherwise, your renewal request will be cancelled."> 
        <cfelseif policyXML.rnwl_type is "Extend" and pymt_code is not "OP">
            <cfset disclaimer = "Please ensure payment is made by the appointed time otherwise, your request to extend your policy will be cancelled. Note also that your premium may be subject to change once your renewal date has past.">
        </cfif> 
        
		<cfif check is 'true' and checkBranchDayTime.recordcount gt 0 and datetime_threshole gte default_threshole and getPublicHolidays.recordcount eq 0> <!--- Date & time is more than the default threshhold; within branch operationg day & time; date not a public holidy --->
        	<cfset status = "true">
            <cfif  dev_code is 'DL'>
            	<!---<cfset message = "Great! Some one will deliver your Certificate or Cover Note on " & day_of_week_string & ' ' & DateFormat(date_time,"mmmm d, yyyy") & ' between the hours of ' & delivery_hours & '. ' & disclaimer>--->
                <cfset message = "Great! Your Certificate or Cover Note will be delivered on " & day_of_week_string & ' ' & DateFormat(date_time,"mmmm d, yyyy") & ' between the hours of ' & delivery_hours & '. ' & disclaimer>
        	<cfelse>
				<cfset message = "Great! See you on " & day_of_week_string & ' ' & DateFormat(date_time,"mmmm d, yyyy") & ' at ' & TimeFormat(pickup_time, "h:mm tt") & ' at our ' & messageXML.name & '. ' & disclaimer>
            </cfif>    
        <cfelseif check is 'true' and getPublicHolidays.recordcount gt 0> <!--- date is a public holiday --->
        	<cfset status = "false">
        	<cfif  dev_code is 'DL'>
            	<cfset message = "Oops! " & return_datetime & " Unfortunately we do not deliver on " & getPublicHolidays.holiday_name & " (public holiday). Please select another time."> 
        	<cfelse>
				<cfset message = "Oops! " & return_datetime & " Unfortunately our " & messageXML.name & " will not be open on " & getPublicHolidays.holiday_name & " (public holiday). Please select another time.">
            </cfif>
		<cfelseif check is 'true' and checkBranchDayTime.recordcount gt 0 and (datetime_threshole lt default_threshole and datetime_threshole gte 0) and dev_code is 'DL'> <!--- Date & time is within operating day & time; less than the default threshhold for delivery --->
        	<cfset status = "false">
        	<cfset message = "Oh no! " & return_datetime & " We need at least " & default_threshole & " hours to prepare your documents. Please select another time.">  
        <cfelseif check is 'true' and checkBranchDayTime.recordcount gt 0 and (datetime_threshole lt default_threshole and datetime_threshole gte 0) and dev_code is 'PU'> <!--- Date & time is within operating day & time; less than the default threshhold for pickup --->
        	<cfset status = "false">
        	<cfset message = "Oh no! " & return_datetime & " We need at least " & default_threshole & " hours to prepare your documents. Please select another time.">        
		<cfelseif check is 'true' and datetime_threshole lt default_threshole and datetime_threshole lt 0> <!--- Date & time has already passed --->
        	<cfset status = "false">
        	<cfset message = "Oh no! " & return_datetime & " This appointment date & time has already past. Please select another time.">
        <cfelseif check is 'true'> <!--- Date & time is not within operating day & time --->
        	<cfset status = "false">
            <cfif  dev_code is 'DL'>
            	<cfset message = "Oops! " & return_datetime & " We only deliver " & operational_messages & '. Please select another time.'>
        	<cfelse>
				<cfset message = "Oops! " & return_datetime & " Our " & messageXML.name & " is only operational " & operational_messages & '. Please select another time.'>
            </cfif>  
        </cfif>            
        
        <cfoutput>
        	<cfif Arguments.branch_id is not 'undefined' or (dev_code is 'DL' or dev_code is 'PT')>
				<cfset obj = 
                        {	
                            date_available: #status#,
                            message: #message#,
                            test: "daysBtwnRnwlAndApt:" & #daysBtwnRnwlAndApt# & ", daysPlcyLapsed:" & #daysPlcyLapsed# & ", daysBtwnTodayAndApt:" & #daysBtwnTodayAndApt# & ': ' & #policyXML.rnwl_dt# & ", check:" & #check#
                        }
                    />
            <cfelse>
            	<cfset obj = 
                        {	
                            message: 'You have not selected a branch yet!'
                        }
                    />
            </cfif>        
        	<cfset arrayAppend(operating_details, obj) />        
        </cfoutput>
        
        <cfset json = serializeJSON(operating_details) />
    
        <cfreturn json />
    </cffunction>
</cfcomponent>   