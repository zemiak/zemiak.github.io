local args={...}
local conf = args[1].config
local profileName = args[1].profileName
local profileId = args[1].profileId
-- DebugPrint produces debug log
PGC.print('Got profile name, ', profileName, "\n")
function DebugPrint(a)
	if conf.debug==true then
		PGC.print(a)
	end
end
local Type_Icons	= {
		["Traditional Cache"] =						"/images/gc-icons/traditional_16.gif",
		["Multi-Cache"] =									"/images/gc-icons/multi_16.gif",
		["Mystery Cache"] =								"/images/gc-icons/unknown_16.gif",
		["EarthCache"] =									 "/images/gc-icons/earthcache_16.gif",
		["Letterbox Hybrid"] =						 "/images/gc-icons/letter_16.gif",
		["Wherigo Cache"] =								"/images/gc-icons/wherigo_16.gif",
		["Virtual Cache"] =								"/images/gc-icons/virtual_16.gif",
		["Webcam Cache"] =								 "/images/gc-icons/webcam_16.gif",
		["Event Cache"] =									"/images/gc-icons/event_16.gif",
		["Cache In Trash Out Event"] =		 "/images/gc-icons/cito_16.gif",
		["Mega-Event Cache"] =						 "/images/gc-icons/mega.gif",
		["Locationless Cache"] = "/images/gc-icons/locationless_16.gif",
		["checkbox"] =										 "/images/check16.png",
		["Giga-Event Cache"] =						 "/images/gc-icons/giga.gif",
		-- Not really the right icon for L&F-events.
		["Community Celebration Event"] =	 "/images/gc-icons/event_16.gif",
		["Geocaching HQ Block Party"] =			"/images/gc-icons/4738_16.gif",
		["Geocaching HQ Celebration"] = "/images/gc-icons/3774.gif",
		["GPS Adventures Maze Exhibit"] =			 "/images/gc-icons/2134.gif",
		["Geocaching HQ Cache"] =							 "/images/gc-icons/3773.gif",
		["Project A.P.E. Cache"] =						"/images/gc-icons/ape_16.gif",
		["Lab Cache"] =										"",
}
function DebugPrintFindsText(finds,limit,fields)
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
end -- end function DebugPrintFindsText
-----------------------------------------------------
function DebugPrintFindsHtml(finds,limit,fields)
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
end --end function DebugPrintFindsHtml
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
  	filter['minPublishDate'] = conf.minPublishDate
	filter['maxPublishDate'] = conf.maxPublishDate
	  filter['excludeGC'] = conf.excludeGC

		filter['filters']=conf.filters
	return filter
end -- end function FilterFromConfig
-----------------------------------------------------
function DebugPrintFilter(filter)
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
	--DebugPrint("loop_filters",loop_filters)
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
end --- end function DebugPrintFilter
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
		--DebugPrint("arg:",config)
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
	--DebugPrint("Filters:",loop_filters,"\n")
	for i,c in ipairs(loop_filters) do
		l_config.filter=expandFilter(c)
			--DebugPrint("expanded filter:",l_config.filter,"\n")
			local filter=l_config.filter
			
				--DebugPrint("l_config:",l_config)
		local myFinds= PGC.GetFinds(profileId,	l_config)
			local last=#finds+1
			for k,v in ipairs(myFinds) do
					local fail=false
					--exculde types
					if filter.excludeTypes~= nil and filter.excludeTypes[v.type]~= nil then
						fail=true
					end
					if filter.minlatitude ~= nil or filter.maxlatitude ~= nil 
						or filter.minlongitude ~= nil or filter.maxlongitude ~= nil then
						if v.latitude~=false	then				
							if filter.minlatitude ~= nil	and	tonumber(filter.minlatitude)>=tonumber(v.latitude) then
								fail=true
							end 
						if filter.maxlatitude ~= nil and	tonumber(filter.maxlatitude)<=tonumber(v.latitude) then
								fail=true
							end
							if filter.minlongitude ~= nil and	tonumber(filter.minlongitude)>=tonumber(v.longitude) then
								fail=true
							end
							if filter.maxlongitude ~= nil and	tonumber(filter.maxlongitude)<=tonumber(v.longitude) then
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
	--for k,v in spairs(finds_lid, function(t,a,b)	if t[b].visitdate==t[a].visitdate then return t[b].log_id >t[a].log_id else return t[b].visitdate>t[a].visitdate	end end) do
		for k,v in spairs(finds, function(t,a,b)	if t[b].visitdate==t[a].visitdate then return t[b].log_id >t[a].log_id else return t[b].visitdate>t[a].visitdate	end end) do
	 
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

