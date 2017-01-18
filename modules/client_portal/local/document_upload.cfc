<!---
	Cold Fusion Template: 
	Author:			Omari K Bogle 
	Date:			20-05-2016
	Modified:		

	Description:	Script to upload documents 
	
	Parameters:		user_id
	
// --->

<cfcomponent>
    <cffunction access="remote" name="documentUpload" output="false" returntype="xml">
        <cfargument name="policy_number" required="yes" default="35555468" />
        <cfargument name="renewal_period" required="yes" default="0516" />
        <cfargument name="document_type" required="yes" default="33" />
        <cfargument name="document_file" required="yes" default="33" />
        
        <!--- Set destination --->
        <cfset destination = "/home/CFApplications/eClient/modules/uploads/">
        
        <!--- Define file name --->
        <cfif Right(document_file,4) is 'docx'>
        	<cfset file_ext = Right(document_file,4)>
        <cfelse>
        	<cfset file_ext = Right(document_file,3)>
        </cfif> 
        
        <!--- Create policy & renewal period directory if it doesnt exist --->
        <cfset policy_directory = policy_number>
        <cfset period_directory = renewal_period>

		<!--- Create policy and renewal path --->        
        <cfset policy_directory_path = destination & policy_directory>
        <cfset renewal_directory_path = destination & policy_directory & "/" & period_directory>
        
        <!--- Create new policy directory --->
        <cfif DirectoryExists(policy_directory_path)>
           <cfoutput><p>The directory already existed</p></cfoutput> 
        <cfelse> 
            <cfdirectory action = "create" directory = "#policy_directory_path#" name="#policy_number#" mode="777"> 
            <cfoutput><p>Your directory has been created.</p></cfoutput> 
        </cfif>
        
        <!--- Create new renewal directory --->
        <cfif DirectoryExists(renewal_directory_path)>
           <cfoutput><p>The directory already existed</p></cfoutput> 
        <cfelse> 
            <cfdirectory action = "create" directory = "#renewal_directory_path#" name="#renewal_period#" mode="777"> 
            <cfoutput><p>Your directory has been created.</p></cfoutput> 
        </cfif>
        
        <cfscript>
			variables.validMimeTypes =  {'application/pdf': {extension: 'pdf', application: 'Adobe Acrobat'}
										,'application/msword': {extension: 'doc', application: 'Microsoft Word'}
										,'application/vnd.openxmlformats-officedocument.wordprocessingml.document': {extension: 'docx', application: 'Microsoft Word 2010'}
										,'image/jpeg': {extension: 'jpg'}
										,'image/gif': {extension: 'gif'}
										,'image/bmp': {extension: 'bmp'}
										,'image/png': {extension: 'png'}};  
		</cfscript>
        
		<!--- Upload document --->
        <cffile action="upload"
                destination="#renewal_directory_path#"
                accept="#StructKeyList(variables.validMimeTypes)#"
                nameconflict="Overwrite"
                result="uploadedFile" 
                mode="777"/>
                
        <!--- renaming the file --->
        <cffile action="rename" 
                source="#renewal_directory_path#/#uploadedFile.clientFile#" 
                destination="#renewal_directory_path#/#document_type#.#uploadedFile.clientFileExt#"
                mode="777"/>    
                
        <!--- Check if file was uploaded and renamed --->
        <cfset new_file = document_type & "." & uploadedFile.clientFileExt>
        <cfset new_file_path = renewal_directory_path & "/" & document_type & "." & uploadedFile.clientFileExt>
        <cfset request.datetime = DateFormat(Now(),"yyyy-mm-dd") & " " & TimeFormat(Now(),"HH:mm:ss")>
        
        <cfif FileExists(new_file_path)>
        	<!--- Check if upload record already exisit --->
            <cfquery name="checkForExistingDocumentType" datasource="ICWI_MySql_Client_DSN">
            	SELECT * 
                FROM icwi_uploads 
                WHERE policy_number = '#policy_number#'
                AND renewal_period = '#renewal_period#'
                AND document_type = '#document_type#'
            </cfquery>
            
            <!--- Determine if record is new or updated --->
            <cfif checkForExistingDocumentType.recordcount gt 0> 
            	<cfquery name="updateUpload" datasource="ICWI_MySql_Client_DSN" result="upload">
                	UPDATE icwi_uploads SET
                        upload_file = '#new_file#',
                        modified_on = '#request.datetime#' 
                    WHERE policy_number = '#policy_number#'
                    AND renewal_period = '#renewal_period#'
                    AND document_type = '#document_type#'
                </cfquery>
            <cfelse>
            	<cfquery name="insertUpload" datasource="ICWI_MySql_Client_DSN" result="upload">
                	INSERT INTO icwi_uploads 
                    (
                        policy_number, document_type, renewal_period, upload_file, created_on, modified_on
                    )
                    VALUES
                    (
                        '#policy_number#',
                        '#document_type#',
                        '#renewal_period#',
                        '#new_file#',
                        '#request.datetime#',
                        '#request.datetime#'                    
                    ) 
                </cfquery>
            </cfif>
            
            <cfif upload.recordcount gt 0> 
				<cfset status = "success">
            <cfelse>
            	<cfset status = "failed">
            </cfif>        
        <cfelse>
        	<cfset status = "failed">
        </cfif>         
                   
        <cfxml variable="XMLEval">
        <upload>
        	<document><cfoutput>#status#</cfoutput></document>  
            <cfif status is "failed">
            	<error_message>Unfortunately we are unable to upload your file at this time. Please use the 'Proceed without uploading' button to continue.</error_message> 
            <cfelse>
            	<sucess_message>Your file has been uploaded successfully. Please click the 'Proceed, upload my document' button to continue.</sucess_message>
            </cfif>     
        </upload>
        </cfxml>
        <cfset XMLString = toString(XMLEval)>
        
        <cfreturn XMLEval>
    </cffunction>
</cfcomponent>   