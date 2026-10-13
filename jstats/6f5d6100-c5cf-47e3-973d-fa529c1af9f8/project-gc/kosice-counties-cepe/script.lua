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
function DebugPrint(a)
	if conf.debug==true then
		PGC.print(a)
	end
end
function PrintFindsText(finds,limit,fields)
  -- THERE IS A SPELLING ERROR IN BELOW VARIABLE //ganja1447
  local tmp=PrinFindsTable(finds,limit,fields) 
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
return res
end -- end function PrintFindsText
-----------------------------------------------------
function PrintFindsHtml(finds,limit,fields)
  local tmp=PrinFindsTable(finds,limit,fields)
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
function PrinFindsTable(finds,limit,fields)
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
end -- end function PrinFindsTable
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
    filter['filters']=conf.filters
  return filter
end -- end function FilterFromConfig
-----------------------------------------------------
function extraInConfig(conf,list)
  	local extra=false
  	local filter={"country","region","county","minVisitDate","maxVisitDate","minHiddenDate",
  				"maxHiddenDate","excludeTypes","types","sizes","difficulties","terrains",
  				"minlatitude","maxlatitude","minlongitude","maxlongitude","filters"}
  	local acc={}
  	for _,v in ipairs(filter) do
   		acc[v]=v
    end
  	for _,v in ipairs(list) do
   		acc[v]=v
    end
  	for k,c in pairs(conf) do
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
                table.insert(v,"Geocaching HQ Cache")
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
	--PGC.print("Filters:",loop_filters,"\n")
  for i,c in ipairs(loop_filters) do
    l_config.filter=expandFilter(c)
      --PGC.print("expanded filter:",l_config.filter,"\n")
      local filter=l_config.filter
      if filter.excludeTypes~= nil then
      table.insert(l_config.fields,"type")
       end
        PGC.print("l_config:",l_config)
    local myFinds= PGC.GetFinds(profileId,  l_config)
      local last=#finds+1
      for k,v in ipairs(myFinds) do
      	
          local fail=false
       		if finds_lid[v.log_id]~= nil then
        		fail=true
        	end
          --exculde types
          if filter.excludeTypes~= nil and filter.excludeTypes[v.type]~= nil then
        	PGC.print("Fail\n")
            fail=true
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
          finds_lid[v.log_id]=v
      end
  end
  local sortFinds={}
  --for k,v in spairs(finds_lid, function(t,a,b)  if t[b].visitdate==t[a].visitdate then return t[b].log_id >t[a].log_id else return t[b].visitdate>t[a].visitdate  end end) do
    for k,v in spairs(finds, function(t,a,b)  if t[b].visitdate==t[a].visitdate then return t[b].log_id >t[a].log_id else return t[b].visitdate>t[a].visitdate  end end) do
   
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
    else
    return '<img src="http://maxcdn.project-gc.com/images/cancel16.png">'    
    end       
end
-----------------------------------------------------
function ok_text(a)
  if a ==true then
      return 'OK'
    else
    return 'Fail'    
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
  local num_per_year = {}
  local enough_caches = false
  local enough_years = false
  local ok = false
  local log = ""
  local html = {}
  local slog=""
  local monthNames = {"January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December" }
  -- Set up filter parameters
  
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
    filter.maxHiddenDate = string.format("%4d-%2d-%2d", endyear, endmonth, Date().tab.day)
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
end
  
-- exclude_current_month
local exclude_current_month = conf.exclude_current_month;
if (exclude_current_month == nil) then exclude_current_month = false end

if (exclude_current_month == true) then
  --PGC.print("Excluding current month\n")
  endmonth = endmonth - 1
  if (endmonth == 0) then
    endmonth = 12
    endyear = endyear - 1
  end
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



local finds = PGC.GetFinds(profileId, { fields = {'gccode', 'cache_name', 'visitdate', 'hidden', 'owner_id', 'type'}, order = 'OLDESTFIRST', filter = filter })

