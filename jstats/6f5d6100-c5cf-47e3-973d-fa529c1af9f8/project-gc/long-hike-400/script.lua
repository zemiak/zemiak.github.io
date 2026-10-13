local args={...}
local conf = args[1].config
local profileName = args[1].profileName
local profileId = args[1].profileId

local cachesWithAttribute = {}
local cacheCountForAttribute = {}

local solution = {}
local includedAttributes = conf.attributes

local ok = false
local log = false
local html = {}
local uniqueCaches = true
local solutionCount = 0

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
  ["Geocaching HQ Celebration"]="http://www.geocaching.com/images/WptTypes/3774.gif"
}

local attributeDescriptions =
{
  [1]  = "Dogs allowed",
  [2]  = "Access/parking fee",
  [3]  = "Climbing gear required",
  [4]  = "Boat required",
  [5]  = "Scuba gear required",
  [6]  = "Kid-friendly",
  [7]  = "Takes less than 1 hour",
  [8]  = "Scenic view",
  [9]  = "Significant hike",
  [10] = "Difficult climbing",
  [11] = "May require wading",
  [12] = "May require swimming",
  [13] = "Available 24/7",
  [14] = "Recommended at night",
  [15] = "Available in winter",
  [17] = "Poison plants",
  [18] = "Dangerous animals",
  [19] = "Ticks",
  [20] = "Abandoned mine nearby",
  [21] = "Cliffs/falling rocks nearby",
  [22] = "Hunting area",
  [23] = "Dangerous area",
  [24] = "Wheelchair-accessible",
  [25] = "Parking available",
  [26] = "Public transit available",
  [27] = "Drinking water nearby",
  [28] = "Restrooms available",
  [29] = "Telephone nearby",
  [30] = "Picnic tables available",
  [31] = "Camping available",
  [32] = "Bikes allowed",
  [33] = "Motorcycles allowed",
  [34] = "Quads allowed",
  [35] = "Off-road vehicles allowed",
  [36] = "Snowmobiles allowed",
  [37] = "Horses allowed",
  [38] = "Campfires allowed",
  [39] = "Thorns",
  [40] = "Stealth required",
  [41] = "Stroller-accessible",
  [42] = "Needs maintenance",
  [43] = "Watch for livestock",
  [44] = "Flashlight required",
  [45] = "Lost and found",
  [46] = "Truck-driver-/RV-accessible",
  [47] = "Field puzzle",
  [48] = "UV light required",
  [49] = "May require snowshoes",
  [50] = "Cross-country skis required",
  [51] = "Special tool required",
  [52] = "Night cache",
  [53] = "Park-and-grab",
  [54] = "In an abandoned structure",
  [55] = "Hike shorter than 1 km",
  [56] = "Hike between 1km-10km",
  [57] = "Hike longer than 10km",
  [58] = "Fuel nearby",
  [59] = "Food nearby",
  [60] = "Wireless beacon required",
  [61] = "Partnership cache",
  [62] = "Seasonal access only",
  [63] = "Recommended for tourists",
  [64] = "Tree-climbing required",
  [65] = "In front yard (with permission)",
  [66] = "Teamwork required",
  [67] = "Part of a GeoTour",
  [68] = "...This one is a mystery, Charlie Brown!...",
  
  [97] = "No dogs allowed",
  
  [102]= "Not recommended for kids",
  [103]= "Takes more than 1 hour",
  [104]= "No scenic view",
  [105]= "Not a significant hike",
  [106]= "No difficult climbing",
  
  [109]= "Not available 24/7",
  [110]= "Not recommended at night",
  [111]= "Not available in winter",
  
  [113]= "No poison plants",
  
  [120]= "Not wheelchair-accessible",
  [121]= "No parking available",
  
  [123]= "No drinking water available",
  [124]= "No public restrooms nearby",
  [125]= "No telephone nearby",
  [126]= "No picnic tables nearby",
  [127]= "No camping",
  [128]= "No bicycles",
  [129]= "No motorcycles",
  [130]= "No quads",
  [131]= "No off-road vehicles",
  [132]= "No snowmobiles",
  [133]= "No horses",
  [134]= "No campfires",
  
  [136]= "No stealth required",
  [137]= "Not stroller-accessible",
  
  [142]= "Not truck-driver-/RV-accessible",
  [143]= "Not a field puzzle",
  
  [148]= "Not recommended at night",
  [149]= "Not a park-and-grab",
  [150]= "Not in an abandoned structure",
  [151]= "Not a short hike",
  [152]= "Not a medium hike",
  [153]= "Not a long hike",
  [154]= "No fuel nearby",
  [155]= "No food nearby",
  
  [158]= "Available all year",
  [159]= "Not recommended for tourists",
  [160]= "No tree-climbing required",
  [161]= "Not in a front yard",
  [162]= "No teamwork required"
}

