<!-- Call PlugnPay custom tag with these values -->
<CF_PlugnPay
MERCHANT="icwi"
PUBLISHER_EMAIL="obogle@icwi.com"
CARD_NUMBER="5520592010807234"
CARD_EXP="06/16"
CARD_AMOUNT="1.00"
CARD_NAME="Patrick A Williams"
CARD_ADDRESS1="Line 1 of Billing Address"
CARD_ADDRESS2="Line 2 of Billing Address"
CARD_CITY="Billing Address City"
CARD_STATE="NY"
CARD_ZIP="11788"
CARD_COUNTRY="US"
ORDERID="1"
XTRAFIELDS="CARD_CVV:ADDRESS1:ADDRESS2"
CARD_CVV="266"
ADDRESS1="Line 1 of shipping address"
ADDRESS2="Line 2 of shipping address"
>
 
<!-- Simple loop to output data.-->
<CFLOOP collection="#pnpStruct#" item="structIndex">
  <cfoutput> #structIndex# = #StructFind(pnpStruct, structIndex)# <br> </cfoutput>
</CFLOOP>

<!-- Simple test to check FinalStatus -->
<CFIF #StructFind(pnpStruct, "FINALSTATUS")# is "success">
  <!--   Enter Code Here For Success  -->
  <cfoutput>#StructFind(pnpStruct, "FINALSTATUS")#<br></cfoutput>
<CFELSE>
  <!--   Enter Code Here For Failure -->
  <cfoutput>#StructFind(pnpStruct, "FINALSTATUS")#<br></cfoutput>
</CFIF>
