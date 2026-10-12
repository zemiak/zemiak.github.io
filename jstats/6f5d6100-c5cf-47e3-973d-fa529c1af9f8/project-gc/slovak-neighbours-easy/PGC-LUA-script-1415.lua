local args={...}

profileName = args[1]['profileName']
PGC.print('Got profile name, ', profileName, "\n")
profileId = PGC.ProfileName2Id(profileName)
PGC.print('Converted to id ', profileId, "\n")

fields = { 'gccode', 'cache_name', 'visitdate', 'country', 'log_id' }
Finds = PGC.GetFinds( profileId, { fields = fields, order = 'OLDESTFIRST' } )

local log = ""
local logOK = ""
htmlCaches = "<table>"

CzechiaFound = false
PolandFound = false
AustriaFound = false
HungaryFound = false
UkraineFound = false
numCountry = 0

for _,v in pairs(Finds) do
  if (v['country'] == 'Czechia' and CzechiaFound == false) then
    CzechiaFound = true
    numCountry = numCountry + 1
    htmlCaches = htmlCaches .. "<tr><td>CZ:</td><td><a href='http://coord.info/" .. v['gccode'] .. "' target='_blank'><img src='/images/external.png' /></a> " .. v['gccode'] .. "</td><td> - </td><td>" .. v['cache_name'] .. "</td><td>(<a href='http://www.geocaching.com/seek/log.aspx?lid=" .. v['log_id'] .. "' target='_blank'>log</a>)</td></tr>"
    logOK = logOK .. "CZ: " .. v['gccode'] .. " - " .. v['cache_name'] .. " ([url=http://www.geocaching.com/seek/log.aspx?lid=" .. v['log_id'] .. "]log[/url])\n"
  end
  if (v['country'] == 'Poland' and PolandFound == false) then
    PolandFound = true
    numCountry = numCountry + 1
    htmlCaches = htmlCaches .. "<tr><td>PL:</td><td><a href='http://coord.info/" .. v['gccode'] .. "' target='_blank'><img src='/images/external.png' /></a> " .. v['gccode'] .. "</td><td> - </td><td>" .. v['cache_name'] .. "</td><td>(<a href='http://www.geocaching.com/seek/log.aspx?lid=" .. v['log_id'] .. "' target='_blank'>log</a>)</td></tr>"
    logOK = logOK .. "PL: " .. v['gccode'] .. " - " .. v['cache_name'] .. " ([url=http://www.geocaching.com/seek/log.aspx?lid=" .. v['log_id'] .. "]log[/url])\n"
  end
  if (v['country'] == 'Austria' and AustriaFound == false) then
    AustriaFound = true
    numCountry = numCountry + 1
    htmlCaches = htmlCaches .. "<tr><td>AT:</td><td><a href='http://coord.info/" .. v['gccode'] .. "' target='_blank'><img src='/images/external.png' /></a> " .. v['gccode'] .. "</td><td> - </td><td>" .. v['cache_name'] .. "</td><td>(<a href='http://www.geocaching.com/seek/log.aspx?lid=" .. v['log_id'] .. "' target='_blank'>log</a>)</td></tr>"
    logOK = logOK .. "AT: " .. v['gccode'] .. " - " .. v['cache_name'] .. " ([url=http://www.geocaching.com/seek/log.aspx?lid=" .. v['log_id'] .. "]log[/url])\n"
  end
  if (v['country'] == 'Hungary' and HungaryFound == false) then
    HungaryFound = true
    numCountry = numCountry + 1
    htmlCaches = htmlCaches .. "<tr><td>HU:</td><td><a href='http://coord.info/" .. v['gccode'] .. "' target='_blank'><img src='/images/external.png' /></a> " .. v['gccode'] .. "</td><td> - </td><td>" .. v['cache_name'] .. "</td><td>(<a href='http://www.geocaching.com/seek/log.aspx?lid=" .. v['log_id'] .. "' target='_blank'>log</a>)</td></tr>"
    logOK = logOK .. "HU: " .. v['gccode'] .. " - " .. v['cache_name'] .. " ([url=http://www.geocaching.com/seek/log.aspx?lid=" .. v['log_id'] .. "]log[/url])\n"
  end  
   if (v['country'] == 'Ukraine' and UkraineFound == false) then
    UkraineFound = true
    numCountry = numCountry + 1
    htmlCaches = htmlCaches .. "<tr><td>UA:</td><td><a href='http://coord.info/" .. v['gccode'] .. "' target='_blank'><img src='/images/external.png' /></a> " .. v['gccode'] .. "</td><td> - </td><td>" .. v['cache_name'] .. "</td><td>(<a href='http://www.geocaching.com/seek/log.aspx?lid=" .. v['log_id'] .. "' target='_blank'>log</a>)</td></tr>"
    logOK = logOK .. "UA: " .. v['gccode'] .. " - " .. v['cache_name'] .. " ([url=http://www.geocaching.com/seek/log.aspx?lid=" .. v['log_id'] .. "]log[/url])\n"
  end 
end

htmlCaches = htmlCaches .. "</table>"
  
if (CzechiaFound == true and PolandFound == true and AustriaFound == true and HungaryFound == true and UkraineFound == true) then
  ok = true
  log = logOK
end

html = "<hr>"
if (ok) then
  html = html .. "<p><img src='/images/check16.png' /> You found caches in all <strong>5</strong> neighbouring countries.</p>"
else
  if (numCountry > 1) then
    html = html .. "<p><img src='/images/cancel16.png' /> You found caches only in <strong>" .. numCountry .. "</strong> neighbouring countries.</p>"
  else
    html = html .. "<p><img src='/images/cancel16.png' /> You found caches only in <strong>" .. numCountry .. "</strong> neighbouring country.</p>"
  end
end    

html = html .. "<hr>"
html = html .. htmlCaches 

return { ok = ok, log = log, html = html }