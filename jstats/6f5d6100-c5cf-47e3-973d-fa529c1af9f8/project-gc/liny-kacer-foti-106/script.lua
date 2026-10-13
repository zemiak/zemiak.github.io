local args={...}
local conf = args[1].config
local profileName = args[1].profileName
local profileId = args[1].profileId
-- PGC.print produces debug log
PGC.print('Got profile name, ', profileName, "\n")
local months={"January","February","March","April","May","June","July","August","September","October","November","December"}
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
function DebugPrint(...)
	if conf.debug==true then
    	local printResult=""
		for i,v in ipairs(arg) do
        	printResult = printResult .. tostring(v)
      	end
      	PGC.print(printResult)
	end
end
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
  filter['minelevation'] = conf.minelevation 
  filter['maxelevation'] = conf.maxelevation 
  filter['filters']=conf.filters
  return filter
end -- end function FilterFromConfig
-----------------------------------------------------
function extraInConfig(conf,list)
  	local extra=false
  	local filter={"country","region","county","minVisitDate","maxVisitDate","minHiddenDate",
  				"maxHiddenDate","excludeTypes","types","sizes","difficulties","terrains",
  				"minlatitude","maxlatitude","minlongitude","maxlongitude","minelevation","maxelevation"}
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
      for _,f in ipairs(loop_filters) do
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
      if filter.minelevation~= nil or filter.maxelevation~= nil then
    	table.insert(l_config.fields,'elevation')
      end
        --PGC.print("l_config:",l_config)
    local myFinds= PGC.GetFinds(profileId,  l_config)
      local last=#finds+1
      for k,v in ipairs(myFinds) do
          local fail=false
       if filter.minelevation ~= nil and tonumber(v.elevation)<tonumber(filter.minelevation) then
    		 fail=true
    	  end
      	if filter.maxelevation ~= nil and tonumber(v.elevation)>tonumber(filter.maxelevation) then
    		 fail=true
    	  end
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
function c_adv_number(conf)
function checkTest(groups,conf)
	local ok=false
	local fail=false
	local largestGroup={caches_nr=0,better=0,dtsum=0,caches_nr=0,types_nr=0,sizes_nr=0,regions_nr=0,DT_nr=0,T_nr=0,D_nr=0}
	local okGroup={}
	okGroup.caches_nr=0
	local okGroup_nr=0
	for a,g in spairs(groups,function(t,b,c) return b<c end) do
		local lok=false
		local lfail=false
		--largest group for fail print
		
      	g.better=0
		for k,v in pairs(conf.conditions) do
			--DebugPrint("conf"..k..":"..v.."\n")
			if k=="dtsum" then          	
				if g.dtsum>=tonumber(v) then
					lok=true
            		g.better=g.better+4
				else
					lfail=true
            		if g.dtsum>largestGroup.dtsum then
              			g.better=g.better+2
              		end
				end
			elseif k=="limit" then  
				if g.caches_nr>=tonumber(v) then
            		g.better=g.better+2
					lok=true
				else
					lfail=true
            		if g.caches_nr>largestGroup.caches_nr then
              			g.better=g.better+1
              		end
				end
			elseif k=="nrtypes" then  
				if g.types_nr>=tonumber(v) then
            		g.better=g.better+4
					lok=true
				else
					lfail=true
            		if g.types_nr>largestGroup.types_nr then
              			g.better=g.better+2
              		end
				end
			elseif k=="nrsizes" then  
				if g.sizes_nr>=tonumber(v) then
            		g.better=g.better+4
					lok=true
				else
					lfail=true
            		if g.sizes_nr>largestGroup.sizes_nr then
              			g.better=g.better+2
              		end
				end
			elseif k=="nrregions" then  
				if g.regions_nr>=tonumber(v) then
            		g.better=g.better+4
					lok=true
				else
					lfail=true
            		if g.regions_nr>largestGroup.regions_nr then
              			g.better=g.better+2
              		end
				end
          	elseif k=="nrDT" then  
				if g.DT_nr>=tonumber(v) then
            		g.better=g.better+4
					lok=true
				else
					lfail=true
            		if g.DT_nr>largestGroup.DT_nr then
              			g.better=g.better+2
              		end
				end
          	elseif k=="nrD" then  
				if g.D_nr>=tonumber(v) then
            		g.better=g.better+4
					lok=true
				else
					lfail=true
            		if g.D_nr>largestGroup.D_nr then
              			g.better=g.better+2
              		end
				end
          	elseif k=="nrT" then  
				if g.T_nr>=tonumber(v) then
            		g.better=g.better+4
					lok=true
				else
					lfail=true
            		if g.T_nr>largestGroup.T_nr then
              			g.better=g.better+2
              		end
				end
			else
				PGC.print("unknown conditions:"..k..":"..v.."\n")
				return {ok=nil,html=nil,log=nil }
			end
       	end
      	if g.better> largestGroup.better or (g.better==largestGroup.better and g.caches_nr>largestGroup.caches_nr) then 
			largestGroup=g
        	--PGC.print("largestGroup",largestGroup)
		end
		if lok==true and lfail==false then
			if okGroup.caches_nr<=g.caches_nr then
				okGroup=g
			end
       		ok=true
        	break
    	end
	end

    if fail==true then
		ok=false
    end
    if ok==true then

		return ok,okGroup
    else

	   	return ok,largestGroup
    end

