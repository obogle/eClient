<!DOCTYPE html PUBLI<cffunction name="addCiscoOnlineCallback" output="false" access="remote" returntype="any" >
	<cfargument name= "policy_no" default="" required="no">
 	<cfargument name= "Name" default="" required="no">
 	<cfargument name= "Phone" default="" required="no">
    
    
    <cfxml variable="xmlrequest">
            <?xml version="1.0" encoding="UTF-8"?>
            <campaignContacts xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xsi:noNamespaceSchemaLocation="campaignContacts.xsd">
            <campaign name="Online_Call_Back">
            <refURL>https://192.168.20.5/adminapi/campaign/6</refURL>
            </campaign>
                <csvdata>
         Account Number, First Name, phone1
         <cfoutput>#xmlFormat("#Arguments.policy_no# , #Arguments.Name# , #Arguments.Phone#")#</cfoutput>	 
                                             
                </csvdata>
            </campaignContacts>
	</cfxml>
     
        
	<cfhttp url="http://192.168.20.5/adminapi/campaign/6/contacts" username="eclient" result="request_response" password="M1$@cces" method="post" >
        <cfhttpparam type="header" name="Content-Type" value="text/xml">
        <cfhttpparam type="body"  value="#xmlrequest#" >
    </cfhttp>
 </cffunction>