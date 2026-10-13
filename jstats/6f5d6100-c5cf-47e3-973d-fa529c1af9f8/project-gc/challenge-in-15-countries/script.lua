-- with areas
function remove_crazy_caches(finds)
  local crazy_caches = PGC.GetBookmarklist("BMAFMJR", {} ) or {}
  local codes = {}
  for _,code in ipairs(crazy_caches) do
    codes[code] = true
  end
  local res={}
  for _,f in ipairs(finds) do
    if not codes[f.gccode] and f.type~="Locationless Cache" then
      table.insert(res, f)
    end
  end
  return res
end    

local types =
  {
    ["Traditional Cache"]							= "https://www.geocaching.com/images/wpttypes/sm/2.gif",
    ["Multi-Cache"]								= "https://www.geocaching.com/images/wpttypes/sm/3.gif",
    ["Virtual Cache"]								= "https://www.geocaching.com/images/wpttypes/sm/4.gif",
    ["Letterbox Hybrid"]							= "https://www.geocaching.com/images/wpttypes/sm/5.gif",
    ["Event Cache"]								= "https://www.geocaching.com/images/wpttypes/sm/6.gif",
    ["Mystery Cache"]								= "https://www.geocaching.com/images/wpttypes/sm/8.gif",
    ["Project A.P.E. Cache"]							= "https://www.geocaching.com/images/wpttypes/sm/9.gif",
    ["Webcam Cache"]								= "https://www.geocaching.com/images/wpttypes/sm/11.gif",
    ["EarthCache"]                                = "https://www.geocaching.com/images/wpttypes/sm/earthcache.gif",
    ["Cache In Trash Out Event"]					= "https://www.geocaching.com/images/wpttypes/sm/13.gif",
    ["Mega-Event Cache"]							= "https://www.geocaching.com/images/wpttypes/sm/mega.gif",
    ["Giga-Event Cache"]							= "https://www.geocaching.com/images/wpttypes/sm/giga.gif",
    ["Wherigo Cache"]								= "https://www.geocaching.com/images/wpttypes/sm/wherigo.gif",
    ["Geocaching HQ Cache"]							= "https://www.geocaching.com/images/wpttypes/sm/3773.gif",
    ["Benchmark"]									= "https://www.geocaching.com/images/wpttypes/sm/27.gif",
    ["Locationless Cache"]				= "https://www.geocaching.com/images/wpttypes/sm/12.gif",
    ["Community Celebration Event"]				= "https://www.geocaching.com/images/wpttypes/sm/3653.gif",
    ["GPS Adventures Maze Exhibit"]				= "https://www.geocaching.com/images/wpttypes/sm/1304.gif",
    ["Geocaching HQ Celebration"]	= "https://www.geocaching.com/images/wpttypes/sm/3774.gif",
    ["Geocaching HQ Block Party"]					= "https://www.geocaching.com/images/wpttypes/sm/4738.gif",
    ["GPS Adventures Maze Exhibit"]					= "https://www.geocaching.com/images/wpttypes/sm/maze.gif"
  }

  local args={...}
  conf = args[1].config

function list_cgroups(cgroup)
  local result={}
  for gname, _ in pairs(cgroup or {}) do
    table.insert(result, gname) 
  end
  return result
end
function create_aress(finds, conf)
  PGC.print("Creating areas based on counties\n")
  local area={}
  for gname, gdata in pairs(conf.def_cgroups or {}) do
    for _,aname in ipairs(gdata) do
      area[aname]=gname
--      PGC.print("Mapping county ", aname, " to area ", gname, "\n")
    end
  end
  local result={}
  for _,f in ipairs(finds) do
    local g=area[f.county or ""]
    if g then
      f.cgroup=g
      table.insert(result,f)
      PGC.print("Assigning area ", g, " to cache ", f.gccode, "\n")
    end
  end
  return result
end

