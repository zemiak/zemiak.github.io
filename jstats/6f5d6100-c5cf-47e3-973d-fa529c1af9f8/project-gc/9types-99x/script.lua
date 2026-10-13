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


-------------------------------------------------------------------------------------------------
local args={...}
conf = args[1].config
minTypes = tonumber(conf.minTypes)			-- minimum finds per type needed
minFinds = tonumber(conf.findsPerType)		-- minimum finds per type needed
totFinds = tonumber(conf.findsTotal)		-- minimum total finds
ndetails = conf.list						-- list of caches

if totFinds == nil then totFinds = 1 end
if minFinds == nil then minFinds = 1 end
-------------------------------------------------------------------------------------------------

profileName = args[1]['profileName']
profileId = args[1]['profileId']
-- PGC.print produces debug log
PGC.print('Got profile name, ', profileName, "\n")
PGC.print('Got profile id ', profileId, "\n")

--[[
Get data for as few fields as possible to reduce memory usage.
--]]
fields = { 'country', 'cache_name', 'gccode', 'type', 'visitdate', 'difficulty', 'terrain', 'log_id' }

local filter={}
filter['country'] = conf.country
filter['region'] = conf.region
filter['county'] = conf.county
filter['minVisitDate'] = conf.minVisitDate
filter['maxVisitDate'] = conf.maxVisitDate
filter['minHiddenDate'] = conf.minHiddenDate
filter['maxHiddenDate'] = conf.maxHiddenDate

filter['types'] = conf.types
filter['sizes'] = conf.sizes
filter['difficulties'] = conf.difficulties
filter['terrains'] = conf.terrains

-------------------------------------------------------------------------------------------------
myFinds = PGC.GetFinds( profileId, { fields = fields, filter = filter, order = 'OLDESTFIRST' } )
-------------------------------------------------------------------------------------------------

-- Do calculations
typeGroups = {}
cachecounter = 0
local logA = {}
local htmlA = {}
local ii = 0

table.insert(htmlA, "<table><tr><th>#</th><th>type</th><th></th>I<th>Cache</th><th>Found date</th></tr>")  	

for index,cache in pairs(myFinds) do

	PGC.print("gc ".. cache['gccode'].." type "..cache['type']..' visitdate: '..cache['visitdate'] .. " Log ID: " .. cache['log_id'],"\n")
  	cachecounter = cachecounter + 1

 	groupKey = cache['type']
      
		groupData = typeGroups[groupKey]
		if (groupData == nil) then -- create new data structure for type
			groupData = {}
			groupData["qual"] = {}
			groupData["find_counter"] = 0
			typeGroups[groupKey] = groupData
		end

		groupData["qual"][cache['gccode']] = cache    	
		groupData["find_counter"] = groupData["find_counter"] + 1

end

typesFound = 0
typesAll = 0
logdataC = ""
findsALL = 0

for group,groupData in pairs(typeGroups) do 	
	typeFinds = groupData["find_counter"]
	qualifyingCaches = groupData["qual"]
  	typesAll = typesAll + 1
  
	if (typeFinds >= minFinds) then -- minimum required finds by type
        typesFound = typesFound + 1
    end
    	typeOutCount = 0
    
		for gccode,cache in pairs(qualifyingCaches) do
      		typeOutCount = typeOutCount + 1
      		findsALL = findsALL + 1
			
      		if (typeOutCount <= minFinds) then
        
				table.insert(logA, "[b]" .. cache.type .."[/b]".. 
          		" [url=http://www.geocaching.com/seek/log.aspx?lid=" .. cache.log_id .. "]" .. cache.cache_name ..
            	" (" .. cache.gccode .. ")[/url]" .. " 📅 " .. cache.visitdate)
        	        
        		table.insert(htmlA, "<tr><td>" .. typesFound .. "/".. typeOutCount .. "</td><td>" .. cache.type .. 
        		'</td><td><img src="' .. types[cache.type] .. '" />' .. '</td><td><a href=\"http://www.geocaching.com/seek/log.aspx?lid=' .. 
        		cache.log_id .. '">' .. cache.cache_name .. " (" .. cache.gccode .. ")</a></td><td>📅 " .. cache.visitdate .. "</td></tr>")     
        	end
 
            if (typeOutCount > minFinds) and (findsALL <= totFinds) then 

				table.insert(logA, "[b]" .. cache.type .."[/b]".. 
       			" [url=http://coord.info/" .. cache.gccode .. "]" .. cache.cache_name .. 
            	" (" .. cache.gccode .. ")[/url]" .. " 📅 " .. cache.visitdate)
        	        
        		table.insert(htmlA, "<tr><td>" .. typesFound .. "/".. typeOutCount .. "</td><td>" .. cache.type .. 
        		'</td><td><img src="' .. types[cache.type] .. '" />' .. '</td><td><a href=\"http://coord.info/' .. 
        		cache.gccode .. '">' .. cache.cache_name .. " (" .. cache.gccode .. ")</a></td><td>📅 " .. cache.visitdate .. "</td></tr>")      
        	end
      		
		end
--	end
end

-- log = table.concat(logA, "\n")
local log = ""
local html = ""
local ok = false

-- Check if challenge is fulfilled and if so, set ok = true
if typesFound >= minTypes and findsALL >= totFinds then
    ok = true
else
    ok = false
end

    log = 'In total, I have ' .. cachecounter .. ' finds, qualified for this challenge. '
	html = 'In total, I have <b>' .. cachecounter .. ' finds</b>, qualified for this challenge. '	

	if totFinds > 1 then
  		log = log .. 'Required minimum: ' .. totFinds .. ' finds.'
  		html = html .. 'Required minimum: ' .. totFinds .. ' finds.'
	end

	if minTypes > 1 then
  		log = log .. '\n' .. 'I have at least ' .. minFinds .. ' finds from each of ' .. typesFound .. ' types (' .. minTypes .. ' types are required).'
  		html = html .. '<br>I have at least <b>' .. minFinds .. ' finds from each of ' .. typesFound .. ' types</b> (' .. minTypes .. ' types are required).'
  	end
  

  	if ndetails == "show" then
 		log = log .. "\n" .. "My qualified finds (not all of them, only required number) are listed here:\n\n" .. table.concat(logA, "\n") .. "\n"
        html = html .. "<br>My qualified finds (not all of them, only required number) are listed here:<hr>" .. table.concat(htmlA) .. "</table><br>"
	end
	
if ok==false then
    html = "Oh no, how unlucky!<br> <b>" .. profileName .. " does not qualify for this Challenge yet.</b><br>"
  	html = html .. "But don't worry! You're on the right track to fulfill the Challenge soon. Just keep on Geocaching!<hr>"
  	html = html .. "In total, you have <b>" .. cachecounter .. " finds</b>, qualified for this challenge:<hr>" .. table.concat(htmlA) .. "</table><br>"
  
  if totFinds > 1 then
  	html = html .. 'Required minimum: ' .. totFinds .. ' caches.'
  end
  	
  if minTypes > 1 then
  		html = html .. '<br>You have at least <b>' .. minFinds .. ' finds from each of ' .. typesFound .. ' types</b> (' .. minTypes .. ' types are required).'
  end
  
  if typesFound > 0 then
  	if ndetails == "show" then
        html = html .. "<br>Your qualified finds are listed here:<hr>" .. table.concat(htmlA) .. "</table><br>"
	end
  end
end

return { ok = ok, log = log, html = html }


