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

local args={...}
local conf = args[1].config
local profileName = args[1].profileName
local profileId = args[1].profileId
-- PGC.print produces debug log
PGC.print('Got profile name, ', profileName, "\n")
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

local ignoreListI = PGC.GetBookmarklist( "BMAFMJR", {} )
local ignoreList={}
for i,c in ipairs(ignoreListI) do
	ignoreList[c]=c
end

PGC.print(ignoreList)
-- Get data for as few fields as possible to reduce memory usage. A full list of fields can be found at http://project-gc.com/doxygen/lua-sandbox/classPGC__LUA__Sandbox.html#a8b8f58ee20469917a29dc7a7f751d9ea
local myFinds = PGC.GetFinds(profileId, { fields = {'gccode','type', 'cache_name', 'visitdate', 'country','difficulty','terrain','latitude','longitude'}, order = 'OLDESTFIRST', filter = filter })


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
    	if conf.maxdistance == nil or(conf.maxdistance ~= nil  and l.distance< conf.maxdistance) then
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
	local tmplog="I made it with a distance of "..dist.." km and I only needed "..conf.distance.." km "..header_end
  	table.insert(log,tmplog)
  
	table.insert(html,tmplog.."<br>")
  	local tmplog="This is "..loops.." times the required distance"
  	table.insert(log,tmplog)
	table.insert(html,tmplog.."<br>")
 	
else
	local tmplog="I <b> didn't</b> make it with a distance of only "..dist.." km and I needed "..conf.distance.." km "..header_end
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
html = table.concat(html, "\n")

--[[
More feedback can be given by producing html into the html variable
Can be of good use to show the user his/her progress
Doesn't actually have to be html
--]]


return { ok = ok, log = log, html = html }
