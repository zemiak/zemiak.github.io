local args={...}
local conf = args[1].config
local profileName = args[1].profileName
local profileId = args[1].profileId
-- PGC.print produces debug log
PGC.print('Got profile name, ', profileName, "\n")
local Type_Icons  = {
    ["Traditional Cache"] =            "/images/gc-icons/traditional_16.gif",
    ["Multi-Cache"] =                  "/images/gc-icons/multi_16.gif",
    ["Mystery Cache"] =                "/images/gc-icons/unknown_16.gif",
    ["EarthCache"] =                   "/images/gc-icons/earthcache_16.gif",
    ["Letterbox Hybrid"] =             "/images/gc-icons/letter_16.gif",
    ["Wherigo Cache"] =                "/images/gc-icons/wherigo_16.gif",
    ["Virtual Cache"] =                "/images/gc-icons/virtual_16.gif",
    ["Webcam Cache"] =                 "/images/gc-icons/webcam_16.gif",
    ["Event Cache"] =                  "/images/gc-icons/event_16.gif",
    ["Cache In Trash Out Event"] =     "/images/gc-icons/cito_16.gif",
    ["Mega-Event Cache"] =             "/images/gc-icons/mega.gif",
    ["Locationless Cache"] = "/images/gc-icons/locationless_16.gif",
    ["checkbox"] =                     "/images/check16.png",
    ["Giga-Event Cache"] =             "/images/gc-icons/giga.gif",
    -- Not really the right icon for L&F-events.
    ["Community Celebration Event"] =   "/images/gc-icons/event_16.gif",
    ["Geocaching HQ Block Party"] =      "/images/gc-icons/4738_16.gif",
    ["Geocaching HQ Celebration"] = "/images/gc-icons/3774.gif",
    ["GPS Adventures Maze Exhibit"] =       "/images/gc-icons/2134.gif",
    ["Geocaching HQ Cache"] =               "/images/gc-icons/3773.gif",
    ["Project A.P.E. Cache"] =            "/images/gc-icons/ape_16.gif",
    ["Lab Cache"] =                    "",
}
local months={"January","February","March","April","May","June","July","August","September","October","November","December"}
local numRegions={["Åland Islands"]=1,["Algeria"]=7,["Angola"]=8,["Andorra"]=7,["Argentina"]=24,["Armenia"]=11,["Austria"]=9,["Bahrain"]=5,["Benin"]=4,["Belgium"]=11,["Botswana"]=9,["Brazil"]=26,["Bulgaria"]=6,["Burundi"]=2,["Burkina Faso"]=7,["Canada"]=14,["Cabo Verde"]=12,["Cameroon"]=4,["Chile"]=15,["China"]=32,["Chad"]=2,["Colombia"]=23,["Croatia"]=21,["Cuba"]=14,["Democratic Republic of the Congo"]=6,["Denmark"]=5,["Czechia"]=14,["Djibouti"]=4,["Dominican Republic"]=17,["Estonia"]=15,["Equatorial Guinea"]=2,["Faroe Islands"]=6,["Ethiopia"]=8,["Finland"]=18,["France"]=22,["Gabon"]=5,["Germany"]=16,["Gambia"]=4,["Ghana"]=7,["Greece"]=14,["Hungary"]=20,["Hong Kong"]=3,["Iceland"]=8,["India"]=24,["Ireland"]=5,["Isle of Man"]=6,["Israel"]=6,["Japan"]=47,["Kazakhstan"]=12,["Kenya"]=6,["Italy"]=20,["Latvia"]=4,["Laos"]=10,["Liberia"]=3,["Lesotho"]=7,["Libya"]=9,["Liechtenstein"]=2,["Luxembourg"]=3,["Lithuania"]=10,["Madagascar"]=6,["Maldives"]=5,["Mali"]=9,["Malta"]=3,["Martinique"]=4,["Australia"]=8,["Mauritius"]=10,["Egypt"]=14,["Mexico"]=32,["Montenegro"]=20,["Morocco"]=14,["Mozambique"]=8,["Namibia"]=13,["Netherlands"]=12,["Mauritania"]=5,["New Zealand"]=3,["Niger"]=3,["Nigeria"]=7,["Norway"]=19,["Oman"]=9,["Peru"]=16,["Philippines"]=15,["Poland"]=16,["Portugal"]=20,["Puerto Rico"]=58,["Qatar"]=9,["Russia"]=61,["Rwanda"]=5,["Réunion"]=4,["Saint Helena"]=3,["Sao Tome and Principe"]=1,["Senegal"]=8,["Serbia"]=3,["Sierra Leone"]=3,["Singapore"]=5,["Slovakia"]=8,["Slovenia"]=12,["Somalia"]=1,["Malawi"]=9,["South Africa"]=9,["Spain"]=19,["South Korea"]=17,["Sudan"]=5,["Sweden"]=21,["Swaziland"]=4,["Syria"]=7,["Tanzania"]=20,["Thailand"]=61,["Tunisia"]=18,["Uganda"]=21,["US Virgin Islands"]=2,["Ukraine"]=26,["United Arab Emirates"]=6,["United Kingdom"]=14,["United States"]=53,["Vietnam"]=8,["Zimbabwe"]=10,["Zambia"]=8,["Romania"]=42,["Switzerland"]=26,["Türkiye"]=7}
local numCounties={["Australia"]=552,["Åland Islands"]=16,["Algeria"]=13,["Angola"]=22,["Argentina"]=246,["Austria"]=95,["Benin"]=4,["Belgium"]=589,["Botswana"]=16,["Brazil"]=505,["Burundi"]=3,["Bulgaria"]=28,["Cameroon"]=6,["Canada"]=293,["Chile"]=205,["Chad"]=2,["Czechia"]=77,["Congo"]=4,["Democratic Republic of the Congo"]=9,["Denmark"]=98,["Djibouti"]=6,["Ethiopia"]=18,["Estonia"]=221,["Finland"]=297,["France"]=97,["Gabon"]=6,["Germany"]=401,["Ghana"]=12,["India"]=97,["Isle of Man"]=24,["Italy"]=110,["Jersey"]=12,["Kenya"]=24,["Gambia"]=5,["Latvia"]=120,["Liberia"]=3,["Liechtenstein"]=11,["Lithuania"]=60,["Luxembourg"]=12,["Madagascar"]=11,["Malawi"]=16,["Mali"]=14,["Mauritania"]=7,["Morocco"]=41,["Mozambique"]=21,["Netherlands"]=390,["New Zealand"]=15,["Nigeria"]=11,["Niger"]=3,["Norway"]=428,["Peru"]=40,["Ireland"]=32,["Poland"]=379,["Portugal"]=308,["Burkina Faso"]=7,["Réunion"]=22,["Rwanda"]=6,["Senegal"]=10,["San Marino"]=8,["Serbia"]=54,["Sierra Leone"]=5,["Slovakia"]=79,["Slovenia"]=205,["Somalia"]=2,["South Africa"]=52,["Sudan"]=6,["Sweden"]=290,["Spain"]=50,["Tanzania"]=41,["Switzerland"]=2184,["Tunisia"]=49,["Türkiye"]=61,["Uganda"]=27,["Ukraine"]=168,["United Kingdom"]=102,["United States"]=3141,["Vietnam"]=31,["Zimbabwe"]=32,["Zambia"]=20}
local ContinentCountries = {
	["Africa"] = {"Algeria","Angola","Benin","Botswana","Burkina Faso","Burundi","Cameroon","Cape Verde","Central African Republic","Chad","Comoros","Congo","Democratic Republic of the Congo","Djibouti","Egypt","Equatorial Guinea","Eritrea","Ethiopia","Gabon","Gambia","Ghana","Guinea","Guinea-Bissau","Ivory Coast","Kenya","Lesotho","Liberia","Libya","Madagascar","Malawi","Mali","Mauritania","Mauritius","Mayotte","Morocco","Mozambique","Namibia","Niger","Nigeria","Reunion","Rwanda","Saint Helena","Sao Tome and Principe","Senegal","Seychelles","Sierra Leone","Somalia","South Africa","South Sudan","Sudan","Swaziland","Tanzania","Togo","Tunisia","Uganda","Western Sahara","Zambia","Zimbabwe"},
	["Asia"] = {"Afghanistan","Armenia","Azerbaijan","Bahrain","Bangladesh","Bhutan","Brunei","Cambodia","China","Cyprus","East Timor","Egypt","Georgia","Hong Kong","India","Indonesia","Iran","Iraq","Israel","Japan","Jordan","Kazakhstan","Kuwait","Kyrgyzstan","Laos","Lebanon","Macau","Malaysia","Maldives","Mongolia","Myanmar","Nepal","North Korea","Oman","Pakistan","Palestine","Philippines","Qatar","Russia","Saudi Arabia","Singapore","South Korea","Sri Lanka","Syria","Taiwan","Tajikistan","Thailand","Türkiye","Turkmenistan","United Arab Emirates","Uzbekistan","Vietnam","Yemen"},
	["Europe"] = {"Åland Islands","Albania","Andorra","Austria","Belarus","Belgium","Bosnia and Herzegovina","Bulgaria","Croatia","Czechia","Denmark","Estonia","Faroe Islands","Finland","France","Germany","Gibraltar","Greece","Greenland","Guernsey","Hungary","Iceland","Ireland","Isle of Man","Italy","Jersey","Latvia","Liechtenstein","Lithuania","Luxembourg","North Macedonia","Malta","Moldova","Monaco","Montenegro","Netherlands","Norway","Poland","Portugal","Romania","Russia","San Marino","Sark","Serbia","Slovakia","Slovenia","Spain","Svalbard and Jan Mayen Islands","Sweden","Switzerland","Türkiye","Ukraine","United Kingdom","Vatican City State"},
	["North America"] = {"Anguilla","Antigua and Barbuda","Aruba","Bahamas","Barbados","Belize","Bermuda","Bonaire","British Virgin Islands","Canada","Cayman Islands","Costa Rica","Cuba","Curacao","Dominica","Dominican Republic","El Salvador","Grenada","Guadeloupe","Guatemala","Haiti","Honduras","Jamaica","Martinique","Mexico","Montserrat","Netherlands Antilles","Nicaragua","Panama","Puerto Rico","Saba","Saint Kitts and Nevis","Saint Lucia","Saint Barthélemy","St Eustatius","St Kitts","Saint Vincent and the Grenadines","St. Martin","Trinidad and Tobago","Turks and Caicos Islands","United States","US Virgin Islands"},
	["Oceania"] = {"American Samoa","Australia","Cook Islands","Fiji","French Polynesia","Guam","Kiribati","Marshall Islands","Micronesia","New Caledonia","New Zealand","Niue","Norfolk Island","Northern Mariana Islands","Palau","Papua New Guinea","Pitcairn Islands","Samoa","Solomon Islands","Tonga","Tuvalu","US Minor Outlying Islands","Vanuatu","Wallis And Futuna Islands"},
	["South America"] = {"Argentina","Bolivia","Brazil","Chile","Colombia","Ecuador","Falkland Islands","French Guiana","Guyana","Paraguay","Peru","South Georgia and the South Sandwich Islands","Suriname","Uruguay","Venezuela"}
}
local mostFoundCountry={}
local mostFoundRegion={}
local mostFoundCounty={}
local findsInCountry = {}
local findsInRegion = {}
local findsInCounty = {}
local matchingCountries = {}
local matchingRegions = {}
local matchingCounties = {}

function DebugPrint(a)
	if conf.debug==true then
		PGC.print(a)
	end
end
function PrintFindsText(finds,limit,fields)
  local tmp=PrintFindsTable(finds,limit,fields)
    local res={}
        local tmp1={}
    for _,k in ipairs(fields) do
      table.insert(tmp1,k)
    end
  table.insert(res,table.concat(tmp1," "))

    for _,c in ipairs(tmp) do
      table.insert(res,table.concat(c," "))
    end
    res=table.concat(res,"\n")
return res .. "\n"
end -- end function PrintFindsText
-----------------------------------------------------
function PrintFindsHtml(finds,limit,fields)
  local tmp=PrintFindsTable(finds,limit,fields)
    local res={}
  table.insert(res,"<table>")
    local tmp1={}
    for _,k in ipairs(fields) do
      table.insert(tmp1,k)
    end
  table.insert(res,"<tr><th>"..table.concat(tmp1,"</th><th>").."</th></tr>")

    for _,c in ipairs(tmp) do
      table.insert(res,"<tr><td>"..table.concat(c,"</td><td>").."</td></tr>")
    end
  table.insert(res,"</table>")
    res=table.concat(res,"\n")
return res
end --end function PrintFindsHtml
-----------------------------------------------------
function PrintFindsTable(finds,limit,fields)
  local res={}
    local count=0
    for _,c in ipairs(finds) do
      count=count+1
      if count>limit then
        break
      end
      local tmp={}
      for _,k in ipairs(fields) do
        table.insert(tmp,c[k])
      end
    table.insert(res,tmp)
  end
  return res
end -- end function PrintFindsTable
-----------------------------------------------------
function FilterFromConfig(conf)
  local filter={}
  filter['country'] = conf.country
  filter['region'] = conf.region
  filter['county'] = conf.county
  filter['minVisitDate'] = conf.minVisitDate
  filter['maxVisitDate'] = conf.maxVisitDate
  filter['minHiddenDate'] = conf.minHiddenDate
  filter['maxHiddenDate'] = conf.maxHiddenDate
  filter['excludeTypes']=conf.excludeTypes
  filter['types'] = conf.types
  filter['sizes'] = conf.sizes
  filter['difficulties'] = conf.difficulties
  filter['terrains'] = conf.terrains
  filter['minlatitude'] = conf.minlatitude
  filter['maxlatitude'] = conf.maxlatitude
  filter['minlongitude'] = conf.minlongitude
  filter['maxlongitude'] = conf.maxlongitude
  filter['minFavoritePoints'] = conf.minFavoritePoints
  filter['excludeTravelingGeocaches'] = conf.excludeTravelingGeocaches
  if conf.excludeMostFoundCountry ~= nil and conf.excludeMostFoundCountry ~= false and conf.excludeMostFoundCountry ~= "false" then
	if conf.excludeCountries == nil then conf.excludeCountries = {} end
	if type(conf.excludeCountries) ~= "table" then
		local temp = conf.excludeCountries
		conf.excludeCountries = {}
		table.insert(conf.excludeCountries, temp)
	end
	for _,c in ipairs(mostFoundCountry) do
		table.insert(conf.excludeCountries,c)
	end
  end
  if conf.excludeMostFoundRegion ~= nil and conf.excludeMostFoundRegion ~= false and conf.excludeMostFoundRegion ~= "false" then
	if conf.excludeRegions == nil then conf.excludeRegions = {} end
	if type(conf.excludeRegions) ~= "table" then
		local temp = conf.excludeRegions
		conf.excludeRegions = {}
		table.insert(conf.excludeRegions, temp)
	end
	for _,c in ipairs(mostFoundRegion) do
		table.insert(conf.excludeRegions,matchingRegions[c])
	end
  end
  if conf.excludeMostFoundCounty ~= nil and conf.excludeMostFoundCounty ~= false and conf.excludeMostFoundCounty ~= "false" then
	if conf.excludeCounties == nil then conf.excludeCounties = {} end
	if type(conf.excludeCounties) ~= "table" then
		local temp = conf.excludeCounties
		conf.excludeCounties = {}
		table.insert(conf.excludeCounties, temp)
	end
	for _,c in ipairs(mostFoundCounty) do
		table.insert(conf.excludeCounties,matchingCounties[c])
	end
  end
  filter['excludeCountries'] = conf.excludeCountries
  filter['excludeRegions'] = conf.excludeRegions
  filter['excludeCounties'] = conf.excludeCounties
  filter['includeRegions'] = conf.includeRegions
  filter['includeCounties'] = conf.includeCounties
  filter['visitday'] = conf.visitday
  filter['visitmonth'] = conf.visitmonth
  filter['hiddenday'] = conf.hiddenday
  filter['hiddenmonth'] = conf.hiddenmonth
  filter['minAge'] = conf.minAge
  filter['maxAge'] = conf.maxAge
  filter['excludeCaches'] = conf.excludeCaches
    filter['filters']=conf.filters
  return filter
end -- end function FilterFromConfig
-----------------------------------------------------
function extraInConfig(conf,list)
  	local extra=false
  	local filter={"country","region","county","minVisitDate","maxVisitDate","minHiddenDate",
  				"maxHiddenDate","excludeTypes","types","sizes","difficulties","terrains",
  				"minlatitude","maxlatitude","minlongitude","maxlongitude","minFavoritePoints","excludeTravelingGeocaches",
				"excludeCountries","excludeRegions","excludeCounties","includeRegions","includeCounties","excludeCaches",
				"findsTotal","excludeMostFoundCountry","excludeMostFoundRegion","excludeMostFoundCounty","maxPoints","skipPoints",
				"includeLabCaches","upperlimit",
				"visitday","visitmonth","hiddenday","hiddenmonth","minAge","maxAge",
				"filters","optimize"}
  	local acc={}
  	for _,v in ipairs(filter) do
   		acc[v]=v
    end
  	for _,v in ipairs(list) do
   		acc[v]=v
    end
  	for k,v in pairs(conf) do
    	if acc[k]== nil then
      		PGC.print("\nUnknown config:",k,":",v,"\n")
      		extra=true
      	end
    end
    return extra
