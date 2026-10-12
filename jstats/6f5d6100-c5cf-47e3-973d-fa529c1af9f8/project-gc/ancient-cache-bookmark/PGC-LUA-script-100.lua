local args={...}
conf = args[1].config

profileName = args[1]['profileName']
PGC.print('Got profile name, ', profileName, "\n")
profileId = PGC.ProfileName2Id(profileName)
PGC.print('Converted to id ', profileId, "\n")

bookmarkNum = tonumber(conf.booknum)

if (bookmarkNum == nil) then
  bookmarkNum = 1
end

local propertyHiden = conf.hiden
local propertyText = conf.text
local propertyList = conf.list
propertyPercentYN = conf.percentYN
if (propertyPercentYN == nil) then
  propertyPercentYN = "false"
end

propertyBookmark = { }
propertyBookmark[1] = conf.bookmark
propertyBookmark[2] = conf.bookmark2
propertyBookmark[3] = conf.bookmark3
propertyBookmark[4] = conf.bookmark4
propertyBookmark[5] = conf.bookmark5

local propertyPercent = tonumber(conf.percent)
  
fieldsF = { 'gccode', 'cache_name', 'visitdate', 'log_id' }
fieldsH = { 'gccode', 'cache_name' }
Finds = PGC.GetFinds( profileId, { fields = fieldsF, order = 'OLDESTFIRST' } )
Hides = PGC.GetHides( profileId, { fields = fieldsH, order = 'OLDESTFIRST' } )

local log = ""
local logOK = ""
htmlCachesFound = "<table>"
htmlCachesHiden = "<table>"

numBookFound = 0
numBookHides = 0
numBookCaches = 0
local Bookm = ""

for nb=1,bookmarkNum do
  Bookm = PGC.GetBookmarklist( propertyBookmark[nb] )
  if (Bookm == false) then
    PGC.print("A", "\n")
  end
  numBookCachesH = 0
  for _,v in pairs(Bookm) do
    numBookCachesH = numBookCachesH + 1
  end

  PGC.print("Pocet v bookmarku: " .. numBookCachesH, "\n")

  if (propertyPercentYN == "true") then
    propertyValue = ( numBookCachesH * propertyPercent ) / 100
    propertyValue = propertyValue + 0.5 - (propertyValue + 0.5) % 1
    PGC.print(propertyValue .. "\n")
  else
    propertyValue = tonumber(conf.value)
    PGC.print(propertyValue .. "\n")
  end

  for a=0,numBookCachesH do
    for _,v in pairs(Finds) do
      if (Bookm[a] == v['gccode']) then
        numBookFound = numBookFound + 1
        if (numBookFound == 1) then
          PGC.print(v['visitdate'] .. " " .. v['gccode'] .. " " .. v['cache_name'] .. "\n")
        end
        if (numBookFound == propertyValue) then
          PGC.print(v['visitdate'] .. " " .. v['gccode'] .. " " .. v['cache_name'] .. "\n")
        end
        htmlCachesFound = htmlCachesFound .. "<tr><td>" .. numBookFound .. "</td><td><a href='http://coord.info/" .. v['gccode'] .. "' target='_blank'><img src='/images/external.png' /></a> " .. v['gccode'] .. "</td><td> - </td><td>" .. v['cache_name'] .. "</td><td>(<a href='http://www.geocaching.com/seek/log.aspx?lid=" .. v['log_id'] .. "' target='_blank'>log</a>)</td></tr>"
        if (propertyValue > 50) then
          if (numBookFound <= propertyValue) then
            logOK = logOK .. "[" .. numBookFound .. ".] " .. v['visitdate'] .. " " .. v['gccode'] .. " " .. v['cache_name'] .. " \n"
          end
        else
          if (numBookFound <= propertyValue) then
            logOK = logOK .. "[" .. numBookFound .. ".] " .. v['visitdate'] .. " " .. v['gccode'] .. " " .. v['cache_name'] .. " ([url=http://www.geocaching.com/seek/log.aspx?lid=" .. v['log_id'] .. "]log[/url])\n"
          end
        end
      end
    end
  end   

  firstHides = false
  for a=0,numBookCachesH do
    for _,v in pairs(Hides) do
      if (Bookm[a] == v['gccode']) then
        if (firstHides == false) then
          firstHides = true
          htmlCachesHiden = htmlCachesHiden .. "<tr><td> </td><td>Placed caches</td> <td></td> <td></td></tr>"
        end
        numBookHides = numBookHides + 1
        htmlCachesHiden = htmlCachesHiden .. "<tr><td>" .. numBookHides .. "</td><td><a href='http://coord.info/" .. v['gccode'] .. "' target='_blank'><img src='/images/external.png' /></a> " .. v['gccode'] .. "</td><td> - </td><td>" .. v['cache_name'] .. "</td></tr>"
        numBook = numBookFound + numBookHides
        if (numBook <= propertyValue) then
          logOK = logOK .. "[" .. numBook .. ".] (owner) " .. v['gccode'] .. " " .. v['cache_name'] .. "\n"
        end      
      end
    end
  end
  
