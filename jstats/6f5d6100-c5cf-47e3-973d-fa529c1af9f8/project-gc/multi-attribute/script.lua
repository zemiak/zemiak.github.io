-- vi:ts=80

local args={...}
local conf = args[1].config
local gccode = args[1].gccode
local profileId = args[1].profileId
local profileName = args[1].profileName

local filter = conf.filter
if (filter == nil) then
  filter = {}
end
local positive = conf.positive
if (positive == nil or positive <= 0) then
  positive = 0
end
local negative = conf.negative
if (negative == nil or negative <= 0) then
  negative = 0
end
local total = conf.total
if (total == nil or total <= 0) then
  total = 0
end
local caches = conf.caches
if (caches == nil or caches <= 0) then
  caches = 0
end
local limit = conf.limit
if (limit == nil or limit <= 1) then
  limit = 1
end
local excludedAttributes = {}
if (conf.excluded) then
  for _,v in pairs(conf.excluded) do
    excludedAttributes[v] = 1
  end
end
local includedAttributes = {}
if (conf.included) then
  for _,v in pairs(conf.included) do
    includedAttributes[v] = 1
  end
end
local verbose = conf.verbose
if (verbose) then
  verbose = true
else
  verbose = false
end

local hasNegative = { [1] = 1, [6] = 1, [7] = 1, [8] = 1, [9] = 1, [10] = 1, [13] = 1, [14] = 1, [15] = 1, [17] = 1, [24] = 1, [25] = 1, [27] = 1,
  [28] = 1, [29] = 1, [30] = 1, [31] = 1, [32] = 1, [33] = 1, [34] = 1, [35] = 1, [36] = 1, [37] = 1, [38] = 1, [40] = 1, [41] = 1, [46] = 1,
  [47] = 1, [52] = 1, [53] = 1, [54] = 1, [55] = 1, [56] = 1, [57] = 1, [58] = 1, [59] = 1, [62] = 1, [63] = 1, [64] = 1, [65] = 1, [66] = 1 }
local a = PGC.GetAttributeList()
local attributeDescriptions = {}
local attributeIcons = {}
for k,v in pairs(a) do
  attributeDescriptions[k] = v.attributeName
  attributeIcons[k] = v.imageSet
  if (v.imageUnset and hasNegative[k]) then
    attributeDescriptions[k+96] = "NOT "..v.attributeName
    attributeIcons[k+96] = v.imageUnset
  else
    PGC.print(v)
  end
end

function count(s)
  local c = 0
  for _,v in pairs(s) do
    c = c+1
  end
  return c
end

function bit(p)
  return 2 ^ (p-1)
end

function hasbit(x, p)
  return x % (p + p) >= p
end

local cachesWithAttribute = {}
local cacheCountForAttribute = {}

function processAttributes(attributeBits, bitMask, arrayIndex, cacheIndex)
  if (includedAttributes[arrayIndex]) then
    if (hasbit(attributeBits, bitMask)) then
      if (cachesWithAttribute[arrayIndex] == nil) then
        cachesWithAttribute[arrayIndex] = {}
      end
      if (cacheCountForAttribute[arrayIndex] == nil) then
        cacheCountForAttribute[arrayIndex] = 0
      end
      cacheCountForAttribute[arrayIndex] = cacheCountForAttribute[arrayIndex] + 1
      cachesWithAttribute[arrayIndex][cacheCountForAttribute[arrayIndex]] = cacheIndex
    end
  end
end

for a,_ in pairs(includedAttributes) do
  if (attributeDescriptions[a] == nil) then
    includedAttributes[a] = nil
  end
end
if (count(includedAttributes) == 0) then
  for a,_ in pairs(attributeDescriptions) do
    includedAttributes[a] = 1
  end
end
for a,_ in pairs(excludedAttributes) do
  includedAttributes[a] = nil
end

local finds = PGC.GetFinds(profileId, { fields = {'gccode', 'attributes_set', 'attributes_unset'}, order = 'OLDESTFIRST', filter = filter })

local A = {}
for i,v in ipairs(finds) do
  for j=1,32 do
    local bitMask = bit(j)
    processAttributes(v.attributes_set_1, bitMask, j, i)
    processAttributes(v.attributes_set_2, bitMask, j+32, i)
    processAttributes(v.attributes_set_3, bitMask, j+64, i)
    processAttributes(v.attributes_unset_1, bitMask, j+96, i)
    processAttributes(v.attributes_unset_2, bitMask, j+128, i)
    processAttributes(v.attributes_unset_3, bitMask, j+160, i)
  end
end

local ok = true
local html = {}
local log = {}

function s(n)
  if (n == 1) then
    return ""
  end
  return "s"
end

function feedback(name, need, base, number)
  local found = 0
  for k=base+1,base+number do
    if (cacheCountForAttribute[k] ~= nil and cacheCountForAttribute[k] >= limit) then
      found = found+1
    end
  end
  if (caches > 0) then
    if (#finds < caches) then
      table.insert(html, "<p>Total find requirement <b>NOT</b> fulfilled with "..#finds.." cache"..s(caches).." ("..caches.." needed).</p>")
      ok = false
    else
      table.insert(html, "<p>Total find requirement fulfilled with "..#finds.." cache"..s(caches).." ("..caches.." needed).</p>")
    end
  end
  if (need > 0) then
    if (found >= need) then
      table.insert(html, "<p>"..name.." attribute requirement fulfilled with "..found.." unique attribute"..s(found).." ("..need.." needed x "..limit..").")
      table.insert(log, name.." attribute requirement fulfilled with "..found.." unique attribute"..s(found).." ("..need.." needed x "..limit..").")
    else
      table.insert(html, "<p>"..name.." attribute requirement <b>NOT</b> fulfilled with "..found.." unique attribute"..s(found).." ("..need.." needed x "..limit..").")
    end
    if (verbose) then
      table.insert(html, "<br />")
      for a=base+1,base+number do
        if (includedAttributes[a] and cacheCountForAttribute[a] and cacheCountForAttribute[a] >= limit) then
          local t = string.gsub(attributeIcons[a], ">", " style='margin-bottom:1px;margin-right:1px'>")
          table.insert(html, t)
        end
      end
    end
    if (found >= need) then
      table.insert(html, "</p>")
    else
      table.insert(html, "<br />")
      local list = {}
      for a=base+1,base+number do
        if (includedAttributes[a] and (cacheCountForAttribute[a] == nil or cacheCountForAttribute[a] < limit)) then
          local c = cacheCountForAttribute[a] or 0
          table.insert(list, "<li style='margin-bottom:1px'>"..attributeIcons[a].." "..attributeDescriptions[a].." (found "..c..")</li>")
        end
      end
      local missing = need-found
      if (count(list) >= missing) then
        table.insert(html, "You still need "..missing.." attribute"..s(missing).." from the following list:<ul>")
      else
        table.insert(html, "You still need "..missing.." attribute"..s(missing)..", but only "..count(list).." attribute"..s(count(list)).." available. Bad configuration?<ul>")
      end
      for _,line in pairs(list) do
        table.insert(html, line)
      end
      table.insert(html, "</ul></p>")
      ok = false
    end
  end
end

if (positive+negative == 0 and total == 0) then
  table.insert(html, "No requirements specified.")
  ok = false
elseif (total > 0) then
  feedback("Total", total, 0, 96*2)
else
  feedback("Positive", positive, 0, 96)
  feedback("Negative", negative, 96, 96)
end

html = table.concat(html, "\n")
log = table.concat(log, "\n")

return { ok = ok, log = log, html = html }

