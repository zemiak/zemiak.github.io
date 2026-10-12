function remove_crazy_caches(finds)
  local crazy_caches = PGC.GetBookmarklist("BMAFMJR", {} )
  local codes = {}
  for _,code in ipairs(crazy_caches) do
    codes[code] = true
  end
  local res={}
  for _,f in ipairs(finds) do
    if not codes[f.gccode] and f.type~="Locationless Cache" then
      table.insert(res, f)
    end
  end
  return res
end

function min(a,b)
  if a<b then return a else return b end
end

function hsort(mytable)
  table.sort(mytable,function(a,b) return tonumber(a.elevation)>tonumber(b.elevation) end)
  return mytable
end  

function gclink(gccode)
  return "[url=http://coord.info/" .. gccode .. "]" .. gccode .. "[/url]"
end

function hgclink(gccode)
  return "<a href='http://coord.info/" .. gccode .. "'>" .. gccode .. "</a>"
end

function formatNumber(n)
    local s = tostring(n)
    repeat
        s, k = s:gsub("^(-?%d+)(%d%d%d)", "%1'%2")
    until k == 0
    return s
end

local args={...}
local conf = args[1].config
local profileName = args[1].profileName
local profileId = args[1].profileId
-- PGC.print produces debug log
PGC.print('Got profile name, ', profileName, "\n")

function altitude(h)
  if conf.alternative_unit then
    local val=h*conf.alternative_unit.ratio
    if val>100 then
      val=val+0.5
      val=val-val%1
    else
      val=val+0.005
      val=val-val%0.01
    end
    return h.."m ("..val..conf.alternative_unit.name..")"
  end
  return h.."m"
end



-- Example filter code
local filter = conf.filter or {}
if conf.countries then filter.country = conf.countries end
if conf.types then filter.types=conf.types end
if not conf.nrCountries then conf.nrCountries=1 end

if  not conf.sumDiffAltitude
and not conf.totDiffAltitude
and not conf.totTraveled 
and not conf.sumAltitude
then
  conf.sumAltitude=0
end

local get_parms={ fields = {'gccode', 'cache_name', 'visitdate', 'hidden', 'country', 'region', 'county', 'elevation', 'type' }, 
                                        order = 'OLDESTFIRST', 
                                        filter = filter 
                                      }
-- Get data for as few fields as possible to reduce memory usage. A full list of fields can be found at http://project-gc.com/doxygen/lua-sandbox/classPGC__LUA__Sandbox.html#a8b8f58ee20469917a29dc7a7f751d9ea
local finds = PGC.GetFinds(profileId, get_parms)

if conf.own then
  local own=PGC.GetHides(profileId, get_parms)
--  PGC.print(own[1])
  for _, v in ipairs(own) do
    v.own=true
    v.visitdate=v.hidden.." (placed)"
    table.insert(finds, v)
  end
end

finds=remove_crazy_caches(finds)

local excludedTypes={}
if conf.excludedTypes then
  for _,t in ipairs(conf.excludedTypes) do
    excludedTypes[t]=true
  end  
end

local states={}
local nrcountries=0
local all={}
local totTraveled=0
local prev=nil

-- Do calculations
for _,v in ipairs(finds) do
  if  v.country ~= nil 
  and v.elevation~=nil 
  and ( not conf.minAltitude or v.elevation+0 >= conf.minAltitude )
  and excludedTypes[v.type]==nil 
  then
    if prev and (v.elevation>prev or not conf.onlyClimbing) then
      totTraveled=totTraveled+math.abs(v.elevation-prev)
    end
   	prev=v.elevation
    table.insert(all,v)  
    if states[v.country]==nil then 
      states[v.country]={} 
      nrcountries=nrcountries+1
    end
    table.insert(states[v.country], v)
  end  
end