end
--------
function getGroupKey(cache, key)
  	local res
	if (key == "dt") then
		res = cache['difficulty'].."/"..cache['terrain']
	elseif (key == "dtsum") then
		res = ToNumeric(cache['difficulty'])+ToNumeric(cache['terrain'])
	elseif (key == "date") then
		res = string.sub(cache['visitdate'],6)
	elseif (key == "day") then
		res = cache['visitdate']
	elseif (key == "month") then
		res = string.sub(cache['visitdate'],1,7)
    elseif (key == "month any year") then
    	res = string.sub(cache['visitdate'],6,7)
	elseif (key == "year") then
		res = string.sub(cache['visitdate'],1,4)
    elseif (key == "day of month") then
		res = string.sub(cache['visitdate'],9,10)
	else
    	res=cache[key]
    end
	return res
end  
--------  
function groupFinds(myFinds,period,groupby,filter)
	local caches={}
	--Group caches by key an calculate DTsum and #types for thar group
	for _,c in ipairs(myFinds) do
    	local groupKey=""
		if period ~= nil then 
			groupKey = groupKey..getGroupKey(c, period)
		end
    	if groupby ~= nil then 
			groupKey =groupKey.. getGroupKey(c,groupby)
		end
	    if key=="" then
    		key="<all>"
    	end
  		if caches[groupKey]==nil then
    		caches[groupKey]={}
        	caches[groupKey].key=groupKey
    		caches[groupKey].caches={}
    		caches[groupKey].caches_nr=0
    		caches[groupKey].dtsum=0
    		caches[groupKey].types={}
    		caches[groupKey].types_nr=0
        	caches[groupKey].DT={}
    		caches[groupKey].DT_nr=0
         	caches[groupKey].D={}
    		caches[groupKey].D_nr=0
            caches[groupKey].T={}
    		caches[groupKey].T_nr=0
      		caches[groupKey].sizes={}
    		caches[groupKey].sizes_nr=0
      		caches[groupKey].regions={}
     		caches[groupKey].regions_nr=0
      		caches[groupKey].filter=filter
    	end
		table.insert(caches[groupKey].caches,c)
  		caches[groupKey].caches_nr=caches[groupKey].caches_nr+1
  		local dtsum=tonumber(c['difficulty'])+tonumber(c['terrain'])
    	c['dtsum']=dtsum
  		caches[groupKey].dtsum=caches[groupKey].dtsum+dtsum
    	if caches[groupKey].types[c.type]== nil then
      		caches[groupKey].types[c.type]=c
      		caches[groupKey].types_nr=caches[groupKey].types_nr+1
    	end
    	if caches[groupKey].sizes[c.size]== nil then
      		caches[groupKey].sizes[c.size]=c
      		caches[groupKey].sizes_nr=caches[groupKey].sizes_nr+1
    	end
    	if caches[groupKey].regions[c.region]== nil then
      		caches[groupKey].regions[c.region]=c
      		caches[groupKey].regions_nr=caches[groupKey].regions_nr+1
    	end
      	local DT=c['difficulty'].."/"..c['terrain']
      	c.DT=DT
      	if caches[groupKey].DT[DT]== nil then
      		caches[groupKey].DT[DT]=c
      		caches[groupKey].DT_nr=caches[groupKey].DT_nr+1
    	end
      	if caches[groupKey].D[c.difficulty]== nil then
      		caches[groupKey].D[c.difficulty]=c
      		caches[groupKey].D_nr=caches[groupKey].D_nr+1
    	end
      	if caches[groupKey].T[c.terrain]== nil then
      		caches[groupKey].T[c.terrain]=c
      		caches[groupKey].T_nr=caches[groupKey].T_nr+1
    	end
 	end
	return caches
