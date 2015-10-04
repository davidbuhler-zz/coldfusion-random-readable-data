<cfcomponent name="com.davidbuhler.gazoo.Gazoo" output="false">

  <cffunction access="public" output="false" name="generateWebsite" returntype="string">

    <cfargument name="include_IPs" required="true" type="boolean"  />
    <cfset var _str = '' />
    <cfset var retBit = '' />
    <cfset var retWebsite = '' />
    
    <cfinvoke method="generateDomainName" returnVariable="retWebsite" />
    <cfif arguments.include_IPs is true>

      <cfinvoke method="generateBit" returnVariable="retBit" />
      <cfif retBit is 0>

        <cfinvoke method="generateIPAddress" returnVariable="retWebsite" />
      </cfif>
    </cfif>
    
    <cfreturn #LCase(retWebsite)# />
    
  </cffunction>
  
  <cffunction access="public" output="false" name="generateDomainName" returntype="string">

    <cfset var _str = '' />
    <cfset var retPrefix = '' />
    <cfset var retSuffix = '' />
    <cfset var retDomainName = '' />
    
    <cfinvoke method="getDomainPrefix" returnVariable="retPrefix" />
    
    <cfinvoke method="getDomainSuffix" returnVariable="retSuffix" />
    
    <cfinvoke method="getDomainName" returnVariable="retDomainName" />
    <cfset _str = retPrefix & retDomainName & '.'& retSuffix   />
    
    <cfreturn _str />
    
  </cffunction>
  
  <cffunction access="public" output="false" name="generateIPAddress" returntype="string">

    <!--- sourced : http://igor.gold.ac.uk/~mas01rk/Teaching/CIS110/notes/IP-Address.html --->
    <cfset var _IP = ""  />
    <cfset var part1 = #RandRange(1, 255, "SHA1PRNG")#   />
    <cfset var part2 = #RandRange(0, 255, "SHA1PRNG")#   />
    <cfset var part3 = #RandRange(0, 255, "SHA1PRNG")#   />
    <cfset var part4 = #RandRange(0, 255, "SHA1PRNG")#   />
    <cfset var part5 = #RandRange(0, 255, "SHA1PRNG")#   />
    <cfset _IP = part1 & '.' & part2 & '.' & part3 & '.' & part4 & '.' & part5   />
    
    <cfreturn _IP />
    
  </cffunction>
  
  <cffunction access="public" output="false" name="generateNumber" returntype="numeric">

    <cfargument name="min" required="true" type="numeric"  />
    <cfargument name="max" required="true" type="numeric"  />
    <cfset var num =  #RandRange(arguments.min, arguments.max, "SHA1PRNG")# />
    
    <cfreturn num />
    
  </cffunction>
  
  <cffunction access="public" output="false" name="generateEmail" returntype="string">

    <cfargument name="randomness" type="string" required="yes" default="very_random"/>
    <cfset var _str = '' />
    <cfset var retFirstName = '' />
    <cfset var retLastName = '' />
    <cfset var retSuffix = '' />
    <cfset var retDomainName = '' />
    
    <cfinvoke method="generateFirstName" returnVariable="retFirstName" />
    
    <cfinvoke method="generateLastName" returnVariable="retLastName" />
    
    <cfinvoke method="getDomainSuffix" returnVariable="retSuffix" />
    
    <cfinvoke method="getDomainName" returnVariable="retDomainName" />
    <cfif arguments.randomness is 'very_random'>

      <cfinvoke method="generateNumber" min="0" max="99999999" returnVariable="retNumber" />
      <cfset  retNumber = '_' &  retNumber />
      <cfelseif arguments.randomness is 'semi_random'>
      
      <cfinvoke method="generateNumber" min="0" max="99" returnVariable="retNumber" />
      <cfset  retNumber = '_' &  retNumber />
      <cfelseif arguments.randomness is 'rarely_random'>
      
      <cfset  retNumber = '' />
    </cfif>
    <cfset _str = retFirstName & retLastName & retNumber & '@' & retDomainName & '.'& retSuffix   />
    
    <cfreturn _str />
    
  </cffunction>
  
  <cffunction access="public" output="false" name="generateAddress1" returntype="string">

    <cfset var _str = '' />
    <cfset var retNumber = '' />
    <cfset var retRoadName = '' />
    <cfset var retRoadSuffix = '' />
    <cfset var retBit = '' />
    <cfset var retCompassDirection = '' />
    
    <cfinvoke method="generateNumber" min="0" max="99999" returnVariable="retNumber" />
    
    <cfinvoke method="getRoadName" returnVariable="retRoadName" />
    
    <cfinvoke method="getRoadSuffix" returnVariable="retRoadSuffix" />
    <cfset _str = retNumber & ' ' & retRoadName & ' ' &  retRoadSuffix  />
    
    <cfinvoke method="generateBit" returnVariable="retBit" />
    <cfif retBit is 0>

      <cfinvoke method="getCompassDirection" returnVariable="retCompassDirection" />
      <cfset _str = _str & " " & retCompassDirection  />
    </cfif>
    
    <cfreturn _str />
    
  </cffunction>
  
  <cffunction access="public" output="false" name="generateAddress2" returntype="string">

    <cfset var _str = '' />
    <cfset var retAddress2Prefix = '' />
    <cfset var retNumber = '' />
    
    <cfinvoke method="getAddress2Prefix"returnVariable="retAddress2Prefix" />
    
    <cfinvoke method="generateNumber" min="0" max="999" returnVariable="retNumber" />
    <cfset _str = retAddress2Prefix & ' ' & retNumber />
    
    <cfreturn _str />
    
  </cffunction>
  
  <cffunction access="private" output="false" name="getAddress2Prefix" returnType="String">

    <cfset var index = '' />
    <cfset var _str = '' />
    <cfset arr=[
    "Suite",
    "Unit",
    "Apt.",
  	"##",
    "Apartment",
    "Num.",
    "Number",
    "Mailstop",
 	"Building",
    "Bldg.",
    "Mailbox",
  	"P.O. Box"
    ]>
    <cfset index = #RandRange(1, #ArrayLen(arr)#, "SHA1PRNG")#   />
    <cfset _str = #arr[index]#   />
    
    <cfreturn _str>
    
  </cffunction>
  
  <cffunction access="public" output="false" name="generatePhoneNumber" returntype="string">

    <!--- ONLY WORKS WITH US PHONE NUMBERS --->
    <cfset var _areaCode = #RandRange(100, 999, "SHA1PRNG")#   />
    <cfset var _prefix = #RandRange(100, 999, "SHA1PRNG")#   />
    <cfset var _suffix = #RandRange(1000, 9999, "SHA1PRNG")#   />
    <cfset var _phoneNumber = ""  />
    <cfset phoneNumberType = #RandRange(1, 4, "SHA1PRNG")#   />
    <cfswitch expression="#phoneNumberType#">
      <cfcase value="1">
        <cfset _phoneNumber = _areaCode & '-' & _prefix & '-'& _suffix   />
      </cfcase>
      <cfcase value="2">
        <cfset _phoneNumber =  '(' &_areaCode & ')' & _prefix & '-'& _suffix   />
      </cfcase>
      <cfcase value="3">
        <cfset _phoneNumber =  '(' &_areaCode & ')' & _prefix & ' - '& _suffix   />
      </cfcase>
      <cfcase value="4">
        <cfset _phoneNumber = _areaCode & '.' & _prefix & '.'& _suffix   />
      </cfcase>
      <cfcase value="5">
        <cfset _phoneNumber =  '(' &_areaCode & ') ' & _prefix & '-'& _suffix   />
      </cfcase>
    </cfswitch>
    
    <cfreturn _phoneNumber />
    
  </cffunction>
  
  <cffunction access="public" output="false" name="generateUSDollarAmount" returntype="string">

    <cfset var _amount = #dollarFormat(RandRange(1, 10000, "SHA1PRNG"))#   />
    
    <cfreturn _amount />
    
  </cffunction>
  
  <cffunction access="public" output="false" name="generateAge" returntype="numeric">

    <cfargument name="min" required="true" type="numeric" />
    <cfargument name="max" required="true" type="numeric" />
    <cfset var _age = 0 />
    <cfif arguments.min lt 0>
      <cfthrow message="The age cannot be less than 0" />
    </cfif>
    <cfif arguments.max gt 150>
      <cfthrow message="The age cannot be less than 150" />
    </cfif>
    <cfset _age = #RandRange(arguments.min, arguments.max, "SHA1PRNG")#   />
    
    <cfreturn _age />
    
  </cffunction>
  
  <cffunction access="public" output="false" name="generateInteger" returntype="numeric">

    <cfargument name="min" required="true" type="numeric" />
    <cfargument name="max" required="true" type="numeric" />
    <cfset var _integer = 0 />
    <cfif arguments.min lt 0>
      <cfthrow message="The integer cannot be less than 0" />
    </cfif>
    <cfset _integer = #RandRange(arguments.min, arguments.max, "SHA1PRNG")#   />
    
    <cfreturn _integer />
    
  </cffunction>
  
  <cffunction access="public" output="false" name="generateUUID" returntype="uuid">

    <cfset var _uuid = CreateUUID() />
    
    <cfreturn _uuid />
    
  </cffunction>
  
  <cffunction access="public" output="false" name="generateSSNumber" returntype="string">

    <cfset var _part1 = #RandRange(100, 999, "SHA1PRNG")#   />
    <cfset var _part2 = #RandRange(10, 99, "SHA1PRNG")#   />
    <cfset var _part3 = #RandRange(1000, 9999, "SHA1PRNG")#   />
    <cfset var _ssNumber = _part1 & '-' & _part2 & '-'& _part3   />
    
    <cfreturn _ssNumber />
    
  </cffunction>
  
  <cffunction access="public" output="false" name="generateBit" returntype="numeric">

    <cfset var _num = #RandRange(0, 1, "SHA1PRNG")#   />
    
    <cfreturn _num />
    
  </cffunction>
  
  <cffunction access="public" output="false" name="generateBoolean" returntype="boolean">

    <cfset var _boolean = false />
    <cfset var _bit = #RandRange(0, 1, "SHA1PRNG")#   />
    <cfif (_bit eq 1)>
      <cfset _boolean = true />
    </cfif>
    
    <cfreturn _boolean />
    
  </cffunction>
  
  <cffunction access="public" output="false" name="generateZipCode" returntype="string">

    <cfargument name="extended" required="false" type="boolean" default="false"/>
    <!--- ONLY WORKS WITH US ZIP CODES --->
    <!--- sourced: http://en.wikipedia.org/wiki/ZIP_code --->
    <cfset var _num1 = #RandRange(00000, 99999, "SHA1PRNG")#   />
    <!--- there is no uniform rule for the zip + 4 extension --->
    <cfset var _num2 = #RandRange(0000, 9999, "SHA1PRNG")#   />
    <cfset _num1 = #NumberFormat(_num1,  '00000')#>
    <cfset _num2 = #NumberFormat(_num2,  '00000')#>
    <cfset _str = _num1   />
    <cfif (arguments.extended is 'zip_plus_four')>
      <cfset _str = _str & '-' & _num2 />
    </cfif>
    
    <cfreturn _str />
    
  </cffunction>
  
  <cffunction access="public" output="false" name="generateZipCodeByState" returntype="numeric">

    <!--- sourced http://www.answers.com/topic/list-of-zip-codes-in-the-united-states --->
    <cfargument name="str" required="yes" type="string" />
    <cfset var _index = 0  />
    <cfset var _num = 0  />
    <cfset var _min = 0  />
    <cfset var _max = 0  />
    <cfswitch expression="#arguments.str#">
      <cfcase value="Alaska,AK">
        <cfset _min=99500>
        <cfset _max=99999 >
      </cfcase>
      <cfcase value="Alabama,AL">
        <cfset _min=35004>
        <cfset _max=36925>
      </cfcase>
      <cfcase value="Arkansas,AR">
        <cfset _min=71600>
        <cfset _max=72999>
      </cfcase>
      <cfcase value="Arizona,AZ">
        <cfset _min=85001>
        <cfset _max=86556>
      </cfcase>
      <cfcase value="California,CA">
        <cfset _min=90001>
        <cfset _max=96162>
      </cfcase>
      <cfcase value="Colorado,CO">
        <cfset _min=80001>
        <cfset _max=81658>
      </cfcase>
      <cfcase value="Connecticut,CT">
        <cfset _min=06000>
        <cfset _max=06999>
      </cfcase>
      <cfcase value="District of Columbia,DC">
        <cfset _index = #RandRange(1,3,'SHA1PRNG')#>
        <cfif _index eq 1>
          <cfset _min=20000>
          <cfset _max=20099>
          <cfelseif _index eq 2>
          
          <cfset _min=20200>
          <cfset _max=20599>
          <cfelseif _index eq 3>
          
          <cfset _min=56900>
          <cfset _max=56999>
        </cfif>
      </cfcase>
      <cfcase value="Delaware,DE">
        <cfset _min=19700>
        <cfset _max=19999>
      </cfcase>
      <cfcase value="Florida,FL">
        <cfset _min=32000>
        <cfset _max=34999>
      </cfcase>
      <cfcase value="Georgia,GA">
        <cfset _index = #RandRange(1,3,'SHA1PRNG')#>
        <cfif _index eq 1>
          <cfset _min=30000>
          <cfset _max=31999>
          <cfelseif _index eq 2>
          
          <cfset _min=39800>
          <cfset _max=39899>
          <cfelseif _index eq 3>
          
          <cfset _min=39901>
          <cfset _max=39901>
        </cfif>
      </cfcase>
      <cfcase value="Hawaii,HI">
        <cfset _min=96700>
        <cfset _max=96899>
      </cfcase>
      <cfcase value="Iowa,IA">
        <cfset _min=50000>
        <cfset _max=52999>
      </cfcase>
      <cfcase value="Idaho,ID">
        <cfset _min=83200>
        <cfset _max=83999>
      </cfcase>
      <cfcase value="Illinois,IL">
        <cfset _min=60000>
        <cfset _max=62999>
      </cfcase>
      <cfcase value="Indiana,IN">
        <cfset _min=46000>
        <cfset _max=47999>
      </cfcase>
      <cfcase value="Kansas,KS">
        <cfset _min=66000>
        <cfset _max=67999>
      </cfcase>
      <cfcase value="Kentucky,KY">
        <cfset _min=40000>
        <cfset _max=42799>
      </cfcase>
      <cfcase value="Louisiana,LA">
        <cfset _min=70000>
        <cfset _max=71599>
      </cfcase>
      <cfcase value="Massachusetts,MA">
        <cfset _min=01000>
        <cfset _max=02799>
      </cfcase>
      <cfcase value="Maryland,MD">
        <cfset _min=20600>
        <cfset _max=21999>
      </cfcase>
      <cfcase value="Maine,ME">
        <cfset _min=03900>
        <cfset _max=04999>
      </cfcase>
      <cfcase value="Michigan,MI">
        <cfset _min=48000>
        <cfset _max=49999>
      </cfcase>
      <cfcase value="Minnesota,MN">
        <cfset _min=55000>
        <cfset _max=56799>
      </cfcase>
      <cfcase value="Missouri,MO">
        <cfset _min=63000>
        <cfset _max=65999>
      </cfcase>
      <cfcase value="Mississippi,MS">
        <cfset _min=38600>
        <cfset _max=39999>
      </cfcase>
      <cfcase value="Montana,MT">
        <cfset _min=59000>
        <cfset _max=59999>
      </cfcase>
      <cfcase value="North Carolina,NC">
        <cfset _min=27000>
        <cfset _max=28999>
      </cfcase>
      <cfcase value="North Dakota,ND">
        <cfset _min=58000>
        <cfset _max=58999>
      </cfcase>
      <cfcase value="Nebraska,NE">
        <cfset _min=68000>
        <cfset _max=69999>
      </cfcase>
      <cfcase value="New Hampshire,NH">
        <cfset _min=03000>
        <cfset _max=03899>
      </cfcase>
      <cfcase value="New Jersey,NJ">
        <cfset _min=07000>
        <cfset _max=08999>
      </cfcase>
      <cfcase value="New Mexico,NM">
        <cfset _min=87000>
        <cfset _max=88499>
      </cfcase>
      <cfcase value="Nevada,NV">
        <cfset _min=88900>
        <cfset _max=89999>
      </cfcase>
      <cfcase value="New York,NY">
        <cfset _index = #RandRange(1,4,'SHA1PRNG')#>
        <cfif _index eq 1>
          <cfset _min=10000>
          <cfset _max=14999>
          <cfelseif _index eq 2>
          
          <cfset _min=06390>
          <cfset _max=06390>
          <cfelseif _index eq 3>
          
          <cfset _min=00501>
          <cfset _max=00501>
          <cfelseif _index eq 4>
          
          <cfset _min=00544>
          <cfset _max=00544>
        </cfif>
      </cfcase>
      <cfcase value="Ohio,OH">
        <cfset _min=43000>
        <cfset _max=45999>
      </cfcase>
      <cfcase value="Oklahoma,OK">
        <cfset _min=73000>
        <cfset _max=74999>
      </cfcase>
      <cfcase value="Oregon,OR">
        <cfset _min=97000>
        <cfset _max=97999>
      </cfcase>
      <cfcase value="Pennsylvania,PA">
        <cfset _min=15000>
        <cfset _max=19699>
      </cfcase>
      <cfcase value="Puerto Rico,PR">
        <cfset _index = #RandRange(1,2,'SHA1PRNG')#>
        <cfif _index eq 1>
          <cfset _min=00600>
          <cfset _max=00799>
          <cfelseif _index eq 2>
          
          <cfset _min=00900>
          <cfset _max=00999>
        </cfif>
      </cfcase>
      <cfcase value="Rhode Island,RI">
        <cfset _min=02800>
        <cfset _max=02999>
      </cfcase>
      <cfcase value="South Carolina,SC">
        <cfset _min=29000>
        <cfset _max=29999>
      </cfcase>
      <cfcase value="South Dakota,SD">
        <cfset _min=57000>
        <cfset _max=57999>
      </cfcase>
      <cfcase value="Tennessee,TN">
        <cfset _min=37000>
        <cfset _max=38599>
      </cfcase>
      <cfcase value="Texas,TX">
        <cfset _index = #RandRange(1,2,'SHA1PRNG')#>
        <cfif _index eq 1>
          <cfset _min=75000>
          <cfset _max=79999>
          <cfelseif _index eq 2>
          
          <cfset _min=88500>
          <cfset _max=88599>
        </cfif>
      </cfcase>
      <cfcase value="Utah,UT">
        <cfset _min=84000>
        <cfset _max=84999>
      </cfcase>
      <cfcase value="Virginia,VA">
        <cfset _index = #RandRange(1,3,'SHA1PRNG')#>
        <cfif _index eq 1>
          <cfset _min=20100>
          <cfset _max=20199>
          <cfelseif _index eq 2>
          
          <cfset _min=22000>
          <cfset _max=24699>
          <cfelseif _index eq 3>
          
          <cfset _min=20000>
          <cfset _max=20099>
        </cfif>
      </cfcase>
      <cfcase value="Vermont,VT">
        <cfset _min=05000>
        <cfset _max=05999>
      </cfcase>
      <cfcase value="Washington,WA">
        <cfset _min=98000>
        <cfset _max=99499>
      </cfcase>
      <cfcase value="Wisconsin,WI">
        <cfset _min=53000>
        <cfset _max=54999>
      </cfcase>
      <cfcase value="West Virginia,WV">
        <cfset _min=24700>
        <cfset _max=26999>
      </cfcase>
      <cfcase value="Wyoming,WY">
        <cfset _min=82000>
        <cfset _max=83199>
      </cfcase>
      <cfdefaultcase>
      <cfthrow message="Invalid state name or state abbreviation not found" detail="'#arguments.str#' is not recognized">
      </cfdefaultcase>
    </cfswitch>
    <cfset _num = #RandRange(_min,_max,'SHA1PRNG')#>
    <cfset _num = #NumberFormat(_num,  '00000')#>
    
    <cfreturn  _num />
    
  </cffunction>
  
  <cffunction access="public" output="false" name="generateDateWithinRange" returntype="date">

    <!--- sourced http://www.bennadel.com/blog/121-Creating-Random-Dates-in-ColdFusion-RandDateRange-dtFrom-dtTo-.htm --->
    <!--- Define arguments. --->
    <cfargument name="startDate" type="date" required="false" />
    <cfargument name="endDate" type="date" required="true" />
    <cfscript>

    // Define the local scope.
    var LOCAL = StructNew();

    // Get the difference in seconds between the two dates.
    LOCAL.TimeDifference = DateDiff(
      "s",
      ARGUMENTS.startDate,
      ARGUMENTS.endDate
      );

    // Create a random time increment based on the second difference.
    // The time span object is a representation of time-length in
    // terms of a single floating-point number.
    LOCAL.TimeIncrement = CreateTimeSpan(
      0, // Days
      0, // Hours
      0, // Minutes
      RandRange( // Seconds
        // Our smallest possible time increment.
        0,

        // Our largest possible time increment that will not
        // put us past the ToDate.
        LOCAL.TimeDifference
        )
      );

    // Get a new random date based on the FromDate and the random
    // time span.
    LOCAL.RandomDate = (ARGUMENTS.startDate + LOCAL.TimeIncrement);

    // This random date now is formatted like a TimeSpan object,
    // meaning that it is in the form of one floating point number.
    return( DateFormat(LOCAL.RandomDate,"mm/dd/yyyy"));

  </cfscript>
    
    <cfreturn _date />
    
  </cffunction>
  
  <cffunction access="public" output="false" name="generateStartEndDates" returntype="struct">

    <cfset var obj = StructNew()  />
    
    <cfinvoke method="generateDate" returnVariable="startDate" />
    
    <cfinvoke method="generateDate" returnVariable="endDate" />
    <cfif dateDiff('d', startDate , endDate) lte 0>

      <cfinvoke method="generateStartEndDates"  />
    </cfif>
    <cfset obj.startDate = startDate />
    <cfset obj.endDate = endDate />
    
    <cfreturn obj />
    
  </cffunction>
  
  <cffunction access="public" output="false" name="generateDate" returntype="date">

    <cfset var _randomDateDiff = #RandRange(1, 1000, "SHA1PRNG")#   />
    <cfset _date = #DateAdd('d', _randomDateDiff, now())#         />
    
    <cfreturn #DateFormat(_date,"mm/dd/yyyy")# />
    
  </cffunction>
  
  <cffunction access="public" output="false" name="generateTime" returntype="date">

    <cfset _time = ""/>
    <cfloop
		index="timeIndex"
		from="1"
		to="10"
		step="1">
      <cfset _time = #TimeFormat( Rand(), "hh:mm TT" )#  />
    </cfloop>
    
    <cfreturn _time />
    
  </cffunction>
  
  <cffunction access="private" output="false" name="getDomainSuffix" returnType="String">

    <cfset arr=[
    "aero",
    "biz",
    "cat",
    "com",
    "coop",
    "edu",
    "gov",
    "info",
    "int",
    "jobs",
    "mil",
    "mobi",
    "museum",
    "name",
    "net",
    "org",
    "travel",
    "ac",
    "ad",
    "ae",
    "af",
    "ag",
    "ai",
    "al",
    "am",
    "an",
    "ao",
    "aq",
    "ar",
    "as",
    "at",
    "au",
    "aw",
    "az",
    "ba",
    "bb",
    "bd",
    "be",
    "bf",
    "bg",
    "bh",
    "bi",
    "bj",
    "bm",
    "bn",
    "bo",
    "br",
    "bs",
    "bt",
    "bv",
    "bw",
    "by",
    "bz",
    "ca",
    "cc",
    "cd",
    "cf",
    "cg",
    "ch",
    "ci",
    "ck",
    "cl",
    "cm",
    "cn",
    "co",
    "cr",
    "cs",
    "cu",
    "cv",
    "cx",
    "cy",
    "cz",
    "de",
    "dj",
    "dk",
    "dm",
    "do",
    "dz",
    "ec",
    "ee",
    "eg",
    "eh",
    "er",
    "es",
    "et",
    "eu",
    "fi",
    "fj",
    "fk",
    "fm",
    "fo",
    "fr",
    "ga",
    "gb",
    "gd",
    "ge",
    "gf",
    "gg",
    "gh",
    "gi",
    "gl",
    "gm",
    "gn",
    "gp",
    "gq",
    "gr",
    "gs",
    "gt",
    "gu",
    "gw",
    "gy",
    "hk",
    "hm",
    "hn",
    "hr",
    "ht",
    "hu",
    "id",
    "ie",
    "il",
    "im",
    "in",
    "io",
    "iq",
    "ir",
    "is",
    "it",
    "je",
    "jm",
    "jo",
    "jp",
    "ke",
    "kg",
    "kh",
    "ki",
    "km",
    "kn",
    "kp",
    "kr",
    "kw",
    "ky",
    "kz",
    "la",
    "lb",
    "lc",
    "li",
    "lk",
    "lr",
    "ls",
    "lt",
    "lu",
    "lv",
    "ly",
    "ma",
    "mc",
    "md",
    "me",
    "mg",
    "mh",
    "mk",
    "ml",
    "mm",
    "mn",
    "mo",
    "mp",
    "mq",
    "mr",
    "ms",
    "mt",
    "mu",
    "mv",
    "mw",
    "mx",
    "my",
    "mz",
    "na",
    "nc",
    "ne",
    "nf",
    "ng",
    "ni",
    "nl",
    "no",
    "np",
    "nr",
    "nu",
    "nz",
    "om",
    "pa",
    "pe",
    "pf",
    "pg",
    "ph",
    "pk",
    "pl",
    "pm",
    "pn",
    "pr",
    "ps",
    "pt",
    "pw",
    "py",
    "qa",
    "re",
    "ro",
    "rs",
    "ru",
    "rw",
    "sa",
    "sb",
    "sc",
    "sd",
    "se",
    "sg",
    "sh",
    "si",
    "sj",
    "sk",
    "sl",
    "sm",
    "sn",
    "so",
    "sr",
    "st",
    "su",
    "sv",
    "sy",
    "sz",
    "tc",
    "td",
    "tf",
    "tg",
    "th",
    "tj",
    "tk",
    "tl",
    "tm",
    "tn",
    "to",
    "tp",
    "tr",
    "tt",
    "tv",
    "tw",
    "tz",
    "ua",
    "ug",
    "uk",
    "um",
    "us",
    "uy",
    "uz",
    "va",
    "vc",
    "ve",
    "vg",
    "vi",
    "vn",
    "vu",
    "wf",
    "ws",
    "ye",
    "yt",
    "yu",
    "za",
    "zm",
    "zr",
    "zw"
    ]>
    <cfset index = #RandRange(1, #ArrayLen(arr)#, "SHA1PRNG")#   />
    <cfset str = #arr[index]#   />
    
    <cfreturn str>
    
  </cffunction>
  
  <cffunction access="private" output="false" name="getRoadName" returnType="String">

    <cfset var arr=[
   "ABERNATHY"
  ,"ADELAIDE WALTERS"
  ,"ADIRONDACK"
  ,"ALASKA"
  ,"ALBANY"
  ,"ALDER"
  ,"ALDERSHOT"
  ,"ALEXANDER"
  ,"ALICE INGRAM"
  ,"ANNA BELLE"
  ,"ARBOR LEA"
  ,"ARBORETUM"
  ,"ARBUTUS"
  ,"ARCHDALE"
  ,"ASCOT"
  ,"ASHE"
  ,"AUDLEY"
  ,"AUTUMN"
  ,"AVERY"
  ,"AYCOCK"
  ,"AZALEA"
  ,"BALTHROPE"
  ,"BANBURY"
  ,"BANSTEAD"
  ,"BARBEE CHAPEL"
  ,"BAREFOOT"
  ,"BARN"
  ,"BARNES"
  ,"BARNHARDT"
  ,"BARTRAM"
  ,"BASKERVILLE"
  ,"BAXTER"
  ,"BAY COLONY"
  ,"BAYBERRY"
  ,"BAYNES"
  ,"BAYSWATER"
  ,"BEAR TREE"
  ,"BEARKLING"
  ,"BEAVER DAM"
  ,"BEECH"
  ,"BEECHAM"
  ,"BEECHRIDGE"
  ,"BELFAIR"
  ,"BELMONT"
  ,"BENBURY"
  ,"BENWICK"
  ,"BERKLEY"
  ,"BICKETT"
  ,"BIG ROCK"
  ,"BIG WOODS"
  ,"BIRCH"
  ,"BLACK OAK"
  ,"BLACK TRUMPET"
  ,"BLACKBERRY"
  ,"BLACKNELL"
  ,"BLAKELY"
  ,"BLOOMSBURY"
  ,"BLUEFIELD"
  ,"BOLINAS"
  ,"BOOTHE HILL"
  ,"BOST"
  ,"BOTANICAL"
  ,"BOXWOOD"
  ,"BOYD"
  ,"BRADFORD"
  ,"BRAGG"
  ,"BRANCH"
  ,"BRANDON"
  ,"BRIGHAM"
  ,"BRITT"
  ,"BRITTANY"
  ,"BROAD LEAF"
  ,"BROGDEN"
  ,"BROOKBERRY"
  ,"BROOKHOLLOW"
  ,"BROUGHTON"
  ,"BROWN BEAR"
  ,"BUCKNER"
  ,"BURNING TREE"
  ,"BURNWOOD"
  ,"BURRINGTON"
  ,"BURTON"
  ,"BUSH CREEK"
  ,"BUTTERFLY"
  ,"BYPASS"
  ,"CABIN"
  ,"CANTERBURY"
  ,"CAROLINA"
  ,"CAROLINA MEADOWS VILLA"
  ,"CARR"
  ,"CARRIAGE"
  ,"CARSON"
  ,"CARTERET"
  ,"CARY"
  ,"CEDAR BERRY"
  ,"CEDAR BREEZE"
  ,"CEDAR CLUB"
  ,"CEDAR MEADOWS"
  ,"CEDAR POND"
  ,"CELESTE"
  ,"CENTRAL"
  ,"CHARLESBERRY"
  ,"CHARLESTON"
  ,"CHARRINGTON"
  ,"CHATHAM"
  ,"CHATHAM DOWNS"
  ,"CHEDWORTH"
  ,"CHEROKEE"
  ,"CHERRY"
  ,"CHESTNUT"
  ,"CHIMENEAS"
  ,"CHURCHILL"
  ,"CIRCLE PARK"
  ,"CLEARWATER FARM"
  ,"CLEARWATER LAKE"
  ,"CLELAND"
  ,"CLOVER"
  ,"CLUB"
  ,"COKER"
  ,"COLBY"
  ,"COLCHESTER"
  ,"COLE"
  ,"COLE PLAZA"
  ,"COLONY WOODS"
  ,"CONEFLOWER"
  ,"CONTINENTAL TRAILER"
  ,"COOPER"
  ,"COOPER GLEN"
  ,"COPELAND"
  ,"COPPER BEECH"
  ,"COUNCIL"
  ,"CRAIG"
  ,"CRANEBRIDGE"
  ,"CRESCENT"
  ,"CRESTWOOD"
  ,"CREW"
  ,"CROSS CREEK"
  ,"CROSSLAND"
  ,"CRYSTAL"
  ,"CUB CREEK"
  ,"CURRIE"
  ,"CYPRESS"
  ,"DALTON"
  ,"DANIEL"
  ,"DARTFORD"
  ,"DAVENTRY"
  ,"DAVID MILLER"
  ,"DAVID STONE"
  ,"DAVIE"
  ,"DAVIS LOVE"
  ,"DEE"
  ,"DEERWOOD"
  ,"DEFOE"
  ,"DIGGS"
  ,"DOBBS"
  ,"DOGWOOD"
  ,"DONEGAL"
  ,"DOUGLAS"
  ,"DRAGONFLY"
  ,"DRISKELL"
  ,"DROUGHTON"
  ,"DRUMMOND"
  ,"DUBOSE HOME"
  ,"DUCHESS"
  ,"DUDLEY"
  ,"DUNBROOK"
  ,"DUNDALK"
  ,"DUNMORE"
  ,"DURANT"
  ,"DUTCHESS"
  ,"EAGLE"
  ,"EASTCHURCH"
  ,"EASTWIND"
  ,"ECHO"
  ,"EDEN"
  ,"EDEN"
  ,"EDGESTONE"
  ,"EDGEWOOD"
  ,"EDWARDS RIDGE"
  ,"EDWARDS RIDGE"
  ,"EHRINGHAUS"
  ,"ELCOMBE"
  ,"ELDERBERRY"
  ,"ELLSWORTH"
  ,"ELM"
  ,"ELMDALE"
  ,"ELMSTEAD"
  ,"EMORY"
  ,"EPHESUS CHURCH"
  ,"EPHESUS CHURCH"
  ,"ESSEX"
  ,"ESTES"
  ,"EUROPA"
  ,"EVERARD"
  ,"FAIRFIELD"
  ,"FAIRLANE"
  ,"FAISON"
  ,"FALCONBRIDGE"
  ,"FALKNER"
  ,"FALMOUTH"
  ,"FARMINGTON"
  ,"FARRINGTON"
  ,"FARRINGTON MILL"
  ,"FARRINGTON POINT"
  ,"FELLOWSHIP"
  ,"FENTON"
  ,"FERRELL"
  ,"FINLEY FOREST"
  ,"FINLEY GOLF COURSE"
  ,"FIRESIDE"
  ,"FLAGSTONE"
  ,"FLEMINGTON"
  ,"FOREST"
  ,"FORKED PINE"
  ,"FORSYTH"
  ,"FORSYTHIA"
  ,"FOUNDERS RIDGE"
  ,"FOUNTAIN"
  ,"FOUNTAIN RIDGE"
  ,"FOUNTAIN RIDGE"
  ,"FOWLE"
  ,"FOXHALL"
  ,"FRANCES"
  ,"FRANKLIN"
  ,"FRIAR"
  ,"FRIDAY CENTER"
  ,"GALLUP"
  ,"GALWAY"
  ,"GARDEN"
  ,"GATTIS"
  ,"GIBBS"
  ,"GLEN FOREST"
  ,"GLEN LENNOX SHOP"
  ,"GLENN GLADE"
  ,"GOLDEN HEATHER"
  ,"GOLFERS RIDGE"
  ,"GOVERNORS"
  ,"GRACE"
  ,"GRADY"
  ,"GRAHAM"
  ,"GRASSY CREEK"
  ,"GRAY BLUFF"
  ,"GREAT OAKS"
  ,"GREEN CEDAR"
  ,"GREY SQUIRREL"
  ,"GRIER"
  ,"GROVE"
  ,"GURNSEY"
  ,"HADDON HALL"
  ,"HALENEWO"
  ,"HAMILTON"
  ,"HAMMOCK"
  ,"HAMPTON HILL"
  ,"HANCOCK"
  ,"HARRINGTON"
  ,"HARVEY"
  ,"HASELL"
  ,"HAWKINS"
  ,"HAWTHORN"
  ,"HAWTHORNE"
  ,"HAYES"
  ,"HAYWORTH"
  ,"HEATH"
  ,"HEATHER"
  ,"HEBRIDES"
  ,"HELMSDALE"
  ,"HEMLOCK"
  ,"HENLEY"
  ,"HICKORY"
  ,"HIDDEN OAKS"
  ,"HIGHLAND"
  ,"HIGHLAND WOODS"
  ,"HIGHVIEW"
  ,"HIGHVIEW"
  ,"HILLSIDE"
  ,"HILLSIDE"
  ,"HINTON"
  ,"HODGES"
  ,"HOEY"
  ,"HOLDEN"
  ,"HOLLY"
  ,"HOLMES"
  ,"HOLT"
  ,"HOMEPLACE"
  ,"HUDSON"
  ,"HUMMINGBIRD HILL"
  ,"HUNTER HILL"
  ,"HUNTERS"
  ,"HUNTERS RIDGE"
  ,"HUNTINGRIDGE"
  ,"HUTERS"
  ,"HYDE"
  ,"IREDELL"
  ,"JACK BENNETT"
  ,"JACKIE ROBINSON"
  ,"JAMESTOWNE"
  ,"JARVIS"
  ,"JAY THOMAS"
  ,"JEREMIAH"
  ,"JOES"
  ,"JOLYN"
  ,"JONES BRANCH"
  ,"JORDAN"
  ,"JORDAN LAKE MH"
  ,"KENDALL"
  ,"KENNEBEC"
  ,"KEPLEY"
  ,"KILEWAY"
  ,"KILLINGTON"
  ,"KINGS MILL"
  ,"KINGSWOOD"
  ,"KINGSWOOD"
  ,"KINSALE"
  ,"KITCHIN"
  ,"KNOB"
  ,"KNOTTY PINE"
  ,"LACROSSE"
  ,"LAKE VALLEY"
  ,"LAMONT"
  ,"LANARK"
  ,"LANCASTER"
  ,"LANDERWOOD"
  ,"LANIER"
  ,"LARIAT"
  ,"LARK"
  ,"LARKINS"
  ,"LAURA MAY"
  ,"LAUREL HILL ROAD"
  ,"LECLAIR"
  ,"LEGEND OAKS"
  ,"LEGION"
  ,"LEGION ROAD"
  ,"LINDEN"
  ,"LITTLE"
  ,"LITTLE BRANCH"
  ,"LITTLEJOHN"
  ,"LOMBARD"
  ,"LONG"
  ,"LONGLEAF"
  ,"LUDWELL"
  ,"LUNA"
  ,"LYNN"
  ,"LYNWOOD"
  ,"LYSTRA"
  ,"LYSTRA"
  ,"LYSTRA ESTATES"
  ,"LYSTRA HILLS"
  ,"MADERA"
  ,"MADISON WOMBLE"
  ,"MAJESTIC"
  ,"MALLARD"
  ,"MANGUM"
  ,"MANLY"
  ,"MANLY"
  ,"MARLON"
  ,"MARRIOTT"
  ,"MARTIN LUTHER KING JR"
  ,"MARVIN EDWARDS"
  ,"MAXWELL"
  ,"MCGHEE"
  ,"MCGREGOR WOODS"
  ,"MCGREGOR WOODS"
  ,"MCLEAN"
  ,"MEADOW"
  ,"MEADOW RIDGE"
  ,"MEADOW RUN"
  ,"MEADOWMONT"
  ,"MEADOWMONT VILLAGE"
  ,"MERRITT"
  ,"MILL HILL"
  ,"MILLER"
  ,"MILLINGPORT"
  ,"MIRAMAR"
  ,"MONXTON"
  ,"MOREHEAD"
  ,"MORGAN BEND"
  ,"MORGAN BLUFF"
  ,"MORGAN CREEK"
  ,"MORGANSCLIFF"
  ,"MORING"
  ,"MORTON"
  ,"MOSELEY"
  ,"MOUNT CARMEL CHURCH"
  ,"MOUNTAIN HEATHER"
  ,"MOUNTAIN LAUREL"
  ,"MOURNING DOVE"
  ,"MURRAY"
  ,"NASH"
  ,"NATURE"
  ,"NELSON"
  ,"NEW CASTLE"
  ,"NEW COOPER"
  ,"NEW RHODODENDRON"
  ,"NEWMAN"
  ,"NIGHT HERON"
  ,"NO RECORD"
  ,"NOTTINGHAM"
  ,"NOTTINGHAM"
  ,"OAK PARK"
  ,"OAK TREE"
  ,"OAKLEY FARM"
  ,"OAKRIDGE"
  ,"OAKWOOD"
  ,"OCOEE FALLS"
  ,"OLD BARN"
  ,"OLD BRIDGE"
  ,"OLD COOPER"
  ,"OLD DURHAM"
  ,"OLD FARRINGTON"
  ,"OLD HOPE VALLEY FARM"
  ,"OLD LYSTRA"
  ,"OLD LYSTRA"
  ,"OLD MASON FARM"
  ,"OLD ORCHARD"
  ,"OLD POST"
  ,"OLD WILDER"
  ,"ORCHARD"
  ,"OTEYS"
  ,"OVAL PARK"
  ,"OVERLAND"
  ,"OVERLAND"
  ,"OWEN"
  ,"OXFORDSHIRE"
  ,"PADDINGTON"
  ,"PAGE"
  ,"PARK"
  ,"PARK AND STAY TRAILER"
  ,"PARK BLUFF"
  ,"PARKER"
  ,"PARKRIDGE"
  ,"PATTON"
  ,"PEACE"
  ,"PEACEFUL"
  ,"PEARL"
  ,"PERFORMANCE"
  ,"PHARR"
  ,"PIN OAK"
  ,"PINEHURST"
  ,"PINEWOOD"
  ,"PIONEER"
  ,"PLAZA"
  ,"PLAZA DRIVE"
  ,"PLUM"
  ,"PLUMTREE"
  ,"PLUMTREE"
  ,"POINSETT"
  ,"PORTER"
  ,"PRESTWICK"
  ,"PUMP HOUSE"
  ,"QUADRANGLE"
  ,"QUARRY"
  ,"RAINTREE"
  ,"RALEIGH"
  ,"REID"
  ,"REYNOLDS"
  ,"RHODODENDRON"
  ,"RICE"
  ,"RIDGEFIELD"
  ,"RIDGEFIELD"
  ,"RIDGEWAY"
  ,"ROARK HOEY"
  ,"ROBBINS"
  ,"ROCHELLE"
  ,"ROCK HILL"
  ,"RODNEY"
  ,"ROGERSON"
  ,"ROPER"
  ,"ROSEBUD"
  ,"ROWAN"
  ,"RR 12"
  ,"RR 13"
  ,"RR 18"
  ,"RR 6"
  ,"RR 7"
  ,"RR 9"
  ,"RUFFED GROUSE"
  ,"RUFFINS"
  ,"RUNNING CEDAR"
  ,"RUNNING DEER"
  ,"RUSSELL"
  ,"RUTGERS"
  ,"SAINT ANDREWS"
  ,"SAINT AYERS"
  ,"SAINT THOMAS"
  ,"SAM JONES"
  ,"SANDCREEK"
  ,"SAUNDERS"
  ,"SCARLETT"
  ,"SCHNIBBEN"
  ,"SCOTT"
  ,"SERRANO"
  ,"SETTLE"
  ,"SHADY"
  ,"SHADY CREEK"
  ,"SHALLOWFORD"
  ,"SHARON"
  ,"SHEFFIELD"
  ,"SHORT"
  ,"SILERS FEN"
  ,"SILVER BIRCH"
  ,"SIMERVILLE"
  ,"SIR RICHARD"
  ,"SLEEPY"
  ,"SLEEPY HOLLOW"
  ,"SMALL POND"
  ,"SNEEDEN"
  ,"SOTHEL"
  ,"SOURWOOD"
  ,"SOUTHERN GREEN"
  ,"SOUTHWOODS"
  ,"SPAIGHT"
  ,"SPARROW APARTMENTS"
  ,"SPRING"
  ,"SPRING MEADOW"
  ,"SPRINGBERRY"
  ,"SPRINGDALE"
  ,"SPRINGDELL"
  ,"SPRUCE"
  ,"SPRUNT"
  ,"STANCELL"
  ,"STANDISH"
  ,"STANLEY"
  ,"STEDMAN"
  ,"STEEPLE CHASE"
  ,"STEPHENS"
  ,"STOKES"
  ,"STONE"
  ,"SUMMERWALK"
  ,"SUN FOREST"
  ,"SWAIN"
  ,"SWAN LAKE"
  ,"SWAYING TREES"
  ,"SYSTON"
  ,"TAMARACK"
  ,"TANAGER"
  ,"TANYARD"
  ,"TAYLOR HALL"
  ,"THE GLADES"
  ,"THE PRESERVE"
  ,"THORNCROFT"
  ,"THORNWOOD"
  ,"TILBURY"
  ,"TINKERBELL"
  ,"TORREY PINES"
  ,"TOTTENHAM"
  ,"TOWER"
  ,"TRADESCANT"
  ,"TREETOP"
  ,"TRENTON"
  ,"TRILLIUM"
  ,"TRILLIUM"
  ,"TRYON"
  ,"TRYON"
  ,"TURNAGE"
  ,"TURNBERRY"
  ,"TURNER"
  ,"TWEED"
  ,"TWILIGHT"
  ,"UMBRIO"
  ,"UMSTEAD"
  ,"US HIGHWAY 15 501"
  ,"US HIGHWAY 15 501"
  ,"VAIL"
  ,"VAN DOREN"
  ,"VANCE"
  ,"VAUXHALL"
  ,"VICKERS"
  ,"VILLAGE CROSSING"
  ,"VILLAGE PARK"
  ,"WALKER"
  ,"WALNUT"
  ,"WALSER"
  ,"WALTHAM"
  ,"WARD"
  ,"WATERFORD"
  ,"WATTS APARTMENTS"
  ,"WAVE"
  ,"WEAVER MINE"
  ,"WEBB"
  ,"WELLESLEY"
  ,"WENDELL"
  ,"WEYBRIDGE"
  ,"WHIPPOORWILL"
  ,"WHIPPOORWILL"
  ,"WHISPERING PINES"
  ,"WHISPERING PINES MHP"
  ,"WHITE PLAINS"
  ,"WHITE PLAINS"
  ,"WHITE ROCK CHURCH"
  ,"WHITLEY"
  ,"WICKER"
  ,"WICKLOW"
  ,"WILD GINGER"
  ,"WILD GINGER"
  ,"WILDER"
  ,"WILDWOOD"
  ,"WILKINSON"
  ,"WILLOW"
  ,"WILLOWBEND"
  ,"WILLOWSPRING"
  ,"WINDFALL CREEK"
  ,"WINDORAH"
  ,"WINDY RIDGE"
  ,"WINSLOW"
  ,"WINSLOW"
  ,"WINTER"
  ,"WINTER"
  ,"WOOD DUCK"
  ,"WOODBINE"
  ,"WOODLAND"
  ,"WOODSIDE"
  ,"WORTH"
  ,"YALE"
  ,"YORK"
  ,"ZAPATA"
    ]>
    <cfset index = #RandRange(1, #ArrayLen(arr)#, "SHA1PRNG")#   />
    <cfset str = #arr[index]#   />
    
    <cfreturn str>
    
  </cffunction>
  
  <cffunction access="private" output="false" name="getRoadSuffix" returnType="String">

    <cfset arr=[
    "Road",
    "Drive",
    "Ave.",
    "Avenue",
    "Street",
    "Lane",
    "Place",
  	"Trail",
  	"Point",
  	"Pass",
  	"Way",
  	"Crossing",
  	"Trail",
    "Circle",
    "Rd.",
    "Court",
    "Ct.",
  	"St.",
  	"Hwy.",
  	"Highway",
 	"Route",
 	"Rte."
    ]>
    <cfset index = #RandRange(1, #ArrayLen(arr)#, "SHA1PRNG")#   />
    <cfset str = #arr[index]#   />
    
    <cfreturn str>
    
  </cffunction>
  
  <cffunction access="private" output="false" name="getCompassDirection" returnType="String">

    <cfset arr=[
    "North",
    "South",
    "West",
    "East",
    "N.",
    "S.",
    "W.",
  	"E.",
  	"N",
  	"S",
  	"W",
    "E"
    ]>
    <cfset index = #RandRange(1, #ArrayLen(arr)#, "SHA1PRNG")#   />
    <cfset str = #arr[index]#   />
    
    <cfreturn str>
    
  </cffunction>
  
  <cffunction access="public" output="false" name="generateCity" returnType="String">

    <!--- http://moving.about.com/gi/dynamic/offsite.htm?zi=1/XJ&sdn=moving&zu=http%3A%2F%2Fwww.morganquitno.com%2Fcit00dang.htm --->
    <cfset arr=[
    "Birmingham",
    "Huntsville",
    "Mobile",
    "Montgomery",
    "Anchorage",
    "Chandler",
    "Gilbert town",
    "Glendale",
    "Mesa",
    "Peoria",
    "Phoenix",
    "Scottsdale",
    "Tempe",
    "Tucson",
    "Little Rock",
    "Anaheim",
    "Antioch",
    "Bakersfield",
    "Berkeley",
    "Burbank",
    "Chula Vista",
    "Concord",
    "Corona",
    "Costa Mesa",
    "Daly City",
    "Downey",
    "El Monte",
    "Elk Grove",
    "Escondido",
    "Fairfield",
    "Fontana",
    "Fremont",
    "Fresno",
    "Fullerton",
    "Garden Grove",
    "Glendale",
    "Hayward",
    "Huntington Beach",
    "Inglewood",
    "Irvine",
    "Lancaster",
    "Long Beach",
    "Los Angeles",
    "Modesto",
    "Moreno Valley",
    "Norwalk",
    "Oakland",
    "Oceanside",
    "Ontario",
    "Orange",
    "Oxnard",
    "Palmdale",
    "Pasadena",
    "Pomona",
    "Rancho Cucamonga",
    "Richmond",
    "Riverside",
    "Roseville",
    "Sacramento",
    "Salinas",
    "San Bernardino",
    "San Buenaventura (Ventura)",
    "San Diego",
    "San Francisco",
    "San Jose",
    "Santa Ana",
    "Santa Clara",
    "Santa Clarita",
    "Santa Rosa",
    "Simi Valley",
    "Stockton",
    "Sunnyvale",
    "Thousand Oaks",
    "Torrance",
    "Vallejo",
    "Visalia",
    "West Covina",
    "Arvada",
    "Aurora",
    "Colorado Springs",
    "Denver",
    "Fort Collins",
    "Lakewood",
    "Pueblo",
    "Thornton",
    "Westminster",
    "Bridgeport",
    "Hartford",
    "New Haven",
    "Stamford",
    "Waterbury",
    "Washington",
    "Cape Coral",
    "Clearwater",
    "Coral Springs",
    "Fort Lauderdale",
    "Gainesville",
    "Hialeah",
    "Hollywood",
    "Jacksonville",
    "Miami",
    "Miramar",
    "Orlando",
    "Pembroke Pines",
    "Pompano Beach",
    "Port St. Lucie",
    "St. Petersburg",
    "Tallahassee",
    "Tampa",
    "Athens-Clarke County",
    "Atlanta",
    "Augusta-Richmond County",
    "Columbus",
    "Savannah",
    "Honolulu CDP",
    "Boise City",
    "Aurora",
    "Chicago",
    "Joliet",
    "Naperville",
    "Peoria",
    "Rockford",
    "Springfield",
    "Evansville",
    "Fort Wayne",
    "Indianapolis",
    "South Bend",
    "Cedar Rapids",
    "Des Moines",
    "Kansas City",
    "Olathe",
    "Overland Park",
    "Topeka",
    "Wichita",
    "Lexington-Fayette",
    "Louisville-Jefferson County",
    "Baton Rouge",
    "Lafayette",
    "New Orleans",
    "Shreveport",
    "Baltimore",
    "Boston",
    "Cambridge",
    "Lowell",
    "Springfield",
    "Worcester",
    "Ann Arbor",
    "Detroit",
    "Flint",
    "Grand Rapids",
    "Lansing",
    "Sterling Heights",
    "Warren",
    "Minneapolis",
    "St. Paul",
    "Jackson",
    "Independence",
    "Kansas City",
    "Springfield",
    "St. Louis",
    "Lincoln",
    "Omaha",
    "Henderson",
    "Las Vegas",
    "North Las Vegas",
    "Reno",
    "Manchester",
    "Elizabeth",
    "Jersey City",
    "Newark",
    "Paterson",
    "Albuquerque",
    "Buffalo",
    "New York",
    "Rochester",
    "Syracuse",
    "Yonkers",
    "Cary",
    "Charlotte",
    "Durham",
    "Fayetteville",
    "Greensboro",
    "Raleigh",
    "Winston-Salem",
    "Akron",
    "Cincinnati",
    "Cleveland",
    "Columbus",
    "Dayton",
    "Toledo",
    "Norman",
    "Oklahoma City",
    "Tulsa",
    "Eugene",
    "Portland",
    "Salem",
    "Allentown",
    "Erie",
    "Philadelphia",
    "Pittsburgh",
    "Providence",
    "Charleston",
    "Columbia",
    "Sioux Falls",
    "Chattanooga",
    "Clarksville",
    "Knoxville",
    "Memphis",
    "Nashville-Davidson",
    "Abilene",
    "Amarillo",
    "Arlington",
    "Austin",
    "Beaumont",
    "Brownsville",
    "Carrollton",
    "Corpus Christi",
    "Dallas",
    "Denton",
    "El Paso",
    "Fort Worth",
    "Garland",
    "Grand Prairie",
    "Houston",
    "Irving",
    "Killeen",
    "Laredo",
    "Lubbock",
    "McAllen",
    "Mesquite",
    "Pasadena",
    "Plano",
    "San Antonio",
    "Waco",
    "Salt Lake City",
    "West Valley City",
    "Alexandria",
    "Arlington CDP",
    "Chesapeake",
    "Hampton",
    "Newport News",
    "Norfolk",
    "Richmond",
    "Virginia Beach",
    "Bellevue",
    "Seattle",
    "Spokane",
    "Tacoma",
    "Vancouver",
    "Green Bay",
    "Madison",
    "Milwaukee"
     ]>
    <cfset index = #RandRange(1, #ArrayLen(arr)#, "SHA1PRNG")#   />
    <cfset str = #arr[index]#   />
    
    <cfreturn str>
    
  </cffunction>
  
  <cffunction access="public" output="false" name="generateStateAbbreviation" returnType="String">

    <!--- http://moving.about.com/gi/dynamic/offsite.htm?zi=1/XJ&sdn=moving&zu=http%3A%2F%2Fwww.morganquitno.com%2Fcit00dang.htm --->
    <cfset arr=[
        "AL"
  ,       "AK"
  ,       "AZ"
  ,       "AR"
  ,       "CA"
  ,       "CO"
  ,       "CT"
  ,       "DE"
  ,       "FL"
  ,       "GA"
  ,       "HI"
  ,       "ID"
  ,       "IL"
  ,       "IN"
  ,       "IA"
  ,       "KS"
  ,       "KY"
  ,       "LA"
  ,       "ME"
  ,       "MD"
  ,       "MA"
  ,       "MI"
  ,       "MN"
  ,       "MS"
  ,       "MO"
  ,       "MT"
  ,       "NE"
  ,       "NV"
  ,       "NH"
  ,       "NJ"
  ,       "NM"
  ,       "NY"
  ,       "NC"
  ,       "ND"
  ,       "OH"
  ,       "OK"
  ,       "OR"
  ,       "PA"
  ,       "RI"
  ,       "SC"
  ,       "SD"
  ,       "TN"
  ,       "TX"
  ,       "UT"
  ,       "VT"
  ,       "VA"
  ,       "WA"
  ,       "WV"
  ,       "WI"
  ,       "WY"
     ]>
    <cfset index = #RandRange(1, #ArrayLen(arr)#, "SHA1PRNG")#   />
    <cfset str = #arr[index]#   />
    
    <cfreturn str>
    
  </cffunction>
  
  <cffunction access="public" output="false" name="generateStateName" returnType="String">

    <!--- http://moving.about.com/gi/dynamic/offsite.htm?zi=1/XJ&sdn=moving&zu=http%3A%2F%2Fwww.morganquitno.com%2Fcit00dang.htm --->
    <cfset arr=[
      "Alabama"
  ,      "Alaska"
  ,      "Arizona"
  ,      "Arkansas"
  ,      "California"
  ,      "Colorado"
  ,      "Connecticut"
  ,      "Delaware"
  ,      "Florida"
  ,      "Georgia"
  ,      "Hawaii"
  ,      "Idaho"
  ,      "Illinois"
  ,      "Indiana"
  ,      "Iowa"
  ,      "Kansas"
  ,      "Kentucky"
  ,      "Louisiana"
  ,      "Maine"
  ,      "Maryland"
  ,      "Massachusetts"
  ,      "Michigan"
  ,      "Minnesota"
  ,      "Mississippi"
  ,      "Missouri"
  ,      "Montana"
  ,      "Nebraska"
  ,      "Nevada"
  ,      "New Hampshire"
  ,      "New Jersey"
  ,      "New Mexico"
  ,      "New York"
  ,      "North Carolina"
  ,      "North Dakota"
  ,      "Ohio"
  ,      "Oklahoma"
  ,      "Oregon"
  ,      "Pennsylvania"
  ,      "Rhode Island"
  ,      "South Carolina"
  ,      "South Dakota"
  ,      "Tennessee"
  ,      "Texas"
  ,      "Utah"
  ,      "Vermont"
  ,      "Virginia"
  ,      "Washington"
  ,      "West Virginia"
  ,      "Wisconsin"
  ,      "Wyoming"
     ]>
    <cfset index = #RandRange(1, #ArrayLen(arr)#, "SHA1PRNG")#   />
    <cfset str = #arr[index]#   />
    
    <cfreturn str>
    
  </cffunction>
  
  <cffunction access="public" output="false" name="generateCompanyName" returnType="String">

    <!--- sourced : http://money.cnn.com/magazines/fortune/fortune500/2007/full_list/index.html --->
    <cfset arr=[
  "Wal-Mart Stores",
  "Exxon Mobil",
  "General Motors",
  "Chevron",
  "ConocoPhillips",
  "General Electric",
  "Ford Motor",
  "Citigroup",
  "Bank of America Corp.",
  "American Intl. Group",
  "J.P. Morgan Chase & Co.",
  "Berkshire Hathaway",
  "Verizon Communications",
  "Hewlett-Packard",
  "Intl. Business Machines",
  "Valero Energy",
  "Home Depot",
  "McKesson",
  "Cardinal Health",
  "Morgan Stanley",
  "UnitedHealth Group",
  "Merrill Lynch",
  "Altria Group",
  "Goldman Sachs Group",
  "Procter & Gamble",
  "Kroger",
  "AT&T",
  "Boeing",
  "AmerisourceBergen",
  "Marathon Oil",
  "State Farm Insurance Cos",
  "Costco Wholesale",
  "Target",
  "Dell",
  "Wellpoint",
  "Johnson & Johnson",
  "MetLife",
  "Sears Holdings",
  "Pfizer",
  "Dow Chemical",
  "Wells Fargo",
  "United Technologies",
  "United Parcel Service",
  "Walgreen",
  "Lowe's",
  "Wachovia Corp.",
  "Lehman Brothers Holdings",
  "Time Warner",
  "Microsoft",
  "Freddie Mac",
  "CVS/Caremark",
  "Motorola",
  "Sprint Nextel",
  "Medco Health Solutions",
  "Caterpillar",
  "Safeway",
  "Lockheed Martin",
  "Caremark Rx",
  "Archer Daniels Midland",
  "Sunoco",
  "Allstate",
  "Intel",
  "PepsiCo",
  "Walt Disney",
  "Sysco",
  "Prudential Financial",
  "Johnson Controls",
  "FedEx",
  "Honeywell Intl.",
  "Ingram Micro",
  "Alcoa",
  "Best Buy",
  "Northrop Grumman",
  "DuPont",
  "Hess",
  "Federated Dept. Stores",
  "Cisco Systems",
  "New York Life Insurance",
  "American Express",
  "TIAA-CREF",
  "Washington Mutual",
  "Hartford Financial Services",
  "Delphi",
  "Comcast",
  "Aetna",
  "Tyson Foods",
  "HCA",
  "News Corp.",
  "Travelers Cos.",
  "Massachusetts Mutual Life Insurance",
  "Countrywide Financial",
  "General Dynamics",
  "International Paper",
  "Coca-Cola",
  "Liberty Mutual Ins. Group",
  "Raytheon",
  "3M",
  "Deere",
  "Merck",
  "Halliburton",
  "AMR",
  "Abbott Laboratories",
  "Plains All Amer. Pipeline",
  "Nationwide",
  "Weyerhaeuser",
  "Lyondell Chemical",
  "Publix Super Markets",
  "McDonald's",
  "Tech Data",
  "Humana",
  "Electronic Data Systems",
  "Northwestern Mutual",
  "Wyeth",
  "Goodyear Tire & Rubber",
  "Emerson Electric",
  "J.C. Penney",
  "Supervalu",
  "Coca-Cola Enterprises",
  "Constellation Energy",
  "UAL",
  "Apple",
  "AutoNation",
  "U.S. Bancorp",
  "Occidental Petroleum",
  "Sara Lee",
  "Staples",
  "Whirlpool",
  "Tesoro",
  "Bristol-Myers Squibb",
  "Lear",
  "Manpower",
  "Express Scripts",
  "TJX",
  "Rite Aid",
  "Loews",
  "Delta Air Lines",
  "Kimberly-Clark",
  "Bear Stearns",
  "Cigna",
  "Dominion Resources",
  "Paccar",
  "Lennar",
  "Duke Energy",
  "Gap",
  "Xerox",
  "Anheuser-Busch",
  "United States Steel",
  "FPL Group",
  "Eli Lilly",
  "Exelon",
  "Union Pacific",
  "Kohl's",
  "Centex",
  "Capital One Financial",
  "D.R. Horton",
  "Office Depot",
  "Burlington No. Santa Fe",
  "Nike",
  "Progressive",
  "DIRECTV Group",
  "Nucor",
  "Texas Instruments",
  "Computer Sciences",
  "AFLAC",
  "CBS",
  "CHS",
  "Oracle",
  "Southern",
  "Murphy Oil",
  "Pulte Homes",
  "Amgen",
  "Avnet",
  "ConAgra Foods",
  "Fluor",
  "Illinois Tool Works",
  "Chubb",
  "Enterprise GP Holdings",
  "Qwest Communications",
  "Arrow Electronics",
  "USAA",
  "Waste Management",
  "Eastman Kodak",
  "SunTrust Banks",
  "Huntsman",
  "TRW Automotive Holdings",
  "Continental Airlines",
  "Sun Microsystems",
  "National City Corp.",
  "Health Net",
  "Masco",
  "Pepsi Bottling",
  "American Electric Power",
  "Edison International",
  "Textron",
  "Northwest Airlines",
  "PG&E Corp.",
  "L-3 Communications",
  "Eaton",
  "Public Service Enterprise Group",
  "Colgate-Palmolive",
  "Kinder Morgan",
  "Toys 'R U",
  "Marriott International",
  "Consolidated Edison",
  "United Auto Group",
  "Phelps Dodge",
  "Marsh & McLennan",
  "ONEOK",
  "Bank of New York Co.",
  "Sempra Energy",
  "Williams",
  "FirstEnergy",
  "General Mills",
  "Aramark",
  "Circuit City Stores",
  "US Airways Group",
  "Smithfield Foods",
  "Viacom",
  "Visteon",
  "Omnicom Group",
  "Cummins",
  "Medtronic",
  "American Standard",
  "EMC",
  "Entergy",
  "PPG Industries",
  "Genworth Financial",
  "KB Home",
  "Reliant Energy",
  "Sanmina-SCI",
  "PNC Financial Services Group",
  "Kellogg",
  "Anadarko Petroleum",
  "TXU",
  "World Fuel Services",
  "Unum Group",
  "Amazon.com",
  "Progress Energy",
  "Devon Energy",
  "Limited Brands",
  "Google",
  "Schering-Plough",
  "Solectron",
  "Genuine Parts",
  "Baxter International",
  "Dean Foods",
  "Aon",
  "Ashland",
  "YRC Worldwide",
  "Principal Financial",
  "Xcel Energy",
  "Echostar Communications",
  "ArvinMeritor",
  "Harrah's Entertainment",
  "Dana",
  "Alltel",
  "Guardian Life of America",
  "Tenet Healthcare",
  "TEPPCO Partner",
  "Danaher",
  "CSX",
  "Yum Brands",
  "State St. Corp.",
  "Fidelity National Financial",
  "BB&T Corp.",
  "Parker Hannifin",
  "Norfolk Southern",
  "S&C Holdco 3",
  "H.J. Heinz",
  "CenterPoint Energy",
  "R.R. Donnelley & Sons",
  "Automatic Data Proc.",
  "Dollar General",
  "Applied Materials",
  "Air Products & Chem.",
  "Southwest Airlines",
  "Lincoln National",
  "Baker Hughes",
  "DTE Energy",
  "OfficeMax",
  "Liberty Media",
  "Lucent Technologies",
  "Avon Products",
  "SLM",
  "Sonic Automotive",
  "Nordstrom",
  "BJ's Wholesale Club",
  "Reynolds American",
  "First American Corp.",
  "Pepco Holdings",
  "Praxair",
  "Rohm & Haas",
  "Apache",
  "Fortune Brands",
  "ITT",
  "Hilton Hotels",
  "Ameriprise Financial",
  "SAIC",
  "Fifth Third Bancorp",
  "Assurant"
    ]>
    <cfset index = #RandRange(1, #ArrayLen(arr)#, "SHA1PRNG")#   />
    <cfset str = #arr[index]#   />
    
    <cfreturn str >
    
  </cffunction>
  
  <cffunction access="public" output="false" name="generateLastName" returnType="String">

    <!--- sourced : http://names.mongabay.com --->
    <cfset arr=[
  "SMITH",
  "JOHNSON",
  "WILLIAMS",
  "JONES",
  "BROWN",
  "DAVIS",
  "MILLER",
  "WILSON",
  "MOORE",
  "TAYLOR",
  "ANDERSON",
  "THOMAS",
  "JACKSON",
  "WHITE",
  "HARRIS",
  "MARTIN",
  "THOMPSON",
  "GARCIA",
  "MARTINEZ",
  "ROBINSON",
  "CLARK",
  "RODRIGUEZ",
  "LEWIS",
  "LEE",
  "WALKER",
  "HALL",
  "ALLEN",
  "YOUNG",
  "HERNANDEZ",
  "KING",
  "WRIGHT",
  "LOPEZ",
  "HILL",
  "SCOTT",
  "GREEN",
  "ADAMS",
  "BAKER",
  "GONZALEZ",
  "NELSON",
  "CARTER",
  "MITCHELL",
  "PEREZ",
  "ROBERTS",
  "TURNER",
  "PHILLIPS",
  "CAMPBELL",
  "PARKER",
  "EVANS",
  "EDWARDS",
  "COLLINS",
  "STEWART",
  "SANCHEZ",
  "MORRIS",
  "ROGERS",
  "REED",
  "COOK",
  "MORGAN",
  "BELL",
  "MURPHY",
  "BAILEY",
  "RIVERA",
  "COOPER",
  "RICHARDSON",
  "COX",
  "HOWARD",
  "WARD",
  "TORRES",
  "PETERSON",
  "GRAY",
  "RAMIREZ",
  "JAMES",
  "WATSON",
  "BROOKS",
  "KELLY",
  "SANDERS",
  "PRICE",
  "BENNETT",
  "WOOD",
  "BARNES",
  "ROSS",
  "HENDERSON",
  "COLEMAN",
  "JENKINS",
  "PERRY",
  "POWELL",
  "LONG",
  "PATTERSON",
  "HUGHES",
  "FLORES",
  "WASHINGTON",
  "BUTLER",
  "SIMMONS",
  "FOSTER",
  "GONZALES",
  "BRYANT",
  "ALEXANDER",
  "RUSSELL",
  "GRIFFIN",
  "DIAZ",
  "HAYES",
  "MYERS",
  "FORD",
  "HAMILTON",
  "GRAHAM",
  "SULLIVAN",
  "WALLACE",
  "WOODS",
  "COLE",
  "WEST",
  "JORDAN",
  "OWENS",
  "REYNOLDS",
  "FISHER",
  "ELLIS",
  "HARRISON",
  "GIBSON",
  "MCDONALD",
  "CRUZ",
  "MARSHALL",
  "ORTIZ",
  "GOMEZ",
  "MURRAY",
  "FREEMAN",
  "WELLS",
  "WEBB",
  "SIMPSON",
  "STEVENS",
  "TUCKER",
  "PORTER",
  "HUNTER",
  "HICKS",
  "CRAWFORD",
  "HENRY",
  "BOYD",
  "MASON",
  "MORALES",
  "KENNEDY",
  "WARREN",
  "DIXON",
  "RAMOS",
  "REYES",
  "BURNS",
  "GORDON",
  "SHAW",
  "HOLMES",
  "RICE",
  "ROBERTSON",
  "HUNT",
  "BLACK",
  "DANIELS",
  "PALMER",
  "MILLS",
  "NICHOLS",
  "GRANT",
  "KNIGHT",
  "FERGUSON",
  "ROSE",
  "STONE",
  "HAWKINS",
  "DUNN",
  "PERKINS",
  "HUDSON",
  "SPENCER",
  "GARDNER",
  "STEPHENS",
  "PAYNE",
  "PIERCE",
  "BERRY",
  "MATTHEWS",
  "ARNOLD",
  "WAGNER",
  "WILLIS",
  "RAY",
  "WATKINS",
  "OLSON",
  "CARROLL",
  "DUNCAN",
  "SNYDER",
  "HART",
  "CUNNINGHAM",
  "BRADLEY",
  "LANE",
  "ANDREWS",
  "RUIZ",
  "HARPER",
  "FOX",
  "RILEY",
  "ARMSTRONG",
  "CARPENTER",
  "WEAVER",
  "GREENE",
  "LAWRENCE",
  "ELLIOTT",
  "CHAVEZ",
  "SIMS",
  "AUSTIN",
  "PETERS",
  "KELLEY",
  "FRANKLIN",
  "LAWSON",
  "FIELDS",
  "GUTIERREZ",
  "RYAN",
  "SCHMIDT",
  "CARR",
  "VASQUEZ",
  "CASTILLO",
  "WHEELER",
  "CHAPMAN",
  "OLIVER",
  "MONTGOMERY",
  "RICHARDS",
  "WILLIAMSON",
  "JOHNSTON",
  "BANKS",
  "MEYER",
  "BISHOP",
  "MCCOY",
  "HOWELL",
  "ALVAREZ",
  "MORRISON",
  "HANSEN",
  "FERNANDEZ",
  "GARZA",
  "HARVEY",
  "LITTLE",
  "BURTON",
  "STANLEY",
  "NGUYEN",
  "GEORGE",
  "JACOBS",
  "REID",
  "KIM",
  "FULLER",
  "LYNCH",
  "DEAN",
  "GILBERT",
  "GARRETT",
  "ROMERO",
  "WELCH",
  "LARSON",
  "FRAZIER",
  "BURKE",
  "HANSON",
  "DAY",
  "MENDOZA",
  "MORENO",
  "BOWMAN",
  "MEDINA",
  "FOWLER",
  "BREWER",
  "HOFFMAN",
  "CARLSON",
  "SILVA",
  "PEARSON",
  "HOLLAND",
  "DOUGLAS",
  "FLEMING",
  "JENSEN",
  "VARGAS",
  "BYRD",
  "DAVIDSON",
  "HOPKINS",
  "MAY",
  "TERRY",
  "HERRERA",
  "WADE",
  "SOTO",
  "WALTERS",
  "CURTIS",
  "NEAL",
  "CALDWELL",
  "LOWE",
  "JENNINGS",
  "BARNETT",
  "GRAVES",
  "JIMENEZ",
  "HORTON",
  "SHELTON",
  "BARRETT",
  "OBRIEN",
  "CASTRO",
  "SUTTON",
  "GREGORY",
  "MCKINNEY",
  "LUCAS",
  "MILES",
  "CRAIG",
  "RODRIQUEZ",
  "CHAMBERS",
  "HOLT",
  "LAMBERT",
  "FLETCHER",
  "WATTS",
  "BATES",
  "HALE",
  "RHODES",
  "PENA",
  "BECK",
  "NEWMAN"
    ]>
    <cfset index = #RandRange(1, #ArrayLen(arr)#, "SHA1PRNG")#   />
    <cfset str = #arr[index]#   />
    
    <cfreturn str >
    
  </cffunction>
  
  <cffunction access="public" output="false" name="generateFirstName" returnType="String">

    <!--- sourced : http://names.mongabay.com --->
    <cfset arr=[
	
	<!--- MEN --->
    "JAMES",
    "JOHN",
    "ROBERT",
    "MICHAEL",
    "WILLIAM",
    "DAVID",
    "RICHARD",
    "CHARLES",
    "JOSEPH",
    "THOMAS",
    "CHRISTOPHER",
    "DANIEL",
    "PAUL",
    "MARK",
    "DONALD",
    "GEORGE",
    "KENNETH",
    "STEVEN",
    "EDWARD",
    "BRIAN",
    "RONALD",
    "ANTHONY",
    "KEVIN",
    "JASON",
    "MATTHEW",
    "GARY",
    "TIMOTHY",
    "JOSE",
    "LARRY",
    "JEFFREY",
    "FRANK",
    "SCOTT",
    "ERIC",
    "STEPHEN",
    "ANDREW",
    "RAYMOND",
    "GREGORY",
    "JOSHUA",
    "JERRY",
    "DENNIS",
    "WALTER",
    "PATRICK",
    "PETER",
    "HAROLD",
    "DOUGLAS",
    "HENRY",
    "CARL",
    "ARTHUR",
    "RYAN",
    "ROGER",
    "JOE",
    "JUAN",
    "JACK",
    "ALBERT",
    "JONATHAN",
    "JUSTIN",
    "TERRY",
    "GERALD",
    "KEITH",
    "SAMUEL",
    "WILLIE",
    "RALPH",
    "LAWRENCE",
    "NICHOLAS",
    "ROY",
    "BENJAMIN",
    "BRUCE",
    "BRANDON",
    "ADAM",
    "HARRY",
    "FRED",
    "WAYNE",
    "BILLY",
    "STEVE",
    "LOUIS",
    "JEREMY",
    "AARON",
    "RANDY",
    "HOWARD",
    "EUGENE",
    "CARLOS",
    "RUSSELL",
    "BOBBY",
    "VICTOR",
    "MARTIN",
    "ERNEST",
    "PHILLIP",
    "TODD",
    "JESSE",
    "CRAIG",
    "ALAN",
    "SHAWN",
    "CLARENCE",
    "SEAN",
    "PHILIP",
    "CHRIS",
    "JOHNNY",
    "EARL",
    "JIMMY",
    "ANTONIO",
    "DANNY",
    "BRYAN",
    "TONY",
    "LUIS",
    "MIKE",
    "STANLEY",
    "LEONARD",
    "NATHAN",
    "DALE",
    "MANUEL",
    "RODNEY",
    "CURTIS",
    "NORMAN",
    "ALLEN",
    "MARVIN",
    "VINCENT",
    "GLENN",
    "JEFFERY",
    "TRAVIS",
    "JEFF",
    "CHAD",
    "JACOB",
    "LEE",
    "MELVIN",
    "ALFRED",
    "KYLE",
    "FRANCIS",
    "BRADLEY",
    "JESUS",
    "HERBERT",
    "FREDERICK",
    "RAY",
    "JOEL",
    "EDWIN",
    "DON",
    "EDDIE",
    "RICKY",
    "TROY",
    "RANDALL",
    "BARRY",
    "ALEXANDER",
    "BERNARD",
    "MARIO",
    "LEROY",
    "FRANCISCO",
    "MARCUS",
    "MICHEAL",
    "THEODORE",
    "CLIFFORD",
    "MIGUEL",
    "OSCAR",
    "JAY",
    "JIM",
    "TOM",
    "CALVIN",
    "ALEX",
    "JON",
    "RONNIE",
    "BILL",
    "LLOYD",
    "TOMMY",
    "LEON",
    "DEREK",
    "WARREN",
    "DARRELL",
    "JEROME",
    "FLOYD",
    "LEO",
    "ALVIN",
    "TIM",
    "WESLEY",
    "GORDON",
    "DEAN",
    "GREG",
    "JORGE",
    "DUSTIN",
    "PEDRO",
    "DERRICK",
    "DAN",
    "LEWIS",
    "ZACHARY",
    "COREY",
    "HERMAN",
    "MAURICE",
    "VERNON",
    "ROBERTO",
    "CLYDE",
    "GLEN",
    "HECTOR",
    "SHANE",
    "RICARDO",
    "SAM",
    "RICK",
    "LESTER",
    "BRENT",
    "RAMON",
    "CHARLIE",
    "TYLER",
    "GILBERT",
    "GENE",
    "MARC",
    "REGINALD",
    "RUBEN",
    "BRETT",
    "ANGEL",
    "NATHANIEL",
    "RAFAEL",
    "LESLIE",
    "EDGAR",
    "MILTON",
    "RAUL",
    "BEN",
    "CHESTER",
    "CECIL",
    "DUANE",
    "FRANKLIN",
    "ANDRE",
    "ELMER",
    "BRAD",
    "GABRIEL",
    "RON",
    "MITCHELL",
    "ROLAND",
    "ARNOLD",
    "HARVEY",
    "JARED",
    "ADRIAN",
    "KARL",
    "CORY",
    "CLAUDE",
    "ERIK",
    "DARRYL",
    "JAMIE",
    "NEIL",
    "JESSIE",
    "CHRISTIAN",
    "JAVIER",
    "FERNANDO",
    "CLINTON",
    "TED",
    "MATHEW",
    "TYRONE",
    "DARREN",
    "LONNIE",
    "LANCE",
    "CODY",
    "JULIO",
    "KELLY",
    "KURT",
    "ALLAN",
    "NELSON",
    "GUY",
    "CLAYTON",
    "HUGH",
    "MAX",
    "DWAYNE",
    "DWIGHT",
    "ARMANDO",
    "FELIX",
    "JIMMIE",
    "EVERETT",
    "JORDAN",
    "IAN",
    "WALLACE",
    "KEN",
    "BOB",
    "JAIME",
    "CASEY",
    "ALFREDO",
    "ALBERTO",
    "DAVE",
    "IVAN",
    "JOHNNIE",
    "SIDNEY",
    "BYRON",
    "JULIAN",
    "ISAAC",
    "MORRIS",
    "CLIFTON",
    "WILLARD",
    "DARYL",
    "ROSS",
    "VIRGIL",
    "ANDY",
    "MARSHALL",
    "SALVADOR",
    "PERRY",
    "KIRK",
    "SERGIO",
    "MARION",
    "TRACY",
    "SETH",
    "KENT",
    "TERRANCE",
    "RENE",
    "EDUARDO",
    "TERRENCE",
    "ENRIQUE",
    "FREDDIE",
    "WADE",
    <!--- WOMEN --->
    "MARY",
    "PATRICIA",
    "LINDA",
    "BARBARA",
    "ELIZABETH",
    "JENNIFER",
    "MARIA",
    "SUSAN",
    "MARGARET",
    "DOROTHY",
    "LISA",
    "NANCY",
    "KAREN",
    "BETTY",
    "HELEN",
    "SANDRA",
    "DONNA",
    "CAROL",
    "RUTH",
    "SHARON",
    "MICHELLE",
    "LAURA",
    "SARAH",
    "KIMBERLY",
    "DEBORAH",
    "JESSICA",
    "SHIRLEY",
    "CYNTHIA",
    "ANGELA",
    "MELISSA",
    "BRENDA",
    "AMY",
    "ANNA",
    "REBECCA",
    "VIRGINIA",
    "KATHLEEN",
    "PAMELA",
    "MARTHA",
    "DEBRA",
    "AMANDA",
    "STEPHANIE",
    "CAROLYN",
    "CHRISTINE",
    "MARIE",
    "JANET",
    "CATHERINE",
    "FRANCES",
    "ANN",
    "JOYCE",
    "DIANE",
    "ALICE",
    "JULIE",
    "HEATHER",
    "TERESA",
    "DORIS",
    "GLORIA",
    "EVELYN",
    "JEAN",
    "CHERYL",
    "MILDRED",
    "KATHERINE",
    "JOAN",
    "ASHLEY",
    "JUDITH",
    "ROSE",
    "JANICE",
    "KELLY",
    "NICOLE",
    "JUDY",
    "CHRISTINA",
    "KATHY",
    "THERESA",
    "BEVERLY",
    "DENISE",
    "TAMMY",
    "IRENE",
    "JANE",
    "LORI",
    "RACHEL",
    "MARILYN",
    "ANDREA",
    "KATHRYN",
    "LOUISE",
    "SARA",
    "ANNE",
    "JACQUELINE",
    "WANDA",
    "BONNIE",
    "JULIA",
    "RUBY",
    "LOIS",
    "TINA",
    "PHYLLIS",
    "NORMA",
    "PAULA",
    "DIANA",
    "ANNIE",
    "LILLIAN",
    "EMILY",
    "ROBIN",
    "PEGGY",
    "CRYSTAL",
    "GLADYS",
    "RITA",
    "DAWN",
    "CONNIE",
    "FLORENCE",
    "TRACY",
    "EDNA",
    "TIFFANY",
    "CARMEN",
    "ROSA",
    "CINDY",
    "GRACE",
    "WENDY",
    "VICTORIA",
    "EDITH",
    "KIM",
    "SHERRY",
    "SYLVIA",
    "JOSEPHINE",
    "THELMA",
    "SHANNON",
    "SHEILA",
    "ETHEL",
    "ELLEN",
    "ELAINE",
    "MARJORIE",
    "CARRIE",
    "CHARLOTTE",
    "MONICA",
    "ESTHER",
    "PAULINE",
    "EMMA",
    "JUANITA",
    "ANITA",
    "RHONDA",
    "HAZEL",
    "AMBER",
    "EVA",
    "DEBBIE",
    "APRIL",
    "LESLIE",
    "CLARA",
    "LUCILLE",
    "JAMIE",
    "JOANNE",
    "ELEANOR",
    "VALERIE",
    "DANIELLE",
    "MEGAN",
    "ALICIA",
    "SUZANNE",
    "MICHELE",
    "GAIL",
    "BERTHA",
    "DARLENE",
    "VERONICA",
    "JILL",
    "ERIN",
    "GERALDINE",
    "LAUREN",
    "CATHY",
    "JOANN",
    "LORRAINE",
    "LYNN",
    "SALLY",
    "REGINA",
    "ERICA",
    "BEATRICE",
    "DOLORES",
    "BERNICE",
    "AUDREY",
    "YVONNE",
    "ANNETTE",
    "JUNE",
    "SAMANTHA",
    "MARION",
    "DANA",
    "STACY",
    "ANA",
    "RENEE",
    "IDA",
    "VIVIAN",
    "ROBERTA",
    "HOLLY",
    "BRITTANY",
    "MELANIE",
    "LORETTA",
    "YOLANDA",
    "JEANETTE",
    "LAURIE",
    "KATIE",
    "KRISTEN",
    "VANESSA",
    "ALMA",
    "SUE",
    "ELSIE",
    "BETH",
    "JEANNE",
    "VICKI",
    "CARLA",
    "TARA",
    "ROSEMARY",
    "EILEEN",
    "TERRI",
    "GERTRUDE",
    "LUCY",
    "TONYA",
    "ELLA",
    "STACEY",
    "WILMA",
    "GINA",
    "KRISTIN",
    "JESSIE",
    "NATALIE",
    "AGNES",
    "VERA",
    "WILLIE",
    "CHARLENE",
    "BESSIE",
    "DELORES",
    "MELINDA",
    "PEARL",
    "ARLENE",
    "MAUREEN",
    "COLLEEN",
    "ALLISON",
    "TAMARA",
    "JOY",
    "GEORGIA",
    "CONSTANCE",
    "LILLIE",
    "CLAUDIA",
    "JACKIE",
    "MARCIA",
    "TANYA",
    "NELLIE",
    "MINNIE",
    "MARLENE",
    "HEIDI",
    "GLENDA",
    "LYDIA",
    "VIOLA",
    "COURTNEY",
    "MARIAN",
    "STELLA",
    "CAROLINE",
    "DORA",
    "JO",
    "VICKIE",
    "MATTIE",
    "TERRY",
    "MAXINE",
    "IRMA",
    "MABEL",
    "MARSHA",
    "MYRTLE",
    "LENA",
    "CHRISTY",
    "DEANNA",
    "PATSY",
    "HILDA",
    "GWENDOLYN",
    "JENNIE",
    "NORA",
    "MARGIE",
    "NINA",
    "CASSANDRA",
    "LEAH",
    "PENNY",
    "KAY",
    "PRISCILLA",
    "NAOMI",
    "CAROLE",
    "BRANDY",
    "OLGA",
    "BILLIE",
    "DIANNE",
    "TRACEY",
    "LEONA",
    "JENNY",
    "FELICIA",
    "SONIA",
    "MIRIAM",
    "VELMA",
    "BECKY",
    "BOBBIE",
    "VIOLET",
    "KRISTINA",
    "TONI",
    "MISTY",
    "MAE",
    "SHELLY",
    "DAISY",
    "RAMONA",
    "SHERRI",
    "ERIKA",
    "KATRINA",
    "CLAIRE",
    "LINDSEY"  
    ]>
    <cfset index = #RandRange(1, #ArrayLen(arr)#, "SHA1PRNG")#   />
    <cfset str = #arr[index]#   />
    
    <cfreturn str >
    
  </cffunction>
  
  <cffunction access="private" output="false" name="getDomainPrefix" returnType="String">

    <cfset var _str = '' />
    <cfswitch expression="#RandRange(1,3,'SHA1PRNG')#">
      <cfcase value="1">
        <cfset _str="http://">
      </cfcase>
      <cfcase value="2">
        <cfset _str="http://www.">
      </cfcase>
      <cfcase value="3">
        <cfset _str="www.">
      </cfcase>
    </cfswitch>
    
    <cfreturn _str />
    
  </cffunction>
  
  <cffunction access="private" output="false" name="getDomainName" returnType="String">

    <cfset var str = '' />
    <cfset var retStr = '' />
    
    <cfinvoke method="generateCompanyName" returnVariable="retStr" />
    <cfset str = ReReplace(retStr,"[[:space:]]*","","all")>
    <cfset str = ReReplace(str,"\&","","all")>
    <cfset str = ReReplace(str,"\.","","all")>
    
    <cfreturn  str />
    
  </cffunction>
  
  <cffunction access="public" output="no" name="generatePassword" returntype="string">

    <cfargument name="min" required="true" type="numeric"  />
    <cfargument name="max" required="true" type="numeric"  />
    <cfset var num =  #RandRange(arguments.min, arguments.max, "SHA1PRNG")# />
    <cfset var count = 1>
    <cfset var str = "">
    <cfloop condition = "count less than or equal to num">
      <cfset count = count + 1>
      
      <cfinvoke method="getPasswordCharacter" returnVariable="retStr" />
      <cfset str = str & retStr>
    </cfloop>
    
    <cfreturn str />
    
  </cffunction>
  
  <cffunction access="private" output="false" name="getPasswordCharacter" returnType="String">

    <cfset arr=[
  "A",
  "B",
  "C",
  "D",
  "E",
  "F",
  "G",
  "H",
  "I",
  "J",
  "K",
  "L",
  "M",
  "N",
  "O",
  "P",
  "Q",
  "R",
  "S",
  "T",
  "U",
  "V",
  "W",
  "X",
  "Y",
  "Z",

  "a",
  "b",
  "c",
  "d",
  "e",
  "f",
  "g",
  "h",
  "i",
  "j",
  "k",
  "l",
  "m",
  "n",
  "o",
  "p",
  "q",
  "r",
  "s",
  "t",
  "u",
  "v",
  "w",
  "x",
  "y",
  "z",

  "0",
  "1",
  "2",
  "3",
  "4",
  "5",
  "6",
  "7",
  "8",
  "9",

  "!",
  "_",
  "-"
    ]>
    <cfset index = #RandRange(1, #ArrayLen(arr)#, "SHA1PRNG")#   />
    <cfset str = #arr[index]#   />
    
    <cfreturn str >
    
  </cffunction>
  
  <cffunction access="public" output="no" name="generateString" returntype="string">

    <cfargument name="min" required="true" type="numeric"  />
    <cfargument name="max" required="true" type="numeric"  />
    <cfset var num =  #RandRange(arguments.min, arguments.max, "SHA1PRNG")# />
    <cfset var count = 1>
    <cfset var str = "">
    <cfloop condition = "count less than or equal to num">

      <cfinvoke method="getLetter" returnVariable="retStr" />
      <cfset str = str & retStr>
      <cfset count = count + 1>
    </cfloop>
    
    <cfreturn str />
    
  </cffunction>
  
  <cffunction access="private" output="false" name="getLetter" returnType="String">

    <cfset arr=[
  "A",
  "B",
  "C",
  "D",
  "E",
  "F",
  "G",
  "H",
  "I",
  "J",
  "K",
  "L",
  "M",
  "N",
  "O",
  "P",
  "Q",
  "R",
  "S",
  "T",
  "U",
  "V",
  "W",
  "X",
  "Y",
  "Z"
    ]>
    <cfset index = #RandRange(1, #ArrayLen(arr)#, "SHA1PRNG")#   />
    <cfset str = #arr[index]#   />
    
    <cfreturn str >
    
  </cffunction>
    
  <cffunction access="public" output="false" name="getBadCharacters" returnType="String">

    <cfset arr=[
"#Chr(161)#","#Chr(162)#","#Chr(163)#","#Chr(164)#","#Chr(165)#","#Chr(166)#","#Chr(167)#","#Chr(168)#","#Chr(169)#","#Chr(170)#","#Chr(171)#","#Chr(172)#","#Chr(173)#","#Chr(174)#","#Chr(175)#","#Chr(176)#","#Chr(177)#","#Chr(178)#","#Chr(179)#","#Chr(180)#","#Chr(181)#","#Chr(182)#","#Chr(183)#","#Chr(184)#","#Chr(185)#","#Chr(186)#","#Chr(187)#","#Chr(188)#","#Chr(189)#","#Chr(190)#","#Chr(191)#","#Chr(215)#","#Chr(247)#","#Chr(192)#","#Chr(193)#","#Chr(194)#","#Chr(195)#","#Chr(196)#","#Chr(197)#","#Chr(198)#","#Chr(199)#","#Chr(200)#","#Chr(201)#","#Chr(202)#","#Chr(203)#","#Chr(204)#","#Chr(205)#","#Chr(206)#","#Chr(207)#","#Chr(208)#","#Chr(209)#","#Chr(210)#","#Chr(211)#","#Chr(212)#","#Chr(213)#","#Chr(214)#","#Chr(216)#","#Chr(217)#","#Chr(218)#","#Chr(219)#","#Chr(220)#","#Chr(221)#","#Chr(222)#","#Chr(223)#","#Chr(224)#","#Chr(225)#","#Chr(226)#","#Chr(227)#","#Chr(228)#","#Chr(229)#","#Chr(230)#","#Chr(231)#","#Chr(232)#","#Chr(233)#","#Chr(234)#","#Chr(235)#","#Chr(236)#","#Chr(237)#","#Chr(238)#","#Chr(239)#","#Chr(240)#","#Chr(241)#","#Chr(242)#","#Chr(243)#","#Chr(244)#","#Chr(245)#","#Chr(246)#","#Chr(248)#","#Chr(249)#","#Chr(250)#","#Chr(251)#","#Chr(252)#","#Chr(253)#","#Chr(254)#","#Chr(255)#","\+","~","\|","x00","x20","x04","x0a","x0d","x1b","x08","x7f","\^","x7f","`","--","\*","\[","\]","\{","\}","\%","\-\;","\r","\(","\)","##"
    ]>
    <cfloop index = "LoopCount" from = "1" to = "#ArrayLen(arr)#">
        <cfoutput>The loop index is #LoopCount#</cfoutput>.<br>
          <cfset str = str & #arr[LoopCount]# & '<br />'   />
    </cfloop>
   
    <cfreturn str >
    
  </cffunction>
  
  <cffunction access="public" output="no" name="generateTextWords" returntype="string">

    <cfargument name="min" required="true" type="numeric"  />
    <cfargument name="max" required="true" type="numeric"  />
    <cfset var num =  #RandRange(arguments.min, arguments.max, "SHA1PRNG")# />
    <cfset var count = 1>
    <cfset var str = "">
    <cfloop condition = "count less than or equal to num">
      <cfset count = count + 1>
      
      <cfinvoke method="getWord" returnVariable="retStr" />
      <cfset str = str & ' ' & retStr>
    </cfloop>
    
    <cfreturn str />
    
  </cffunction>
  
  <cffunction access="public" output="no" name="generateHTMLWords" returntype="string">

    <cfargument name="totalGenerations" required="false" type="numeric" default="10" />
    <cfargument name="wordsInParagraphMax" required="false" type="numeric" default="200" />
    <cfargument name="h1WordCountMax" required="false" type="numeric" default="10" />
    <cfargument name="h2WordCountMax" required="false" type="numeric" default="10" />
    <cfargument name="boldWordCountMax" required="false" type="numeric" default="10" />
    <cfargument name="italicizedWordCountMax" required="false" type="numeric" default="10" />
    <cfset var str = "">
    <cfset var retH1 = ''>
    <cfset var retH2 = ''>
    <cfset var retParagraphs = ''>
    <cfset var retItal = ''>
    <cfloop index = "totalGenerations" from = "1" to = #arguments.totalGenerations#>

      <cfinvoke method="generateH1" loops="#arguments.h1WordCountMax#" returnVariable="retH1" />
      <cfset str = str & retH1>
      
      <cfinvoke 
          method="generateParagraph" 
          italicizedWordCountMax="#arguments.italicizedWordCountMax#" 
          boldWordCountMax="#arguments.boldWordCountMax#" 
          loops="#arguments.wordsInParagraphMax#" 
          returnVariable="retParagraphs" />
      <cfset str = str & retParagraphs>
      
      <cfinvoke 
      	method="generateH2" 
        loops="#arguments.h2WordCountMax#" 
        returnVariable="retH1" />
      <cfset str = str & retH2>
      
      <cfinvoke 
      		method="generateParagraph"  
          	boldWordCountMax="#arguments.boldWordCountMax#" 
          	loops="#arguments.wordsInParagraphMax#" 
          	italicizedWordCountMax="#arguments.italicizedWordCountMax#" 
          	returnVariable="retParagraphs" />
      <cfset str = str & retParagraphs>
      
      <cfinvoke 
          method="generateParagraph" 
          italicizedWordCountMax="#arguments.italicizedWordCountMax#" 
          boldWordCountMax="#arguments.boldWordCountMax#" 
          loops="#arguments.wordsInParagraphMax#" 
          returnVariable="retParagraphs" />
      <cfset str = str & retParagraphs>
    </cfloop>
    
    <cfreturn str />
    
  </cffunction>
  
  <cffunction output="no" access="private" name="generateH1" returntype="string">

    <cfargument name="loops" required="true" type="numeric"/>
    <cfset var str = "">
    <cfset str = str & '<h1>'>
    <cfloop index = "LoopCount" from = "1" to = #arguments.loops#>

      <cfinvoke method="getWord" returnVariable="retWord" />
      <cfset str = str & ' ' & retWord>
    </cfloop>
    <cfset str = str & '</h1>'>
    
    <cfreturn str />
    
  </cffunction>
  
  <cffunction output="no" access="private" name="generateH2" returntype="string">

    <cfargument name="loops" required="true" type="numeric" />
    <cfset var str = "">
    <cfset str = str & '<h2>'>
    <cfloop index = "LoopCount" from = "1" to = #arguments.loops#>

      <cfinvoke method="getWord" returnVariable="retWord" />
      <cfset str = str & ' ' & retWord>
    </cfloop>
    <cfset str = str & '</h2>'>
    
    <cfreturn str />
    
  </cffunction>
  
  <cffunction output="no" access="private" name="generateParagraph" returntype="string">

    <cfargument name="loops" required="true" type="numeric" />
    <cfargument name="boldWordCountMax" required="true" type="numeric" />
    <cfargument name="italicizedWordCountMax" required="true" type="numeric" />
    <cfset var retStr = ''>
    <cfset var str = ''>
    <cfset var boldStr = ''>
    <cfset var linkName = ''>
    <cfset var paragraphWordCount = #RandRange(20, arguments.loops, "SHA1PRNG")# />
    <cfset var randLinkPos =  #RandRange(40, arguments.loops, "SHA1PRNG")# />
    <!--- bold should only show up in bigger paragraphs --->
    <cfset var randBoldPos =  #RandRange(5, arguments.loops, "SHA1PRNG")# />
    <cfset var randItalPos =  #RandRange(5, arguments.loops, "SHA1PRNG")# />
    <cfset var wordCountInLink =  #RandRange(1, 5, "SHA1PRNG")# />
    <cfset str = str & '<p>'>
    <cfloop index = "LoopCount" from = "1" to = #paragraphWordCount#>

      <cfinvoke method="getWord" returnVariable="retParagraphWord" />
      <cfset str = str & ' ' & retParagraphWord>
      <cfif LoopCount is  randLinkPos>
        <cfloop index = "WordCountInLink" from = "1" to = #wordCountInLink#>

          <cfinvoke method="getWord" returnVariable="retLinkWord" />
          <cfset linkName =  linkName & ' ' & retLinkWord & ' '>
        </cfloop>
        <cfset str = str & ' <a href="http://foo.com" target="_blank">#linkName#</a> '>
      </cfif>
      <cfif LoopCount is  randBoldPos>
        <cfset str = str & '<b>'>
        <cfloop index = "boldWordCountMaxText" from = "1" to = #arguments.boldWordCountMax#>

          <cfinvoke method="getWord" returnVariable="retWord" />
          <cfset str =  str & ' ' & retWord & ' '>
        </cfloop>
        <cfset str = str & '</b>'>
      </cfif>
      <cfif LoopCount is  randItalPos>
        <cfset str = str & '<i>'>
        <cfloop index = "ItalWordCountText" from = "1" to = #arguments.italicizedWordCountMax#>

          <cfinvoke method="getWord" returnVariable="retWord" />
          <cfset str =  str & ' ' & retWord & ' '>
        </cfloop>
        <cfset str = str & '</i>'>
      </cfif>
    </cfloop>
    <cfset str = str & '</p>'>
    
    <cfreturn str />
    
  </cffunction>
  
  <cffunction access="private" output="false" name="getHTMLElement" returnType="String">

    <cfset arr=[
  "p",
  "h1",
  "h2",
  "h3",
  "h4",
  "h5",
  "h6",
  "b",
  "u",
  "font"
    ]>
    <cfset index = #RandRange(1, #ArrayLen(arr)#, "SHA1PRNG")#   />
    <cfset str = #arr[index]#   />
    
    <cfreturn str >
    
  </cffunction>
  
  <cffunction access="private" output="false" name="getWord" returnType="String">

    <cfset arr=[
  "Phasellus",
  "sem",
  "dui",
  "egestas",
  "ut",
  "morbi",
  "malesuada",
  "Vivamus",
  "pellentesque",
  "senectus",
  "ligula",
  "vulputate",
  "Integer",
  "et",
  "condimentum",
  "dictum",
  "lectus",
  "tortor",
  "condimentum",
  "aliquam",
  "mauris",
  "netus",
  "adipiscing",
  "vitae",
  "neque",
  "vestibulum",
  "dolor",
  "malesuada",
  "Vivamus",
  "pellentesque",
  "senectus",
  "in",
  "Curabitur",
  "urabitur",
  "ipsum",
  "habitant",
  "dictum",
  "Praesent",
  "tristique",
  "fermentum",
  "quis",
  "ultricies",
  "diam",
  "est",
  "ultricies",
  "leo",
  "volutpat",
  "at",
  "tristique",
  "dapibus",
  "velit"
    ]>
    <cfset index = #RandRange(1, #ArrayLen(arr)#, "SHA1PRNG")#   />
    <cfset str = #arr[index]#   />
    
    <cfreturn str >
    
  </cffunction>
  
  <cffunction name="generateThumbNailImage" access="public" returntype="string">

    <cfset var i=0>
    <cfset var index=0>
    <cfset var q_images="">
    <cfset var str="No image exists">
    <cfdirectory 
    	directory="#request.gazoo_output_directory_path#" 
    	recurse="no" 
    	name="q_images" 
    	action="LIST" />
    <cfif q_images.recordcount>
      <cfset dirsArray = arraynew(1)>
      <cfset i=1>
      <cfloop query="q_images">
        <cfif (q_images.type IS "file") AND (q_images.name contains "thumb")>
          <cfset dirsArray[i] = q_images.name>
          <cfset i = i + 1>
        </cfif>
      </cfloop>
      <cfset index = #RandRange(1, #ArrayLen(dirsArray)#, "SHA1PRNG")#   />
      <cfset str = request.gazoo_image_destination_directory & #dirsArray[index]#   />
    </cfif>
    
    <cfreturn str >
    
  </cffunction>
  
  <cffunction name="generateMacroImage" access="public" returntype="string">

    <cfset var i=0>
    <cfset var index=0>
    <cfset var q_images="">
    <cfset var str="No image exists">
    <cfdirectory 
        directory="#request.gazoo_output_directory_path#" 
        recurse="no" 
        name="q_images" 
        action="LIST" />
    <cfif q_images.recordcount>
      <cfset dirsArray = arraynew(1)>
      <cfset i=1>
      <cfloop query="q_images">
        <cfif (q_images.type IS "file") AND (q_images.name contains "macro")>
          <cfset dirsArray[i] = q_images.name>
          <cfset i = i + 1>
        </cfif>
      </cfloop>
      <cfset index = #RandRange(1, #ArrayLen(dirsArray)#, "SHA1PRNG")#   />
      <cfset str = request.gazoo_image_destination_directory & #dirsArray[index]#   />
    </cfif>
    
    <cfreturn str >
    
  </cffunction>
  
  <cffunction name="generateMatchingImages" access="public" returntype="struct">

    <cfset var i=0>
    <cfset var index=0>
    <cfset var q_images="">
    <cfset var str="No image exists">
    <cfset var imageSetObj=StructNew()>
    <cfset imageSetObj.macroImage =  str/>
    <cfset imageSetObj.thumbNailImage = str/>
    <cfdirectory 
        directory="#request.gazoo_output_directory_path#" 
        recurse="no" 
        name="q_images" 
        action="LIST" />
    <cfif q_images.recordcount>
      <cfset dirsArray = arraynew(1)>
      <cfset i=1>
      <cfloop query="q_images">
        <cfif (q_images.type IS "file") AND (q_images.name contains "macro")>
          <cfset dirsArray[i] = q_images.name>
          <cfset i = i + 1>
        </cfif>
      </cfloop>
      <cfset index = #RandRange(1, #ArrayLen(dirsArray)#, "SHA1PRNG")#   />
      
      <cfinvoke method="generateThumbNailImageByIndex" index="#index#"returnVariable="retThumbnailImage"/>
      <cfset imageSetObj.macroImage =  #request.gazoo_image_destination_directory# & #dirsArray[index]# />
      <cfset imageSetObj.thumbNailImage =  retThumbnailImage />
    </cfif>
    
    <cfreturn imageSetObj >
    
  </cffunction>
  
  <cffunction name="generateThumbNailImageByIndex" access="private" returntype="string">

    <cfargument name="index" required="yes" type="numeric"/>
    <cfset var str = "#request.gazoo_image_destination_directory#image_#arguments.index#_thumb.jpg"/>
    
    <cfreturn str >
    
  </cffunction>
  
</cfcomponent>

