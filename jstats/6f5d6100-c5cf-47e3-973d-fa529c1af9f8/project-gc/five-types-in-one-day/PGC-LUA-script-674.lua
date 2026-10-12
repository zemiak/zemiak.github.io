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
  ["Locationless Cache"]				= "http://www.geocaching.com/images/wpttypes/sm/12.gif",
  ["Community Celebration Event"]				= "http://www.geocaching.com/images/wpttypes/sm/3653.gif",
  ["GPS Adventures Maze Exhibit"]				= "http://www.geocaching.com/images/wpttypes/sm/1304.gif",
  ["Geocaching HQ Celebration"]	= "http://www.geocaching.com/images/wpttypes/sm/3774.gif",
  ["Geocaching HQ Block Party"]					= "http://www.geocaching.com/images/wpttypes/sm/4738.gif",
  ["GPS Adventures Maze Exhibit"]					= "http://www.geocaching.com/images/wpttypes/sm/maze.gif"
}

function TableCopy(t)
	local t2 = {}
	for k,v in pairs(t) do
		t2[k] = v
	end
	return t2
end

local args={...}
local conf = args[1].config
profileName = args[1]['profileName']
PGC.print('Got profile name, ', profileName, "\n")
profileId = PGC.ProfileName2Id(profileName)
PGC.print('Converted to id ', profileId, "\n")

limit = conf.limit

local filter={}
filter['country'] = conf.country
filter['region'] = conf.region
filter['county'] = conf.county
filter['minVisitDate'] = conf.minVisitDate

filter['types'] = conf.types
filter['sizes'] = conf.sizes
filter['difficulties'] = conf.difficulties
filter['terrains'] = conf.terrains

myFinds = PGC.GetFinds( profileId, { fields = { 'gccode', 'visitdate', 'type' }, filter = filter, order = 'OLDESTFIRST' } )

local bestDate = false
local bestCount = 0
local lastDate = false
local bestTypes = { }
local currentTypes = { }
local loops = 0

for _,v in ipairs(myFinds) do
	if lastDate == false then
		if currentTypes[v['type']] == nil then
			currentTypes[v['type']] = v['gccode']
		end
	elseif lastDate == v['visitdate'] then
		if currentTypes[v['type']] == nil then
			currentTypes[v['type']] = v['gccode']
		end
    	
	else
		local count = 0
    	local countE = 0
    
    	for k,_ in pairs(currentTypes) do
      		if k == "Event Cache" or k == "Cache In Trash Out Event" or k == "Mega-Event Cache" or k == "Giga-Event Cache" or k == "Community Celebration Event" or k == "GPS Adventures Maze Exhibit" or k == "Geocaching HQ Celebration" or k == "Geocaching HQ Block Party" or k == "GPS Adventures Maze Exhibit" then
        		countE = countE+1
        	end
      	end
    
		for k,_ in pairs(currentTypes) do      		
      		count = count+1
		end    	
		
    	  	
    
		if count == limit and countE <= 1 then
      		--PGC.print(lastDate, "\n")
			bestCount = count
      		bestE = countE
			bestDate = lastDate
			bestTypes = TableCopy(currentTypes)
			PGC.print('Found a new record, ' .. bestCount .. ' at ' .. bestDate .. ', including ' .. countE .. ' event type', "\n")
      		loops = loops + 1
		end

		currentTypes = { }
		currentTypes[v['type']] = v['gccode']
	end

	lastDate = v['visitdate']
end

local count = 0
local countE = 0
    
for k,_ in pairs(currentTypes) do
   if k == "Event Cache" or k == "Mega-Event Cache" or k == "Cache In Trash Out Event" or k == "Giga-Event Cache" or k == "Cache In Trash Out Event" or k == "Community Celebration Event" or k == "GPS Adventures Maze Exhibit" or k == "Geocaching HQ Celebration" or k == "Geocaching HQ Block Party" or k == "GPS Adventures Maze Exhibit" then
     countE = countE+1
   end
end

for k,_ in pairs(currentTypes) do
	count = count+1
end


if count == limit and countE <= 1 then
  bestDate = lastDate
  loops = loops + 1
end

if bestDate ~= false then
  if count == limit and countE <= 1 then
      bestCount = count
      bestE = countE
      bestDate = lastDate
      bestTypes = TableCopy(currentTypes)
      PGC.print('Found a new record, ' .. bestCount .. ' at ' .. bestDate .. ', including ' .. countE .. ' event type', "\n")
  end

  PGC.print('Final result, ' .. bestCount .. ' at ' .. bestDate, "\n")