end
----------
function createLog1(okCaches,ok,conf)
    log={}
    html={}
    slog={}
    shtml={}

	if conf.conditions ~= nil then
      	
		local outputfields={}
		--PGC.print(okCaches.filter)
		table.insert(outputfields,'gccode')
		table.insert(outputfields,'visitdate')
      	for k,v in pairs(conf.conditions) do
			if k=="dtsum" then
    			table.insert(outputfields,'dtsum')
			elseif k=="nrtypes" then
    			table.insert(outputfields,'type')
          	elseif k=="nrregions" then
    			table.insert(outputfields,'region')
			elseif k=="nrsizes" then
    			table.insert(outputfields,'size')
			elseif k=="nrDT" then
    			table.insert(outputfields,'DT')
          	elseif k=="nrD" then
    			table.insert(outputfields,'difficulty')
          	elseif k=="nrT" then
    			table.insert(outputfields,'terrain')
			end
      	end     	
		table.insert(outputfields,'cache_name')
      	if conf.period ~= nil then
        	local line=""
        	if okCaches.key~= nil then
        	if conf.period=="date" then
          		line="On (month,day)"..okCaches.key.." Any year"
      		elseif conf.period=="day" then
          		line="On "..okCaches.key
      		elseif conf.period=="month" then
          		line="On (year,month)"..okCaches.key
      		elseif conf.period=="month any year" then
          		line="On "..month[tonumber(okCaches.key)].." any year"
      		elseif conf.period=="year" then
          		line="On (year)"..okCaches.key
      		elseif conf.period=="day of month" then
          		line="On the "..okCaches.key.." day of any month"
      		end
        	table.insert(shtml,line..'<br>')
	      	table.insert(slog,line)
          	end
        end
      	for k,v in pairs(conf.conditions) do
        	 DebugPrint("conf"..k..":"..v.."\n")
	    	if  k=="dtsum" then
    			local line=""
      			if v <=okCaches.dtsum then
	        		line="I made it with a DTsum of "..okCaches.dtsum.." and needed only "..v.." "..PrintFilter(conf.filter)
    	  		else
      			  	line="I <b>did not make it</b> I had DTsum of only "..okCaches.dtsum.." and I needed "..v.." "..PrintFilter(conf.filter)
      			end
      			table.insert(shtml,line..'<br>')
      			table.insert(slog,line)
   			elseif  k=="limit" then
      			local line=""
      			if v <=okCaches.caches_nr then
	        		line="I made it with "..okCaches.caches_nr.." finds and needed only "..v.." "..PrintFilter(conf.filter)
    	  		else
        			line="I <b>did not make it</b> I had only "..okCaches.caches_nr.." finds and  needed "..v.." "..PrintFilter(conf.filter)
	      		end
    	  		  
      			table.insert(shtml,line..'<br>')
      			table.insert(slog,line)
			elseif k=="nrsizes" then
          		conf.printSizes=true
      			local line=""
      			if v <=okCaches.sizes_nr then
        			line="I made it with "..okCaches.sizes_nr.." different sizes and needed only "..v.." "..PrintFilter(conf.filter)
      			else
	        		line="I <b>did not make it</b> I had only "..okCaches.sizes_nr.." different types and I needed "..v.." "..PrintFilter(conf.filter)
    	  		end
      			table.insert(shtml,line..'<br>')
	      		table.insert(slog,line)
   			elseif k=="nrtypes" then
          		conf.printTypes= true
				local line=""
          		--PGC.print("v:",v,"\n")
				if v <=okCaches.types_nr then
					line="I made it with "..okCaches.types_nr.." different types and needed only "..v.." "..PrintFilter(conf.filter)
				else
					line="I <b>did not make it</b> I had only "..okCaches.types_nr.." different types and I needed "..v.." "..PrintFilter(conf.filter)
				end
				table.insert(shtml,line..'<br>')
				table.insert(slog,line)
          	elseif k=="nrregions" then
          		conf.printRegions= true
				local line=""
          		--PGC.print("v:",v,"\n")
				if v <=okCaches.regions_nr then
					line="I made it with "..okCaches.regions_nr.." different regions and needed only "..v.." "..PrintFilter(conf.filter)
				else
					line="I <b>did not make it</b> I had only "..okCaches.regions_nr.." different regions and I needed "..v.." "..PrintFilter(conf.filter)
				end
				table.insert(shtml,line..'<br>')
				table.insert(slog,line)
          	elseif k=="nrDT" then
          		conf.printDT= true
				local line=""
          		--PGC.print("v:",v,"\n")
				if v <=okCaches.DT_nr then
					line="I made it with "..okCaches.DT_nr.." different DT and needed only "..v.." "..PrintFilter(conf.filter)
				else
					line="I <b>did not make it</b> I had only "..okCaches.DT_nr.." different DT and I needed "..v.." "..PrintFilter(conf.filter)
				end
				table.insert(shtml,line..'<br>')
				table.insert(slog,line)
          	elseif k=="nrD" then
          		conf.printD= true
				local line=""
          		--PGC.print("v:",v,"\n")
				if v <=okCaches.D_nr then
					line="I made it with "..okCaches.D_nr.." different difficulty and needed only "..v.." "..PrintFilter(conf.filter)
				else
					line="I <b>did not make it</b> I had only "..okCaches.D_nr.." different difficulty and I needed "..v.." "..PrintFilter(conf.filter)
				end
				table.insert(shtml,line..'<br>')
				table.insert(slog,line)
          	elseif k=="nrT" then
          		conf.printT= true
				local line=""
          		--PGC.print("v:",v,"\n")
				if v <=okCaches.T_nr then
					line="I made it with "..okCaches.T_nr.." different terrain and needed only "..v.." "..PrintFilter(conf.filter)
				else
					line="I <b>did not make it</b> I had only "..okCaches.T_nr.." different terrain and I needed "..v.." "..PrintFilter(conf.filter)
				end
				table.insert(shtml,line..'<br>')
				table.insert(slog,line)
			end
		end
      	if conf.printTypes== true then
        	local line=""
      		line=line.."Found Types: "
        	local count=0
        	if okCaches.types~=nil then
      		for i,v in pairs(okCaches.types) do
          		count=count+1
          		if count>1 then
            		line=line..", "
            	end
	      		line=line..i
    	 	end
      		table.insert(html,line..'<br>')
			table.insert(log,line)
        	PrintFields(okCaches.types,outputfields,log,html,conf) 
          	end
      	end
    	if conf.printSizes== true then
      		local line=""
      		line=line.."Found Sizes:"
        	local count=0
        	if okCaches.sizes~= nil then
      		for i,v in pairs(okCaches.sizes) do
          		count=count+1
          		if count>1 then
            		line=line..", "
            	end
	      		line=line..i
    	 	end
      		table.insert(html,line..'<br>')
			table.insert(log,line)
        	PrintFields(okCaches.sizes,outputfields,log,html,conf) 
          	end
      	end
      	if conf.printRegions== true then
        	local line=""
      		line=line.."Found Regions:"
        	local count=0
        	if	okCaches.regions~=nil then
      		for i,v in pairs(okCaches.regions) do
          		count=count+1
          		if count>1 then
            		line=line..", "
            	end
	      		line=line..i
    	 	end
          
      		table.insert(html,line..'<br>')
			table.insert(log,line)
        	PrintFields(okCaches.regions,outputfields,log,html,conf) 
        end
      	end
      	if conf.printDT== true then
        	local line=""
      		line=line.."Found DT:"
        	local count=0
        	if	okCaches.DT~=nil then
      		for i,v in spairs(okCaches.DT,function(t,a,b) return a>b end) do
          		count=count+1
          		if count>1 then
            		line=line..", "
            	end
	      		line=line..i
    	 	end
        
      		table.insert(html,line..'<br>')
			table.insert(log,line)
        	PrintFields(okCaches.DT,outputfields,log,html,conf) 
          	end
      	end
      	if conf.printD== true then
        	local line=""
      		line=line.."Found difficulty:"
        	local count=0
     		if	okCaches.D~=nil then
      		for i,v in spairs(okCaches.D,function(t,a,b) return a>b end) do
          		count=count+1
          		if count>1 then
            		line=line..", "
            	end
	      		line=line..i
    	 	end
          
      		table.insert(html,line..'<br>')
			table.insert(log,line)
        	PrintFields(okCaches.D,outputfields,log,html,conf) 
          		end
      	end 
      	if conf.printT== true then
        	local line=""
      		line=line.."Found terrain:"
        	local count=0
        	if	okCaches.T~=nil then
      		for i,v in spairs(okCaches.T,function(t,a,b) return a>b end) do
          		count=count+1
          		if count>1 then
            		line=line..", "
            	end
	      		line=line..i
    	 	end
      		table.insert(html,line..'<br>')
			table.insert(log,line)
        	PrintFields(okCaches.T,outputfields,log,html,conf) 
          		end
      	end 
      
      
		if conf.conditions.dtsum ~= nil or conf.conditions.limit ~= nil and conf.brief~= true then
			PrintFieldsLimitDT(okCaches,outputfields,log,html,conf) 
		end
    end
	return log,html,slog,shtml