local attributeIcons =
{
  [1] = "http://www.geocaching.com/images/attributes/dogs-yes.gif",
  [2] = "http://www.geocaching.com/images/attributes/fee-yes.gif",
  [3] = "http://www.geocaching.com/images/attributes/rappelling-yes.gif",
  [4] = "http://www.geocaching.com/images/attributes/boat-yes.gif",
  [5] = "http://www.geocaching.com/images/attributes/scuba-yes.gif",
  [6] = "http://www.geocaching.com/images/attributes/kids-yes.gif",
  [7] = "http://www.geocaching.com/images/attributes/onehour-yes.gif",
  [8] = "http://www.geocaching.com/images/attributes/scenic-yes.gif",
  [9] = "http://www.geocaching.com/images/attributes/hiking-yes.gif",
  [10] = "http://www.geocaching.com/images/attributes/climbing-yes.gif",
  [11] = "http://www.geocaching.com/images/attributes/wading-yes.gif",
  [12] = "http://www.geocaching.com/images/attributes/swimming-yes.gif",
  [13] = "http://www.geocaching.com/images/attributes/available-yes.gif",
  [14] = "http://www.geocaching.com/images/attributes/night-yes.gif",
  [15] = "http://www.geocaching.com/images/attributes/winter-yes.gif",

  [17] = "http://www.geocaching.com/images/attributes/poisonoak-yes.gif",
  [18] = "http://www.geocaching.com/images/attributes/dangerousanimals-yes.gif",
  [19] = "http://www.geocaching.com/images/attributes/ticks-yes.gif",
  [20] = "http://www.geocaching.com/images/attributes/mine-yes.gif",
  [21] = "http://www.geocaching.com/images/attributes/cliff-yes.gif",
  [22] = "http://www.geocaching.com/images/attributes/hunting-yes.gif",
  [23] = "http://www.geocaching.com/images/attributes/danger-yes.gif",
  [24] = "http://www.geocaching.com/images/attributes/wheelchair-yes.gif",
  [25] = "http://www.geocaching.com/images/attributes/parking-yes.gif",
  [26] = "http://www.geocaching.com/images/attributes/public-yes.gif",
  [27] = "http://www.geocaching.com/images/attributes/water-yes.gif",
  [28] = "http://www.geocaching.com/images/attributes/restrooms-yes.gif",
  [29] = "http://www.geocaching.com/images/attributes/phone-yes.gif",
  [30] = "http://www.geocaching.com/images/attributes/picnic-yes.gif",
  [31] = "http://www.geocaching.com/images/attributes/camping-yes.gif",
  [32] = "http://www.geocaching.com/images/attributes/bicycles-yes.gif",
  [33] = "http://www.geocaching.com/images/attributes/motorcycles-yes.gif",
  [34] = "http://www.geocaching.com/images/attributes/quads-yes.gif",
  [35] = "http://www.geocaching.com/images/attributes/jeeps-yes.gif",
  [36] = "http://www.geocaching.com/images/attributes/snowmobiles-yes.gif",
  [37] = "http://www.geocaching.com/images/attributes/horses-yes.gif",
  [38] = "http://www.geocaching.com/images/attributes/campfires-yes.gif",
  [39] = "http://www.geocaching.com/images/attributes/thorn-yes.gif",
  [40] = "http://www.geocaching.com/images/attributes/stealth-yes.gif",
  [41] = "http://www.geocaching.com/images/attributes/stroller-yes.gif",
  [42] = "http://www.geocaching.com/images/attributes/firstaid-yes.gif",
  [43] = "http://www.geocaching.com/images/attributes/cow-yes.gif",
  [44] = "http://www.geocaching.com/images/attributes/flashlight-yes.gif",
  [45] = "http://www.geocaching.com/images/attributes/landf-yes.gif",
  [46] = "http://www.geocaching.com/images/attributes/rv-yes.gif",
  [47] = "http://www.geocaching.com/images/attributes/field_puzzle-yes.gif",
  [48] = "http://www.geocaching.com/images/attributes/UV-yes.gif",
  [49] = "http://www.geocaching.com/images/attributes/snowshoes-yes.gif",
  [50] = "http://www.geocaching.com/images/attributes/skiis-yes.gif",
  [51] = "http://www.geocaching.com/images/attributes/s-tool-yes.gif",
  [52] = "http://www.geocaching.com/images/attributes/nightcache-yes.gif",
  [53] = "http://www.geocaching.com/images/attributes/parkngrab-yes.gif",
  [54] = "http://www.geocaching.com/images/attributes/abandonedbuilding-yes.gif",
  [55] = "http://www.geocaching.com/images/attributes/hike_short-yes.gif",
  [56] = "http://www.geocaching.com/images/attributes/hike_med-yes.gif",
  [57] = "http://www.geocaching.com/images/attributes/hike_long-yes.gif",
  [58] = "http://www.geocaching.com/images/attributes/fuel-yes.gif",
  [59] = "http://www.geocaching.com/images/attributes/food-yes.gif",
  [60] = "http://www.geocaching.com/images/attributes/wirelessbeacon-yes.gif",
  [61] = "http://www.geocaching.com/images/attributes/partnership-yes.gif",
  [62] = "http://www.geocaching.com/images/attributes/seasonal-yes.gif",
  [63] = "http://www.geocaching.com/images/attributes/touristOK-yes.gif",
  [64] = "http://www.geocaching.com/images/attributes/treeclimbing-yes.gif",
  [65] = "http://www.geocaching.com/images/attributes/frontyard-yes.gif",
  [66] = "http://www.geocaching.com/images/attributes/teamwork-yes.gif",
  [67] = "http://www.geocaching.com/images/attributes/geotour-yes.gif",
  [68] = "http://www.example.com",

  [97] = "http://www.geocaching.com/images/attributes/dogs-no.gif",

  [102]= "http://www.geocaching.com/images/attributes/kids-no.gif",
  [103]= "http://www.geocaching.com/images/attributes/onehour-no.gif",
  [104]= "http://www.geocaching.com/images/attributes/scenic-no.gif",
  [105]= "http://www.geocaching.com/images/attributes/hiking-no.gif",
  [106]= "http://www.geocaching.com/images/attributes/climbing-no.gif",

  [109]= "http://www.geocaching.com/images/attributes/available-no.gif",
  [110]= "http://www.geocaching.com/images/attributes/night-no.gif",
  [111]= "http://www.geocaching.com/images/attributes/winter-no.gif",

  [113]= "http://www.geocaching.com/images/attributes/poisonoak-no.gif",

  [120]= "http://www.geocaching.com/images/attributes/wheelchair-no.gif",
  [121]= "http://www.geocaching.com/images/attributes/parking-no.gif",

  [123]= "http://www.geocaching.com/images/attributes/water-no.gif",
  [124]= "http://www.geocaching.com/images/attributes/restrooms-no.gif",
  [125]= "http://www.geocaching.com/images/attributes/phone-no.gif",
  [126]= "http://www.geocaching.com/images/attributes/picnic-no.gif",
  [127]= "http://www.geocaching.com/images/attributes/camping-no.gif",
  [128]= "http://www.geocaching.com/images/attributes/bicycles-no.gif",
  [129]= "http://www.geocaching.com/images/attributes/motorcycles-no.gif",
  [130]= "http://www.geocaching.com/images/attributes/quads-no.gif",
  [131]= "http://www.geocaching.com/images/attributes/jeeps-no.gif",
  [132]= "http://www.geocaching.com/images/attributes/snowmobiles-no.gif",
  [133]= "http://www.geocaching.com/images/attributes/horses-no.gif",
  [134]= "http://www.geocaching.com/images/attributes/campfires-no.gif",

  [136]= "http://www.geocaching.com/images/attributes/stealth-no.gif",
  [137]= "http://www.geocaching.com/images/attributes/stroller-no.gif",

  [142]= "http://www.geocaching.com/images/attributes/rv-no.gif",
  [143]= "http://www.geocaching.com/images/attributes/field_puzzle-no.gif",

  [148]= "http://www.geocaching.com/images/attributes/nightcache-no.gif",
  [149]= "http://www.geocaching.com/images/attributes/parkngrab-no.gif",
  [150]= "http://www.geocaching.com/images/attributes/abandonedbuilding-no.gif",
  [151]= "http://www.geocaching.com/images/attributes/hike_short-no.gif",
  [152]= "http://www.geocaching.com/images/attributes/hike_med-no.gif",
  [153]= "http://www.geocaching.com/images/attributes/hike_long-no.gif",
  [154]= "http://www.geocaching.com/images/attributes/fuel-no.gif",
  [155]= "http://www.geocaching.com/images/attributes/food-no.gif",

  [158]= "http://www.geocaching.com/images/attributes/seasonal-no.gif",
  [159]= "http://www.geocaching.com/images/attributes/touristOK-no.gif",
  [160]= "http://www.geocaching.com/images/attributes/treeclimbing-no.gif",
  [161]= "http://www.geocaching.com/images/attributes/frontyard-no.gif",
  [162]= "http://www.geocaching.com/images/attributes/teamwork-no.gif"
}

