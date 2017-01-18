<html> 
<head> 
    <title>HTTP Post Test</title> 
</head> 
<body> 
<h1>HTTP Post Test</h1> 
<cfhttp method="POST" url="https://clickandgo.icwi.com/rest/services/remotePwdResetLvlI" resolveurl="Yes"> 
	<cfhttpparam type="header" name="accept" value="text/plain">
    
    <cfhttpparam name="user_name" type="formfield" value="obogle@gmail.com">
</cfhttp> 
<cfoutput> 
File Content:<br> 
    #cfhttp.filecontent#<br> 
Mime Type:#cfhttp.MimeType#<br>
</cfoutput> 
</body> 
</html>


