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
  [1]  = "Dogs",
  [2]  = "Access/parking fee",
  [3]  = "Climbing gear required",
  [4]  = "Boat required",
  [5]  = "Scuba gear required",
  [6]  = "Recommended for kids",
  [7]  = "Takes less than one hour",
  [8]  = "Scenic view",
  [9]  = "Significant hike",
  [10] = "Difficult climb",
  [11] = "May require wading",
  [12] = "May require swimming",
  [13] = "Available 24/7",
  [14] = "Recommended at night",
  [15] = "Available in winter",
  [17] = "Poisonous plants",
  [18] = "Dangerous animals",
  [19] = "Ticks",
  [20] = "Abandoned mine",
  [21] = "Cliff/falling rocks",
  [22] = "Hunting area",
  [23] = "Dangerous area",
  [24] = "Wheelchair-accessible",
  [25] = "Parking nearby",
  [26] = "Public transportation nearby",
  [27] = "Drinking water nearby",
  [28] = "Public restrooms nearby",
  [29] = "Telephone nearby", 
  [30] = "Picnic tables nearby",
  [31] = "Camping nearby",
  [32] = "Bicycles",
  [33] = "Motorcycles",
  [34] = "Quads",
  [35] = "Off-road vehicles",
  [36] = "Snowmobiles",
  [37] = "Horses",
  [38] = "Campfires",
  [39] = "Thorns",
  [40] = "Stealth required",
  [41] = "Stroller-accessible",
  [42] = "Needs maintenance",
  [43] = "Livestock nearby",
  [44] = "Flashlight required",
  [45] = "Lost and Found tour",
  [46] = "Trucks/RVs",
  [47] = "Field puzzle",
  [48] = "UV light required",
  [49] = "May require snowshoes",
  [50] = "May require cross country skis",
  [51] = "Special tool required",
  [52] = "Night cache",
  [53] = "Park and grab",
  [54] = "Abandoned structure",
  [55] = "Short hike (<1 km)",
  [56] = "Medium hike (1 km–10 km)",
  [57] = "Long hike (>10 km)",
  [58] = "Fuel nearby",
  [59] = "Food nearby",
  [60] = "Wireless beacon",
  [61] = "Partnership cache",
  [62] = "Seasonal access",
  [63] = "Recommended for tourists",
  [64] = "Tree climbing required",
  [65] = "Yard (private residence)",
  [66] = "Teamwork cache",
  [67] = "GeoTour",
  [68] = "...This one is a mystery, Charlie Brown!...",
  [69] = "Bonus cache",
  [70] = "Power trail",
  [71] = "Challenge cache",
  [72] = "Geocaching.com solution checker",

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

  [148]= "Not a night cache",
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
  [1] = "https://project-gc.com/images/gc-attributes/dogs-yes.png",
  [2] = "https://project-gc.com/images/gc-attributes/fee-yes.png",
  [3] = "https://project-gc.com/images/gc-attributes/rappelling-yes.png",
  [4] = "https://project-gc.com/images/gc-attributes/boat-yes.png",
  [5] = "https://project-gc.com/images/gc-attributes/scuba-yes.png",
  [6] = "https://project-gc.com/images/gc-attributes/kids-yes.png",
  [7] = "https://project-gc.com/images/gc-attributes/onehour-yes.png",
  [8] = "https://project-gc.com/images/gc-attributes/scenic-yes.png",
  [9] = "https://project-gc.com/images/gc-attributes/hiking-yes.png",
  [10] = "https://project-gc.com/images/gc-attributes/climbing-yes.png",
  [11] = "https://project-gc.com/images/gc-attributes/wading-yes.png",
  [12] = "https://project-gc.com/images/gc-attributes/swimming-yes.png",
  [13] = "https://project-gc.com/images/gc-attributes/available-yes.png",
  [14] = "https://project-gc.com/images/gc-attributes/night-yes.png",
  [15] = "https://project-gc.com/images/gc-attributes/winter-yes.png",
 
  [17] = "https://project-gc.com/images/gc-attributes/poisonoak-yes.png",
  [18] = "https://project-gc.com/images/gc-attributes/dangerousanimals-yes.png",
  [19] = "https://project-gc.com/images/gc-attributes/ticks-yes.png",
  [20] = "https://project-gc.com/images/gc-attributes/mine-yes.png",
  [21] = "https://project-gc.com/images/gc-attributes/cliff-yes.png",
  [22] = "https://project-gc.com/images/gc-attributes/hunting-yes.png",
  [23] = "https://project-gc.com/images/gc-attributes/danger-yes.png",
  [24] = "https://project-gc.com/images/gc-attributes/wheelchair-yes.png",
  [25] = "https://project-gc.com/images/gc-attributes/parking-yes.png",
  [26] = "https://project-gc.com/images/gc-attributes/public-yes.png",
  [27] = "https://project-gc.com/images/gc-attributes/water-yes.png",
  [28] = "https://project-gc.com/images/gc-attributes/restrooms-yes.png",
  [29] = "https://project-gc.com/images/gc-attributes/phone-yes.png",
  [30] = "https://project-gc.com/images/gc-attributes/picnic-yes.png",
  [31] = "https://project-gc.com/images/gc-attributes/camping-yes.png",
  [32] = "https://project-gc.com/images/gc-attributes/bicycles-yes.png",
  [33] = "https://project-gc.com/images/gc-attributes/motorcycles-yes.png",
  [34] = "https://project-gc.com/images/gc-attributes/quads-yes.png",
  [35] = "https://project-gc.com/images/gc-attributes/jeeps-yes.png",
  [36] = "https://project-gc.com/images/gc-attributes/snowmobiles-yes.png",
  [37] = "https://project-gc.com/images/gc-attributes/horses-yes.png",
  [38] = "https://project-gc.com/images/gc-attributes/campfires-yes.png",
  [39] = "https://project-gc.com/images/gc-attributes/thorn-yes.png",
  [40] = "https://project-gc.com/images/gc-attributes/stealth-yes.png",
  [41] = "https://project-gc.com/images/gc-attributes/stroller-yes.png",
  [42] = "https://project-gc.com/images/gc-attributes/firstaid-yes.png",
  [43] = "https://project-gc.com/images/gc-attributes/cow-yes.png",
  [44] = "https://project-gc.com/images/gc-attributes/flashlight-yes.png",
  [45] = "https://project-gc.com/images/gc-attributes/landf-yes.png",
  [46] = "https://project-gc.com/images/gc-attributes/rv-yes.png",
  [47] = "https://project-gc.com/images/gc-attributes/field_puzzle-yes.png",
  [48] = "https://project-gc.com/images/gc-attributes/UV-yes.png",
  [49] = "https://project-gc.com/images/gc-attributes/snowshoes-yes.png",
  [50] = "https://project-gc.com/images/gc-attributes/skiis-yes.png",
  [51] = "https://project-gc.com/images/gc-attributes/s-tool-yes.png",
  [52] = "https://project-gc.com/images/gc-attributes/nightcache-yes.png",
  [53] = "https://project-gc.com/images/gc-attributes/parkngrab-yes.png",
  [54] = "https://project-gc.com/images/gc-attributes/AbandonedBuilding-yes.png",
  [55] = "https://project-gc.com/images/gc-attributes/hike_short-yes.png",
  [56] = "https://project-gc.com/images/gc-attributes/hike_med-yes.png",
  [57] = "https://project-gc.com/images/gc-attributes/hike_long-yes.png",
  [58] = "https://project-gc.com/images/gc-attributes/fuel-yes.png",
  [59] = "https://project-gc.com/images/gc-attributes/food-yes.png",
  [60] = "https://project-gc.com/images/gc-attributes/wirelessbeacon-yes.png",
  [61] = "https://project-gc.com/images/gc-attributes/partnership-yes.png",
  [62] = "https://project-gc.com/images/gc-attributes/seasonal-yes.png",
  [63] = "https://project-gc.com/images/gc-attributes/touristOK-yes.png",
  [64] = "https://project-gc.com/images/gc-attributes/treeclimbing-yes.png",
  [65] = "https://project-gc.com/images/gc-attributes/frontyard-yes.png",
  [66] = "https://project-gc.com/images/gc-attributes/teamwork-yes.png",
  [67] = "https://project-gc.com/images/gc-attributes/geotour-yes.png",
  [68] = "http://www.example.com",
  [69] = "https://project-gc.com/images/gc-attributes/bonuscache-yes.png",
  [70] = "https://project-gc.com/images/gc-attributes/powertrail-yes.png",
  [71] = "https://project-gc.com/images/gc-attributes/challengecache-yes.png",
  [72] = "https://project-gc.com/images/gc-attributes/hqsolutionchecker-yes.png",

  [97] = "https://project-gc.com/images/gc-attributes/dogs-no.png",

  [102]= "https://project-gc.com/images/gc-attributes/kids-no.png",
  [103]= "https://project-gc.com/images/gc-attributes/onehour-no.png",
  [104]= "https://project-gc.com/images/gc-attributes/scenic-no.png",
  [105]= "https://project-gc.com/images/gc-attributes/hiking-no.png",
  [106]= "https://project-gc.com/images/gc-attributes/climbing-no.png",

  [109]= "https://project-gc.com/images/gc-attributes/available-no.png",
  [110]= "https://project-gc.com/images/gc-attributes/night-no.png",
  [111]= "https://project-gc.com/images/gc-attributes/winter-no.png",

  [113]= "https://project-gc.com/images/gc-attributes/poisonoak-no.png",

  [120]= "https://project-gc.com/images/gc-attributes/wheelchair-no.png",
  [121]= "https://project-gc.com/images/gc-attributes/parking-no.png",

  [123]= "https://project-gc.com/images/gc-attributes/water-no.png",
  [124]= "https://project-gc.com/images/gc-attributes/restrooms-no.png",
  [125]= "https://project-gc.com/images/gc-attributes/phone-no.png",
  [126]= "https://project-gc.com/images/gc-attributes/picnic-no.png",
  [127]= "https://project-gc.com/images/gc-attributes/camping-no.png",
  [128]= "https://project-gc.com/images/gc-attributes/bicycles-no.png",
  [129]= "https://project-gc.com/images/gc-attributes/motorcycles-no.png",
  [130]= "https://project-gc.com/images/gc-attributes/quads-no.png",
  [131]= "https://project-gc.com/images/gc-attributes/jeeps-no.png",
  [132]= "https://project-gc.com/images/gc-attributes/snowmobiles-no.png",
  [133]= "https://project-gc.com/images/gc-attributes/horses-no.png",
  [134]= "https://project-gc.com/images/gc-attributes/campfires-no.png",

  [136]= "https://project-gc.com/images/gc-attributes/stealth-no.png",
  [137]= "https://project-gc.com/images/gc-attributes/stroller-no.png",

  [142]= "https://project-gc.com/images/gc-attributes/rv-no.png",
  [143]= "https://project-gc.com/images/gc-attributes/field_puzzle-no.png",

  [148]= "https://project-gc.com/images/gc-attributes/nightcache-no.png",
  [149]= "https://project-gc.com/images/gc-attributes/parkngrab-no.png",
  [150]= "https://project-gc.com/images/gc-attributes/AbandonedBuilding-no.png",
  [151]= "https://project-gc.com/images/gc-attributes/hike_short-no.png",
  [152]= "https://project-gc.com/images/gc-attributes/hike_med-no.png",
  [153]= "https://project-gc.com/images/gc-attributes/hike_long-no.png",
  [154]= "https://project-gc.com/images/gc-attributes/fuel-no.png",
  [155]= "https://project-gc.com/images/gc-attributes/food-no.png",

  [158]= "https://project-gc.com/images/gc-attributes/seasonal-no.png",
  [159]= "https://project-gc.com/images/gc-attributes/touristOK-no.png",
  [160]= "https://project-gc.com/images/gc-attributes/treeclimbing-no.png",
  [161]= "https://project-gc.com/images/gc-attributes/frontyard-no.png",
  [162]= "https://project-gc.com/images/gc-attributes/teamwork-no.png"
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
      symbol = "&#x2612;"
    else
      color = "green"
      symbol = "&#x2611;"
    end
    table.insert(html, "<div><span style='font-size:20pt;font-weight:bold;color:" .. color .. ";'>" .. symbol .. "</span><img  style='margin-bottom:2px;width:30px;height:30px' src='" .. attributeIcons[attrNum] .. "' />&nbsp;You have found <span style='font-size:18pt;font-weight:bold;color:" .. color .. ";'>" .. cacheCountForAttribute[attrNum] .. '</span> caches of type "' .. attributeDescriptions[attrNum] .. '"</div>')
  end

  if conf.shortLog ~= true then
  	table.insert(html, "<table><tr><th></th><th>Attribute</th><th>Cache</th><th>Owner</th><th>Found date</th></tr>")
  	for attrNum, count in pairs(includedAttributes) do
    	for cacheNum = 1, count do
      	local cache = finds[cachesWithAttribute[attrNum][cacheNum]]
    	if cache.owner_id ~= nil then
    	    table.insert(html, "<tr><td><img  style='margin-bottom:2px;width:30px;height:30px' src='" .. attributeIcons[attrNum] .. "' /></td><td><b>" .. attributeDescriptions[attrNum] .. '</b></td><td><img src="' .. types[cache.type] .. '" />&nbsp;<a href=\"http://coord.info/' .. cache.gccode .. '">' .. cache.cache_name .. " (" .. cache.gccode .. ")</a></td><td><a href=\"http://www.geocaching.com/profile/?id=" .. cache.owner_id .. '">' .. PGC.ProfileId2Name(cache.owner_id) .. "</a></td><td>" .. cache.visitdate .. "</td></tr>")
      	else
          table.insert(html, "<tr><td><img  style='margin-bottom:2px;width:30px;height:30px' src='" .. attributeIcons[attrNum] .. "' /></td><td><b>" .. attributeDescriptions[attrNum] .. '</b></td><td><img src="' .. types[cache.type] .. '" />&nbsp;<a href=\"http://coord.info/' .. cache.gccode .. '">' .. cache.cache_name .. " (" .. cache.gccode .. ")</a></td><td></td><td>" .. cache.visitdate .. "</td></tr>")
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
      symbol = "&#x2612;"
    else
      color = "green"
      symbol = "&#x2611;"
    end
    table.insert(html, "<div><span style='font-size:20pt;font-weight:bold;color:" .. color .. ";'>" .. symbol .. "</span><img  style='margin-bottom:2px;width:30px;height:30px' src='" .. attributeIcons[attrNum] .. "' />&nbsp;You have found <span style='font-size:18pt;font-weight:bold;color:" .. color .. ";'>" .. cacheCountForAttribute[attrNum] .. '</span> caches of type "' .. attributeDescriptions[attrNum] .. '". You require <span style="font-size:18pt;font-weight:bold;color:' .. color .. ';">' .. numRequired .. "</span> more caches of this type.</div>")
  end
end


if (totalRequired > 0) then
  local numRequired = totalRequired - totalValid
  if (numRequired < 0) then numRequired = 0 end
  if (numRequired > 0) then
    color = "red"
    symbol = "&#x2612;"
  else
    color = "green"
    symbol = "&#x2611;"
  end
  table.insert(html, "<div><span style='font-size:20pt;font-weight:bold;color:" .. color .. ";'>" .. symbol .. "</span>&nbsp;You have found <span style='font-size:18pt;font-weight:bold;color:" .. color .. ";'>" .. totalValid .. '</span> caches with attributes of the required types. You require <span style="font-size:18pt;font-weight:bold;color:' .. color .. ';">' .. numRequired .. "</span> more caches with these attributes.</div><br />")
end
html = table.concat(html)

return { ok = ok, log = log, html = html }