end
--------
function findMaxWidth(logtmp)
	local res={}
  	for i,v in ipairs(logtmp[1]) do
	    res[i]=0
  	end
  	for i,v in ipairs(logtmp) do
    	for j,f in ipairs(v) do
   			res[j]=math.max(res[j],string.len(f))
    	end
  	end
  	return res
end
--------  
function PrintFieldsLimitDT(okCaches,outputfields,log,html,conf)
    local log={}
    local html={}
	if conf.brief ~= true then
 		--generate html, and log temp
    	local logtmp={}
    	local done=false
    	table.insert(html,'<table border=1><tr><th>')
    	table.insert(html,table.concat(outputfields,'</th><th>'))
    	table.insert(html,'</th><tr>')
    	table.insert(logtmp,outputfields)
    	local loopDT=0
    	local loopNR=0
      	if okCaches.caches~= nil then
  		for i,c in ipairs(okCaches.caches) do
       		local l_done=false
        	local l_notdone=false
      		if done==false or conf.full==true then       
      			local line={}
      			for j,f in ipairs(outputfields) do
        			table.insert(line,c[f])
      			end
      			table.insert(html,'<tr><td>')
    			table.insert(html,table.concat(line,'</td><td>'))
    			table.insert(html,'</td><tr>')
        		table.insert(logtmp,line)
      		end
      		if conf.conditions.dtsum ~= nil then
	    		loopDT=loopDT+c.dtsum
        		if loopDT>=conf.conditions.dtsum then
          			l_done=true
        		else
          			l_notdone=true
        		end
	  		end
	  		if conf.conditions.limit ~= nil then
    			loopNR=loopNR+1
        		if loopNR>=conf.conditions.limit then
					l_done=true
        		else
          			l_notdone=true
        		end
      		end
      		if l_done==true and l_notdone==false then
        		done=true
        	end
    	end
        end
    	table.insert(html,'</table>')
    	local width=findMaxWidth(logtmp)
    	table.insert(log,'[code]')
    	for i,v in pairs(logtmp) do
    		local line={}
      		for j,f in pairs(v) do
				if j ~= table.maxn(v) then
					table.insert(line,string.format("%-"..width[j].."s",f))
        		else
        			table.insert(line,f)
        		end
      		end
      		table.insert(log,table.concat(line," "))
   		end
 	end
  	table.insert(html,'<br>')
	table.insert(log,"")
    return log,html
