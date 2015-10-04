<cfobject name="RandomDataGeneratorService" component="com.davidbuhler.gazoo.Gazoo" />
	<cfscript>
		obj = StructNew ();
		
		emailArgs1 = StructNew();
		emailArgs1.randomNess = 'rarely_random';
		obj.EmailAddress1 = RandomDataGeneratorService.generateEmail(argumentCollection = emailArgs1);
		
		emailArgs2 = StructNew();
		emailArgs2.randomNess = 'semi_random';
		obj.EmailAddress2 = RandomDataGeneratorService.generateEmail(argumentCollection = emailArgs2);

		emailArgs3 = StructNew();
		emailArgs3.randomNess = 'very_random';
		obj.EmailAddress3 = RandomDataGeneratorService.generateEmail(argumentCollection = emailArgs3);
		
		passwordArgs = StructNew();
		passwordArgs.min = 6;
		passwordArgs.max = 12;
		obj.Password = RandomDataGeneratorService.generatePassword(argumentCollection = passwordArgs);
		
		obj.FirstName = RandomDataGeneratorService.generateFirstName();
		obj.LastName = RandomDataGeneratorService.generateLastName();
		obj.PhoneNumber = RandomDataGeneratorService.generatePhoneNumber();
		obj.averagePurchase = RandomDataGeneratorService.generateUSDollarAmount();
		obj.Address1 = RandomDataGeneratorService.generateAddress1();
		obj.Address2 = RandomDataGeneratorService.generateAddress2();
		obj.City = RandomDataGeneratorService.generateCity();
		obj.StateAbbreviation = RandomDataGeneratorService.generateStateAbbreviation();
		obj.StateName = RandomDataGeneratorService.generateStateName();

		ageArgs = StructNew();
		ageArgs.min = 20;
		ageArgs.max = 150;
		obj.Age = RandomDataGeneratorService.generateAge(argumentCollection = ageArgs);
		
		obj.CompanyName = RandomDataGeneratorService.generateCompanyName();
		obj.SSNumber = RandomDataGeneratorService.generateSSNumber();
		obj.privateProfileBoolean = RandomDataGeneratorService.generateBoolean();
		obj.privateProfileBit = RandomDataGeneratorService.generateBit();
		
		descriptionArgs = StructNew();
		descriptionArgs.min = 20;
		descriptionArgs.max = 150;
		obj.Description = (RandomDataGeneratorService.generateTextWords(argumentCollection = descriptionArgs));
		
		websiteArgs = StructNew();
		websiteArgs.include_IPs = true;
		obj.website = RandomDataGeneratorService.generateWebsite(argumentCollection = websiteArgs);
		
		htmlsArgs = StructNew();
		htmlsArgs.totalGenerations = 9;
		htmlsArgs.wordsInParagraphMax = 99;
		htmlsArgs.h1WordCountMax = 9;
		htmlsArgs.h2WordCountMax = 9;
		htmlsArgs.boldWordCountMax = 9;
		htmlsArgs.italicizedWordCountMax = 9;
		
		obj.blogPost = RandomDataGeneratorService.generateHTMLWords(argumentCollection = htmlsArgs);
		
		obj.dangerousChars = RandomDataGeneratorService.getBadCharacters();
		
		stringArgs = StructNew();
		stringArgs.min = 3;
		stringArgs.max = 10;
		
		obj.str = RandomDataGeneratorService.generateString(argumentCollection = stringArgs);
		
		ZipCodePlus4Args = StructNew();
		ZipCodePlus4Args.extended = true;
		
		obj.ZipCodePlus4 = RandomDataGeneratorService.generateZipCode(argumentCollection = ZipCodePlus4Args);
		
		ZipCodeByStateArgs = StructNew();
		ZipCodeByStateArgs.str = obj.StateAbbreviation;
		
		obj.ZipCodeByState = RandomDataGeneratorService.generateZipCodeByState(argumentCollection = ZipCodeByStateArgs);

		dateWithinRangeArgs = StructNew();
		dateWithinRangeArgs.startDate = '11/04/1950';
		dateWithinRangeArgs.endDate = '05/05/1995';
		
		obj.Birthday = RandomDataGeneratorService.generateDateWithinRange(argumentCollection = dateWithinRangeArgs);
		
		obj.postDate = RandomDataGeneratorService.generateDate();
		obj.postTime = RandomDataGeneratorService.generateTime();
		
		obj.dateProp= RandomDataGeneratorService.generateStartEndDates();
		obj.startDate = obj.dateProp.startDate;
		obj.endDate = obj.dateProp.endDate;

		integerArgs = StructNew();
		integerArgs.min = 3;
		integerArgs.max = 10;
		obj.integer = RandomDataGeneratorService.generateInteger(argumentCollection = integerArgs);

		obj.uuid = RandomDataGeneratorService.generateUUID();

		obj.thumbnailPath = RandomDataGeneratorService.generateThumbNailImage();
		obj.macroImagePath = RandomDataGeneratorService.generateMacroImage();
		
		getMatchingImagesObj = StructNew();
		getMatchingImagesObj = RandomDataGeneratorService.generateMatchingImages();
		
		matchingImagesObj = StructNew();
		matchingImagesObj.thumbnailImagePath = getMatchingImagesObj.thumbNailImage;
		matchingImagesObj.macroImagePath = getMatchingImagesObj.macroImage;
		
    </cfscript>
