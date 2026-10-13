local args = {...}
local conf = args[1].config
local profileName = args[1].profileName
local profileId = args[1].profileId
local gccode = args[1].gccode -- gccode from the tag
-- PGC.print produces debug log
PGC.print('Got profile name, ', profileName, "\n")

local filter = conf['filter'] or { }
filter['types'] = filter['types'] or conf.types

local repetitions = conf.repetitions * 1 or 1

fields = { 'type' }
Finds = PGC.GetFinds( profileId, { fields = fields, filter = filter, order = 'OLDESTFIRST' } )

local letterboxCount  = 0
local wherigoCount = 0
local virtualCount = 0

for _,v in pairs(Finds) do
	if (v.type == 'Letterbox Hybrid') then
    	letterboxCount = letterboxCount + 1
    end
  	if (v.type == 'Wherigo Cache') then
    	wherigoCount = wherigoCount + 1
    end
  	if (v.type == 'Virtual Cache') then
    	virtualCount = virtualCount + 1
    end
end

--[[
-- Get data for as few fields as possible to reduce memory usage. A full list of fields can be found at http://project-gc.com/doxygen/lua-sandbox/classPGC__LUA__Sandbox.html#a8b8f58ee20469917a29dc7a7f751d9ea
-- We are injecting the conf.filter variable straight into GetFinds here. This adds automatic dynamic to the checker script
local finds = PGC.GetFinds(profileId, { fields = {'gccode', 'cache_name', 'visitdate', 'country'}, order = 'OLDESTFIRST', filter = conf.filter })
--]]


--[[
-- Do calculations
for _,f in ipairs(finds) do
  ..

  PGC.GetCPUUsage() can be used to see how many seconds has passed, according to the Sandbox itself.
end
--]]



local ok = false
local log = false
local html = false

if (letterboxCount >= repetitions and wherigoCount >= repetitions and virtualCount >= repetitions) then
	ok = true
end


-- Check if challenge is fulfilled and if so, set ok = true
-- ok = true

if(ok == true) then
  	-- Produce example log, Project-GC recommends using Markdown if it's useful.
  	-- Do not use  log = log .. "foo"  in loops with many iterations, it consumes a lot of memory in LUA.
  	log = {}
  
	table.insert(log, "Počet nalezených letterbox keší: " .. letterboxCount .. " z " .. repetitions .. ".")
	table.insert(log, "Počet nalezených wherigo keší: " .. wherigoCount .. " z " .. repetitions .. ".")
	table.insert(log, "Počet nalezených virtual keší: " .. virtualCount .. " z " .. repetitions .. ".")
  	log = table.concat(log, "\n")
end


--[[
-- Allow unattended checks to return without worrying about generating logs, html, or maps
if args[1].environmentSettings.cli then
  return { ok = ok}
end
--]]

function ShowIcon(condition)
	if (condition == true) then
    	return "<img src=\"/images/check16.png\">"
    else
    	return "<img src=\"/images/cancel16.png\">"
    end
end

local statustable = { }
table.insert(statustable, "<span style=\"font-size:18px;\">" .. ShowIcon(letterboxCount >= repetitions) .. " Počet nalezených letterbox keší: <b>" .. letterboxCount .. "</b> z " .. repetitions .. ".</span>")
table.insert(statustable, "<span style=\"font-size:18px;\">" .. ShowIcon(wherigoCount >= repetitions) .. " Počet nalezených wherigo keší: <b>" .. wherigoCount .. "</b> z " .. repetitions .. ".</span>")
table.insert(statustable, "<span style=\"font-size:18px;\">" .. ShowIcon(virtualCount >= repetitions) .. " Počet nalezených virtual keší: <b>" .. virtualCount .. "</b> z " .. repetitions .. ".</span>")
html = table.concat(statustable, "<br>")



--[[
More feedback can be given by producing html into the html variable.
Can be of good use to show the user his/her progress.
Doesn't actually have to be html.
PGC.HTMLEscape can be used to html-escape variables that might need it. For example usernames containing characters like '<'.
--]]


return { ok = ok, log = log, html = html }