end
--------
function PrintFields(Caches,outputfields,log,html,conf)
	--generate html, and log temp
    local logtmp={}
    local done=false
	local l_html={}
    --PGC.print(outputfields)
    table.insert(l_html,'<table><tr><th>')
    table.insert(l_html,table.concat(outputfields,'</th><th>'))
    table.insert(html,'</th><tr>')
    table.insert(logtmp,outputfields)
  	for i,c in pairs(Caches) do
      	local line={}
      	for j,f in ipairs(outputfields) do
        	table.insert(line,c[f])
      	end
      	table.insert(l_html,'<tr><td>')
    	table.insert(l_html,table.concat(line,'</td><td>'))
    	table.insert(l_html,'</td><tr>\n')
        table.insert(logtmp,line)

      
    end
    table.insert(html,'</table>')
    local width=findMaxWidth(logtmp)
    table.insert(log,'[code]')
    for i,v in pairs(logtmp) do
    	local line={}
      	for j,f in pairs(v) do
        	if j ~= table.maxn(v) then
        		table.insert(line,string.format("%-"..width[j].."s",f))
        	else
        		table.insert(line,f)
        	end
      	end
      	table.insert(log,table.concat(line," "))
   	end
	
	table.insert(html,table.concat(l_html))
	table.insert(log,"")
