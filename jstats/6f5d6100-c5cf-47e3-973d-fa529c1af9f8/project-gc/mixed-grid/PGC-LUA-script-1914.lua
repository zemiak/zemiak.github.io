local args={...}
local conf = args[1].config
local profileName = args[1].profileName
local profileId = args[1].profileId
local GCtitle={}
local filtertext={}
local types =
{
  ["Traditional Cache"]            = "http://www.geocaching.com/images/wpttypes/sm/2.gif",
  ["Multi-Cache"]                  = "http://www.geocaching.com/images/wpttypes/sm/3.gif",
  ["Virtual Cache"]                = "http://www.geocaching.com/images/wpttypes/sm/4.gif",
  ["Letterbox Hybrid"]             = "http://www.geocaching.com/images/wpttypes/sm/5.gif",
  ["Event Cache"]                  = "http://www.geocaching.com/images/wpttypes/sm/6.gif",
  ["Mystery Cache"]                = "http://www.geocaching.com/images/wpttypes/sm/8.gif",
  ["Project A.P.E. Cache"]            = "http://www.geocaching.com/images/wpttypes/sm/9.gif",
  ["Webcam Cache"]                 = "http://www.geocaching.com/images/wpttypes/sm/11.gif",
  ["EarthCache"]                   = "http://www.geocaching.com/images/wpttypes/sm/earthcache.gif",
  ["Cache In Trash Out Event"]     = "http://www.geocaching.com/images/wpttypes/sm/13.gif",
  ["Mega-Event Cache"]             = "http://www.geocaching.com/images/wpttypes/sm/mega.gif",
  ["Giga-Event Cache"]             = "http://www.geocaching.com/images/wpttypes/sm/giga.gif",
  ["Wherigo Cache"]                = "http://www.geocaching.com/images/wpttypes/sm/wherigo.gif",
  ["Geocaching HQ Cache"]               = "http://www.geocaching.com/images/wpttypes/sm/3773.gif",
  ["Benchmark"]	                   = "http://www.geocaching.com/images/wpttypes/sm/27.gif",
  ["Locationless Cache"] = "http://www.geocaching.com/images/wpttypes/sm/12.gif",
  ["10 Years! Event Cache"]        = "http://www.geocaching.com/images/wpttypes/sm/3653.gif",
  ["GPS Adventures Maze Exhibit"]  = "http://www.geocaching.com/images/wpttypes/sm/1304.gif",
  ["Community Celebration Event"]   = "http://www.geocaching.com/images/wpttypes/sm/3653.gif",
  ["Geocaching HQ Block Party"]      = "http://www.geocaching.com/images/wpttypes/sm/4738.gif",
  ["GPS Adventures Maze Exhibit"]       = "http://www.geocaching.com/images/wpttypes/sm/maze.gif",
  ["Geocaching HQ Celebration"]="http://www.geocaching.com/images/wpttypes/sm/3774.gif"
}
local Type_Icons  = {
    ["Traditional Cache"] =            "/images/gc-icons/traditional_16.gif",
    ["Multi-Cache"] =                  "/images/gc-icons/multi_16.gif",
    ["Mystery Cache"] =                "/images/gc-icons/unknown_16.gif",
    ["EarthCache"] =                   "/images/gc-icons/earthcache_16.gif",
    ["Letterbox Hybrid"] =             "/images/gc-icons/letter_16.gif",
    ["Wherigo Cache"] =                "/images/gc-icons/wherigo_16.gif",
    ["Virtual Cache"] =                "/images/gc-icons/virtual_16.gif",
    ["Webcam Cache"] =                 "/images/gc-icons/webcam_16.gif",
    ["Event Cache"] =                  "/images/gc-icons/event_16.gif",
    ["Cache In Trash Out Event"] =     "/images/gc-icons/cito_16.gif",
    ["Mega-Event Cache"] =             "/images/gc-icons/mega.gif",
    ["Locationless Cache"] = "/images/gc-icons/locationless_16.gif",
    ["checkbox"] =                     "/images/check16.png",
    ["Giga-Event Cache"] =             "/images/gc-icons/giga.gif",
    -- Not really the right icon for L&F-events.
    ["Community Celebration Event"] =   "/images/gc-icons/event_16.gif",
    ["Geocaching HQ Block Party"] =      "/images/gc-icons/4738_16.gif",
    ["Geocaching HQ Celebration"] = "/images/gc-icons/3774.gif",
    ["GPS Adventures Maze Exhibit"] =       "/images/gc-icons/2134.gif",
    ["Geocaching HQ Cache"] =               "/images/gc-icons/3773.gif",
    ["Project A.P.E. Cache"] =            "/images/gc-icons/ape_16.gif",
    ["Lab Cache"] =                    ""
}
local type_abbr = {
    ["Traditional Cache"] = "Tradi",
    ["Multi-Cache"] = "Multi",
    ["Mystery Cache"] = "Mystery",
    ["EarthCache"] = "Ec",
    ["Letterbox Hybrid"] = "LH",
    ["Wherigo Cache"] = "Wherigo",
    ["Virtual Cache"] = "Virtual",
    ["Webcam Cache"] = "Webcam",
    ["Event Cache"] = "Event",
    ["Cache In Trash Out Event"] = "CITO",
    ["Mega-Event Cache"] = "MEGA",
    ["Locationless Cache"] = "Locationless",
    ["Giga-Event Cache"] = "GIGA",
    ["Community Celebration Event"] = "CCE",
    ["Geocaching HQ Block Party"] = "HQ Block Party",
    ["Geocaching HQ Celebration"] = "HQ Celebration",
    ["GPS Adventures Maze Exhibit"] =  "GPSA",
    ["Geocaching HQ Cache"] = "HQ",
    ["Project A.P.E. Cache"] = "APE",
    ["Lab Cache"] = "Lab"
  }

local category1 = {"Fave","Events","Traditional Cache","Multi-Cache","Mystery Cache","EarthCache","Letterbox Hybrid","Wherigo Cache","Virtual Cache","All_nine"}
local category2 = {["Fave"]="0",["Events"]="1",["Traditional Cache"]="2",["Multi-Cache"]="3",["Mystery Cache"]="4",["EarthCache"]="5",["Letterbox Hybrid"]="6",["Wherigo Cache"]="7",["Virtual Cache"]="8",["All_nine"]="9"}

-- PGC.print produces debug log
PGC.print('Got profile name, ', profileName, "\n")
sometypes={"Traditional Cache","Mystery Cache","Multi-Cache","Virtual Cache","Letterbox Hybrid","EarthCache","Wherigo Cache"}
categories={"Virtual Cache","Event","Multi-Cache","Letterbox Hybrid","EarthCache","Wherigo Cache","Fave","Traditional Cache","Mystery Cache"}
events={"Cache In Trash Out Event","Event Cache", "Mega-Event Cache","Giga-Event Cache"}
fpthresh=10

-- added for additional input/outout
lang="en"
GCtitle=""
filtertext=""
--

--flag for detecting success
success=false
myexit = 0


if conf.events~=nil then 
  events=conf.events
end

if conf.fpthresh~=nil then
  fpthresh=conf.fpthresh
end

--added for additioinal input/output
if conf.lang~=nil then
  lang=conf.lang
end
if conf.GCcode~=nil then
  GCcode=conf.GCcode
end
if conf.GCtitle~=nil then
  GCtitle=conf.GCtitle
end
if conf.filtertext~=nil then
  filtertext=conf.filtertext
end
--
PGC.print(GCtitle)