-- Cycle through the finds, organizing caches by month found, and counting the number of distinct months
for _,cache in ipairs(finds) do
  if exclude_types[cache.type]==nil then
  local year = tonumber(string.sub(cache.hidden, 1, 4))
  local yearIndex = year - startyear + 1
  local month = tonumber(string.sub(cache.hidden, 6, 7))
  if (years[yearIndex][month] == false) then
    years[yearIndex][month] = cache
    monthCount = monthCount + 1
  end
  if (num_per_year[yearIndex] == nil) then
    num_per_year[yearIndex] = 1
  else
    num_per_year[yearIndex] = num_per_year[yearIndex] + 1
  end
end
end

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
end

-- Generate the sample log
if(ok == true) then
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
local tmp=""
if ok then
    tmp="You have  found caches hidden " .. monthCount .. " different month and you needed only " .. totalMonths - leeway
else
  tmp="You have only found caches hidden " .. monthCount .. " different months, out of " .. totalMonths - leeway .." required"    
end
  
slog=tmp
shtml=tmp
  
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
      table.insert(html, "<tr><td><b>" .. monthNames[month] .. " " .. year .. '</b></td><td><img src="' .. Type_Icons[cache.type] .. '" />&nbsp<a href=\"http://coord.info/' .. cache.gccode .. '">' .. cache.cache_name .. " (" .. cache.gccode 
          ..")</a><td>" .. cache.hidden .. "</td><td>" .. cache.visitdate .. "</td></tr>")
    end
  end
end

html = table.concat(html)

  return{ok = ok, log = log, html = html, slog = slog, shtml = shtml }
end -- end function c_jasmer
----------------------------
function c_DT(conf)
-----------------------------
	function PrintDT(DT,verticalSum,horizontalSum,sum,type)
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
				if DT[i][j]>0 then
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
   
	table.insert(ut,"I have"..ty..":")
	for i,v in pairs(conf.conditions) do
		local tmp=""
		if i=="loops" or i=="loop" then			
			if	loops>=v then
				tmp=tmp.."ok:"..loops.." total loops of ".. v.." needed"
				lok=true
			else
				tmp=tmp.."Fail: I had only "..loops .." total loops of ".. v.." needed"
				fail=true
	 		end
			table.insert(ut,tmp)
		elseif i=="loopsPer"then
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
    
	html=html..PrintDT(DT,verticalSum,horizontalSum,sum,print_types)
	local log =""
	return{ok = ok, log = log, html = html, slog = slog, shtml = shtml }
end -- end function c_DT
-----------------------------------------------------

function c_adv_number(conf)
function checkTest(groups,conf)
	local ok=false
	local fail=false
	local largestGroup={caches_nr=0,better=0,dtsum=0,caches_nr=0,types_nr=0,sizes_nr=0,regions_nr=0,DT_nr=0,T_nr=0,D_nr=0}
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
	--Group caches by key an calculate DTsum and #types for thar group
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
      		caches[groupKey].regions={}
     		caches[groupKey].regions_nr=0
      		caches[groupKey].filter=filter
    	end
		table.insert(caches[groupKey].caches,c)
  		caches[groupKey].caches_nr=caches[groupKey].caches_nr+1
  		local dtsum=tonumber(c['difficulty'])+tonumber(c['terrain'])
    	c['dtsum']=dtsum
  		caches[groupKey].dtsum=caches[groupKey].dtsum+dtsum
    	if caches[groupKey].types[c.type]== nil then
      		caches[groupKey].types[c.type]=c
      		caches[groupKey].types_nr=caches[groupKey].types_nr+1
    	end
    	if caches[groupKey].sizes[c.size]== nil then
      		caches[groupKey].sizes[c.size]=c
      		caches[groupKey].sizes_nr=caches[groupKey].sizes_nr+1
    	end
    	if caches[groupKey].regions[c.region]== nil then
      		caches[groupKey].regions[c.region]=c
      		caches[groupKey].regions_nr=caches[groupKey].regions_nr+1
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
      
      
		if conf.conditions.dtsum ~= nil or conf.conditions.limit ~= nil and conf.brief~= true then
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
local options ={"conditions","brief","period","debug"}
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
  
if filter.types~= nil and #filter.types== 1 and ExcludeTypes== nil then
    icontype=filter.types[1]
