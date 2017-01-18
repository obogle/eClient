 2
 3<!---
  cvb	3+6Cold Fusion Template: 
	Author:			Omari K Bogle 
	Date:			25-09-2015
	Modified:		

	Description:	Script to save registration details 
	
	Parameters:		email, password, security question & answer
	
// --->


<cfcomponent>
    <cffunction access="remote" name="clientRegistration" output="false" returntype="xml">
        <cfargument name="policy_number" required="yes" default="33" />
        <cfargument name="id_number" required="yes" default="33" />
        <cfargument name="id_type" required="yes" default="33" />
        <cfargument name="client_number" required="yes" default="33" />
        <cfargument name="email_address" required="yes" default="33" />
        <cfargument name="user_password" required="yes" default="33" />
        <cfargument name="security_id" required="yes" default="33" />
        <cfargument name="is_own_quest" required="yes" default="33" />
        <cfargument name="security_question" required="yes" default="33" />
        <cfargument name="id_number" required="yes" default="33" />
        
		<!--- Default values --->
        <cfset request.today = DateFormat(Now(),"yyyy-mm-dd") & ' ' & TimeFormat(Now(),"HH:mm:ss")>
        
        
        <!--- Check if client already exisits --->
        <cfquery name="checkForClientI" datasource="ICWI_MySql_Client_DSN"> 
            SELECT u.user_id, u.email_address
            FROM icwi_client_users u
            WHERE u.client_number = '#client_number#'
        </cfquery>
        
        <!--- Save registration information --->
        <cfif checkForClientI.recordcount lt 1>
            <cfquery name="saveRegInfo" datasource="ICWI_MySql_Client_DSN">  
                INSERT INTO icwi_client_users 
                (
                    policy_number, client_number, id_type_id, id_number, email_address, 
                    user_password, security_id, own_question, security_answer,
                    created_on
                )
                VALUES 
                (
                    #policy_number#, #client_number#, '#id_type#', #id_number#,'#email_address#',
                    '#user_password#', #security_id#,
                    <!--- Check if user choose to use there own security question --->
                    <cfif is_own_quest is "True">
                        '#security_question#', 
                    <cfelse>
                        NULL,
                    </cfif>
                    '#security_answer#', '#request.today#'
                )   
            </cfquery>
        </cfif>
        
        <!--- Check if the client was registered successfully --->
        <cfquery name="checkForClient" datasource="ICWI_MySql_Client_DSN"> 
            SELECT u.user_id, u.email_address
            FROM icwi_client_users u
            WHERE u.email_address = '#email_address#'
            AND u.policy_number = #policy_number#
        </cfquery>
        
        <!--- Encode URL values --->
        
        <cfset userId = URLEncodedFormat(checkForClient.user_id)>
        <cfset activeStatus = URLEncodedFormat(False)>
        
        <!--- Send Email To customer--->
        <cfif checkForClient.recordcount gt 0 and checkForClientI.recordcount lt 1>
            <cfset reg_status = "Success!">
            <cfoutput query="checkForClient">
                <cfmail to="#checkForClient.email_address#" 
                        from="ICWI Click & Go <do-not-reply@icwi.com>" 
                        server="smtp.gmail.com" 
                        subject="ICWI eClient Registration"
                        username="do-not-reply@icwi.com"
                        password="Blank123"
                        port="465"
                        useSSL ="yes"
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
        <tr>
          <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="395"><a href= "http://www.icwi.com" target="_blank"><img src="http://ebroker.icwi.com/email/images/logo.png" width="395" height="76" border="0" alt=""/></a>
                <br/><br/>
                </td>
                <td width="203"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td height="46" align="right" valign="middle"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td width="67%" align="right"><font style="font-family:'Myriad Pro', Helvetica, Arial, sans-serif; color:##68696a; font-size:8px; text-transform:uppercase"><a href= "http://yourlink" style="color:##68696a; text-decoration:none"><strong>CONTACT US</strong></a></font></td>
                            <td width="29%" align="right"><font style="font-family:'Myriad Pro', Helvetica, Arial, sans-serif; color:##68696a; font-size:8px"><a href= "http://yourlink" style="color:##68696a; text-decoration:none; text-transform:uppercase"><strong>GO TO MY ACCOUNT</strong></a></font></td>
                            <td width="4%">&nbsp;</td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr>
                      <td height="30"><img src="http://ebroker.icwi.com/email/images/blueBorder.jpg" width="393" height="30" border="0" alt=""/></td>
                    </tr>
                  </table></td>
              </tr>
            </table></td>
            
        </tr>
         <tr>
          <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="400"><a href= "http://www.icwi.com" target="_blank"><img src="http://ebroker.icwi.com/email/images/click&gopic2.PNG" width="400" height="300" border="0" alt=""/></a>
                <br/><br/>
                </td>
                <td style="text-align:right">
                <h1 style="color:##3D5F93">Thank you for Registering</h1>
                <br /><br />
                <h3 style="color:##3D5F93">Just one more step... Please click the link below to confirm your email</h3>
                <br/><br/>
                	<a style="color:##fd6a62" href="http://#CGI.SERVER_NAME#/client/modules/client_portal/reg_confirmation.cfm?userId=#userId#&activeStatus=#activeStatus#" target="_blank"><h3>Confirm My Email</h3></a>
                </td>
              </tr>
            </table></td>
            
        </tr>
        <tr>
           <td height="10" style="border-bottom:4px solid #d0d1d3"></td>
        </tr>
        <tr>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td width="13%" align="center">&nbsp;</td>
              <td width="14%" align="center"><font style="font-family:'Myriad Pro', Helvetica, Arial, sans-serif; color:##010203; font-size:9px; text-transform:uppercase"><a href= "http://yourlink" style="color:##010203; text-decoration:none"><strong>VIEW ACCOUNT </strong></a></font></td>
              <td width="2%" align="center"><font style="font-family:'Myriad Pro', Helvetica, Arial, sans-serif; color:##010203; font-size:9px; text-transform:uppercase"><strong>|</strong></font></td>
              <td width="9%" align="center"><font style="font-family:'Myriad Pro', Helvetica, Arial, sans-serif; color:##010203; font-size:9px; text-transform:uppercase"><a href= "http://yourlink" style="color:##010203; text-decoration:none"><strong>THING ONE </strong></a></font></td>
              <td width="2%" align="center"><font style="font-family:'Myriad Pro', Helvetica, Arial, sans-serif; color:##010203; font-size:9px; text-transform:uppercase"><strong>|</strong></font></td>
              <td width="10%" align="center"><font style="font-family:'Myriad Pro', Helvetica, Arial, sans-serif; color:##010203; font-size:9px; text-transform:uppercase"><a href= "http://yourlink" style="color:##010203; text-decoration:none"><strong>THING TWO </strong></a></font></td>
              <td width="2%" align="center"><font style="font-family:'Myriad Pro', Helvetica, Arial, sans-serif; color:##010203; font-size:9px; text-transform:uppercase"><strong>|</strong></font></td>
              <td width="11%" align="center"><font style="font-family:'Myriad Pro', Helvetica, Arial, sans-serif; color:##010203; font-size:9px; text-transform:uppercase"><a href= "http://yourlink" style="color:##010203; text-decoration:none"><strong>CONTACT </strong></a></font></td>
              <td width="2%" align="center"><font style="font-family:'Myriad Pro', Helvetica, Arial, sans-serif; color:##010203; font-size:9px; text-transform:uppercase"><strong>|</strong></font></td>
              <td width="17%" align="center"><font style="font-family:'Myriad Pro', Helvetica, Arial, sans-serif; color:##010203; font-size:9px; text-transform:uppercase"><a href= "http://yourlink" style="color:##010203; text-decoration:none"><strong>STAY CONNECTED</strong></a></font></td>
              <td width="4%" align="right"><a href="https://www.facebook.com/" target="_blank"><img src="http://ebroker.icwi.com/email/images/Facebook.png" alt="facebook" width="20" height="19" border="0" /></a></td>
              <td width="5%" align="center"><a href="https://twitter.com/" target="_blank"><img src="http://ebroker.icwi.com/email/images/Twitter.png" alt="twitter" width="23" height="19" border="0" /></a></td>
              
              <td width="5%">&nbsp;</td>
            </tr>
          </table></td>
        </tr>
        <tr>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td align="center"><font style="font-family:'Myriad Pro', Helvetica, Arial, sans-serif; color:##231f20; font-size:8px"><strong>The Insurance Company of the West Indies | Tel: 1(888) ICWI | <a href= "http://yourlink" style="color:##010203; text-decoration:none"> direct@icwi.com </a></strong></font></td>
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
        <cfelse>
            <cfset reg_status = "Failed">
        </cfif>   
        <cfxml variable="XMLEval">
        <reg>
        	<reg_info>
            <cfoutput>
            	<reg_status>#reg_status#</reg_status>
            </cfoutput>    
            </reg_info>    
        </reg>
        </cfxml>
        <cfset XMLString = toString(XMLEval)>
        
        <cfreturn XMLEval>
    </cffunction>
</cfcomponent>                                                                                              