filter = conf.filter

--restrict German output to German Speaking Countries
if GCtitle == "9x9 = 81 - Die gemischte Matrix Challenge" or GCtitle == "Kunterbunt (mixed D/T grid)" or GCtitle == "9x9 = 81 - Die gemischte Matrix Challenge reloaded" then
  lang="de"
  else
  lang=""
  end

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

nchoosek = {started=false,
  done=false,
  h=0,
  a={},
  m=0,
}
nchoosek.__index = nchoosek


function nchoosek:new()
  local self = setmetatable({}, nchoosek)
  self.started=false
  self.done=false
  return self
end

function nchoosek:reset()
  self.started=false
  self.done=false
  self.a={}
end

function nchoosek:next (n,k)
  if self.done then
    return
  end
  if self.started==false then
    self.m=0
    self.h=k
    self.started=true
  else
    if self.m<n-self.h then
      self.h=0
    end
    self.h=self.h+1
    self.m=self.a[k+1-self.h]
  end
  for j=1,self.h do

    self.a[k+j-self.h]=self.m+j
  end
  if self.a[1]==n-k+1 then
    self.done=true
  end
  return self.a
end

function nchoosek:isdone()
  return self.done
end


function check_if_possible2(solutionspace)
  --check that for each bundle of types 
  -- there are enough unique DT bins
  local scratch={}
  local counter=0
  local ccat={}
  for _,ind in pairs(solutionspace) do
    counter=counter+1
    ccat[counter]=_
  end

  local subset
  local subsetengine=nchoosek:new()

  local badbin=false

  for subsize=1,counter do
    subsetengine:reset()
    while not subsetengine:isdone() do
      subset=subsetengine:next(counter,subsize)
      local scratch2={}
      for _,ind in ipairs(subset) do
        table.insert(scratch2,ccat[ind])
      end
      if check_list_possible2(scratch2,solutionspace) then
        
        badbin=true
        return badbin
      end
    end
  end

  return badbin

end

function explainnotpossible(solutionspace)
  --check that for each bundle of types 
  -- there are enough unique DT bins
  local scratch={}
  local counter=0
  local ccat={}
  suggestbins={}
  suggestcounts={}
  for _,ind in pairs(solutionspace) do
    counter=counter+1
    ccat[counter]=_
  end

  local subset
  local subsetengine=nchoosek:new()

  local badbin=false

  for subsize=1,counter do
    subsetengine:reset()
    while not subsetengine:isdone() do
      subset=subsetengine:next(counter,subsize)
      local scratch2={}
      for _,ind in ipairs(subset) do
        table.insert(scratch2,ccat[ind])
      end
      if check_list_possible2(scratch2,solutionspace) then
        table.insert(suggestbins,scratch2)
        
        badbin=true
        
      end
    end
  end

  return badbin

end





function check_list_possible2(a,b)
  local counter=0
  local tcat
  local _
  local badbin=false
  for _,tcat in ipairs(a) do
    counter=counter+1
  end
  local c={}

  for _,tcat in ipairs(a) do
    c=setunion(c,b[tcat])
  end

  local bins=#c  

  if bins<counter*9 then
    PGC.print("Bins "..bins .." Counter "..counter.."\n")
    badbin=true
  end
  return badbin
end



