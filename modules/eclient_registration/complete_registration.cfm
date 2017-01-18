<!---
	Cold Fusion Template: 
	Author:			Omari K Bogle 
	Date:			25-09-2015
	Modified:		Alyssa morgan html email stuff

	Description:	Script to save registration details 
	
	Parameters:		email, password, security question & answer
	
// --->

<!--- Include Random generated code --->
<cfinclude template="ran_script.cfm">

<!--- Form values --->
<cfset policy_number = Form.POLICYNUMBER>
<!--- <cfset id_number = Form.IDNUM> --->
<cfset id_number = ''>
<!--- <cfset id_type = Form.IDTYPESELECT> --->
<cfset id_type = ''>
<cfset client_number = Form.CLIENTNUMBER>
<cfset email_address = Form.regEmail>
<!--- <cfset user_password = HASH(Form.regPassword,"MD5")> --->
<cfset user_password = HASH(Form.regPassword,"SHA-512")>
<cfset security_id = ListGetAt(Form.securityQuestionValidate,1)>
<cfset is_own_quest = ListGetAt(Form.securityQuestionValidate,2)>
<cfset security_question = Form.regQuestion>
<cfset security_answer = Form.regAnswer>
<cfset request.today = DateFormat(Now(),"yyyy-mm-dd") & ' ' & TimeFormat(Now(),"HH:mm:ss")>


<!--- Check if client already exisits --->
<cfquery name="checkForClientI" datasource="ICWI_MySql_Client_DSN"> 
	SELECT u.user_id, u.email_address
    FROM icwi_client_users u
    WHERE u.client_number = '#client_number#'
    AND disable_account = 'False'
</cfquery>

<!--- Save registration information --->
<cfif checkForClientI.recordcount lt 1>
    <cfquery name="saveRegInfo" datasource="ICWI_MySql_Client_DSN">  
        INSERT INTO icwi_client_users 
        (
            policy_number, client_number, email_address, 
            user_password, security_id, own_question, security_answer, tmp_key,
            created_on
        )
        VALUES 
        (
            '#policy_number#', '#client_number#', '#email_address#',
            '#user_password#', '#security_id#',
            <!--- Check if user choose to use there own security question --->
            <cfif is_own_quest is "True">
                '#security_question#', 
            <cfelse>
                NULL,
            </cfif>
            '#security_answer#', '#strPassword#', '#request.today#'
        )   
    </cfquery>
</cfif>

<!--- Check if the client was registered successfully --->
<cfquery name="checkForClient" datasource="ICWI_MySql_Client_DSN"> 
	SELECT u.user_id, u.email_address
    FROM icwi_client_users u
    WHERE u.email_address = '#email_address#'
    AND u.policy_number = '#policy_number#'
    AND disable_account = 'False'
</cfquery>

<!--- Encode URL values --->

<cfset userId = URLEncodedFormat(checkForClient.user_id)>
<cfset activeStatus = URLEncodedFormat(False)>
<!---<cfset userId = HASH(checkForClient.user_id,"SHA-512")>
<cfset activeStatus = HASH("False","SHA-512")>--->

<!--- <cfset urlPageAndValues = 'reg_confirmation.cfm?userId=' & userId & '&activeStatus=' & activeStatus> --->

<!--- Send Email To customer
<cfif checkForClient.recordcount gt 0 and checkForClientI.recordcount lt 1>--->
	<cfset reg_status = "Success!">
    <cfset message = 'Your account has been created and an activation link has been sent to the e-mail address you entered. Note that you must activate the account by clicking on the activation link when you get the e-mail before you can login.'>
	<cfoutput query="checkForClient">
        <cfmail to="#checkForClient.email_address#" 
        		from="ICWI Click & Go <clickandgo@icwi.com>"                  
                subject="ICWI Click & Go Registration"
                <!---
                server="smtp.gmail.com"
                username="clickandgo@icwi.com"
                password="Blank123"
                port="465"
                useSSL ="yes"
				--->
                type="html">
                <!--- Start of HTML email --->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Registration Confirmation</title>
</head>

