<cfcomponent output="false">
	
	<cfset request.gazoo_source_directory_path 			= "C:\ColdFusion8\wwwroot\gazoo\images\untouched\" 		/>
	<cfset request.gazoo_output_directory_path 			= "C:\ColdFusion8\wwwroot\gazoo\images\manipulated\" 	/>
    
    <!--- Comment the top two lines, and uncomment these two lines for CF 7
	<cfset request.gazoo_source_directory_path 			= "C:\CFusionMX7\wwwroot\gazoo\images\untouched\" 		/>
	<cfset request.gazoo_output_directory_path 			= "C:\CFusionMX7\wwwroot\gazoo\images\manipulated\" 	/>
	--->
    
	<cfset request.gazoo_image_source_directory 		= "/gazoo/images/untouched/"							/>    
    <cfset request.gazoo_image_destination_directory 	= "/gazoo/images/manipulated/"							/>
    
    <cfset request.gazoo_version_number 				= "Gazoo : v0.9.5" 										/>

</cfcomponent>