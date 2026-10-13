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
end


function compSort(t,a,b)
    if conf.parameter_comparison=="GTEQ" or conf.parameter_comparison== nil then
    	return tonumber(t[b]['elevation']) < tonumber(t[a]['elevation'])
    elseif conf.parameter_comparison=="LTEQ" then
    	return tonumber(t[b]['elevation']) > tonumber(t[a]['elevation'])
    else
      return tonumber(t[b]['elevation']) < tonumber(t[a]['elevation'])
	end
end


function compTest(a,b)
	if conf.parameter_comparison == "GTEQ" or conf.parameter_comparison== nil then
    	return tonumber(b) <= tonumber(a)
    elseif conf.parameter_comparison == "LTEQ" then
    	return tonumber(b) >= tonumber(a)
    else
      return tonumber(b) <= tonumber(a)
    end
end

function collectTypes (list)
  local set = {}
  local c = 0
  for _, t in ipairs(list) do
    c = c + 1
    set[c] = t.type
  end
  return set
end

local args = {...}
conf = args[1].config
local profileName = args[1].profileName
local profileId = args[1].profileId
    
-- PGC.print produces debug log
PGC.print('Got profile name, ', profileName, "\n")
local conf_nr = 0
for _,v in pairs(conf) do
  conf_nr = conf_nr + 1
end
if conf_nr == 0 then
  return{ ok = {}, log = {}, html = {}}
end

local filter = {}
local allowedTypes = collectTypes(conf.allowedTypes)
filter['types'] = allowedTypes
filter['country'] = conf.allowedCountries


fields = {'gccode', 'cache_name', 'country', 'visitdate', 'elevation'}

-- Get data for as few fields as possible to reduce memory usage. A full list of fields can be found at http://project-gc.com/doxygen/lua-sandbox/classPGC__LUA__Sandbox.html#a8b8f58ee20469917a29dc7a7f751d9ea
local finds = PGC.GetFinds(profileId, { fields = fields, order = 'OLDESTFIRST', filter = filter })

local tmp = {}
for _,v in ipairs(finds) do
  if v.elevation then table.insert(tmp,v) end
end
finds = tmp


-- Do calculations
local nr_t1 = 0
local thr_t1 = conf.height
local t1_needed = conf.needed

local okfinds = {}
local used = {}
local elevation = 0

   for _, c in spairs(finds, compSort) do
	if used[c['gccode']] == nil then
    used[c['gccode']] = 1
    if conf.correction ~= nil then
      c['elevation'] = tonumber(c['elevation']) + tonumber(conf.correction)
    else
      c['elevation'] = tonumber(c['elevation'])
    end
    if (tonumber(c['elevation']) >= thr_t1) then
	 		nr_t1 = nr_t1 + 1
    	table.insert(okfinds, c)
    end
  end
end

local log = false
local html = false
local ok = false
local t1_ok = false

if nr_t1 >= t1_needed then
  ok = true
end

local pname = "Elevation"

log = {}
html = {}
local v
if ok then
  local tmplog = "I found "..nr_t1.." needed caches with at least "..thr_t1.." "..pname
  table.insert(log, tmplog)
  table.insert(html, tmplog.."<br>")
else
  local tmplog = "I found "..nr_t1.." caches of "..t1_needed.." needed with at least "..thr_t1.." "..pname
  table.insert(log, tmplog)
  table.insert(html, tmplog.."<br>")
end

table.insert(html, "<table><tr><th>gccode</th><th>"..pname.."</th><th>Visitdate</th><th>Name</th></tr>")
table.insert(log, "[code]")

for i,c in ipairs(okfinds) do
  table.insert(log, string.format("%-7s %5s ",c['gccode'], c['elevation'].." "..c['visitdate'].." "..c['cache_name']))
  table.insert(html, "<tr><td>"..c['gccode'].."</td><td>"..c['elevation'].."</td><td>"..c['visitdate'].."</td><td>"..c['cache_name'].."</td></tr>")
end

table.insert(log, "[/code]")
table.insert(html, "</table>")
log = table.concat(log, "\n")
html = table.concat(html, "\n")

return { ok = ok, log = log, html = html }
