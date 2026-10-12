local events={
  "GPS Adventures Maze Exhibit",
  "Community Celebration Event",
  "Cache In Trash Out Event",
  "Mega-Event Cache",
  "Giga-Event Cache",
  "Event Cache"
}


local allowed_types={
  "GPS Adventures Maze Exhibit",      -- event
  "Community Celebration Event",  -- event
  "EarthCache",
  "Multi-Cache",
  "Webcam Cache",
  "Cache In Trash Out Event",    -- event
  "Wherigo Cache",
  "Virtual Cache",
  "Mystery Cache",
  "Traditional Cache",
  "Letterbox Hybrid",
--  "Geocaching HQ Cache",
  "Mega-Event Cache",            -- event
  "Giga-Event Cache",            -- event
  "Event Cache",                 -- event
--  "Project A.P.E. Cache",
--  "Geocaching HQ Cache",
--  "Benchmark",
  "Locationless Cache",
--  "GPS Adventures Maze Exhibit",
--  "Geocaching HQ Celebration",
  "Geocaching HQ Block Party",
  "GPS Adventures Maze Exhibit"  
}


evLookup={}
for i,e in ipairs(events) do
  evLookup[e]=true
end  

function isEvent(type)
  return evLookup[type]~=nil  
end

function gclink(code)
  return "[url=http://coord.info/" .. code .. "]" .. code .. "[/url]"
end  

function hgclink(code, name)
  if not name then name='' end
  return "<a href='http://coord.info/" .. code .. "'>" .. code .. "</a>"
end  

function align(str, width)
  local l=str:len()
  for i=1,width-l do
    str=str.." "
  end
  return str
end

local args={...}
local conf = args[1].config
local profileName = args[1].profileName
local profileId = args[1].profileId
-- PGC.print produces debug log
PGC.print('Got profile name, ', profileName, "\n")


-- Example filter code
local filter = {}
--[[
if(conf.country ~= nil) then
	filter['country'] = conf.country
end
--]]
filter.types=allowed_types

-- Get data for as few fields as possible to reduce memory usage. A full list of fields can be found at http://project-gc.com/doxygen/lua-sandbox/classPGC__LUA__Sandbox.html#a8b8f58ee20469917a29dc7a7f751d9ea
local finds = PGC.GetFinds(profileId, { fields = {'gccode', 'type', 'county', 'cache_name', 'visitdate'}, order = 'OLDESTFIRST', filter = filter })

local month={}

-- Do calculations
for _,v in ipairs(finds) do
  local m=tonumber(v.visitdate:sub(6,7))
  if month[m]==nil then month[m]={} end
  local type=v.type
  --if isEvent(v.type) then type="Event" end
  if month[m][type]==nil then month[m][type]=v end
end


local ok = true
local log = {}
local html = {}


local monthname={
  "January",
  "February",
  "March",
  "April",
  "May",
  "June",
  "July",
  "August",
  "September",
  "October",
  "November",
  "December"
  }

local nbr = conf.nbr
local county = conf.county
  
