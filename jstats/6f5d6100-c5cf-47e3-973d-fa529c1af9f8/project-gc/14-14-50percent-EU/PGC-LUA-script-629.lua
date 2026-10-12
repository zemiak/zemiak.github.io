local types =
{
  ["Traditional Cache"]                           = "https://www.geocaching.com/help/index.php?pg=file&from=2&id=1412",
  ["Multi-Cache"]                                 = "https://www.geocaching.com/help/index.php?pg=file&from=2&id=1413",
  ["Mystery Cache"]                               = "https://www.geocaching.com/help/index.php?pg=file&from=2&id=1414",
  ["Letterbox Hybrid"]                            = "https://www.geocaching.com/help/index.php?pg=file&from=2&id=1415",
  ["Wherigo Cache"]                               = "https://www.geocaching.com/help/index.php?pg=file&from=2&id=1416",
  ["Lab Cache"]                                   = "https://www.geocaching.com/help/index.php?pg=file&from=2&id=1417",
  ["Webcam Cache"]                                = "https://www.geocaching.com/help/index.php?pg=file&from=2&id=1418",
  ["Virtual Cache"]                               = "https://www.geocaching.com/help/index.php?pg=file&from=2&id=1419",
  ["Cache In Trash Out Event"]                    = "https://www.geocaching.com/help/index.php?pg=file&from=2&id=1426",
  ["Mega-Event Cache"]                            = "https://www.geocaching.com/help/index.php?pg=file&from=2&id=1421",
  ["Giga-Event Cache"]                            = "https://www.geocaching.com/help/index.php?pg=file&from=2&id=1422",
  ["GPS Adventures Maze Exhibit"]                 = "https://www.geocaching.com/help/index.php?pg=file&from=2&id=1423",
  ["Geocaching HQ Cache"]                              = "https://www.geocaching.com/help/index.php?pg=file&from=2&id=1424",
  ["Event Cache"]                                 = "https://www.geocaching.com/help/index.php?pg=file&from=2&id=1425",
  ["Locationless Cache"]                = "https://www.geocaching.com/help/index.php?pg=file&from=2&id=1429",
  ["EarthCache"]                                  = "https://s3.amazonaws.com/gs-geo-images/76ae4335-ecdd-4275-be5f-d6b4941df8eb.png",
  ["Project A.P.E. Cache"]                           = "https://s3.amazonaws.com/gs-geo-images/3d80d4a9-258a-4f9f-8c45-9443b752cbbb.png",
  ["Benchmark"]                                   = "http://www.geocaching.com/images/wpttypes/sm/27.gif",
  ["Community Celebration Event"]                  = "https://s3.amazonaws.com/gs-geo-images/8676475b-8d6f-4bf5-bb15-55de7b17745f.png",
  ["Geocaching HQ Celebration"]      = "http://www.geocaching.com/images/wpttypes/sm/3774.gif",
  ["Geocaching HQ Block Party"]                     = "http://www.geocaching.com/images/wpttypes/sm/4738.gif",
  ["GPS Adventures Maze Exhibit"]                      = "https://www.geocaching.com/help/index.php?pg=file&from=2&id=1423"
}

--[[
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
  [69] = "http://www.geocaching.com/images/attributes/bonuscache-yes.png",
  [70] = "http://www.geocaching.com/images/attributes/powertrail-yes.png",
  [71] = "http://www.geocaching.com/images/attributes/challengecache-yes.png",
  [72] = "http://www.geocaching.com/images/attributes/hqsolutionchecker-yes.png",

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
--]]

local args={...}
conf = args[1].config