---------------------------------------------------------------------------------------
--                              Function Definitions                                 --
---------------------------------------------------------------------------------------

-- Given a bit index, get the value if that bit was set to 1
-- e.g.  given 4, set the fourth bit from the right to 1.  Result:  8
function bit(p)
  return 2 ^ (p - 1)  -- 1-based indexing
end

-- Given a bitfield and bitmask, AND the two to determine if the bitmask is set in this field.
function hasbit(x, p)
  return x % (p + p) >= p       
end

-- Take an attribute field from the GC data, and an attribute number, and figure if that attribute is set/unset.
-- If so, add the cache to an array of valid caches, indexed by attribute number
function processAttributes(attributesBits, bitMask, arrayIndex, cacheIndex)

  -- Only include attribute types that are required for this challenge
  if (includedAttributes[arrayIndex] == nil) then return end
  if (hasbit(attributesBits, bitMask)) then

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

---------------------------------------------------------------------------------------
--                            End Function Definitions                               --
---------------------------------------------------------------------------------------
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
local totalRequired = conf.total
local totalValid = 0
-- Get the user's finds

if (totalRequired == nil) then totalRequired = 0 end
local finds = PGC.GetFinds(profileId, { fields = {'gccode', 'cache_name', 'visitdate', 'attributes_set', 'attributes_unset', 'owner_id', 'type'}, filter=filter, order = 'OLDESTFIRST'})


