<cfset status = "ALL">

<cfquery name="ipCheck" datasource="ICWI_MySql_Client_DSN">  
    SELECT GROUP_CONCAT(ip_address) AS ip_address, GROUP_CONCAT(user_name) AS user_name, GROUP_CONCAT(access_on) AS access_on
    FROM icwi_access_log
    WHERE access_status = 'Successful'
</cfquery>

<cfset ip_array = Replace(ipCheck.ip_address,',','", "','ALL')>
<cfset ip_array = '"' & ip_array>
<cfset ip_array = ip_array & '"'>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>IP Address geocoding on Google Maps</title>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
    <script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false"></script>
    <script type="text/javascript" src="ipmapper.js"></script>
 
    <script type="text/javascript">
   /* $(function(){
    try{
        IPMapper.initializeMap("map");
        var ipArray = [<cfoutput>#ip_array#</cfoutput>];
        IPMapper.addIPArray(ipArray);
    } catch(e){
        //handle error
    }
});*/
	$(function(){
    try{
        IPMapper.initializeMap("map");
        IPMapper.addIPMarker("eclient.icwi.local");
    } catch(e){
        //handle error
    }
});
    </script>
</head>
<body>
    <input id="ip" name="ip" type="text" />
    <button onclick="IPMapper.addIPMarker($('#ip').val());">Geocode</button>
    <div id="map" style="height: 500px;"></div>
</body>
</html>