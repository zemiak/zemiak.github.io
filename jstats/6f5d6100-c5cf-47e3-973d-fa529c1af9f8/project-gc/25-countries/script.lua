function GetKeysSortedByValue(tbl, compare)
  local keys = {}
  for key in pairs(tbl) do
    table.insert(keys, key)
  end

  table.sort(keys, function(key1, ke2)
    return compare(tbl[key1], tbl[ke2])
  end)
  return keys
end

function CompareFunction(value1, value2)
  return value1 > value2 
end

local args={...}
local conf = args[1].config
local profileName = args[1].profileName
local profileId = args[1].profileId
if(conf.numberOfCaches == nil) then
	conf.numberOfCaches = 2
end
if(conf.numberOfCountries == nil) then
	conf.numberOfCountries = 20
end
local finds = PGC.GetFinds(profileId, { fields = {'country'}, order = 'OLDESTFIRST', filter = filter })

local numberOfCountries = 0
local countries = {}
local qualifiedCountries = {}
for _,f in ipairs(finds) do
	if countries[f['country']] == nil then
    	countries[f['country']] = 0    	
    end
  	countries[f['country']] = countries[f['country']] +1
  	if countries[f['country']] >= conf.numberOfCaches then
    	if qualifiedCountries[f['country']] == nil then
      		numberOfCountries = numberOfCountries +1
      	end
    	qualifiedCountries[f['country']] = countries[f['country']]    	
    end
end

local ok = false
local log = false
local html = false

if(numberOfCountries >= conf.numberOfCountries) then
  ok = true
end

if(ok == true) then
  local sortedQualifiedCountries = GetKeysSortedByValue(qualifiedCountries, CompareFunction)
  log = {}
  texts = { "Requirements fulfilled with", conf.numberOfCaches, "or more finds in", numberOfCountries, "countries as follows:\n"}
  text = table.concat(texts, " ")
  table.insert(log, text)
  for _, country in pairs(sortedQualifiedCountries) do
    texts = { country, qualifiedCountries[country]}
  	text = table.concat(texts, " ")
    table.insert(log, text)    
  end
  log = table.concat(log, "\n")
else
  local missing = conf.numberOfCountries - numberOfCountries  
  texts = { "You have", conf.numberOfCaches, "or more finds in", numberOfCountries, " countries and need another", missing, "countries to fulfill the requirements!"}
  html = table.concat(texts, " ")
end


return { ok = ok, log = log, html = html }