-- Attributes are stored in six numerical fields, as bitfields.
-- The first 32 are in attributes_set_1
-- The next 32 are in attributes_set_2
-- The last 32 are in attributes_set_3
-- Deselected attributes are in attributes_unset_1, 2, 3

-- Mask out the selected/deselected attributes and store the caches according to attribute number
for index, cache in ipairs(finds) do

  for i = 1, 32 do
    local bitMask = bit(i)
 
    -- Convert attribute data from a group of bits to tables indexed by attribute number 
    processAttributes(cache.attributes_set_1, bitMask, i, index)
    processAttributes(cache.attributes_set_2, bitMask, i + 32, index)
    processAttributes(cache.attributes_set_3, bitMask, i + 64, index)
    
    processAttributes(cache.attributes_unset_1, bitMask, i + 96, index)
    processAttributes(cache.attributes_unset_2, bitMask, i + 128, index)
    processAttributes(cache.attributes_unset_3, bitMask, i + 160, index)

  end
end

local enoughCaches = true 
for attrNum, count in pairs(includedAttributes) do
  if (cacheCountForAttribute[attrNum] == nil) then cacheCountForAttribute[attrNum] = 0 end
  if (cacheCountForAttribute[attrNum] < count) then
    enoughCaches = false
    break
  end
   totalValid = totalValid + cacheCountForAttribute[attrNum]
end

ok = enoughCaches and totalValid >= totalRequired

-- Generate the sample log
if(ok == true) then
  log = {}
   	for attrNum, count in pairs(includedAttributes) do
    if cacheCountForAttribute[attrNum] == nil then
      	cacheCountForAttribute[attrNum]=0
     end
    local numRequired = count - cacheCountForAttribute[attrNum]
    if (numRequired < 0) then numRequired = 0 end
    table.insert(log, "You have found " .. cacheCountForAttribute[attrNum] .. ' caches of type "' .. attributeDescriptions[attrNum] .. '"')
  end
  
  if conf.shortLog ~= true then 
  table.insert(log, "Here are my qualifying caches:\n")
  	for attrNum, count in pairs(includedAttributes) do
   	 for cacheNum = 1, count do
   	   local cache = finds[cachesWithAttribute[attrNum][cacheNum]]
   	   table.insert(log, "[b]" .. attributeDescriptions[attrNum] .."[/b]"..
        	" found " .. cache.visitdate..
       		" [url=http://coord.info/" .. cache.gccode .. "]" .. cache.cache_name .. 
            " (" .. cache.gccode .. ")[/url]")
      
   	 end
 	 end
    end

  
  log = table.concat(log, "\n")
