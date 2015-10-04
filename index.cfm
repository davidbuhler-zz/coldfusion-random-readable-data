<cfdirectory
    directory="#request.gazoo_source_directory_path#"
    name="untouched_images_dir"
    sort="size ASC, name DESC, datelastmodified">
    
<cfdirectory
    directory="#request.gazoo_output_directory_path#"
    name="modified_images_dir"
    sort="size ASC, name DESC, datelastmodified">
    
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <cfoutput>  <title>Welcome Page (#request.gazoo_version_number#)</title> </cfoutput>
        
        <style type="text/css">
            @import url("assets/styles.css");
        </style>
    </head>
    
    <body>
    <div id="content">
      <h1>Welcome to Gazoo</h1>
      <h2>What is Gazoo?</h2>
      <p>Gazoo Creates highly random, highly readable data for Coldfusion applications. Gazoo was created, like many open-source projects, to help solve a problem on a pretty big application.</p>
      <h2>Before you get started:</h2>
      <p>Gazoo can convert images for use in testing. 
      During testing, it's recommended to use plain, simple images, so the focus is on the application...and not the design.</p>
      <p>If you're working on a project where you need to use specific images, just load those images into the&quot;gazoo_image_source_directory&quot;, click &quot;Create Testing Images&quot;, and you're good to go. You can change the source and output path of images in the Application.cfc.</p>
      <h2>Now, what do you want to do?</h2>
      
      <div class="linkBox"> 
      	<a class="runAgainLink" href="display_data.cfm">LET'S SEE SOME RANDOM DATA &gt;</a> 
      	<a class="runAgainLink" href="scripts/convert_images.cfm">CREATE TESTING IMAGES</a> 
      </div>
      
      <!--- MODIFIED --->
      <div class="titleDiv">MANIPULATED FILES FOR USE IN TESTING</div>
      <table cellspacing=1 cellpadding=10>
        <tr>
          <th>Name</th>
          <th>Size</th>
          <th>Type</th>
          <th>Modified</th>
          <th>Attributes</th>
          <th>Mode</th>
        </tr>
        <cfoutput query="modified_images_dir">
          <tr>
            <td><a href="#request.gazoo_image_destination_directory##modified_images_dir.name#">#modified_images_dir.name#</a></td>
            <td>#modified_images_dir.size#</td>
            <td>#modified_images_dir.type#</td>
            <td>#modified_images_dir.dateLastModified#</td>
            <td>#modified_images_dir.attributes#</td>
            <td>#modified_images_dir.mode#</td>
          </tr>
        </cfoutput>
      </table>
      
	  <!--- SOURCE --->
      <div class="titleDiv">UNTOUCHED SOURCE FILES</div>
      <table class="table2" cellspacing=1 cellpadding=10>
        <tr>
          <th>Name</th>
          <th>Size</th>
          <th>Type</th>
          <th>Modified</th>
          <th>Attributes</th>
          <th>Mode</th>
        </tr>
        <cfoutput query="untouched_images_dir">
          <tr>
            <td><a href="#request.gazoo_image_source_directory##untouched_images_dir.name#">#untouched_images_dir.name#</a></td>
            <td>#untouched_images_dir.size#</td>
            <td>#untouched_images_dir.type#</td>
            <td>#untouched_images_dir.dateLastModified#</td>
            <td>#untouched_images_dir.attributes#</td>
            <td>#untouched_images_dir.mode#</td>
          </tr>
        </cfoutput>
      </table>
    </div>
    
    <div class="linkBox" style="text-align:right;padding:10px;"> 
    	<b>Page 1 of 2</b> 
    </div>
    
    </body>
</html>
<cfsetting showdebugoutput="no"/>