function c_DT(conf)
-----------------------------
	local cellFinds={}
	local dMin,dMax,tMin,tMax,diagOk
	function PrintDT(DT,verticalSum,horizontalSum,sum)
		local DThtml={}
		local line='<table><tr><th></th><th>1.0</th><th>1.5</th><th>2.0</th><th>2.5</th>'
			..'<th>3.0</th><th>3.5</th><th>4.0</th><th>4.5</th><th>5.0</th><th></th></tr>'
		table.insert(DThtml,line)
		for i=1,9,1 do
			line="<tr><th>"..tostring((i+1)/2).."</th>"
			for j=1,9,1 do
				if i<dMin or i>dMax or j<tMin or j>tMax then
					line=line..'<td class="align-center" style="color: #888888; background-color: #e0e0e0">'..DT[i][j].."</td>"
				elseif DT[i][j]>0 then
					line=line..'<td class="align-center" style="color: #000000; background-color: #c8b600">'..DT[i][j].."</td>"
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
--------------------------------	
	function process_finds(finds,horizontalSum,verticalSum,DT,found_types,found_regions)
		for i,v in ipairs(finds) do
			if found_types[v.type]== nil then 
				found_types[v.type]=v
			end
			if v.region~= nil then
				if found_regions[v.region]== nil then 
					found_regions[v.region]=v
				end
			end
			local T=tonumber(v['terrain'])*2-1
			local D=tonumber(v['difficulty'])*2-1
			horizontalSum[T]=horizontalSum[T]+1
			verticalSum[D]=verticalSum[D]+1
			DT[D][T]=DT[D][T]+1
			table.insert(cellFinds[D][T],v.gccode)
		end
	end