<!--- END CF
*
*
*
*
*
*
*

BEGIN HTML --->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<cfoutput>
<title>Coldfusion Random Data Generator (#request.gazoo_version_number#)</title>
<style type="text/css">
            @import url("assets/styles.css");
        </style>
</head>
<body>
  <div class="productName"><a title="click here to return to the homepage" href="index.cfm">#request.gazoo_version_number#</a></div>   
  <div class="linkBox"><a class="runAgainLink" href="#cgi.SCRIPT_NAME#">GENERATE NEW RECORD</a> </div>
      <table summary="Results of the object." cellpadding="0" cellspacing="0">
        <colgroup width="175">
        </colgroup>
        <colgroup width="350">
        </colgroup>
        <colgroup width="100">
        </colgroup>
        <colgroup width="175">
        </colgroup>
        <thead>
          <tr>
            <th scope="col">FIELD</th>
            <th scope="col">DATA</th>
            <th scope="col">METHOD</th>
            <th scope="col">ARGS</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td class="label" scope="row">First Name</td>
            <td scope="row">#obj.FirstName#</td>
            <td class="argsCol" scope="row">generateFirstName()</td>
            <td class="argsCol" scope="row">None</td>
          </tr>
          <tr>
            <td class="label" scope="row">Last Name</td>
            <td scope="row">#obj.LastName#</td>
            <td class="argsCol" scope="row">generateLastName()</td>
            <td class="argsCol" scope="row">None</td>
          </tr>
          <tr>
          <tr>
            <td class="label" scope="row">Thumbnail</td>
            <td scope="row"><img alt="#matchingImagesObj.thumbnailImagePath#" src="#matchingImagesObj.thumbnailImagePath#"/></td>
            <td class="argsCol" scope="row">generateMatchingImages()</td>
            <td class="argsCol" scope="row">None</td>
          </tr>
          <tr>
          <tr>
            <td class="label" scope="row">Macro Image</td>
            <td scope="row"><img alt="#matchingImagesObj.macroImagePath#" src="#matchingImagesObj.macroImagePath#"/></td>
            <td class="argsCol" scope="row">generateMatchingImages()</td>
            <td class="argsCol" scope="row">None</td>
          </tr>
          <tr>
            <td class="label" scope="row">Website</td>
            <td scope="row"><a href="#obj.website#" target="_blank">#obj.website#</a></td>
            <td class="argsCol" scope="row">generateWebsite()</td>
            <td class="argsCol" scope="row"><ul>
              <li><strong>include_IPs</strong> (req.)
                <ul>
                  <li>true/false</li>
                  </ul>
                </li>
              </ul></td>
          </tr>
          <tr>
            <td class="label" scope="row">Birthday</td>
            <td scope="row">#obj.Birthday#</td>
            <td class="argsCol" scope="row">generateDateWithinRange()</td>
            <td class="argsCol" scope="row"><ul>
              <li><strong>StartDate</strong> (req.)
                <ul>
                  <li>mm/dd/yyyy</li>
                  </ul>
                </li>
                <li><strong>EndDate</strong> (req.)
                  <ul>
                    <li>mm/dd/yyyy</li>
                  </ul>
                </li>
              </ul></td>
          </tr>
          <tr>
            <td class="label" scope="row">Phone</td>
            <td scope="row">#obj.PhoneNumber#</td>
            <td class="argsCol" scope="row">generatePhoneNumber()</td>
            <td class="argsCol" scope="row">None</td>
          </tr>
          <tr>
            <td class="label" scope="row">Email</td>
            <td scope="row">#obj.EmailAddress1#</td>
            <td class="argsCol" scope="row">generateEmail()</td>
            <td class="argsCol" scope="row"><ul>
              <li><strong>randomness</strong>
                <ul>
                  <li>'rarely_random'</li>
                    <li>'semi_random'</li>
                    <li>'very_random'</li>
                  </ul>
                </li>
              </ul></td>
          </tr>
          <tr>
            <td class="label" scope="row">Password</td>
            <td scope="row">#obj.Password#</td>
            <td class="argsCol" scope="row">generatePassword()</td>
            <td class="argsCol" scope="row"><ul>
              <li><strong>min</strong>
                (req.) </li>
              <li><strong>max</strong> (req.)</li>
              </ul></td>
          </tr>
          <tr>
            <td class="label" scope="row">SSN</td>
            <td scope="row">#obj.SSNumber#</td>
            <td class="argsCol" scope="row">generateSSNumber()</td>
            <td class="argsCol" scope="row">None</td>
          </tr>
          <tr>
            <td class="label" scope="row">Description</td>
            <td scope="row">#paragraphFormat(obj.Description)#</td>
            <td class="argsCol" scope="row">generateTextWords()</td>
            <td class="argsCol" scope="row"><ul>
              <li><strong>min</strong> (req.) </li>
              <li><strong>max</strong> (req.)</li>
            </ul>
            </td>
          </tr>
          <tr>
            <td class="label" scope="row">Company</td>
            <td scope="row">#obj.CompanyName#</td>
            <td class="argsCol" scope="row">generateCompanyName()</td>
            <td class="argsCol" scope="row">None</td>
          </tr>
          <tr>
            <td class="label" scope="row">Address 1</td>
            <td scope="row">#obj.Address1#</td>
            <td class="argsCol" scope="row">generateAddress1()</td>
            <td class="argsCol" scope="row">None</td>
          </tr>
          <tr>
            <td class="label" scope="row">Address 2</td>
            <td scope="row">#obj.Address2#</td>
            <td class="argsCol" scope="row">generateAddress2()</td>
            <td class="argsCol" scope="row">None</td>
          </tr>
          <tr>
            <td class="label" scope="row">City</td>
            <td scope="row">#obj.City#</td>
            <td class="argsCol" scope="row">generateCity()</td>
            <td class="argsCol" scope="row">None</td>
          </tr>
          <tr>
            <td class="label" scope="row">State</td>
            <td scope="row">#obj.StateName#</td>
            <td class="argsCol" scope="row">generateStateName()</td>
            <td class="argsCol" scope="row">None</td>
          </tr>
          <tr>
            <td class="label" scope="row">Zip code<br/>
            (#obj.StateAbbreviation#)</td>
            <td scope="row">#obj.ZipCodeByState#</td>
            <td class="argsCol" scope="row">generateZipCodeByState()</td>
            <td class="argsCol" scope="row"><ul>
              <li><strong>str</strong> (req.)</li>
              </ul></td>
          </tr>
          <tr>
            <td class="label" scope="row">PUBLIC PROFILE</td>
            <td scope="row">#obj.privateProfileBoolean#</td>
            <td class="argsCol" scope="row">&nbsp;</td>
            <td class="argsCol" scope="row">None</td>
          </tr>
          <tr>
            <td class="label" scope="row">HTML</td>
            <td scope="row">#paragraphFormat(obj.blogPost)#</td>
            <td class="argsCol" scope="row">generateHTMLWords()</td>
            <td class="argsCol" scope="row">
            <ul>
              <li><strong>totalGenerations</strong>
                <ul>
                  <li>num</li>
                  </ul>
                </li>
                <li><strong>wordsInParagraphMax</strong>
                  <ul>
                    <li>num</li>
                  </ul>
                </li>
                <li><strong>h1WordCountMax</strong>
                  <ul>
                    <li>num</li>
                  </ul>
                </li>
                <li><strong>h2WordCountMax</strong>
                  <ul>
                    <li>num</li>
                  </ul>
                </li>
                <li><strong>boldWordCountMax</strong>
                  <ul>
                    <li>num</li>
                  </ul>
                </li>
                <li><strong>italicizedWordCountMax</strong>
                  <ul>
                    <li>num</li>
                  </ul>
                </li>
              </ul></td>
          </tr>
          <tr>
            <td class="label" scope="row">ONLINE</td>
            <td scope="row">#obj.startDate# - #obj.endDate#</td>
            <td class="argsCol" scope="row">generateStartEndDates()</td>
            <td class="argsCol" scope="row">None</td>
          </tr>
          <tr>
            <td class="label" scope="row">Last Post</td>
            <td scope="row">#obj.postDate# @ #obj.postTime#</td>
            <td class="argsCol" scope="row"><p>generateDate()</p>
              <p>generateTime()</p></td>
            <td class="argsCol" scope="row">None</td>
          </tr>
          <tr>
            <th colspan="4">OTHER RANDOM DATA</th>
          </tr>
          <tr>
            <td class="label" scope="row">STRING</td>
            <td scope="row">#obj.str#</td>
            <td class="argsCol" scope="row">generateString()</td>
            <td class="argsCol" scope="row"><ul>
              <li><strong>min</strong> (req.) </li>
              <li><strong>max</strong> (req.)</li>
            </ul>
            </td>
          </tr>
          <tr>
            <td class="label" scope="row">Email</td>
            <td scope="row">#obj.EmailAddress2#</td>
            <td class="argsCol" scope="row">generateEmail()</td>
            <td class="argsCol" scope="row"><ul>
              <li><strong>randomness</strong>
                <ul>
                  <li>'rarely_random'</li>
                    <li>'semi_random'</li>
                    <li>'very_random'</li>
                  </ul>
                </li>
              </ul></td>
          </tr>
          <tr>
            <td class="label" scope="row">Email</td>
            <td scope="row">#obj.EmailAddress3#</td>
            <td class="argsCol" scope="row">generateEmail()</td>
            <td class="argsCol" scope="row"><ul>
              <li><strong>randomness</strong>
                <ul>
                  <li>'rarely_random'</li>
                    <li>'semi_random'</li>
                    <li>'very_random'</li>
                  </ul>
                </li>
              </ul></td>
          </tr>
          <tr>
            <td class="label" scope="row">State Abbreviation</td>
            <td scope="row">#obj.StateAbbreviation#</td>
            <td class="argsCol" scope="row">generateStateAbbreviation()</td>
            <td class="argsCol" scope="row">None</td>
          </tr>
          <tr>
            <td class="label" scope="row">Zip code</td>
            <td scope="row">#obj.ZipCodePlus4#</td>
            <td class="argsCol" scope="row">generateZipCode()</td>
            <td class="argsCol" scope="row"><ul>
              <li><strong>extended</strong>
                <ul>
                  <li>true/false</li>
                  </ul>
                </li>
              </ul></td>
          </tr>
          <tr>
            <td class="label" scope="row">AMOUNT</td>
            <td scope="row">#obj.averagePurchase#</td>
            <td class="argsCol" scope="row">generateUSDollarAmount()</td>
            <td class="argsCol" scope="row">None</td>
          </tr>
          <tr>
            <td class="label" scope="row">Age</td>
            <td scope="row">#obj.age#</td>
            <td class="argsCol" scope="row">generateAge()</td>
            <td class="argsCol" scope="row"><ul>
              <li><strong>min</strong> (req.) </li>
              <li><strong>max</strong> (req.)</li>
              </ul></td>
          </tr>
          <tr>
            <td class="label" scope="row">Integer</td>
            <td scope="row">#obj.integer#</td>
            <td class="argsCol" scope="row">generateInteger()</td>
            <td class="argsCol" scope="row"><ul>
              <li><strong>min</strong> (req.) </li>
              <li><strong>max</strong> (req.)</li>
              </ul></td>
          </tr>
          <tr>
            <td class="label" scope="row">UUID</td>
            <td scope="row">#obj.uuid#</td>
            <td class="argsCol" scope="row">generateUUID()</td>
            <td class="argsCol" scope="row">
            None
            </td>
          </tr>
          <tr>
            <td class="label" scope="row">Dangerous Characters</td>
            <td scope="row">#obj.dangerousChars#</td>
            <td class="argsCol" scope="row">getBadCharacters()</td>
            <td class="argsCol" scope="row">None</td>
          </tr>
          <tr>
            <td class="label" scope="row">Thumbnail</td>
            <td scope="row"><img alt="#obj.thumbnailPath#" src="#obj.thumbnailPath#"/></td>
            <td class="argsCol" scope="row">generateThumbNailImage()</td>
            <td class="argsCol" scope="row">None</td>
          </tr>
          <tr>
          <tr>
            <td class="label" scope="row">Macro Image</td>
            <td scope="row"><img alt="#obj.macroImagePath#" src="#obj.macroImagePath#"/></td>
            <td class="argsCol" scope="row">generateMacroImage()</td>
            <td class="argsCol" scope="row">None</td>
          </tr>
        </tbody>
  </table>
      <div class="linkBox"> <a class="runAgainLink" href="#cgi.SCRIPT_NAME#">GENERATE NEW RECORD</a> </div>
    </cfoutput>
      <div class="linkBox" style="text-align:right;padding:10px;"> 
      
         <b>Page 2 of 2</b>
      
      </div>
</body>
</html>
<cfsetting showdebugoutput="false"/>