end --end extraInConfig(
-----------------------------------------------------
function PrintFilter(filter)
  res=""
    if filter~= nil then
    local l_filters=TableCopy(filter.filters)

  local l_filter=TableCopy(filter)
    l_filter.filters=nil
    local loop_filters={}
    if l_filters==nil then
      table.insert(loop_filters,TableCopy(l_filter))
    else
      for _,t in pairs(l_filters) do
          local tmp=TableCopy(l_filter)
          for k,v in pairs(t) do
            if type(v)=="table" then
                tmp[k]=TableCopy(v)
              else
                tmp[k]=v
              end
          end
          table.insert(loop_filters,tmp)
        end
    end
  --PGC.print("loop_filters",loop_filters)
    --count filters
    local count=0
    for _,_ in ipairs(loop_filters) do
      count=count+1
    end

    if count>=1 then
      res=res.."Filters:("
      local count2=0
      for _,f in ipairs(loop_filters) do
        	if count2>0 then
        	res=res.." OR "
          	end
          count2=count2+1
          local count3=0
          for k,v in pairs(f) do
            count3=count3+1
            if count3>1 then
            res=res.." , "
            end
            if type(v)=="table" then
                res=res.." "..k.." ("
                local count4=0
                for _,d in ipairs(v) do
                  count4=count4+1
                if count4>1 then
                res=res.." , "
                end
                      res=res..d
                end
              res=res..") "
            else
                res=res.." "..k..":"..tostring(v)
            end
          end


      end
      res=res..")"
    else
      res=res.."No Filter"
    end
    else
      res=res.."No Filter"
    end

  return res
end --- end function PrintFilter
-----------------------------------------------------
function GetCombinedFinds(profileId,config)
  --replacement for PGC.GetFinds
  --The resulting caches are combined and sorted
  --additional filter options not included in PGC.GetFinds can also be added
  --minlatitude,maxlatitude, minlongitude, maxlongitude in decimal form
  local function expandFilter(filter)
      local res={}
      for k,v in pairs(filter) do
      -- add custom groups as types and make excludeTypes accociative
      if k=="types" then
            if type(v)=="string" then
             local tmp=v
               res['types']={}
              table.insert(res.types,tmp)
          end
          res.types={}
          for i,t in ipairs(v) do
              if t=="Physical" then
                table.insert(res.types,"Traditional Cache")
                table.insert(res.types,"Mystery Cache")
                table.insert(res.types,"Multi-Cache")
                table.insert(res.types,"Letterbox Hybrid")
                table.insert(res.types,"Wherigo Cache")
                table.insert(res.types,"Project A.P.E. Cache")
                table.insert(res.types,"Geocaching HQ Cache")
              elseif t=="Events" then
                table.insert(res.types,"Event Cache")
                table.insert(res.types,"Cache In Trash Out Event")
                table.insert(res.types,"Community Celebration Event")
                table.insert(res.types,"Mega-Event Cache")
                table.insert(res.types,"Geocaching HQ Block Party")
                table.insert(res.types,"Giga-Event Cache")
                table.insert(res.types,"Geocaching HQ Celebration")
              else
                table.insert(res.types,t)
            end
              end

      -- exclude types
      elseif k=="excludeTypes" then
        	res.excludeTypes={}
          if type(v)=="string" then
              local tmp=v

              res.excludeTypes[tmp]=tmp
          end
          local types=filter.excludeTypes
          --res.excludeTypes={}
          for i,t in ipairs(v) do
              if t=="Physical" then
                res.excludeTypes['Traditional Cache']="Traditional Cache"
                res.excludeTypes['Mystery Cache']="Mystery Cache"
                res.excludeTypes['Multi-Cache']="Multi-Cache"
                res.excludeTypes['Letterbox Hybrid']="Letterbox Hybrid"
                res.excludeTypes['Wherigo Cache']="Wherigo Cache"
                res.excludeTypes['Project A.P.E. Cache']="Project A.P.E. Cache"
                v.excludeTypes['Geocaching HQ Cache']="Geocaching HQ Cache"
              elseif t=="Events" then
                res.excludeTypes['Event Cache']="Event Cache"
                res.excludeTypes['Cache In Trash Out Event']="Cache In Trash Out Event"
                res.excludeTypes['Community Celebration Event']="Community Celebration Event"
                res.excludeTypes['Mega-Event Cache']="Mega-Event Cache"
                res.excludeTypes['Geocaching HQ Block Party']="Geocaching HQ Block Party"
                res.excludeTypes['Giga-Event Cache']="Giga-Event Cache"
                res.excludeTypes['Geocaching HQ Celebration']="Geocaching HQ Celebration"
              else
                res.excludeTypes[t]=t
              end
          end
      -- countries
      elseif k=="country" then
        	res.country={}
          if type(v)=="string" then
			if ContinentCountries[v] ~= nil then
			  for _,u in ipairs(ContinentCountries[v]) do
                res.country[u]=u
			  end
			else
              res.country[v]=v
			end
          else
			  for i,t in ipairs(v) do
				if ContinentCountries[t] ~= nil then
				  for _,u in ipairs(ContinentCountries[t]) do
					res.country[u]=u
				  end
				else
				  res.country[t]=t
				end
			  end
          end
      -- exclude countries
      elseif k=="excludeCountries" or k=="ExcludedCountries" then
        	res.excludeCountries={}
          if type(v)=="string" then
			if ContinentCountries[v] ~= nil then
			  for _,u in ipairs(ContinentCountries[v]) do
                res.excludeCountries[u]=u
			  end
			else
              res.excludeCountries[v]=v
			end
          else
			  for i,t in ipairs(v) do
				if ContinentCountries[t] ~= nil then
				  for _,u in ipairs(ContinentCountries[t]) do
					res.excludeCountries[u]=u
				  end
				else
				  res.excludeCountries[t]=t
				end
			  end
          end
      -- exclude regions
      elseif k=="excludeRegions" or k=="ExcludedRegions" then
        	res.excludeRegions={}
          if type(v)=="string" then
              res.excludeRegions[v]=v
          else
			  for i,t in ipairs(v) do
					res.excludeRegions[t]=t
			  end
          end
      -- exclude counties
      elseif k=="excludeCounties" or k=="ExcludedCounties" then
        	res.excludeCounties={}
          if type(v)=="string" then
              res.excludeCounties[v]=v
          else
			  for i,t in ipairs(v) do
					res.excludeCounties[t]=t
			  end
          end
      -- include regions
      elseif k=="includeRegions" or k=="IncludedRegions" then
        	res.includeRegions={}
          if type(v)=="string" then
              res.includeRegions[v]=v
          else
			  for i,t in ipairs(v) do
					res.includeRegions[t]=t
			  end
          end
      -- include counties
      elseif k=="includeCounties" or k=="IncludedCounties" then
        	res.includeCounties={}
          if type(v)=="string" then
              res.includeCounties[v]=v
          else
			  for i,t in ipairs(v) do
					res.includeCounties[t]=t
			  end
          end
      -- exclude specific caches
      elseif k=="excludeCaches" then
        	res.excludeCaches={}
          if type(v)=="string" then
              res.excludeCaches[v]=v
          else
			  for i,t in ipairs(v) do
					res.excludeCaches[t]=t
			  end
          end
      -- limit find dates
      elseif k=="visitday" then
        	res.visitday={}
          if type(v)=="string" then
              res.visitday[v]=v
          else
			  for i,t in ipairs(v) do
					res.visitday[t]=t
			  end
          end
      elseif k=="visitmonth" then
        	res.visitmonth={}
          if type(v)=="string" then
              res.visitmonth[v]=v
          else
			  for i,t in ipairs(v) do
					res.visitmonth[t]=t
			  end
          end
      -- limit hide dates
      elseif k=="hiddenday" then
        	res.hiddenday={}
          if type(v)=="string" then
              res.hiddenday[v]=v
          else
			  for i,t in ipairs(v) do
					res.hiddenday[t]=t
			  end
          end
      elseif k=="hiddenmonth" then
        	res.hiddenmonth={}
          if type(v)=="string" then
              res.hiddenmonth[v]=v
          else
			  for i,t in ipairs(v) do
					res.hiddenmonth[t]=t
			  end
          end
        else
            res[k]=TableCopy(v)
        end
      end
  return res
  end --function expandFilter(filter) end
    --PGC.print("arg:",config)
  local finds={}
    local finds_lid={}
    local l_config=TableCopy(config)

  --Extract filters
    local l_filters=l_config.filter.filters
    l_config.filter.filters=nil
    local l_filter=l_config.filter
    local loop_filters={}
    if l_filters==nil then
      table.insert(loop_filters,TableCopy(l_filter))
    else
      for _,t in pairs(l_filters) do
          local tmp=TableCopy(l_filter)
          for k,v in pairs(t) do
            if type(v)=="table" then
                tmp[k]=TableCopy(v)
              else
                tmp[k]=v
              end
          end
          table.insert(loop_filters,tmp)
        end
    end
    table.insert(l_config.fields,'visitdate')
	table.insert(l_config.fields,'log_id')
	table.insert(l_config.fields,'country')
	table.insert(l_config.fields,'region')
	table.insert(l_config.fields,'county')
	--PGC.print("Filters:",loop_filters,"\n")
  for i,c in ipairs(loop_filters) do
    l_config.filter=expandFilter(c)
      --PGC.print("expanded filter:",l_config.filter,"\n")
      local filter=l_config.filter
      if filter.excludeTypes~= nil then
      table.insert(l_config.fields,"type")
       end
	   if filter.hiddenday ~= nil or filter.hiddenmonth ~= nil or filter.minAge ~= nil or filter.maxAge ~= nil then
		table.insert(l_config.fields,"hidden")
	   end
	   if l_config.filter.excludeTravelingGeocaches ~= nil then l_config.excludeTravelingGeocaches = l_config.filter.excludeTravelingGeocaches end
        PGC.print("l_config:",l_config)
    local myFinds= PGC.GetFinds(profileId,  l_config)
      local last=#finds+1
      for k,v in ipairs(myFinds) do

          local fail=false
       		if finds_lid[v.log_id]~= nil then
        		fail=true
        	end
          --exclude types
          if filter.excludeTypes~= nil and filter.excludeTypes[v.type]~= nil then
        	--PGC.print("Fail\n")
            fail=true
          end
		  --exclude/re-include countries, regions and counties
		  if (filter.excludeCountries ~= nil and filter.excludeCountries[v.country] ~= nil) then
			  if (filter.includeRegions == nil or filter.includeRegions[v.region] == nil) and (filter.includeCounties == nil or filter.includeCounties[v.county] == nil) then
				fail=true
			  end
		  end
		  if (filter.excludeRegions ~= nil and filter.excludeRegions[v.region] ~= nil) then
			  if (filter.includeCounties == nil or filter.includeCounties[v.county] == nil) then
				fail=true
			  end
		  end
		  if (filter.excludeCounties ~= nil and filter.excludeCounties[v.county] ~= nil) then
			fail=true
		  end
          --exclude specific caches
          if filter.excludeCaches~= nil and filter.excludeCaches[v.gccode]~= nil then
        	--PGC.print("Fail\n")
            fail=true
          end
		  -- Limit find dates
		  if filter.visitday ~= nil and filter.visitday[string.sub(v.visitdate,9,10)] == nil then
			fail = true
		  end
		  if filter.visitmonth ~= nil and filter.visitmonth[string.sub(v.visitdate,6,7)] == nil then
			fail = true
		  end
		  -- Limit hide dates
		  if filter.hiddenday ~= nil and filter.hiddenday[string.sub(v.hidden,9,10)] == nil then
			fail = true
		  end
		  if filter.hiddenmonth ~= nil and filter.hiddenmonth[string.sub(v.hidden,6,7)] == nil then
			fail = true
		  end
		  -- Limit age
		  if filter.minAge ~= nil and (os.time() - os.time({year=string.sub(v.hidden,1,4),month=string.sub(v.hidden,6,7),day=string.sub(v.hidden,9,10)}))/86400 < filter.minAge then
			fail = true
		  end
		  if filter.maxAge ~= nil and (os.time() - os.time({year=string.sub(v.hidden,1,4),month=string.sub(v.hidden,6,7),day=string.sub(v.hidden,9,10)}))/86400 > filter.maxAge then
			fail = true
		  end
		  if filter.hiddenmonth ~= nil and filter.hiddenmonth[string.sub(v.hidden,6,7)] == nil then
			fail = true
		  end
          if filter.minlatitude ~= nil or filter.maxlatitude ~= nil
            or filter.minlongitude ~= nil or filter.maxlongitude ~= nil then
            if v.latitude~=false  then
              if filter.minlatitude ~= nil  and  tonumber(filter.minlatitude)>=tonumber(v.latitude) then
                fail=true
              end
            if filter.maxlatitude ~= nil and  tonumber(filter.maxlatitude)<=tonumber(v.latitude) then
                fail=true
              end
              if filter.minlongitude ~= nil and  tonumber(filter.minlongitude)>=tonumber(v.longitude) then
                fail=true
              end
              if filter.maxlongitude ~= nil and  tonumber(filter.maxlongitude)<=tonumber(v.longitude) then
                fail=true
              end
            else
              fail=true
            end
          end
          if fail==false then
          finds[last] = v
          last=last+1
          end
          --finds_lid[v.log_id]=v
      end
  end
  local sortFinds={}
  --for k,v in spairs(finds_lid, function(t,a,b)  if t[b].visitdate==t[a].visitdate then return t[b].log_id >t[a].log_id else return t[b].visitdate>t[a].visitdate  end end) do
    for k,v in spairs(finds, function(t,a,b)  if t[b].visitdate==t[a].visitdate and t[a].log_id ~= nil and t[b].log_id ~= nil then return t[b].log_id >t[a].log_id else return t[b].visitdate>t[a].visitdate  end end) do

      table.insert(sortFinds,v)
  end
  return sortFinds
end --function GetCombinedFinds
-----------------------------------------------------
function spairs(t, order)
  -- collect the keys
  local keys = {}
  for k in pairs(t) do keys[#keys+1] = k end

    -- if order function given, sort by it by passing the table and keys a, b,
    -- otherwise just sort the keys
    if order then
        table.sort(keys, function(a,b) return order(t, a, b) end)
    else
        table.sort(keys)
    end

    -- return the iterator function
    local i = 0
    return function()
        i = i + 1
        if keys[i] then
            return keys[i], t[keys[i]]
        end
  end
end --function spairs
-----------------------------------------------------
function TableCopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in pairs(orig) do
            copy[orig_key] = TableCopy(orig_value)
        end
        --setmetatable(copy, deepcopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end
-----------------------------------------------------
function ok_html(a)
  if a ==true then
      return '<img src="http://maxcdn.project-gc.com/images/check16.png">'
    elseif a == "maybe" then
	  return '<img src="http://www.geocaching.com/images/wpttypes/sm/8.gif">'
    elseif a == "info" then
	  return ''
    else
	  return '<img src="http://maxcdn.project-gc.com/images/cancel16.png">'
    end
end
-----------------------------------------------------
function ok_text(a)
  if a ==true then
      return 'OK'
    elseif a == "maybe" then
	  return 'Maybe'
    elseif a == "info" then
	  return ''
    else
    return 'Fail'
    end
end
-----------------------------------------------------
	function plural(word)
	  if word == "country" then return "countries" end
	  if word == "county" then return "counties" end
	  return word .. "s"
	end
-----------------------------------------------------
function calculateMostFound()
	local myFinds= PGC.GetFinds(profileId, {fields = {'country','region','county'}})
	local highestCountryTotal = 0
	local highestRegionTotal = 0
	local highestCountyTotal = 0
	for _,f in ipairs(myFinds) do
		if findsInCountry[f.country] == nil then
			findsInCountry[f.country] = 0
			matchingCountries[f.country] = f.country
		end
		findsInCountry[f.country] = findsInCountry[f.country] + 1
		if findsInCountry[f.country] > highestCountryTotal then
			highestCountryTotal = findsInCountry[f.country]
		end

		if f.region ~= nil then
			local region = f.country.."/"..f.region
			if findsInRegion[region] == nil then
				findsInRegion[region] = 0
				matchingCountries[region] = f.country
				matchingRegions[region] = f.region
			end
			findsInRegion[region] = findsInRegion[region] + 1
			if findsInRegion[region] > highestRegionTotal then
				highestRegionTotal = findsInRegion[region]
			end
		end

		if f.county ~= nil then
			local county = f.country.."/"..f.region.."/"..f.county
			if findsInCounty[county] == nil then
				findsInCounty[county] = 0
				matchingCountries[county] = f.country
				matchingRegions[county] = f.region
				matchingCounties[county] = f.county
			end
			findsInCounty[county] = findsInCounty[county] + 1
			if findsInCounty[county] > highestCountyTotal then
				highestCountyTotal = findsInCounty[county]
			end
		end
	end
	for country,count in pairs(findsInCountry) do
		if findsInCountry[country] == highestCountryTotal then
			table.insert(mostFoundCountry, country)
		end
	end
	for region,count in pairs(findsInRegion) do
		if findsInRegion[region] == highestRegionTotal then
			table.insert(mostFoundRegion, region)
		end
	end
	for county,count in pairs(findsInCounty) do
		if findsInCounty[county] == highestCountyTotal then
			table.insert(mostFoundCounty, county)
		end
	end
end
-----------------------------------------------------
function c_jasmer(conf)
	local startyear
	local startmonth
	local endyear = Date().tab.year -- Default is current year
	local endmonth = Date().tab.month -- Default is current month
	local monthCount = 0

	local years = {}
	local months = {}
	local num_per_year = {}
	local enough_caches = false
	local enough_years = false
	local ok = false
	local log = ""
	local html = {}
	local slog=""
	local monthNames = {"January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December" }
	-- Set up filter parameters

	-- exclude_current_month
	local exclude_current_month = conf.exclude_current_month;
	if (exclude_current_month == nil) then exclude_current_month = false end

	local filter=FilterFromConfig(conf)
	-- start_date and end_date
	if(conf.start_date == nil or conf.end_date == nil) then
	  PGC.print("You must supply a start and end date in the tag")
	else
	  filter.minHiddenDate = conf.start_date
	  startyear = tonumber(string.sub(conf.start_date, 1, 4))
	  startmonth = tonumber(string.sub(conf.start_date, 6, 7))
	  --PGC.print("startyear",startyear,"startmonth",startmonth,"\n")

	  if (conf.end_date == "today") then
	    local endday = Date().tab.day
		if (exclude_current_month == true) then
		  local enddate = Date(Date.Format("yyyy-mm-dd"):parse(string.format("%04d-%02d-%02d",endyear,endmonth,1))['time']-86400)
          endyear = enddate.tab.year
		  endmonth = enddate.tab.month
          endday = enddate.tab.day
		end
		filter.maxHiddenDate = string.format("%4d-%2d-%2d", endyear, endmonth, endday)
	  else
		-- Update the end date to the date supplied in the tag
		endyear = tonumber(string.sub(conf.end_date, 1, 4))
		endmonth = tonumber(string.sub(conf.end_date, 6, 7))
		filter.maxHiddenDate = conf.end_date
		 --PGC.print("endyear",endyear,"endmonth",endmonth,"\n")
	  end
	end
	local totalMonths = (endyear - startyear - 1) * 12 + (12 - startmonth + 1) + endmonth
	for yearIndex = 1, endyear - startyear + 1 do
	  -- Create a separate entry for each month of the year
	  years[yearIndex] = { false, false, false, false, false, false, false, false, false, false, false, false }
	  months[yearIndex] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
	end

	-- leeway
	local leeway = conf.leeway
	if (leeway == nil) then leeway = 0 end
	if (string.find(leeway, "%", 1, true) ~= nil) then -- leeway contains a % sign
	  -- figure out how many caches worth of leeway corresponds to the percentage
	  leeway = totalMonths * tonumber(PGC.UTF8SubStr(leeway, 1, string.len(leeway) - 1)) / 100 -- Get the number without the % on the end
	end


	-- per_year
	local per_year = conf.per_year

	-- num_complete_years
	local num_complete_years = conf.num_complete_years

	-- num_complete_months
	local num_complete_months = conf.num_complete_months


	-- num_per_month
	local num_per_month = 1
	if (conf.num_per_month ~= nil) then num_per_month = conf.num_per_month end

	local exclude_types={}
	if conf.exclude_types~= nil then
		for _,v in pairs(conf.exclude_types ) do
			exclude_types[v]=v
		end
	end
	-- Get the user's finds



	local finds = GetCombinedFinds(profileId, { fields = {'gccode', 'cache_name', 'visitdate', 'hidden', 'owner_id', 'type'}, order = 'OLDESTFIRST', filter = filter })

	-- Cycle through the finds, organizing caches by month found, and counting the number of distinct months
	for _,cache in ipairs(finds) do
		if exclude_types[cache.type]==nil then
			local year = tonumber(string.sub(cache.hidden, 1, 4))
			local yearIndex = year - startyear + 1
			local month = tonumber(string.sub(cache.hidden, 6, 7))
			months[yearIndex][month] = months[yearIndex][month] + 1
			if (years[yearIndex][month] == false) then
				years[yearIndex][month] = cache
--				monthCount = monthCount + 1
			end
			if (num_per_year[yearIndex] == nil) then
				num_per_year[yearIndex] = 1
			else
				num_per_year[yearIndex] = num_per_year[yearIndex] + 1
			end
		end
	end

	local monthTable = {}
	local numCompleteYears = 0
	local numCompleteMonths = 0
	local monthColumns = {true, true, true, true, true, true, true, true, true, true, true, true}
	local consecutiveMonths = 0
	local maxConsecutiveMonths = 0
	for yearIndex = 1, endyear - startyear + 1 do
		local year = startyear + yearIndex - 1
		local monthRow = {"<td>"..year.."</td>"}
		local completeYear = true
		for month = 1, 12 do
			if ((year == startyear and month < startmonth) or (year == endyear and month > endmonth)) then
				table.insert(monthRow,"<td bgcolor='grey'></td>")
			elseif months[yearIndex][month] >= num_per_month then
				table.insert(monthRow,"<td bgcolor='#7F7'>"..months[yearIndex][month].."</td>")
				monthCount = monthCount + 1
				consecutiveMonths = consecutiveMonths + 1
			else
				table.insert(monthRow,"<td bgcolor='#F77'>"..months[yearIndex][month].."</td>")
				monthColumns[month] = false
				completeYear = false
				if consecutiveMonths > maxConsecutiveMonths then
					maxConsecutiveMonths = consecutiveMonths
				end
				consecutiveMonths = 0
			end
		end
		table.insert(monthTable,table.concat(monthRow,""))
		if (completeYear == true) then
			numCompleteYears = numCompleteYears + 1
		end
	end
	if consecutiveMonths > maxConsecutiveMonths then
		maxConsecutiveMonths = consecutiveMonths
	end
	for month = 1, 12 do
		if (monthColumns[month] == true) then
			numCompleteMonths = numCompleteMonths + 1
		end
	end
	table.insert(html,"<table><tr><th></th><th>Jan</th><th>Feb</th><th>Mar</th><th>Apr</th><th>May</th><th>Jun</th><th>Jul</th><th>Aug</th><th>Sep</th><th>Oct</th><th>Nov</th><th>Dec</th></tr><tr>"..table.concat(monthTable,"</tr><tr>").."</tr></table>")

	-- Some debug info to make sure parameters are correct
	--PGC.print ("Total months: " .. totalMonths .. ", leeway: " .. leeway .. "\n")
	--PGC.print ("Start date: " .. monthNames[startmonth] .. " " .. startyear .. "\n")
	--PGC.print ("End date: " .. monthNames[endmonth] .. " " .. endyear .. "\n")

	-- If the number of distinct months is at least as many as the requirement,
	-- check that we have the required number per year (if specified)
	if (monthCount >= totalMonths - leeway) then
	  ok = true
	  enough_caches = true
	  enough_years = true
	  if (per_year ~= nil) then
		for yearIndex = 1, endyear - startyear + 1 do
		  if (num_per_year[yearIndex] == nil or num_per_year[yearIndex] < per_year) then
			ok = false
			enough_years = false
		  end
		end
	  end
	  if (num_complete_months ~= nil) then
		  if (numCompleteMonths < num_complete_months) then
			ok = false
		  end
	  end
	  if (num_complete_years ~= nil) then
		  if (numCompleteYears < num_complete_years) then
			ok = false
		  end
	  end
	  if (conf.consecutiveMonths ~= nil) then
		  if (maxConsecutiveMonths < conf.consecutiveMonths) then
			ok = false
		  end
	  end
	end

	-- Generate the sample log
	if(ok == true and not conf.brief) then
	  log = {}

	  table.insert(log, "Here are my qualifying caches:\n")

	  for yearIndex,months in ipairs(years) do
		local year = yearIndex + startyear - 1
		for month,cache in ipairs(months) do
		  if (cache ~= false) then
			table.insert(log, monthNames[month] .. " " .. year .. " " .. cache.type .. " "
				.. cache.gccode .. " " .. cache.cache_name .. "  ".. cache.visitdate)
		  end
		end
	  end
	  log = table.concat(log, "\n")
	end
	local tmp={}
	if (num_complete_months ~= nil or num_complete_years ~= nil) then
		if (num_complete_months ~= nil) then
			table.insert(tmp,profileName .. " has completed " .. numCompleteMonths .. " different month columns of " .. num_complete_months .. " required")
		end
		if (num_complete_years ~= nil) then
			table.insert(tmp,profileName .. " has completed " .. numCompleteYears .. " different years of " .. num_complete_years .. " required")
		end
	elseif (conf.consecutiveMonths ~= nil) then
		table.insert(tmp,profileName .. " has completed " .. maxConsecutiveMonths .. " consecutive months of " .. conf.consecutiveMonths .. " required")
	else
		if ok then
			table.insert(tmp,profileName .. " has  found caches hidden " .. monthCount .. " different month and you needed only " .. totalMonths - leeway)
		else
		  table.insert(tmp,profileName .. " has only found caches hidden " .. monthCount .. " different months, out of " .. totalMonths - leeway .." required")
		end
	end

	slog=table.concat(tmp,"\n")
	shtml=table.concat(tmp,"<br>")

	if per_year~= nil then
	  local tmp=""
		if enough_years == true then
		  tmp= "But you have found at least " .. per_year .. " caches in each year"
		else
			tmp= "And you have not  found at least " .. per_year .. " caches in each year"
		end
		slog=slog.."\n"..tmp
		shtml=shtml.."<br>"..tmp
	end
	slog=slog.."\n"..PrintFilter(filter)
	shtml=shtml.."<br>"..PrintFilter(filter)

	-- Table of qualifying finds
	if (not conf.brief) then
		table.insert(html, "<table><tr><th>Month</th><th>Cache</th>><th>Hidden</th><th>Visit date</th></tr>")

		for yearIndex,months in ipairs(years) do
		  local year = yearIndex + startyear - 1
		  for month, cache in ipairs(months) do
			if (cache == false) then
			  local infoText
			  if ((year > startyear or (year == startyear and month >= startmonth)) and (year < endyear or  (year == endyear and month <= endmonth))) then
				infoText = "Not yet found"
				table.insert(html, "<tr><td><b>" .. monthNames[month] .. " " .. year .."</b></td><td><i style='color:red'>" .. infoText .. "</i></td><td /><td /><td /></tr>")
			  end
			else
				--PGC.print(cache.type .. "\n")
			  table.insert(html, "<tr><td><b>" .. monthNames[month] .. " " .. year .. '</b></td><td><img src="' .. Type_Icons[cache.type] .. '" />&nbsp;<a href=\"http://coord.info/' .. cache.gccode .. '">' .. cache.cache_name .. " (" .. cache.gccode
				  ..")</a><td>" .. cache.hidden .. "</td><td>" .. cache.visitdate .. "</td></tr>")
			end
		  end
		end
	end

	html = table.concat(html)

	local points = nil
	if ok and conf.pointsPer ~= nil then
		points = conf.pointsPer * monthCount
		if conf.skipPoints ~= nil then
			if points <= conf.skipPoints then
				points = 0
			else
				points = points - conf.skipPoints
			end
		end
		if conf.maxPoints ~= nil and points > conf.maxPoints then
			points = conf.maxPoints
		end
	end

	return{ok = ok, log = log, html = html, slog = slog, shtml = shtml, points = points }
end -- end function c_jasmer
----------------------------
function c_DT(conf)
-----------------------------
	function PrintDT(DT,verticalSum,horizontalSum,sum,type,threshold)
		local DThtml={}
    	local line=""
   		for _,t in pairs(type) do
    		line=line..t..", "
     	end
        table.insert(DThtml,line.."<br>")
		local line='<table><tr><th></th><th>1.0</th><th>1.5</th><th>2.0</th><th>2.5</th>'
			..'<th>3.0</th><th>3.5</th><th>4.0</th><th>4.5</th><th>5.0</th><th></th></tr>'
		table.insert(DThtml,line)
		for i=1,9,1 do
			line="<tr><th>"..tostring((i+1)/2).."</th>"
			for j=1,9,1 do
				if DT[i][j]>=threshold then
					line=line..'<td class="align-center" style="color: #000000; background-color: #00b600">'..DT[i][j].."</td>"
				elseif DT[i][j]>0 then
					line=line..'<td class="align-center" style="color: #000000; background-color: #c8b600">'..DT[i][j].."</td>"
				else
					line=line..'<td class="align-center" style="color: #000000; background-color: #FFFFFF">'..DT[i][j].."</td>"
				end
			end
			line=line..'<td class="align-center" style="color: #000000; background-color: #00b600">'..verticalSum[i].."</td>"
			line=line.."</tr>"
			table.insert(DThtml,line)
		end
		line="<tr><td>".."</td>"
		for i=1,9,1 do
				line=line..'<td class="align-center" style="color: #000000; background-color: #00b600">'..horizontalSum[i].."</td>"
		end
		line=line..'<td class="align-center" style="color: #000000; background-color: #b60000">'..sum.."<td></tr>"
		table.insert(DThtml,line)
		table.insert(DThtml,"</table>")
		return table.concat(DThtml)
	end
	--------------------------------
	function process_finds(finds,horizontalSum,verticalSum,DT,found_types,found_regions)
		for i,v in ipairs(finds) do
			if found_types[v.type]== nil then
				found_types[v.type]=v
			end
			if v.region~= nil then
				if found_regions[v.region]== nil then
					found_regions[v.region]=v
				end
			end
			local T=tonumber(v['terrain'])*2-1
			local D=tonumber(v['difficulty'])*2-1
			horizontalSum[T]=horizontalSum[T]+1
			verticalSum[D]=verticalSum[D]+1
			DT[D][T]=DT[D][T]+1
		end
	end
	--------------------------------------------
	local filter=FilterFromConfig(conf)

	if conf.minValue ==nil then
		conf.minValue=1
	end
	if conf.minSum ==nil then
		conf.minSum=100
	end
	local DT={}
	local horizontalSum={}
	local verticalSum={}
	local sum=0
	for i=1,10,1 do
		local tmp={}
		table.insert(DT,tmp)
	end
	for i=1,9,1 do
		horizontalSum[i]=0
		verticalSum[i]=0
		for j=1,9,1 do
				DT[i][j]=0
		end
	end
	local found_types={}
	local found_regions={}
	local found_types_nr=0
	local found_regions_nr=0
	fields = {'gccode','hidden', 'cache_name','region', 'visitdate', 'difficulty', 'terrain','type'}
	local finds = GetCombinedFinds(profileId, {filter=filter, fields = fields, order = 'OLDESTFIRST', })
	process_finds(finds,horizontalSum,verticalSum,DT,found_types,found_regions,sum)
	if conf.laterTypes~= nil then
		filter['maxHiddenDate'] = nil
		filter['minHiddenDate'] = conf.laterMinHiddenDate
		filter['difficulties']=conf.laterdifficulties
		filter['terrains']=conf.laterterrains
		filter['types']=conf.laterTypes
		finds = GetCombinedFinds(profileId, {filter=filter, fields = {'gccode','hidden', 'cache_name','region', 'visitdate', 'difficulty', 'terrain','type'}, order = 'OLDESTFIRST', })
		process_finds(finds,horizontalSum,verticalSum,DT,found_types,found_regions,sum)
	end
	for _,_ in pairs(found_types)do
		found_types_nr=found_types_nr+1
	end
	for _,_ in pairs(found_regions)do
		found_regions_nr=found_regions_nr+1
	end
	for _,v in pairs(verticalSum)do
		sum=sum+v
	end

	--check for number of loops
	local loops=DT[1][1]
	local entries=0
	for i=1,9,1 do
		for j=1,9,1 do
			if DT[i][j]>=conf.minValue then
				entries=entries+1
			end
			loops=math.min(loops,DT[i][j])
		end
	end
	local pcLoops = loops
	for i=1,9,1 do
		for j=1,9,1 do
			if DT[i][j]>loops then
				pcLoops = pcLoops + (1/81)
			end
		end
	end
	local comp=true
	--horizontal D lines
	local horizontalMin={}
	local horizontal={}
	local horizontalNr=0
	for i=1,9,1 do
		horizontalMin[i]=DT[i][1]
		comp=true
		for j=1,9,1 do
			if DT[i][j]<conf.minValue then
					comp=false
				end
		horizontalMin[i]=math.min(horizontalMin[i],DT[i][j])
		end
		if comp then
			table.insert(horizontal,1)
			horizontalNr=horizontalNr+1
		else
			table.insert(horizontal,0)
		end
	end
	--T lines
	local verticalMin={}
	local vertical={}
	local verticalNr=0
	for i=1,9,1 do
		verticalMin[i]=DT[1][i]
		comp=true
		for j=1,9,1 do
			if DT[j][i]<conf.minValue then
				comp=false
			end
			verticalMin[i]=math.min(verticalMin[i],DT[j][i])
		end
		if comp then
			table.insert(vertical,1)
			verticalNr=verticalNr+1
		else
			table.insert(vertical,0)
		end
	end
	-- /line
	local right_diagonalMin=DT[9][1]
	local right_diagonal=0
	comp=true
	for i=1,9,1 do
		if DT[10-i][i]<conf.minValue then
			comp=false
		end
		right_diagonalMin=math.min(right_diagonalMin,DT[10-i][i])
	end
	if comp then
		right_diagonal=1
	end
	DebugPrint("right_diagonalMin",right_diagonalMin,"")
	--\ line
	local left_diagonalMin=DT[1][1]
	local left_diagonal=0
	comp=true
	for i=1,9,1 do
		if DT[i][i]<conf.minValue	then
			comp=false
		end
		left_diagonalMin=math.min(left_diagonalMin,DT[i][i])
	end
	if comp then
		left_diagonal=1
	end
	DebugPrint("left_diagonalMin",left_diagonalMin,"")
	local total_lines=horizontalNr+verticalNr+right_diagonal+left_diagonal
	--horizontalSum
	local horizontalSumNr=0
	for i=1,9,1 do
		if horizontalSum[i]>=conf.minSum then
			horizontalSumNr=horizontalSumNr+1
		end
	end
	--horizontalSum
	local verticalSumNr=0
	for i=1,9,1 do
		if verticalSum[i]>=conf.minSum then
			verticalSumNr=verticalSumNr+1
		end
	end
	DebugPrint("loops:"..loops.."")
	DebugPrint("horizontalNr:"..horizontalNr.."")
	DebugPrint("verticalNr:"..verticalNr.."")
	DebugPrint("right_diagonal:"..right_diagonal.."")
	DebugPrint("left_diagonal:"..left_diagonal.."")
	DebugPrint("entries:"..entries.."")
	DebugPrint("horizontalSumNr:"..horizontalSumNr.."")
	DebugPrint("verticalSumN:"..verticalSumNr.."")
	local ok = false
	local lok=false
	local fail=false
	local html=''
	local ut={}
    local ty=" only of types ("
    if conf.types~= nil then
    for _,t in pairs(conf.types) do
      ty=ty..t..", "
    end
   	ty=ty..")"
    else
    	ty=""
    end
	local tmp = ""

	local threshold = conf.minValue

	table.insert(ut,profileName .. " has"..ty..":")
	for i,v in pairs(conf.conditions) do
		local tmp=""
		if i=="loops" or i=="loop" then
			if (threshold == nil or threshold > v) then
				threshold = v
			end
			if	loops>=v then
				tmp=tmp.."ok:"..loops.." total loops of ".. v.." needed"
				lok=true
			else
				tmp=tmp.."Fail: I had only "..loops .." total loops of ".. v.." needed"
				fail=true
	 		end
			table.insert(ut,tmp)
		elseif i=="loopsPer"then
			if (threshold == nil or threshold > v) then
				threshold = v
			end
			local lloops=1+math.floor(#finds/v)
			if	loops>=lloops then
				tmp=tmp.."ok:"..loops.." total loops of ".. lloops.." needed (1 + one extra for every "..v.." finds)"
				lok=true
			else
				tmp=tmp.."Fail: I had only "..loops .." total loops of ".. lloops.." needed (1 + one extra for every "..v.." finds)"
				fail=true
	 		end
			table.insert(ut,tmp)
		elseif i=="horizontal" then
			if	horizontalNr>=v then
				tmp=tmp.."ok:"..horizontalNr.." horizontal lines of ".. v.." needed"
				lok=true
				if conf.minValue>1 then
					tmp=tmp.." with a min value of "..conf.minValue
				end
			else
				tmp=tmp.."Fail: I had only "..horizontalNr .." horizontal lines of ".. v.." needed"
				fail=true
				if conf.minValue>1 then
					tmp=tmp.." with a min value of "..conf.minValue
				end
	 		end
			table.insert(ut,tmp)
		elseif i=="vertical" then
			if	verticalNr>=v then
				tmp=tmp.."ok:"..verticalNr.." vertical lines of ".. v.." needed"
				lok=true
				if conf.minValue>1 then
					tmp=tmp.." with a min value of "..conf.minValue
				end
			else
				tmp=tmp.."Fail: I had only "..verticalNr .." vertical lines of ".. v.." needed"
				fail=true
				if conf.minValue>1 then
					tmp=tmp.." with a min value of "..conf.minValue
				end
	 		end
			table.insert(ut,tmp)
		elseif i=="left_diagonal" then
			if	left_diagonal>=v then
				tmp=tmp.."ok:"..left_diagonal.." left_diagonal lines of ".. v.." needed"
				lok=true
				if conf.minValue>1 then
					tmp=tmp.." with a min value of "..conf.minValue
				end
			else
				tmp=tmp.."Fail: I had only "..left_diagonal .." left_diagonal lines of ".. v.." needed"
				fail=true
				if conf.minValue>1 then
					tmp=tmp.." with a min value of "..conf.minValue
				end
	 		end
			table.insert(ut,tmp)
		elseif i=="right_diagonal" then
			if	right_diagonal>=v then
				tmp=tmp.."ok:"..right_diagonal.." right_diagonal lines of ".. v.." needed"
				lok=true
				if conf.minValue>1 then
					tmp=tmp.." with a min value of "..conf.minValue
				end
			else
				tmp=tmp.."Fail: I had only "..right_diagonal .." right_diagonal lines of ".. v.." needed"
				fail=true
				if conf.minValue>1 then
					tmp=tmp.." with a min value of "..conf.minValue
				end
	 		end
			table.insert(ut,tmp)
		elseif i=="diagonal" then
			if right_diagonal+left_diagonal>=v then
				tmp=tmp.."ok:"..right_diagonal+left_diagonal.." diagonal lines of ".. v.." needed"
				lok=true
				if conf.minValue>1 then
					tmp=tmp.." with a min value of "..conf.minValue
				end
			else
				tmp=tmp.."Fail: I had only "..right_diagonal+left_diagonal .." diagonal lines of ".. v.." needed"
				fail=true
				if conf.minValue>1 then
					tmp=tmp.." with a min value of "..conf.minValue
				end
	 		end
			table.insert(ut,tmp)
		elseif i=="total_lines" then
			if total_lines>=v then
				tmp=tmp.."ok:".. total_lines.."	total_lines lines of ".. v.." needed"
				lok=true
				if conf.minValue>1 then
					tmp=tmp.." with a min value of "..conf.minValue
				end
			else
				tmp=tmp.."Fail: I had only ".. total_lines .."	total_lines lines of ".. v.." needed"
				fail=true
				if conf.minValue>1 then
					tmp=tmp.." with a min value of "..conf.minValue
				end
	 		end
			table.insert(ut,tmp)
		elseif i=="vertical_horizontal" then
			if verticalNr+horizontalNr>=v then
				tmp=tmp.."ok:".. verticalNr+horizontalNr.."	vertical and/or horizontal lines of ".. v.." needed"
				lok=true
				if conf.minValue>1 then
					tmp=tmp.." with a min value of "..conf.minValue
				end
			else
				tmp=tmp.."Fail: I had only ".. verticalNr+horizontalNr .."	vertical and/or horizontal lines of ".. v.." needed"
				fail=true
				if conf.minValue>1 then
					tmp=tmp.." with a min value of "..conf.minValue
				end
	 		end
			table.insert(ut,tmp)
		elseif i=="entries" then
			if	entries>=v then
				tmp=tmp.."ok:".. entries.."	entries of ".. v.." needed"
				lok=true
				if conf.minValue>1 then
					tmp=tmp.." with a min value of "..conf.minValue
				end
			else
				tmp=tmp.."Fail: I had only ".. entries .." entries of ".. v.." needed"
				fail=true
				if conf.minValue>1 then
					tmp=tmp.." with a min value of "..conf.minValue
				end
	 		end
			table.insert(ut,tmp)
		elseif i=="horizontalSum"	then
			if	horizontalSumNr>=v then
				tmp=tmp.."ok:"..horizontalSumNr.." total horizontal sums greater then "..conf.minSum .." of ".. v.." needed"
				lok=true
				if conf.minValue>1 then
					tmp=tmp.." with a min value of "..conf.minValue
				end
			else
				tmp=tmp.."Fail: I had only "..horizontalSumNr.." total horizontal sums greater then"..conf.minSum .." of ".. v.." needed"
				fail=true
				if conf.minValue>1 then
					tmp=tmp.." with a min value of "..conf.minValue
				end
	 		end
			table.insert(ut,tmp)
		elseif i=="verticalSum"	then
			if	verticalSumNr>=v then
				tmp=tmp.."ok:"..verticalSumNr.." total vertical sums greater then "..conf.minSum .." of ".. v.." needed"
				lok=true
				if conf.minValue>1 then
					tmp=tmp.." with a min value of "..conf.minValue
				end
			else
				tmp=tmp.."Fail: I had only "..verticalSumNr.." total vertical sums greater then "..conf.minSum .." of ".. v.." needed"
				fail=true
				if conf.minValue>1 then
					tmp=tmp.." with a min value of "..conf.minValue
				end
	 		end
			table.insert(ut,tmp)
		elseif i=="horizontal_verticalSum"	then
			if horizontalSumNr+verticalSumNr>=v then
				tmp=tmp.."ok:"..horizontalSumNr+verticalSumNr.." total horizontal and/or vertical sums greater then "..conf.minSum .." of ".. v.." needed"
				lok=true
				if conf.minValue>1 then
					tmp=tmp.." with a min value of "..conf.minValue
				end
			else
				tmp=tmp.."Fail: I had only "..horizontalSumNr+verticalSumNr.." total horizontal and/or vertical sums greater then "..conf.minSum .." of ".. v.." needed"
				fail=true
				if conf.minValue>1 then
					tmp=tmp.." with a min value of "..conf.minValue
				end
	 		end
			table.insert(ut,tmp)
		elseif i=="min_nr_types" then
			if found_types_nr>=v then
				tmp=tmp.."ok:"..found_types_nr.." different types found of the ".. v.." needed"
				lok=true
			else
				tmp=tmp.."Fail: only "..found_types_nr .." diffrent types found of ".. v.." needed"
				fail=true
	 		end
			table.insert(ut,tmp)
		elseif i=="required_types" then
			local ok_list={}
			local fail_list={}
			local req_types=0
			for k,t in ipairs(v) do
				req_types=req_types+1
				if	found_types[t]~= nil then
					table.insert(ok_list,t)
				else
					table.insert(fail_list,t)
				end
			end
			if	#fail_list==0 then
				tmp=tmp.."ok: All required types found "
				tmp=tmp..table.concat(ok_list,", ")
				table.insert(ut,tmp)
				lok=true
			else
				tmp=tmp.."Fail: Only "..#ok_list.." of "..req_types.." required types found"
				table.insert(ut,tmp)
				table.insert(ut,"	 Found types:"..table.concat(ok_list,", "))
				table.insert(ut,"	 Missing types:"..table.concat(fail_list,", "))
				fail=true
	 		end
		elseif i=="required_regions" then
			local ok_list={}
			local fail_list={}
			local req_types=0
			for k,t in ipairs(v) do
				req_types=req_types+1
				if	found_regions[t]~= nil then
					table.insert(ok_list,t)
				else
					table.insert(fail_list,t)
				end
			end
			if	#fail_list==0 then
				tmp=tmp.."ok: All required regions found "
				tmp=tmp..table.concat(ok_list,", ")
				table.insert(ut,tmp)
				lok=true
			else
				tmp=tmp.."Fail: Only "..#ok_list.." of "..req_types.." required regions found"
				table.insert(ut,tmp)
				table.insert(ut,"	 Found regions:"..table.concat(ok_list,", "))
				table.insert(ut,"	 Missing regions:"..table.concat(fail_list,", "))
				fail=true
	 		end
		else
			DebugPrint("\nUnknown condition :"..i.."="..v.." \n")
			table.insert(ut,tmp)
			return { ok = fail, log = 1, html =1 }
		end
	end
	if conf.minValue >1 then
		table.insert(ut,"All entries has to greater or equal to "..conf.minValue.." to be counted in lines and entries")
	end
	if (lok==true and fail==false) then
		ok=true
	end
	local slog=table.concat(ut,"\n")
	local shtml=table.concat(ut,"<br>")
    local print_types=conf.types
    if print_types==nil then
    	print_types={}
    end

	html=html..PrintDT(DT,verticalSum,horizontalSum,sum,print_types,threshold)
	local log =""

	local points = nil
	if ok and conf.pointsPer ~= nil then
		points = conf.pointsPer * loops
		if conf.skipPoints ~= nil then
			if points <= conf.skipPoints then
				points = 0
			else
				points = points - conf.skipPoints
			end
		end
		if conf.maxPoints ~= nil and points > conf.maxPoints then
			points = conf.maxPoints
		end
	end

	return{ok = ok, log = log, html = html, slog = slog, shtml = shtml, points = points }
end -- end function c_DT
-----------------------------------------------------

function c_adv_number(conf)
	function checkTest(groups,conf)
		local ok=false
		local fail=false
		local largestGroup={caches_nr=0,better=0,dtsum=0,dsum=0,tsum=0,caches_nr=0,types_nr=0,sizes_nr=0,countries_nr=0,regions_nr=0,counties_nr=0,DT_nr=0,T_nr=0,D_nr=0}
		local okGroup={}
		okGroup.caches_nr=0
		local okGroup_nr=0
		for a,g in spairs(groups,function(t,b,c) return b<c end) do
			local lok=false
			local lfail=false
			--largest group for fail print

			g.better=0
			for k,v in pairs(conf.conditions) do
				--DebugPrint("conf"..k..":"..v.."\n")
				if k=="dtsum" then
					if g.dtsum>=tonumber(v) then
						lok=true
						g.better=g.better+4
					else
						lfail=true
						if g.dtsum>largestGroup.dtsum then
							g.better=g.better+2
						end
					end
				elseif k=="dsum" then
					if g.dsum>=tonumber(v) then
						lok=true
						g.better=g.better+4
					else
						lfail=true
						if g.dsum>largestGroup.dsum then
							g.better=g.better+2
						end
					end
				elseif k=="tsum" then
					if g.tsum>=tonumber(v) then
						lok=true
						g.better=g.better+4
					else
						lfail=true
						if g.tsum>largestGroup.tsum then
							g.better=g.better+2
						end
					end
				elseif k=="limit" then
					if g.caches_nr>=tonumber(v) then
						g.better=g.better+2
						lok=true
					else
						lfail=true
						if g.caches_nr>largestGroup.caches_nr then
							g.better=g.better+1
						end
					end
				elseif k=="nrtypes" then
					if g.types_nr>=tonumber(v) then
						g.better=g.better+4
						lok=true
					else
						lfail=true
						if g.types_nr>largestGroup.types_nr then
							g.better=g.better+2
						end
					end
				elseif k=="nrsizes" then
					if g.sizes_nr>=tonumber(v) then
						g.better=g.better+4
						lok=true
					else
						lfail=true
						if g.sizes_nr>largestGroup.sizes_nr then
							g.better=g.better+2
						end
					end
				elseif k=="nrcountries" then
					if g.countries_nr>=tonumber(v) then
						g.better=g.better+4
						lok=true
					else
						lfail=true
						if g.countries_nr>largestGroup.countries_nr then
							g.better=g.better+2
						end
					end
				elseif k=="nrregions" then
					if g.regions_nr>=tonumber(v) then
						g.better=g.better+4
						lok=true
					else
						lfail=true
						if g.regions_nr>largestGroup.regions_nr then
							g.better=g.better+2
						end
					end
				elseif k=="nrcounties" then
					if g.counties_nr>=tonumber(v) then
						g.better=g.better+4
						lok=true
					else
						lfail=true
						if g.counties_nr>largestGroup.counties_nr then
							g.better=g.better+2
						end
					end
				elseif k=="nrDT" then
					if g.DT_nr>=tonumber(v) then
						g.better=g.better+4
						lok=true
					else
						lfail=true
						if g.DT_nr>largestGroup.DT_nr then
							g.better=g.better+2
						end
					end
				elseif k=="nrD" then
					if g.D_nr>=tonumber(v) then
						g.better=g.better+4
						lok=true
					else
						lfail=true
						if g.D_nr>largestGroup.D_nr then
							g.better=g.better+2
						end
					end
				elseif k=="nrT" then
					if g.T_nr>=tonumber(v) then
						g.better=g.better+4
						lok=true
					else
						lfail=true
						if g.T_nr>largestGroup.T_nr then
							g.better=g.better+2
						end
					end
				else
					PGC.print("unknown conditions:"..k..":"..v.."\n")
					return {ok=nil,html=nil,log=nil }
				end
			end
			if g.better> largestGroup.better or (g.better==largestGroup.better and g.caches_nr>largestGroup.caches_nr) then
				largestGroup=g
				--PGC.print("largestGroup",largestGroup)
			end
			if lok==true and lfail==false then
				if okGroup.caches_nr<=g.caches_nr then
					okGroup=g
				end
				ok=true
				break
			end
		end

		if fail==true then
			ok=false
		end
		if ok==true then

			return ok,okGroup
		else

			return ok,largestGroup
		end

	end
	--------
	function getGroupKey(cache, key)
		local res
		if (key == "dt") then
			res = cache['difficulty'].."/"..cache['terrain']
		elseif (key == "dtsum") then
			res = ToNumeric(cache['difficulty'])+ToNumeric(cache['terrain'])
		elseif (key == "dsum") then
			res = ToNumeric(cache['difficulty'])
		elseif (key == "tsum") then
			res = ToNumeric(cache['terrain'])
		elseif (key == "date") then
			res = string.sub(cache['visitdate'],6)
		elseif (key == "day") then
			res = cache['visitdate']
		elseif (key == "month") then
			res = string.sub(cache['visitdate'],1,7)
		elseif (key == "month any year") then
			res = string.sub(cache['visitdate'],6,7)
		elseif (key == "year") then
			res = string.sub(cache['visitdate'],1,4)
		elseif (key == "day of month") then
			res = string.sub(cache['visitdate'],9,10)
		else
			res=cache[key]
		end
		return res
	end
	--------
	function groupFinds(myFinds,period,groupby,filter)
		local caches={}
		--Group caches by key an calculate DTsum and #types for that group
		for _,c in ipairs(myFinds) do
			local groupKey=""
			if period ~= nil then
				groupKey = groupKey..getGroupKey(c, period)
			end
			if groupby ~= nil then
				groupKey =groupKey.. getGroupKey(c,groupby)
			end
			if key=="" then
				key="<all>"
			end
			if caches[groupKey]==nil then
				caches[groupKey]={}
				caches[groupKey].key=groupKey
				caches[groupKey].caches={}
				caches[groupKey].caches_nr=0
				caches[groupKey].dtsum=0
				caches[groupKey].dsum=0
				caches[groupKey].tsum=0
				caches[groupKey].types={}
				caches[groupKey].types_nr=0
				caches[groupKey].DT={}
				caches[groupKey].DT_nr=0
				caches[groupKey].D={}
				caches[groupKey].D_nr=0
				caches[groupKey].T={}
				caches[groupKey].T_nr=0
				caches[groupKey].sizes={}
				caches[groupKey].sizes_nr=0
				caches[groupKey].countries={}
				caches[groupKey].countries_nr=0
				caches[groupKey].regions={}
				caches[groupKey].regions_nr=0
				caches[groupKey].counties={}
				caches[groupKey].counties_nr=0
				caches[groupKey].filter=filter
			end
			table.insert(caches[groupKey].caches,c)
			caches[groupKey].caches_nr=caches[groupKey].caches_nr+1
			local dtsum=tonumber(c['difficulty'])+tonumber(c['terrain'])
			c['dtsum']=dtsum
			caches[groupKey].dtsum=caches[groupKey].dtsum+dtsum
			local dsum=tonumber(c['difficulty'])
			c['dsum']=dsum
			caches[groupKey].dsum=caches[groupKey].dsum+dsum
			local tsum=tonumber(c['terrain'])
			c['tsum']=tsum
			caches[groupKey].tsum=caches[groupKey].tsum+tsum
			if caches[groupKey].types[c.type]== nil then
				caches[groupKey].types[c.type]=c
				caches[groupKey].types_nr=caches[groupKey].types_nr+1
			end
			if caches[groupKey].sizes[c.size]== nil then
				caches[groupKey].sizes[c.size]=c
				caches[groupKey].sizes_nr=caches[groupKey].sizes_nr+1
			end
			if caches[groupKey].countries[c.country]== nil then
				caches[groupKey].countries[c.country]=c
				caches[groupKey].countries_nr=caches[groupKey].countries_nr+1
			end
			if caches[groupKey].regions[c.region]== nil and c.region ~= nil then
				caches[groupKey].regions[c.region]=c
				caches[groupKey].regions_nr=caches[groupKey].regions_nr+1
			end
			if caches[groupKey].counties[c.county]== nil and c.county ~= nil then
				caches[groupKey].counties[c.county]=c
				caches[groupKey].counties_nr=caches[groupKey].counties_nr+1
			end
			local DT=c['difficulty'].."/"..c['terrain']
			c.DT=DT
			if caches[groupKey].DT[DT]== nil then
				caches[groupKey].DT[DT]=c
				caches[groupKey].DT_nr=caches[groupKey].DT_nr+1
			end
			if caches[groupKey].D[c.difficulty]== nil then
				caches[groupKey].D[c.difficulty]=c
				caches[groupKey].D_nr=caches[groupKey].D_nr+1
			end
			if caches[groupKey].T[c.terrain]== nil then
				caches[groupKey].T[c.terrain]=c
				caches[groupKey].T_nr=caches[groupKey].T_nr+1
			end
		end
		return caches
	end
	----------
	function createLog1(okCaches,ok,conf)
		log={}
		html={}
		slog={}
		shtml={}

		if conf.conditions ~= nil then

			local outputfields={}
			--PGC.print(okCaches.filter)
			table.insert(outputfields,'gccode')
			table.insert(outputfields,'visitdate')
			for k,v in pairs(conf.conditions) do
				if k=="dtsum" then
					table.insert(outputfields,'dtsum')
				elseif k=="dsum" then
					table.insert(outputfields,'dsum')
				elseif k=="tsum" then
					table.insert(outputfields,'tsum')
				elseif k=="nrtypes" then
					table.insert(outputfields,'type')
				elseif k=="nrsizes" then
					table.insert(outputfields,'size')
				elseif k=="nrDT" then
					table.insert(outputfields,'DT')
				elseif k=="nrD" then
					table.insert(outputfields,'difficulty')
				elseif k=="nrT" then
					table.insert(outputfields,'terrain')
				end
			end
			table.insert(outputfields,'cache_name')
			if conf.period ~= nil then
				local line=""
			if okCaches.key ~= nil then
				if conf.period=="date" then
					line="On (month,day)"..okCaches.key.." Any year"
				elseif conf.period=="day" then
					line="On "..okCaches.key
				elseif conf.period=="month" then
					line="On (year,month)"..okCaches.key
				elseif conf.period=="month any year" then
					line="On "..month[tonumber(okCaches.key)].." any year"
				elseif conf.period=="year" then
					line="On (year)"..okCaches.key
				elseif conf.period=="day of month" then
					line="On the "..okCaches.key.." day of any month"
				end
				table.insert(shtml,line..'<br>')
				table.insert(slog,line)
			  end
			end
			for k,v in pairs(conf.conditions) do
				 DebugPrint("conf"..k..":"..v.."\n")
				if  k=="dtsum" then
					local line=""
					if v <=okCaches.dtsum then
						line="I made it with a DTsum of "..okCaches.dtsum.." and needed only "..v.." "..PrintFilter(conf.filter)
					else
						line="I <b>did not make it</b> I had DTsum of only "..okCaches.dtsum.." and I needed "..v.." "..PrintFilter(conf.filter)
					end
					table.insert(shtml,line..'<br>')
					table.insert(slog,line)
				elseif  k=="dsum" then
					local line=""
					if v <=okCaches.dsum then
						line="I made it with a Dsum of "..okCaches.dsum.." and needed only "..v.." "..PrintFilter(conf.filter)
					else
						line="I <b>did not make it</b> I had Dsum of only "..okCaches.dsum.." and I needed "..v.." "..PrintFilter(conf.filter)
					end
					table.insert(shtml,line..'<br>')
					table.insert(slog,line)
				elseif  k=="tsum" then
					local line=""
					if v <=okCaches.tsum then
						line="I made it with a Tsum of "..okCaches.tsum.." and needed only "..v.." "..PrintFilter(conf.filter)
					else
						line="I <b>did not make it</b> I had Tsum of only "..okCaches.tsum.." and I needed "..v.." "..PrintFilter(conf.filter)
					end
					table.insert(shtml,line..'<br>')
					table.insert(slog,line)
				elseif  k=="limit" then
					local line=""
					if v <=okCaches.caches_nr then
						line="I made it with "..okCaches.caches_nr.." finds and needed only "..v.." "..PrintFilter(conf.filter)
					else
						line="I <b>did not make it</b> I had only "..okCaches.caches_nr.." finds and  needed "..v.." "..PrintFilter(conf.filter)
					end

					table.insert(shtml,line..'<br>')
					table.insert(slog,line)
				elseif k=="nrsizes" then
					conf.printSizes=true
					local line=""
					if v <=okCaches.sizes_nr then
						line="I made it with "..okCaches.sizes_nr.." different sizes and needed only "..v.." "..PrintFilter(conf.filter)
					else
						line="I <b>did not make it</b> I had only "..okCaches.sizes_nr.." different types and I needed "..v.." "..PrintFilter(conf.filter)
					end
					table.insert(shtml,line..'<br>')
					table.insert(slog,line)
				elseif k=="nrtypes" then
					conf.printTypes= true
					local line=""
					--PGC.print("v:",v,"\n")
					if v <=okCaches.types_nr then
						line="I made it with "..okCaches.types_nr.." different types and needed only "..v.." "..PrintFilter(conf.filter)
					else
						line="I <b>did not make it</b> I had only "..okCaches.types_nr.." different types and I needed "..v.." "..PrintFilter(conf.filter)
					end
					table.insert(shtml,line..'<br>')
					table.insert(slog,line)
				elseif k=="nrcountries" then
					conf.printCountries= true
					local line=""
					--PGC.print("v:",v,"\n")
					if v <=okCaches.countries_nr then
						line="I made it with "..okCaches.countries_nr.." different countries and needed only "..v.." "..PrintFilter(conf.filter)
					else
						line="I <b>did not make it</b> I had only "..okCaches.countries_nr.." different countries and I needed "..v.." "..PrintFilter(conf.filter)
					end
					table.insert(shtml,line..'<br>')
					table.insert(slog,line)
				elseif k=="nrregions" then
					conf.printRegions= true
					local line=""
					--PGC.print("v:",v,"\n")
					if v <=okCaches.regions_nr then
						line="I made it with "..okCaches.regions_nr.." different regions and needed only "..v.." "..PrintFilter(conf.filter)
					else
						line="I <b>did not make it</b> I had only "..okCaches.regions_nr.." different regions and I needed "..v.." "..PrintFilter(conf.filter)
					end
					table.insert(shtml,line..'<br>')
					table.insert(slog,line)
				elseif k=="nrcounties" then
					conf.printCounties= true
					local line=""
					--PGC.print("v:",v,"\n")
					if v <=okCaches.counties_nr then
						line="I made it with "..okCaches.counties_nr.." different counties and needed only "..v.." "..PrintFilter(conf.filter)
					else
						line="I <b>did not make it</b> I had only "..okCaches.counties_nr.." different counties and I needed "..v.." "..PrintFilter(conf.filter)
					end
					table.insert(shtml,line..'<br>')
					table.insert(slog,line)
				elseif k=="nrDT" then
					conf.printDT= true
					local line=""
					--PGC.print("v:",v,"\n")
					if v <=okCaches.DT_nr then
						line="I made it with "..okCaches.DT_nr.." different DT and needed only "..v.." "..PrintFilter(conf.filter)
					else
						line="I <b>did not make it</b> I had only "..okCaches.DT_nr.." different DT and I needed "..v.." "..PrintFilter(conf.filter)
					end
					table.insert(shtml,line..'<br>')
					table.insert(slog,line)
				elseif k=="nrD" then
					conf.printD= true
					local line=""
					--PGC.print("v:",v,"\n")
					if v <=okCaches.D_nr then
						line="I made it with "..okCaches.D_nr.." different difficulty and needed only "..v.." "..PrintFilter(conf.filter)
					else
						line="I <b>did not make it</b> I had only "..okCaches.D_nr.." different difficulty and I needed "..v.." "..PrintFilter(conf.filter)
					end
					table.insert(shtml,line..'<br>')
					table.insert(slog,line)
				elseif k=="nrT" then
					conf.printT= true
					local line=""
					--PGC.print("v:",v,"\n")
					if v <=okCaches.T_nr then
						line="I made it with "..okCaches.T_nr.." different terrain and needed only "..v.." "..PrintFilter(conf.filter)
					else
						line="I <b>did not make it</b> I had only "..okCaches.T_nr.." different terrain and I needed "..v.." "..PrintFilter(conf.filter)
					end
					table.insert(shtml,line..'<br>')
					table.insert(slog,line)
				end
			end
			if conf.printTypes== true then
				local line=""
				line=line.."Found Types: "
				local count=0
				if okCaches.types~= nil  then
				for i,v in pairs(okCaches.types) do
					count=count+1
					if count>1 then
						line=line..", "
					end
					line=line..i
				end
				table.insert(html,line..'<br>')
				table.insert(log,line)
				PrintFields(okCaches.types,outputfields,log,html,conf)
				end
			end
			if conf.printSizes== true then
				local line=""
				line=line.."Found Sizes:"
				local count=0
				if okCaches.sizes~= nil then
				for i,v in pairs(okCaches.sizes) do
					count=count+1
					if count>1 then
						line=line..", "
					end
					line=line..i
				end
				table.insert(html,line..'<br>')
				table.insert(log,line)
				PrintFields(okCaches.sizes,outputfields,log,html,conf)
				end
			end
			if conf.printRegions== true then
				local line=""
				line=line.."Found Regions:"
				local count=0
				if okCaches.regions~= nil then
				for i,v in pairs(okCaches.regions) do
					count=count+1
					if count>1 then
						line=line..", "
					end
					line=line..i
				end
				table.insert(html,line..'<br>')
				table.insert(log,line)
				PrintFields(okCaches.regions,outputfields,log,html,conf)
				end
			end
			if conf.printCounties== true then
				local line=""
				line=line.."Found Counties:"
				local count=0
				if okCaches.counties~= nil then
				for i,v in pairs(okCaches.counties) do
					count=count+1
					if count>1 then
						line=line..", "
					end
					line=line..i
				end
				table.insert(html,line..'<br>')
				table.insert(log,line)
				PrintFields(okCaches.counties,outputfields,log,html,conf)
				end
			end
			if conf.printDT== true then
				local line=""
				line=line.."Found DT:"
				local count=0
				if okCaches.DT~= nil then
				for i,v in spairs(okCaches.DT,function(t,a,b) return a>b end) do
					count=count+1
					if count>1 then
						line=line..", "
					end
					line=line..i
				end
				table.insert(html,line..'<br>')
				table.insert(log,line)
				PrintFields(okCaches.DT,outputfields,log,html,conf)
				end
			end
			if conf.printD== true then
				local line=""
				line=line.."Found difficulty:"
				local count=0
				if okCaches.D~= nil then
				for i,v in spairs(okCaches.D,function(t,a,b) return a>b end) do
					count=count+1
					if count>1 then
						line=line..", "
					end
					line=line..i
				end
				table.insert(html,line..'<br>')
				table.insert(log,line)
				PrintFields(okCaches.D,outputfields,log,html,conf)
				end
			end
			if conf.printT== true then
				local line=""
				line=line.."Found terrain:"
				local count=0
				if okCaches.T~= nil then
				for i,v in spairs(okCaches.T,function(t,a,b) return a>b end) do
					count=count+1
					if count>1 then
						line=line..", "
					end
					line=line..i
				end
				table.insert(html,line..'<br>')
				table.insert(log,line)
				PrintFields(okCaches.T,outputfields,log,html,conf)
				end
			end


			if conf.conditions.dtsum ~= nil or conf.conditions.dsum ~= nil or conf.conditions.tsum ~= nil or conf.conditions.limit ~= nil and conf.brief~= true then
				PrintFieldsLimitDT(okCaches,outputfields,log,html,conf)
			end
		end
		return log,html,slog,shtml
	end
	--------
	function findMaxWidth(logtmp)
		local res={}
		for i,v in ipairs(logtmp[1]) do
			res[i]=0
		end
		for i,v in ipairs(logtmp) do
			for j,f in ipairs(v) do
				res[j]=math.max(res[j],string.len(f))
			end
		end
		return res
	end
	--------
	function PrintFieldsLimitDT(okCaches,outputfields,log,html,conf)
		local log={}
		local html={}
		if conf.brief ~= true then
			--generate html, and log temp
			local logtmp={}
			local done=false
			table.insert(html,'<table border=1><tr><th>')
			table.insert(html,table.concat(outputfields,'</th><th>'))
			table.insert(html,'</th><tr>')
			table.insert(logtmp,outputfields)
			local loopDT=0
			local loopD=0
			local loopT=0
			local loopNR=0
			if okCaches.caches~= nil then
			for i,c in ipairs(okCaches.caches) do
				local l_done=false
				local l_notdone=false
				if done==false or conf.full==true then
					local line={}
					for j,f in ipairs(outputfields) do
						table.insert(line,c[f])
					end
					if #line>0 then
						table.insert(html,'<tr><td>')
						table.insert(html,table.concat(line,'</td><td>'))
						table.insert(html,'</td><tr>')
						table.insert(logtmp,line)
					end
				end
				if conf.conditions.dtsum ~= nil then
					loopDT=loopDT+c.dtsum
					if loopDT>=conf.conditions.dtsum then
						l_done=true
					else
						l_notdone=true
					end
				end
				if conf.conditions.dsum ~= nil then
					loopD=loopD+c.dsum
					if loopD>=conf.conditions.dsum then
						l_done=true
					else
						l_notdone=true
					end
				end
				if conf.conditions.tsum ~= nil then
					loopT=loopT+c.tsum
					if loopT>=conf.conditions.tsum then
						l_done=true
					else
						l_notdone=true
					end
				end
				if conf.conditions.limit ~= nil then
					loopNR=loopNR+1
					if loopNR>=conf.conditions.limit then
						l_done=true
					else
						l_notdone=true
					end
				end
				if l_done==true and l_notdone==false then
					done=true
				end
			end
			end
			table.insert(html,'</table>')
			local width=findMaxWidth(logtmp)
			table.insert(log,'[code]')
			for i,v in pairs(logtmp) do
				local line={}
				for j,f in pairs(v) do
					if j ~= table.maxn(v) then
						table.insert(line,string.format("%-"..width[j].."s",f))
					else
						table.insert(line,f)
					end
				end
				table.insert(log,table.concat(line," "))
			end
		end
		table.insert(html,'<br>')
		table.insert(log,"")
		return log,html
	end
	--------
	function PrintFields(Caches,outputfields,log,html,conf)
		--generate html, and log temp
		local logtmp={}
		local done=false
		local l_html={}
		--PGC.print(outputfields)
		table.insert(l_html,'<table><tr><th>')
		table.insert(l_html,table.concat(outputfields,'</th><th>'))
		table.insert(html,'</th><tr>')
		table.insert(logtmp,outputfields)
		for i,c in pairs(Caches) do
			local line={}
			for j,f in ipairs(outputfields) do
				table.insert(line,c[f])
			end
			table.insert(l_html,'<tr><td>')
			table.insert(l_html,table.concat(line,'</td><td>'))
			table.insert(l_html,'</td><tr>\n')
			table.insert(logtmp,line)


		end
		table.insert(html,'</table>')
		local width=findMaxWidth(logtmp)
		table.insert(log,'[code]')
		for i,v in pairs(logtmp) do
			local line={}
			for j,f in pairs(v) do
				if j ~= table.maxn(v) then
					table.insert(line,string.format("%-"..width[j].."s",f))
				else
					table.insert(line,f)
				end
			end
			table.insert(log,table.concat(line," "))
		end

		table.insert(html,table.concat(l_html))
		table.insert(log,"")
	end
	--------
	local slog=""
	local shtml=""
	local options ={"conditions","brief","period","debug","pointsPer"}
		if extraInConfig(conf,options)==true then
			return{ok=nil,log=nil,html=nil}
		end
	local filter=FilterFromConfig(conf)
	conf.filter=filter

	local period=conf.period
	local groupby=conf.groupby
	local fields={'gccode', 'cache_name','size', 'visitdate', 'country','region','county','difficulty','terrain','log_id','type'}
	local log = {}
	local html ={}
	local ok = false
	local fail=false
	local myFinds=GetCombinedFinds(profileId,{fields = fields,  order = 'OLDESTFIRST',  filter = filter })
	local groups =groupFinds(myFinds,period,groupby,filter)
	local okCaches={}
	ok,okCaches=checkTest(groups,conf)
	if ok==false then
		fail=true
	end


	log,html,slog,shtml=createLog1(okCaches,ok,conf)
	okCaches.caches=nil
	--PGC.print(okCaches)
	if fail==true then
	  ok=false
	end



	log = table.concat(log, "\n")
	html = table.concat(html, "<br>")
	slog = table.concat(slog, "\n")
	shtml = table.concat(shtml, "<br>")
	if conf.dt=="sum" then
	  ok=nil
	  html='<h3> "dt":"sum" is a old config and shall be changed to "dtsum":required dt sum limit is no longer used for dtsum<br>please contact script tagger</h3>'
	end
	if conf.brief==true then
		log=""
		html=""
	end

	return{ok = ok, log = log, html = html, slog = slog, shtml = shtml }
end -- end function c_adv_numbers
-----------------------------------------------------

function c_calendar(conf)
	local debug=conf.debug or false
	local status = { }
	local notypes = { }
	local dom = { }

	if conf.type~= nil then
	  if type(conf.type)=="string" and conf.type~="" then
		  if conf.types==nil then
			  conf.types={}
		  end
		  table.insert(conf.types,conf.type)
		elseif type(conf.type)=="table" then
			if conf.types==nil then
			  conf.types={}
		  end
			for _,v in pairs (conf.type) do
			conf.types[v]=v
		  end
	  end
	end
	conf.type=nil

	local filter=  FilterFromConfig(conf)
	local ExcludedTypes={}
	--PGC.print("type(conf.ExcludedTypes)",type(conf.ExcludedTypes),"\n")
	if type(conf.ExcludedTypes)== "string" then
		ExcludedTypes[conf.ExcludedTypes]=conf.ExcludedTypes
	elseif type(conf.ExcludedTypes)== "table"  then
	  for _,v in pairs (conf.ExcludedTypes) do
		  ExcludedTypes[v]=v
		end
	end
	--PGC.print("conf.types",conf.types,"\n")
	--PGC.print("ExcludedTypes",ExcludedTypes,"\n")


	if conf.limit == nil then
		conf.limit = 1
	else
		conf.limit = tonumber(conf.limit)
	end
	if conf.needed == nil then
		conf.needed = 366
	else
		conf.needed = tonumber(conf.needed)
	end
	if conf.leapday == "allow" then
		conf.leapday = "false"
	else
		conf.leapday = "true"
	end
	local icontype="checkbox"

	if filter.types~= nil and #filter.types== 1 and #ExcludedTypes == 0 then
		icontype=filter.types[1]
	end

	if conf.placed == nil then
		conf.placed = "false"
	else
    if conf.placed ~= "birthday" then
		conf.placed = "true"
	end
  end
	if conf.nooftypes ~= nil then
		conf.limit = conf.nooftypes
	end
	local includeLabCaches = false
	if conf.includeLabCaches ~= nil then includeLabCaches = conf.includeLabCaches end
	
	if debug then
	  PGC.print("type: ", conf.type, "\n")
	  PGC.print("Limit: ", conf.limit, "\n")
	  PGC.print("Needed: ", conf.needed, "\n")
	  PGC.print("Leapday: ", conf.leapday, "\n")
	  PGC.print("Invert: ", conf.invert, "\n")
	  PGC.print("Icontype: ", icontype, "\n")
	  PGC.print("Placed: ", conf.placed, "\n")
	  PGC.print("No of types: ", conf.nooftypes, "\n")
	end


	myFinds = GetCombinedFinds( profileId, { fields = { 'gccode', 'type', 'visitdate', 'hidden' },order = 'OLDESTFIRST',filter=filter,includeLabCaches=includeLabCaches } )

	function makekey(month, day)
		return string.format("%02d-%02d",month, day)
	end


	local daysinmonth = { 31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 }

  local daysdone = 0
	for i, f in ipairs(myFinds) do
		-- Found date or placed date?
		if conf.placed == "true" then
			if f['hidden'] ~= nil then
				day = string.sub(f['hidden'], 6)
			else
				day = "13-01"	-- Dummy date because lab caches don't have hidden date.
			end
		else
      if conf.placed == "birthday" then
        if string.sub(f['visitdate'], 6) == string.sub(f['hidden'], 6)
          and string.len(f['visitdate']) == 10
          and string.len(f['hidden']) == 10 then
          day = string.sub(f['hidden'], 6)
        else
          day = "13-01"    -- Dummy date that will be ignored later.
        end
      else
			day = string.sub(f['visitdate'], 6)
		end
    end

		-- Keep track of number of types logged per day.
		if notypes[day] == nil then
			notypes[day] = { }
		end
		if notypes[day][f['type']] == nil then
			notypes[day][f['type']] = { }
			notypes[day][f['type']] = f['gccode']
		end

		-- Regular checking of filled calendar.
		   if  ExcludedTypes[f.type]==nil then
				-- Cache valid for challenge.
				if status[day] == nil then
					status[day] = 1
        daysdone = daysdone + 1
        -- PGC.print what day the challenge was completed.
        if daysdone == 366 then
          PGC.print("Completed date: " .. f['visitdate'] .. "\n")
        end
				else
					status[day] = status[day] + 1
				end
			end

	end
	if debug then
	  PGC.print("No types per date")
	  PGC.print(notypes)
	end
	-- What is done?
	local numdone = 0
	local monthsdone = {}
	for month = 1, 12 do
		local prevnumdone = numdone
		for day = 1, daysinmonth[month] do
			if conf.nooftypes == nil then
				local key = makekey(month, day)
				if status[key] ~= nil and status[key] >= conf.limit then
					numdone = numdone + 1
				end
			else
				local key = makekey(month, day)
				local num = 0
				if notypes[key] ~= nil then
					for type, gccode in pairs(notypes[key]) do
						num = num + 1
					end
					if num >= conf.nooftypes then
						numdone = numdone + 1
					end
				end
				status[key] = num
			end
		end
		if (numdone - prevnumdone) == daysinmonth[month] or
			(conf.leapday == "false" and month == 2 and (numdone - prevnumdone) == 28 and
				(status[makekey(2,29)] == nil or (status[makekey(2,29)] ~= nil and status[makekey(2,29)] < conf.limit))) then
			table.insert(monthsdone,month)
		end
	end
	if debug then
	  PGC.print("Completed " .. numdone .. " days of " .. conf.needed .. " needed.\n")
	end
	local ok = false
	local log = ""
	local dates = ""
	local html = ""
	local slog=""
	local shtml=""
	local missing = { }
	local statustable = { }

	-- Check if completed.
	if conf.monthsneeded ~= nil then
		if #monthsdone >= conf.monthsneeded then
			ok = true
		end

	  slog = #monthsdone .. " months of " .. conf.monthsneeded .. " completed. "
	  if conf.leapday == "false" then
		slog = slog .. "This challenge allows leap day to be skipped. "
	  end
	else
		if numdone >= conf.needed
		  or (numdone == conf.needed - 1
			and conf.leapday == "false"
			and (status[makekey(2,29)] == nil or (status[makekey(2,29)] ~= nil and status[makekey(2,29)] < conf.limit))
			) then
			ok = true
		end

	  slog = numdone .. " dates of " .. conf.needed .. " completed. "
	  if conf.leapday == "false" then
		slog = slog .. "This challenge allows leap day to be skipped. "
	  end
	end


	-- Build log entry.
  local missing = { }
  local statustable = { }

	-- Show what is done and what is missing.
	if ok == false then
		if conf.nooftypes == nil then
			table.insert(statustable, '<br>Numbers in the calendar in '
				.. '<span style="color:red">red</span> are the number of '
				.. 'finds needed to meet the requirement that day.<br>')
		else
			table.insert(statustable, '<br>Completed days have a green checkmark. '
				.. 'Non-completed days show the icons for the cache types you '
				.. 'have found on that date so far.<br>')
		end
	end
	table.insert(statustable, "<table border=\"1\" class=\"align-center\"><tr><td></td>")
	table.insert(statustable, "<tr>")
	table.insert(statustable, "<td></td>")
	for day = 1, 31 do
		table.insert(statustable, "<td>" .. day .. "</td>")
	end
	table.insert(statustable, "</tr>")
	for month = 1, 12 do
		table.insert(statustable, "<tr>")
		table.insert(statustable, "<td>" .. month .. "</td>")
		for day = 1, 31 do
			local key = makekey(month, day)
			if day <= daysinmonth[month] then
				if conf.nooftypes == nil then
					if status[key] == nil or status[key] < conf.limit then
						local diff = status[key] or 0
						diff = conf.limit - diff
						if ok == false then
              if month == 2 and day == 29 and conf.leapday == "false" then
                table.insert(statustable, '<td><span style="color:red">('
                                         .. diff .. ")</span></td>")
              else
                table.insert(statustable, '<td><span style="color:red">'
                                         .. diff .. "</span></td>")
              end
						else
							table.insert(statustable, '<td></td>')
						end
						table.insert(missing, key)
					else
						table.insert(statustable, "<td><img src=\"" .. Type_Icons[icontype] .. "\"></td>")
					end
				else
					if status[key] >= conf.limit then
						table.insert(statustable, "<td><img src=\"" .. Type_Icons['checkbox'] .. "\"></td>")
					else
						if status[key] == 0 then
							table.insert(statustable, "<td></td>")
						else
							local str = "<td>"
							for type, gccode in pairs(notypes[key]) do
								str = str .. "<img src=\"" .. Type_Icons[type] .. "\"> "
							end
							str = str .. "</td>"
							table.insert(statustable, str)
						end
					end
				end
			else
				table.insert(statustable, "<td>X</td>")
			end
		end
		table.insert(statustable, "</tr>")
	end
	table.insert(statustable, "</table>")

	-- PGC.print list of missing dates to debug, for those that want a text list.
	PGC.print(table.concat(missing, ", "))

	-- Report results.
	 slog=slog..PrintFilter(filter)
	shtml = slog
	html=table.concat(statustable, "\n")

	local points = nil
	if ok and conf.pointsPer ~= nil then
		points = conf.pointsPer * numdone
		if conf.skipPoints ~= nil then
			if points <= conf.skipPoints then
				points = 0
			else
				points = points - conf.skipPoints
			end
		end
		if conf.maxPoints ~= nil and points > conf.maxPoints then
			points = conf.maxPoints
		end
	end

	return { ok = ok, log = log, html = html,slog=slog,shtml=shtml, points = points }
end -- end function c_calendar
-----------------------------------------------------
function c_ok(conf)
  local tmp="OK:"
  if conf.txt~= nil then
    tmp=tmp..conf.txt
  end
  return {ok=true,slog=tmp,log=tmp,shtml=tmp,html=tmp}
end
-----------------------------------------------------
function c_fail(conf)
  local tmp="FAIL:"
  if conf.txt~= nil then
    tmp=tmp..conf.txt
  end
  return {ok=false,slog=tmp,log=tmp,shtml=tmp,html=tmp}
end
-----------------------------------------------------
function c_info(conf)
  local tmp=conf.txt
  return {ok="info",slog=tmp,log=tmp,shtml=tmp,html=tmp}
end
-----------------------------------------------------
function c_maybe(conf)
  local tmp="MAYBE:"
  if conf.txt~= nil then
    tmp=tmp..conf.txt
  end
  return {ok="maybe",slog=tmp,log=tmp,shtml=tmp,html=tmp}
end
-----------------------------------------------------------
function c_date(conf)
	function DateOffset(v)

    	local daysinmonth = { 31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 }
    	local monthoff={0,31,60,91,121,152,182,213,244,274,305,335}
    	local month=tonumber(string.sub(v,1,2))
    	local day=tonumber(string.sub(v,4,5))

    	local off=monthoff[month]+day
    	return off
    end
	-----
	local filter=FilterFromConfig(conf)
	if conf.field == nil then
		conf.field = 'visitdate'
	end
	local fields = {'gccode', 'cache_name',conf.field}
	local includeLabCaches = false
	if conf.includeLabCaches ~= nil then includeLabCaches = conf.includeLabCaches end
	--local finds = GetCombinedFinds(profileId, { fields = fields, order = 'OLDESTFIRST', filter = filter })
	local finds = GetCombinedFinds(profileId, { fields = fields, order = 'OLDESTFIRST', filter = filter, includeLabCaches = includeLabCaches })
  	local dateStart
  	local dateStop
  	local int=""
	local isoDate = Date.Format("yyyy-mm-dd")

	local weekdays = {'Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday'}
	local special = {
		["Good Friday"] = {["2000-04-21"]=1, ["2001-04-13"]=1, ["2002-03-29"]=1, ["2003-04-18"]=1, ["2004-04-09"]=1, ["2005-03-25"]=1, ["2006-04-14"]=1, ["2007-04-06"]=1, ["2008-03-21"]=1, ["2009-04-10"]=1, ["2010-04-02"]=1, ["2011-04-22"]=1, ["2012-04-06"]=1, ["2013-03-29"]=1, ["2014-04-18"]=1, ["2015-04-03"]=1, ["2016-03-25"]=1, ["2017-04-14"]=1, ["2018-03-30"]=1, ["2019-04-19"]=1, ["2020-04-10"]=1, ["2021-04-02"]=1, ["2022-04-15"]=1, ["2023-04-07"]=1, ["2024-03-29"]=1, ["2025-04-18"]=1, ["2026-04-03"]=1, ["2027-03-26"]=1, ["2028-04-14"]=1, ["2029-03-30"]=1, ["2030-04-19"]=1, ["2031-04-11"]=1, ["2032-03-26"]=1, ["2033-04-15"]=1, ["2034-04-07"]=1, ["2035-03-23"]=1, ["2036-04-11"]=1, ["2037-04-03"]=1, ["2038-04-23"]=1, ["2039-04-08"]=1, ["2040-03-30"]=1, ["2041-04-19"]=1, ["2042-04-04"]=1, ["2043-03-27"]=1, ["2044-04-15"]=1, ["2045-04-07"]=1, ["2046-03-23"]=1, ["2047-04-12"]=1, ["2048-04-03"]=1, ["2049-04-16"]=1, ["2050-04-08"]=1, ["2051-03-31"]=1, ["2052-04-19"]=1, ["2053-04-04"]=1, ["2054-03-27"]=1, ["2055-04-16"]=1, ["2056-03-31"]=1, ["2057-04-20"]=1, ["2058-04-12"]=1, ["2059-03-28"]=1, ["2060-04-16"]=1, ["2061-04-08"]=1, ["2062-03-24"]=1, ["2063-04-13"]=1, ["2064-04-04"]=1, ["2065-03-27"]=1, ["2066-04-09"]=1, ["2067-04-01"]=1, ["2068-04-20"]=1, ["2069-04-12"]=1, ["2070-03-28"]=1, ["2071-04-17"]=1, ["2072-04-08"]=1, ["2073-03-24"]=1, ["2074-04-13"]=1, ["2075-04-05"]=1, ["2076-04-17"]=1, ["2077-04-09"]=1, ["2078-04-01"]=1, ["2079-04-21"]=1, ["2080-04-05"]=1, ["2081-03-28"]=1, ["2082-04-17"]=1, ["2083-04-02"]=1, ["2084-03-24"]=1, ["2085-04-13"]=1, ["2086-03-29"]=1, ["2087-04-18"]=1, ["2088-04-09"]=1, ["2089-04-01"]=1, ["2090-04-14"]=1, ["2091-04-06"]=1, ["2092-03-28"]=1, ["2093-04-10"]=1, ["2094-04-02"]=1, ["2095-04-22"]=1, ["2096-04-13"]=1, ["2097-03-29"]=1, ["2098-04-18"]=1, ["2099-04-10"]=1},
		["Easter Saturday"] = {["2000-04-22"]=1, ["2001-04-14"]=1, ["2002-03-30"]=1, ["2003-04-19"]=1, ["2004-04-10"]=1, ["2005-03-26"]=1, ["2006-04-15"]=1, ["2007-04-07"]=1, ["2008-03-22"]=1, ["2009-04-11"]=1, ["2010-04-03"]=1, ["2011-04-23"]=1, ["2012-04-07"]=1, ["2013-03-30"]=1, ["2014-04-19"]=1, ["2015-04-04"]=1, ["2016-03-26"]=1, ["2017-04-15"]=1, ["2018-03-31"]=1, ["2019-04-20"]=1, ["2020-04-11"]=1, ["2021-04-03"]=1, ["2022-04-16"]=1, ["2023-04-08"]=1, ["2024-03-30"]=1, ["2025-04-19"]=1, ["2026-04-04"]=1, ["2027-03-27"]=1, ["2028-04-15"]=1, ["2029-03-31"]=1, ["2030-04-20"]=1, ["2031-04-12"]=1, ["2032-03-27"]=1, ["2033-04-16"]=1, ["2034-04-08"]=1, ["2035-03-24"]=1, ["2036-04-12"]=1, ["2037-04-04"]=1, ["2038-04-24"]=1, ["2039-04-09"]=1, ["2040-03-31"]=1, ["2041-04-20"]=1, ["2042-04-05"]=1, ["2043-03-28"]=1, ["2044-04-16"]=1, ["2045-04-08"]=1, ["2046-03-24"]=1, ["2047-04-13"]=1, ["2048-04-04"]=1, ["2049-04-17"]=1, ["2050-04-09"]=1, ["2051-04-01"]=1, ["2052-04-20"]=1, ["2053-04-05"]=1, ["2054-03-28"]=1, ["2055-04-17"]=1, ["2056-04-01"]=1, ["2057-04-21"]=1, ["2058-04-13"]=1, ["2059-03-29"]=1, ["2060-04-17"]=1, ["2061-04-09"]=1, ["2062-03-25"]=1, ["2063-04-14"]=1, ["2064-04-05"]=1, ["2065-03-28"]=1, ["2066-04-10"]=1, ["2067-04-02"]=1, ["2068-04-21"]=1, ["2069-04-13"]=1, ["2070-03-29"]=1, ["2071-04-18"]=1, ["2072-04-09"]=1, ["2073-03-25"]=1, ["2074-04-14"]=1, ["2075-04-06"]=1, ["2076-04-18"]=1, ["2077-04-10"]=1, ["2078-04-02"]=1, ["2079-04-22"]=1, ["2080-04-06"]=1, ["2081-03-29"]=1, ["2082-04-18"]=1, ["2083-04-03"]=1, ["2084-03-25"]=1, ["2085-04-14"]=1, ["2086-03-30"]=1, ["2087-04-19"]=1, ["2088-04-10"]=1, ["2089-04-02"]=1, ["2090-04-15"]=1, ["2091-04-07"]=1, ["2092-03-29"]=1, ["2093-04-11"]=1, ["2094-04-03"]=1, ["2095-04-23"]=1, ["2096-04-14"]=1, ["2097-03-30"]=1, ["2098-04-19"]=1, ["2099-04-11"]=1},
		["Easter"] = {["2000-04-23"]=1, ["2001-04-15"]=1, ["2002-03-31"]=1, ["2003-04-20"]=1, ["2004-04-11"]=1, ["2005-03-27"]=1, ["2006-04-16"]=1, ["2007-04-08"]=1, ["2008-03-23"]=1, ["2009-04-12"]=1, ["2010-04-04"]=1, ["2011-04-24"]=1, ["2012-04-08"]=1, ["2013-03-31"]=1, ["2014-04-20"]=1, ["2015-04-05"]=1, ["2016-03-27"]=1, ["2017-04-16"]=1, ["2018-04-01"]=1, ["2019-04-21"]=1, ["2020-04-12"]=1, ["2021-04-04"]=1, ["2022-04-17"]=1, ["2023-04-09"]=1, ["2024-03-31"]=1, ["2025-04-20"]=1, ["2026-04-05"]=1, ["2027-03-28"]=1, ["2028-04-16"]=1, ["2029-04-01"]=1, ["2030-04-21"]=1, ["2031-04-13"]=1, ["2032-03-28"]=1, ["2033-04-17"]=1, ["2034-04-09"]=1, ["2035-03-25"]=1, ["2036-04-13"]=1, ["2037-04-05"]=1, ["2038-04-25"]=1, ["2039-04-10"]=1, ["2040-04-01"]=1, ["2041-04-21"]=1, ["2042-04-06"]=1, ["2043-03-29"]=1, ["2044-04-17"]=1, ["2045-04-09"]=1, ["2046-03-25"]=1, ["2047-04-14"]=1, ["2048-04-05"]=1, ["2049-04-18"]=1, ["2050-04-10"]=1, ["2051-04-02"]=1, ["2052-04-21"]=1, ["2053-04-06"]=1, ["2054-03-29"]=1, ["2055-04-18"]=1, ["2056-04-02"]=1, ["2057-04-22"]=1, ["2058-04-14"]=1, ["2059-03-30"]=1, ["2060-04-18"]=1, ["2061-04-10"]=1, ["2062-03-26"]=1, ["2063-04-15"]=1, ["2064-04-06"]=1, ["2065-03-29"]=1, ["2066-04-11"]=1, ["2067-04-03"]=1, ["2068-04-22"]=1, ["2069-04-14"]=1, ["2070-03-30"]=1, ["2071-04-19"]=1, ["2072-04-10"]=1, ["2073-03-26"]=1, ["2074-04-15"]=1, ["2075-04-07"]=1, ["2076-04-19"]=1, ["2077-04-11"]=1, ["2078-04-03"]=1, ["2079-04-23"]=1, ["2080-04-07"]=1, ["2081-03-30"]=1, ["2082-04-19"]=1, ["2083-04-04"]=1, ["2084-03-26"]=1, ["2085-04-15"]=1, ["2086-03-31"]=1, ["2087-04-20"]=1, ["2088-04-11"]=1, ["2089-04-03"]=1, ["2090-04-16"]=1, ["2091-04-08"]=1, ["2092-03-30"]=1, ["2093-04-12"]=1, ["2094-04-04"]=1, ["2095-04-24"]=1, ["2096-04-15"]=1, ["2097-03-31"]=1, ["2098-04-20"]=1, ["2099-04-12"]=1},
		["Easter Monday"] = {["2000-04-24"]=1, ["2001-04-16"]=1, ["2002-04-01"]=1, ["2003-04-21"]=1, ["2004-04-12"]=1, ["2005-03-28"]=1, ["2006-04-17"]=1, ["2007-04-09"]=1, ["2008-03-24"]=1, ["2009-04-13"]=1, ["2010-04-05"]=1, ["2011-04-25"]=1, ["2012-04-09"]=1, ["2013-04-01"]=1, ["2014-04-21"]=1, ["2015-04-06"]=1, ["2016-03-28"]=1, ["2017-04-17"]=1, ["2018-04-02"]=1, ["2019-04-22"]=1, ["2020-04-13"]=1, ["2021-04-05"]=1, ["2022-04-18"]=1, ["2023-04-10"]=1, ["2024-04-01"]=1, ["2025-04-21"]=1, ["2026-04-06"]=1, ["2027-03-29"]=1, ["2028-04-17"]=1, ["2029-04-02"]=1, ["2030-04-22"]=1, ["2031-04-14"]=1, ["2032-03-29"]=1, ["2033-04-18"]=1, ["2034-04-10"]=1, ["2035-03-26"]=1, ["2036-04-14"]=1, ["2037-04-06"]=1, ["2038-04-26"]=1, ["2039-04-11"]=1, ["2040-04-02"]=1, ["2041-04-22"]=1, ["2042-04-07"]=1, ["2043-03-30"]=1, ["2044-04-18"]=1, ["2045-04-10"]=1, ["2046-03-26"]=1, ["2047-04-15"]=1, ["2048-04-06"]=1, ["2049-04-19"]=1, ["2050-04-11"]=1, ["2051-04-03"]=1, ["2052-04-22"]=1, ["2053-04-07"]=1, ["2054-03-30"]=1, ["2055-04-19"]=1, ["2056-04-03"]=1, ["2057-04-23"]=1, ["2058-04-15"]=1, ["2059-03-31"]=1, ["2060-04-19"]=1, ["2061-04-11"]=1, ["2062-03-27"]=1, ["2063-04-16"]=1, ["2064-04-07"]=1, ["2065-03-30"]=1, ["2066-04-12"]=1, ["2067-04-04"]=1, ["2068-04-23"]=1, ["2069-04-15"]=1, ["2070-03-31"]=1, ["2071-04-20"]=1, ["2072-04-11"]=1, ["2073-03-27"]=1, ["2074-04-16"]=1, ["2075-04-08"]=1, ["2076-04-20"]=1, ["2077-04-12"]=1, ["2078-04-04"]=1, ["2079-04-24"]=1, ["2080-04-08"]=1, ["2081-03-31"]=1, ["2082-04-20"]=1, ["2083-04-05"]=1, ["2084-03-27"]=1, ["2085-04-16"]=1, ["2086-04-01"]=1, ["2087-04-21"]=1, ["2088-04-12"]=1, ["2089-04-04"]=1, ["2090-04-17"]=1, ["2091-04-09"]=1, ["2092-03-31"]=1, ["2093-04-13"]=1, ["2094-04-05"]=1, ["2095-04-25"]=1, ["2096-04-16"]=1, ["2097-04-01"]=1, ["2098-04-21"]=1, ["2099-04-13"]=1},
		["WA Queen's/King's Birthday"] = {["2000-10-02"]=1, ["2001-10-01"]=1, ["2002-09-30"]=1, ["2003-09-29"]=1, ["2004-10-04"]=1, ["2005-09-26"]=1, ["2006-10-02"]=1, ["2007-10-01"]=1, ["2008-09-29"]=1, ["2009-09-28"]=1, ["2010-09-27"]=1, ["2011-10-28"]=1, ["2012-10-01"]=1, ["2013-09-30"]=1, ["2014-09-29"]=1, ["2015-09-28"]=1, ["2016-09-26"]=1, ["2017-09-25"]=1, ["2018-09-24"]=1, ["2019-09-30"]=1, ["2020-09-28"]=1, ["2021-10-27"]=1, ["2022-09-26"]=1, ["2023-09-25"]=1, ["2024-09-23"]=1, ["2025-09-29"]=1,["2026-09-28"]=1,["2027-09-27"]=1},
		["AFL Grand Final Friday"] = {["2015-10-02"]=1,["2016-09-30"]=1,["2017-09-29"]=1,["2018-09-28"]=1,["2019-09-27"]=1}
	}

  	for k,v in pairs(conf.conditions) do
  			if k=="date"then
        		if type(v)=="table" then
        			dateStart=DateOffset(v[1])
    				dateStop=DateOffset(v[2])
    				int=int.." Between(month,day) "..v[1].." & "..v[2]
				else
	        		int=int.." On(month,day) "..v
	          	end
    		elseif k=="dom" then
	            	if type(v)=="table" then
    					int=int.." Between(day of any month) "..v[1].." & "..v[2]
      				else
            	    	int=int.." On(day of any month) "..v
        	        end
      		elseif k=="month" then
	            	if type(v)=="table" then
    					int=int.." Between(month) "..v[1].." & "..v[2]
      				else
            	    	int=int.." On(month) "..v
        	        end
    		elseif k=="dow" then
            	    int=int.." On(day of any week) "..v
      		elseif k=="special" then
            	    int=int.." On special list "..v
    		else

        	end
      	end


  	local count=0
	local ok_finds={}
  	for _,c in ipairs(finds) do
		if conf.field ~= nil then
			local date=DateOffset(string.sub(c[conf.field],6,10))
			local day=tonumber(string.sub(c[conf.field],9,10))
			local month=tonumber(string.sub(c[conf.field],6,7))
			local d = isoDate:parse(c[conf.field])
			local wday=d.tab.wday
			--PGC.print(date,",",day,"\n")
			local lfail=false
			local lok=false
			for k,v in pairs(conf.conditions) do
				if k=="date" then
					if type(v)=="table" then
						if date>=dateStart and date<=dateStop then
							lok=true
						else
							lfail=true
						end
					else
						if string.sub(c[conf.field],6,10)==v then
							lok=true
						else
							lfail=true
						end
					end
				elseif k=="dom" then

						if type(v)=="table" then
							if day>=tonumber(v[1]) and day<=tonumber(v[2]) then
								lok=true
							else
								lfail=true
							end
						else
							if day==v then
								lok=true
							else
								lfail=true
							end
						end
				elseif k=="month" then

						if type(v)=="table" then
							if month>=tonumber(v[1]) and month<=tonumber(v[2]) then
								lok=true
							else
								lfail=true
							end
						else
							if month==v then
								lok=true
							else
								lfail=true
							end
						end
				elseif k=="dow" then

						if weekdays[wday]==v then
							lok=true
						else
							lfail=true
						end
				elseif k=="special" then

						if special[v][c[conf.field]]~=nil then
							lok=true
						else
							lfail=true
						end
				else
					PGC.print("conditions:",k,":",v," Unknown\n")
					return {ok=nil,html=nil,log=nil}
				end
			end

			if lok==true and lfail==false then
				count=count+1
				table.insert(ok_finds,c)
				--if count>=conf.limit then
					--break
				--end
			end
		end
  	end

	local ok=false
	if #ok_finds >= conf.limit then
	    ok = true
	end

	local slog = profileName .. " has " .. #ok_finds .. " finds (" .. conf.limit .. " needed)."..int.." "..PrintFilter(filter).."\n"
	local shtml = profileName .. " has " .. #ok_finds .. " finds (" .. conf.limit .. " needed)."..int.." "..PrintFilter(filter)
	local log = slog
	local html = shtml
	if conf.brief ~= true and conf.brief ~= "true" then
		local log = slog.."\n"..PrintFindsText(ok_finds,conf.limit,fields)
		local html = shtml.."<br>".. PrintFindsHtml(ok_finds,conf.limit,fields)
	end

	local points = nil
	if ok and conf.pointsPer ~= nil then
		points = conf.pointsPer * #ok_finds
		if conf.skipPoints ~= nil then
			if points <= conf.skipPoints then
				points = 0
			else
				points = points - conf.skipPoints
			end
		end
		if conf.maxPoints ~= nil and points > conf.maxPoints then
			points = conf.maxPoints
		end
	end

	return{ok = ok, log = log, html = html, slog = slog, shtml = shtml, points = points }
end -- end function c_date(

-----------------------------------------------------

function c_number(conf)
  	local options ={"limit","brief","pointsPer"}
  	if extraInConfig(conf,options)==true then
    	return{ok=nil,log=nil,html=nil}
    end
	local includeLabCaches = false
	if conf.includeLabCaches ~= nil then includeLabCaches = conf.includeLabCaches end
  	local filter=FilterFromConfig(conf)
	local fields = {'gccode', 'cache_name'}
	local limit = nil
	if conf.optimize then limit = conf.limit + 1 end
	local finds = GetCombinedFinds(profileId, { limit = limit, fields = fields, order = 'OLDESTFIRST', filter = filter, includeLabCaches = includeLabCaches })
	--local finds = GetCombinedFinds(profileId, { fields = fields, order = 'OLDESTFIRST', filter = filter })
	local ok=false
	if #finds >= conf.limit then
		if conf.upperlimit == nil or conf.upperlimit >= #finds then
			ok = true
		end
	end
	local slog = ""
	local shtml = "" 
	if conf.optimize ~= nil then
		slog = profileName .. " has at least " .. conf.limit .. "finds "
		if conf.upperlimit ~= nil then
			slog = slog .. "(max " .. conf.upperlimit .. ") "
		end
		slog = slog..PrintFilter(filter).."\n"
		shtml = profileName .. " has at least " .. conf.limit .. " finds "
		if conf.upperlimit ~= nil then
			shtml = shtml .. "(max " .. conf.upperlimit .. ") "
		end
		shtml = shtml..PrintFilter(filter)
	else
		slog = profileName .. " has " .. #finds .. " finds (" .. conf.limit .. " needed) "
		if conf.upperlimit ~= nil then
			slog = slog .. "(max " .. conf.upperlimit .. ") "
		end
		slog = slog..PrintFilter(filter).."\n"
		shtml = profileName .. " has " .. #finds .. " finds (" .. conf.limit .. " needed) "
		if conf.upperlimit ~= nil then
			shtml = shtml .. "(max " .. conf.upperlimit .. ") "
		end
		shtml = shtml..PrintFilter(filter)
	end
	local log = slog..PrintFindsText(finds,conf.limit,fields)
	local html = shtml..PrintFindsHtml(finds,conf.limit,fields)
  	if conf.brief== true then
    	log=""
    	html=""
    end

	local points = nil
	if ok and conf.pointsPer ~= nil then
		points = conf.pointsPer * #finds
		if conf.skipPoints ~= nil then
			if points <= conf.skipPoints then
				points = 0
			else
				points = points - conf.skipPoints
			end
		end
		if conf.maxPoints ~= nil and points > conf.maxPoints then
			points = conf.maxPoints
		end
	end

	return{ok = ok, log = log, html = html, slog = slog, shtml = shtml, points = points }
end -- end function c_number

-----------------------------------------------------

function c_range(conf)
  	local options ={"limit","brief","pointsPer"}
  	local filter=FilterFromConfig(conf)
	local fields = {'gccode', 'cache_name', conf.field}
	local myFinds = GetCombinedFinds(profileId, { fields = fields, order = 'OLDESTFIRST', filter = filter })
	--local finds = GetCombinedFinds(profileId, { fields = fields, order = 'OLDESTFIRST', filter = filter })
	local ok=false
	local finds = {}
	local limit = 1
	if conf.limit ~= nil then limit = conf.limit end
	local minVal = nil
	local minCache = nil
	local maxVal = nil
	local maxCache = nil

	for _,f in ipairs(myFinds) do
    	local val = tonumber(f[conf.field])
    	if val == nil then
      		PGC.print("Value not available. Field: "..conf.field..", cache: "..f.gccode.."\n")
    	else
			if (conf.min == nil or conf.min <= val) then
				if (conf.max == nil or conf.max >= val) then
					table.insert(finds,f)
          		end
			end
			if (minVal == nil or val < minVal) then
				minVal = val
				minCache = f
			end
			if (maxVal == nil or val > maxVal) then
				maxVal = val
				maxCache = f
			end
		end
	end

	if #finds >= limit then
	    ok = true
	end

	local fieldInfo = " Field: "..conf.field
	if (conf.min ~= nil) then
		fieldInfo = fieldInfo .. ", min: " .. conf.min
	end
	if (conf.max ~= nil) then
		fieldInfo = fieldInfo .. ", max: " .. conf.max
	end

	local slog = profileName .. " has " .. #finds .. " finds (" .. conf.limit .. " needed)."..PrintFilter(filter)..fieldInfo.."\n"
	local shtml = profileName .. " has " .. #finds .. " finds (" .. conf.limit .. " needed)."..PrintFilter(filter)..fieldInfo
	local log = slog..PrintFindsText(finds,limit,fields)
	local html = shtml.."<br/>"..PrintFindsHtml(finds,limit,fields)
	if #finds == 0 then
		if conf.min ~= nil then
			html = html.."<br/>Maximum found:<br/>"..PrintFindsHtml({maxCache},limit,fields)
		end
		if conf.max ~= nil then
			html = html.."<br/>Minimum found:<br/>"..PrintFindsHtml({minCache},limit,fields)
		end
	end
  	if conf.brief== true then
    	log=""
    	html=""
    end

	local points = nil
	if ok and conf.pointsPer ~= nil then
		points = conf.pointsPer * #finds
		if conf.skipPoints ~= nil then
			if points <= conf.skipPoints then
				points = 0
			else
				points = points - conf.skipPoints
			end
		end
		if conf.maxPoints ~= nil and points > conf.maxPoints then
			points = conf.maxPoints
		end
	end

	return{ok = ok, log = log, html = html, slog = slog, shtml = shtml, points = points }
end -- end function c_range

-----------------------------------------------------
function c_age(conf)
  local filter=FilterFromConfig(conf)
  local iso = Date.Format("yyyy-mm-dd")
  local date = Date {}
  date:add(conf.age)
  filter.maxHiddenDate=iso:tostring(date)
    local fields = {'gccode', 'cache_name','hidden','country'}
  local finds = GetCombinedFinds(profileId, { fields = fields, order = 'OLDESTFIRST', filter = filter })
  local ok=false
  if #finds > conf.limit then
    if conf.nrcountries ~= nil then
      local countries = {}
      local f = {}
      for _,v in ipairs(finds) do
        if countries[v.country] == nil then
          countries[v.country] = 1
          f[#f+1] = v
        end
      end
      finds = f
      if #finds >= conf.nrcountries then
        ok = true
      end
    else
      ok = true
    end
  end
  local sage=""
    if conf.age.year~=nil then
      sage=sage..-conf.age.year.." Years "
    end
    if conf.age.month~=nil then
      sage=sage..-conf.age.month.." Month "
    end
    if conf.age.days~=nil then
      sage=sage..-conf.age.days.." Days "
    end



  local slog = "Old Caches: User has " .. #finds .. " finds (" .. conf.limit .. " needed) older then "..sage.."."..PrintFilter(filter)
  local shtml = "Old Caches: User has " .. #finds .. " finds (" .. conf.limit .. " needed) older then "..sage.."."..PrintFilter(filter)
  if conf.nrcountries ~= nil then
    slog = slog .. " ("..conf.nrcountries.." countries needed)"
    shtml = shtml .. " ("..conf.nrcountries.." countries needed)"
  end
  slog = slog .. "\n"
    local log = slog.."\n"..PrintFindsText(finds,conf.limit,fields)
  local html =shtml.."<br>".. PrintFindsHtml(finds,conf.limit,fields)
  	if conf.brief== true then
    	log=""
    	html=""
    end

	local points = nil
	if ok and conf.pointsPer ~= nil then
		points = conf.pointsPer * #finds
		if conf.skipPoints ~= nil then
			if points <= conf.skipPoints then
				points = 0
			else
				points = points - conf.skipPoints
			end
		end
		if conf.maxPoints ~= nil and points > conf.maxPoints then
			points = conf.maxPoints
		end
	end

  return{ok = ok, log = log, html = html, slog = slog, shtml = shtml, points = points }
end -- end function c_age
-----------------------------------------------------
function c_streak(conf)
	local filter=FilterFromConfig(conf)
	local includeLabCaches = false
	if conf.includeLabCaches ~= nil then includeLabCaches = conf.includeLabCaches end
	local slog=""
	local shtml=""
	function DateDiff(a, b)
	   if(a ~= nil and b ~= nil) then
		  local iso = Date.Format("yyyy-mm-dd")
		  local d1 = iso:parse(a)
		  local d2 = iso:parse(b)

		  local diffDays = round((d2.time-d1.time)/86400)

		  return diffDays
	   end
	   return nil
	end
	function nrSE(l)
	 -- PGC.print("-------\n")
	 -- PGC.print(l)
	  local nr=0
	  local started=false
	  for i,v in ipairs(l) do
	   -- PGC.print(v.."\n")
		if v=="end" then
			if started then
				started=false
				nr=nr+1
			end
		end

		if  v=="start" then
		  started=true
		 end
	  end
		--PGC.print(nr.."\n")
	  return nr
	end
	function deepcopy(orig)
		local orig_type = type(orig)
		local copy
		if orig_type == 'table' then
			copy = {}
			for orig_key, orig_value in next, orig, nil do
				copy[deepcopy(orig_key)] = deepcopy(orig_value)
			end
			--setmetatable(copy, deepcopy(getmetatable(orig)))
		else -- number, string, boolean, etc
			copy = orig
		end
		return copy
	end
	function round(num, idp)
	   local mult = 10^(idp or 0)
	   return math.floor(num * mult + 0.5) / mult
	end

	function tablelength(T)
	   local count = 0
	   for _ in pairs(T) do count = count + 1 end
	   return count
	end

	function PrintCaches(html,s,pf)
	   local lastday=""
	   local pTypes={}
	   if pf.html then
		  table.insert(html,"<table>")
	   else
		  --table.insert(html,"[code]")
	   end
	   for i,c in ipairs(s.caches) do
		  if pf.onePerDay~=true or lastday~=c['visitdate'] or pTypes[c['type']]==nil then
		 pTypes[c['type']]=c['type']
		 table.insert(html,cacheToLog(c,pf))
		  end
		  lastday=c['visitdate']
	   end
	   if pf.html then
		  table.insert(html,"</table>")
	   else
		  --table.insert(html,"[/code]")
	   end
	end
	function cacheToLog(c,pf)
	   local res=""
	   if pf.html then
		  res=res.."<tr>"
		  --datumr
		  res=res.."<td>"..c['visitdate'].."</td>"
	   else
		  res=res..c['visitdate'].." "
	   end
	   if pf.html then
		  res=res..'<td><a href="http://coord.info/'..c['gccode']..'">'..c['gccode'].."</a></td>"
	   else
		  res=res..'[url=http://coord.info/'..c['gccode']..']'..c['gccode'].."[/url] "
	   end
	   if pf.DT and c['difficulty'] ~= nil then
		  if pf.html then
		 res=res.."<td>"..c['difficulty'].."/"..c['terrain'].."</td>"
		  else
		 res=res..c['difficulty'].."/"..c['terrain'].." "
		  end
	   end
	   if pf['type'] then
		  if pf.html then
		 res=res.."<td>"..c['type'].."</td>"
		  else
		 res=res..string.format("%-7s ",c['type'])
		  end
	   end
	   if pf.html then
		  res=res.."<td>"..c['cache_name'].."</td>"
		  res=res.."</tr>"
	   else
		  res=res..c['cache_name']
	   end


	   return res

	end
	function cStreakInit()
	   local cStreak={}
	   cStreak['points']=0
	   cStreak['loggedTypes']={}
	   cStreak['caches']={}
	   cStreak['StreakLength']=0
	   cStreak['nrFinds']=0
	   cStreak['ok']=false
	   cStreak['leaplog']=false
	   cStreak['year_se']={}
	   cStreak['month_se']={}
	   cStreak['week_se']={}
	   --cStreak['']=
	   --cStreak['']=
	   return cStreak
	end

	function logHeader(t,s,pf)
	   tmplog=""
	   if s.ok then
		  tmplog=tmplog..profileName .. " has succeeded between "..s['caches'][1]['visitdate'].." and "..s['caches'][table.maxn(s['caches'])]['visitdate']..": "
		  slog=profileName .. " has succeeded between "..s['caches'][1]['visitdate'].." and "..s['caches'][table.maxn(s['caches'])]['visitdate'].."\n"
		  shtml=profileName .. " has succeeded between "..s['caches'][1]['visitdate'].." and "..s['caches'][table.maxn(s['caches'])]['visitdate'].."<br/>"
	   else
		  tmplog=tmplog..profileName .. " has only between "..s['caches'][1]['visitdate'].." and "..s['caches'][table.maxn(s['caches'])]['visitdate']..": "
		  slog=profileName .. " has only between "..s['caches'][1]['visitdate'].." and "..s['caches'][table.maxn(s['caches'])]['visitdate'].."\n"
		  shtml=profileName .. " has only between "..s['caches'][1]['visitdate'].." and "..s['caches'][table.maxn(s['caches'])]['visitdate'].."<br/>"
	   end
	   if conf.days~= nil then
		  tmplog=tmplog.. s.StreakLength.." of "..conf.days.." days "
		  slog=slog.. s.StreakLength.." of "..conf.days.." days "
		  shtml=shtml.. s.StreakLength.." of "..conf.days.." days "
	   end
		if conf.limit~= nil then
		  tmplog=tmplog.. s.nrFinds.." of "..conf.limit.." caches "
	   end
	   if conf.MinNrTypes~= nil then
		  tmplog=tmplog.. tablelength(s.loggedTypes).." of "..conf.MinNrTypes.." diffrent types "
	   end
	   if conf.points~= nil then
		  tmplog=tmplog.. s.points.." of "..conf.points.." points "
	   end
		if conf.years~= nil then
		  tmplog=tmplog.. nrSE(s.year_se).." of "..conf.years.." complete years "
	   end
	   if conf.weeks~= nil then
		  tmplog=tmplog.. nrSE(s.week_se).." of "..conf.weeks.." complete weeks "
	   end
	   if conf.months~= nil then
		  tmplog=tmplog.. nrSE(s.month_se).." of "..conf.months.." complete months "
	   end
		if conf.months~= nil then
		  tmplog=tmplog.. nrSE(s.month_se).." of "..conf.months.." complete months "
	   end
		if conf.leapcheck~= nil then
			if s.leaplog then
				tmplog=tmplog.. "and a log on a leapday (Feb 29) "
			else
				tmplog=tmplog.. "and a MISSING log on a leapday (Feb 29) "
			end
		tmplog=tmplog.."in a streak"
	   end
	  if pf.html then
		if conf.brief~= true then
	  tmplog=tmplog.."<br>The result are the first time you met the requirement and only the minimum amount of caches are displayed"
		  end
		end
	   if pf.html then
		  table.insert(t,tmplog.."<br>")
		else
			table.insert(t,tmplog)
	   end

	end


	local currentType=conf.type
	local types=conf.types
	local minpoints=conf.points
	local MinNrTypes=conf.MinNrTypes
	if( minpoints==nil) then
	   minpoints=0
	end


	myFinds = GetCombinedFinds( profileId, {filter=filter, fields = { 'gccode','cache_name','difficulty','terrain', 'visitdate','type'}, order = 'OLDESTFIRST', includeLabCaches = includeLabCaches } )
	local tmp={}
	tmp['visitdate']="2900-01-01"
	table.insert(myFinds,tmp)


	local break_ok=true
	local one_per_day=true
	if conf.fullstreak==true then
	  break_ok=false
	end
	if conf.leapcheck==true then
	  break_ok=false
	end

	if conf.points~=nil or conf.MinNrTypes~=nil or conf.limit~=nil then
		one_per_day=false
	end
	local iso = Date.Format("yyyy-mm-dd")

	local ok=false
	local lastdate='1900-01-01'
	local cStreak=cStreakInit()
	local maxStreak=cStreakInit()
	local okStreak={}
	--local leaplog=false
	local lastStreak={}
	for _,c in ipairs(myFinds) do
	   local datediff=DateDiff(lastdate,c['visitdate'])
		--PGC.print("zero diff"..DateDiff(lastdate,c['visitdate']).."\n")
	   lastdate=c['visitdate']

	   --Avbrott om ok
	  -- if ok== false and (conf.fullstreak~=true or datediff>1) then
		  local cok=false
		  local cnot_ok=false
		  if conf.days~=nil then
			 if cStreak.StreakLength>=conf.days then
				cok=true
			else
				cnot_ok=true
			end
		  end
		 if conf.points~=nil then
			if cStreak.points>=conf.points then
				cok=true
			else
				cnot_ok=true
			end
		  end
		  if conf.limit~=nil then
			if cStreak.nrFinds>=conf.limit then
				cok=true
			else
				cnot_ok=true
			end
		  end
		  if conf.MinNrTypes~=nil then
			if tablelength(cStreak.loggedTypes)>=conf.MinNrTypes then
				cok=true
			else
				cnot_ok=true
			end
		  end
		  if conf.years~=nil then
			if nrSE(cStreak.year_se)>=conf.years then
				cok=true
			else
				cnot_ok=true
			end
		  end
		if conf.months~=nil then
			if nrSE(cStreak.month_se)>=conf.months then
				--PGC.print(cStreak.month_se)
				cok=true
			else
				cnot_ok=true
			end
		  end
		if conf.weeks~=nil then
			if nrSE(cStreak.week_se)>=conf.weeks then
				cok=true
			else
				cnot_ok=true
			end
		  end
		  if conf.leapcheck~=nil then
			if cStreak.leaplog==true then
				cok=true
			else
				cnot_ok=true
			end
		  end

		  -- Avbrty om ok och ej not_ok
		  if cok and cnot_ok==false then -- and ok==false then

			cStreak['ok']=true
			ok=true
			PGC.print("OK\n")
			--maxStreak=deepcopy(cStreak)
				--okStreak=deepcopy(cStreak)
			if okStreak.StreakLength==nil
				or conf.days~=nil and cStreak.StreakLength>=okStreak.StreakLength
				or conf.limit~=nil and cStreak.nrFinds>=okStreak.nrFinds  then
				maxStreak=cStreak
				okStreak=cStreak
				if break_ok then
					break
				end
			end
		  --end
	   end

	   --avbrotti streaken

	   if datediff>1  then
			lastStreak=cStreak
		  --Kolla om bättre än max
		  --Fulkol för bara längsa streak
		  --if cStreak.StreakLength>=maxStreak.StreakLength then
		  if maxStreak.StreakLength==nil
				or conf.days~=nil and cStreak.StreakLength>=maxStreak.StreakLength
				or conf.limit~=nil and cStreak.nrFinds>=maxStreak.nrFinds  then
			maxStreak=cStreak
			--PGC.print(maxStreak)
		  end
		  cStreak=cStreakInit()
			datediff=1
	   end
	   --nästa dag
	   if datediff==1 then

			-- ny dag
			if ok==false  or conf.fullstreak then
				cStreak.StreakLength=cStreak.StreakLength+1
			end
			--kolla skottdag  start/slut(vecka.månad.år)
			if conf.weeks~= nil or conf.months~=nil or conf.years~=nil or conf.leapcheck~=nil then
			local d1 = iso:parse(c['visitdate'])
			local d2 = iso:parse(c['visitdate'])
			local doy=d1:month().."-"..d1:day()
		 -- PGC.print(":",doy,":\n")
			if  doy=="2-29" then
				PGC.print("Leep:ok\n")
				cStreak.leaplog=true
			end
			if doy=="1-1" then
				table.insert(cStreak.year_se,"start")
			end
			if doy=="12-31" then
				table.insert(cStreak.year_se,"end")
			end
			if d1:day()==1 then
				table.insert(cStreak.month_se,"start")
			end
			if (d2:last_day()):day()==d1:day() then
				table.insert(cStreak.month_se,"end")
			end
			local t=d1:weekday_name()
			if t=='Mon' then
				table.insert(cStreak['week_se'],"start")
			end
			if t=='Sun' then
				table.insert(cStreak['week_se'],"end")
			end
			end
	   end

	   if c['gccode']~=nil and (one_per_day~=true or datediff==1)  then
		  --Lägg till cachen
		  if ok==false  or conf.fullstreak then
			--if ok==false  or conf.fullstreak then
			cStreak.nrFinds=cStreak.nrFinds+1
			table.insert(cStreak['caches'],c)
			if c['difficulty'] ~= nil and c['terrain'] ~= nil then
				cStreak.points=cStreak.points+c['difficulty']+c['terrain']
			end
			if  cStreak.loggedTypes[c['type']]==nil then
				cStreak.loggedTypes[c['type']]=c['type']
			end
		  end
	   end

	end

	--if  cStreak.StreakLength>=maxStreak.StreakLength then

	   if maxStreak.StreakLength==nil
				or conf.days~=nil and cStreak.StreakLength>=maxStreak.StreakLength
				or conf.limit~=nil and cStreak.nrFinds>=maxStreak.nrFinds  then
			maxStreak=cStreak
	end
	PGC.print(maxStreak.caches[1])
	if conf.leapcheck==true and okStreak.leaplog==false then
	  ok=false
	end
	log={}
	html={}



	--Standard format
	local pf={}
	pf['onePerDay']=true
	pf['DT']=true
	-- format beroende på param
	if conf.points~=nil then
	   pf['onePerDay']=false
	   pf['DT']=true
	end
	if conf.MinNrTypes~=nil then
	   pf['type']=true
	end


	if ok and (conf.MinNrTypes~= nil  or conf.points~= nil or (conf.days~=nil and conf.days<50)) then

	logHeader(log,okStreak,pf)
	  if conf.brief~= true then
		tmplog="The result are the first time you met the requirement and only the minimum amount of caches are displayed"
		table.insert(log,tmplog)
			PrintCaches(log,okStreak,pf)
		end
	end

	pf['html']=true



	if ok then
		table.insert(html,"Your qualifying  streak<br>")
		logHeader(html,okStreak,pf)
		if conf.brief~= true then
			PrintCaches(html,okStreak,pf)
		end
	--end
	else
		table.insert(html,"Your best streak:  <br>")
		if maxStreak.caches[1]~= nil then
			if maxStreak['caches'][1]['gccode']~= lastStreak['caches'][1]['gccode'] then
				table.insert(html,"(Your last streak are below)<br>")
			end
			logHeader(html,maxStreak,pf)
			PrintCaches(html,maxStreak,pf)
			if maxStreak['caches'][1]['gccode']~= lastStreak['caches'][1]['gccode'] then
				table.insert(html,"<br>Your last streak:<br>")
				logHeader(html,lastStreak,pf)
				if conf.brief~= true then
					PrintCaches(html,lastStreak,pf)
				end
			end
		else
			table.insert(html,"is zero")
		end
	end



	log=table.concat(log,"\n")
	html=table.concat(html)

	local points = nil
	if ok and conf.pointsPer ~= nil then
		points = conf.pointsPer * maxStreak.StreakLength
		if conf.skipPoints ~= nil then
			if points <= conf.skipPoints then
				points = 0
			else
				points = points - conf.skipPoints
			end
		end
		if conf.maxPoints ~= nil and points > conf.maxPoints then
			points = conf.maxPoints
		end
	end

  return{ok = ok, log = log, html = html, slog = slog, shtml = shtml, points = points }
end -- end function c_streak
-----------------------------------------------------
function c_attributes(conf)
	local cachesWithAttribute = {}
	local cacheCountForAttribute = {}
	local totalValid = 0

	local includedAttributes = conf.attributes
	local totalRequired = conf.total
	local requiredUnique = conf.unique
	if requiredUnique == nil then requiredUnique = 0 end

	local ok = false
	local log = false
	local html = {}
	local slog = false
	local shtml = {}

	if includedAttributes == "positive" then
	  includedAttributes = {[1]=0,[2]=0,[3]=0,[4]=0,[5]=0,[6]=0,[7]=0,[8]=0,[9]=0,[10]=0,[11]=0,[12]=0,[13]=0,[14]=0,[15]=0,[17]=0,[18]=0,[19]=0,[20]=0,[21]=0,[22]=0,[23]=0,[24]=0,[25]=0,[26]=0,[27]=0,[28]=0,[29]=0,[30]=0,[31]=0,[32]=0,[33]=0,[34]=0,[35]=0,[36]=0,[37]=0,[38]=0,[39]=0,[40]=0,[41]=0,[42]=0,[43]=0,[44]=0,[45]=0,[46]=0,[47]=0,[48]=0,[49]=0,[50]=0,[51]=0,[52]=0,[53]=0,[54]=0,[55]=0,[56]=0,[57]=0,[58]=0,[59]=0,[60]=0,[61]=0,[62]=0,[63]=0,[64]=0,[65]=0,[66]=0,[67]=0,[69]=0,[70]=0,[71]=0,[72]=0}
	elseif includedAttributes == "negative" then
	  includedAttributes = {[97]=0,[102]=0,[103]=0,[104]=0,[105]=0,[106]=0,[109]=0,[110]=0,[111]=0,[113]=0,[120]=0,[121]=0,[123]=0,[124]=0,[125]=0,[126]=0,[127]=0,[128]=0,[129]=0,[130]=0,[131]=0,[132]=0,[133]=0,[134]=0,[136]=0,[137]=0,[142]=0,[143]=0,[148]=0,[149]=0,[150]=0,[151]=0,[152]=0,[153]=0,[154]=0,[155]=0,[158]=0,[159]=0,[160]=0,[161]=0,[162]=0}
	elseif includedAttributes == "all" then
	  includedAttributes = {[1]=0,[2]=0,[3]=0,[4]=0,[5]=0,[6]=0,[7]=0,[8]=0,[9]=0,[10]=0,[11]=0,[12]=0,[13]=0,[14]=0,[15]=0,[17]=0,[18]=0,[19]=0,[20]=0,[21]=0,[22]=0,[23]=0,[24]=0,[25]=0,[26]=0,[27]=0,[28]=0,[29]=0,[30]=0,[31]=0,[32]=0,[33]=0,[34]=0,[35]=0,[36]=0,[37]=0,[38]=0,[39]=0,[40]=0,[41]=0,[42]=0,[43]=0,[44]=0,[45]=0,[46]=0,[47]=0,[48]=0,[49]=0,[50]=0,[51]=0,[52]=0,[53]=0,[54]=0,[55]=0,[56]=0,[57]=0,[58]=0,[59]=0,[60]=0,[61]=0,[62]=0,[63]=0,[64]=0,[65]=0,[66]=0,[67]=0,[69]=0,[70]=0,[71]=0,[72]=0,[97]=0,[102]=0,[103]=0,[104]=0,[105]=0,[106]=0,[109]=0,[110]=0,[111]=0,[113]=0,[120]=0,[121]=0,[123]=0,[124]=0,[125]=0,[126]=0,[127]=0,[128]=0,[129]=0,[130]=0,[131]=0,[132]=0,[133]=0,[134]=0,[136]=0,[137]=0,[142]=0,[143]=0,[148]=0,[149]=0,[150]=0,[151]=0,[152]=0,[153]=0,[154]=0,[155]=0,[158]=0,[159]=0,[160]=0,[161]=0,[162]=0}
	end

	local types =
	{
	  ["Traditional Cache"]            = "http://www.geocaching.com/images/wpttypes/sm/2.gif",
	  ["Multi-Cache"]                  = "http://www.geocaching.com/images/wpttypes/sm/3.gif",
	  ["Virtual Cache"]                = "http://www.geocaching.com/images/wpttypes/sm/4.gif",
	  ["Letterbox Hybrid"]             = "http://www.geocaching.com/images/wpttypes/sm/5.gif",
	  ["Event Cache"]                  = "http://www.geocaching.com/images/wpttypes/sm/6.gif",
	  ["Mystery Cache"]                = "http://www.geocaching.com/images/wpttypes/sm/8.gif",
	  ["Project A.P.E. Cache"]            = "http://www.geocaching.com/images/wpttypes/sm/9.gif",
	  ["Webcam Cache"]                 = "http://www.geocaching.com/images/wpttypes/sm/11.gif",
	  ["EarthCache"]                   = "http://www.geocaching.com/images/wpttypes/sm/earthcache.gif",
	  ["Cache In Trash Out Event"]     = "http://www.geocaching.com/images/wpttypes/sm/13.gif",
	  ["Mega-Event Cache"]             = "http://www.geocaching.com/images/wpttypes/sm/mega.gif",
	  ["Giga-Event Cache"]             = "http://www.geocaching.com/images/wpttypes/sm/giga.gif",
	  ["Wherigo Cache"]                = "http://www.geocaching.com/images/wpttypes/sm/wherigo.gif",
	  ["Geocaching HQ Cache"]               = "http://www.geocaching.com/images/wpttypes/sm/3773.gif",
	  ["Benchmark"]	                   = "http://www.geocaching.com/images/wpttypes/sm/27.gif",
	  ["Locationless Cache"] = "http://www.geocaching.com/images/wpttypes/sm/12.gif",
	  ["10 Years! Event Cache"]        = "http://www.geocaching.com/images/wpttypes/sm/3653.gif",
	  ["GPS Adventures Maze Exhibit"]  = "http://www.geocaching.com/images/wpttypes/sm/1304.gif",
	  ["Community Celebration Event"]   = "http://www.geocaching.com/images/wpttypes/sm/3653.gif",
	  ["Geocaching HQ Block Party"]      = "http://www.geocaching.com/images/wpttypes/sm/4738.gif",
	  ["GPS Adventures Maze Exhibit"]       = "http://www.geocaching.com/images/wpttypes/sm/maze.gif"
	}

	local attributeDescriptions =
	{
	  [1]  = "Dogs allowed",
	  [2]  = "Access/parking fee",
	  [3]  = "Climbing gear required",
	  [4]  = "Boat required",
	  [5]  = "Scuba gear required",
	  [6]  = "Kid-friendly",
	  [7]  = "Takes less than 1 hour",
	  [8]  = "Scenic view",
	  [9]  = "Significant hike",
	  [10] = "Difficult climbing",
	  [11] = "May require wading",
	  [12] = "May require swimming",
	  [13] = "Available 24/7",
	  [14] = "Recommended at night",
	  [15] = "Available in winter",
	  [17] = "Poison plants",
	  [18] = "Dangerous animals",
	  [19] = "Ticks",
	  [20] = "Abandoned mine nearby",
	  [21] = "Cliffs/falling rocks nearby",
	  [22] = "Hunting area",
	  [23] = "Dangerous area",
	  [24] = "Wheelchair-accessible",
	  [25] = "Parking available",
	  [26] = "Public transit available",
	  [27] = "Drinking water nearby",
	  [28] = "Restrooms available",
	  [29] = "Telephone nearby",
	  [30] = "Picnic tables available",
	  [31] = "Camping available",
	  [32] = "Bikes allowed",
	  [33] = "Motorcycles allowed",
	  [34] = "Quads allowed",
	  [35] = "Off-road vehicles allowed",
	  [36] = "Snowmobiles allowed",
	  [37] = "Horses allowed",
	  [38] = "Campfires allowed",
	  [39] = "Thorns",
	  [40] = "Stealth required",
	  [41] = "Stroller-accessible",
	  [42] = "Needs maintenance",
	  [43] = "Watch for livestock",
	  [44] = "Flashlight required",
	  [45] = "Lost and found",
	  [46] = "Truck-driver-/RV-accessible",
	  [47] = "Field puzzle",
	  [48] = "UV light required",
	  [49] = "May require snowshoes",
	  [50] = "Cross-country skis required",
	  [51] = "Special tool required",
	  [52] = "Night cache",
	  [53] = "Park-and-grab",
	  [54] = "In an abandoned structure",
	  [55] = "Hike shorter than 1 km",
	  [56] = "Hike between 1km-10km",
	  [57] = "Hike longer than 10km",
	  [58] = "Fuel nearby",
	  [59] = "Food nearby",
	  [60] = "Wireless beacon required",
	  [61] = "Partnership cache",
	  [62] = "Seasonal access only",
	  [63] = "Recommended for tourists",
	  [64] = "Tree-climbing required",
	  [65] = "In front yard (with permission)",
	  [66] = "Teamwork required",
	  [67] = "Part of a GeoTour",
	  [69] = "Bonus cache",
	  [70] = "Power trail",
	  [71] = "Challenge cache",
	  [72] = "Geocaching.com solution checker",

	  [97] = "No dogs allowed",

	  [102]= "Not recommended for kids",
	  [103]= "Takes more than 1 hour",
	  [104]= "No scenic view",
	  [105]= "Not a significant hike",
	  [106]= "No difficult climbing",

	  [109]= "Not available 24/7",
	  [110]= "Not recommended at night",
	  [111]= "Not available in winter",

	  [113]= "No poison plants",

	  [120]= "Not wheelchair-accessible",
	  [121]= "No parking available",

	  [123]= "No drinking water available",
	  [124]= "No public restrooms nearby",
	  [125]= "No telephone nearby",
	  [126]= "No picnic tables nearby",
	  [127]= "No camping",
	  [128]= "No bicycles",
	  [129]= "No motorcycles",
	  [130]= "No quads",
	  [131]= "No off-road vehicles",
	  [132]= "No snowmobiles",
	  [133]= "No horses",
	  [134]= "No campfires",

	  [136]= "No stealth required",
	  [137]= "Not stroller-accessible",

	  [142]= "Not truck-driver-/RV-accessible",
	  [143]= "Not a field puzzle",

	  [148]= "Not a night cache",
	  [149]= "Not a park-and-grab",
	  [150]= "Not in an abandoned structure",
	  [151]= "Not a short hike",
	  [152]= "Not a medium hike",
	  [153]= "Not a long hike",
	  [154]= "No fuel nearby",
	  [155]= "No food nearby",

	  [158]= "Available all year",
	  [159]= "Not recommended for tourists",
	  [160]= "No tree-climbing required",
	  [161]= "Not in a front yard",
	  [162]= "No teamwork required"
	}

	local attributeIcons =
	{
	  [1] = "http://www.geocaching.com/images/attributes/dogs-yes.gif",
	  [2] = "http://www.geocaching.com/images/attributes/fee-yes.gif",
	  [3] = "http://www.geocaching.com/images/attributes/rappelling-yes.gif",
	  [4] = "http://www.geocaching.com/images/attributes/boat-yes.gif",
	  [5] = "http://www.geocaching.com/images/attributes/scuba-yes.gif",
	  [6] = "http://www.geocaching.com/images/attributes/kids-yes.gif",
	  [7] = "http://www.geocaching.com/images/attributes/onehour-yes.gif",
	  [8] = "http://www.geocaching.com/images/attributes/scenic-yes.gif",
	  [9] = "http://www.geocaching.com/images/attributes/hiking-yes.gif",
	  [10] = "http://www.geocaching.com/images/attributes/climbing-yes.gif",
	  [11] = "http://www.geocaching.com/images/attributes/wading-yes.gif",
	  [12] = "http://www.geocaching.com/images/attributes/swimming-yes.gif",
	  [13] = "http://www.geocaching.com/images/attributes/available-yes.gif",
	  [14] = "http://www.geocaching.com/images/attributes/night-yes.gif",
	  [15] = "http://www.geocaching.com/images/attributes/winter-yes.gif",

	  [17] = "http://www.geocaching.com/images/attributes/poisonoak-yes.gif",
	  [18] = "http://www.geocaching.com/images/attributes/dangerousanimals-yes.gif",
	  [19] = "http://www.geocaching.com/images/attributes/ticks-yes.gif",
	  [20] = "http://www.geocaching.com/images/attributes/mine-yes.gif",
	  [21] = "http://www.geocaching.com/images/attributes/cliff-yes.gif",
	  [22] = "http://www.geocaching.com/images/attributes/hunting-yes.gif",
	  [23] = "http://www.geocaching.com/images/attributes/danger-yes.gif",
	  [24] = "http://www.geocaching.com/images/attributes/wheelchair-yes.gif",
	  [25] = "http://www.geocaching.com/images/attributes/parking-yes.gif",
	  [26] = "http://www.geocaching.com/images/attributes/public-yes.gif",
	  [27] = "http://www.geocaching.com/images/attributes/water-yes.gif",
	  [28] = "http://www.geocaching.com/images/attributes/restrooms-yes.gif",
	  [29] = "http://www.geocaching.com/images/attributes/phone-yes.gif",
	  [30] = "http://www.geocaching.com/images/attributes/picnic-yes.gif",
	  [31] = "http://www.geocaching.com/images/attributes/camping-yes.gif",
	  [32] = "http://www.geocaching.com/images/attributes/bicycles-yes.gif",
	  [33] = "http://www.geocaching.com/images/attributes/motorcycles-yes.gif",
	  [34] = "http://www.geocaching.com/images/attributes/quads-yes.gif",
	  [35] = "http://www.geocaching.com/images/attributes/jeeps-yes.gif",
	  [36] = "http://www.geocaching.com/images/attributes/snowmobiles-yes.gif",
	  [37] = "http://www.geocaching.com/images/attributes/horses-yes.gif",
	  [38] = "http://www.geocaching.com/images/attributes/campfires-yes.gif",
	  [39] = "http://www.geocaching.com/images/attributes/thorn-yes.gif",
	  [40] = "http://www.geocaching.com/images/attributes/stealth-yes.gif",
	  [41] = "http://www.geocaching.com/images/attributes/stroller-yes.gif",
	  [42] = "http://www.geocaching.com/images/attributes/firstaid-yes.gif",
	  [43] = "http://www.geocaching.com/images/attributes/cow-yes.gif",
	  [44] = "http://www.geocaching.com/images/attributes/flashlight-yes.gif",
	  [45] = "http://www.geocaching.com/images/attributes/landf-yes.gif",
	  [46] = "http://www.geocaching.com/images/attributes/rv-yes.gif",
	  [47] = "http://www.geocaching.com/images/attributes/field_puzzle-yes.gif",
	  [48] = "http://www.geocaching.com/images/attributes/UV-yes.gif",
	  [49] = "http://www.geocaching.com/images/attributes/snowshoes-yes.gif",
	  [50] = "http://www.geocaching.com/images/attributes/skiis-yes.gif",
	  [51] = "http://www.geocaching.com/images/attributes/s-tool-yes.gif",
	  [52] = "http://www.geocaching.com/images/attributes/nightcache-yes.gif",
	  [53] = "http://www.geocaching.com/images/attributes/parkngrab-yes.gif",
	  [54] = "http://www.geocaching.com/images/attributes/abandonedbuilding-yes.gif",
	  [55] = "http://www.geocaching.com/images/attributes/hike_short-yes.gif",
	  [56] = "http://www.geocaching.com/images/attributes/hike_med-yes.gif",
	  [57] = "http://www.geocaching.com/images/attributes/hike_long-yes.gif",
	  [58] = "http://www.geocaching.com/images/attributes/fuel-yes.gif",
	  [59] = "http://www.geocaching.com/images/attributes/food-yes.gif",
	  [60] = "http://www.geocaching.com/images/attributes/wirelessbeacon-yes.gif",
	  [61] = "http://www.geocaching.com/images/attributes/partnership-yes.gif",
	  [62] = "http://www.geocaching.com/images/attributes/seasonal-yes.gif",
	  [63] = "http://www.geocaching.com/images/attributes/touristOK-yes.gif",

	  [64] = "http://www.geocaching.com/images/attributes/treeclimbing-yes.gif",
	  [65] = "http://www.geocaching.com/images/attributes/frontyard-yes.gif",
	  [66] = "http://www.geocaching.com/images/attributes/teamwork-yes.gif",
	  [67] = "http://www.geocaching.com/images/attributes/geotour-yes.gif",
	  
	[69] = "https://www.geocaching.com/images/attributes/bonuscache-yes.png' width='30' height='30",
	[70] = "https://www.geocaching.com/images/attributes/powertrail-yes.png' width='30' height='30",
	[71] = "https://www.geocaching.com/images/attributes/challengecache-yes.png' width='30' height='30",
	[72] = "https://www.geocaching.com/images/attributes/hqsolutionchecker-yes.png' width='30' height='30",

	  [97] = "http://www.geocaching.com/images/attributes/dogs-no.gif",

	  [102]= "http://www.geocaching.com/images/attributes/kids-no.gif",
	  [103]= "http://www.geocaching.com/images/attributes/onehour-no.gif",
	  [104]= "http://www.geocaching.com/images/attributes/scenic-no.gif",
	  [105]= "http://www.geocaching.com/images/attributes/hiking-no.gif",
	  [106]= "http://www.geocaching.com/images/attributes/climbing-no.gif",

	  [109]= "http://www.geocaching.com/images/attributes/available-no.gif",
	  [110]= "http://www.geocaching.com/images/attributes/night-no.gif",
	  [111]= "http://www.geocaching.com/images/attributes/winter-no.gif",

	  [113]= "http://www.geocaching.com/images/attributes/poisonoak-no.gif",

	  [120]= "http://www.geocaching.com/images/attributes/wheelchair-no.gif",
	  [121]= "http://www.geocaching.com/images/attributes/parking-no.gif",

	  [123]= "http://www.geocaching.com/images/attributes/water-no.gif",
	  [124]= "http://www.geocaching.com/images/attributes/restrooms-no.gif",
	  [125]= "http://www.geocaching.com/images/attributes/phone-no.gif",
	  [126]= "http://www.geocaching.com/images/attributes/picnic-no.gif",
	  [127]= "http://www.geocaching.com/images/attributes/camping-no.gif",
	  [128]= "http://www.geocaching.com/images/attributes/bicycles-no.gif",
	  [129]= "http://www.geocaching.com/images/attributes/motorcycles-no.gif",
	  [130]= "http://www.geocaching.com/images/attributes/quads-no.gif",
	  [131]= "http://www.geocaching.com/images/attributes/jeeps-no.gif",
	  [132]= "http://www.geocaching.com/images/attributes/snowmobiles-no.gif",
	  [133]= "http://www.geocaching.com/images/attributes/horses-no.gif",
	  [134]= "http://www.geocaching.com/images/attributes/campfires-no.gif",

	  [136]= "http://www.geocaching.com/images/attributes/stealth-no.gif",
	  [137]= "http://www.geocaching.com/images/attributes/stroller-no.gif",

	  [142]= "http://www.geocaching.com/images/attributes/rv-no.gif",
	  [143]= "http://www.geocaching.com/images/attributes/field_puzzle-no.gif",

	  [148]= "http://www.geocaching.com/images/attributes/nightcache-no.gif",
	  [149]= "http://www.geocaching.com/images/attributes/parkngrab-no.gif",
	  [150]= "http://www.geocaching.com/images/attributes/abandonedbuilding-no.gif",
	  [151]= "http://www.geocaching.com/images/attributes/hike_short-no.gif",
	  [152]= "http://www.geocaching.com/images/attributes/hike_med-no.gif",
	  [153]= "http://www.geocaching.com/images/attributes/hike_long-no.gif",
	  [154]= "http://www.geocaching.com/images/attributes/fuel-no.gif",
	  [155]= "http://www.geocaching.com/images/attributes/food-no.gif",

	  [158]= "http://www.geocaching.com/images/attributes/seasonal-no.gif",
	  [159]= "http://www.geocaching.com/images/attributes/touristOK-no.gif",
	  [160]= "http://www.geocaching.com/images/attributes/treeclimbing-no.gif",
	  [161]= "http://www.geocaching.com/images/attributes/frontyard-no.gif",
	  [162]= "http://www.geocaching.com/images/attributes/teamwork-no.gif"
	}

	---------------------------------------------------------------------------------------
	--                              Function Definitions                                 --
	---------------------------------------------------------------------------------------

	-- Given a bit index, get the value if that bit was set to 1
	-- e.g.  given 4, set the fourth bit from the right to 1.  Result:  8
	function bit(p)
	  return 2 ^ (p - 1)  -- 1-based indexing
	end

	-- Given a bitfield and bitmask, AND the two to determine if the bitmask is set in this field.
	function hasbit(x, p)
	  return x % (p + p) >= p
	end

	-- Take an attribute field from the GC data, and an attribute number, and figure if that attribute is set/unset.
	-- If so, add the cache to an array of valid caches, indexed by attribute number
	function processAttributes(attributesBits, bitMask, arrayIndex, cacheIndex)

	  -- Only include attribute types that are required for this challenge
	  if (includedAttributes[arrayIndex] == nil) then return end
	  if (hasbit(attributesBits, bitMask)) then

		if (cachesWithAttribute[arrayIndex] == nil) then
		  cachesWithAttribute[arrayIndex] = {}
		end

		if (cacheCountForAttribute[arrayIndex] == nil) then
		  cacheCountForAttribute[arrayIndex] = 0
		end

		cacheCountForAttribute[arrayIndex] = cacheCountForAttribute[arrayIndex] + 1
		cachesWithAttribute[arrayIndex][cacheCountForAttribute[arrayIndex]] = cacheIndex

	  end
	end

	---------------------------------------------------------------------------------------
	--                            End Function Definitions                               --
	---------------------------------------------------------------------------------------

	-- Set defaults for parameters if not set
	if (totalRequired == nil) then totalRequired = 0 end

	local filter=FilterFromConfig(conf)

	-- Get the user's finds
	local finds = GetCombinedFinds(profileId, { fields = {'gccode', 'cache_name', 'visitdate', 'attributes_set', 'attributes_unset', 'owner_id', 'type'}, order = 'OLDESTFIRST', filter = filter})


	-- Attributes are stored in six numerical fields, as bitfields.
	-- The first 32 are in attributes_set_1
	-- The next 32 are in attributes_set_2
	-- The last 32 are in attributes_set_3
	-- Deselected attributes are in attributes_unset_1, 2, 3

	-- Mask out the selected/deselected attributes and store the caches according to attribute number
	for index, cache in ipairs(finds) do

	  for i = 1, 32 do
		local bitMask = bit(i)

		-- Convert attribute data from a group of bits to tables indexed by attribute number
		processAttributes(cache.attributes_set_1, bitMask, i, index)
		processAttributes(cache.attributes_set_2, bitMask, i + 32, index)
		processAttributes(cache.attributes_set_3, bitMask, i + 64, index)

		processAttributes(cache.attributes_unset_1, bitMask, i + 96, index)
		processAttributes(cache.attributes_unset_2, bitMask, i + 128, index)
		processAttributes(cache.attributes_unset_3, bitMask, i + 160, index)

	  end
	end

	local enoughCaches = true
	local totalUnique = 0

	for attrNum, count in pairs(includedAttributes) do
	  if (cacheCountForAttribute[attrNum] == nil) then cacheCountForAttribute[attrNum] = 0 end
	  if (cacheCountForAttribute[attrNum] < count) then
		enoughCaches = false
	  end
	  totalValid = totalValid + cacheCountForAttribute[attrNum]
	  if (cacheCountForAttribute[attrNum] > 0) then
	    totalUnique = totalUnique + 1
	  end
	end

	ok = enoughCaches and totalValid >= totalRequired and totalUnique >= requiredUnique

	-- Generate the sample log
	if(ok == true) then
	  log = ""
	end

	-- Generate the HTML message to the user
	if (ok == true) then
	  table.insert(html, '')
	elseif (enoughCaches) then
	  table.insert(html, profileName .. " has found enough caches of each attribute type, but don't have enough total caches.")
	elseif (totalValid >= totalRequired) then
	  table.insert(html, profileName .. " has found enough total caches, but don't have enough of each attribute type.")
	end

	if (totalRequired > 0) then
	  local numRequired = totalRequired - totalValid
	  if (numRequired < 0) then numRequired = 0 end
	  if (numRequired > 0) then
		color = "red"
		symbol = "?"
	  else
		color = "green"
		symbol = "?"
	  end
	  table.insert(html, "<div><span style='font-size:20pt;font-weight:bold;color:" .. color .. ";'>" .. symbol .. "</span>&nbsp;You have found <span style='font-size:18pt;font-weight:bold;color:" .. color .. ";'>" .. totalValid .. '</span> caches with attributes of the required types. You require <span style="font-size:18pt;font-weight:bold;color:' .. color .. ';">' .. numRequired .. "</span> more caches with these attributes.</div><br />")
	  table.insert(shtml, profileName .. " has found " .. totalValid .. ' caches with attributes of the required types ('..totalRequired..' required).')
	end

	for attrNum, count in pairs(includedAttributes) do
	  local numRequired = count - cacheCountForAttribute[attrNum]
	  if (numRequired < 0) then numRequired = 0 end
	  if (numRequired > 0) then
		color = "red"
		symbol = "?"
	  else
		color = "green"
		symbol = "?"
	  end
	  table.insert(html, "<div><span style='font-size:20pt;font-weight:bold;color:" .. color .. ";'>" .. symbol .. "</span><img  style='margin-bottom:2px' src='" .. attributeIcons[attrNum] .. "' />&nbsp;You have found <span style='font-size:18pt;font-weight:bold;color:" .. color .. ";'>" .. cacheCountForAttribute[attrNum] .. '</span> caches of type "' .. attributeDescriptions[attrNum] .. '". You require <span style="font-size:18pt;font-weight:bold;color:' .. color .. ';">' .. numRequired .. "</span> more caches of this type.</div>")
	  table.insert(shtml, profileName .. " has found " .. cacheCountForAttribute[attrNum] .. ' caches of type "' .. attributeDescriptions[attrNum] .. '" ('..includedAttributes[attrNum]..' required).')
	end

	html = table.concat(html)
	log = html
	shtml = table.concat(shtml)

	if (requiredUnique > 0) then
		shtml = profileName .. " has found "..totalUnique.." unique attributes ("..requiredUnique.." required)"
	end

	slog = shtml

	local points = nil
	if ok and conf.pointsPer ~= nil then
		points = conf.pointsPer * totalValid
		if conf.skipPoints ~= nil then
			if points <= conf.skipPoints then
				points = 0
			else
				points = points - conf.skipPoints
			end
		end
		if conf.maxPoints ~= nil and points > conf.maxPoints then
			points = conf.maxPoints
		end
	end

  return{ok = ok, log = log, html = html, slog = slog, shtml = shtml, points = points }
end -- end function c_attributes
-----------------------------------------------------
function c_fp(conf)
	function GetProfileId(args)
	  profileName = args[1].profileName
	  profileId = PGC.ProfileName2Id(profileName)
	--	DebugPrintLine("ProfileName: "..profileName.." ("..profileId..")")
	  return profileId
	end

	function GetDefault(value, default)
	  if (value == nil) then
		return default
	  else
		return value
	  end
	end

	function TableLength(T)
	  local count = 0
	  for _ in ipairs(T) do count = count + 1 end
	  return count
	end

	function GetSumOfTopFavoritePoints(caches, sumFavs, numOfCaches, minFavsPerFind)
	  local logtable = {}
	  table.insert(logtable, "Nr  \tFavorites    Visited         GCCode \t Cache" )
	  local qualfinds = {}
	  local usedCaches = {}
	  table.insert(qualfinds, { "Nr", "Favorites", "Visited", "GCCode", "Cache"})

	  noNumOfCachesGiven = false
	  if (numOfCaches == -1) then
		noNumOfCachesGiven = true
		numOfCaches = TableLength(caches)
	  end

	  sumFavPoints = 0
	  qualCount = 0
	  if (TableLength(caches) > 0) then
		for _,c in ipairs(caches) do
		  if usedCaches[c.gccode] == nil then
			  if (qualCount + 1) > numOfCaches
				  or tonumber(c.favorite_points) < minFavsPerFind
				  or (sumFavPoints > tonumber(sumFavs) and noNumOfCachesGiven) then
				break
			  end
			  qualCount = qualCount + 1
			  sumFavPoints = sumFavPoints + c.favorite_points
			  table.insert(logtable, qualCount..". \t" ..c.favorite_points.."     \t "..c.visitdate.."   "..c.gccode.." \t " .. c.cache_name )
			  table.insert(qualfinds, {qualCount, c.favorite_points, c.visitdate, c.gccode, c.cache_name})
			  usedCaches[c.gccode] = c.gccode
		  end
		end
	  end
	  return sumFavPoints, qualCount, qualfinds, logtable
	end

	-- init script variables
	if (conf.debug == "true") then
	  DEBUG = true;
	end

	sumFavs = tonumber(GetDefault(conf.sumFavs, "-1"))
	numFinds = tonumber(GetDefault(conf.numFinds, "-1"))
	minFavsPerFind = tonumber(GetDefault(conf.minFavsPerFind, "0"))
	country = GetDefault(conf.country, nil)
	region = GetDefault(conf.region, nil)

	fields = { 'gccode', 'cache_name', 'favorite_points', 'visitdate'}
	local filter=FilterFromConfig(conf)
	myFinds = GetCombinedFinds( profileId, { filter = filter, fields = fields } )

	-- sort find list by favorite points
	table.sort( myFinds, function (a,b)
	  return tonumber(a.favorite_points) > tonumber(b.favorite_points)
	end )

	PGC.print('sumFavs ', sumFavs, ' numFinds ', numFinds, ' minFavsPerFind ', minFavsPerFind,' country ', country,' region ', region, '\n')
	--PGC.print('My finds sorted by favs:\n', myFinds, '\n')

	foundFavPoints, qualCount, qualfinds, logtable = GetSumOfTopFavoritePoints( myFinds, sumFavs, numFinds, minFavsPerFind, logtable, qualfinds )

	-- prepare output and log
	local ok = false
	local log = false
	local slog = ""
	local shtml = ""
	if foundFavPoints >= sumFavs and qualCount >= numFinds then
	  ok = true
	  log = 'I checked on '..Date.Format("dd.mm.yyyy HH:MM"):tostring(Date)..' and found that I have collected '..foundFavPoints..' favorite points with '..qualCount..' found caches.\n'
	  log = log..'Following is the list of my finds:\n'
	  log = log .. table.concat(logtable, "\n")
	  PGC.print(log)
	  slog = slog .. profileName .. ' has collected '..foundFavPoints..' favorite points with '..qualCount..' found caches.'
	else
	  slog = slog .. profileName .. ' has collected '..foundFavPoints..' favorite points with '..qualCount..' found caches.'
	  log = slog
	  PGC.print('You have collected '..foundFavPoints..' favorite points with '..qualCount..' found caches.\n')
	  PGC.print('By improving by '..string.format("%.0f",sumFavs-foundFavPoints)..' favorite points you would be able to log this challenge.\n')
	end
	local html = PGC.CreateHTMLTable(qualfinds)
	shtml = slog

	local points = nil
	if ok and conf.pointsPer ~= nil then
		points = conf.pointsPer * foundFavPoints
		if conf.skipPoints ~= nil then
			if points <= conf.skipPoints then
				points = 0
			else
				points = points - conf.skipPoints
			end
		end
		if conf.maxPoints ~= nil and points > conf.maxPoints then
			points = conf.maxPoints
		end
	end

	return { ok = ok, log = log, html = html, slog = slog, shtml = shtml, points = points }
end -- end function c_fp
-----------------------------------------------------
function c_crc(conf)
	local types =
	{
	  ["Traditional Cache"]							= "http://www.geocaching.com/images/wpttypes/sm/2.gif",
	  ["Multi-Cache"]								= "http://www.geocaching.com/images/wpttypes/sm/3.gif",
	  ["Virtual Cache"]								= "http://www.geocaching.com/images/wpttypes/sm/4.gif",
	  ["Letterbox Hybrid"]							= "http://www.geocaching.com/images/wpttypes/sm/5.gif",
	  ["Event Cache"]								= "http://www.geocaching.com/images/wpttypes/sm/6.gif",
	  ["Mystery Cache"]								= "http://www.geocaching.com/images/wpttypes/sm/8.gif",
	  ["Project A.P.E. Cache"]							= "http://www.geocaching.com/images/wpttypes/sm/9.gif",
	  ["Webcam Cache"]								= "http://www.geocaching.com/images/wpttypes/sm/11.gif",
	  ["EarthCache"]                                = "http://www.geocaching.com/images/wpttypes/sm/earthcache.gif",
	  ["Cache In Trash Out Event"]					= "http://www.geocaching.com/images/wpttypes/sm/13.gif",
	  ["Mega-Event Cache"]							= "http://www.geocaching.com/images/wpttypes/sm/mega.gif",
	  ["Giga-Event Cache"]							= "http://www.geocaching.com/images/wpttypes/sm/giga.gif",
	  ["Wherigo Cache"]								= "http://www.geocaching.com/images/wpttypes/sm/wherigo.gif",
	  ["Geocaching HQ Cache"]							= "http://www.geocaching.com/images/wpttypes/sm/3773.gif",
	  ["Benchmark"]									= "http://www.geocaching.com/images/wpttypes/sm/27.gif",
	  ["Locationless Cache"]				= "http://www.geocaching.com/images/wpttypes/sm/12.gif",
	  ["Community Celebration Event"]				= "http://www.geocaching.com/images/wpttypes/sm/3653.gif",
	  ["GPS Adventures Maze Exhibit"]				= "http://www.geocaching.com/images/wpttypes/sm/1304.gif",
	  ["Geocaching HQ Celebration"]	= "http://www.geocaching.com/images/wpttypes/sm/3774.gif",
	  ["Geocaching HQ Block Party"]					= "http://www.geocaching.com/images/wpttypes/sm/4738.gif",
	  ["GPS Adventures Maze Exhibit"]					= "http://www.geocaching.com/images/wpttypes/sm/maze.gif"
	}

	local level = conf.level
	local minNeeded = tonumber(conf.needed)			-- minimum countries/regions/counties with finds needed
	local minFinds = tonumber(conf.findsPer)		-- minimum finds per country/region/county needed
	local minTypes = tonumber(conf.typesPer)		-- minimum types per country/region/county needed
	local minTotal = tonumber(conf.findsTotal)			-- minimum total finds needed
	local ndetails = conf.list							-- list of caches
	local TExcludedTypes = {}
	local TExcludedCountries = {}
	local TExcludedRegions = {}
	local TExcludedCounties = {}
	local TExcludedGCCodes = {}
	local display = tonumber(conf.display)			-- the number of countries/regions/counties to display

	if minNeeded == nil then
	  minNeeded = 1
	end

	if minFinds == nil then
	  minFinds = 1
	end

	if minTypes == nil then
	  minTypes = 1
	end

	if minTotal == nil then
	  minTotal = 1
	end

	if level == nil then
	  level = "country"
	end

	if display == nil then
		display = minNeeded
	end
	-------------------------------------------------------------------------------------------------

	profileName = args[1]['profileName']
	profileId = args[1]['profileId']
	-- PGC.print produces debug log
	PGC.print('Got profile name, ', profileName, "\n")
	PGC.print('Got profile id ', profileId, "\n")

	--[[
	Get data for as few fields as possible to reduce memory usage.
	--]]
	fields = { 'county', 'region', 'country', 'cache_name', 'gccode', 'type', 'visitdate' }

	local filter=FilterFromConfig(conf)

	myFinds = GetCombinedFinds( profileId, { fields = fields, filter = filter, order = 'OLDESTFIRST' } )


	-- Do calculations
	levelGroups = {}
	cachecounter = 0
	local logA = {}
	local logB = {}
	local htmlA = {}
	local htmlB = {}
	local htmlC = {}
	local htmlD = {}
	local ii = 0

	table.insert(htmlA, "<table><tr><th>#</th><th>Country</th><th>Region</th><th>County</th><th>Cache</th><th>Found date</th></tr>")
	table.insert(htmlB, "<table><tr><th>#</th><th>Country</th><th>Region</th><th>County</th><th>Cache</th><th>Found date</th></tr>")

	  if conf.ExcludedTypes ~= nil then 	--make a table indexed by type
		for _,cache in ipairs(conf.ExcludedTypes) do
		  TExcludedTypes[cache] =0
		end
	  end

	  if conf.excludeCountries ~= nil then 	--make a table indexed by country
		for _,cache in ipairs(conf.excludeCountries) do
		  TExcludedCountries[cache] =0
		end
	  end

	  if conf.ExcludedRegions ~= nil then 	--make a table indexed by region
		for _,cache in ipairs(conf.ExcludedRegions) do
		  TExcludedRegions[cache] =0
		end
	  end

	  if conf.ExcludedCounties ~= nil then 	--make a table indexed by level
		for _,cache in ipairs(conf.ExcludedCounties) do
		  TExcludedCounties[cache] =0
		end
	  end

	  if conf.ExcludedGCCodes ~= nil then 	--make a table indexed by GCCode
		for _,cache in ipairs(conf.ExcludedGCCodes) do
		  TExcludedGCCodes[cache] =0
		end
	  end

	for index,cache in pairs(myFinds) do
	  if cache['region'] == nil then cache['region'] = "" end
	  if cache['county'] == nil then cache['county'] = "" end
	  if cache['type'] ~= 'Locationless Cache' then
		if TExcludedTypes[ cache['type']] == nil and cache['gccode'] ~= nil and cache['gccode'] ~= "" then
		  if level == "country" or cache['region'] ~= "" then
			if level ~= "county" or cache['county'] ~= "" then
			  if TExcludedCountries[ cache['country']] == nil and TExcludedRegions[ cache['region']] == nil and TExcludedCounties[ cache['county']] == nil and TExcludedGCCodes[ cache['gccode']] == nil then
				  --PGC.print("gc ".. cache['gccode'].." county "..cache['county']..' visitdate: '..cache['visitdate']," \n")
				  --cache['dtsum'] = tonumber(cache['difficulty'])+tonumber(cache['terrain'])
				  cachecounter = cachecounter + 1

		-- log and html: second part (total number of caches)
				  if minTotal > 1 and cachecounter <= minTotal then
					  table.insert(logB, "[b]" .. cache[level] .. "[/b]" ..
						  " [url=http://coord.info/" .. cache.gccode .. "]" .. cache.cache_name ..
						  " (" .. cache.gccode .. ")[/url]" .. " | " .. cache.visitdate)

					  table.insert(htmlB, "<tr><td>" .. cachecounter .. "</td><td>" .. cache.country .. "</td><td>" .. cache.region .. "</td><td>" .. cache.county ..
						  '</td><td><img src="' .. types[cache.type] .. '" />&nbsp;<a href=\"http://coord.info/' ..
						  cache.gccode .. '">' .. cache.cache_name .. " (" .. cache.gccode .. ")</a></td><td>" .. cache.visitdate .. "</td></tr>")
				  end

				  groupKey = cache[level]

				  groupData = levelGroups[groupKey]
				  if (groupData == nil) then -- create new data structure for level
					  groupData = {}
					  groupData["qual"] = {}
					  groupData["type"] = {}
					  groupData["find_counter"] = 0
					  levelGroups[groupKey] = groupData
				  end

				  -- enter new cache into list of caches on the visit date
				  --qualifyingCaches = groupData["qual"]
				  --qualifyingCaches[cache['gccode']] = cache
				  groupData["qual"][cache['gccode']] = cache
				  groupData["type"][cache['type']] = cache
				  groupData["find_counter"] = groupData["find_counter"] + 1
			  end
			end
		  end
		end
	  end
	end

	logB = table.concat(logB, "\n")

	local numFound = 0
	local numAll = 0
	local logdataC = ""

	for group,groupData in spairs(levelGroups, function(f,a,b) return a<b end) do
		levelFinds = groupData["find_counter"]
		qualifyingCaches = groupData["qual"]
		numAll = numAll + 1

		local typeCount = 0
		for t,c in pairs(groupData["type"]) do
			typeCount = typeCount + 1
		end

		table.insert(htmlD, "<tr><td>" .. group.."&nbsp;</td><td>"..groupData["find_counter"] .. "</td></tr>")

		if (levelFinds >= minFinds and typeCount >= minTypes) then -- minimum required finds by level
			numFound = numFound + 1
			levelOutCount = 0
			table.insert(htmlC, group..": "..groupData["find_counter"])
			for gccode,cache in pairs(qualifyingCaches) do
				levelOutCount = levelOutCount + 1

				if numFound <= display then
					table.insert(logA, "[b]" .. cache[level] .."[/b]"..
					" [url=http://coord.info/" .. cache.gccode .. "]" .. cache.cache_name ..
					" (" .. cache.gccode .. ")[/url]" .. " | " .. cache.visitdate)

					table.insert(htmlA, "<tr><td>" .. numFound .. "/".. levelOutCount .. "</td><td>" .. cache.country .. "</td><td>" .. cache.region .. "</td><td>" .. cache.county ..
					'</td><td><img src="' .. types[cache.type] .. '" />&nbsp;<a href=\"http://coord.info/' ..
					cache.gccode .. '">' .. cache.cache_name .. " (" .. cache.gccode .. ")</a></td><td>" .. cache.visitdate .. "</td></tr>")
				end

				if (levelOutCount >= minFinds) then
					break
				end
			end
		end
	end

	logA = table.concat(logA, "\n")

	local ok = false
	local html = false
	local shtml = ""

	-- Check if challenge is fulfilled and if so, set ok = true
	local log = ""
	local slog = ""

	if (numFound >= minNeeded) and (cachecounter >= minTotal) then -- minimum required countries/regions/counties found
		ok = true
	else
		ok = false
	end

		log = log .. profileName .. " has found required number of caches (" .. minFinds .. ") of the required number of types (" .. minTypes .. ") in each of " .. numFound .. " " .. plural(level) .. " (required number of " .. plural(level) .. ": " .. minNeeded .. ")."..PrintFilter(filter)
		html = profileName .. " has found required number of caches (" .. minFinds .. ") of the required number of types (" .. minTypes .. ") in each of " .. numFound .. " " .. plural(level) .. " (required number of " .. plural(level) .. ": " .. minNeeded .. ")." ..PrintFilter(filter).."<br>"
		slog = log
		shtml = html

		if ndetails == "show" then
			log = log .. "Finds in required " .. plural(level) .. " are listed here:\n\n" .. logA .. "\n"
			html = html .. "Finds in required " .. plural(level) .. " are listed here:<hr>" .. table.concat(htmlA) .. "</table>"
		elseif ndetails == "short" then
			html = html .. table.concat(htmlC,"<br>")
		end

	if minTotal > 1 then
		log = log .. "In total (respecting all sub-challenge requirements and limitations), I have found " .. cachecounter .. " caches (required minimum: " .. minTotal .. ")."..PrintFilter(filter)
		html = html .. "<hr>In total (respecting all sub-challenge requirements and limitations), " .. profileName .. " has found " .. cachecounter .. " caches (required minimum: " .. minTotal .. ")."..PrintFilter(filter).."<br>"
		slog = log
		shtml = shtml .. "In total (respecting all sub-challenge requirements and limitations), " .. profileName .. " has found " .. cachecounter .. " caches (required minimum: " .. minTotal .. ").<br>"

		if ndetails == "show" then
			log = log .. "Here is the list of " .. minTotal .. " required finds:\n\n" .. logB .. "\n"
			html = html .. "List of required " .. minTotal .. " finds is here:<hr>" .. table.concat(htmlB) .. "</table>"
		elseif ndetails == "short" then
			html = html .. table.concat(htmlC,"<br>")
		end
	end


	if ok==false then
		html = profileName .. " has found required number of caches (" .. minFinds .. ") of the required number of types (" .. minTypes .. ") in " .. numFound .. " " .. plural(level) .. " so far. Required minimum is " .. minNeeded .. " " .. plural(level) .. "."..PrintFilter(filter).."<br>"

		if ndetails == "show" then
			html = html .. "Finds in each " .. level .. " are listed here:<hr>" .. table.concat(htmlA) .. "</table><br>"
		elseif ndetails == "short" then
			html = html .. table.concat(htmlD,"<br>")
		end

		if minTotal > 1 then
			html = html .. "In total (respecting all sub-challenge requirements and limitations), you have found " .. cachecounter .. " caches. Required minimum is " .. minTotal .. " caches."..PrintFilter(filter).."<br>"
			if ndetails == "show" then
				html = html .. "List of qualified finds, regardless " .. level .. ", is here:<hr>" .. table.concat(htmlB) .. "</table>"
			end
		end

		if conf[level] then
			local htmlMissing = {}

		
				if (not levelGroups[conf[level]]) or (levelGroups[conf[level]].find_counter < minFinds) then
					if type(conf[level]=="table") then
						for _,entry in ipairs(conf[level]) do
							table.insert(htmlMissing, "<li>"..entry.."</li>")
						end
					else
						table.insert(htmlMissing, "<li>"..conf[level].."</li>")
					end
				end
			

		html = html .. "List of missing " .. plural(level) .. ":<ul>" .. table.concat(htmlMissing) .. "</ul>"
		end
	end

	local points = nil
	if ok and conf.pointsPer ~= nil then
		points = conf.pointsPer * numFound
		if conf.skipPoints ~= nil then
			if points <= conf.skipPoints then
				points = 0
			else
				points = points - conf.skipPoints
			end
		end
		if conf.maxPoints ~= nil and points > conf.maxPoints then
			points = conf.maxPoints
		end
	end

	return { ok = ok, log = log, html = html, slog = slog, shtml = shtml, points = points }
end -- end function c_crc
-----------------------------------------------------
function c_crcPC(conf)
	function plural(word)
	  if word == "country" then return "countries" end
	  if word == "county" then return "counties" end
	  return word .. "s"
	end

	local level = conf.level
	local minNeeded = tonumber(conf.needed)			-- minimum countries/regions/counties with finds needed
	local minFinds = tonumber(conf.findsPer)		-- minimum finds per country/region/county needed
	local minTotal = tonumber(conf.findsTotal)			-- minimum total finds needed
	local ndetails = conf.list							-- list of caches
	local TExcludedTypes = {}
	local TExcludedCountries = {}
	local TExcludedRegions = {}
	local TExcludedCounties = {}
	local TExcludedGCCodes = {}

	if minNeeded == nil then
	  minNeeded = 1
	end

	if minFinds == nil then
	  minFinds = 1
	end

	if minTotal == nil then
	  minTotal = 1
	end

	if level == nil then
	  level = "country"
	end
	-------------------------------------------------------------------------------------------------

	profileName = args[1]['profileName']
	profileId = args[1]['profileId']
	-- PGC.print produces debug log
	PGC.print('Got profile name, ', profileName, "\n")
	PGC.print('Got profile id ', profileId, "\n")

	--[[
	Get data for as few fields as possible to reduce memory usage.
	--]]
	fields = { 'county', 'region', 'country', 'cache_name', 'gccode', 'type', 'visitdate' }

	local filter=FilterFromConfig(conf)

	myFinds = GetCombinedFinds( profileId, { fields = fields, filter = filter, order = 'OLDESTFIRST' } )


	-- Do calculations
	cachecounter = 0
	local ii = 0

	local crc = {}

	  if conf.ExcludedTypes ~= nil then 	--make a table indexed by type
		for _,cache in ipairs(conf.ExcludedTypes) do
		  TExcludedTypes[cache] =0
		end
	  end

	  if conf.excludeCountries ~= nil then 	--make a table indexed by country
		for _,cache in ipairs(conf.excludeCountries) do
		  TExcludedCountries[cache] =0
		end
	  end

	  if conf.ExcludedRegions ~= nil then 	--make a table indexed by region
		for _,cache in ipairs(conf.ExcludedRegions) do
		  TExcludedRegions[cache] =0
		end
	  end

	  if conf.ExcludedCounties ~= nil then 	--make a table indexed by level
		for _,cache in ipairs(conf.ExcludedCounties) do
		  TExcludedCounties[cache] =0
		end
	  end

	  if conf.ExcludedGCCodes ~= nil then 	--make a table indexed by GCCode
		for _,cache in ipairs(conf.ExcludedGCCodes) do
		  TExcludedGCCodes[cache] =0
		end
	  end

	for index,cache in pairs(myFinds) do
	  if cache['region'] == nil then cache['region'] = "" end
	  if cache['county'] == nil then cache['county'] = "" end
	  if cache['type'] ~= 'Locationless Cache' then
		if TExcludedTypes[ cache['type']] == nil and cache['gccode'] ~= nil and cache['gccode'] ~= "" then
		  if level == "country" or cache['region'] ~= "" then
			if level ~= "county" or cache['county'] ~= "" then
			  if TExcludedCountries[ cache['country']] == nil and TExcludedRegions[ cache['region']] == nil and TExcludedCounties[ cache['county']] == nil and TExcludedGCCodes[ cache['gccode']] == nil then
				  --PGC.print("gc ".. cache['gccode'].." county "..cache['county']..' visitdate: '..cache['visitdate']," \n")
				  --cache['dtsum'] = tonumber(cache['difficulty'])+tonumber(cache['terrain'])
				  cachecounter = cachecounter + 1
				  if cache.region == nil then cache.region = "" end
					if crc[cache.country] == nil then
						crc[cache.country] = {}
					end
					if cache.county == nil then cache.county = "" end
						if crc[cache.country][cache.region] == nil then
							crc[cache.country][cache.region] = {}
						end
						if crc[cache.country][cache.region][cache.county] == nil then
							crc[cache.country][cache.region][cache.county] = 0
						end
						crc[cache.country][cache.region][cache.county] = crc[cache.country][cache.region][cache.county] + 1
			  end
			end
		  end
		end
	  end
	end

	numFound = 0

	for country,regions in pairs(crc) do
		local countryTotalCounties = 0
		local countryTotalRegions = 0

		for region,counties in pairs(regions) do
			local regionTotalFinds = 0
			local regionTotalCounties = 0

			for county,count in pairs(counties) do
				regionTotalFinds = regionTotalFinds + count
				if (county ~= "" and count >= minFinds) then
					regionTotalCounties = regionTotalCounties + 1
					countryTotalCounties = countryTotalCounties + 1
				end
			end

			if (region ~= "" and regionTotalFinds >= minFinds) then
				countryTotalRegions = countryTotalRegions + 1
			end

			if (conf.pcOf == "county" and level == "region") then
				local total = PGC.GetNumberOfCountiesInRegion(country, region)
				if total ~= false and regionTotalCounties >= (total * conf.pc / 100) then
					numFound = numFound + 1
				end
			end
		end

		if (conf.pcOf == "region" and level == "country") then
			local total = PGC.GetNumberOfRegionsInCountry(country)
			if total ~= false and countryTotalRegions >= (total * conf.pc / 100) then
				numFound = numFound + 1
			end
		end

		if (conf.pcOf == "county" and level == "country") then
			local total = PGC.GetNumberOfCountiesInCountry(country)
			if total ~= false and countryTotalCounties >= (total * conf.pc / 100) then
				numFound = numFound + 1
			end
		end
	end

	local ok = false
	local html = false
	local shtml = ""

	-- Check if challenge is fulfilled and if so, set ok = true
	local log = ""
	local slog = ""

	if (numFound >= minNeeded) and (cachecounter >= minTotal) then -- minimum required countries/regions/counties found
		ok = true
	else
		ok = false
	end

		log = log .. profileName .. " has found required number of caches (" .. minFinds .. ") in each of " .. numFound .. " " .. plural(level) .. " (required number of " .. plural(level) .. ": " .. minNeeded .. ")."
		html = profileName .. " has found required number of caches (" .. minFinds .. ") in each of " .. numFound .. " " .. plural(level) .. " (required number of " .. plural(level) .. ": " .. minNeeded .. ").<br>"
		slog = log
		shtml = html

	if minTotal > 1 then
		log = log .. "In total (respecting all sub-challenge requirements and limitations), I have found " .. cachecounter .. " caches (required minimum: " .. minTotal .. ")."
		html = html .. "<hr>In total (respecting all sub-challenge requirements and limitations), " .. profileName .. " has found " .. cachecounter .. " caches (required minimum: " .. minTotal .. ").<br>"
		slog = log
		shtml = shtml .. "In total (respecting all sub-challenge requirements and limitations), " .. profileName .. " has found " .. cachecounter .. " caches (required minimum: " .. minTotal .. ").<br>"

	end


	if ok==false then
		html = profileName .. " has found required number of caches (" .. minFinds .. ") in " .. numFound .. " " .. plural(level) .. " so far. Required minimum is " .. minNeeded .. " " .. plural(level) .. ".<br>"

		if minTotal > 1 then
			html = html .. "In total (respecting all sub-challenge requirements and limitations), you have found " .. cachecounter .. " caches. Required minimum is " .. minTotal .. " caches.<br>"
		end
	end

	local points = nil
	if ok and conf.pointsPer ~= nil then
		points = conf.pointsPer * numFound
		if conf.skipPoints ~= nil then
			if points <= conf.skipPoints then
				points = 0
			else
				points = points - conf.skipPoints
			end
		end
		if conf.maxPoints ~= nil and points > conf.maxPoints then
			points = conf.maxPoints
		end
	end

	return { ok = ok, log = log, html = html, slog = slog, shtml = shtml, points = points }
end -- end function c_crcPC
-----------------------------------------------------
function c_souvenir(conf)
	local log = { }
	local slog = { }
local loglist = { }
local htmllist = { }

	function copytolog(list)
		for i,line in ipairs(list) do
        table.insert(htmllist, line)
		end
	end

function logboth(string)
    table.insert(loglist, string)
    table.insert(htmllist, string)
end

	--[[
	Get data for as few fields as possible to reduce memory usage. A full list of fields can be found at http://project-gc.com/doxygen/lua-sandbox/classPGC__LUA__Sandbox.html#a8b8f58ee20469917a29dc7a7f751d9ea
	local finds = GetCombinedFinds(profileId, { fields = {'gccode', 'cache_name', 'visitdate', 'country'}, order = 'OLDESTFIRST', filter = {country = conf.country } })
	--]]

	profileSouvenirs = PGC.GetSouvenirs(profileId, { fields = fields, order = "OLDESTFIRST" })

	local souvenirCount = 0

	local log_all = { }
	local log_countries = { }
	local log_states = { }
	local log_countriesandstates = { }
	local log_uniqueevents = { }
	local log_events = { }
	local log_days = { }
local log_geotours = { }
local log_others = { }
	local ok = true
	local html = false
	local fail = false

	local exist
	local countries = 0
	local states = 0
	local uniqueevents = 0
	local events = 0
	local days = 0
local geotours = 0
local others = 0

	-- Count the user's various souvenirs.
	for _,souvenir in ipairs(profileSouvenirs) do
		if souvenir['group'] == 'country' then
			countries = countries + 1
			table.insert(log_countries, "- " .. souvenir["title"])
		end

		if souvenir['group'] == 'region' then
			states = states + 1
			table.insert(log_states, "- " .. souvenir["title"])
		end

		if souvenir['group'] == 'unique-event' then
			uniqueevents = uniqueevents + 1
			table.insert(log_uniqueevents, "- " .. souvenir["title"])
		end

		if souvenir['group'] == 'event-related' or souvenir['group'] == 'unique-event' then
			events = events + 1
			table.insert(log_events, "- " .. souvenir["title"])
		end

		if souvenir['group'] == 'specific-day' then
			days = days + 1
			table.insert(log_days, "- " .. souvenir["title"])
		end

    if souvenir['group'] == 'geotour' then
        geotours = geotours + 1
        table.insert(log_geotours, "- " .. souvenir["title"])
    end

    if souvenir['group'] == 'other' then
        others = others + 1
        table.insert(log_others, "- " .. souvenir["title"])
    end

    table.insert(log_all, souvenir["date_discovered"] .. ": " .. souvenir["title"])

		souvenirCount = souvenirCount + 1
	end

	-- Test number of souvenirs in total.
	if conf.count ~= nil then
    logboth("Number of souvenirs: "  .. souvenirCount .. " (" .. conf.count .. " required)")
		if souvenirCount < conf.count then
			fail = true
		end
	end

	-- Test number of country souvenirs.
	if conf.countries ~= nil then
    logboth("Number of country souvenirs: " .. countries .. " (" .. conf.countries .. " required)")
		copytolog(log_countries)
		if countries < conf.countries then
			fail = true
		end
	end

	-- Test number of state souvenirs.
	if conf.states ~= nil then
    logboth("Number of region souvenirs: " .. states .. " (" .. conf.states .. " required)")
		copytolog(log_states)
		if states < conf.states then
			fail = true
		end
	end

	-- Test number of country and state souvenirs.
	if conf.countriesandstates ~= nil then
    logboth("Number of country and region souvenirs: " .. countries+states .. " (" .. conf.countriesandstates .. " required)")
		copytolog(log_countries)
		copytolog(log_states)
		if countries+states < conf.countriesandstates then
			fail = true
		end
	end

	-- Test number of unique-event souvenirs.
	if conf.uniqueevents ~= nil then
    logboth("Number of unique-event souvenirs: " .. uniqueevents .. " (" .. conf.uniqueevents .. " required)")
		copytolog(log_uniqueevents)
		if uniqueevents < conf.uniqueevents then
			fail = true
		end
	end

	-- Test number of event souvenirs.
	if conf.events ~= nil then
    if conf.dontincludeuniques then
        logboth("Number of event-related souvenirs: "  .. events-uniqueevents .. " (" .. conf.events .. " required)")
    else
        logboth("Number of event-related souvenirs: "  .. events .. " (" .. conf.events .. " required)")
    end
		copytolog(log_events)
		if events < conf.events then
			fail = true
		end
	end

	-- Test number of special day souvenirs.
	if conf.days ~= nil then
    logboth("Number of specific-day souvenirs: "  .. days .. " (" .. conf.days .. " required)")
		copytolog(log_days)
		if days < conf.days then
			fail = true
		end
	end

-- Test number of GeoTour souvenirs.
if conf.geotours ~= nil then
    logboth("Number of GeoTour souvenirs: "  .. geotours .. " (" .. conf.geotours .. " required)")
    copytolog(log_geotours)
    if geotours < conf.geotours then
        fail = true
    end
end


-- Test number of other souvenirs.
if conf.others ~= nil then
    logboth("Number of other souvenirs: "  .. others .. " (" .. conf.others .. " required)")
    copytolog(log_others)
    if others < conf.others then
        fail = true
    end
end

	if fail == true then
		ok = false
	else
		ok = true
	end

	PGC.print("All souvenirs:\n" .. table.concat(log_all, "\n"))

if souvenirCount == 0 then
    logboth("This user has 0 souvenirs. This is not entirely impossible, but if this is not the expected number the reason is probably that the user has changed a setting on https://www.geocaching.com/account/settings/userprivacy#about so that not everyone can see their souvenirs. This setting needs to be changed for checkers to work as expected.")
end

	local html = table.concat(htmllist, "<br>")
	log = table.concat(loglist, "\n")
	local shtml = table.concat(htmllist, "<br>")
	slog = table.concat(loglist, "\n")

	local points = nil
	if ok and conf.pointsPer ~= nil then
		points = conf.pointsPer * souvenirCount
		if conf.skipPoints ~= nil then
			if points <= conf.skipPoints then
				points = 0
			else
				points = points - conf.skipPoints
			end
		end
		if conf.maxPoints ~= nil and points > conf.maxPoints then
			points = conf.maxPoints
		end
	end

	return { ok = ok, log = log, html = html, slog = slog, shtml = shtml, points = points }
end -- end function c_souvenir
-----------------------------------------------------
function c_tb(conf)
	local tb = PGC.GetNumTrackablesDiscovered(profileId)
	PGC.print(tb)


	local log = {}

	local fail=false
	local lok=false


	--  [trackablesDiscovered] => 759
	--     [coinsDiscovered]
	if conf.trackablesDiscovered~= nil then
		if tonumber(tb.trackablesDiscovered)>=conf.trackablesDiscovered then
			lok=true
			table.insert(log,"You made it with "..tb.trackablesDiscovered..
		  " trackables dicovered and you only needed "..conf.trackablesDiscovered)
		else
			fail=true
		 table.insert(log,"You did not make it. You have only discovered "..tb.trackablesDiscovered..
		  " trackables and you needed "..conf.trackablesDiscovered)

		end
	end
	if conf.travelbugsDiscovered~= nil then
		if tonumber(tb.travelbugsDiscovered)>=conf.travelbugsDiscovered then
			lok=true
		table.insert(log,"You made it with "..tb.travelbugsDiscovered..
		  " travelbugs dicovered and you only needed "..conf.travelbugsDiscovered)
		else
			fail=true
			 table.insert(log,"You did not make it. You have only discovered "..tb.travelbugsDiscovered..
		  " travelbugs and you needed "..conf.travelbugsDiscovered)
		end
	end

	if conf.coinsDiscovered~= nil then
		if tonumber(tb.coinsDiscovered)>=conf.coinsDiscovered then
			lok=true
		table.insert(log,"You made it with "..tb.coinsDiscovered..
		  " coins dicovered and you only needed "..conf.coinsDiscovered)
		else
			fail=true
			 table.insert(log,"You did not make it. You have only discovered "..tb.coinsDiscovered..
		  " coins and you needed "..conf.coinsDiscovered)
		end
	end


	local ok=false

	if lok==true and fail==false then
	  ok=true
	end

	local html = table.concat(log, "<br>")
	log = table.concat(log, "\n")
	local shtml = html
	local slog = log

	local points = nil
	if ok and conf.pointsPer ~= nil then
		points = conf.pointsPer * souvenirCount
		if conf.skipPoints ~= nil then
			if points <= conf.skipPoints then
				points = 0
			else
				points = points - conf.skipPoints
			end
		end
		if conf.maxPoints ~= nil and points > conf.maxPoints then
			points = conf.maxPoints
		end
	end

	return { ok = ok, log = log, html = html, slog = slog, shtml = shtml, points = points }
end -- end function c_tb
-----------------------------------------------------
function c_regex(conf)
	local fields = {'gccode', 'cache_name', 'visitdate', 'country'}
	table.insert(fields,conf.alphafield)

	local limit = 1
	if conf.limit ~= nil then
		limit = conf.limit
	end

	local filter=FilterFromConfig(conf)

	local finds = GetCombinedFinds( profileId, { fields = fields, filter = filter, order = 'OLDESTFIRST' } )

	local ok_caches={}
	-- Do calculations
	for _,f in ipairs(finds) do
		local value=f[conf.alphafield]
		if conf.toUpper then
			value=PGC.UTF8ToUpper(value)
		end
		local match_value=string.match(value,conf.regex)
		if match_value~=nil and (conf.blacklist==nil or conf.blacklist[f.gccode] ==nil) then
			table.insert(ok_caches,f)
		end
	end
	local ok = false
	local log = {}
	local html = {}

	local sublog=""
	if #ok_caches>=limit then
		ok=true
		sublog="You made it with "..#ok_caches.." of "..limit.." needed matches"
	else
		sublog="You did not make it. You only had "..#ok_caches.." of the "..limit.." needed matches"
	end
	table.insert(log,sublog)
	table.insert(html,sublog)

	local shtml = sublog
	local slog = sublog

	if #ok_caches>limit then
		sublog="Only the needed caches are printed"
		table.insert(log,sublog)
		table.insert(html,sublog)
	end
	table.insert(html,"<table>")
	table.insert(log,"")
	local clog={}
	local hlog={}
	table.insert(clog,string.format("    %-7s","GCcode "))
	table.insert(hlog,"GC code")
	if conf.alphafield~="gccode" and conf.alphafield~="cache_name" then
		table.insert(clog,conf.alphafield)
		table.insert(hlog,conf.alphafield)
	end
	table.insert(clog,"Name")
	table.insert(hlog,"Name")
	table.insert(log,table.concat(clog, " "))
	table.insert(html,"<tr><th>"..table.concat(hlog, "</th><th>").."</th></tr>")

	local printnr=0
	for i,f in ipairs(ok_caches) do
		local clog={}
		local hlog={}
		printnr=printnr+1
		if printnr<=limit then
		table.insert(clog,string.format("    %-7s",f.gccode))
		table.insert(hlog,f.gccode)
		if conf.alphafield~="gccode" and conf.alphafield~="cache_name" then
			table.insert(clog,f[conf.alphafield])
			table.insert(hlog,f[conf.alphafield])
		end
		table.insert(clog,f.cache_name)
		table.insert(hlog,f.cache_name)

		table.insert(log,table.concat(clog, " "))
		table.insert(html,"<tr><td>"..table.concat(hlog, "</td><td>").."</td></tr>")
		end
	end
	table.insert(html,"</table>")
	--table.insert(log,"[/code]")


	html= table.concat(html, "<br/>")
	log = table.concat(log, "\n")

	local points = nil
	if ok and conf.pointsPer ~= nil then
		points = conf.pointsPer * #ok_caches
		if conf.skipPoints ~= nil then
			if points <= conf.skipPoints then
				points = 0
			else
				points = points - conf.skipPoints
			end
		end
		if conf.maxPoints ~= nil and points > conf.maxPoints then
			points = conf.maxPoints
		end
	end

	return { ok = ok, log = log, html = html, slog = slog, shtml = shtml, points = points }
end -- end function c_regex
-----------------------------------------------------
function c_sliding(conf)
	function DateDiff(a, b)
	  if(a ~= nil and b ~= nil) then
		local iso = Date.Format("yyyy-mm-dd")
		local d1 = iso:parse(a)
		local d2 = iso:parse(b)

		local diffDays = round((d2.time-d1.time)/86400)
		diffDays=math.abs(diffDays)
		return diffDays
	  end
	  return nil
	end
	function round(num, idp)
	  local mult = 10^(idp or 0)
	  return math.floor(num * mult + 0.5) / mult
	end

	local conf_nr=0
	for _,v in pairs(conf) do
	  conf_nr=conf_nr+1
	end
	if conf_nr==0 then
	  return{ ok={},log={},html={},slog={},shtml={}}
	end
	local country=conf.country
	local region=conf.region
	local county=conf.county
	local types=conf.types
	local days=conf.days
	local limit=conf.limit
	local dailymin=conf.dailymin
	local dailymintypes=conf.dailymintypes
	local mintypes=conf.mintypes
	local continuous=true
	if limit ~=nil then
		continuous=false
	end

	local filter=FilterFromConfig(conf)
	filter['minVisitDate']=conf.after
	local fields = {'gccode', 'cache_name', 'visitdate', 'country', 'type'}

	local findsPerDate={}
	--[[
	Get data for as few fields as possible to reduce memory usage. A full list of fields can be found at http://project-gc.com/doxygen/lua-sandbox/classPGC__LUA__Sandbox.html#a8b8f58ee20469917a29dc7a7f751d9ea
	local finds = PGC.GetFinds(profileId, { fields = {'gccode', 'cache_name', 'visitdate', 'country'}, order = 'OLDESTFIRST', filter = {country = conf.country } })
	--]]

	local findDay={}
	--[[
	findDay['date']="1990-01-01"
	findDay['finds']=0
	findDay['types']={}
	findDay['typeNr']=0
	]]--
	local daynr=0;
	local daylast="1990-01-01"
	PGC.print(filter)
	local myFinds = GetCombinedFinds( profileId, { fields = fields, filter = filter, order = 'OLDESTFIRST' } )
	for _,v in ipairs(myFinds) do
		if  v['visitdate']~=daylast then
			daynr=daynr+1
			findDay={}
			findDay['date']=v['visitdate']
			findDay['finds']=1
			findDay['types']={}
			findDay['types'][v['type']]=1
			findDay['typeNr']=1
			findsPerDate[daynr]=findDay
			daylast=v['visitdate']
		else
			findsPerDate[daynr]['finds']=findsPerDate[daynr]['finds']+1
			if findsPerDate[daynr]['types'][v['type']]==nil then
				findsPerDate[daynr]['types'][v['type']]=1
				findDay['typeNr']=findDay['typeNr']+1
			else
				findsPerDate[daynr]['types'][v['type']]=findsPerDate[daynr]['types'][v['type']]+1
			end
		end
	end
	-- En extra för nästa framtiden
	findDay={}
	local d = Date {}
	d:add { day = 1 }
	local dprint = Date.Format("yyyy-mm-dd")
	findDay['date']=dprint:tostring(d)
	findDay['finds']=0
	findDay['types']={}
	findDay['typeNr']=0
	findsPerDate[#findsPerDate+1]=findDay

	function tablenr(a)
	  local count=0
	  for _,_ in pairs(a) do
		count=count+1
	  end
	  return count
	end
	for i=1,table.maxn(findsPerDate),1 do
		--local d=DateDiff(findsPerDate[i]['date'],findsPerDate[i-1]['date'])
		PGC.print(findsPerDate[i]['date']," ",findsPerDate[i]['finds'],"\n")
	end

	-- Do calculations
	local ok = false
	local oklog={}
	local html={}

	local slog = ""
	local shtml = ""

	for i=1,table.maxn(findsPerDate),1 do
		local lastDiff=1
		--nollställer varable med denna dag som start
		local sum=findsPerDate[i]['finds']
		local min=findsPerDate[i]['finds']
		local minTypes=findsPerDate[i]['typeNr']
		local types={}
		local tmplog={}
		local score=0
		for k,v in pairs(findsPerDate[i].types) do
			if types[k]== nil then
				types[k]=v
			else
				types[k]=types[k]+v
			end
		end
		--PGC.print(findsPerDate[i]['date']," : ",findsPerDate[i]['finds']," \n")
		local diff
		--local okDiff=1
		for j=i+1,table.maxn(findsPerDate),1 do

			diff=DateDiff(findsPerDate[i]['date'],findsPerDate[j]['date'])+1
			--PGC.print(diff," ",findsPerDate[i]['date']," ",findsPerDate[j]['date'],"\n")
			--nolla per dag om dag överhoppad
			if diff>lastDiff+1 and lastDiff+1<=days then
				--PGC.print("dag missad ",findsPerDate[i]['date']," ",findsPerDate[j]['date']," ",lastDiff," ", diff,"\n")
				minTypes=0
				min=0
			end

			if diff>days then
				break
			end
			lastDiff=diff
			--okDiff=diff
			--nextDay=okDiff+1
			sum=sum+findsPerDate[j]['finds']
			--PGC.print(findsPerDate[j]['date']," ",min," : ",findsPerDate[j]['finds']," : |",math.min(min,findsPerDate[j]['finds']),"| Diff:",diff,"\n")
			min=math.min(min,findsPerDate[j]['finds'])

			minTypes=math.min(minTypes,findsPerDate[j]['typeNr'])
			for k,v in pairs(findsPerDate[j].types) do
				if types[k]== nil then
					types[k]=v
				else
					types[k]=types[k]+v
				end
			end
			--slut om alla dagar är kollade
			if diff+1>days then
				break
			end
		end
		--PGC.print("start:",findsPerDate[i]['date']," antal dagar:",nextDay," summa loggade:")
		--PGC.print(sum," min per dag:"..min.." min tyes per day"..minTypes.." olika typer "..tablenr(types).."\n")
		-- kolla om kraven är uppfylda
		local lok=false
		local lfail=false
		--if nextDay<=days then
		local window_size=lastDiff
		if window_size==nil then
		  window_size=0
		end
		table.insert(tmplog,"Starting "..findsPerDate[i]['date']  .." and during the next "..window_size.." days")
		if limit~= nil then
		  if sum >=limit then
			lok=true
			table.insert(tmplog,"I had "..sum.." finds and needed only "..limit)
		   else
			lfail=true
			table.insert(tmplog,"I had only "..sum.." finds and needed "..limit)
		   end

			--break
		end
		if mintypes~= nil then
			if tablenr(types) >=mintypes  then
				lok=true
				table.insert(tmplog,"I found "..tablenr(types).." different types and needed only "..mintypes)
			else
				lfail=true
				table.insert(tmplog,"I found only "..tablenr(types).." different types and needed "..mintypes)
			end
		end
		if dailymin~=nil then
		  if dailymin<=min  and window_size==days then
			lok=true
			table.insert(tmplog,"I found a minimum of "..min.." finds each day and needed only "..dailymin.." each day")
		  else
			lfail=true
			table.insert(tmplog,"I found a minimum of only "..min.." find each day and needed "..dailymin.." each day")
		  end

		end
		if dailymintypes~=nil then
		  if dailymintypes<=minTypes and window_size==days then
			 lok=true
			table.insert(tmplog,"I found a minimum of "..minTypes.." differnt types each day and needed only "..dailymintypes.." each day")
		 else
			lfail=true
			table.insert(tmplog,"I found a minimum of only "..minTypes.." differnt types each day and needed "..dailymintypes.." each day")
		  end
		end
		if lok==true and lfail==false then
		  ok=true
		  oklog=tmplog
		  break
		end

		--end
	end

	local log = ""
	html ="Unfortunately no useful best or current data is printed in this checker.<br>"
			.."The problem is that it is hard to define a best result with different check parameters.<br>"
			.."A current result is hard to because for example which day should the current 365 days windows start?"
			.." 365 days ago is not that useful to if you what to log 1000 caches in 365 days. And what is the correct start?. 365 lines out output is a bit much.<br>"
			.."A quick looks at the challenges that uses this checker I conclude that it is quite easy to use for example map compare to find your current status and I will not spend my time on that<br> "
	shtml = "No matching sliding window found."

	-- Check if challenge is fulfilled and if so, set ok = true
	-- ok = true

	if ok == true then
		-- Produce example log, Project-GC recommends using bbcode if it's useful.
		-- Do not use  log = log .. "foo"  in loops with many iterations, it consumes a lot of memory in LUA.
		--log="I had a "..okType.." of "..okValue.." starting "..okDayStart.." and during the next "..okDays.." Days\n"
		log=table.concat(oklog,"\n")
		html=table.concat(oklog,"<br>")
		slog = log
		shtml = html
	end

	local points = nil
	if ok and conf.pointsPer ~= nil then
		points = conf.pointsPer * #ok_caches
		if conf.skipPoints ~= nil then
			if points <= conf.skipPoints then
				points = 0
			else
				points = points - conf.skipPoints
			end
		end
		if conf.maxPoints ~= nil and points > conf.maxPoints then
			points = conf.maxPoints
		end
	end

	return { ok = ok, log = log, html = html, slog = slog, shtml = shtml, points = points }
end -- end function c_sliding
-----------------------------------------------------
function c_words(conf)
	local ok = false
	local log = ""
	local html = {}

	local qualifyingCaches = {}
	local stringFound = {}
	local numQualifying = 0
	local qualifyingTypes = {}
	local numTypes = 0
	local stringsToFind = {}
	local found = {}

	local numRequired = conf.num
	local stringsProvided = conf.words
	local singleWord = conf.word
	local wholeWordOnly = conf.whole_word
	local maxFindsForEachWord = conf.max_per_word

	local lowerCacheName

	local requiredTypes = conf.num_types
	if (requiredTypes == nil) then requiredTypes = 0 end

	local types =
	{
	  ["Traditional Cache"]            = "http://www.geocaching.com/images/wpttypes/sm/2.gif",
	  ["Multi-Cache"]                  = "http://www.geocaching.com/images/wpttypes/sm/3.gif",
	  ["Virtual Cache"]                = "http://www.geocaching.com/images/wpttypes/sm/4.gif",
	  ["Letterbox Hybrid"]             = "http://www.geocaching.com/images/wpttypes/sm/5.gif",
	  ["Event Cache"]                  = "http://www.geocaching.com/images/wpttypes/sm/6.gif",
	  ["Mystery Cache"]                = "http://www.geocaching.com/images/wpttypes/sm/8.gif",
	  ["Project A.P.E. Cache"]            = "http://www.geocaching.com/images/wpttypes/sm/9.gif",
	  ["Webcam Cache"]                 = "http://www.geocaching.com/images/wpttypes/sm/11.gif",
	  ["EarthCache"]                   = "http://www.geocaching.com/images/wpttypes/sm/earthcache.gif",
	  ["Cache In Trash Out Event"]     = "http://www.geocaching.com/images/wpttypes/sm/13.gif",
	  ["Mega-Event Cache"]             = "http://www.geocaching.com/images/wpttypes/sm/mega.gif",
	  ["Giga-Event Cache"]             = "http://www.geocaching.com/images/wpttypes/sm/giga.gif",
	  ["Wherigo Cache"]                = "http://www.geocaching.com/images/wpttypes/sm/wherigo.gif",
	  ["Geocaching HQ Cache"]               = "http://www.geocaching.com/images/wpttypes/sm/3773.gif",
	  ["Benchmark"]	                   = "http://www.geocaching.com/images/wpttypes/sm/27.gif",
	  ["Locationless Cache"] = "http://www.geocaching.com/images/wpttypes/sm/12.gif",
	  ["10 Years! Event Cache"]        = "http://www.geocaching.com/images/wpttypes/sm/3653.gif",
	  ["GPS Adventures Maze Exhibit"]  = "http://www.geocaching.com/images/wpttypes/sm/1304.gif",
	  ["Community Celebration Event"]   = "http://www.geocaching.com/images/wpttypes/sm/3653.gif",
	  ["Geocaching HQ Block Party"]      = "http://www.geocaching.com/images/wpttypes/sm/4738.gif",
	  ["GPS Adventures Maze Exhibit"]       = "http://www.geocaching.com/images/wpttypes/sm/maze.gif"
	}

	---------------------------------------
	-- Returns the length of a utf8 string.
	---------------------------------------
	function UTF8_StringLen(string)
	  local char
	  local length = 0
	  local byteVal
	  local i = 1

	  while true do
		-- Loop until we find a byte that is not a "start" byte for a Unicode character
		char = string.sub(string, i, i)
		i = i + 1

		if char == "" then return length end

		byteVal = string.byte(char)
		if byteVal > 191 or byteVal < 127 then
		  length = length + 1
		end
	  end
	end
	---------------------------------------
	---------------------------------------

	local filter=FilterFromConfig(conf)
	if (conf.type ~= nil) then filter.types = { conf.type } end
	if (conf.start_date ~= nil) then filter.minVisitDate = conf.start_date end
	if (conf.end_date ~= nil) then filter.maxVisitDate = conf.end_date end
	local fields = {'gccode', 'cache_name', 'visitdate', 'owner_id', 'type'}

	if (stringsProvided == nil) then stringsProvided = { singleWord } end
	if (wholeWordOnly == nil) then wholeWordOnly = false end

	-- Get the user's finds
	local finds = GetCombinedFinds( profileId, { fields = fields, filter = filter, order = 'OLDESTFIRST' } )

	-- Look for "special" regex characters in the stringsToFind, and escape them
	for index,string in pairs(stringsProvided) do
	  local regexString = string.gsub(string, "([^%a%d])", "%%%1")
	  if (wholeWordOnly) then
		regexString = "%f[%a%d]" .. regexString .. "%f[^%a%d]"
	  end

	  stringsToFind[regexString] = UTF8_StringLen(string)
	  if (maxFindsForEachWord ~= nil) then found[regexString] = 0 end
	end

	for index, cache in ipairs(finds) do
	  lowerCacheName = PGC.UTF8ToLower(cache.cache_name)
	  for stringToFind,length in pairs(stringsToFind) do
		-- If we've already found the maximum allowed of this word, don't continue.
		if (maxFindsForEachWord == nil or found[stringToFind] < maxFindsForEachWord) then
		  if (string.find(lowerCacheName, PGC.UTF8ToLower(stringToFind))) then
			numQualifying = numQualifying + 1
			qualifyingCaches[numQualifying] = index
			stringFound[numQualifying] = stringToFind

			if (maxFindsForEachWord ~= nil) then found[stringToFind] = found[stringToFind] + 1 end

			-- Check if we already have a qualifying cache of this type.  If not, add its type to the list of qualifying types.
			local foundType = false
			for i,type in ipairs(qualifyingTypes) do
			  if (type == cache.type) then foundType = true end
			end
			if (foundType == false) then
			  numTypes = numTypes + 1
			  qualifyingTypes[numTypes] = cache.type
			end
			break
		  end
		end
	  end
	end

	ok = numQualifying >= numRequired and numTypes >= requiredTypes

	-- Generate the sample log
	if(ok == true) then
	  log = {}

	  table.insert(log, "Here are my qualifying caches:\n")

	  for index,cacheIndex in ipairs(qualifyingCaches) do

		if (index > numRequired) then break end -- Only print the required number of caches to the log
		local cache = finds[cacheIndex]
		local wordIndex = string.find(PGC.UTF8ToLower(cache.cache_name), PGC.UTF8ToLower(stringFound[index]))
		local stringLength = stringsToFind[stringFound[index]]

		local highlightedCacheName = PGC.UTF8SubStr(cache.cache_name, 1, wordIndex - 1) .. "**" .. PGC.UTF8SubStr(cache.cache_name, wordIndex, stringLength) .. "**" .. PGC.UTF8SubStr(cache.cache_name, wordIndex + stringLength, UTF8_StringLen(cache.cache_name) - (wordIndex + stringLength - 1))
		table.insert(log, "**" .. index .. "**: [" .. highlightedCacheName .. " (" .. cache.gccode .. ")](http://coord.info/" .. cache.gccode .. ") by [" .. PGC.ProfileId2Name(cache.owner_id) .. "](http://www.geocaching.com/profile/?id=" .. cache.owner_id .. "), found " .. cache.visitdate .. "  (" .. cache.type .. ")")
	  end
	  log = table.concat(log, "\n")
	end

	-- Generate the HTML message to the user
	local location = " in "
	if (conf.region ~= nil) then location = location .. conf.region end
	if (conf.region ~= nil and conf.country ~= nil) then location = location .. ", " end
	if (conf.country ~= nil) then location = location .. conf.country end
	if (conf.country == nil and conf.region == nil) then location = "" end

	local typeString = ""
	if (conf.type ~= nil) then typeString = ' of type "' .. conf.type .. '"' end

	local displayString
	if (conf.word ~= nil) then displayString = '"' .. conf.word .. '"'
	else displayString = "the specified words"
	end

	table.insert(html, profileName .. " has found " .. numQualifying .. " out of " .. numRequired .. ' required caches' .. location .. typeString .. ' with ' .. displayString .. ' in the name.')
	local shtml = table.concat(html)
	local slog = shtml
	if (ok == true) then
	  table.insert(html, '<BR /><BR />Congratulations!  You qualify for this challenge cache!<br />You can copy the text in the box above and paste it into your "Found" log if you wish (only the first ' .. numRequired .. ' caches are printed to the log).<br /><br />  Here are your qualifying caches:<br /><br />')
	elseif (numQualifying >= numRequired) then
	  table.insert(html, "<BR />You have enough qualifying caches, but they only have " .. numTypes .. " of the " .. requiredTypes .. " cache types required to qualify.<BR /><BR />")
	else
	  table.insert(html, "<BR />You need <b>" .. numRequired - numQualifying .. "</b> more caches to qualify.<BR /><BR />")
	end

	table.insert(html, "<table><tr><th>Number</th><th>Cache</th><th>Owner</th><th>Found date</th></tr>")

	for index, cacheIndex in pairs(qualifyingCaches) do
	  local cache = finds[cacheIndex]
	  local stringLength = stringsToFind[stringFound[index]]
	  local wordIndex = string.find(PGC.UTF8ToLower(cache.cache_name), PGC.UTF8ToLower(stringFound[index]))
	  -- The above ignores UTF8 characters, and will give an incorrect position when the string contains multi-byte characters.
	  -- To resolve this, get the substring up to the location found above, and find its UTF8 length.
	  wordIndex = UTF8_StringLen(string.sub(cache.cache_name, 1, wordIndex))
	PGC.print ("WordIndex for '" .. cache.cache_name .. "':  " .. wordIndex .. "\n")

	  PGC.print("--------------StringLength = " .. stringLength .. " (" .. stringFound[index] .. ")\n")

	  local highlightedCacheName = PGC.UTF8SubStr(cache.cache_name, 1, wordIndex - 1) .. "<b style='color:red'>" .. PGC.UTF8SubStr(cache.cache_name, wordIndex, stringLength) .. "</b>" .. PGC.UTF8SubStr(cache.cache_name, wordIndex + stringLength, UTF8_StringLen(cache.cache_name) - (wordIndex + stringLength - 1))
	  table.insert(html, "<tr><td><b>" .. index .. '</b></td><td><img src="' .. types[cache.type] .. '" />&nbsp;<a href=\"http://coord.info/' .. cache.gccode .. '">' .. highlightedCacheName .. " (" .. cache.gccode .. ")</a></td><td><a href=\"http://www.geocaching.com/profile/?id=" .. cache.owner_id .. '">' .. PGC.ProfileId2Name(cache.owner_id) .. "</a></td><td>" .. cache.visitdate .. "</td></tr>")
	end

	html = table.concat(html)

	local points = nil
	if ok and conf.pointsPer ~= nil then
		points = conf.pointsPer * #ok_caches
		if conf.skipPoints ~= nil then
			if points <= conf.skipPoints then
				points = 0
			else
				points = points - conf.skipPoints
			end
		end
		if conf.maxPoints ~= nil and points > conf.maxPoints then
			points = conf.maxPoints
		end
	end

	return { ok = ok, log = log, html = html, slog = slog, shtml = shtml, points = points }
end -- end function c_words
-----------------------------------------------------
function c_distance(conf)
	function GetCacheValue(cache, key)
		local res
		if (key == "dt") then
			res = cache['difficulty'].."/"..cache['terrain']
		elseif (key == "dtsum") then
			res = ToNumeric(cache['difficulty'])+ToNumeric(cache['terrain'])
		elseif (key == "date") then
			res = string.sub(cache['visitdate'],6)
		elseif (key == "day") then
			res = cache['visitdate']
		elseif (key == "month") then
			res = string.sub(cache['visitdate'],1,7)
		elseif (key == "month any year") then
			res = string.sub(cache['visitdate'],6,7)
		elseif (key == "year") then
			res = string.sub(cache['visitdate'],1,4)
		end
		return res
	end

	period=conf.period

	local filter={}
	filter['country'] = conf.country
	filter['region'] = conf.region
	filter['county'] = conf.county
	filter['minVisitDate'] = conf.minVisitDate

	filter['types'] = conf.types
	filter['sizes'] = conf.sizes
	filter['difficulties'] = conf.difficulties
	filter['terrains'] = conf.terrains

	function distance(x)
	  if (conf.miles) then
		return x*0.62137
	  end
	  return x
	end

	function showdistance(x)
	  if (conf.miles) then
		return (x*0.62137).." miles"
	  end
	  return x.." km"
	end

	local ignoreListI = PGC.GetBookmarklist( "BMAFMJR", {} )
	local ignoreList={}
	for i,c in ipairs(ignoreListI) do
		ignoreList[c]=c
	end

	--PGC.print(ignoreList)
	-- Get data for as few fields as possible to reduce memory usage. A full list of fields can be found at http://project-gc.com/doxygen/lua-sandbox/classPGC__LUA__Sandbox.html#a8b8f58ee20469917a29dc7a7f751d9ea
	local myFinds = GetCombinedFinds(profileId, { fields = {'gccode','type', 'cache_name', 'visitdate', 'country','difficulty','terrain','latitude','longitude'}, order = 'OLDESTFIRST', filter = filter })


	local caches={}
	--dela upp i lämpliga grupper
	for _,c in ipairs(myFinds) do
		if c.type ~="Locationless Cache"  and   (conf.ignoreBookmark~=true or  ignoreList[c.gccode]==nil )then
		if (period == "day" or period == "date" or period == "month" or period == "year"or period == "month any year") then 
			groupKey = GetCacheValue(c, period)
		else
			groupKey = '<all>'
		end
		if caches[groupKey]==nil then
			caches[groupKey]={}
			caches[groupKey].caches={}
			caches[groupKey].caches_nr=0
			caches[groupKey].dtsum=0
			caches[groupKey].types={}
			caches[groupKey].types_nr=0
			caches[groupKey].distance=0
		end
		table.insert(caches[groupKey].caches,c)
		caches[groupKey].caches_nr=caches[groupKey].caches_nr+1
		local dtsum=tonumber(c['difficulty'])+tonumber(c['terrain'])
		c['dtsum']=dtsum
		caches[groupKey].dtsum=caches[groupKey].dtsum+dtsum
		if tonumber(c['latitude'])~= nil then
		if caches[groupKey].latitude~= nil and caches[groupKey].longitude~= nil then
			caches[groupKey].distance=caches[groupKey].distance+PGC.DistanceHaversine(caches[groupKey].latitude,   caches[groupKey].longitude,tonumber(c['latitude']),      tonumber(c['longitude']))/1000
		end
		caches[groupKey].latitude=tonumber(c['latitude'])
		caches[groupKey].longitude=tonumber(c['longitude'])

		--PGC.print(caches[groupKey].distance,"\n")
		end
		end
	end

	local ok = false
	local okCaches={}
	okCaches.distance=0
	for a,l in pairs(caches) do
	  --Lägga in koll på mer än limit
	  if l.distance>okCaches.distance then 
		if conf.maxdistance == nil or (conf.maxdistance ~= nil and l.distance<conf.maxdistance) then
		  okCaches=l
		  if l.distance>=tonumber(conf.distance) then
			ok=true
		  end
		end
	  end
	end

	local comptype="caches"
	if conf.dt=="sum" then
		comptype="DT points"
	end

	local log = {}
	local html ={}
	local slog = {}
	local shtml ={}

	-- Do calculations

	local nr = okCaches.distance

	local header_end=""
	if conf.period~=nil then
		header_end=" in a "..conf.period
	end  
	local loops=nr/conf.distance
	loops=string.format("%.2f",loops)
	local dist=string.format("%.3f",nr)

	if ok then
		local tmplog="I made it with a distance of "..showdistance(dist).." and I only needed "..showdistance(conf.distance).." "..header_end
		slog = tmplog
		shtml = tmplog
		table.insert(log,tmplog)
		table.insert(html,tmplog.."<br>")
		local tmplog="This is "..loops.." times the required distance"
		table.insert(log,tmplog)
		table.insert(html,tmplog.."<br>")
		
	else
		local tmplog="I <b> didn't</b> make it with a distance of only "..showdistance(dist).." and I needed "..showdistance(conf.distance).." "..header_end
		slog = tmplog
		shtml = tmplog
		table.insert(log,tmplog)
		table.insert(html,tmplog.."<br>")
		local tmplog="This is only "..loops.." times the required distance"
		table.insert(log,tmplog)
		table.insert(html,tmplog.."<br>")

	end
	if conf.ignoreBookmark==true then
			local tmplog="Caches excluded from groundspeek statistics are excluded"
			table.insert(log,tmplog)
			table.insert(html,tmplog.."<br>")
	else
		local tmplog="Caches excluded from groundspeek statistics are <b>not</b> excluded"
			table.insert(log,tmplog)
			table.insert(html,tmplog.."<br>")
	end

	local tmplog="If a non Premium member uses the checker all premium caches will be excluded from the calculation because of licence issues"
	table.insert(log,tmplog)
	table.insert(html,tmplog.."<br>")


	log = table.concat(log, "\n")
	html = table.concat(html, "<br/>")

	local points = nil
	if ok and conf.pointsPer ~= nil then
		points = conf.pointsPer * #ok_caches
		if conf.skipPoints ~= nil then
			if points <= conf.skipPoints then
				points = 0
			else
				points = points - conf.skipPoints
			end
		end
		if conf.maxPoints ~= nil and points > conf.maxPoints then
			points = conf.maxPoints
		end
	end

	return { ok = ok, log = log, html = html, slog = slog, shtml = shtml, points = points }
end -- end function c_distance
-----------------------------------------------------
-- At least n caches of specific cachetypes by hampf
function c_types(conf)
	function comp(a,b)
	  return a[1]<b[1]
	end

	local thresholds=conf.thresholds

	local fields={'type'}

	local filter={}
	filter['country'] = conf.country
	filter['region'] = conf.region
	filter['county'] = conf.county
	filter['minVisitDate'] = conf.minVisitDate

	filter['types'] = conf.types
	filter['sizes'] = conf.sizes
	filter['difficulties'] = conf.difficulties
	filter['terrains'] = conf.terrains
	
	local finds = GetCombinedFinds(profileId, { fields = fields, order = 'OLDESTFIRST', filter = filter })

	local types={}

	for _,f in ipairs(finds) do
	  if types[f['type']]==nil then types[f['type']]=0 end
	  types[f['type']] = types[f['type']]+1
	end

	local sorted={}
	for i,j in pairs(types) do
	  table.insert(sorted,{j, i})
	end
	table.sort(sorted,comp)

	local sortedThresholds={}
	for _,t in pairs(thresholds) do
	  table.insert(sortedThresholds, t)
	end
	table.sort(sortedThresholds)

	local ok=true
	local i=1
	local j=1
	local checked={}

	while ok==true and i<=table.maxn(sorted) and j<=table.maxn(sortedThresholds) do
	  if tonumber(sorted[i][1])>=tonumber(sortedThresholds[j]) then
		table.insert(checked,{sortedThresholds[j], sorted[i][1], sorted[i][2]})
		j=j+1
	  end
	  i=i+1
	  if i>table.maxn(sorted) and j<=table.maxn(sortedThresholds) then ok=false end
	end

	local log = false
	local html = false

	local slog = log
	local shtml = html

	if(ok == true) then
	  log = {"Qualified:"}
	  slog = {}
	  for i,c in ipairs(checked) do
		table.insert(log, "Step "..i.." ("..c[1].."): "..c[2].." "..c[3].."s")
		table.insert(slog, c[1])
	  end
	  html = table.concat(log, "<br/>")
	  log = table.concat(log, "\n")
	  shtml = "Qualified: "..table.concat(slog, ",")
	  slog = shtml
	else
	  html = {"Not Qualified:"}
	  slog = {}
	  for i,c in ipairs(sorted) do
		table.insert(html, ""..c[1].." "..c[2].."s")
		table.insert(slog, c[1])
	  end
	  log = table.concat(html, "\n")
	  html = table.concat(html, "<br/>")
	  shtml = "Not Qualified: "..table.concat(slog, ",")
	  slog = shtml
	end

	local points = nil
	if ok and conf.pointsPer ~= nil then
		points = conf.pointsPer * #ok_caches
		if conf.skipPoints ~= nil then
			if points <= conf.skipPoints then
				points = 0
			else
				points = points - conf.skipPoints
			end
		end
		if conf.maxPoints ~= nil and points > conf.maxPoints then
			points = conf.maxPoints
		end
	end

	return { ok = ok, log = log, html = html, slog = slog, shtml = shtml, points = points }
end -- end function c_types
-----------------------------------------------------

function l_at_least(arg,filter,opt)
    --PGC.print("arg:",arg)
    local res={}
    local count=0
    local ok_count=0
    local maybe_count=0
    local req_count=opt.req
    local l_arg=TableCopy(arg)
    for i,t in pairs(l_arg) do
		if opt ~= nil and opt.func ~= nil and t.func == nil then
			t.func = opt.func
		end
		if opt ~= nil and opt.conf ~= nil then
			for n,v in pairs(opt.conf) do
				if t.conf[n] == nil then
					t.conf[n] = v
				end
			end
		end
      if t.func~= nil then
      count=count+1
      --PGC.print("i:",i," t",t,"\n")
      if filter~= nil then
        for k,v in pairs(filter) do
            t.conf[k]=v
          end
        end
      local tmp=lookup(t.func,t.conf,filter,t.opt)
      --PGC.print(tmp)
      if count==1 then
        if tmp.ok==true then
              ok_count=ok_count+1
        elseif tmp.ok=="maybe" then
              maybe_count=maybe_count+1
            end
      res.log=tmp.log
      res.html=tmp.html
        res.slog=tmp.slog
        res.shtml="<tbody><tr><td>"..ok_html(tmp.ok).."</td><td>"..tmp.shtml.."</td></tr>"
      else
        if tmp.ok==true then
              ok_count=ok_count+1
        elseif tmp.ok=="maybe" then
              maybe_count=maybe_count+1
            end
      res.log=res.log..tmp.log
      res.html=res.html.."<br>"..tmp.html
        res.slog=res.slog..tmp.slog
        res.shtml=res.shtml.."<tr><td>"..ok_html(tmp.ok).."</td><td>"..tmp.shtml.."</td></tr>"
      end
    end
    end
    if ok_count>=req_count then
      res.ok=true
    elseif ok_count+maybe_count>=req_count then
      res.ok="maybe"
    else
      res.ok=false
    end

    res.shtml='<table border="1"><thead><tr><th>'..ok_html(res.ok)..'</th><th>At-least '..req_count..' of '..count..'</th></tr></thead>'
              ..res.shtml.."</tbody></table>"
    res.slog=ok_text(res.ok)..": at-least "..req_count..' of '..count.." {\n"..res.slog.."}\n"
	return res
end -- end l_atleast
-----------------------------------------------------
function l_and(arg,filter,opt)
    --PGC.print("and arg:",arg)
    local res={}
    local count=0
    local l_arg=TableCopy(arg)
    for _,t in pairs(l_arg) do
		if opt ~= nil and opt.func ~= nil and t.func == nil then
			t.func = opt.func
		end
		if opt ~= nil and opt.conf ~= nil then
			for n,v in pairs(opt.conf) do
				if t.conf[n] == nil then
					t.conf[n] = v
				end
			end
		end
      if t.func~= nil then
      count=count+1
      if filter~= nil then
        for k,v in pairs(filter) do
            t.conf[k]=v
          end
        end
      --PGC.print("t.conf",t.conf)
      local tmp=lookup(t.func,t.conf,filter,t.opt)
      if count==1 then
        res.ok=tmp.ok
      res.log=tmp.log
      res.html=tmp.html
        res.slog=tmp.slog
        res.shtml="<tbody><tr><td>"..ok_html(tmp.ok).."</td><td>"..tmp.shtml.."</td></tr>"
      else
        if res.ok == "maybe" then
			if tmp.ok == false then res.ok = false else res.ok = "maybe" end
        elseif tmp.ok == "maybe" then
			if res.ok == false then res.ok = false else res.ok = "maybe" end
        elseif res.ok == "info" then
			res.ok = tmp.ok
        elseif tmp.ok ~= "info" then
			res.ok=res.ok and tmp.ok
		end
      res.log=res.log..tmp.log
      res.html=res.html.."<br>"..tmp.html
        res.slog=res.slog..tmp.slog
        res.shtml=res.shtml.."<tr><td>"..ok_html(tmp.ok).."</td><td>"..tmp.shtml.."</td></tr>"
      end
      end
    end
    res.shtml='<table border="1"><thead><tr><th>'..ok_html(res.ok)..'</th><th>AND</th></tr></thead>'
              ..res.shtml.."</tbody></table>"
    res.slog=ok_text(res.ok)..": AND{\n"..res.slog.."}\n"
	return res
end --end function l_and
-----------------------------------------------------
function l_or(arg,filter,opt)
      local res={}
    local count=0
    local l_arg=TableCopy(arg)
    for _,t in pairs(l_arg) do
		if opt ~= nil and opt.func ~= nil and t.func == nil then
			t.func = opt.func
		end
		if opt ~= nil and opt.conf ~= nil then
			for n,v in pairs(opt.conf) do
				if t.conf[n] == nil then
					t.conf[n] = v
				end
			end
		end
      if t.func~= nil then
      count=count+1
      if filter~= nil then
        for k,v in pairs(filter) do
            t.conf[k]=v
          end
        end
      local tmp=lookup(t.func,t.conf,filter,t.opt)
      --PGC.print(tmp)
      if count==1 then
        res.ok= tmp.ok
      res.log=tmp.log
      res.html=tmp.html
        res.slog=tmp.slog
        res.shtml="<tbody><tr><td>"..ok_html(tmp.ok).."</td><td>"..tmp.shtml.."</td></tr>"
      else
        if res.ok == "maybe" then
			if tmp.ok == true then res.ok = true else res.ok = "maybe" end
        elseif tmp.ok == "maybe" then
			if res.ok == true then res.ok = true else res.ok = "maybe" end
        elseif res.ok == "info" then
			res.ok = tmp.ok
        elseif tmp.ok ~= "info" then
			res.ok=res.ok or tmp.ok
		end
      res.log=res.log..tmp.log
      res.html=res.html.."<br>"..tmp.html
        res.slog=res.slog..tmp.slog
        res.shtml=res.shtml.."<tr><td>"..ok_html(tmp.ok).."</td><td>"..tmp.shtml.."</td></tr>"
      end
        end
    end
    res.shtml='<table border="1"><thead><tr><th>'..ok_html(res.ok)..'</th><th>OR</th></tr></thead>'
              ..res.shtml.."</tbody></table>"
    res.slog=ok_text(res.ok)..": OR{\n"..res.slog.."}\n"
	return res
end --end function l_or
-----------------------------------------------------
function l_in_a_year(arg,filter,opt)
    -- Detect years with finds

	local includeLabCaches = false
	if conf.includeLabCaches ~= nil then includeLabCaches = conf.includeLabCaches end

    local l_filter=TableCopy(filter)
    if l_filter==nil then
      l_filter={}
    end
    local logic_func="and"
  	local logic_opt={}
  	PGC.print("l_filter",l_filter,"\n")

    local y_filter=TableCopy(l_filter)
    PGC.print("y_filter",y_filter,"\n")
  	if opt ~= nil then
    	if opt.year_filter~= nil then
      		for k,v in pairs(opt.year_filter) do
	        	y_filter[k]=TableCopy(v)
    		end
    	end
    	if opt.logic_func~= nil then
      		logic_func=opt.logic_func
      	end
    	if opt.logic_func~= nil then
      		logic_opt=opt.logic_opt
      	end

    end
    PGC.print("y_filter",y_filter,"\n")
  local finds = GetCombinedFinds(profileId, { fields = {'visitdate'}, order = 'OLDESTFIRST', filter = y_filter, includeLabCaches = includeLabCaches })
    local find_years={}
    for _,c in ipairs(finds) do
      local y=string.sub(c.visitdate,1,4)
      find_years[y]=y
    end
    PGC.print("find_years",find_years,"\n")
    local res={ok=false ,log="", html="", slog="",shtml=""}
    local count=0
    for year in spairs(find_years, function(f,a,b) return a>b end) do
      PGC.print(year,"\n")
      count=count+1
      local minVisitDate =year.."-01-01"
    local maxVisitDate=year.."-12-31"

    if l_filter==nil then
          l_filter={}
        end
      l_filter.minVisitDate=minVisitDate
      l_filter.maxVisitDate=maxVisitDate
      local tmp=lookup(logic_func,arg,l_filter,logic_opt)
      --PGC.print(tmp)
      if count==1 then
        res.ok= tmp.ok
      res.log=tmp.log
      res.html=tmp.html
        res.slog=tmp.slog
        res.shtml="<tbody><tr><td>"..ok_html(tmp.ok).."</td><td>"..tmp.shtml.."</td></tr>"
      else
        if res.ok == "maybe" then
			if tmp.ok == true then res.ok = true else res.ok = "maybe" end
        elseif tmp.ok == "maybe" then
			if res.ok == true then res.ok = true else res.ok = "maybe" end
        elseif res.ok == "info" then
			res.ok = tmp.ok
        elseif tmp.ok ~= "info" then
			res.ok=res.ok or tmp.ok
		end
      res.log=res.log..tmp.log
      res.html=res.html.."<br>"..tmp.html
        res.slog=res.slog..tmp.slog
        res.shtml=res.shtml.."<tr><td>"..ok_html(tmp.ok).."</td><td>"..tmp.shtml.."</td></tr>"
      end
    end
    if count==0 then
      res.shtml="<tbody><tr><td>"..ok_html(false).."</td><td>".."No in pre_check found" .."</td></tr>"
    end
    res.shtml='<table border="1"><thead><tr><th>'..ok_html(res.ok)..'</th><th>in_a_year:pre_check:only years with found in :'..PrintFilter(y_filter)..'are checked</th></tr></thead>'
              ..res.shtml.."</tbody></table>"
    res.slog=ok_text(res.ok)..": in_a_year{\n"..res.slog.."}\n"

	return res
end --end function l_in_a_year
-----------------------------------------------------
function l_in_a_hidden_year(arg,filter,opt)
    -- Detect years with finds

	local includeLabCaches = false
	if conf.includeLabCaches ~= nil then includeLabCaches = conf.includeLabCaches end

    local l_filter=TableCopy(filter)
    if l_filter==nil then
      l_filter={}
    end
    local logic_func="and"
  	local logic_opt={}
  	PGC.print("l_filter",l_filter,"\n")

    local y_filter=TableCopy(l_filter)
    PGC.print("y_filter",y_filter,"\n")
  	if opt ~= nil then
    	if opt.year_filter~= nil then
      		for k,v in pairs(opt.year_filter) do
	        	y_filter[k]=TableCopy(v)
    		end
    	end
    	if opt.logic_func~= nil then
      		logic_func=opt.logic_func
      	end
    	if opt.logic_func~= nil then
      		logic_opt=opt.logic_opt
      	end

    end
    PGC.print("y_filter",y_filter,"\n")
  local finds = GetCombinedFinds(profileId, { fields = {'hidden'}, order = 'OLDESTFIRST', filter = y_filter, includeLabCaches = includeLabCaches })
    local find_years={}
    for _,c in ipairs(finds) do
      local y=string.sub(c.hidden,1,4)
      find_years[y]=y
    end
    PGC.print("find_years",find_years,"\n")
    local res={ok=false ,log="", html="", slog="",shtml=""}
    local count=0
    for year in spairs(find_years, function(f,a,b) return a>b end) do
      PGC.print(year,"\n")
      count=count+1
      local minHiddenDate =year.."-01-01"
    local maxHiddenDate=year.."-12-31"

    if l_filter==nil then
          l_filter={}
        end
      l_filter.minHiddenDate=minHiddenDate
      l_filter.maxHiddenDate=maxHiddenDate
      local tmp=lookup(logic_func,arg,l_filter,logic_opt)
      --PGC.print(tmp)
      if count==1 then
        res.ok= tmp.ok
      res.log=tmp.log
      res.html=tmp.html
        res.slog=tmp.slog
        res.shtml="<tbody><tr><td>"..ok_html(tmp.ok).."</td><td>"..tmp.shtml.."</td></tr>"
      else
        if res.ok == "maybe" then
			if tmp.ok == true then res.ok = true else res.ok = "maybe" end
        elseif tmp.ok == "maybe" then
			if res.ok == true then res.ok = true else res.ok = "maybe" end
        elseif res.ok == "info" then
			res.ok = tmp.ok
        elseif tmp.ok ~= "info" then
			res.ok=res.ok or tmp.ok
		end
      res.log=res.log..tmp.log
      res.html=res.html.."<br>"..tmp.html
        res.slog=res.slog..tmp.slog
        res.shtml=res.shtml.."<tr><td>"..ok_html(tmp.ok).."</td><td>"..tmp.shtml.."</td></tr>"
      end
    end
    if count==0 then
      res.shtml="<tbody><tr><td>"..ok_html(false).."</td><td>".."No in pre_check found" .."</td></tr>"
    end
    res.shtml='<table border="1"><thead><tr><th>'..ok_html(res.ok)..'</th><th>in_a_year:pre_check:only years with found in :'..PrintFilter(y_filter)..'are checked</th></tr></thead>'
              ..res.shtml.."</tbody></table>"
    res.slog=ok_text(res.ok)..": in_a_year{\n"..res.slog.."}\n"

	return res
end --end function l_in_a_year
-----------------------------------------------------
function l_points(arg,filter,opt)
    --PGC.print("and arg:",arg)
    local res={}
    local count=0
    local l_arg=TableCopy(arg)
	local points_total=0
	local maybe_points=0
	local req_points_total = opt.points_total
	res.ok=false
	local thousands_separator = ","
	if opt.thousands_separator ~= nil then
		thousands_separator = opt.thousands_separator
	end
	local prefix = ""
	if opt.prefix ~= nil then
		prefix = opt.prefix
	end
	local postfix = ""
	if opt.postfix ~= nil then
		postfix = opt.postfix
	end

	function points(i,o)
		if o.ok == true then
			if i.points ~= nil then
				return i.points
			elseif o.points ~= nil then
				return o.points
			else
				return 1
			end
		else
			return 0
		end
	end

	function printPoints(p,res)
		if res.ok == "info" then
			return ""
		elseif p < 10000 then
			return prefix .. p .. postfix
		else
			local pp = {}
			while p >= 1000 do
				tmp = math.floor(p / 1000)
				r = p - (tmp * 1000)
				hun = math.floor(r/100)
				ten = math.floor((r-(hun*100))/10)
				one = r - (hun*100) - (ten*10)
				rStr = hun .. ten .. one
				table.insert(pp,1,rStr)
				p = tmp
			end
			table.insert(pp,1,p)
			return prefix .. table.concat(pp,thousands_separator) .. postfix
		end
	end

    for _,t in pairs(l_arg) do
		if opt ~= nil and opt.func ~= nil and t.func == nil then
			t.func = opt.func
		end
		if opt ~= nil and opt.conf ~= nil then
			for n,v in pairs(opt.conf) do
				if t.conf[n] == nil then
					t.conf[n] = v
				end
			end
		end
      if t.func~= nil then
      count=count+1
      if filter~= nil then
        for k,v in pairs(filter) do
            t.conf[k]=v
          end
        end
      --PGC.print("t.conf",t.conf)
      local tmp=lookup(t.func,t.conf,filter,t.opt)
	  if tmp.log == nil then tmp.log = "" end
	  if tmp.html == nil then tmp.html = "" end
	  if tmp.slog == nil then tmp.slog = "" end
	  if tmp.shtml == nil then tmp.shtml = "" end
      if count==1 then
      res.log=tmp.log
      res.html=tmp.html
        res.slog=printPoints(points(t,tmp),tmp)..": "..tmp.slog
        res.shtml="<tbody><tr><td>"..printPoints(points(t,tmp),tmp).."</td><td>"..tmp.shtml.."</td></tr>"
		points_total = points(t,tmp)
      else
      res.log=res.log.."\n"..tmp.log
      res.html=res.html.."<br>"..tmp.html
        res.slog=res.slog.."\n"..printPoints(points(t,tmp),tmp)..": "..tmp.slog
        res.shtml=res.shtml.."<tr><td>"..printPoints(points(t,tmp),tmp).."</td><td>"..tmp.shtml.."</td></tr>"
		points_total = points_total + points(t,tmp)
      end

	  if tmp.ok == "maybe" then
		if t.points ~= nil then
			maybe_points = maybe_points + t.points
		elseif tmp.points ~= nil then
			maybe_points = maybe_points + tmp.points
		else
			maybe_points = maybe_points + 1
		end
	  end
      end
    end
	if points_total >= req_points_total then
		res.ok = true
	elseif points_total + maybe_points >= req_points_total then
		res.ok = "maybe"
	end
		if opt.skipPoints ~= nil then
			if points_total <= opt.skipPoints then
				points_total = 0
			else
				points_total = points_total - opt.skipPoints
			end
		end
	if opt.maxPoints ~= nil and points_total > opt.maxPoints then
		points_total = opt.maxPoints
	end
	res.points = points_total
	if opt.points ~= nil then res.points = opt.points end
    res.shtml='<table border="1"><thead><tr><th>'..printPoints(points_total,res)..'</th><th>POINTS</th></tr></thead>'
              ..res.shtml.."</tbody></table>"
    res.slog=ok_text(res.ok)..": POINTS ("..printPoints(points_total,res).."){\n"..res.slog.."\n}"
	return res
end --end function l_points
-----------------------------------------------------
function l_bingo(arg,filter,opt)
    local res={}
    local count=0
    local l_arg=TableCopy(arg)
	res.ok=false
	res.patterns={}
	local results = {}
	local minPatterns = 1
	if opt ~= nil and opt.minPatterns ~= nil then minPatterns = opt.minPatterns end

    for _,t in pairs(l_arg) do
		if opt ~= nil and opt.func ~= nil and t.func == nil then
			t.func = opt.func
		end
		if opt ~= nil and opt.conf ~= nil then
			for n,v in pairs(opt.conf) do
				if t.conf[n] == nil then
					t.conf[n] = v
				end
			end
		end
      if t.func~= nil then
		  count=count+1
		  if filter~= nil then
			for k,v in pairs(filter) do
				t.conf[k]=v
			  end
			end
		  --PGC.print("t.conf",t.conf)
		  local tmp=lookup(t.func,t.conf,filter,t.opt)
		  if count==1 then
		  res.log=tmp.log
		  res.html=t.name..":<br>"..tmp.html
			res.slog=tmp.slog
			res.shtml="<tbody><tr><td>"..t.name.."</td><td>"..ok_html(tmp.ok).."</td><td>"..tmp.shtml.."</td></tr>"
		  else
		  res.log=res.log..tmp.log
		  res.html=res.html.."<br>"..t.name..":<br>"..tmp.html
			res.slog=res.slog..tmp.slog
			res.shtml=res.shtml.."<tr><td>"..t.name.."</td><td>"..ok_html(tmp.ok).."</td><td>"..tmp.shtml.."</td></tr>"
		  end
		  results[t.name]=tmp
      end
    end
	local patterns_matched = 0
	local patterns_maybe = 0
	for _,p in pairs(opt.patterns) do
		local pattern_matched = true
		for c in p:gmatch"[%z\1-\127\194-\244][\128-\191]*" do
PGC.print("c:",c)
if (results[c] == nil) then
	results[c] = {["ok"]=false}
end
			if pattern_matched == "maybe" then
				if results[c].ok == false then pattern_matched = false else pattern_matched = "maybe" end
			elseif results[c].ok == "maybe" then
				if pattern_matched == false then pattern_matched = false else pattern_matched = "maybe" end
			else
				pattern_matched=pattern_matched and results[c].ok
			end
			--pattern_matched = pattern_matched and results[c].ok
		end
		if pattern_matched == true then
			patterns_matched = patterns_matched + 1
			table.insert(res.patterns,p)
		elseif pattern_matched == "maybe" then
			patterns_maybe = patterns_maybe + 1
			table.insert(res.patterns,"??"..p)
		end
	end
	if patterns_matched >= minPatterns then
		res.ok = true
	elseif patterns_matched + patterns_maybe >= minPatterns then
		res.ok = "maybe"
	end
	local rows_required = ""
	if minPatterns > 1 then rows_required = " ("..minPatterns.." required)" end
    res.shtml='<table border="1"><thead><tr><th>'..table.concat(res.patterns,'<br/>')..'</th><th>'..ok_html(res.ok)..'</th><th>BINGO'..rows_required..'</th></tr></thead>'
              ..res.shtml.."</tbody></table>"
    res.slog=ok_text(res.ok)..": BINGO{\n"..res.slog.."}\n"
	return res
end --end function l_bingo
-----------------------------------------------------
function l_years(arg,filter,opt)
    local res={}
    local count=0
    local ok_count=0
    local maybe_count=0
    local req_count=opt.req
    local l_arg=TableCopy(arg)

	if filter == nil then filter = {} end

	local minHiddenDate = "2000-05-01"
	if opt.minHiddenDate ~= nil then minHiddenDate = opt.minHiddenDate end
	local minYear = tonumber(string.sub(minHiddenDate,1,4))
	local maxHiddenDate = Date.Format("yyyy-mm-dd"):tostring(Date())
	if opt.maxHiddenDate ~= nil then maxHiddenDate = opt.maxHiddenDate end
	local maxYear = tonumber(string.sub(maxHiddenDate,1,4))

	for year = minYear,maxYear do
		local minHD = ""..year.."-01-01"
		if year == minYear then minHD = minHiddenDate end
		local maxHD = ""..year.."-12-31"
		if year == maxYear then maxHD = maxHiddenDate end

		  count=count+1
		local t_arg = {}
		local t_filter = {}
		  if arg~= nil then
			for k,v in pairs(arg) do
				t_arg[k]=v
			  end
			end
		  if filter~= nil then
			for k,v in pairs(filter) do
				t_arg[k]=v
				t_filter[k]=v
			  end
			end
			t_arg["minHiddenDate"]=minHD
			t_arg["maxHiddenDate"]=maxHD
			t_filter["minHiddenDate"]=minHD
			t_filter["maxHiddenDate"]=maxHD
		  --PGC.print("t.conf",t.conf)
		  local tmp=lookup("and",t_arg,t_filter,{})
		  if count==1 then
			  if tmp.ok == true then
				ok_count = 1
			  elseif tmp.ok == "maybe" then
				maybe_count = 1
			  end
			  res.log=tmp.log
			  res.html=tmp.html
				res.slog=tmp.slog
				res.shtml="<tbody><tr><td>"..year.."</td><td>"..ok_html(tmp.ok).."</td><td>"..tmp.shtml.."</td></tr>"
		  else
			  if tmp.ok == true then
				ok_count = ok_count + 1
			  elseif tmp.ok == "maybe" then
				maybe_count = maybe_count + 1
			  end
			  res.log=res.log..tmp.log
			  res.html=res.html.."<br>"..tmp.html
				res.slog=res.slog..tmp.slog
				res.shtml=res.shtml.."<tr><td>"..year.."</td><td>"..ok_html(tmp.ok).."</td><td>"..tmp.shtml.."</td></tr>"
		  end
	end
    if ok_count>=req_count then
      res.ok=true
    elseif ok_count+maybe_count>=req_count then
      res.ok="maybe"
    else
      res.ok=false
    end

    res.shtml='<table border="1"><thead><tr><th></th><th>'..ok_html(res.ok)..'</th><th>At least '..req_count..' years of '..count..'</th></tr></thead>'
              ..res.shtml.."</tbody></table>"
    res.slog=ok_text(res.ok)..": at-least "..req_count..' of '..count.." {\n"..res.slog.."}\n"
	return res -- end function l_years
end
-----------------------------------------------------
function l_sameCRC(arg,filter,opt)
    local res={}
	res.ok = false
    local count=0
	local maybeCount = 0
	local level = opt.level
	local limit = opt.limit
	local showAll = false
	if opt.showAll ~= nil then
		showAll = opt.showAll
	end
	if limit == nil then
		limit = 1
	end
	local areas = findsInCountry
	if level == "region" then
		areas = findsInRegion
	elseif level == "county" then
		areas = findsInCounty
	end
	for area,_ in spairs(areas) do
		local t=TableCopy(arg)
		if opt ~= nil and opt.func ~= nil and t.func == nil then
			t.func = opt.func
		end
		if opt ~= nil and opt.conf ~= nil then
			for n,v in pairs(opt.conf) do
				if t.conf[n] == nil then
					t.conf[n] = v
				end
			end
		end
		if t.opt == nil then
			t.opt = {}
			t.opt.conf = {}
		end
		t.opt.conf.country = matchingCountries[area]
		if level == "region" then
			t.opt.conf.region = matchingRegions[area]
		elseif level == "county" then
			t.opt.conf.region = matchingRegions[area]
			t.opt.conf.county = matchingCounties[area]
		end
	  if t.func~= nil then
		  if filter~= nil then
			for k,v in pairs(filter) do
				t.conf[k]=v
			  end
			end
		  --PGC.print("t.conf",t.conf)
		  local tmp=lookup(t.func,t.conf,filter,t.opt)
		  if tmp.ok == true then
			  count=count+1
			  if (count + maybeCount)==1 then
				  res.log=tmp.log
				  res.html=area.."<br>"..tmp.html
					res.slog=tmp.slog
					res.shtml="<tr><td>"..ok_html(tmp.ok).."</td><td>"..area.."</td><td>"..tmp.shtml.."</td></tr>"
			  else
				  res.log=res.log..tmp.log
				  res.html=res.html.."<br>"..area.."<br>"..tmp.html
					res.slog=res.slog..tmp.slog
					res.shtml=res.shtml.."<tr><td>"..ok_html(tmp.ok).."</td><td>"..area.."</td><td>"..tmp.shtml.."</td></tr>"
			  end
		  elseif tmp.ok == "maybe" then
			  maybeCount=maybeCount+1
			  if (count + maybeCount)==1 then
				  res.log=tmp.log
				  res.html=area.."<br>"..tmp.html
					res.slog=tmp.slog
					res.shtml="<tr><td>"..ok_html(tmp.ok).."</td><td>"..area.."</td><td>"..tmp.shtml.."</td></tr>"
			  else
				  res.log=res.log..tmp.log
				  res.html=res.html.."<br>"..area.."<br>"..tmp.html
					res.slog=res.slog..tmp.slog
					res.shtml=res.shtml.."<tr><td>"..ok_html(tmp.ok).."</td><td>"..area.."</td><td>"..tmp.shtml.."</td></tr>"
			  end
		  elseif showAll then
			  maybeCount=maybeCount+1
			  if (count + maybeCount)==1 then
				  res.log=tmp.log
				  res.html=area.."<br>"..tmp.html
					res.slog=tmp.slog
					res.shtml="<tr><td>"..ok_html(tmp.ok).."</td><td>"..area.."</td><td>"..tmp.shtml.."</td></tr>"
			  else
				  res.log=res.log..tmp.log
				  res.html=res.html.."<br>"..area.."<br>"..tmp.html
					res.slog=res.slog..tmp.slog
					res.shtml=res.shtml.."<tr><td>"..ok_html(tmp.ok).."</td><td>"..area.."</td><td>"..tmp.shtml.."</td></tr>"
			  end
		  end
	  end
	end
	if count == 0 and showAll ~= true then
		  res.log="No matching "..plural(level).." found"
		  res.html=res.log
			res.slog=res.log
			res.shtml="<tr><td>"..ok_html(false).."</td><td></td><td>"..res.log.."</td></tr>"
	elseif count == 0 then
		  res.log="No matching "..plural(level).." found"..res.log
		  res.html="No matching "..plural(level).." found<br>"..res.html
			res.slog="No matching "..plural(level).." found"
			res.shtml="<tr><td>"..ok_html(false).."</td><td></td><td>No matching "..plural(level).." found</td></tr>"
	end
	if count >= limit then
		res.ok = true
		res.shtml = "<tr><td></td><td></td><td>"..count.." "..plural(level).." found out of a needed "..limit.."</td></tr>"..res.shtml
	elseif (count + maybeCount) >= limit then
		res.ok = "maybe"
		res.shtml = "<tr><td></td><td></td><td>"..count.." "..plural(level).." found and "..maybeCount.." possibly found out of a needed "..limit.."</td></tr>"..res.shtml
	end
    res.shtml='<table border="1"><thead><tr><th>'..ok_html(res.ok)..'</th><th>'..level..'</th><th>Results</th></tr></thead><tbody>'
              ..res.shtml.."</tbody></table>"
    res.slog=ok_text(res.ok)..": same "..level.."{\n"..count.." "..plural(level).." found out of a needed "..limit.."\n"..res.slog.."}\n"
	return res
end --end function l_sameCRC
-----------------------------------------------------
function l_same(arg,filter,opt)
    local res={}
	res.ok = false
    local count=0
	local maybeCount = 0
	local limit = opt.limit
	local showAll = false
	if opt.showAll ~= nil then
		showAll = opt.showAll
	end
	if limit == nil then
		limit = 1
	end
	if filter == nil then
		filter = {}
	end
	
	local fieldVals = {}
	local finds = GetCombinedFinds(profileId, { fields = {opt.field}, order = 'OLDESTFIRST', filter = filter })
	for _,f in pairs(finds) do
		fieldVals[f[opt.field]] = 1
	end
	
	for fieldVal,_ in spairs(fieldVals) do
		local t=TableCopy(arg)
		if opt ~= nil and opt.func ~= nil and t.func == nil then
			t.func = opt.func
		end
		if opt ~= nil and opt.conf ~= nil then
			for n,v in pairs(opt.conf) do
				if t.conf[n] == nil then
					t.conf[n] = v
				end
			end
		end
		if t.opt == nil then
			t.opt = {}
			t.opt.conf = {}
		end
		t.opt.conf[opt.field] = fieldVal
	  if t.func~= nil then
		  if filter~= nil then
			for k,v in pairs(filter) do
				t.conf[k]=v
			  end
			end
		  --PGC.print("t.conf",t.conf)
		  local tmp=lookup(t.func,t.conf,filter,t.opt)
		  if tmp.ok == true then
			  count=count+1
			  if (count + maybeCount)==1 then
				  res.log=tmp.log
				  res.html=fieldVal.."<br>"..tmp.html
					res.slog=tmp.slog
					res.shtml="<tr><td>"..ok_html(tmp.ok).."</td><td>"..fieldVal.."</td><td>"..tmp.shtml.."</td></tr>"
			  else
				  res.log=res.log..tmp.log
				  res.html=res.html.."<br>"..fieldVal.."<br>"..tmp.html
					res.slog=res.slog..tmp.slog
					res.shtml=res.shtml.."<tr><td>"..ok_html(tmp.ok).."</td><td>"..fieldVal.."</td><td>"..tmp.shtml.."</td></tr>"
			  end
		  elseif tmp.ok == "maybe" then
			  maybeCount=maybeCount+1
			  if (count + maybeCount)==1 then
				  res.log=tmp.log
				  res.html=fieldVal.."<br>"..tmp.html
					res.slog=tmp.slog
					res.shtml="<tr><td>"..ok_html(tmp.ok).."</td><td>"..fieldVal.."</td><td>"..tmp.shtml.."</td></tr>"
			  else
				  res.log=res.log..tmp.log
				  res.html=res.html.."<br>"..fieldVal.."<br>"..tmp.html
					res.slog=res.slog..tmp.slog
					res.shtml=res.shtml.."<tr><td>"..ok_html(tmp.ok).."</td><td>"..fieldVal.."</td><td>"..tmp.shtml.."</td></tr>"
			  end
		  elseif showAll then
			  maybeCount=maybeCount+1
			  if (count + maybeCount)==1 then
				  res.log=tmp.log
				  res.html=fieldVal.."<br>"..tmp.html
					res.slog=tmp.slog
					res.shtml="<tr><td>"..ok_html(tmp.ok).."</td><td>"..fieldVal.."</td><td>"..tmp.shtml.."</td></tr>"
			  else
				  res.log=res.log..tmp.log
				  res.html=res.html.."<br>"..fieldVal.."<br>"..tmp.html
					res.slog=res.slog..tmp.slog
					res.shtml=res.shtml.."<tr><td>"..ok_html(tmp.ok).."</td><td>"..fieldVal.."</td><td>"..tmp.shtml.."</td></tr>"
			  end
		  end
	  end
	end
	if count == 0 and showAll ~= true then
		  res.log="No matching "..opt.field.." found"
		  res.html=res.log
			res.slog=res.log
			res.shtml="<tr><td>"..ok_html(false).."</td><td></td><td>"..res.log.."</td></tr>"
	elseif count == 0 then
		if res.log == nil then res.log = "" end
		if res.html == nil then res.html = "" end
		  res.log="No matching "..opt.field.." found"..res.log
		  res.html="No matching "..opt.field.." found<br>"..res.html
			res.slog="No matching "..opt.field.." found"
			res.shtml="<tr><td>"..ok_html(false).."</td><td></td><td>No matching "..opt.field.." found</td></tr>"
	end
	if count >= limit then
		res.ok = true
		res.shtml = "<tr><td></td><td></td><td>"..count.." "..opt.field.." found out of a needed "..limit.."</td></tr>"..res.shtml
	elseif (count + maybeCount) >= limit then
		res.ok = "maybe"
		res.shtml = "<tr><td></td><td></td><td>"..count.." "..opt.field.." found and "..maybeCount.." possibly found out of a needed "..limit.."</td></tr>"..res.shtml
	end
    res.shtml='<table border="1"><thead><tr><th>'..ok_html(res.ok)..'</th><th>'..opt.field..'</th><th>Results</th></tr></thead><tbody>'
              ..res.shtml.."</tbody></table>"
    res.slog=ok_text(res.ok)..": same "..opt.field.."{\n"..count.." "..opt.field.." found out of a needed "..limit.."\n"..res.slog.."}\n"
	return res
end --end function l_same
-----------------------------------------------------
function lookup(f,arg,filter,opt)
  local res=nil
  if f=="or"  then
    res=l_or(arg,filter,opt)
  elseif f=="and"  then
    res=l_and(arg,filter,opt)
  elseif f=="points"  then
    res=l_points(arg,filter,opt)
  elseif f=="at_least"  then
    res=l_at_least(arg,filter,opt)
   elseif f=="in_a_year"  then
    res=l_in_a_year(arg,filter,opt)
   elseif f=="in_a_hidden_year"  then
    res=l_in_a_hidden_year(arg,filter,opt)
   elseif f=="bingo"  then
    res=l_bingo(arg,filter,opt)
   elseif f=="years"  then
    res=l_years(arg,filter,opt)
   elseif f=="sameCRC"  then
    res=l_sameCRC(arg,filter,opt)
   elseif f=="same"  then
    res=l_same(arg,filter,opt)

  elseif f=="number" then
    res=c_number(arg)
  elseif f=="range" then
    res=c_range(arg)
  elseif f=="calendar" then
    res=c_calendar(arg)
  elseif f=="jasmer" then
    res=c_jasmer(arg)
  elseif f=="DT" then
    res=c_DT(arg)
  elseif f=="adv_number" then
    res=c_adv_number(arg)
   elseif f=="date" then
    res=c_date(arg)
   elseif f=="streak" then
    res=c_streak(arg)
   elseif f=="attributes" then
    res=c_attributes(arg)
   elseif f=="fp" then
    res=c_fp(arg)
   elseif f=="crc" then
    res=c_crc(arg)
   elseif f=="crcPC" then
    res=c_crcPC(arg)
   elseif f=="souvenir" then
    res=c_souvenir(arg)
   elseif f=="tb" then
    res=c_tb(arg)
   elseif f=="regex" then
    res=c_regex(arg)
   elseif f=="sliding" then
    res=c_sliding(arg)
   elseif f=="words" then
    res=c_words(arg)
   elseif f=="distance" then
    res=c_distance(arg)
   elseif f=="types" then
    res=c_types(arg)

  elseif f=="age" then
    res=c_age(arg)
   elseif f=="fail" then
    res=c_fail(arg)
   elseif f=="ok" then
    res=c_ok(arg)
   elseif f=="info" then
    res=c_info(arg)
   elseif f=="maybe" then
    res=c_maybe(arg)
  else
    PGC.print("Missing function:",f,"\n",arg)
  end
  return res
end
-----------------------------------------------------
calculateMostFound()
local res
for i=1,1,1 do
  res=lookup(conf.func,conf.conf,filter,conf.opt)
end
local ok=res.ok
local log=res.slog.."\n\n"..res.log
local html=ok_html(res.ok)..res.shtml.."<br>"..res.html
--PGC.print(html)

if ok == "maybe" then
	ok = false
	log = "The testable conditions of this challenge have you failing, but you may have passed if you have met some/all of the untestable conditions marked as \"maybe\" below\n\n" .. log
	html = "The testable conditions of this challenge have you failing, but you may have passed if you have met some/all of the untestable conditions marked as \"maybe\" below<br><br>" .. html
end

return { ok = ok, log = log, html = html }
