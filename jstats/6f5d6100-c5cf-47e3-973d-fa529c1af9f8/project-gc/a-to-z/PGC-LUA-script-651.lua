local args={...}
conf = args[1].config

profileName = args[1]['profileName']
PGC.print('Got profile name, ', profileName, "\n")
profileId = PGC.ProfileName2Id(profileName)
PGC.print('Converted to id ', profileId, "\n")

fields = { 'gccode', 'cache_name', 'visitdate', 'log_id', 'placed_by' }
Finds = PGC.GetFinds( profileId, { fields = fields, order = 'OLDESTFIRST' } )

local log = ""
local logOK = ""
local numLetters = 0
local numL = 0
htmlCaches = "<table  class='table'>"
htmlCaches = htmlCaches .. "<tr><th>Status</th><th>Character</th><th>GC code</th><th>Cache name</th><th>Visit date</th></tr>"
lang = conf.language
local k = 26

if conf.language == nil then
  lang = "english"
else
  lang = "slovak"
end

if lang == "slovak" then
  alphabetBig = {'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'CH', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'}
  alphabetSmall = {'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'ch', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'}
  k = 27
else
  alphabetBig = {'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'}
  alphabetSmall = {'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'}
end
  
  
for a=1,k do
  for _,v in pairs(Finds) do
    cacheName = string.lower(v['cache_name'])
    if (string.find(cacheName, alphabetSmall[a]) == 1 and numL ~= a and a ~= 3) then
      numLetters = numLetters + 1
      numL = numL + 1
      htmlCaches = htmlCaches .. "<tr><td><img src='/images/check16.png' /></td><td><strong>" .. alphabetBig[a] .. "</strong></td><td><a href='http://coord.info/" .. v['gccode'] .. "' target='_blank'><img src='/images/external.png' /></a> " .. v['gccode'] .. "</td><td>" .. v['cache_name'] .. "</td><td>" .. v['visitdate'] .. "</td></tr>"
      logOK = logOK .. "[b]" .. alphabetBig[a] .. "[/b] - " .. v['gccode'] .. " - " .. v['cache_name'] .. " ([url=http://www.geocaching.com/seek/log.aspx?lid=" .. v['log_id'] .. "]log[/url])\n"
    elseif (string.find(cacheName, alphabetSmall[a]) == 1 and string.find(cacheName, "h") ~= 2 and numL ~= a and a == 3) then
      numLetters = numLetters + 1
      numL = numL + 1
      htmlCaches = htmlCaches .. "<tr><td><img src='/images/check16.png' /></td><td><strong>" .. alphabetBig[a] .. "</strong></td><td><a href='http://coord.info/" .. v['gccode'] .. "' target='_blank'><img src='/images/external.png' /></a> " .. v['gccode'] .. "</td><td>" .. v['cache_name'] .. "</td><td>" .. v['visitdate'] .. "</td></tr>"
      logOK = logOK .. "[b]" .. alphabetBig[a] .. "[/b] - " .. v['gccode'] .. " - " .. v['cache_name'] .. " ([url=http://www.geocaching.com/seek/log.aspx?lid=" .. v['log_id'] .. "]log[/url])\n"
    end
  end 
  if (numL ~= a) then
    htmlCaches = htmlCaches .. "<tr><td><img src='/images/cancel16.png' /></td><td><strong>" .. alphabetBig[a] .. "</strong></td><td> - </td><td> - </td><td> - </td></tr>"
    numL = numL + 1
  end  
end

-- alphabet of owners START

--info = ""
--local numLettersO = 0
--local numL = 0

--for a=1,k do
--  for _,v in pairs(Finds) do
--    placedBy = string.lower(v['placed_by'])
--    placedBy = v['placed_by']
--    if (string.find(placedBy, alphabetSmall[a]) == 1 and numL ~= a and a ~= 3) then
--      numLettersO = numLettersO + 1
--      numL = numL + 1 
--      info = info .. alphabetBig[a] .. " - " .. v['placed_by'] .. " (" .. v['gccode'] ..")\n"
--    elseif (string.find(placedBy, alphabetSmall[a]) == 1 and string.find(placedBy, "h") ~= 2 and numL ~= a and a == 3) then
--      numLettersO = numLettersO + 1
--      numL = numL + 1
--      info = info .. alphabetBig[a] .. " - " .. v['placed_by'] .. " (" .. v['gccode'] ..")\n"
--    end
--  end 
--  if (numL ~= a) then
--    info = info .. alphabetBig[a] .. " -\n"
--    numL = numL + 1
--  end  
--end

--PGC.print(info, "\n")

-- alphabet of owners END


htmlCaches = htmlCaches .. "</table>"
html = htmlCaches

if (numLetters == k) then
  ok = true
  if lang == 'slovak' then
  	log = log .. "Našiel som kešky s týmito názvami:\n\n"
  else
    log = log .. "I found caches with these names:\n\n"
  end
  log = log .. logOK
end

return { ok = ok, log = log, html = html }