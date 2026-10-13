local args={...}
conf = args[1].config
profileName = args[1]['profileName']
profileId = args[1]['profileId']
-- PGC.print produces debug log
PGC.print('Got profile name, ', profileName, "\n")


local filter = {} 
if conf.filter ~= nil then 
  filter = conf.filter 
end 


local excludeTypes = {}
if(conf.excludeTypes ~= nil) then
  for _,v in ipairs(conf.excludeTypes) do
    excludeTypes[v] = true
  end
end



local found = {}



--[[
Get data for as few fields as possible to reduce memory usage.
A full list of fields can be found at http://project-gc.com/doxygen/lua-sandbox/classPGC__LUA__Sandbox.html#a8b8f58ee20469917a29dc7a7f751d9ea
--]]
local myFinds = PGC.GetFinds(profileId, { fields = {'gccode', 'type', 'cache_name', 'visitdate', 'country', 'region', 'county'}, filter = filter, order = 'OLDESTFIRST' })


-- Do calculations
local found = {}
if(conf.countries ~= nil) then
  found['countries'] = {}
end
if(conf.regions ~= nil) then
  found['regions'] = {}
end
if(conf.counties ~= nil) then
  found['counties'] = {}
end

for _,f in ipairs(myFinds) do

  if(excludeTypes[f['type']] == nil) then
  
	  -- countries
  	if(conf.countries ~= nil and conf.countries[f['country']] ~= nil) then
      if(found['countries'][f['country']] == nil ) then
        found['countries'][f['country']] = 0
      end
      found['countries'][f['country']] = found['countries'][f['country']] + 1
    end

    -- regions
    if(conf.regions ~= nil and conf.regions[f['region']] ~= nil) then
      if(found['regions'][f['region']] == nil ) then
        found['regions'][f['region']] = 0
      end
      found['regions'][f['region']] = found['regions'][f['region']] + 1
    end

    --counties
    if(conf.counties ~= nil and conf.counties[f['county']] ~= nil) then
      if(found['counties'][f['county']] == nil ) then
        found['counties'][f['county']] = 0
      end
      found['counties'][f['county']] = found['counties'][f['county']] + 1
    end
  
  end
end





local ok = true
local log = {}
local html = {}


-- Check if challenge is fulfilled and if so, set ok = true
if(conf.countries ~= nil) then
  for country,numRequired in pairs(conf.countries) do
    if(found.countries[country] == nil) then
      ok = false
      table.insert(html, country .. ": 0 of " .. numRequired)
    elseif(found.countries[country] < numRequired) then
      ok = false
      table.insert(html, country .. ": " .. found.countries[country] .. " of " .. numRequired)
    else
      table.insert(log, country .. ": " .. found.countries[country])
      table.insert(html, country .. ": " .. found.countries[country] .. " OK")
    end
  end
end

if(conf.regions ~= nil) then
  for region,numRequired in pairs(conf.regions) do
    if(found.regions[region] == nil) then
      ok = false
      table.insert(html, region .. ": 0 of " .. numRequired)
    elseif(found.regions[region] < numRequired) then
      ok = false
      table.insert(html, region .. ": " .. found.regions[region] .. " of " .. numRequired)
    else
      table.insert(log, region .. ": " .. found.regions[region])
      table.insert(html, region .. ": " .. found.regions[region] .. " OK")
    end
  end
end

if(conf.counties ~= nil) then
  for county,numRequired in pairs(conf.counties) do
    if(found.counties[county] == nil) then
      ok = false
      table.insert(html, county .. ": 0 of " .. numRequired)
    elseif(found.counties[county] < numRequired) then
      ok = false
      table.insert(html, county .. ": " .. found.counties[county] .. " of " .. numRequired)
    else
      table.insert(log, county .. ": " .. found.counties[county])
      table.insert(html, county .. ": " .. found.counties[county] .. " OK")
    end
  end
end

log = table.concat(log, "\n")
html = table.concat(html, "<br>")

--[[
More advanced feedback can be given by producing html into the html var
Can be of good use to show the user his/her progress
Doesn't actually have to be html
--]]


return { ok = ok, log = log, html = html }