function filter_attr(finds)
  
  function has_attr(f, attr, required)
    function int(i) return i-i%1 end
    if not attr then return false end
    if type(attr)=="table" then
      local done=0
      for _,a in ipairs(attr) do
        if has_attr(f,a) then done=done+1 end
        if done>=(required or 1) then return true end
      end
      return false
    end
    local bm;
    if attr>0 then
      bm={f.attributes_set_1,f.attributes_set_2,f.attributes_set_3}
    else
      attr=-attr;
      bm={f.attributes_unset_1,f.attributes_unset_2,f.attributes_unset_3}
    end
    attr=attr-1
    local b=bm[int(attr/32)+1]
    if not b then return false end
    local i=attr%32
    local div1={1,2,4,8,16,32,64,128}
    local div2={1, 256, 65536, 16777216}
  --  PGC.print("b= ",b," attr= ",attr,"\n")
  --  PGC.print("div2= ", div2[int(i/8+1)], "attr%8= ", attr%8, " div1= ", div1[i%8+1], "\n")
    return int(b/div2[int(i/8+1)]/div1[i%8+1])%2==1
  end
  
  local result={}
  for _,f in ipairs(finds) do
  	if  (not conf.attributes or has_attr(f,conf.attributes,conf.attributes_required) )
   	    and not has_attr(f,conf.exclude_attributes)
    then
      table.insert(result,f)
    end
  end
  PGC.print("after attr filter ", #result, " caches\n")
  return result
end


-- decode countries/regions/counties
  if conf.cgroups then
    conf.areas=conf.cgroups
    conf.def_cgroups=conf.cgroup
    conf.cgroup=list_cgroups(conf.cgroup)
    conf.area="cgroup"
  elseif conf.countries then
  	conf.areas=conf.countries
    conf.area="country"
  elseif conf.regions then
    conf.areas=conf.regions
    conf.area="region"
  elseif conf.counties then
    conf.areas=conf.counties
    conf.area="county"
  elseif conf.states then
    conf.areas=conf.states
    conf.area="state"
  end


  minRegions = tonumber(conf.areas)  -- minimum regions with finds needed
  minFinds = tonumber(conf.findsPerArea or 1)  -- minimum finds per Region needed
  minTotal = tonumber(conf.findsTotal)  -- minimum total finds needed
  ndetails = conf.list or "show"-- list of caches
  local TExcludedTypes = {}
  local TExcludedCountries = {}
  local TExcludedRegions = {}
  local TExcludedCounties = {}
  local TExcludedGCCodes = {}

  if minRegions == nil then
    minRegions = 1
  end

  if minFinds == nil then
    minFinds = 1
  end

  if minTotal == nil then
    minTotal = 1
  end

  local maxPlacedDate = "9999-12-31"
  if (conf.maxPlacedDate ~= nil) then
    maxPlacedDate = conf.maxPlacedDate
  end
  temp = string.gsub(maxPlacedDate,"[^0-9]","")
  maxPlacedDate = tonumber(temp)

local is_big_country={}
for _,c in ipairs(conf.countries_with_states or {"United States", "Canada", "Australia"}) do
  is_big_country[c]=true
end

function make_key(cache)
  if conf.area=="state" and is_big_country[cache.country] then
    return cache.country.."-"..(cache.region or "")
  elseif conf.area=="state" then
    return cache.country
  elseif conf.area=="county" then
    return cache.country.."-"..(cache.region or "").."-"..(cache.county or "")
  elseif conf.area=="region" then
    return cache.country.."-"..(cache.region or "")
  elseif conf.area=="cgroup" then
    PGC.print("Using cgroup ", cache.cgroup, " for key\n")  
    return cache.cgroup
  else
    return cache[conf.area]
  end
end
  
  -------------------------------------------------------------------------------------------------

  profileName = args[1]['profileName']
  profileId = args[1]['profileId']
  PGC.print('Got profile name, ', profileName, "\n")
  PGC.print('Got profile id ', profileId, "\n")

  fields = { 'country', 'region', 'county', 'cache_name', 'gccode', 'type', 'visitdate', 'hidden', 'owner_id' }
  local filter = {}

  if conf.types ~= nil then
  	filter['types'] = conf.types
  end

  if conf.sizes ~= nil then
  	filter['sizes'] = conf.sizes
  end

  if conf.region ~= nil then
  	filter['region'] = conf.region
  end

  if conf.country ~= nil then
  	filter['country'] = conf.country
  end

  if conf.county ~= nil then
  	filter['county'] = conf.county
  end

  if conf.attributes or conf.exclude_attributes then
    table.insert(fields, 'attributes_set')
    table.insert(fields, 'attributes_unset')
  end

  local keysMap
  if conf.keys then
    keysMap={}
    for _,k in ipairs(conf.keys) do
      keysMap[k]=k;
    end
  end
  local listAreas=conf[conf.area]
  if type(listAreas)~= 'table' then listAreas={listAreas} end
  local areaname=conf.area
  local tmp={country="Countries", region="Regions", county="Counties", state="States", cgroup="Areas"}
  local areanames=tmp[areaname]

  function logplace(cache)
    if conf.area=="country" then
      return "[b]" .. cache.country .."[/b]"
    elseif conf.area=="region" then
      return "[b]" .. (cache.region or "").."[/b]".. " (" .. cache.country .. ")"
    else
      return "[b]" .. (cache.county or "") .."[/b]".. " (" .. (cache.region or "").." - "..cache.country .. ")"
    end
  end  

function isOwnedEvent(cache)
  return  profileId==cache.owner_id
     and (  cache.type=="Event Cache"
         or cache.type=="Cache In Trash Out Event"
         or cache.type=="Mega-Event Cache"
         or cache.type=="Giga-Event Cache"
         )
end

  local showRegion=true
  local showArea=false
  local showCounty=true

  filter['difficulties'] = conf.difficulties
  filter['terrains'] = conf.terrains
  filter['minVisitDate'] = conf.minVisitDate

  myFinds = remove_crazy_caches(PGC.GetFinds( profileId, { fields = fields, filter = filter, order = 'OLDESTFIRST' } ))
  myFinds = filter_attr(myFinds)
  if conf.cgroup then
    myFinds = create_aress(myFinds, conf)
    showArea=true
  end
  regionGroups = {}
  cachecounter = 0
  local logA = {}
  local logB = {}
  local htmlA = {}
  local htmlB = {}
  local regionGroupsList = {}
  local ii = 0


function founds_in_region(neededArea)
  for a,v in pairs(regionGroups) do
--    PGC.print("searchinf for "..neededArea.." in ",v,"\n")
    if  v.qual[1][conf.area]==neededArea then
      return v.find_counter;
    end
  end
  return 0
--[[    
 regionGroups[neededArea].find_counter 
  		regionGroups[groupKey] = groupData
      table.insert(regionGroupsList, groupKey) -- added line
--]]  
end


  local htmlhdr="<table><tr><th>#</th><th>Country</th>"..(showRegion and "<th>Region</th>" or "")..(showArea and "<th>Area</th>" or "")..(showCounty and "<th>County</th>" or "").."<th>Cache</th><th>Found date</th><th>Placed date</th></tr>"
  table.insert(htmlA, htmlhdr)
  table.insert(htmlB, htmlhdr)

    if conf.ExcludedTypes ~= nil then 	--make a table indexed by type
      for _,cache in ipairs(conf.ExcludedTypes) do
        TExcludedTypes[cache] =0
      end
    end

    if conf.ExcludedCountries ~= nil then 	--make a table indexed by country
      for _,cache in ipairs(conf.ExcludedCountries) do
        TExcludedCountries[cache] =0
      end
    end

    if conf.ExcludedRegions ~= nil then 	--make a table indexed by region
      for _,cache in ipairs(conf.ExcludedRegions) do
        TExcludedRegions[cache] =0
      end
    end

    if conf.ExcludedCounties ~= nil then 	--make a table indexed by county
      for _,cache in ipairs(conf.ExcludedCounties) do
        TExcludedCounties[cache] =0
      end
    end

    if conf.ExcludedGCCodes ~= nil then 	--make a table indexed by GCCode
      for _,cache in ipairs(conf.ExcludedGCCodes) do
        TExcludedGCCodes[cache] =0
      end
    end

  for index,cache in ipairs(myFinds) do
    if cache['type'] ~= 'Locationless Cache' then
    if TExcludedTypes[ cache['type']] == nil then --and cache['country'] .. "/" .. cache['region'] ~= nil then
    if    TExcludedCountries[ cache['country']] == nil 
      and TExcludedRegions[ cache['region'] or ""] == nil 
      and TExcludedCounties[cache.county or ""] == nil  
      and cache['gccode'] ~= nil 
      and cache['gccode'] ~= "" 
      and (not conf.ExcludeOwnedEvents or not isOwnedEvent(cache))  
--      and (not keysMap or keysMap[
   then

      temp = string.gsub(cache['hidden'],"[^0-9]","") 		--new
      local placeddate = tonumber(temp)					--new
      	if (placeddate < maxPlacedDate) then			--new

--      PGC.print("gc ".. cache['gccode'].." Country " ..cache['country'] .." Region "..cache['region']..' visitdate: '..cache['visitdate'],"\n")
    	cachecounter = cachecounter + 1

-- log and html: second part (total number of caches)

    	if minTotal > 1 and cachecounter <= minTotal then
            local l
            if ndetails=='short' then
              l=logplace(cache).." ".. cache.gccode .. " " .. cache.cache_name
            else  
              l=logplace(cache) ..
         		" ["..cache.cache_name.."](https://coord.info/" .. cache.gccode .. ")"
             .. " | " .. cache.visitdate .. " | " .. cache.hidden
            end
  		table.insert(logB, index..". "..l)

  		table.insert(htmlB, "<tr><td>" .. cachecounter .. "</td><td><b>" .. cache.country .. "</td>"..
              (showRegion and "<td><b>" .. (cache.region or "").."</b></td>" or "")..
              (showArea and "<td><b>" .. (cache.cgroup or "").."</b></td>" or "")..
              (showCounty and "<td><b>" .. (cache.county or "").."</b></td>" or "")..
              '<td><img src="' .. types[cache.type] .. '" />&nbsp;&nbsp;<a href=\"https://coord.info/' ..
          	cache.gccode .. '">' .. cache.cache_name .. " (" .. cache.gccode .. ")</a></td><td>" .. cache.visitdate .. "</td><td>" .. cache.hidden .. "</td></tr>")
      end

      if    TExcludedCountries[ cache['country']] == nil 
        and TExcludedRegions[ cache['region'] or "" ] == nil 
        and TExcludedCounties[ cache['county'] or ""] == nil 
        and TExcludedGCCodes[ cache['gccode']] == nil 
        then
          groupKey = make_key(cache)
          gcKey = cache['gccode']
        	groupData = regionGroups[groupKey]

    if (groupData == nil) then -- create new data structure for Region
  		groupData = {}
  		groupData["qual"] = {}
  		groupData["find_counter"] = 0
  		regionGroups[groupKey] = groupData
      table.insert(regionGroupsList, groupKey) -- added line
  	end

  	      table.insert(groupData["qual"], cache)
  	      groupData["find_counter"] = groupData["find_counter"] + 1
      end
      end
      end
    end
    end
  end

  logB = table.concat(logB, "\n")

  RegionsFound = 0
  RegionsAll = 0
  logdataC = ""

 for i,group in ipairs(regionGroupsList) do
    local groupData = regionGroups[group]

    RegionFinds = groupData["find_counter"]
  	qualifyingCaches = groupData["qual"]

    RegionsAll = RegionsAll + 1

  	if (RegionFinds >= minFinds) then -- minimum required finds by Region
        RegionsFound = RegionsFound + 1
      	RegionOutCount = 0
     		for _,cache in ipairs(qualifyingCaches) do
        		RegionOutCount = RegionOutCount + 1

        		if RegionsFound <= minRegions then
--        PGC.print("inserting ", cache)
        		local l
        if ndetails=='short' then
          l= logplace(cache) .. " ".. cache.gccode .. " " .. cache.cache_name
        else
          l= logplace(cache) ..
         			" [url=https://coord.info/" .. cache.gccode .. "]" .. cache.cache_name ..
              	" (" .. cache.gccode .. ")[/url]" .. " | " .. cache.visitdate .. " | " .. cache.hidden
        end
        
  			table.insert(logA, i..". "..l)

        table.insert(htmlA, 
          "<tr><td>" .. RegionsFound .. "/".. RegionOutCount .. "</td>"..
          "<td><b>" .. cache.country .. "</td>"..
          (showRegion and "<td><b>" .. (cache.region or "").. "</b></td>" or "")..
          (showArea and "<td><b>" .. (cache.cgroup or "").. "</b></td>" or "")..
          (showCounty and "<td><b>" .. (cache.county or "").. "</b></td>" or "")..
          '<td><img src="' .. types[cache.type] .. '" />&nbsp;&nbsp;<a href=\"https://coord.info/' ..
          		cache.gccode .. '">' .. cache.cache_name .. " (" .. cache.gccode .. ")</a></td>"..
          "<td>" .. cache.visitdate .. "</td>"..
          "<td>" .. (cache.hidden or "UNKNOWN HIDDEN").. "</td></tr>")
        		end

          	if (RegionOutCount >= minFinds) then
          		break
          	end
  		end
    end
end

  logA = table.concat(logA, "\n")

  local ok = false
  local html = false

  -- Check if challenge is fulfilled and if so, set ok = true
  local log = ""

  if (RegionsFound >= minRegions) and (cachecounter >= minTotal) then -- minimum required Regions found
      ok = true
  else
      ok = false
  end
  if conf.areas==1
  then
    log = log .. "I have found required number of caches (" .. minFinds .. " required) in the "..areaname.." \n"
    html = "<b>" .. profileName .. " has found required number of caches </b>(" .. minFinds .. " required) in the "..areaname.."<br>"
  else
    log = log .. "I have found required number of caches (" .. minFinds .. ") in each of " .. RegionsFound .. " "..areanames.." (required number of "..areanames..": " .. minRegions .. ").\n"
    html = "<b>" .. profileName .. " has found required number of caches (" .. minFinds .. ")</b> in each of <b>" .. RegionsFound .. " "..areanames.."</b> (required number of "..areanames..": " .. minRegions .. ").<br>"
  end
  	if ndetails == "show" or ndetails == "short" then
  		log = log .. "Finds in required "..areanames.." are listed here:\n\n" .. logA .. "\n"
        html = html .. "Finds in required "..areanames.." are listed here:<hr>" .. table.concat(htmlA) .. "</table>"
    else
      table.sort(regionGroupsList, function(a,b) return regionGroups[a].find_counter>regionGroups[b].find_counter end)
      for i,group in ipairs(regionGroupsList) do
        if i>minRegions then break end
        local groupData = regionGroups[group]
        RegionFinds = groupData["find_counter"]
    	log=log..i..": "..group.." ("..RegionFinds..")\n"
        html=html..i..": "..group.." ("..RegionFinds..")<br/>"
      end
  	end

  if minTotal > 1 then
  	log = log .. "\nIn total (respecting all challenge requirements and limitations), I have found " .. cachecounter .. " caches (required minimum: " .. minTotal .. ")."
      html = html .. "<hr>In total (respecting all challenge requirements and limitations), <b>" .. profileName .. "</b> has found<b> " .. cachecounter .. " caches</b> (required minimum: " .. minTotal .. ").<br>"

    	if ndetails == "show" or ndetails=='short' then
    		log = log .. "Here is the list of " .. minTotal .. " required finds:\n\n" .. logB .."\n"
        end
  		html = html .. "List of required " .. minTotal .. " finds is here:<hr>" .. table.concat(htmlB) .. "</table>"
  end


  if ok==false then
    html = "<b>" .. profileName .. " does not qualify for this Challenge yet.</b><br>"
   	html = html .. "But don't worry! You are on right track to fulfil the Challenge soon. Let's go to find some caches out there!<br><br>"
   	html = html .. "You have found required number of caches (" .. minFinds .. ") in " .. RegionsFound .. " "..areanames.." so far. Required minimum is " .. minRegions .. " "..areanames..".<br>"

   	if ndetails == "show" then
          html = html .. "Finds in each "..areaname.." are listed here:<hr>" .. table.concat(htmlA) .. "</table><br>"
    else
      table.sort(regionGroupsList, function(a,b) return regionGroups[a].find_counter>regionGroups[b].find_counter end)
      for i,group in ipairs(regionGroupsList) do
        local groupData = regionGroups[group]
        RegionFinds = groupData["find_counter"]
        html=html..i..": "..group.." ("..RegionFinds..")<br/>"
      end
  	end

    if minTotal > 1 then
      html = html .. "In total (respecting all challenge requirements and limitations), you have found " .. cachecounter .. " caches. Required minimum is " .. minTotal .. " caches.<br>"
      if ndetails == "show" then
        html = html .. "List of qualified finds, regardless "..areaname..", is here:<hr>" .. table.concat(htmlB) .. "</table>"
      end
    end

    local htmlMissing = {}
    for _, neededArea in ipairs(listAreas or {}) do
      founds=founds_in_region(neededArea)
--      founds=regionGroups[neededArea] and regionGroups[neededArea].find_counter or 0
      if founds < minFinds then
        local missing= minFinds>1 and " ("..minFinds-founds.." found missing)" or ""
        table.insert(htmlMissing, "<li>"..neededArea..missing.."</li>")
      end
    end
    if #htmlMissing > 0 then	
      html = html .. "List of missing "..areanames..":<ul>" .. table.concat(htmlMissing) .. "</ul>"
    end
  end

  return { ok = ok, log = log, html = html }
