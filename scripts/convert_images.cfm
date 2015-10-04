
<cfdirectory 
    directory="#request.gazoo_source_directory_path#" 
    recurse="no" 
    sort="datelastmodified" 
    name="q_images" 
    action="LIST" />
    
<cfset dirsArray = arraynew(1)>
<cfset i=1>
<cfloop query="q_images">
  <cfif q_images.type IS "file">
    <cfset dirsArray[i] = q_images.name>
    <cfif IsImageFile("#request.gazoo_source_directory_path##dirsArray[i]#")>
 
        <cfimage 
            source="#request.gazoo_source_directory_path##dirsArray[i]#" 
            name="image_undergoing_transformation">
	
		<cfset ImageGrayscale("#image_undergoing_transformation#")>

        <cfimage
            source="#image_undergoing_transformation#" 
            action="resize" 
            width="350"
            height="350" 
            destination="#request.gazoo_output_directory_path#image_#i#_macro.jpg" overwrite="yes">

        <cfimage
            source="#image_undergoing_transformation#" 
            action="resize" 
            width="125"
            height="125" 
            destination="#request.gazoo_output_directory_path#image_#i#_thumb.jpg" overwrite="yes">
        
    </cfif>
	<cfset i = i + 1>
  </cfif>
</cfloop>

<cflocation addtoken="no" url="#cgi.HTTP_REFERER#" />
