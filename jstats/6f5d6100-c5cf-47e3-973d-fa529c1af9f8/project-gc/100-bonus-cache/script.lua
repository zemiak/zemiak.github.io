local args = {...}
local conf = args[1].config
local profileName = args[1].profileName
local profileId = args[1].profileId
-- PGC.print produces debug log
PGC.print('Got profile name, ', profileName, "\n")

-- Given a bit index, get the value if that bit was set to 1
-- e.g.  given 4, set the fourth bit from the right to 1.  Result:  8
function bit(p)
  return 2 ^ (p - 1)  -- 1-based indexing
end

local reqCachesCount = conf.reqCachesCount * 1 or 1
-- 69 --Bonus cache
local bitMask = bit(5) -- 69 - 32 - 32

fields = { 'attributes_set' }
Finds = PGC.GetFinds( profileId, { fields = fields, filter = filter, order = 'OLDESTFIRST' } )

local findsTotal = 0
local foundInCountries = {}

-- Given a bitfield and bitmask, AND the two to determine if the bitmask is set in this field.
function hasbit(x, p)
  return x % (p + p) >= p
end

-- Take an attribute field from the GC data, and an attribute number, and figure if that attribute is set/unset
function processAttributes(attributesBits, gccode)
  	if hasbit(attributesBits, bitMask) then
		return true
  	end
  	return false
end

for _,v in pairs(Finds) do
  	local attrFound = processAttributes(v.attributes_set_3, v.gccode)
  
  	if attrFound == true then
    	findsTotal = findsTotal + 1
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


-- Check if challenge is fulfilled and if so, set ok = true
-- ok = true
if findsTotal >= reqCachesCount then
	ok = true
end

if(ok == true) then
  -- Produce example log, Project-GC recommends using Markdown if it's useful.
  -- Do not use  log = log .. "foo"  in loops with many iterations, it consumes a lot of memory in LUA.
  log = {}
  	table.insert(log, "Počet nalezených bonus keší: " .. findsTotal .. " z potřebných " .. reqCachesCount .. ".")
  	log = table.concat(log, "\n")
end


--[[
-- Allow unattended checks to return without worrying about generating logs, html, or maps
if args[1].environmentSettings.cli then
  return { ok = ok}
end
--]]


--[[
More feedback can be given by producing html into the html variable.
Can be of good use to show the user his/her progress.
Doesn't actually have to be html.
PGC.HTMLEscape can be used to html-escape variables that might need it. For example usernames containing characters like '<'.
--]]
function ShowIcon(condition)
	if (condition == true) then
    	return "<img src=\"/images/check16.png\">"
    else
    	return "<img src=\"/images/cancel16.png\">"
    end
end

local statustable = { }
table.insert(statustable, "<span style=\"font-size:18px;\">" .. ShowIcon(ok) .. " Počet nalezených bonus keší: <b>" .. findsTotal .. "</b> z potřebných " .. reqCachesCount .. ".</span>")
html = table.concat(statustable, "<br>")


return { ok = ok, log = log, html = html }