end

local ok = false
local log = {}
local html = {}
local tmplog = ""
local tmphtml = ""

if bestCount == limit then
	ok = true
  	tmplog = 'Túto challenge sa mi podarilo splniť ' .. loops .. '-krát.'
  	table.insert(log,tmplog)
	
  
  	if bestE == 1 then
    	tmplog = 'Dňa [b]'  .. bestDate .. '[/b] som našiel presne [b]' .. limit .. '[/b] rôznych typov kešiek (z nich ' .. bestE .. ' druh eventu).'
    	tmphtml = 'I completed this challenge ' .. loops .. '-times.'
    	table.insert(html,tmphtml.."<br>")
  		tmphtml = 'On <b>' .. bestDate .. '</b> I found <u>exactly</u> <b>'  .. limit .. '</b> different cache types, including ' .. bestE .. ' event.'
  		table.insert(html,tmphtml.."<hr>")
    	tmphtml = 'Túto challenge sa mi podarilo splniť ' .. loops .. '-krát.'
    	table.insert(html,tmphtml.."<br>")
  		tmphtml = 'Dňa <b>'  .. bestDate .. '</b> som našiel <u>presne</u> <b>' .. limit .. ' rôznych typov kešiek</b>, z toho ' .. bestE .. ' druh eventu.'
    else
    	tmplog = 'Dňa [b]'  .. bestDate .. '[/b] som našiel presne [b]' .. limit .. '[/b] rôznych typov kešiek (medzi nimi žiadny event).'
    	tmphtml = 'I completed this challenge ' .. loops .. '-times.'
    	table.insert(html,tmphtml.."<br>")
    	tmphtml = 'On <b>'  .. bestDate .. '</b> I found <u>exactly</u> <b> ' .. limit .. '</b> different cache types (none of them was event).'
  		table.insert(html,tmphtml.."<hr>")
    	tmphtml = 'Túto challenge sa mi podarilo splniť ' .. loops .. '-krát.'
    	table.insert(html,tmphtml.."<br>")
  		tmphtml = 'Dňa <b>'  .. bestDate .. '</b> som našiel <u>presne</u> <b>' .. limit .. ' rôznych typov kešiek</b> (medzi nimi žiadny event).'
    end
else
	tmphtml = 'The challenge is to find EXACTLY <b>' .. limit .. ' different cache types</b> (<u>not more</u>, not less) in 1 day (only 1 of the types can be an event).'
  	table.insert(html,tmphtml.."<br>")
  	tmphtml = profileName .. ' did not make it yet.'
  	table.insert(html,tmphtml.."<hr>")
  	tmphtml = 'Úlohou je nájsť PRESNE <b>' .. limit .. ' rôznych typov kešiek za deň</b> (<u>nie viac</u>, nie menej), z toho maximálne jeden druh eventu.'
  	table.insert(html,tmphtml.."<br>")
  	tmphtml = profileName .. ' zatiaľ nesplnil túto podmienku.'
  	table.insert(html,tmphtml)
end

if ok == true then
  	table.insert(log,tmplog)
	table.insert(html,tmphtml.."<hr>")
  
  	table.insert(log,"")
  	local fields={"type", "GC Code", "Cache Name"}
  	table.insert(html,"<Table><tr><th>"..table.concat(fields,"</th><th>").."</th></tr>")
  		
  	for type,gccode in pairs(bestTypes) do
  		local cacheName = PGC.HTMLEscape(PGC.Gccode2CacheName(gccode))
    	local gclink = "<a href=http://www.geocaching.com/geocache/" .. gccode .. ">" .. gccode .. "</a>"
    	local lglink = "[url=http://www.geocaching.com/geocache/" .. gccode .. "]" .. gccode .. "[/url]"
    	local sz = "<img src=" .. types[type] .. ">"
		local fieldshtml={sz,gclink,cacheName}
    	local fieldslog={type,": ",lglink,cacheName}
    
		table.insert(log,table.concat(fieldslog," "))
   		table.insert(html,"<tr><td>"..table.concat(fieldshtml,"</td><td>").."</td></tr>")
	end

    table.insert(log,"")
	table.insert(html,"</Table>")
end
  
	log = table.concat(log, "\n")
	html = table.concat(html, "\n")



return { ok = ok, log = log, html = html }