local the8types=
{
  {type="Traditional Cache", 						w=10, text="Trad.",     	img= "http://www.geocaching.com/images/wpttypes/sm/2.gif"},
  {type="Multi-Cache",		 						w=10, text="Multi",     	img= "http://www.geocaching.com/images/wpttypes/sm/3.gif"},
  {type="Mystery Cache",	 						w=10, text="Mystery",   	img= "http://www.geocaching.com/images/wpttypes/sm/8.gif"},
  {type="Letterbox Hybrid",	 						w=10, text="Letterbox", 	img= "http://www.geocaching.com/images/wpttypes/sm/5.gif"},
  {type="Wherigo Cache",	 						w=10, text="Wherigo",   	img= "http://www.geocaching.com/images/wpttypes/sm/wherigo.gif"},
  {type="EarthCache",        						w=10, text="Earth",     	img= "http://www.geocaching.com/images/wpttypes/sm/earthcache.gif"},
  {type="Virtual Cache",	 						w=10, text="Virtual",   	img= "http://www.geocaching.com/images/wpttypes/sm/4.gif"},
  {type="Webcam Cache",		 						w=10, text="Webcam",    	img= "http://www.geocaching.com/images/wpttypes/sm/11.gif"},
  {type="Event Cache",								w=10, text="Event",     	img= "http://www.geocaching.com/images/wpttypes/sm/6.gif"},
  {type="Cache In Trash Out Event",					w=10, text="CITO",      	img= "http://www.geocaching.com/images/wpttypes/sm/13.gif"},
  {type="Mega-Event Cache",							w=10, text="Mega",      	img= "http://www.geocaching.com/images/wpttypes/sm/mega.gif"},
  {type="Giga-Event Cache",							w=10, text="Giga",      	img= "http://www.geocaching.com/images/wpttypes/sm/giga.gif"},
  {type="GPS Adventures Maze Exhibit",			 		w=10, text="Maze",     img= "http://www.geocaching.com/images/wpttypes/sm/maze.gif"},
  {type="Community Celebration Event",			 	w=10, text="Lost&Found",	img= "http://www.geocaching.com/images/wpttypes/sm/3653.gif"},
--  {type="Geocaching HQ Cache",							w=10, text="HQ",     		img= "http://www.geocaching.com/images/wpttypes/sm/3773.gif"},
--  {type="Project A.P.E. Cache", 						w=10, text="APE",       	img= "http://www.geocaching.com/images/wpttypes/sm/9.gif"},
--  {type="Geocaching HQ Celebration",	w=10, text="L&F Event", 	img= "http://www.geocaching.com/images/wpttypes/sm/3774.gif"},
  {type="Geocaching HQ Block Party",			 		w=10, text="Block Party",	img= "http://www.geocaching.com/images/wpttypes/sm/4738.gif"},
  {type="Locationless Cache",				w=10, text="L-less",    	img= "http://www.geocaching.com/images/wpttypes/sm/12.gif"}
--  {type="Benchmark",			 					w=10, text="Benchmark", 	img= "http://www.geocaching.com/images/wpttypes/sm/27.gif"},
--  {type="GPS Adventures Maze Exhibit",			 	w=10, text="Maze",      	img= "http://www.geocaching.com/images/wpttypes/sm/1304.gif"},
--  ["Project A.P.E. Cache"]							= "http://www.geocaching.com/images/wpttypes/sm/9.gif",
--  ["Webcam Cache"]								= "http://www.geocaching.com/images/wpttypes/sm/11.gif",
--  ["Cache In Trash Out Event"]					= "http://www.geocaching.com/images/wpttypes/sm/13.gif",
--  ["Mega-Event Cache"]							= "http://www.geocaching.com/images/wpttypes/sm/mega.gif",
--  ["Giga-Event Cache"]							= "http://www.geocaching.com/images/wpttypes/sm/giga.gif",
--  ["Geocaching HQ Cache"]							= "http://www.geocaching.com/images/wpttypes/sm/3773.gif",
--  ["Benchmark"]									= "http://www.geocaching.com/images/wpttypes/sm/27.gif",
--  ["Locationless Cache"]				= "http://www.geocaching.com/images/wpttypes/sm/12.gif",
--  ["Community Celebration Event"]				= "http://www.geocaching.com/images/wpttypes/sm/3653.gif",
--  ["GPS Adventures Maze Exhibit"]				= "http://www.geocaching.com/images/wpttypes/sm/1304.gif",
--  ["Geocaching HQ Celebration"]	= "http://www.geocaching.com/images/wpttypes/sm/3774.gif",
--  ["Geocaching HQ Block Party"]					= "http://www.geocaching.com/images/wpttypes/sm/4738.gif",
--  ["GPS Adventures Maze Exhibit"]					= "http://www.geocaching.com/images/wpttypes/sm/maze.gif"
}

table.insert(log, "I have found the following number of cache types per month:")
table.insert(html, "You have found the following cache types per month:<table>")
local line="<tr><td></td>"
local lline="          "
for _,t in ipairs(the8types) do
  line=line.."<td align='center'><img src='"..t.img.."'/></td>"
  lline=lline..align(t.text, t.w)
end                  
table.insert(html,line.."</tr>")

--table.insert(log,lline)
for m=1,12 do 
  line="<tr><td>"..monthname[m].."</td>"     
  lline=align(monthname[m],10).."[green]"
  local m=month[m]
  if m==nil then m={} end
  for _,t in ipairs(the8types) do
    local l="<font color='red'>missing</font>"
    local ll="[red]"..align("missing",t.w).."[/red]"
    if m[t.type] then 
      l=hgclink(m[t.type].gccode,m[t.type].cache_name) 
-- log too long      ll=gclink(m[t.type].gccode)..align(" ",t.w-m[t.type].gccode:len())
      ll=align(m[t.type].gccode,t.w)
    end
    line=line.."<td>"..l.."</td>"
    lline=lline..ll
  end   
  table.insert(html,line.."</tr>");  
--table.insert(log,lline.."[/green]")
end 


table.insert(html,"</table><br/><table>")
--table.insert(log,"[/code]")
for i=1,12 do
  local ms={}
  if month[i]==nil then month[i]={} end
  for _,v in pairs(month[i]) do
    table.insert(ms, v)
  end
  table.sort(ms, function(a,b) return a.visitdate<b.visitdate end)
  table.insert(log, monthname[i].." ("..#ms..")")
  table.insert(html, "<tr><td colspan=5><B>"..monthname[i].." ("..#ms.."):</B></td></tr>")
  if #ms==0 then
--    table.insert(log,"&nbsp;&nbsp;0. nothing")
    table.insert(html,"<tr><td></td><td colspan=4>0. nothing</td></tr>")
  else
    for i,v in ipairs(ms) do
--      table.insert(log,"&nbsp;&nbsp;"..i..". "..v.type.." on "..v.visitdate.." "..gclink(v.gccode).." "..v.cache_name)
      table.insert(html,"<tr><td>&nbsp;</td><td>"..i..". "..v.type.."</td><td>on "..v.visitdate.."</td><td>"..hgclink(v.gccode).."</td><td>"..v.cache_name.."</td></tr>")
    end  
  end
  if #ms<nbr then ok=false end
--  table.insert(log,"");
  table.insert(html,"<tr><td colspan=5></td></tr>")
end
table.insert(html,"</table>")  


log = table.concat(log, "\n")
html = table.concat(html)
if not ok then log=false end


return { ok = ok, log = log, html = html }