end

if conf.placed == nil then
    conf.placed = "false"
else
    conf.placed = "true"
end
if conf.nooftypes ~= nil then
    conf.limit = conf.nooftypes
end
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


myFinds = PGC.GetFinds( profileId, { fields = { 'gccode', 'type', 'visitdate', 'hidden' },filter=filter } )

function makekey(month, day)
    return string.format("%02d-%02d",month, day)
end


local daysinmonth = { 31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 }

for i, f in ipairs(myFinds) do
    -- Found date or placed date?
    if conf.placed == "true" then
        day = string.sub(f['hidden'], 6)
    else
        day = string.sub(f['visitdate'], 6)
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
for month = 1, 12 do
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
if numdone >= conf.needed  
  or (numdone == conf.needed - 1 
    and conf.leapday == "false"
    and (status[makekey(2,29)] == nil or (status[makekey(2,29)] ~= nil and status[makekey(2,29)] < conf.limit))
    ) then
    ok = true
end


-- Build log entry.
slog = "Missing dates (" .. numdone .. " of " .. conf.needed .. " done):\n"

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
                        table.insert(statustable, '<td><span style="color:red">' .. diff .. "</span></td>")
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
return { ok = ok, log = log, html = html,slog=slog,shtml=shtml }
end -- end function c_calendar
-----------------------------------------------------

function l_at_least(arg,filter,opt)
    --PGC.print("arg:",arg)
    local res={}
    local count=0
    local ok_count=0
    local req_count=opt.req
    local l_arg=TableCopy(arg)
    for i,t in pairs(l_arg) do
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
            end
      res.log=tmp.log
      res.html=tmp.html
        res.slog=tmp.slog
        res.shtml="<tbody><tr><td>"..ok_html(tmp.ok).."</td><td>"..tmp.shtml.."</td></tr>"
      else
        if tmp.ok==true then
              ok_count=ok_count+1
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
    else
      res.ok=false
    end
  
    res.shtml='<table border="1"><thead><tr><th>'..ok_html(res.ok)..'</th><th>At-least '..req_count..' of '..count..'</th></tr></thead>'
              ..res.shtml.."</tbody></table>"
    res.slog=ok_text(res.ok)..": at-least "..req_count..' of '..count.." {\n"..res.slog.."}\n"
return res
end
-----------------------------------------------------
function l_and(arg,filter,opt)
    --PGC.print("and arg:",arg)
    local res={}
    local count=0
    local l_arg=TableCopy(arg)
    for _,t in pairs(l_arg) do
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
        res.ok=res.ok and tmp.ok
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
end
-----------------------------------------------------
function l_or(arg,filter,opt)
      local res={}
    local count=0
    for _,t in pairs(arg) do
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
        res.ok=res.ok or tmp.ok
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
  local finds = PGC.GetFinds(profileId, { fields = {'visitdate'}, order = 'OLDESTFIRST', filter = y_filter })
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
        res.ok=res.ok or tmp.ok
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
	local fields = {'gccode', 'cache_name','visitdate'}
	--local finds = GetCombinedFinds(profileId, { fields = fields, order = 'OLDESTFIRST', filter = filter })
	local finds = PGC.GetFinds(profileId, { fields = fields, order = 'OLDESTFIRST', filter = filter })
  	local dateStart
  	local dateStop
  	local int=""
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
    		else

        	end
      	end
  

  	local count=0
	local ok_finds={}
  	for _,c in ipairs(finds) do
  		local date=DateOffset(string.sub(c.visitdate,6,10))
  		local day=tonumber(string.sub(c.visitdate,9,10))
    	local month=tonumber(string.sub(c.visitdate,6,7))
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
	        		if string.sub(c.visitdate,6,10)==v then
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
    		else
        		PGC.print("conditions:",k,":",v," Unknown\n")
        		return {ok=nil,html=nil,log=nil}
        	end
      	end
  
  		if lok==true and lfail==false then
      		count=count+1
    		table.insert(ok_finds,c)
      		if count>=conf.limit then
        		break
        	end
  		end
  	end
  
	local ok=false
	if #ok_finds >= conf.limit then
	    ok = true
	end

	local slog = "User has " .. #ok_finds .. " finds (" .. conf.limit .. " needed)."..int.." "..PrintFilter(filter).."\n"
	local shtml = "User has " .. #ok_finds .. " finds (" .. conf.limit .. " needed)."..int.." "..PrintFilter(filter)  
	local log = slog.."\n"..PrintFindsText(ok_finds,conf.limit,fields)
	local html = shtml.."<br>".. PrintFindsHtml(ok_finds,conf.limit,fields)
	return{ok = ok, log = log, html = html, slog = slog, shtml = shtml }
