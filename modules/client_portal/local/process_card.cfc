<!---
	Cold Fusion Template: 
	Author:			Omari K Bogle 
	Date:			26-01-2016
	Modified:		
					

	Description:	Function which calls plugnplay to make payment
	
	Parameters:		card_name, card_number, card_exp, card_cvv, card_amount
	
// --->

<cfcomponent>
    <cffunction access="remote" name="processCard" output="false" returntype="xml">
        <cfargument name="card_name" required="yes" default="pnptest" />
        <cfargument name="card_number" required="yes" default="4111111111111111"/>
        <cfargument name="card_exp" required="yes" default="05/05"/>
        <cfargument name="card_cvv" required="yes" default="1111"/>
        <cfargument name="card_amount" required="yes" default="1.00"/>
        
        <!--- Include plugnplay call --->
        <!--- <cfinclude template="process_card.cfm"> --->
		<!-- Call PlugnPay custom tag with these values -->
        <CF_PlugnPay
        MERCHANT="pnptest"
        PUBLISHER_EMAIL="trash@plugnpay.com"
        CARD_NUMBER="#card_number#"
        CARD_EXP="#card_exp#"
        CARD_AMOUNT="#card_amount#"
        CARD_NAME="#card_name#"
        CARD_ADDRESS1="Line 1 of Billing Address"
        CARD_ADDRESS2="Line 2 of Billing Address"
        CARD_CITY="Billing Address City"
        CARD_STATE="NY"
        CARD_ZIP="11788"
        CARD_COUNTRY="US"
        ORDERID="123456"
        XTRAFIELDS="CARD_CVV:ADDRESS1:ADDRESS2"
        CARD_CVV="#card_cvv#"
        ADDRESS1="Line 1 of shipping address"
        ADDRESS2="Line 2 of shipping address"
        >        
        <cfxml variable="XMLEval">
        <pnp>
        	<pnp_info>
        		<pnp_status><cfoutput>#StructFind(pnpStruct, "FINALSTATUS")#</cfoutput></pnp_status> 
            </pnp_info>       
        </pnp>
        </cfxml>
        <cfset XMLString = toString(XMLEval)>
        
        <cfreturn XMLEval>
    </cffunction>
</cfcomponent>        