function check_node2 (cnum,csolution)
  if cnum==nil then
    success=true
    return
  end
  PGC.print("Entering check_node2 "..cnum.." with "..#csolution[cnum].."\n")
  if #csolution[cnum]<9 then
    return
  end
  local subsetengine=nchoosek:new()
  subsetengine:reset()
  while not subsetengine:isdone() do
    subset=subsetengine:next(#csolution[cnum],9)
    local scratch2={}
    for _,ind in ipairs(subset) do
      table.insert(scratch2,csolution[cnum][ind])
    end
    local nextsolution={}
    local minsize=82
    local mincat
    for cat,_ in pairs(csolution) do
      --PGC.print(cat)
      if csolution[cat]~=nil and cat~=cnum then
        nextsolution[cat]=setdiff(csolution[cat],scratch2)
        --PGC.print(cat)
        --PGC.print(nextsolution[cat])
        if #nextsolution[cat]<minsize then
          minsize=#nextsolution[cat]
          mincat=cat
        end
      end
    end

    if minsize>=9 and check_if_possible2(nextsolution)==false then
      check_node2(mincat,nextsolution)
      if success==true then
        for trash, dd in ipairs(scratch2) do 
          sdiff = string.sub(dd,1,3)
          sterr=string.sub(dd,5,7)
         
          packedfinds[(sdiff)][(sterr)]['final']=packedfinds[(sdiff)][(sterr)][cnum]
          packedfinds[(sdiff)][(sterr)]['final']['reason']=cnum
        end
        return
      end
    else
      PGC.print("Blocked on "..mincat.."\n")
    end
    if myexit>100000 then
      return
    end
  end
  PGC.print("Exiting check_node2 "..cnum.."\n")
  myexit=myexit+1
end







function setdiff(a,b)
  local c={}

  for _, aa in ipairs(a) do
    local keep=true
    for _, bb in ipairs(b) do
      if (bb==aa) then 
        keep=false
      end
    end
    if keep==true then
      table.insert(c,aa)
    end
  end
  return c
end

function setunion(a,b)
  local c={}
  for _, aa in ipairs(a) do
    table.insert(c,aa)
  end
  for _, bb in ipairs(b) do
    local keep=true
    for _, aa in ipairs(a) do
      if (bb==aa) then 
        keep=false
      end
    end
    if keep==true then
      table.insert(c,bb)
    end
  end
  return c
end

--work in progress 
function PrintDT(DT)
    local DThtml={}
    local line='<table><tr><th></th><th>1.0</th><th>1.5</th><th>2.0</th><th>2.5</th><th>3.0</th><th>3.5</th><th>4.0</th><th>4.5</th><th>5.0</th><th></th></tr>'
    table.insert(DThtml,line)
    for i=1,9,1 do
      line="<tr><th>"..tostring((i+1)/2).."</th>"
      for j=1,9,1 do
        if DT[i][j]>0 then
          if conf['conditions']['min_fp'] then
            line=line..'<td class="align-center" style="color: #000000; background-color: #c8b600">'..DT[i][j]..': <a href="http://coord.info/'..FPMaxCache[i][j]['gccode']..'"><img src="'..types[FPMaxCache[i][j]['type']]..'" /><br />'..FPMax[i][j]..' <img src="https://www.geocaching.com/images/icons/fave_fill_16.png" /></a></td>'
          else
          	line=line..'<td class="align-center" style="color: #000000; background-color: #c8b600">'..DT[i][j].."</td>"
          end
        else
         line=line..'<td class="align-center" style="color: #000000; background-color: #FFFFFF">'..DT[i][j].."</td>"
        end
      end
      line=line..'<td class="align-center" style="color: #000000; background-color: #00b600">'..verticalSum[i].."</td>"
      line=line.."</tr>"
        table.insert(DThtml,line)
    end
    line="<tr><td>".."</td>"
    for i=1,9,1 do
        line=line..'<td class="align-center" style="color: #000000; background-color: #00b600">'..horizontalSum[i].."</td>" 
    end    
    line=line..'<td class="align-center" style="color: #000000; background-color: #b60000">'..sum.."<td></tr>"
    table.insert(DThtml,line)
    table.insert(DThtml,"</table>")
    return table.concat(DThtml)
  end
--
local ADT={}
for i=1,9,1 do
  ADT[i]={}
end
for i=1,9,1 do
   for j=1,9,1 do
  ADT[i][j]={}
end
end
for i=1,9,1 do
   for j=1,9,1 do
       for k=0,9,1 do
  ADT[i][j][k]={}
  ADT[i][j][k]=0
end
end
end

	local DT={}
	for i=1,9,1 do
	 local tmp={}
	 table.insert(DT,tmp)
	end
	for i=1,9,1 do
     for j=1,9,1 do
      DT[i][j]=0
	 end
	end

	local DT1={}
	for i=1,9,1 do
	 local tmp={}
	 table.insert(DT1,tmp)
	end
	for i=1,9,1 do
     for j=1,9,1 do
      DT1[i][j]=0
	 end
	end

	local DT2={}
	for i=1,9,1 do
	 local tmp={}
	 table.insert(DT2,tmp)
	end
	for i=1,9,1 do
     for j=1,9,1 do
      DT2[i][j]=0
	 end
	end

	local DT3={}
	for i=1,9,1 do
	 local tmp={}
	 table.insert(DT3,tmp)
	end
	for i=1,9,1 do
     for j=1,9,1 do
      DT3[i][j]=0
	 end
	end

	local DT4={}
	for i=1,9,1 do
	 local tmp={}
	 table.insert(DT4,tmp)
	end
	for i=1,9,1 do
     for j=1,9,1 do
      DT4[i][j]=0
	 end
	end

	local DT5={}
	for i=1,9,1 do
	 local tmp={}
	 table.insert(DT5,tmp)
	end
	for i=1,9,1 do
     for j=1,9,1 do
      DT5[i][j]=0
	 end
	end

	local DT6={}
	for i=1,9,1 do
	local tmp={}
	 table.insert(DT6,tmp)
	end
	for i=1,9,1 do
     for j=1,9,1 do
      DT6[i][j]=0
	 end
	end

	local DT7={}
	for i=1,9,1 do
	local tmp={}
	 table.insert(DT7,tmp)
	end
	for i=1,9,1 do
     for j=1,9,1 do
      DT7[i][j]=0
	 end
	end

	local DT8={}
	for i=1,9,1 do
	local tmp={}
	 table.insert(DT8,tmp)
	end
	for i=1,9,1 do
     for j=1,9,1 do
      DT8[i][j]=0
	 end
	end
--End work in progess
    
function getLastFind (profileId)
	lastFinds =  PGC.GetFinds( profileId, { fields = { 'gccode', 'visitdate', 'cache_name'}, 
				order = 'NEWESTFIRST', 
				limit = 1} )
	return lastFinds[1]
end
    
-- Get data for as few fields as possible to reduce memory usage. A full list of fields can be found at http://project-gc.com/doxygen/lua-sandbox/classPGC__LUA__Sandbox.html#a8b8f58ee20469917a29dc7a7f751d9ea
local finds = PGC.GetFinds(profileId, { fields = {'gccode', 'cache_name', 'visitdate', 'difficulty','terrain','favorite_points','type'}, order = 'OLDESTFIRST', filter = filter })

log={}
filterfindno={}
filterfindno=0
ffntradi={}
ffnmulti={}
ffnunkn={}
ffnec={}
ffnwh={}
ffnvi={}
ffnlbh={}
ffevent={}
ffnfav={}
ffnfavwc={}
ffeventall={}
ffntradi=0
ffnmulti=0
ffnunkn=0
ffnec=0
ffnwh=0
ffnvi=0
ffnlbh=0
ffevent=0
ffnfav=0
ffnfavwc=0
ffeventall=0
--pick one of each dt for each "category"
packedfinds={}
packedfinds['lists']={}
for _, cat in ipairs(categories) do
  packedfinds['lists'][cat]={}
end

for _,f in ipairs(finds) do

  filterfindno=filterfindno+1
  if f.type == "Traditional Cache" then
  ffntradi=ffntradi+1
  end
  if f.type == "Multi-Cache" then
  ffnmulti=ffnmulti+1
  end
  if f.type == "Mystery Cache" then
  ffnunkn=ffnunkn+1
  end
  if f.type == "EarthCache" then
  ffnec=ffnec+1
  end
  if f.type == "Letterbox Hybrid" then
  ffnlbh=ffnlbh+1
  end
  if f.type == "Wherigo Cache" then
  ffnwh=ffnwh+1   
  end
  if f.type == "Virtual Cache" then
  ffnvi=ffnvi+1   
  end
  if f.type == "Event Cache" then
  ffevent=ffevent+1 
  ffeventall=ffeventall+1
  end  
  if f.type == "Cache In Trash Out Event" or f.type == "Mega-Event Cache" or f.type == "Giga-Event Cache" then
-- not considered for Carnatic's challenge, but included in definition of "all" Events
-- f.type == "Geocaching HQ Block Party" or f.type == "Geocaching HQ Celebration" or f.type == "Community Celebration Event" 
  ffeventall=ffeventall+1
  end
  if tonumber(f.favorite_points)>=fpthresh then
  ffnfav=ffnfav+1 
   if f.type == "Webcam Cache" then  
   ffnfavwc=ffnfavwc+1
   end  
--to be considered for Carnatic's challenge for Favorite Points
   if f.type == "GPS Adventures Maze Exhibit" then  
   end
   if f.type == "Geocaching HQ Cache" then  
   end
   if f.type == "Project A.P.E. Cache" then  
   end
  end  

  
  
  
  
  
  d=(f['difficulty'])
  t=(f['terrain'])
  if packedfinds[d] == nil then
    packedfinds[d] = {}
  end

  if packedfinds[d][t]==nil then
    packedfinds[d][t]={}
    packedfinds[d][t]['cats']={};
  end

  -- for the ones that the bins are types
  for _, sometype in ipairs(sometypes) do
    if sometype == f.type then
      if packedfinds[d][t][f.type]==nil then
        packedfinds[d][t][f.type]=f
            
--different cachetypes (simple first try, only meant for Challenges Kunterbunt and Gemischte Matrix)
        local dd=d*2-1
        local tt=t*2-1
        if f.type == "Traditional Cache" then
        ADT[dd][tt][7]=ADT[dd][tt][7]+1
        ADT[dd][tt][9]=ADT[dd][tt][9]+1
        DT2[dd][tt]=DT2[dd][tt]+1
        end
        if f.type == "Multi-Cache" then
        ADT[dd][tt][5]=ADT[dd][tt][5]+1
        ADT[dd][tt][9]=ADT[dd][tt][9]+1
        DT3[dd][tt]=DT3[dd][tt]+1
        end
        if f.type == "Mystery Cache" then
        ADT[dd][tt][6]=ADT[dd][tt][6]+1
        ADT[dd][tt][9]=ADT[dd][tt][9]+1
        DT4[dd][tt]=DT4[dd][tt]+1
        end
        if f.type == "EarthCache" then
        ADT[dd][tt][4]=ADT[dd][tt][4]+1
        ADT[dd][tt][9]=ADT[dd][tt][9]+1
        DT5[dd][tt]=DT5[dd][tt]+1
        end
        if f.type == "Letterbox Hybrid" then
        ADT[dd][tt][3]=ADT[dd][tt][3]+1
        ADT[dd][tt][9]=ADT[dd][tt][9]+1
        DT6[dd][tt]=DT6[dd][tt]+1
        end
        if f.type == "Wherigo Cache" then
        ADT[dd][tt][2]=ADT[dd][tt][2]+1
        ADT[dd][tt][9]=ADT[dd][tt][9]+1
        DT7[dd][tt]=DT7[dd][tt]+1
        end
        if f.type == "Virtual Cache" then
        ADT[dd][tt][0]=ADT[dd][tt][0]+1
        ADT[dd][tt][9]=ADT[dd][tt][9]+1
        DT8[dd][tt]=DT8[dd][tt]+1
        end
--End different cachetypes (simple first try, only for Challenges Kunterbunt and Gemischte Matrix)
            
        --PGC.print(" "..f.type.." "..type_abbr[f.type].." \n")
        table.insert(packedfinds[d][t]['cats'],f.type)
        table.insert(packedfinds['lists'][f.type],string.format('%s,%s',d,t))
        --PGC.print(f.difficulty.." "..f.terrain.." "..f.type.."\n")
      end
    end
  end
  -- group all the event types together into the event reason.
  for _, sometype in ipairs(events) do
    if sometype == f.type then
      if packedfinds[d][t]["Event"]==nil then
        packedfinds[d][t]["Event"]=f
            
--different cachetypes (simple first try, only for Challenges Kunterbunt and Gemischte Matrix)
        local dd=d*2-1
        local dd=d*2-1
        local tt=t*2-1
      --  local c2 = category2[f.type]
        ADT[dd][tt][1]=ADT[dd][tt][1]+1
        ADT[dd][tt][9]=ADT[dd][tt][9]+1
        DT1[dd][tt]=DT1[dd][tt]+1
--End different cachetypes (simple first try, only for Challenges Kunterbunt and Gemischte Matrix)
            
        table.insert(packedfinds[d][t]['cats'],"Event")
        table.insert(packedfinds['lists']['Event'],string.format('%s,%s',d,t))
        --PGC.print(f.difficulty.." "..f.terrain.." EVENT "..f.type.."\n")
      end
    end
  end

  -- The favorite points reason.
  if tonumber(f.favorite_points)>=fpthresh then
    if packedfinds[d][t]["Fave"]==nil then
      packedfinds[d][t]["Fave"]=f
          
--different cachetypes (simple first try, only for Challenges Kunterbunt and Gemischte Matrix)
      local dd=d*2-1
      local tt=t*2-1
      --  local c2 = category2[f.type]
        ADT[dd][tt][8]=ADT[dd][tt][8]+1
        ADT[dd][tt][9]=ADT[dd][tt][9]+1
      DT[dd][tt]=DT[dd][tt]+1
--End different cachetypes (simple first try, only for Challenges Kunterbunt and Gemischte Matrix)
          
      table.insert(packedfinds[d][t]['cats'],"Fave")
      table.insert(packedfinds['lists']['Fave'],string.format('%s,%s',d,t))	
      --PGC.print(f.difficulty.." "..f.terrain.." FAVE "..f.type.."\n")
    end
  end
end





-- additional output - work in progress
FAVEhtml={}
local line={}
line="<br><br>"

line=line.."<b>[en] D/T found geocaches with at least "..fpthresh.." favorite points </b>("..profileName..")<br>"
if lang == "de" then
 line=line.."<b>[de] D/T-Matrix bereits gefundener Geocaches".."<br>".." mit mindestens "..fpthresh.." Favoritenpunkten </b>("..profileName..")<br>"
end
table.insert(FAVEhtml,line.."<br>")
local line='<table border=\"1\" ><tr><th></th><th>1.0</th><th>1.5</th><th>2.0</th><th>2.5</th>'
			..'<th>3.0</th><th>3.5</th><th>4.0</th><th>4.5</th><th>5.0</th></tr>'
table.insert(FAVEhtml,line)
local countsquares=0
for d=1.0,5.0,0.5 do
 line="<tr><th align=center>"..d.."</th>"
 for t=1.0,5.0,0.5 do
  local sd=string.format('%1.1f',d)
  local st=string.format('%1.1f',t)
  local dd=d*2-1
  local tt=t*2-1
  if DT[dd][tt] > 0 then
  countsquares=countsquares+1
  line=line.."<td align=center><img src=\"".."https://www.geocaching.com/images/icons/fave_fill_16.png".."\"></td>"
  else
  line=line.."<td></td>"
  end
 end
 line=line.."</tr>"
 table.insert(FAVEhtml,line)
end
line="</table>"
if countsquares < 9 then
  line=line.."[en] Geocaches with at least "..fpthresh.." favorite points need at least 9 different D/T, now you have <b>"..countsquares.."</b>.<br>"
  if lang == "de" then
  line=line.."[de] Es sind mindestens 9 unterschiedliche D/T für Geocaches mit mindestens "..fpthresh.." Favoritenpunkten nötig, bereits vorhanden: <b>"..countsquares.."</b>.<br>"  
  end
  else
  line=line.."[en] Geocaches with at least "..fpthresh.." favorite points: <b>"..countsquares.."</b> of 81 D/T squares filled.<br>"
  if lang == "de" then
  line=line.."[de] Geocaches mit mindestens "..fpthresh.." Favoritenpunkten: <b>"..countsquares.."</b> von 81 D/T bereits belegt.<br>"  
  end
  end
table.insert(FAVEhtml,line)
html0={}
html0=table.concat(FAVEhtml, "\n")


DT1html={}
local line={}
 line="<br><br><b>D/T Events </b>("..profileName..")<br>"
--DT2 "Traditional Cache"
--DT3 "Multi-Cache"
--DT4 "Unkown Cache"
--DT5 "EarthCache"
--DT6 "Letterbox Hybrid"
--DT7 "Wherigo Cache"
--DT8 "Virtual Cache"
table.insert(DT1html,line.."<br>")
local line='<table border=\"1\" ><tr><th></th><th>1.0</th><th>1.5</th><th>2.0</th><th>2.5</th>'
			..'<th>3.0</th><th>3.5</th><th>4.0</th><th>4.5</th><th>5.0</th></tr>'
table.insert(DT1html,line)
local countsquares=0
for d=1.0,5.0,0.5 do
 line="<tr><th align=center>"..d.."</th>"
 for t=1.0,5.0,0.5 do
  local sd=string.format('%1.1f',d)
  local st=string.format('%1.1f',t)
  local dd=d*2-1
  local tt=t*2-1
  if DT1[dd][tt] > 0 then
  countsquares=countsquares+1
  local sti=Type_Icons["Event Cache"]
  line=line.."<td align=center><img src=\""..sti.."\"></td>"
  else
  line=line.."<td></td>"
  end
 end
 line=line.."</tr>"
 table.insert(DT1html,line)
end
line="</table>"
if countsquares < 9 then
  line=line.."[en] Events need at least 9 different D/T, now you have <b>"..countsquares.."</b>.<br>"
  if lang == "de" then
  line=line.."[de] Es sind mindestens 9 unterschiedliche D/T für Events nötig, bereits vorhanden: <b>"..countsquares.."</b>.<br>"  
  end
  else
  line=line.."[en] Events: <b>"..countsquares.."</b> of 81 D/T squares filled.<br>"
  if lang == "de" then
  line=line.."[de] Events: <b>"..countsquares.."</b> von 81 D/T bereits belegt.<br>"  
  end
  end
table.insert(DT1html,line)
html1={}
html1=table.concat(DT1html, "\n")

DT2html={}
local line={}
 line="<br><br><b>D/T Traditional Cache </b>("..profileName..")<br>"
table.insert(DT2html,line.."<br>")
local line='<table border=\"1\" ><tr><th></th><th>1.0</th><th>1.5</th><th>2.0</th><th>2.5</th>'
			..'<th>3.0</th><th>3.5</th><th>4.0</th><th>4.5</th><th>5.0</th></tr>'
table.insert(DT2html,line)
local countsquares=0
for d=1.0,5.0,0.5 do
 line="<tr><th align=center>"..d.."</th>"
 for t=1.0,5.0,0.5 do
  local sd=string.format('%1.1f',d)
  local st=string.format('%1.1f',t)
  local dd=d*2-1
  local tt=t*2-1
  if DT2[dd][tt] > 0 then
  countsquares=countsquares+1
  local sti=Type_Icons["Traditional Cache"]
  line=line.."<td align=center><img src=\""..sti.."\"></td>"
  else
  line=line.."<td></td>"
  end
 end
 line=line.."</tr>"
 table.insert(DT2html,line)
end
line="</table>"
if countsquares < 9 then
  line=line.."[en] Traditional Cache needs at least 9 different D/T, now you have <b>"..countsquares.."</b>.<br>"
  if lang == "de" then
  line=line.."[de] Es sind mindestens 9 unterschiedliche D/T für Traditional Caches nötig, bereits vorhanden: <b>"..countsquares.."</b>.<br>"  
    end
    else
  line=line.."[en] Traditional Caches: <b>"..countsquares.."</b> of 81 D/T squares filled.<br>"
  if lang == "de" then
  line=line.."[de] Traditional Caches: <b>"..countsquares.."</b> von 81 D/T bereits belegt.<br>"  
  end
  end
table.insert(DT2html,line)
html2={}
html2=table.concat(DT2html, "\n")


DT3html={}
local line={}
 line="<br><br><b>D/T Multi-Cache </b>("..profileName..")<br>"
table.insert(DT3html,line.."<br>")
local line='<table border=\"1\" ><tr><th></th><th>1.0</th><th>1.5</th><th>2.0</th><th>2.5</th>'
			..'<th>3.0</th><th>3.5</th><th>4.0</th><th>4.5</th><th>5.0</th></tr>'
table.insert(DT3html,line)
local countsquares=0
for d=1.0,5.0,0.5 do
 line="<tr><th align=center>"..d.."</th>"
 for t=1.0,5.0,0.5 do
  local sd=string.format('%1.1f',d)
  local st=string.format('%1.1f',t)
  local dd=d*2-1
  local tt=t*2-1
  if DT3[dd][tt] > 0 then
  countsquares=countsquares+1
  local sti=Type_Icons["Multi-Cache"]
  line=line.."<td align=center><img src=\""..sti.."\"></td>"
  else
  line=line.."<td></td>"
  end
 end
 line=line.."</tr>"
 table.insert(DT3html,line)
end
line="</table>"
if countsquares < 9 then
  line=line.."[en] Multi-Cache needs at least 9 different D/T, now you have <b>"..countsquares.."</b>.<br>"
  if lang == "de" then
  line=line.."[de] Es sind mindestens 9 unterschiedliche D/T für Multicaches nötig, bereits vorhanden: <b>"..countsquares.."</b>.<br>"  
    end
      else
  line=line.."[en] Multi-caches: <b>"..countsquares.."</b> of 81 D/T squares filled.<br>"
  if lang == "de" then
  line=line.."[de] Multi-caches: <b>"..countsquares.."</b> von 81 D/T bereits belegt.<br>"  
  end
  end
table.insert(DT3html,line)
html3={}
html3=table.concat(DT3html, "\n")


DT4html={}
local line={}
 line="<br><br><b>D/T Mystery Cache </b>("..profileName..")<br>"
table.insert(DT4html,line.."<br>")
local line='<table border=\"1\" ><tr><th></th><th>1.0</th><th>1.5</th><th>2.0</th><th>2.5</th>'
			..'<th>3.0</th><th>3.5</th><th>4.0</th><th>4.5</th><th>5.0</th></tr>'
table.insert(DT4html,line)
local countsquares=0
for d=1.0,5.0,0.5 do
 line="<tr><th align=center>"..d.."</th>"
 for t=1.0,5.0,0.5 do
  local sd=string.format('%1.1f',d)
  local st=string.format('%1.1f',t)
  local dd=d*2-1
  local tt=t*2-1
  if DT4[dd][tt] > 0 then
  countsquares=countsquares+1
  local sti=Type_Icons["Mystery Cache"]
  line=line.."<td align=center><img src=\""..sti.."\"></td>"
  else
  line=line.."<td></td>"
  end
 end
 line=line.."</tr>"
 table.insert(DT4html,line)
end
line="</table>"
if countsquares < 9 then
  line=line.."[en] Mystery Cache needs at least 9 different D/T, now you have <b>"..countsquares.."</b>.<br>"
  if lang == "de" then
  line=line.."[de] Es sind mindestens 9 unterschiedliche D/T für Mystery Caches nötig, bereits vorhanden: <b>"..countsquares.."</b>.<br>"  
    end
      else
  line=line.."[en] Mystery Caches: <b>"..countsquares.."</b> of 81 D/T squares filled.<br>"
  if lang == "de" then
  line=line.."[de] Mystery Caches: <b>"..countsquares.."</b> von 81 D/T bereits belegt.<br>"  
  end
  end
table.insert(DT4html,line)
html4={}
html4=table.concat(DT4html, "\n")


DT5html={}
local line={}
 line="<br><br><b>D/T EarthCache </b>("..profileName..")<br>"
table.insert(DT5html,line.."<br>")
local line='<table border=\"1\" ><tr><th></th><th>1.0</th><th>1.5</th><th>2.0</th><th>2.5</th>'
			..'<th>3.0</th><th>3.5</th><th>4.0</th><th>4.5</th><th>5.0</th></tr>'
table.insert(DT5html,line)
local countsquares=0
for d=1.0,5.0,0.5 do
 line="<tr><th align=center>"..d.."</th>"
 for t=1.0,5.0,0.5 do
  local sd=string.format('%1.1f',d)
  local st=string.format('%1.1f',t)
  local dd=d*2-1
  local tt=t*2-1
  if DT5[dd][tt] > 0 then
  countsquares=countsquares+1
  local sti=Type_Icons["EarthCache"]
  line=line.."<td align=center><img src=\""..sti.."\"></td>"
  else
  line=line.."<td></td>"
  end
 end
 line=line.."</tr>"
 table.insert(DT5html,line)
end
line="</table>"
if countsquares < 9 then
  line=line.."[en] EarthCache needs at least 9 different D/T, now you have <b>"..countsquares.."</b>.<br>"
  if lang == "de" then
  line=line.."[de] Es sind mindestens 9 unterschiedliche D/T für Earthcaches nötig, bereits vorhanden: <b>"..countsquares.."</b>.<br>"  
    end
      else
  line=line.."[en] Earthcaches: <b>"..countsquares.."</b> of 81 D/T squares filled.<br>"
  if lang == "de" then
  line=line.."[de] Earthcaches: <b>"..countsquares.."</b> von 81 D/T bereits belegt.<br>"  
  end
  end
table.insert(DT5html,line)
html5={}
html5=table.concat(DT5html, "\n")


DT6html={}
local line={}
 line="<br><br><b>D/T Letterbox Hybrid </b>("..profileName..")<br>"
table.insert(DT6html,line.."<br>")
local line='<table border=\"1\" ><tr><th></th><th>1.0</th><th>1.5</th><th>2.0</th><th>2.5</th>'
			..'<th>3.0</th><th>3.5</th><th>4.0</th><th>4.5</th><th>5.0</th></tr>'
table.insert(DT6html,line)
local countsquares=0
for d=1.0,5.0,0.5 do
 line="<tr><th align=center>"..d.."</th>"
 for t=1.0,5.0,0.5 do
  local sd=string.format('%1.1f',d)
  local st=string.format('%1.1f',t)
  local dd=d*2-1
  local tt=t*2-1
  if DT6[dd][tt] > 0 then
  countsquares=countsquares+1
  local sti=Type_Icons["Letterbox Hybrid"]
  line=line.."<td align=center><img src=\""..sti.."\"></td>"
  else
  line=line.."<td></td>"
  end
 end
 line=line.."</tr>"
 table.insert(DT6html,line)
end
line="</table>"
if countsquares < 9 then
  line=line.."[en] Letterbox Hybrid needs at least 9 different D/T, now you have <b>"..countsquares.."</b>.<br>"
  if lang == "de" then
  line=line.."[de] Es sind mindestens 9 unterschiedliche D/T für Letterbox Hybrids nötig, bereits vorhanden: <b>"..countsquares.."</b>.<br>"  
    end
      else
  line=line.."[en] Letterbox Hybrid: <b>"..countsquares.."</b> of 81 D/T squares filled.<br>"
  if lang == "de" then
  line=line.."[de] Letterbox Hybrid: <b>"..countsquares.."</b> von 81 D/T bereits belegt.<br>"  
  end
  end
table.insert(DT6html,line)
html6={}
html6=table.concat(DT6html, "\n")


DT7html={}
local line={}
 line="<br><br><b>D/T Wherigo Cache </b>("..profileName..")<br>"
table.insert(DT7html,line.."<br>")
local line='<table border=\"1\" ><tr><th></th><th>1.0</th><th>1.5</th><th>2.0</th><th>2.5</th>'
			..'<th>3.0</th><th>3.5</th><th>4.0</th><th>4.5</th><th>5.0</th></tr>'
table.insert(DT7html,line)
local countsquares=0
for d=1.0,5.0,0.5 do
 line="<tr><th align=center>"..d.."</th>"
 for t=1.0,5.0,0.5 do
  local sd=string.format('%1.1f',d)
  local st=string.format('%1.1f',t)
  local dd=d*2-1
  local tt=t*2-1
  if DT7[dd][tt] > 0 then
  countsquares=countsquares+1
  local sti=Type_Icons["Wherigo Cache"]
  line=line.."<td align=center><img src=\""..sti.."\"></td>"
  else
  line=line.."<td></td>"
  end
 end
 line=line.."</tr>"
 table.insert(DT7html,line)
end
line="</table>"
if countsquares < 9 then
  line=line.."[en] Wherigo Cache needs at least 9 different D/T, now you have <b>"..countsquares.."</b>.<br>"
  if lang == "de" then
  line=line.."[de] Es sind mindestens 9 unterschiedliche D/T für Wherigos nötig, bereits vorhanden: <b>"..countsquares.."</b>.<br>"  
    end
      else
  line=line.."[en] Wherigo Caches: <b>"..countsquares.."</b> of 81 D/T squares filled.<br>"
  if lang == "de" then
  line=line.."[de] Wherigo Caches: <b>"..countsquares.."</b> von 81 D/T bereits belegt.<br>"  
  end
  end
table.insert(DT7html,line)
html7={}
html7=table.concat(DT7html, "\n")

DT8html={}
local line={}
 line="<br><br><b>D/T Virtual Cache </b>("..profileName..")<br>"
table.insert(DT8html,line.."<br>")
local line='<table border=\"1\" ><tr><th></th><th>1.0</th><th>1.5</th><th>2.0</th><th>2.5</th>'
			..'<th>3.0</th><th>3.5</th><th>4.0</th><th>4.5</th><th>5.0</th></tr>'
table.insert(DT8html,line)
local countsquares=0
for d=1.0,5.0,0.5 do
 line="<tr><th align=center>"..d.."</th>"
 for t=1.0,5.0,0.5 do
  local sd=string.format('%1.1f',d)
  local st=string.format('%1.1f',t)
  local dd=d*2-1
  local tt=t*2-1
  if DT8[dd][tt] > 0 then
  countsquares=countsquares+1
  local sti=Type_Icons["Virtual Cache"]
  line=line.."<td align=center><img src=\""..sti.."\"></td>"
  else
  line=line.."<td></td>"
  end
 end
 line=line.."</tr>"
 table.insert(DT8html,line)
end
line="</table>"
if countsquares < 9 then
  line=line.."[en] Virtual cache needs at least 9 different D/T, now you have <b>"..countsquares.."</b>.<br>"
  if lang == "de" then
  line=line.."[de] Es sind mindestens 9 unterschiedliche D/T für Virtual Caches nötig, bereits vorhanden: <b>"..countsquares.."</b>.<br>"  
    end
      else
  line=line.."[en] Virtual Caches: <b>"..countsquares.."</b> of 81 D/T squares filled.<br>"
  if lang == "de" then
  line=line.."[de] Virtual Caches: <b>"..countsquares.."</b> von 81 D/T bereits belegt.<br>"  
  end
  end
table.insert(DT8html,line)
html8={}
html8=table.concat(DT8html, "\n")


ADT9html={}
local line={}
--- temp warning
line=""
--    line='<h3 style="color:red">Attention, output might be cut off anywhere due to unannounced changes in project-gc'.."'"..'s challenge checker system (noticed September 13, 2017)</h3><br>'
-- temporary warning  

-- line="<br><br><b>All 9 cache types </b>("..profileName..")<br>(Favorite points >"..fpthresh..", Event, Traditional Cache, Multi-Cache, Mystery Cache, EarthCache, Letterbox Hybrid, Wherigo Cache, Virtual Cache)<br>"
 line=line.."<br><br><b>All 9 cache types </b>("..profileName..")<br>(Virtual Cache, Event, Wherigo Cache, Letterbox Hybrid, EarthCache, Multi-Cache, Mystery Cache, Traditional Cache, Favorite points >"..fpthresh..")<br>"
table.insert(ADT9html,line.."<br>")
local line='<table border=\"1\" ><tr><th style="text-align:center"></th><th style="text-align:center">1.0</th><th style="text-align:center">1.5</th><th style="text-align:center">2.0</th><th style="text-align:center">2.5</th>'
			..'<th style="text-align:center">3.0</th><th style="text-align:center">3.5</th><th style="text-align:center">4.0</th><th style="text-align:center">4.5</th><th style="text-align:center">5.0</th></tr>'
table.insert(ADT9html,line)
for d=1.0,5.0,0.5 do
 line='<tr><th style="text-align:center">'..d..'</th>'
 for t=1.0,5.0,0.5 do
  local sd=string.format('%1.1f',d)
  local st=string.format('%1.1f',t)
  local dd=d*2-1
  local tt=t*2-1
    line=line..'<td style="text-align:center">'
    for k=0,8,1 do
     local sr=ADT[dd][tt][k]
     local st1 = ""
     if sr > 0 then
     if k == 0 then
     st1=Type_Icons["Virtual Cache"]
     st1=types["Virtual Cache"]
     end
     if k == 1 then
     st1=Type_Icons["Event Cache"]
     st1=types["Event Cache"]
     end
     if k == 2 then
     st1=Type_Icons["Wherigo Cache"]
     st1=types["Wherigo Cache"]
     end
     if k == 3 then
     st1=Type_Icons["Letterbox Hybrid"]
     st1=types["Letterbox Hybrid"]
     end
     if k == 4 then
     st1=Type_Icons["EarthCache"]
     st1=types["EarthCache"]
     end
     if k == 5 then
     st1=Type_Icons["Multi-Cache"]
     st1=types["Multi-Cache"]
     end
     if k == 6 then
     st1=Type_Icons["Mystery Cache"]
     st1=types["Mystery Cache"]
     end
     if k == 7 then
     st1=Type_Icons["Traditional Cache"]
     st1=types["Traditional Cache"]
     end
     if k == 8 then
     st1="https://www.geocaching.com/images/icons/fave_fill_16.png"
     end
     if k == 2 or k == 5 then
     line=line.."<img align=\"middle\" src=\""..st1.."\"><br>"
     else
     line=line.."<img align=\"middle\" src=\""..st1.."\">"
     end
     else
     if k == 2 or k == 5 then
     line=line.."<font color=\"red\"> X  </font><br>"    
     else
     line=line.."<font color=\"red\"> X  </font>"   
     end
     end 
      
    end
    line=line.."</td>" 
 end
 line=line.."</tr>"
 table.insert(ADT9html,line)
end
line="</table>"
table.insert(ADT9html,line)
htmlall={}
--temporarily disable big display
htmlall=table.concat(ADT9html, "\n")
--htmlall=""
--- temp warning
--local line=""
--    line='<h3 style="color:red">Attention, output might be cut off anywhere due to unannounced changes in project-gc'.."'"..'s challenge checker system (noticed September 13, 2017). Temporarily no 9x9x9 overview is shown in order to ensure the rest being displayed.</h3><br>'
-- temporary warning  
-- End additional output - work in progress
--htmlall=htmlall..line



local badbin=check_if_possible2(packedfinds['lists'])

if badbin==false then
  local minsize=82
  local mincat
  for i, category in ipairs(categories) do
    if #packedfinds['lists'][category]<minsize then
      minsize=#packedfinds['lists'][category]
      mincat=category
    end

  end
  check_node2(mincat,packedfinds['lists'])
else
  explainnotpossible(packedfinds['lists'])
end

local ok = false
local log = false
local html = false

if success == true then
  ok = true
end



local badbin=check_if_possible2(packedfinds['lists'])

if badbin==false then
  local minsize=82
  local mincat
  for i, category in ipairs(categories) do
    if #packedfinds['lists'][category]<minsize then
      minsize=#packedfinds['lists'][category]
      mincat=category
    end

  end
  check_node2(mincat,packedfinds['lists'])
else
  explainnotpossible(packedfinds['lists'])
end

local ok = false
local log = false
local html = false

if success == true then
  ok = true
end

-- Check if challenge is fulfilled and if so, set ok = true
-- ok = true

if(ok == true) then
  -- Produce example log, Project-GC recommends using Markdown if it's useful.
  -- Do not use  log = log .. "foo"  in loops with many iterations, it consumes a lot of memory in LUA.
  log = {}

  if success then
    for d=1.0,5.0,0.5 do
      for t=1.0,5.0,0.5 do
        local sd=string.format('%1.1f',d)
        local st=string.format('%1.1f',t)
        local tc=packedfinds[(sd)][(st)]['final']
        table.insert(log,"+"..sd.." "..st.." "..tc['gccode'].." "..tc['cache_name'].." "..tc['reason'].." "..tc['visitdate'])
      end
    end
  
-- additional output: successful D/T grid filled with cache icons
  successhtml={}
  local line={}
    line=""
--    line='<h3 style="color:red">Attention, output might be cut off anywhere due to unannounced changes in project-gc'.."'"..'s challenge checker system (noticed September 13, 2017)</h3><br>'
          if GCtitle == "Kunterbunt (mixed D/T grid)" then
line=line..'<h3 style="color:red">[de] Der Cache befindet sich NICHT an den Headerkoordinaten. <br>Bitte den Finalwegpunkt beachten. Danke.</h3>'
end    

  line=line.."<h3>Challenge "..GCtitle.."</h3>"..filtertext.."<br><br>"
 line=line.."<b>[en] Mixed D/T grid </b>("..profileName..")<br>"
  if lang == "de" then
      
      if GCtitle == "Kunterbunt (mixed D/T grid)" then
   line=line..'<b>[de] Die kunterbunte D/T-Matrix </b>('..profileName..")<br>"
else
       line=line..'<b>[de] Die gemischte D/T-Matrix </b>('..profileName..")<br>"    
        end
      
    end
  table.insert(successhtml,line.."<br>")
  local line='<table border=\"1\" ><tr><th></th><th>1.0</th><th>1.5</th><th>2.0</th><th>2.5</th>'
			..'<th>3.0</th><th>3.5</th><th>4.0</th><th>4.5</th><th>5.0</th></tr>'
  table.insert(successhtml,line)
  for d=1.0,5.0,0.5 do
   line="<tr><th align=center>"..d.."</th>"
   for t=1.0,5.0,0.5 do
    local sd=string.format('%1.1f',d)
    local st=string.format('%1.1f',t)
    local dd=d*2-1
    local tt=t*2-1
    local tc=packedfinds[(sd)][(st)]['final']
    if tc['reason'] == "Fave" then
     line=line.."<td><img align=\"middle\" src=\"".."https://www.geocaching.com/images/icons/fave_fill_16.png".."\"></td>"
 	else
          local sr=packedfinds[(sd)][(st)]['final']['reason']
          line=line.."<td>"
          local st1=""
          if sr == "Wherigo Cache" then
          st1=Type_Icons["Wherigo Cache"]
          line=line.."<img align=\"middle\" src=\""..st1.."\">"
          end
          if sr == "Traditional Cache" then
          st1=Type_Icons["Traditional Cache"]
          line=line.."<img align=\"middle\" src=\""..st1.."\">"
          end
          if sr == "Multi-Cache" then
          st1=Type_Icons["Multi-Cache"]
          line=line.."<img align=\"middle\" src=\""..st1.."\">"
          end
          if sr == "Virtual Cache" then
          st1=Type_Icons["Virtual Cache"]
          line=line.."<img align=\"middle\" src=\""..st1.."\">"
          end
          if sr == "Letterbox Hybrid" then
          st1=Type_Icons["Letterbox Hybrid"]
          line=line.."<img align=\"middle\" src=\""..st1.."\">"
          end
          if sr == "Event" then
          st1=Type_Icons["Event Cache"]
          line=line.."<img align=\"middle\" src=\""..st1.."\">"
          end
          if sr == "Mystery Cache" then
          st1=Type_Icons["Mystery Cache"]
          line=line.."<img align=\"middle\" src=\""..st1.."\">"
          end
          if sr == "EarthCache" then
          st1=Type_Icons["EarthCache"]
          line=line.."<img align=\"middle\" src=\""..st1.."\">"
          end
          line=line.."</td>"
    end
   end
   line=line.."</tr>"
   table.insert(successhtml,line)
  end
  lastFind = getLastFind(profileId)
  line="</table><br>"
    
    
    
  table.insert(successhtml,line)
  htmls={}
  htmls=table.concat(successhtml, "\n")   
-- End additional output - work in progress    
    
    
    
    
    
  end
  log = table.concat(log, "\n")
      
-- additional output - work in progress
  lastFind = getLastFind(profileId)

	htmllf = "<br><br><b>Warning:</b> The most recent logs at www.geocaching.com for the last days might be missing here. Finds on retracted caches are not in project-gc's database. The last find in project-gc's database is for " .. lastFind.gccode .. ": " .. lastFind.cache_name .. " on " .. lastFind.visitdate .. "<br><br>"..filterfindno.." of your finds are considered with current filter. Traditional: "..ffntradi..", Multi: "..ffnmulti..", Unknown: "..ffnunkn..", EarthCache: "..ffnec..", Wherigo: "..ffnwh..", Virtual: "..ffnvi..", Letterbox Hybrid: "..ffnlbh..", "
    if GCtitle == "Kunterbunt (mixed D/T grid)" then
    htmllf=htmllf.." Events (Event cache only): "..ffevent..","
    end
    if GCtitle == "9x9 = 81 - Die gemischte Matrix Challenge" then
    htmllf=htmllf.." Events (Event, CITO, Mega, Giga): "..ffeventall..","
    end
    htmllf=htmllf.." Geocaches with at least "..fpthresh.." favorite points: "..ffnfav.." (including "..ffnfavwc.." Webcams)"
 
  
  html = htmls.."<br><br><hr>"..htmlall.."<br>"..html8.."\n"..html1.."\n"..html7.."\n"..html6.."\n"..html5.."\n"..html3.."\n"..html4.."\n"..html2.."\n"..html0..htmllf
-- End additional output - work in progress
      
else
  
 html={}
      
-- additional output - work in progress
   table.insert(html,"<br><br><b>Original output (by sloth96):</b><br><br>")
-- End additional output - work in progress
      
  if badbin then    
    table.insert(html,"Some grouping of caches did not have enough distinct D/T for the types.<br>")
    table.insert(html,"Find more unique D/T bins in the following cache type groups. <br>")
    for a,b in ipairs(suggestbins) do
    	local tempstring=''
      	local mc=0
      	for c,d in ipairs(b) do
        	tempstring=tempstring.." "..d
        	mc=mc+1
        end
      	table.insert(html,tempstring.." set needs to have "..(mc*9).." unique D/T squares and does not.<br>")
    end
  end

  html = table.concat(html, "\n")
      
      
-- additional output - work in progress      
  html0 = table.concat(FAVEhtml, "\n")
    html9=""

  if lang == "de" then
    html9=html9.."[de] Hallo "..profileName..', leider lassen sich mit deinen bisherigen Funden die einzelnen Cachetypen für die Challenge "'..GCtitle..'" nicht so in der D/T-Matrix anordnen, dass jeder der neun Cachetypen genau neun Plätze in der Matrix besetzen kann. Welche Gruppen von Cachetypen betroffen sind, ist ganz unten im englischen Original-Output des Checkers aufgelistet.'
    
--temporarily diabled    
    html9=html9.." Im Anschluss findest Du die D/T-Matrix für alle Cachetypen gemeinsam und für jeden Cachetyp getrennt und Hinweise, wie man vorgehen könnte."
--    html9=html9.." Im Anschluss findest Du die D/T-Matrix für alle Cachetypen gemeinsam (dieses Feature muss leider derzeit -ab 2017-09-15 aus Performancegründen entfallen) und für jeden Cachetyp getrennt und Hinweise, wie man vorgehen könnte."

    
    html10='<br><br><b>[de] Hinweise:</b><br><br>Bitte beachte, dass die folgenden Bedingungen vorab erfüllt sein müssen:<br>1. Es gibt für jedes D/T-Feld der "All 9 cache types"-D/T-Matrix zumindest einen Fund.<br>2. Kein Cachetyp steht in mehr als 9 Feldern ganz alleine in der "All 9 cache types"-D/T-Matrix. Keine zwei Cachetypen, z.B. Traditional und Unknown stehen in mehr als 18 Feldern, wo keine weiteren Typen stehen.<br>3. In jeder D/T-Matrix für die einzelnen Cachetypen sind zumindest 9 Felder besetzt.<br>  '
html10=html10.."<br>Danach sollte man im englischen Original-Output weiter unten nachschauen, wo es hakt. <br>-Typ1 Typ2 set needs to have 18 unique D/T squares and does not- bedeutet z.B. dass zusätzliche Funde mit weiteren D/T-Kombinationen bei Typ1 und/oder Typ2 erforderlich sind, damit je 9 Felder mit Typ1 und Typ2 und zusammen 18 Felder besetzt werden können .<br>"
html10=html10.."<br>Eine Möglichkeit, wie man vorgehen könnte: <br>1. In eine leere D/T Matrix zuerst die besuchten/zum Besuch ausgewählten neun Virtuals eintragen, da nur die noch bestehenden Virtuals und die 2017-2018 neu erstellten Reward Virtuals zur Auswahl stehen und hier eventuell nicht mit allen Möglichkeiten zu rechnen ist. "
html10=html10.."Danach oder auch gleichzeitig noch freie Felder mit mit neun besuchten/geplanten Events 'besetzen'."
 html10=html10.." Die ersten beiden Schritte sind deswegen sinnvoll, weil diese beiden Cachetypen evt. nicht (mehr) alle D/T-Kombinationen haben bzw. haben können/sollen/dürfen.<br>"   
    html10=html10.."2. Jeweils einen nächsten Cachetyp wählen, z.B. in der Reihenfolge Letterbox Hybrid - Wherigo - EarthCache, noch freie Felder mit besuchten/geplanten Caches 'besetzen', dann wiederholen mit dem nächsten Cachetyp.<br>"
html10=html10.."3. Wenn diese fünf Cachetypen 'untergebracht' sind, mit den restlichen Cachetypen fortfahren, sie sollten z.B. in der Reihenfolge Multi, Unknown, Favo, Tradi theoretisch reichlich Möglichkeiten zur Auswahl bieten. "    
else
    html9=""
    html10=""
  end
  
if filterfindno > 0 then
  lastFind = getLastFind(profileId)

	htmllf = "<br><br><b>Warning:</b> The most recent logs at www.geocaching.com for the last days might be missing here. Finds on retracted caches are not in project-gc's database. The last find in project-gc's database is for " .. lastFind.gccode .. ": " .. lastFind.cache_name .. " on " .. lastFind.visitdate .. "<br><br>"..filterfindno.." of your finds are considered with current filter. Traditional: "..ffntradi..", Multi: "..ffnmulti..", Unknown: "..ffnunkn..", EarthCache: "..ffnec..", Wherigo: "..ffnwh..", Virtual: "..ffnvi..", Letterbox Hybrid: "..ffnlbh..", "
    if GCtitle == "Kunterbunt (mixed D/T grid)" then
    htmllf=htmllf.." Events (Event cache only): "..ffevent..","
    end
    if GCtitle == "9x9 = 81 - Die gemischte Matrix Challenge" then
    htmllf=htmllf.." Events (Event, CITO, Mega, Giga): "..ffeventall..","
    end
    htmllf=htmllf.." Geocaches with at least "..fpthresh.." favorite points: "..ffnfav.." (including "..ffnfavwc.." Webcams)"

else
    htmllf = "<br><br>No finds recorded with current filter."
end     
    html="\n"..html9.."\n"..htmlall.."\n"..html8.."\n"..html1.."\n"..html7.."\n"..html6.."\n"..html5.."\n"..html3.."\n"..html4.."\n"..html2.."\n"..html0.."\n"..html10.."\n"..html.."\n"..htmllf
-- End additional output - work in progress

  

      
end



--[[
More feedback can be given by producing html into the html variable
Can be of good use to show the user his/her progress
Doesn't actually have to be html
--]]


return { ok = ok, log = log, html = html }