end -- end function c_date(

-----------------------------------------------------

  function c_number(conf)
  	local options ={"limit","brief"}
  	if extraInConfig(conf,options)==true then
    	return{ok=nil,log=nil,html=nil}
    end
  	local filter=FilterFromConfig(conf)
	local fields = {'gccode', 'cache_name'}
	local finds = GetCombinedFinds(profileId, { fields = fields, order = 'OLDESTFIRST', filter = filter })
	--local finds = PGC.GetFinds(profileId, { fields = fields, order = 'OLDESTFIRST', filter = filter })
	local ok=false
	if #finds >= conf.limit then
	    ok = true
	end
	local slog = "User has " .. #finds .. " finds (" .. conf.limit .. " needed)."..PrintFilter(filter).."\n"
	local shtml = "User has " .. #finds .. " finds (" .. conf.limit .. " needed)."..PrintFilter(filter)  
	local log = PrintFindsText(finds,conf.limit,fields)
	local html = PrintFindsHtml(finds,conf.limit,fields)
  	if conf.brief== true then
    	log=""
    	html=""
    end
	return{ok = ok, log = log, html = html, slog = slog, shtml = shtml }
end -- end function c_number

-----------------------------------------------------
function c_age(conf)
  local filter=FilterFromConfig(conf)
  local iso = Date.Format("yyyy-mm-dd")
  local date = Date {}
  date:add(conf.age)
  filter.maxHiddenDate=iso:tostring(date)
    local fields = {'gccode', 'cache_name','hidden'}
  local finds = GetCombinedFinds(profileId, { fields = fields, order = 'OLDESTFIRST', filter = filter })
  local ok=false
  if #finds > conf.limit then
      ok = true
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
    
    
      
  local slog = "Old Caches: User has " .. #finds .. " finds (" .. conf.limit .. " needed) older then "..sage.."."..PrintFilter(filter).."\n"
  local shtml = "Old Caches: User has " .. #finds .. " finds (" .. conf.limit .. " needed) older then "..sage.."."..PrintFilter(filter)  
    local log = slog.."\n"..PrintFindsText(finds,conf.limit,fields)
  local html =shtml.."<br>".. PrintFindsHtml(finds,conf.limit,fields)
  	if conf.brief== true then
    	log=""
    	html=""
    end
  return{ok = ok, log = log, html = html, slog = slog, shtml = shtml } 
end -- end function c_age   
-----------------------------------------------------
function lookup(f,arg,filter,opt)
  local res=nil
  if f=="or"  then
    res=l_or(arg,filter,opt)
  elseif f=="and"  then
    res=l_and(arg,filter,opt)
  elseif f=="at_least"  then
    res=l_at_least(arg,filter,opt)
   elseif f=="in_a_year"  then
    res=l_in_a_year(arg,filter,opt)
  elseif f=="number" then
    res=c_number(arg)
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
    
  elseif f=="age" then
    res=c_age(arg)
   elseif f=="fail" then
    res=c_fail(arg)
   elseif f=="ok" then
    res=c_ok(arg)
  else
    PGC.print("Missing function:",f,"\n",arg)
  end
  return res
end
-----------------------------------------------------
local res
for i=1,1,1 do
  res=lookup(conf.func,conf.conf,filter,conf.opt)
end
local ok=res.ok
local log=res.slog.."\n\n"..res.log
local html=ok_html(res.ok)..res.shtml.."<br>"..res.html
--PGC.print(html)
return { ok = ok, log = log, html = html }
