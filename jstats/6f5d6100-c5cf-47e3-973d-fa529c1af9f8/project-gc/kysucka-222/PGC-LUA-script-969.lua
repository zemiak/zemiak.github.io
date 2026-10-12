local args={...}
local conf = args[1].config
local profileName = args[1].profileName
local profileId = args[1].profileId
-- PGC.print produces debug log
PGC.print('Got profile name, ', profileName, "\n")
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
    ["Lab Cache"] =                    "",
}
function PrintFindsText(finds,limit,fields)
  local tmp=PrinFindsTable(finds,limit,fields) 
    local res={}
        local tmp1={}
    for _,k in ipairs(fields) do
      table.insert(tmp1,k)
    end
  table.insert(res,table.concat(tmp1," "))
  
    for _,c in ipairs(tmp) do
      table.insert(res,table.concat(c," "))
    end
    res=table.concat(res,"\n")
return res
end -- end function PrintFindsText

-----------------------------------------------------
function PrintFindsHtml(finds,limit,fields)
  local tmp=PrinFindsTable(finds,limit,fields)
    local res={}
  table.insert(res,"<table>")
    local tmp1={}
    for _,k in ipairs(fields) do
      table.insert(tmp1,k)
    end
  table.insert(res,"<tr><th>"..table.concat(tmp1,"</th><th>").."</th></tr>")
  
    for _,c in ipairs(tmp) do
      table.insert(res,"<tr><td>"..table.concat(c,"</td><td>").."</td></tr>")
    end
  table.insert(res,"</table>")
    res=table.concat(res,"\n")
return res
end --end function PrintFindsHtml
-----------------------------------------------------
function PrinFindsTable(finds,limit,fields)
  local res={}
    local count=0
    for _,c in ipairs(finds) do
      count=count+1
      if count>limit then
        break
      end
      local tmp={}
      for _,k in ipairs(fields) do
        table.insert(tmp,c[k])
      end
    table.insert(res,tmp)
  end
  return res
end -- end function PrinFindsTable
-----------------------------------------------------
function FilterFromConfig(conf)
  local filter={}
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
  filter['minlatitude'] = conf.minlatitude
  filter['maxlatitude'] = conf.maxlatitude
  filter['minlongitude'] = conf.minlongitude
  filter['maxlongitude'] = conf.maxlongitude 
  filter['radius']=conf.radius
  filter['filters']=conf.filters
  return filter
end -- end function FilterFromConfig
-----------------------------------------------------
function extraInConfig(conf,list)
  	local extra=false
  	local filter={"country","region","county","minVisitDate","maxVisitDate","minHiddenDate",
  				"maxHiddenDate","excludeTypes","types","sizes","difficulties","terrains",
  				"minlatitude","maxlatitude","minlongitude","maxlongitude","radius"}
  	local acc={}
  	for _,v in ipairs(filter) do
   		acc[v]=v
    end
  	for _,v in ipairs(list) do
   		acc[v]=v
    end
  	for k,c in pairs(conf) do
    	if acc[k]== nil then
      		PGC.print("\nUnknown config:",k,":",v,"\n")
      		extra=true
      	end
    end
    return extra
