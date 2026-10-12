
local events={"Event Cache","Cache In Trash Out Event","Community Celebration Event",
  "Mega-Event Cache","Geocaching HQ Block Party","Giga-Event Cache","Geocaching HQ Celebration"}

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
function checkOwners(owners,nrTypes,nrOwners)
local nrOkOwners=0
local okOwners={}

local ok=false
for o,v in spairs(owners, function(t,a,b) return string.upper(b) > string.upper(a) end) do
  local nr=0
  local tmplog=o.." - "
  for t,c in pairs(v, function(tt,aa,bb) return bb > aa end) do
    --if conf.by_owner_id==true then
    --  c["placed_by"]=PGC.ProfileId2Name(c['owner_id'])
    --end
    nr=nr+1
    if nr<=nrTypes then
        if nr~=1 then
        tmplog=tmplog..", "
        end
        --tmplog=tmplog..", "..c.gccode.." "..c.cache_name.." "..t
            tmplog=tmplog..t
        end
  end
  if nr>=nrTypes and nrTypes==conf.nr_types or nr==nrTypes and nrTypes~=conf.nr_types then
        PGC.print("ok:",o,"\n")
    nrOkOwners=nrOkOwners+1
    table.insert(okOwners,tmplog)
     --break
   end
    if nrOkOwners>=nrOwners then

      ok=true
      break
  end
  end
--end
--end
tmp={}
  tmp['ok']=ok
  tmp['okOwners']=okOwners
  tmp['nrOkOwners']=nrOkOwners
  return tmp
end


local args={...}
 conf = args[1].config
local profileName = args[1].profileName
local profileId = args[1].profileId
-- PGC.print produces debug log
PGC.print('Got profile name, ', profileName, "\n")
local conf_nr=0
for _,v in pairs(conf) do
  conf_nr=conf_nr+1
end
if conf_nr==0 then
  return{ ok={},log={},html={}}
end
local filter={}
local filter = {}
filter['country'] = conf.country
filter['region'] = conf.region
filter['county'] = conf.county
filter['minVisitDate'] = conf.minVisitDate
--filter['maxVisitDate'] = conf.maxVisitDate
filter['minHiddenDate'] = conf.minHiddenDate
filter['maxHiddenDate'] = conf.maxHiddenDate
filter['types'] = conf.types
filter['sizes'] = conf.sizes
filter['difficulties'] = conf.difficulties
filter['terrains'] = conf.terrains


local owners={}
local owner_id={}
--local finds = PGC.GetFinds(profileId, { fields = {'gccode', 'cache_name', 'visitdate', 'type','placed_by','owner_id'}, order = 'OLDESTFIRST', filter = filter })
local finds = PGC.GetFinds(profileId, { fields = {'gccode', 'cache_name', 'visitdate', 'type','placed_by','owner_id'}, order = 'OLDESTFIRST', filter = filter })
local event_in={}
for _,t in pairs(events) do
  event_in[t]=t
  end
for i,c in ipairs(finds) do
  --PGC.print(c)
  -- placed_by nil check added by Project-GC
  if c["placed_by"] ~= nil then
    if owners[c["placed_by"]]==nil then
        local tmp={}
        owners[c["placed_by"]]=tmp
    end
    if owners[c["placed_by"]][c['type']]==nil then
        owners[c["placed_by"]][c['type']]=c
    end
  end
  -- owner_id nil check added by Project-GC
  if c["owner_id"] ~= nil then
    if owner_id[c["owner_id"]]==nil then
        local tmp={}
        owner_id[c["owner_id"]]=tmp
    end
    if owner_id[c["owner_id"]][c['type']]==nil and
      (c["owner_id"]~=profileId  or (conf.exclude_owned_non_events~=true or  event_in[c.type]~=nil))  then
        owner_id[c["owner_id"]][c['type']]=c
    end
  end
end
local ok = false
local log = false
local html = false
local list_to_test=owners
if conf.by_owner_id==true then
  list_to_test={}
  for id,c in pairs(owner_id) do
    list_to_test[PGC.ProfileId2Name(id)]=c
  end

end
res=checkOwners(list_to_test,conf.nr_types,conf.owners)
PGC.print(res)
ok=res['ok']
local okOwners=res['okOwners']
local nrOkOwners=res['nrOkOwners']
if ok==false then
  local totalOwners=nrOkOwners
  html="You <B>only</b> have logged "..conf.nr_types.." types from ".. nrOkOwners.." of "..conf.owners.." different owners needed<br>"
  html=html.."These are completed cache owners:<br><br>"
  html =html.. table.concat(okOwners, "<br>")
  for i=conf.nr_types-1,2,-1 do
      res=checkOwners(list_to_test,i,900)
      okOwners=res['okOwners']
    nrOkOwners=res['nrOkOwners']
      totalOwners=totalOwners+nrOkOwners
      html=html.."<br><br>And you found "..i.." types from ".. nrOkOwners.." different owners<br>"
        html=html.."These <b>no</b> completed cache owners<br>Use the list to find owners to logg more types from to complete che challenge<br><br>"
      html =html.. table.concat(okOwners, "<br>")
    if totalOwners>200 then

          html=html.."<br><br>Owners with fever types found are not displays if the number of owners above are greater then 200<br>"
        break
      end
    end

else
  log = table.concat(okOwners, "\n")
end
-- Do calculations






--[[
More advanced feedback can be given by producing html into the html var
Can be of good use to show the user his/her progress
Doesn't actually have to be html
--]]


return { ok = ok, log = log, html = html }