local topPerState={}
for s,t in pairs(states) do
--  PGC.print("state ",s,"\n")
  states[s]=hsort(states[s])
  table.insert(topPerState, {country=s, highest=states[s][1], diff=states[s][1].elevation-states[s][ #states[s] ].elevation})
end

local loglist={}
local ok = false
local log = {}
local html = {}

if conf.sumDiffAltitude then

-- SUM DIFF ALTITUDE CHECK  
  
  table.sort(topPerState, function(a,b) return a.diff>b.diff end)
  local totDiff=0
  table.insert(log, "I have found:")
  table.insert(html, "You have found:<table>")
  for i,c in ipairs(topPerState) do
    local s=states[c.country]
    local h=s[1]
    local l=s[#s]
    totDiff=totDiff+c.diff
    table.insert(log,c.country..", altitude difference="..altitude(c.diff))
    table.insert(log,"&nbsp;&nbsp;highest: "..altitude(h.elevation).." "..gclink(h.gccode).." "..h.cache_name.." on "..h.visitdate)
    table.insert(log,"&nbsp;&nbsp;lowest:  "..altitude(l.elevation).." "..gclink(l.gccode).." "..l.cache_name.." on "..l.visitdate)
    table.insert(log,"")

    table.insert(html,"<tr><td colspan=5>"..c.country..", altitude difference="..altitude(c.diff).."</td></tr>")
    table.insert(html,"<tr><td>&nbsp;&nbsp;highest:</td><td>"..altitude(h.elevation).."</td><td>"..hgclink(h.gccode).."</td><td>"..h.cache_name.."</td><td>"..h.visitdate.."</td></tr>")
    table.insert(html,"<tr><td>&nbsp;&nbsp;lowest:</td><td>"..altitude(l.elevation).."</td><td>"..hgclink(l.gccode).."</td><td>"..l.cache_name.."</td><td>"..l.visitdate.."</td></tr>")
    table.insert(html,"<tr><td colspan=5>&nbsp;</td></tr>")
--    if i==conf.nrCountries then break end
  end
  table.insert(log,"Total altitude difference = **"..altitude(totDiff).."**")    
  table.insert(html,"</table>Total altitude difference = <font color='red'><strong>"..altitude(totDiff).."</strong></font>")    
  ok=totDiff >= conf.sumDiffAltitude and #topPerState>=conf.nrCountries
--  PGC.print(topPerState)
elseif conf.totDiffAltitude then

-- TOTAL DIFFERENCE OF ALTITUDE
  if not conf.nrCouples then conf.nrCouples=1 end
  if #all<2*conf.nrCouples then
    return {ok=false, log=false, html="You have found less than "..(2*conf.nrCouples).." qualified caches"}
  end
  hsort(all)
--  PGC.print(all)
  ok=true
  table.insert(html,"<table>")  
  for i=1,conf.nrCouples do
    local h=all[i]
    local l=all[#all-conf.nrCouples+i]
    local totDiff=h.elevation-l.elevation

    table.insert(log,"altitude difference=**"..altitude(totDiff).."**")
    table.insert(log,"&nbsp;&nbsp;highest: "..altitude(h.elevation).." "..gclink(h.gccode).." "..h.cache_name.." on "..h.visitdate.." in "..h.country)
    table.insert(log,"&nbsp;&nbsp;lowest:  "..altitude(l.elevation).." "..gclink(l.gccode).." "..l.cache_name.." on "..l.visitdate.." in "..l.country)

    table.insert(html,"<tr><td colspan=5>altitude difference=<font color='red'>"..altitude(totDiff).."</font></td></tr>")
    table.insert(html,"<tr><td>&nbsp;&nbsp;highest:</td><td>"..altitude(h.elevation).."</td><td>"..hgclink(h.gccode).."</td><td>"..h.cache_name.."</td><td>"..h.visitdate.."</td><td>"..h.country.."</td></tr>")
    table.insert(html,"<tr><td>&nbsp;&nbsp;lowest:</td><td>"..altitude(l.elevation).."</td><td>"..hgclink(l.gccode).."</td><td>"..l.cache_name.."</td><td>"..l.visitdate.."</td><td>"..l.country.."</td></tr>")
    if totDiff < conf.totDiffAltitude then ok=false end
  end  
  table.insert(html,"</table>")  
  
elseif conf.totTraveled then

  ok=totTraveled>=conf.totTraveled
  if ok then
    log={"I have travelled for **"..altitude(totTraveled).."** of elevation"}
    html={"You have travelled for <font color='red'>"..altitude(totTraveled).."</font> of elevation, so you have fulfilled the challenge"}  
  else
    log={}
    html={"You have travelled only for <font color='red'>"..altitude(totTraveled).."</font> of elevation, so you have not fulfilled the challenge"}
  end  
  
else
-- SUM ALTITUDE CHECK

  local used={}
  table.sort(topPerState, function(a,b) return tonumber(a.highest.elevation)>tonumber(b.highest.elevation) end)
-- first we must get the top caches from top N countries and remove it from the lists
  local totNr=0
  local countNr=0
  for i=1,min(conf.nrCountries,#topPerState) do
    local country=topPerState[i].country
    local v=states[country][1]
    table.insert(loglist, v)
    used[v.gccode]=true
    totNr=totNr+1
    countNr=countNr+1
  end
  hsort(all)
  for x,v in ipairs(all) do
	PGC.print(x,"\n")
    if used[v.gccode]==nil then
      totNr=totNr+1
      table.insert(loglist,v)
      if totNr==conf.nrCaches then break end
    end
  end
  if totNr==0 then
    return {html="Sorry, you have not found any qualified cache"}
  end
  if conf.order_by_altitude then
--    table.sort(loglist,function(a,b) return (conf.order_by_altitue==1) == (a.elevation<b.elevation) end) -- it does not work, but hopefully the table is already ordered by elevation :-)
  else  
    table.sort(loglist,function(a,b) return a.visitdate<b.visitdate end)
  end
-- generate log and html
  local newstate={}
  local nrcountries=0
  for i,v in ipairs(loglist) do
    local state=v.country
    local hstate=state
    if newstate[state]==nil then 
      newstate[state]=true 
      hstate="<font color='red'><strong>"..state.."</strong></font>:"
      state="** "..state.." ** :"
      nrcountries=nrcountries+1
    end
    if conf.nrCountries==1 then
      state=""
      hstate=""
    end
    if not conf.brief then 
      table.insert(log, i..": "..state..formatNumber(altitude(v.elevation)).." "..gclink(v.gccode).." "..v.cache_name.." on "..v.visitdate)
      table.insert(html, "<tr><td>"..i..":</td><td>"..hstate.."</td><td>"..formatNumber(altitude(v.elevation)).."</td><td>"..hgclink(v.gccode).."</td><td>"..v.cache_name.."</td><td>"..v.visitdate.."</td></tr>")
    end
  end  
  if not conf.title then
    local incountries
    if nrcountries>1 then
      incountries=nrcountries.." countries"
    else
      incountries=loglist[1].country
    end
    local orPlaced=conf.own and "or placed " or ""
    table.insert(log,1,"I have found "..orPlaced..totNr.." qualified caches in "..incountries..":")
    table.insert(html,1,"You have found "..orPlaced..totNr.." qualified caches in "..incountries..":<table>")
  else
    loglist[1].nr=totNr
    local title=conf.title:gsub("%[(.-)%]", function(tag) return loglist[1][tag] end)
    table.insert(log,1,title)
    table.insert(html,1,title.."<table>")
  end
  local sum=0
  for _,v in ipairs(loglist) do
    sum=sum+v.elevation
  end  
  table.insert(log,"Total altitude = **"..formatNumber(altitude(sum)).."**")    
  table.insert(html,"</table>Total altitude = <font color='red'><strong>"..formatNumber(altitude(sum)).."</strong></font>")    
  if conf.sumAltitude>0 then
  	ok=sum>=conf.sumAltitude and nrcountries >= conf.nrCountries
  else
    PGC.print("totNr", totNr, "conf.nrCaches", conf.nrCaches)
    ok=totNr >= conf.nrCaches
  end
--  PGC.print("total altitude=",sum,"\n")
--  PGC.print(loglist)
  
end




log = table.concat(log, "\n")
html = table.concat(html)
if not ok then log=false end    
    
return { ok = ok, log = log, html = html }