numBookCaches = numBookCaches + numBookCachesH

end

if (bookmarkNum > 1) then
  PGC.print("Nalezeno v bookmarcich: " .. numBookFound, "\n")
  PGC.print("Zalozeno v bookmarcich: " .. numBookHides, "\n")
else
  PGC.print("Nalezeno v bookmarku: " .. numBookFound, "\n")
  PGC.print("Zalozeno v bookmarku: " .. numBookHides, "\n")
end

htmlCachesFound = htmlCachesFound .. "</table>"
htmlCachesHiden = htmlCachesHiden .. "</table>"

if (propertyHiden == "true") then
    numBook = numBookFound + numBookHides
  else
    numBook = numBookFound
    numBookHides = 0
end
BookHides = ""
if (numBookHides > 0) then
  BookHides = "a zalozil "
end

numBookPercent = 0
numBookPercent = (numBook / numBookCaches) * 100
numBookPercent = numBookPercent + 0.5 - (numBookPercent + 0.5) % 1
PGC.print("Nalezeno a založeno v bookmarku (%): " .. numBookPercent, "%\n")

if (propertyPercentYN == "true") then
	if (numBookPercent >= propertyPercent) then
  		ok = true
  		log = log .. "Nalezl " .. BookHides .. "jsem [b]" .. numBookPercent .. "%[/b] kesi " .. propertyText .. ".\n" 
  		if (propertyList == "true") then
    		log = log .. logOK
  		end 
	end 
  else
	if (numBook >= propertyValue) then
  		ok = true
  		log = log .. "Nalezl " .. BookHides .. "jsem [b]" .. numBook .. "[/b] kesi " .. propertyText .. ".\n" 
  		if (propertyList == "true") then
    		log = log .. logOK
		end 
	end 
end

html = "<hr>"
if (ok) then
    if (numBookHides > 0) then
        html = html .. "<p><img src='/images/check16.png' /> You found and hiden <strong>" .. numBook .. "</strong> caches from bookmark.</p>"
      else
        html = html .. "<p><img src='/images/check16.png' /> You found <strong>" .. numBook .. "</strong> caches from bookmark.</p>"
    end
  else
    if (numBookHides > 0) then
        html = html .. "<p><img src='/images/cancel16.png' /> You found and hiden only <strong>" .. numBook .. "</strong> caches from bookmark.</p>"
      else  
        html = html .. "<p><img src='/images/cancel16.png' /> You found only <strong>" .. numBook .. "</strong> caches from bookmark.</p>"
    end
end 

html = html .. "<p>It is <strong>" .. numBookPercent .. "%</strong> of caches from bookmark.</p>"

html = html .. "<hr>"
html = html .. htmlCachesFound
if (numBookHides > 0) then
  html = html .. "<hr>"
  html = html .. htmlCachesHiden
end 

return { ok = ok, log = log, html = html }