function filter_attr(finds)
  
  function has_attr(f, attr, required)
    function int(i) return i-i%1 end
    if not attr then return false end
    if type(attr)=="table" then
      local done=0
      for _,a in ipairs(attr) do
        if has_attr(f,a) then done=done+1 end
        if done>=(required or 1) then return true end
      end
      return false
    end
    local bm;
    if attr>0 then
      bm={f.attributes_set_1,f.attributes_set_2,f.attributes_set_3}
    else
      attr=-attr;
      bm={f.attributes_unset_1,f.attributes_unset_2,f.attributes_unset_3}
    end
    attr=attr-1
    local b=bm[int(attr/32)+1]
    if not b then return false end
    local i=attr%32
    local div1={1,2,4,8,16,32,64,128}
    local div2={1, 256, 65536, 16777216}
  --  PGC.print("b= ",b," attr= ",attr,"\n")
  --  PGC.print("div2= ", div2[int(i/8+1)], "attr%8= ", attr%8, " div1= ", div1[i%8+1], "\n")
    return int(b/div2[int(i/8+1)]/div1[i%8+1])%2==1
  end
  
  local result={}
  for _,f in ipairs(finds) do
  	if  (not conf.attributes or has_attr(f,conf.attributes,conf.attributes_required) )
   	    and not has_attr(f,conf.exclude_attributes)
    then
      table.insert(result,f)
    end
  end
  PGC.print("after attr filter ", #result, " caches\n")
  return result
end

minAreas = tonumber(conf.countries)               -- minimum areas with finds needed
minFinds = tonumber(conf.findsPerCountry)         -- minimum finds per area needed
minTotal = tonumber(conf.findsTotal)              -- minimum total finds needed
ndetails = conf.list                              -- list of caches
local maxPlacedDate = "9999-12-31"

if minAreas == nil then minAreas = 1 end
if minFinds == nil then minFinds = 1 end
if minTotal == nil then minTotal = 1 end

profileName = args[1]['profileName']
profileId   = args[1]['profileId']

PGC.print('Got profile name, ', profileName, "\n")
PGC.print('Got profile id ', profileId, "\n")

fields = { 'country', 'cache_name', 'gccode', 'type', 'visitdate', 'hidden', 'log_id' }
local filter = {}

if conf.types ~= nil then filter['types'] = conf.types end
if conf.sizes ~= nil then filter['sizes'] = conf.sizes end
if conf.country ~= nil then filter['country'] = conf.country end

 if conf.attributes or conf.exclude_attributes then
    table.insert(fields, 'attributes_set')
    table.insert(fields, 'attributes_unset')
 end

if (conf.maxPlacedDate ~= nil) then maxPlacedDate = conf.maxPlacedDate end
    temp          = string.gsub(maxPlacedDate,"[^0-9]","")
    maxPlacedDate = tonumber(temp)

local TExcludedTypes      = {}
local TExcludedCountries  = {}
local TExcludedGCCodes    = {}

local keysMap
if conf.keys then
  keysMap = {}
  for _,k in ipairs(conf.keys) do
    keysMap[k] = k;
  end
end

local listAreas = conf.country

if type(listAreas) ~= 'table' then listAreas = {listAreas} end
local areaname  = conf.country
local tmp       = {country="Countries", region="Regions", county="Counties"}
local areanames = tmp[areaname]

filter['difficulties']  = conf.difficulties
filter['terrains']      = conf.terrains
filter['minVisitDate']  = conf.minVisitDate

myFinds = PGC.GetFinds( profileId, { fields = fields, filter = filter, order = 'OLDESTFIRST' } )
myFinds = filter_attr(myFinds)

    areaGroups             = {}
    cachecounter           = 0
    local logA             = {}
    local logB             = {}
    local htmlA            = {}
    local htmlB            = {}
    local areaGroupList    = {}
    local map = { caches = {}, polygons = {}, polygonLines = {}, circles = {}, correctedCoordinatesInUse = false }

    function founds_in_area(neededArea)
      for a,v in pairs(areaGroups) do
        if  v.qual[1]["country"] == neededArea then
          return v.find_counter;
        end
      end
      return 0
    end

table.insert(htmlA, "<table><tr><th>#</th><th>🌍 Country</th><th>🐸 Cache</th><th>😀 Found date</th><th>❇️ Placed date</th></tr>")
table.insert(htmlB, "<table><tr><th>#</th><th>🌍 Country</th><th>🐸 Cache</th><th>😀 Found date</th><th>❇️ Placed date</th></tr>")

  if conf.ExcludedTypes ~= nil then 	                 -- make a table indexed by type
    for _,cache in ipairs(conf.ExcludedTypes) do
      TExcludedTypes[cache] = 0
    end
  end

  if conf.ExcludedCountries ~= nil then 	            -- make a table indexed by country
    for _,cache in ipairs(conf.ExcludedCountries) do
      TExcludedCountries[cache] = 0
    end
  end

  if conf.ExcludedGCCodes ~= nil then 	              -- make a table indexed by GCCode
    for _,cache in ipairs(conf.ExcludedGCCodes) do
      TExcludedGCCodes[cache] = 0
    end
  end

for index,cache in pairs(myFinds) do
  if cache['type'] ~= 'Locationless Cache' then
    if TExcludedTypes[cache['type']] == nil then
      if TExcludedCountries[cache['country']] == nil
        and cache['gccode'] ~= nil
        and cache['gccode'] ~= ""
      then
        temp = string.gsub(cache['hidden'],"[^0-9]","")
        local placeddate = tonumber(temp)
          if (placeddate < maxPlacedDate) then
            PGC.print("gc ".. cache['gccode'] .. " Country " .. cache['country']
              .. " visitdate: " .. cache['visitdate'] .. " Log ID: " .. cache['log_id'],"\n")
            cachecounter = cachecounter + 1

              if minTotal > 1 and cachecounter <= minTotal then
                table.insert(logB, "[b]" .. cache.country .. "[/b]"
                  .. " [url=http://www.geocaching.com/seek/log.aspx?lid=" .. cache.log_id .. "]" .. cache.cache_name
                  .. " (" .. cache.gccode .. ")[/url]" .. " | " .. cache.visitdate .. " | " .. cache.hidden)

                table.insert(htmlB, "<tr><td>" .. cachecounter .. "</td><td><b>" .. PGC.Icon.CountryFlag(cache.country) .. " " .. cache.country .. "</b></td><td>"
                  .. PGC.Icon.GeocacheType(cache.type) .. " " .. '<a href=\"http://www.geocaching.com/seek/log.aspx?lid='
                  .. cache.log_id .. '" target="_blank">' .. cache.cache_name .. " (" .. cache.gccode .. ")</a></td><td>| "
                  .. cache.visitdate .. "</td><td>| " .. cache.hidden .. "</td></tr>")
              end

              if TExcludedCountries[cache['country']]         == nil
                and TExcludedGCCodes[cache['gccode']]         == nil
              then
                groupKey  = cache.country
                gcKey     = cache['gccode']
                groupData = areaGroups[groupKey]

                if (groupData == nil) then                              -- create new data structure for area
                  groupData = {}
                  groupData["qual"] = {}
                  groupData["find_counter"] = 0
                  areaGroups[groupKey] = groupData
                  table.insert(areaGroupList, groupKey)
                end

                table.insert(groupData["qual"], cache)
                groupData["find_counter"] = groupData["find_counter"] + 1
              end
          end
      end
    end
  end
end

logB = table.concat(logB, "\n")

AreasFound = 0
AreasAll   = 0

for _,group in ipairs(areaGroupList) do
  local groupData = areaGroups[group]
  AreaFinds = groupData["find_counter"]
  qualifyingCaches = groupData["qual"]
  AreasAll = AreasAll + 1

  if (AreaFinds >= minFinds) then                         -- minimum required finds by area
    AreasFound = AreasFound + 1
  end

  if (AreaFinds >= 1) then                                -- write into output
      AreaOutCount = 0

      for _,cache in ipairs(qualifyingCaches) do
          AreaOutCount = AreaOutCount + 1

          if AreasFound <= AreasFound then
            table.insert(logA, "[b]" .. cache.country .."[/b]"
              .. " [url=http://www.geocaching.com/seek/log.aspx?lid=" .. cache.log_id .. "]" .. cache.cache_name .. " (" .. cache.gccode .. ")[/url]" .. " | "
              .. cache.visitdate .. " | " .. cache.hidden)

              table.insert(htmlA, "<tr><td>" .. AreasAll .. "/".. AreaOutCount .. "</td><td><b>" .. PGC.Icon.CountryFlag(cache.country) .. " " .. cache.country .. "</b></td><td>"
                .. PGC.Icon.GeocacheType(cache.type) .. " " .. '<a href=\"http://www.geocaching.com/seek/log.aspx?lid='
                .. cache.log_id .. '" target="_blank">' .. cache.cache_name .. " (" .. cache.gccode .. ")</a></td><td>😃 "
                .. cache.visitdate .. "</td><td>📅 " .. cache.hidden .. "</td></tr>")
              table.insert(map.caches, cache.gccode)
          end

          if (AreaOutCount >= minFinds) then break end
      end
  end
end

logA = table.concat(logA, "\n")

local ok    = false
local html  = false
local since = ""
local log   = ""

if (AreasFound >= minAreas) and (cachecounter >= minTotal) then           -- minimum required areas found
  ok = true
else
  ok = false
end

  if conf.minVisitDate ~= nil then
    since = "Since " .. conf.minVisitDate .. ", "
  end

  log = since .. "I have found required number of caches (" .. minFinds .. ") in each of " .. AreasFound
    .. " countries (required number of countries: " .. minAreas .. ").\n"

  html = "<div style='width: 670px; height: 310px; background: url(https://s3.amazonaws.com/gs-geo-images/f5b7dc86-7f2e-42bb-9bc3-5be9156859b2.png); background-repeat: no-repeat; text-align: center; font-family: Trebuchet MS; Helvetica; font-size: 16px; color: #FFFFFF; padding: 248px 24px 24px;'>"
  html = html .. since .. "<b>" .. profileName .. " has found required number of caches (" .. minFinds .. ")</b> in each of <b>" .. AreasFound
    .. " countries.</b><br> Required number of countries: " .. minAreas .. ". "

  if ndetails == "show" then
    log  = log  .. "Finds in required countries are listed here:\n\n" .. logA .. "\n"
    html = html .. "More details about achievement below.</div> <hr>" .. table.concat(htmlA) .. "</table><hr>"
  
    	local htmlMissing = {}

    for _, neededArea in ipairs(listAreas or {}) do
      founds=founds_in_area(neededArea)

      if founds < minFinds then
        local missing = minFinds > 1 and " (" .. minFinds - founds .. " finds missing)" or ""
        table.insert(htmlMissing, "<li>" .. neededArea .. missing .. "</li>")
      end
    end

    if #htmlMissing > 0 then
      html = html .. "You still can add these countries up (not required):<ul>" .. table.concat(htmlMissing) .. "</ul>"
    end
  
  else
    html = html .. "</div>"
  end

  if minTotal > 1 then
    log  = log  .. "In total (respecting all challenge requirements and limitations), I have found " .. cachecounter .. " caches (required minimum: " .. minTotal .. ")."
    html = html .. "In total (respecting all challenge requirements and limitations), <b>" .. profileName .. "</b> has found<b> " .. cachecounter .. " caches</b> (required minimum: " .. minTotal .. ").<br>"

    if ndetails == "show" then
      log  = log  .. "Here is the list of " .. minTotal .. " required finds:\n\n" .. logB .. "[/code]\n"
      html = html .. "List of required " .. minTotal .. " finds is here:<hr>" .. table.concat(htmlB) .. "</table>"
  end
end

if ok == false then
    html = "<b>" .. profileName .. " does not qualify for this Challenge yet.</b><br>"

    if conf.minVisitDate ~= nil then
  		html = html .. "Since " .. conf.minVisitDate .. ", "
  	end

  	html = html .. "You have found required number of caches (" .. minFinds .. ") in " .. AreasFound .. " countries so far. Required minimum is " .. minAreas .. " countries.<br>"

    if ndetails == "show" then
        html = html .. "Finds in each country are listed here:<hr>" .. table.concat(htmlA) .. "</table><br>"
    end

    if minTotal > 1 then
      html = html .. "In total (respecting all challenge requirements and limitations), you have found " .. cachecounter .. " caches. Required minimum is " .. minTotal .. " caches.<br>"

      if ndetails == "show" then
        html = html .. "List of qualified finds, regardless country, is here:<hr>" .. table.concat(htmlB) .. "</table>"
      end
    end

    local htmlMissing = {}

    for _, neededArea in ipairs(listAreas or {}) do
      founds=founds_in_area(neededArea)

      if founds < minFinds then
        local missing = minFinds > 1 and " (" .. minFinds - founds .. " finds missing)" or ""
        table.insert(htmlMissing, "<li>" .. neededArea .. missing .. "</li>")
	  end
    end

    if #htmlMissing > 0 then
      html = html .. "List of missing countries:<ul>" .. table.concat(htmlMissing) .. "</ul>"
    end
end

return { ok = ok, log = log, html = html, map = map}