end
--------  
local slog=""
local shtml=""
local options ={"conditions","brief","period","debug"}
  	if extraInConfig(conf,options)==true then
    	return{ok=nil,log=nil,html=nil}
    end
local filter=FilterFromConfig(conf)
conf.filter=filter

local period=conf.period
local groupby=conf.groupby
local fields={'gccode', 'cache_name','size', 'visitdate', 'country','region','county','difficulty','terrain','log_id','type'}
local log = {}
local html ={}
local ok = false
local fail=false
local myFinds=GetCombinedFinds(profileId,{fields = fields,  order = 'OLDESTFIRST',  filter = filter })
local groups =groupFinds(myFinds,period,groupby,filter)
local okCaches={}
ok,okCaches=checkTest(groups,conf)
if ok==false then
	fail=true
end


log,html,slog,shtml=createLog1(okCaches,ok,conf)
okCaches.caches=nil
--PGC.print(okCaches)
if fail==true then
  ok=false
end



log = table.concat(log, "\n")
html = table.concat(html, "<br>")
slog = table.concat(slog, "\n")
shtml = table.concat(shtml, "<br>")
if conf.dt=="sum" then
  ok=nil
  html='<h3> "dt":"sum" is a old config and shall be changed to "dtsum":required dt sum limit is no longer used for dtsum<br>please contact script tagger</h3>'
end
if conf.brief==true then
    log=""
    html=""
end
  
return{ok = ok, log = log, html = html, slog = slog, shtml = shtml } 
end -- end function c_adv_numbers


--Runs the checker and create pgc copatible output
res=c_adv_number(conf)



local ok=res.ok

log=res.slog.."\n"..res.log
html=ok_html(res.ok).."<br>"..res.shtml.."<br>"..res.html



return { ok = ok, log = log, html = html }
