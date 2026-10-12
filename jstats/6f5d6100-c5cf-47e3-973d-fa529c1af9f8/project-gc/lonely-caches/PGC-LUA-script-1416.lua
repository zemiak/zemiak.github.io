local args={...}
local conf = args[1].config
local profileName = args[1].profileName
local profileId = args[1].profileId
-- PGC.print produces debug log
PGC.print('Got profile name, ', profileName, "\n")


local filter = {}
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

local threshold = 31
if(conf.threshold ~= nil) then
	threshold = conf.threshold
end

local limit = 1
if(conf.limit ~= nil) then
	limit = conf.limit
end


local finds = PGC.GetFinds(profileId, { fields = {'gccode', 'cache_name', 'visitdate', 'country', 'hidden', 'last_publish_date', 'last_archive_date', 'num_finds'}, order = 'OLDESTFIRST', filter = filter })
local count = 0
local today = Date {}

local ok = false
local log = {}
local html = {"<table><tr><th>GC code</th><th>Name</th><th>Age</th><th>Number of Finds</th><th>Loneliness</th></tr><tr><td>"}

function toDate(string)
  local d = Date {year = tonumber(string.sub(string,1,4)), month = tonumber(string.sub(string,6,7)), day = tonumber(string.sub(string,9,10))}
  return d
end

for _,f in ipairs(finds) do
  local from = toDate(f['hidden'])
  if (f['last_publish_date'] ~= nil) then
    from = toDate(f['last_publish_date'])
  end
  local to = today
  if (f['last_archive_date'] ~= nil) then
    to = toDate(f['last_archive_date'])
  end
  
  local interval = math.ceil((to['time'] - from['time'])/(60*60*24) - 0.5)
  
  local loneliness = interval / f['num_finds']
  
  if (loneliness >= threshold) then
    count = count + 1
    local line = {}
    table.insert(line,f['gccode'])
    table.insert(line,f['cache_name'])
    table.insert(line,interval)
    table.insert(line,f['num_finds'])
    table.insert(line,loneliness)
    table.insert(log,table.concat(line,"\t"))
    table.insert(html,table.concat(line,"</td><td>"))
  end
end

if (count >= limit) then
  ok = true
end


log = table.concat(log, "\n")
html = table.concat(html, "</td></tr><tr><td>").."</td></tr></table>"

return { ok = ok, log = log, html = html }