--------------------------------------------
	local filter=FilterFromConfig(conf)
	PGC.print(filter)
	if conf.minValue ==nil then
		conf.minValue=1
	end
	if conf.minSum ==nil then
		conf.minSum=100
	end
	if conf.minDifficulty ==nil then
		conf.minDifficulty=1
	end
	if conf.maxDifficulty ==nil then
		conf.maxDifficulty=5
	end
	if conf.minTerrain ==nil then
		conf.minTerrain=1
	end
	if conf.maxTerrain ==nil then
		conf.maxTerrain=5
	end
	dMin=conf.minDifficulty*2-1
	dMax=conf.maxDifficulty*2-1
	tMin=conf.minTerrain*2-1
	tMax=conf.maxTerrain*2-1
	diagOk=(dMax-dMin)==(tMax-tMin)
	local qualifying_lines={}
	local function addQualifyingLine(kind,idx)
		if conf.list_qualifying_geocaches~=true then
			return
		end
		local label=kind
		local cells={}
		if kind=="D" then
			label="D"..tostring((idx+1)/2)
			for j=tMin,tMax,1 do table.insert(cells,{idx,j}) end
		elseif kind=="T" then
			label="T"..tostring((idx+1)/2)
			for j=dMin,dMax,1 do table.insert(cells,{j,idx}) end
		elseif kind=="Diag \\" then
			for k=0,math.min(dMax-dMin,tMax-tMin),1 do table.insert(cells,{dMin+k,tMin+k}) end
		else
			for k=0,math.min(dMax-dMin,tMax-tMin),1 do table.insert(cells,{dMax-k,tMin+k}) end
		end
		local codes={}
		for _,c in ipairs(cells) do
			local bucket=cellFinds[c[1]][c[2]]
			for n=1,math.min(conf.minValue,#bucket) do
				table.insert(codes,bucket[n])
			end
		end
		table.insert(qualifying_lines,{label=label,codes=codes})
	end
	local DT={}
	local horizontalSum={}
	local verticalSum={}
	local sum=0
	for i=1,10,1 do
		local tmp={}
		table.insert(DT,tmp)
	end
	for i=1,9,1 do
		horizontalSum[i]=0
		verticalSum[i]=0
		cellFinds[i]={}
		for j=1,9,1 do
				DT[i][j]=0
				cellFinds[i][j]={}
		end
	end
	local found_types={}
	local found_regions={}
	local found_types_nr=0
	local found_regions_nr=0
	fields = {'gccode','hidden', 'cache_name','region', 'visitdate', 'difficulty', 'terrain','type','last_publish_date'}
	local finds = GetCombinedFinds(profileId, {filter=filter, fields = fields, order = 'OLDESTFIRST', })	
  	if filter.excludeGC~= nil then
    	local ex={}
    	for _,f in ipairs(filter.excludeGC) do
      		ex[f]=f
      	end
    	local finds1=finds
    	 finds={}
     
    	for _,f in ipairs(finds1) do
      		if ex[f.gccode]== nil then
      			table.insert(finds,f)
        	end
        end
    
    end
  	if filter.minPublishDate~= nil or filter.maxPublishDate~=nil then
    	PGC.print("Publsih date\n")
    	local finds1=finds
    	 finds={}
     
    	for _,f in ipairs(finds1) do
      		local lok=false
      		local lfail=false
      		if f.last_publish_date== nil then
      			lok=true
      		else
        		if filter.maxPublishDate~= nil then
          			if f.last_publish_date <=filter.maxPublishDate then
	        			lok=true
    	      		else
        	  			lfail=true
          			end
        		end
        		if filter.minPublishDate~= nil  then
          			if f.last_publish_date >=filter.minPublishDate then
        				lok=true
          			else
          				lfail=true
            		end
          		end
        
        
      		end
      		if lok==true and lfail==false then
        		table.insert(finds,f)
        	end
      	end
    end
	process_finds(finds,horizontalSum,verticalSum,DT,found_types,found_regions,sum)
	if conf.laterTypes~= nil then
		filter['maxHiddenDate'] = nil
		filter['minHiddenDate'] = conf.laterMinHiddenDate
		filter['difficulties']=conf.laterdifficulties
		filter['terrains']=conf.laterterrains
		filter['types']=conf.laterTypes
		finds = GetCombinedFinds(profileId, {filter=filter, fields = {'gccode','hidden', 'cache_name','region', 'visitdate', 'difficulty', 'terrain','type'}, order = 'OLDESTFIRST', })
		process_finds(finds,horizontalSum,verticalSum,DT,found_types,found_regions,sum)
	end
	for _,_ in pairs(found_types)do
		found_types_nr=found_types_nr+1
	end
	for _,_ in pairs(found_regions)do
		found_regions_nr=found_regions_nr+1
	end 
	for _,v in pairs(verticalSum)do
		sum=sum+v
	end
	
	--check for number of loops
	local loops=DT[dMin][tMin]
	local entries=0
	for i=dMin,dMax,1 do
		for j=tMin,tMax,1 do
			if DT[i][j]>=conf.minValue then
				entries=entries+1
			end
			loops=math.min(loops,DT[i][j])
		end
	end
	local comp=true
	--horizontal D lines
	local horizontalMin={}
	local horizontal={}
	local horizontalNr=0
	for i=dMin,dMax,1 do
		horizontalMin[i]=DT[i][tMin]
		comp=true
		for j=tMin,tMax,1 do
			if DT[i][j]<conf.minValue then
					comp=false
				end
		horizontalMin[i]=math.min(horizontalMin[i],DT[i][j])
		end
		if comp then
			table.insert(horizontal,1)
			horizontalNr=horizontalNr+1
			addQualifyingLine("D",i)
		else
			table.insert(horizontal,0)	
		end
	end
	--T lines
	local verticalMin={}
	local vertical={}
	local verticalNr=0
	for i=tMin,tMax,1 do
		verticalMin[i]=DT[dMin][i]
		comp=true
		for j=dMin,dMax,1 do
			if DT[j][i]<conf.minValue then
				comp=false
			end
			verticalMin[i]=math.min(verticalMin[i],DT[j][i])
		end
		if comp then
			table.insert(vertical,1)
			verticalNr=verticalNr+1
			addQualifyingLine("T",i)
		else
			table.insert(vertical,0)	
		end
	end
	-- /line
	local right_diagonalMin=DT[dMax][tMin]
	local right_diagonal=0
	comp=true
	for k=0,math.min(dMax-dMin,tMax-tMin),1 do
		if DT[dMax-k][tMin+k]<conf.minValue then
			comp=false
		end
		right_diagonalMin=math.min(right_diagonalMin,DT[dMax-k][tMin+k])
	end
	if comp and diagOk then
		right_diagonal=1
		addQualifyingLine("Diag /")
	end
	DebugPrint("right_diagonalMin",right_diagonalMin,"")
	--\ line
	local left_diagonalMin=DT[dMin][tMin]
	local left_diagonal=0
	comp=true
	for k=0,math.min(dMax-dMin,tMax-tMin),1 do
		if DT[dMin+k][tMin+k]<conf.minValue	then
			comp=false
		end
		left_diagonalMin=math.min(left_diagonalMin,DT[dMin+k][tMin+k])
	end
	if comp and diagOk then
		left_diagonal=1
		addQualifyingLine("Diag \\")
	end
	DebugPrint("left_diagonalMin",left_diagonalMin,"")
	local total_lines=horizontalNr+verticalNr+right_diagonal+left_diagonal
	--horizontalSum
	local horizontalSumNr=0
	for i=tMin,tMax,1 do
		if horizontalSum[i]>=conf.minSum then
			horizontalSumNr=horizontalSumNr+1
		end
	end
	--horizontalSum
	local verticalSumNr=0
	for i=dMin,dMax,1 do
		if verticalSum[i]>=conf.minSum then
			verticalSumNr=verticalSumNr+1
		end
	end
	DebugPrint("loops:"..loops.."")	
	DebugPrint("horizontalNr:"..horizontalNr.."")
	DebugPrint("verticalNr:"..verticalNr.."")
	DebugPrint("right_diagonal:"..right_diagonal.."")
	DebugPrint("left_diagonal:"..left_diagonal.."")
	DebugPrint("entries:"..entries.."")
	DebugPrint("horizontalSumNr:"..horizontalSumNr.."")
	DebugPrint("verticalSumN:"..verticalSumNr.."")
	local ok = false
	local lok=false
	local fail=false
	local html=''
	ut={}
	local tmp = ""
	table.insert(ut,"I have:")
	for i,v in pairs(conf.conditions) do
		local tmp=""
		if i=="loops" or i=="loop" then			
			if	loops>=v then
				tmp=tmp.."ok:"..loops.." total loops of ".. v.." needed"
				lok=true
			else
				tmp=tmp.."Fail: I had only "..loops .." total loops of ".. v.." needed"
				fail=true
	 		end
			table.insert(ut,tmp)
		elseif i=="loopsPer"then
			local lloops=1+math.floor(#finds/v)
			if	loops>=lloops then
				tmp=tmp.."ok:"..loops.." total loops of ".. lloops.." needed (1 + one extra for every "..v.." finds)"
				lok=true
			else
				tmp=tmp.."Fail: I had only "..loops .." total loops of ".. lloops.." needed (1 + one extra for every "..v.." finds)"
				fail=true
	 		end
			table.insert(ut,tmp)
		elseif i=="horizontal" then
			if	horizontalNr>=v then
				tmp=tmp.."ok:"..horizontalNr.." horizontal lines of ".. v.." needed"
				lok=true
				if conf.minValue>1 then
					tmp=tmp.." with a min value of "..conf.minValue
				end
			else
				tmp=tmp.."Fail: I had only "..horizontalNr .." horizontal lines of ".. v.." needed"
				fail=true
				if conf.minValue>1 then
					tmp=tmp.." with a min value of "..conf.minValue
				end
	 		end
			table.insert(ut,tmp)
		elseif i=="vertical" then
			if	verticalNr>=v then
				tmp=tmp.."ok:"..verticalNr.." vertical lines of ".. v.." needed"
				lok=true
				if conf.minValue>1 then
					tmp=tmp.." with a min value of "..conf.minValue
				end
			else
				tmp=tmp.."Fail: I had only "..verticalNr .." vertical lines of ".. v.." needed"
				fail=true
				if conf.minValue>1 then
					tmp=tmp.." with a min value of "..conf.minValue
				end
	 		end
			table.insert(ut,tmp)
		elseif i=="left_diagonal" then
			if	left_diagonal>=v then
				tmp=tmp.."ok:"..left_diagonal.." left_diagonal lines of ".. v.." needed"
				lok=true
				if conf.minValue>1 then
					tmp=tmp.." with a min value of "..conf.minValue
				end
			else
				tmp=tmp.."Fail: I had only "..left_diagonal .." left_diagonal lines of ".. v.." needed"
				fail=true
				if conf.minValue>1 then
					tmp=tmp.." with a min value of "..conf.minValue
				end
	 		end
			table.insert(ut,tmp)
		elseif i=="right_diagonal" then
			if	right_diagonal>=v then
				tmp=tmp.."ok:"..right_diagonal.." right_diagonal lines of ".. v.." needed"
				lok=true
				if conf.minValue>1 then
					tmp=tmp.." with a min value of "..conf.minValue
				end
			else
				tmp=tmp.."Fail: I had only "..right_diagonal .." right_diagonal lines of ".. v.." needed"
				fail=true
				if conf.minValue>1 then
					tmp=tmp.." with a min value of "..conf.minValue
				end
	 		end
			table.insert(ut,tmp)
		elseif i=="diagonal" then
			if right_diagonal+left_diagonal>=v then
				tmp=tmp.."ok:"..right_diagonal+left_diagonal.." diagonal lines of ".. v.." needed"
				lok=true
				if conf.minValue>1 then
					tmp=tmp.." with a min value of "..conf.minValue
				end
			else
				tmp=tmp.."Fail: I had only "..right_diagonal+left_diagonal .." diagonal lines of ".. v.." needed"
				fail=true
				if conf.minValue>1 then
					tmp=tmp.." with a min value of "..conf.minValue
				end
	 		end
			table.insert(ut,tmp)
		elseif i=="total_lines" then
			if total_lines>=v then
				tmp=tmp.."ok:".. total_lines.."	total_lines lines of ".. v.." needed"
				lok=true
				if conf.minValue>1 then
					tmp=tmp.." with a min value of "..conf.minValue
				end
			else
				tmp=tmp.."Fail: I had only ".. total_lines .."	total_lines lines of ".. v.." needed"
				fail=true
				if conf.minValue>1 then
					tmp=tmp.." with a min value of "..conf.minValue
				end
	 		end
			table.insert(ut,tmp)
		elseif i=="vertical_horizontal" then
			if verticalNr+horizontalNr>=v then
				tmp=tmp.."ok:".. verticalNr+horizontalNr.."	vertical and/or horizontal lines of ".. v.." needed"
				lok=true
				if conf.minValue>1 then
					tmp=tmp.." with a min value of "..conf.minValue
				end
			else
				tmp=tmp.."Fail: I had only ".. verticalNr+horizontalNr .."	vertical and/or horizontal lines of ".. v.." needed"
				fail=true
				if conf.minValue>1 then
					tmp=tmp.." with a min value of "..conf.minValue
				end
	 		end
			table.insert(ut,tmp)
		elseif i=="entries" then
			if	entries>=v then
				tmp=tmp.."ok:".. entries.."	entries of ".. v.." needed"
				lok=true
				if conf.minValue>1 then
					tmp=tmp.." with a min value of "..conf.minValue
				end
			else
				tmp=tmp.."Fail: I had only ".. entries .." entries of ".. v.." needed"
				fail=true
				if conf.minValue>1 then
					tmp=tmp.." with a min value of "..conf.minValue
				end
	 		end
			table.insert(ut,tmp)
		elseif i=="horizontalSum"	then
			if	horizontalSumNr>=v then
				tmp=tmp.."ok:"..horizontalSumNr.." total horizontal sums greater then "..conf.minSum .." of ".. v.." needed"
				lok=true
				if conf.minValue>1 then
					tmp=tmp.." with a min value of "..conf.minValue
				end
			else
				tmp=tmp.."Fail: I had only "..horizontalSumNr.." total horizontal sums greater then"..conf.minSum .." of ".. v.." needed"
				fail=true
				if conf.minValue>1 then
					tmp=tmp.." with a min value of "..conf.minValue
				end
	 		end
			table.insert(ut,tmp)
		elseif i=="verticalSum"	then
			if	verticalSumNr>=v then
				tmp=tmp.."ok:"..verticalSumNr.." total vertical sums greater then "..conf.minSum .." of ".. v.." needed"
				lok=true
				if conf.minValue>1 then
					tmp=tmp.." with a min value of "..conf.minValue
				end
			else
				tmp=tmp.."Fail: I had only "..verticalSumNr.." total vertical sums greater then "..conf.minSum .." of ".. v.." needed"
				fail=true
				if conf.minValue>1 then
					tmp=tmp.." with a min value of "..conf.minValue
				end
	 		end
			table.insert(ut,tmp)
		elseif i=="horizontal_verticalSum"	then
			if horizontalSumNr+verticalSumNr>=v then
				tmp=tmp.."ok:"..horizontalSumNr+verticalSumNr.." total horizontal and/or vertical sums greater then "..conf.minSum .." of ".. v.." needed"
				lok=true
				if conf.minValue>1 then
					tmp=tmp.." with a min value of "..conf.minValue
				end
			else
				tmp=tmp.."Fail: I had only "..horizontalSumNr+verticalSumNr.." total horizontal and/or vertical sums greater then "..conf.minSum .." of ".. v.." needed"
				fail=true
				if conf.minValue>1 then
					tmp=tmp.." with a min value of "..conf.minValue
				end
	 		end
			table.insert(ut,tmp)
		elseif i=="min_nr_types" then
			if found_types_nr>=v then
				tmp=tmp.."ok:"..found_types_nr.." different types found of the ".. v.." needed"
				lok=true
			else
				tmp=tmp.."Fail: only "..found_types_nr .." diffrent types found of ".. v.." needed"
				fail=true
	 		end
			table.insert(ut,tmp)
		elseif i=="required_types" then
			local ok_list={}
			local fail_list={}
			local req_types=0
			for k,t in ipairs(v) do
				req_types=req_types+1
				if	found_types[t]~= nil then
					table.insert(ok_list,t)
				else
					table.insert(fail_list,t)
				end
			end
			if	#fail_list==0 then
				tmp=tmp.."ok: All required types found "
				tmp=tmp..table.concat(ok_list,", ")
				table.insert(ut,tmp)
				lok=true
			else
				tmp=tmp.."Fail: Only "..#ok_list.." of "..req_types.." required types found"
				table.insert(ut,tmp)
				table.insert(ut,"	 Found types:"..table.concat(ok_list,", "))
				table.insert(ut,"	 Missing types:"..table.concat(fail_list,", "))
				fail=true
	 		end
		elseif i=="required_regions" then
			local ok_list={}
			local fail_list={}
			local req_types=0
			for k,t in ipairs(v) do
				req_types=req_types+1
				if	found_regions[t]~= nil then
					table.insert(ok_list,t)
				else
					table.insert(fail_list,t)
				end
			end
			if	#fail_list==0 then
				tmp=tmp.."ok: All required regions found "
				tmp=tmp..table.concat(ok_list,", ")
				table.insert(ut,tmp)
				lok=true
			else
				tmp=tmp.."Fail: Only "..#ok_list.." of "..req_types.." required regions found"
				table.insert(ut,tmp)
				table.insert(ut,"	 Found regions:"..table.concat(ok_list,", "))
				table.insert(ut,"	 Missing regions:"..table.concat(fail_list,", "))
				fail=true
	 		end
		else
			DebugPrint("\nUnknown condition :"..i.."="..v.." \n")
			table.insert(ut,tmp)
			return { ok = fail, log = 1, html =1 }		 
		end
	end
	if conf.minValue >1 then
		table.insert(ut,"All entries has to greater or equal to "..conf.minValue.." to be counted in lines and entries")
	end
	if dMin>1 or dMax<9 or tMin>1 or tMax<9 then
		table.insert(ut,"Only D "..conf.minDifficulty.."-"..conf.maxDifficulty.." and T "..conf.minTerrain.."-"..conf.maxTerrain.." count towards lines, loops and entries")
	end
	if (lok==true and fail==false) then
		ok=true
	end
	local slog=table.concat(ut,"\n")
	local shtml=table.concat(ut,"<br>")
	html=html..PrintDT(DT,verticalSum,horizontalSum,sum)
	if conf.list_qualifying_geocaches==true then
		local out={}
		for n,l in ipairs(qualifying_lines) do
			table.insert(out,"Line "..n.." ("..l.label.."): "..table.concat(l.codes,", "))
		end
		if #out==0 then
			table.insert(out,"No completed lines to list")
		end
		html=html.."<br>"..table.concat(out,"<br>")
	end
	local log =""
	return{ok = ok, log = log, html = html, slog = slog, shtml = shtml }
end -- end function c_DT




--Runs the checker and create pgc copatible output
res=c_DT(conf)



local ok=res.ok
local log="slog:\n"..res.slog.."\n\nlog:\n"..res.log
local html=ok_html(res.ok).."shtml:<br>"..res.shtml.."<br>html<br>"..res.html


return { ok = ok, log = log, html = html }