end --end extraInConfig(
-----------------------------------------------------
function PrintFilter(filter)
  res=""
    if filter~= nil then
    local l_filters=TableCopy(filter.filters)
    
  local l_filter=TableCopy(filter)
    l_filter.filters=nil
    local loop_filters={}
    if l_filters==nil then
      table.insert(loop_filters,TableCopy(l_filter))
    else
      for _,t in pairs(l_filters) do
          local tmp=TableCopy(l_filter)
          for k,v in pairs(t) do
            if type(v)=="table" then
                tmp[k]=TableCopy(v)
              else
                tmp[k]=v
              end
          end
          table.insert(loop_filters,tmp)
        end
    end
  --PGC.print("loop_filters",loop_filters)
    --count filters
    local count=0
    for _,_ in ipairs(loop_filters) do
      count=count+1
    end

    if count>=1 then
      res=res.."Filters:("
      local count2=0
      for _,f in pairs(loop_filters) do
          count2=count2+1
          if count2>1 then
          res=res.." ; "
          end
          local count3=0
          for k,v in pairs(f) do
            count3=count3+1
            if count3>1 then
            res=res.." , "
            end
            if type(v)=="table" then
                res=res.." "..k.." ("
                local count4=0
                for _,d in ipairs(v) do
                  count4=count4+1
                if count4>1 then
                res=res.." , "
                end
                      res=res..d
                end
              res=res..") "
            else
                res=res.." "..k..":"..tostring(v)
            end
          end
          
      end
      res=res..")"
    else
      res=res.."No Filter"
    end
    else
      res=res.."No Filter"
    end
  
  return res
end --- end function PrintFilter
-----------------------------------------------------
function GetCombinedFinds(profileId,config)
  --replacement for PGC.GetFinds
  --The resulting caches are combined and sorted
  --additional filter options not included in PGC.GetFinds can also be added
  --minlatitude,maxlatitude, minlongitude, maxlongitude in decimal form
  local function expandFilter(filter)
      local res={}
      for k,v in pairs(filter) do
      -- add custom groups as types and make excludeTypes accociative
      if k=="types" then
            if type(v)=="string" then
             local tmp=v
               res['types']={}
              table.insert(res.types,tmp)
          end
          res.types={}
          for i,t in ipairs(v) do
              if t=="Physical" then
                table.insert(res.types,"Traditional Cache")
                table.insert(res.types,"Mystery Cache")
                table.insert(res.types,"Multi-Cache")
                table.insert(res.types,"Letterbox Hybrid")
                table.insert(res.types,"Wherigo Cache")
                table.insert(res.types,"Project A.P.E. Cache")
                table.insert(v,"Geocaching HQ Cache")
              elseif t=="Events" then
                table.insert(res.types,"Event Cache")
                table.insert(res.types,"Cache In Trash Out Event")
                table.insert(res.types,"Community Celebration Event")
                table.insert(res.types,"Mega-Event Cache")
                table.insert(res.types,"Geocaching HQ Block Party")
                table.insert(res.types,"Giga-Event Cache")
                table.insert(res.types,"Geocaching HQ Celebration")
              else
                table.insert(res.types,t)
            end 
              end
          
      -- exclude types
      elseif k==excludeTypes then
          if type(v)=="string" then
              local tmp=v
              res.excludeTypes={}
              table.insert(res.excludeTypes,tmp)
          end
          local types=filter.excludeTypes
          filter.excludeTypes={}
          for i,t in ipairs(v) do
              if t=="Physical" then
                res.excludeTypes['Traditional Cache']="Traditional Cache"
                res.excludeTypes['Mystery Cache']="Mystery Cache"
                res.excludeTypes['Multi-Cache']="Multi-Cache"
                res.excludeTypes['Letterbox Hybrid']="Letterbox Hybrid"
                res.excludeTypes['Wherigo Cache']="Wherigo Cache"
                res.excludeTypes['Project A.P.E. Cache']="Project A.P.E. Cache"
                v.excludeTypes['Geocaching HQ Cache']="Geocaching HQ Cache"
              elseif t=="Events" then
                res.excludeTypes['Event Cache']="Event Cache"
                res.excludeTypes['Cache In Trash Out Event']="Cache In Trash Out Event"
                res.excludeTypes['Community Celebration Event']="Community Celebration Event"
                res.excludeTypes['Mega-Event Cache']="Mega-Event Cache"
                res.excludeTypes['Geocaching HQ Block Party']="Geocaching HQ Block Party"
                res.excludeTypes['Giga-Event Cache']="Giga-Event Cache"
                res.excludeTypes['Geocaching HQ Celebration']="Geocaching HQ Celebration"
              else
                res.excludeTypes[t]=t
              end
          end
          else
            res[k]=TableCopy(v)
      end
      end
  return res
  end --function expandFilter(filter) end
    --PGC.print("arg:",config)
  local finds={}
    local finds_lid={}
    local l_config=TableCopy(config)

  --Extract filters   
    local l_filters=l_config.filter.filters
    l_config.filter.filters=nil
    local l_filter=l_config.filter
    local loop_filters={}
    if l_filters==nil then
      table.insert(loop_filters,TableCopy(l_filter))
    else
      for _,t in pairs(l_filters) do
          local tmp=TableCopy(l_filter)
          for k,v in pairs(t) do
            if type(v)=="table" then
                tmp[k]=TableCopy(v)
              else
                tmp[k]=v
              end
          end
          table.insert(loop_filters,tmp)
        end
    end
    table.insert(l_config.fields,'visitdate')
	table.insert(l_config.fields,'log_id')
	--PGC.print("Filters:",loop_filters,"\n")
  for i,c in ipairs(loop_filters) do
    l_config.filter=expandFilter(c)
      --PGC.print("expanded filter:",l_config.filter,"\n")
      local filter=l_config.filter
      
        --PGC.print("l_config:",l_config)
    local myFinds= PGC.GetFinds(profileId,  l_config)
      local last=#finds+1
      for k,v in ipairs(myFinds) do
          local fail=false
          --exculde types
          if filter.excludeTypes~= nil and filter.excludeTypes[v.type]~= nil then
            fail=true
          end
          if filter.minlatitude ~= nil or filter.maxlatitude ~= nil 
            or filter.minlongitude ~= nil or filter.maxlongitude ~= nil then
            if v.latitude~=false  then        
              if filter.minlatitude ~= nil  and  tonumber(filter.minlatitude)>=tonumber(v.latitude) then
                fail=true
              end 
            if filter.maxlatitude ~= nil and  tonumber(filter.maxlatitude)<=tonumber(v.latitude) then
                fail=true
              end
              if filter.minlongitude ~= nil and  tonumber(filter.minlongitude)>=tonumber(v.longitude) then
                fail=true
              end
              if filter.maxlongitude ~= nil and  tonumber(filter.maxlongitude)<=tonumber(v.longitude) then
                fail=true 
              end  
            else
              fail=true
            end
          end
          if fail==false then
          finds[last] = v
          last=last+1
          end
          finds_lid[v.log_id]=v
      end
  end
  local sortFinds={}
  --for k,v in spairs(finds_lid, function(t,a,b)  if t[b].visitdate==t[a].visitdate then return t[b].log_id >t[a].log_id else return t[b].visitdate>t[a].visitdate  end end) do
    for k,v in spairs(finds, function(t,a,b)  if t[b].visitdate==t[a].visitdate then return t[b].log_id >t[a].log_id else return t[b].visitdate>t[a].visitdate  end end) do
   
      table.insert(sortFinds,v)
  end  
  return sortFinds  
end --function GetCombinedFinds
-----------------------------------------------------
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
end --function spairs
-----------------------------------------------------
function TableCopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in pairs(orig) do
            copy[orig_key] = TableCopy(orig_value)
        end
        --setmetatable(copy, deepcopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end
-----------------------------------------------------
function ok_html(a)
  if a ==true then
      return '<img src="http://maxcdn.project-gc.com/images/check16.png">'
    else
    return '<img src="http://maxcdn.project-gc.com/images/cancel16.png">'    
    end       
end
-----------------------------------------------------
function ok_text(a)
  if a ==true then
      return 'OK'
    else
    return 'Fail'    
    end       
end
-----------------------------------------------------
-----------------------------------------------------
--- Example checker

function c_number(conf)
  	local options ={"limit","brief"}
  	if extraInConfig(conf,options)==true then
    	return{ok=nil,log=nil,html=nil}
    end
  	local filter=FilterFromConfig(conf)
	local fields = {'gccode', 'cache_name'}
	local finds = GetCombinedFinds(profileId, { fields = fields, order = 'OLDESTFIRST', filter = filter })
	--local finds = PGC.GetFinds(profileId, { fields = fields, order = 'OLDESTFIRST', filter = filter })
	local ok=false
	if #finds >= conf.limit then
	    ok = true
	end
	local slog = "User has " .. #finds .. " finds (" .. conf.limit .. " needed)."..PrintFilter(filter).."\n"
	local shtml = "User has " .. #finds .. " finds (" .. conf.limit .. " needed)."..PrintFilter(filter)  
	local log = PrintFindsText(finds,conf.limit,fields)
	local html = PrintFindsHtml(finds,conf.limit,fields)
  	if conf.brief== true then
    	log=""
    	html=""
    end
	return{ok = ok, log = log, html = html, slog = slog, shtml = shtml }
end -- end function c_number




--Runs the checker and create pgc copatible output
res=c_number(conf)

local log=""
local html=""

local ok=res.ok

	log=res.slog.."\n"..res.log
	html=ok_html(res.ok).."<br>"..res.shtml.."<br>"..res.html

return { ok = ok, log = log, html = html }