end

-- Generate the HTML message to the user
if (ok == true) then
  
  	for attrNum, count in pairs(includedAttributes) do
    if cacheCountForAttribute[attrNum] == nil then
      	cacheCountForAttribute[attrNum]=0
     end
    local numRequired = count - cacheCountForAttribute[attrNum]
    if (numRequired < 0) then numRequired = 0 end
    if (numRequired > 0) then
      color = "red"
      symbol = "✘"
    else
      color = "green"
      symbol = "✓"
    end
    table.insert(html, "<div><span style='font-size:20pt;font-weight:bold;color:" .. color .. ";'>" .. symbol .. "</span><img  style='margin-bottom:2px' src='" .. attributeIcons[attrNum] .. "' />&nbsp;You have found <span style='font-size:18pt;font-weight:bold;color:" .. color .. ";'>" .. cacheCountForAttribute[attrNum] .. '</span> caches of type "' .. attributeDescriptions[attrNum] .. '"</div>')
  end
  
  if conf.shortLog ~= true then 
  	table.insert(html, "<table><tr><th></th><th>Attribute</th><th>Cache</th><th>Owner</th><th>Found date</th></tr>")
  	for attrNum, count in pairs(includedAttributes) do
    	for cacheNum = 1, count do
      	local cache = finds[cachesWithAttribute[attrNum][cacheNum]]
        if cache.owner_id ~= nil then
    	    table.insert(html, "<tr><td><img  style='margin-bottom:2px;' src='" .. attributeIcons[attrNum] .. "' /></td><td><b>" .. attributeDescriptions[attrNum] .. '</b></td><td><img src="' .. types[cache.type] .. '" />&nbsp;<a href=\"http://coord.info/' .. cache.gccode .. '">' .. cache.cache_name .. " (" .. cache.gccode .. ")</a></td><td><a href=\"http://www.geocaching.com/profile/?id=" .. cache.owner_id .. '">' .. PGC.ProfileId2Name(cache.owner_id) .. "</a></td><td>" .. cache.visitdate .. "</td></tr>")
      	else
          table.insert(html, "<tr><td><img  style='margin-bottom:2px;' src='" .. attributeIcons[attrNum] .. "' /></td><td><b>" .. attributeDescriptions[attrNum] .. '</b></td><td><img src="' .. types[cache.type] .. '" />&nbsp;<a href=\"http://coord.info/' .. cache.gccode .. '">' .. cache.cache_name .. " (" .. cache.gccode .. ")</a></td><td></td><td>" .. cache.visitdate .. "</td></tr>")
        end
   	 end
  	end
  end
else
  for attrNum, count in pairs(includedAttributes) do
    if cacheCountForAttribute[attrNum] == nil then
      	cacheCountForAttribute[attrNum]=0
     end
    local numRequired = count - cacheCountForAttribute[attrNum]
    if (numRequired < 0) then numRequired = 0 end
    if (numRequired > 0) then
      color = "red"
      symbol = "✘"
    else
      color = "green"
      symbol = "✓"
    end
    table.insert(html, "<div><span style='font-size:20pt;font-weight:bold;color:" .. color .. ";'>" .. symbol .. "</span><img  style='margin-bottom:2px' src='" .. attributeIcons[attrNum] .. "' />&nbsp;You have found <span style='font-size:18pt;font-weight:bold;color:" .. color .. ";'>" .. cacheCountForAttribute[attrNum] .. '</span> caches of type "' .. attributeDescriptions[attrNum] .. '". You require <span style="font-size:18pt;font-weight:bold;color:' .. color .. ';">' .. numRequired .. "</span> more caches of this type.</div>")
  end
end
 

if (totalRequired > 0) then
  local numRequired = totalRequired - totalValid
  if (numRequired < 0) then numRequired = 0 end
  if (numRequired > 0) then
    color = "red"
    symbol = "✘"
  else
    color = "green"
    symbol = "✓"
  end
  table.insert(html, "<div><span style='font-size:20pt;font-weight:bold;color:" .. color .. ";'>" .. symbol .. "</span>&nbsp;You have found <span style='font-size:18pt;font-weight:bold;color:" .. color .. ";'>" .. totalValid .. '</span> caches with attributes of the required types. You require <span style="font-size:18pt;font-weight:bold;color:' .. color .. ';">' .. numRequired .. "</span> more caches with these attributes.</div><br />")
end
html = table.concat(html)

return { ok = ok, log = log, html = html }