<body bgcolor="##ffffff">
<table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="##ffffff">
  <tr>
    <td><table width="600" border="0" cellspacing="0" cellpadding="0" bgcolor="##FFFFFF" align="center">
        <!---BANNER--->
        <tr bgcolor="##004059">
          <td><table width="100%" border="0" cellspacing="0" cellpadding="0" style="padding:10px;">
              <tr>
                <td width="395"><a href= "http://www.icwi.com" target="_blank"><img src="http://ebrokertest.icwi.local/email/images/Click&Go_Horizontal_white.png" width="100" height="20" border="0" alt=""/></a>
                <br/><br/>
                </td>
                <td width="203"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td height="46" align="right" valign="middle"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td width="67%" align="right"><font style="font-family:'Myriad Pro', Helvetica, Arial, sans-serif; color:##68696a; font-size:8px;"><a style="display:inline;width:16px;border-style:none!important;border:0!important" href="http://www.icwi.com" target="_blank"><b><font size="2" color="##ffffff">icwi.com</font></b> </a></font> <b style="color:##ffffff">|</b> 
</td>
                            <td width="29%" align="right"><font style="font-family:'Myriad Pro', Helvetica, Arial, sans-serif; color:##68696a; font-size:8px"><a style="display:inline;width:16px;border-style:none!important;border:0!important" href="http://icwi.com/jamaica/contact-us/" target="_blank"><b><font size="2" color="##ffffff">Contact us</font></b></a>
</td>
                            <td width="4%">&nbsp;</td>
                          </tr>
                        </table></td>
                    </tr>
                    <!---
                    <tr>
                      <td height="30"><img src="http://ebrokertest.icwi.local/email/images/blueBorder.jpg" width="393" height="30" border="0" alt=""/></td>
                    </tr>
					--->
                  </table></td>
              </tr>
            </table></td>
            
        </tr>
        <!---/ BANNER--->
        <tr>
          <td>&nbsp;</td>
        </tr>
         <tr>
          <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                  <td>&nbsp;</td>
                </tr>
              <tr >
              	
                <td width="400"><a href= "http://www.icwi.com" target="_blank"><img src="https://ebrokertest.icwi.local/email/images/click&gostatusPic.jpg" width="400" height="300" border="0" alt=""/></a>
				
                <br/>
                </td>
                <td style="padding-left:10px;">
                    <h1 style="color:##777777">Say hello to convenience!</h1>
                   
                    <span style="color:##777777; font-size:14px; ">Just one more step...</span><br/><br/>
                    <span style="color:##777777; font-size:14px;">Please click the link below to activate your account.</span><br/><br/>
                    <span style="color:##777777; font-size:14px;">Once you activate your account, sign in to Click & Go to experience insurance the ICWI way!</span><br/>
                    
                	<a style="color:##777777" href="http://#CGI.SERVER_NAME#/client/modules/eclient_registration/reg_confirmation.cfm?userId=#userId#&activeStatus=#activeStatus#" target="_blank"><img src="http://ebrokertest.icwi.local/email/images/Activation_button.png" width="264" height="106"  border="0" alt=""/></a>
                </td>
              </tr>
            </table></td>
            
        </tr>
        <tr>
           <td height="10" style="border-bottom:4px solid ##d0d1d3"></td>
        </tr>
        <tr>
          <td>&nbsp;</td>
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
            <b>To Contact Us </b>
            <br>
            Please do not reply to this email. If you need assistance, please call 1.888.920.ICWI(4294) or email us at <a href="mailto:direct@icwi.com" style="color:##006;text-decoration:none" target="_blank">direct@icwi.com</a> and one of our friendly Customer Care Representatives will be happy to assist.
            <br><br>
            <b>Privacy</b>
            <br>
            ICWI is committed to protecting your privacy. You can learn more about ICWI's Privacy Policy at <a href="http://icwi.com/privacy" target="_blank">http://icwi.com/privacy</a>.
            <br><br>
          </td>

        </tr>
        <tr>
          <td>&nbsp;</td>
        </tr>
      </table></td>
  </tr>
</table>
</body>
</html>
				<!--- End of HTML email --->  
        </cfmail> 
    </cfoutput>  
  <!---  
<cfelse>
	<cfset reg_status = "Failed">
    <cfset message = 'Oops! There was a problem creating your account. Please contact our customer service department at 1-(888)-920-ICWI for further assistance.'>
</cfif>  ---> 

<!--- Redirect to email page
<cflocation url="registration_complete.cfm">  --->                                                                                  