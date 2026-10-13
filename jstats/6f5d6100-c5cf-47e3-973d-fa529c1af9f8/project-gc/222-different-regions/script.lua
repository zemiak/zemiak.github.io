--[[
Supported parameters:
"types": string or array with cache types to be INCLUDED in the search (default see "excludeLocationless"). Supports "Events" for all Event Cache Types and "Physical" for all types with logbook.
"excludedTypes": string or array with cache types to be EXCLUDED from the search (default see "excludeLocationless"). Supports "Events" and "Physical".
"excludeLocationless": do not count "Locationless Cache" (default: true)

"sizes": string or array with cache sizes to be INCLUDED in search (default: all sizes included)
"excludedSizes": string or array with cache sizes to be EXCLUDED from search (default: none excluded)

"difficulties": array of difficulty values 1.0 - 5.0 to be INCLUDED in search (default: all difficulties included)
"excludedDifficulties": array of difficulty values 1.0 - 5.0 to be EXCLUDED in search (default: none excluded)

"terrains": An array of valid terrain values 1.0 - 5.0 to be INCLUDED in search (default: all terrains included)
"excludedTerrains": An array of valid terrain values 1.0 - 5.0 to be EXCLUDED in search (default: none excluded)

"minElevation": minimum elevation in meters that a cache must have to be counted (default: none)
"maxElevation": maximum elevation in meters that a cache must have to be counted (default: none)

"attributes": one or more attributes that a cache must have (number or [numbers], optional)
"attributesPerCache": number of required attributes that a cache must have at the same time (default: 1)

"filter": optional PGC.GetFinds() filter, can be used in case you want to filter for anything else than types/sizes/difficulties/terrains (default: no further filtering)

"ignoreBookmark": do not count caches on the official "Caches Excluded from Souvenirs and Statistics" list (https://www.geocaching.com/plan/lists/BMAFMJR) (default: true)
"excludedCaches": optional array of GC codes that shall be ignored (default: none)

"allowedCountries": only count finds in the listed countries / regions / counties (optional). Can be set to:
  - a single country, i.e. "allowedCountries": "Germany"
  - some macros are available to define country groups, i.e. continents ("Europe", "North America", "South America", "Africa", "Asia", "Oceania", "Antarctica") or "European Union",
  - Project-GC's country lists for continents can be used with these macros: "PGC.Europe", "PGC.Asia", "PGC.Africa", "PGC.Central America", "PGC.Oceania", "PGC.North America", "PGC.South America",
    "PGC.Antarctic and subantarctic islands"
  - an array of countries, i.e. "allowedCountries": ["Germany", "Austria"]
  - an object, if regions or counties inside countries shall be restricted, i.e. "allowedCountries": { "Germany": { "allowedRegions": ...} }
  "excludedRegions" can be set to a single region or an array of regions in which caches are not counted
  "allowedRegions" can be set to:
    - a single region, i.e. "allowedRegions": "Bayern"
    - an array of regions, i.e. "allowedRegions": ["Bayern", "Berlin"]
  "allowedCounties" can be set to:
    - a single county, i.e. "allowedCounties": "Rosenheim"
    - an array of counties, i.e. "allowedCounties": ["Bayreuth (Lkr)", "Dachau (Lkr)"]
  When "allowedRegions" or "allowedCounties" are listed, only caches in one of these regions or counties will be counted.
"excludedCountries": allows finds everywhere in the world except in the listed countries. This can only be used when "allowedCountries" is not used.
  - can be set to "MostFoundCountry" to exclude the country in which the player found the most caches
  - "excludedRegions": when set inside excludedCountries, allows finds everywhere except in the listed regions

"findsTotal": total number of finds required (default: 0)
"continents": number of continents required (default: 0)
"countries": number of countries required (default: 0), can be set too "all" when "allowedCountries" is restricted
"regions": number of regions required (default: 0), can be set too "all" when "allowedCountries" is restricted
"counties": number of counties required (default: 0), can be set too "all" when "allowedCountries" is restricted
At least one of findsTotal/countries/regions/counties must be set to >0.

"log": optional summary log to output above the individual conditions that must be fulfilled
"findsTotalLog": optional custom log to be used for the "findsTotal" condition
"continentsLog": optional custom log to be used for the "continents" condition
"countriesLog": optional custom log to be used for the "countries" condition
"regionsLog": optional custom log to be used for the "regions" condition
"countiesLog": optional custom log to be used for the "counties" condition

"findsPerContinent": number of finds required in each continent (optional)
"typesPerContinent": number of cache types required in each continent (optional)
"sizesPerContinent": number of cache sizes required in each continent (optional)
"countriesPerContinent": number of counties required in each continent (optional)
"regionsPerContinent": number of regions required in each continent (optional)
"countiesPerContinent": number of counties required in each continent (optional)

"findsPerCountry": number of finds required in each country (optional)
"typesPerCountry": number of cache types required in each country (optional)
"sizesPerCountry": number of cache sizes required in each country (optional)
"regionsPerCountry": number of regions required in each country (optional)
"regionsPerCountryPercent": percentage of regions required in each country 0-100 (optional)
"countiesPerCountry": number of counties required in each country (optional)
"countiesPerCountryPercent": percentage of counties required in each country 0-100 (optional)

"findsPerRegion": number of finds required in each region (optional)
"typesPerRegion": number of cache types required in each region (optional)
"sizesPerRegion": number of cache sizes required in each region (optional)
"countiesPerRegion": number of counties required in each region (optional)
"countiesPerRegionPercent": percentage of counties required in each region 0-100 (optional)

"findsPerCounty": number of finds required in each county (optional)
"typesPerCounty": number of cache types required in each county (optional)
"sizesPerCounty": number of cache sizes required in each county (optional)

"findsPerType": number of finds required for each type (optional, used for typesPerContinent, typesPerCountry, typesPerRegion, typesPerCounty)
"findsPerTypeCountdown": number by which "findsPerType" shall be reduced after each found Continent / Country / Region / County (optional)
"findsPerSize": number of finds required for each size (optional, used for sizesPerContinent, sizesPerCountry, sizesPerRegion, sizesPerCounty)

If multiple of the conditions above are set, all of them must be fulfilled.

"showContinentsInList": when set to true, the found continents are shown in the text output (default: false). Can be set to a number or "all" to control how many list entries shall be shown.

"showCountriesOnMap": when set to true and "countries" > 0, the found countries are shown on the map (default: false)
"showCountriesInList": when set to true, the found countries are shown in the text output (default: false). Can be set to a number or "all" to control how many list entries shall be shown.
"colorCountryPassed": color in which found countries are shown (default: "#006030")
"colorCountryMissing": color in which missing countries are shown (default: "#600030"). Missing countries are only shown when "allowedCountries" is set
"opacityCountry": opacity with which countries are shown on the map (default: 0.1)

"showRegionsOnMap": when set to true and "regions" > 0, the found regions are shown on the map (default: false)
"showRegionsInList": when set to true, the found regions are shown in the text output (default: false). Can be set to a number or "all" to control how many list entries shall be shown.
"colorRegionPassed": color in which found regions are shown (default: "#008040")
"colorRegionMissing": color in which missing regions are shown (default: "#800040")
"opacityRegion": opacity with which regions are shown on the map (default: 0.1)

"showCountiesOnMap": when set to true and "counties" > 0, the found counties are shown on the map (default: false)
"showCountiesInList": when set to true, the found counties are shown in the text output (default: false). Can be set to a number or "all" to control how many list entries shall be shown.
"colorCountyPassed": color in which found counties are shown (default: "#00C000")
"colorCountyMissing": color in which missing counties are shown (default: "#C00000")
"opacityCounty": opacity with which counties are shown on the map (default: 0.15)

"showCachesOnMap": when set to true and a certain number of finds or types is required, those number of caches are shown on the map
"showCachesInList": when set to true and a certain number of finds or types is required, those number of caches are shown in the text output
"showTypesAsSummary": when set to true, the required types are not listed as individual caches, but a summary is listed how many caches of each type were found
"showSizesAsSummary": when set to true, the required sizes are not listed as individual caches, but a summary is listed how many caches of each size were found

"showProgressWhenQualified": when set to true, progress on partial qualifications is still shown when the challenge criteria is fulfilled (default: false)
]]

local args = {...}
local conf = args[1].config
local profileName = args[1].profileName
local profileId = args[1].profileId
local gccode = args[1].gccode -- gccode from the tag
PGC.print('Got profile name, ', profileName, '\n')

-- need to use os.time() to determine elapsed runtime, as PGC.GetCPUUsage() doesn't return useful data to prevent checker timeout
local startTime = os.time()
local maxExecutionTime = args[1].environmentSettings.maxExecutionTime

-- some 'defines' to control which columns can be omitted when printing a cache
SKIP_NONE = 0
SKIP_COUNTRY = 1
SKIP_COUNTRY_REGION = 2
SKIP_COUNTRY_REGION_COUNTY = 3
SHOW_TYPE_FIRST = 4
SHOW_SIZE_FIRST = 5

-- continents list countries that mostly belong to that continent from the geographical point of view. For some countries that span more than 1 continent, some regions on the second continent are defined
local continents = {
  ["Europe"] = {
    "Åland Islands", "Albania", "Andorra", "Austria", "Belarus", "Belgium", "Bosnia and Herzegovina", "Bulgaria", "Croatia", "Czechia", "Denmark", "Estonia", "Faroe Islands", "Finland", "France", "Germany",
    "Gibraltar", "Greece", "Guernsey", "Hungary", "Iceland", "Ireland", "Isle of Man", "Italy", "Jersey", "Latvia", "Liechtenstein", "Lithuania", "Luxembourg", "Malta", "Moldova", "Monaco", "Montenegro",
    "Netherlands", "North Macedonia", "Norway", "Poland", "Portugal", "Romania", "Russia", "San Marino", "Sark", "Serbia", "Slovakia", "Slovenia", "Spain", "Svalbard and Jan Mayen Islands", "Sweden",
    "Switzerland", "Ukraine", "United Kingdom", "Vatican City State"
  },
  ["North America"] = {
    "Anguilla", "Antigua and Barbuda", "Bahamas", "Barbados", "Belize", "Bermuda", "British Virgin Islands", "Canada", "Cayman Islands", "Costa Rica", "Cuba", "Dominica", "Dominican Republic", "El Salvador",
    "Greenland", "Grenada", "Guadeloupe", "Guatemala", "Haiti", "Honduras", "Jamaica", "Martinique", "Mexico", "Montserrat", "Nicaragua", "Panama", "Puerto Rico", "Saint Barthélemy", "Saint Kitts and Nevis",
    "Saint Lucia", "Saint Martin", "Saint Pierre and Miquelon", "Saint Vincent and the Grenadines", "Sint Maarten", "Turks and Caicos Islands", "United States", "US Virgin Islands"
  },
  ["South America"] = {
    "Argentina", "Aruba", "Bolivia", "Bonaire, Sint Eustatius and Saba", "Brazil", "Chile", "Colombia", "Curaçao", "Ecuador", "Falkland Islands", "French Guiana", "Guyana", "Paraguay", "Peru",
    "South Georgia and the South Sandwich Islands", "Suriname", "Trinidad and Tobago", "Uruguay", "Venezuela"
  },
  ["Africa"] = {
    "Algeria", "Angola", "Benin", "Botswana", "Burkina Faso", "Burundi", "Cabo Verde", "Cameroon", "Central African Republic", "Chad", "Comoros", "Congo", "Côte d'Ivoire", "Democratic Republic of the Congo",
    "Djibouti", "Egypt", "Equatorial Guinea", "Eritrea", "Eswatini", "Ethiopia", "Gabon", "Gambia", "Ghana", "Guinea", "Guinea-Bissau", "Kenya", "Lesotho", "Liberia", "Libya", "Madagascar", "Malawi", "Mali",
    "Mauritania", "Mauritius", "Mayotte", "Morocco", "Mozambique", "Namibia", "Niger", "Nigeria", "Portugal/Arquipélago da Madeira", "Réunion", "Rwanda", "Saint Helena", "Sao Tome and Principe", "Senegal",
    "Seychelles", "Sierra Leone", "Somalia", "South Africa", "South Sudan", "Spain/Ceuta", "Spain/Islas Canarias", "Spain/Melilla", "Sudan", "Tanzania", "Togo", "Tunisia", "Uganda", "Western Sahara",
    "Yemen/Socotra", "Zambia", "Zimbabwe"
  },
  ["Asia"] = {
    "Afghanistan", "Armenia", "Azerbaijan", "Bahrain", "Bangladesh", "Bhutan", "British Indian Ocean Territory", "Brunei", "Cambodia", "China", "Christmas Island", "Cocos (Keeling) Islands", "Cyprus",
    "Egypt/North Sinai", "Egypt/South Sinai", "Georgia", "Hong Kong", "India", "Indonesia", "Iran", "Iraq", "Israel", "Japan", "Jordan", "Kazakhstan", "Kuwait", "Kyrgyzstan", "Laos", "Lebanon", "Macao",
    "Malaysia", "Maldives", "Mongolia", "Myanmar", "Nepal", "North Korea", "Oman", "Pakistan", "Palestine", "Philippines", "Qatar", "Russia/Siberian Federal District", "Russia/Far Eastern Federal District",
    "Russia/Ural Federal District", "Saudi Arabia", "Singapore", "South Korea", "Sri Lanka", "Syria", "Taiwan", "Tajikistan", "Thailand", "Timor-Leste", "Türkiye", "Turkmenistan", "United Arab Emirates",
    "Uzbekistan", "Vietnam", "Yemen"
  },
  ["Oceania"] = {
    "American Samoa", "Australia", "Cook Islands", "Fiji", "French Polynesia", "Guam", "Indonesia/Papua", "Kiribati", "Marshall Islands", "Micronesia", "Nauru", "New Caledonia", "New Zealand", "Niue",
    "Norfolk Island", "Northern Mariana Islands", "Palau", "Papua New Guinea", "Pitcairn", "Samoa", "Solomon Islands", "Tokelau", "Tonga", "Tuvalu", "US Minor Outlying Islands", "Vanuatu",
    "Wallis and Futuna Islands"
  },
  ["Antarctica"] = {
    "Antarctica", "Bouvet Island", "French Southern and Antarctic Territories", "Heard Island and McDonald Islands", "South Georgia and the South Sandwich Islands/South Sandwich Islands"
  }
}

local continentsLookupTable = {}

-- configs for "allowedCountries" that are predefined, e.g. because they are too big for a checker tag configuration
local aliasConfigs = {
  ['European Union'] = { "Austria", "Belgium", "Bulgaria", "Croatia", "Cyprus", "Czechia", "Denmark", "Estonia", "Finland", "France", "Germany", "Greece", "Hungary", "Ireland", "Italy", "Latvia", "Lithuania", "Luxembourg", "Malta", "Netherlands", "Poland", "Portugal", "Romania", "Slovakia", "Slovenia", "Spain", "Sweden" },
  ['GCB17CT'] = {
    ['United States'] = {
      ['allowedCounties'] = {
        'Clay County (AL)', 'Geneva County (AL)', 'Wilcox County (AL)', 'Cleburne County (AR)', 'Izard County (AR)', 'Perry County (AR)', 'Stone County (AR)', 'Yell County (AR)', 'Alpine County (CA)',
        'Amador County (CA)', 'Butte County (CA)', 'Calaveras County (CA)', 'Lake County (CA)', 'Mariposa County (CA)', 'Plumas County (CA)', 'Santa Cruz County (CA)', 'Sutter County (CA)',
        'Trinity County (CA)', 'Tuolumne County (CA)', 'Yuba County (CA)', 'Crowley County (CO)', 'Custer County (CO)', 'Hinsdale County (CO)', 'Pitkin County (CO)', 'Rio Blanco County (CO)',
        'San Miguel County (CO)', 'Calhoun County (FL)', 'Liberty County (FL)', 'Union County (FL)', 'Baker County (GA)', 'Calhoun County (GA)', 'Elbert County (GA)', 'Fayette County (GA)',
        'Glascock County (GA)', 'Hancock County (GA)', 'Jasper County (GA)', 'Macon County (GA)', 'Marion County (GA)', 'Washington County (GA)', 'Boise County (ID)', 'Gem County (ID)', 'Teton County (ID)',
        'Valley County (ID)', 'Calhoun County (IL)', 'Crawford County (IL)', 'Edwards County (IL)', 'Hamilton County (IL)', 'Hardin County (IL)', 'Jasper County (IL)', 'Menard County (IL)', 'Pope County (IL)',
        'Randolph County (IL)', 'Stark County (IL)', 'Wabash County (IL)', 'Blackford County (IN)', 'Brown County (IN)', 'Fayette County (IN)', 'Ohio County (IN)', 'Adams County (IA)', 'Appanoose County (IA)',
        'Emmet County (IA)', 'Guthrie County (IA)', 'Marion County (IA)', 'Monroe County (IA)', 'Pocahontas County (IA)', 'Taylor County (IA)', 'Van Buren County (IA)', 'Greeley County (KS)', 'Lane County (KS)',
        'Wichita County (KS)', 'Breathitt County (KY)', 'Cumberland County (KY)', 'Elliott County (KY)', 'Estill County (KY)', 'Knott County (KY)', 'Lee County (KY)', 'Lewis County (KY)', 'Monroe County (KY)',
        'Owsley County (KY)', 'Perry County (KY)', 'Wayne County (KY)', 'Cameron Parish (LA)', 'Franklin Parish (LA)', 'Plaquemines Parish (LA)', 'Saint Bernard Parish (LA)', 'Saint Helena Parish (LA)',
        'Washington Parish (LA)', 'West Carroll Parish (LA)', 'Piscataquis County (ME)', 'Caroline County (MD)', 'Dukes County (MA)', 'Nantucket County (MA)', 'Barry County (MI)', 'Gladwin County (MI)',
        'Huron County (MI)', 'Leelanau County (MI)', 'Luce County (MI)', 'Missaukee County (MI)', 'Montmorency County (MI)', 'Oscoda County (MI)', 'Sanilac County (MI)', 'Tuscola County (MI)', 'Cook County (MN)',
        'Isanti County (MN)', 'Kanabec County (MN)', 'Lake County (MN)', 'Lake of the Woods County (MN)', 'Pope County (MN)', 'Roseau County (MN)', 'Attala County (MS)', 'Calhoun County (MS)',
        'Lafayette County (MS)', 'Leake County (MS)', 'Neshoba County (MS)', 'Quitman County (MS)', 'Smith County (MS)', 'Winston County (MS)', 'Bollinger County (MO)', 'Dent County (MO)', 'Douglas County (MO)',
        'Henry County (MO)', 'Iron County (MO)', 'Knox County (MO)', 'Polk County (MO)', 'Ray County (MO)', 'Reynolds County (MO)', 'Sullivan County (MO)', 'Washington County (MO)', 'Daniels County (MT)',
        'Garfield County (MT)', 'McCone County (MT)', 'Richland County (MT)', 'Sanders County (MT)', 'Sheridan County (MT)', 'Arthur County (NE)', 'Banner County (NE)', 'Blaine County (NE)', 'Boone County (NE)',
        'Garfield County (NE)', 'Grant County (NE)', 'Hooker County (NE)', 'Knox County (NE)', 'McPherson County (NE)', 'Nance County (NE)', 'Pawnee County (NE)', 'Perkins County (NE)', 'Sherman County (NE)',
        'Valley County (NE)', 'Wayne County (NE)', 'Los Alamos County (NM)', 'Fulton County (NY)', 'Hamilton County (NY)', 'Lewis County (NY)', 'Orleans County (NY)', 'Schuyler County (NY)',
        'Tompkins County (NY)', 'Wayne County (NY)', 'Yates County (NY)', 'Pamlico County (NC)', 'Cavalier County (ND)', 'Dunn County (ND)', 'Grant County (ND)', 'Griggs County (ND)', 'Hettinger County (ND)',
        'Logan County (ND)', 'McIntosh County (ND)', 'Mercer County (ND)', 'Oliver County (ND)', 'Ransom County (ND)', 'Sargent County (ND)', 'Sioux County (ND)', 'Steele County (ND)', 'Carroll County (OH)',
        'Monroe County (OH)', 'Morgan County (OH)', 'Haskell County (OK)', 'Polk County (OR)', 'Wallowa County (OR)', 'Yamhill County (OR)', 'Cameron County (PA)', 'Bristol County (RI)', 'Bon Homme County (SD)',
        'Buffalo County (SD)', 'Clay County (SD)', 'McPherson County (SD)', 'Marshall County (SD)', 'Sanborn County (SD)', 'Clay County (TN)', 'Hancock County (TN)', 'Houston County (TN)', 'Jackson County (TN)',
        'Lake County (TN)', 'Macon County (TN)', 'Meigs County (TN)', 'Overton County (TN)', 'Union County (TN)', 'Aransas County (TX)', 'Bandera County (TX)', 'Bosque County (TX)', 'Brazoria County (TX)',
        'Briscoe County (TX)', 'Burleson County (TX)', 'Cochran County (TX)', 'Delta County (TX)', 'Grimes County (TX)', 'Hansford County (TX)', 'Hutchinson County (TX)', 'Jim Hogg County (TX)',
        'Llano County (TX)', 'Loving County (TX)', 'Matagorda County (TX)', 'Winkler County (TX)', 'Wayne County (UT)', 'Lamoille County (VT)', 'Charles City County (VA)', 'Craig County (VA)',
        'Dickenson County (VA)', 'Lancaster County (VA)', 'Mathews County (VA)', 'Westmoreland County (VA)', 'Manassas (VA)', 'Manassas Park (VA)', 'Poquoson (VA)', 'Island County (WA)', 'San Juan County (WA)',
        'Skamania County (WA)', 'Wahkiakum County (WA)', 'Pleasants County (WV)', 'Tyler County (WV)', 'Webster County (WV)', 'Wirt County (WV)', 'Adams County (WI)', 'Burnett County (WI)', 'Door County (WI)',
        'Green County (WI)', 'Green Lake County (WI)', 'Kewaunee County (WI)', 'Menominee County (WI)', 'Taylor County (WI)', 'Madera County (CA)', 'Tulare County (CA)', 'Adair County (KY)', 'Powell County (KY)',
        'Wolfe County (KY)', 'Calvert County (MD)', "Saint Mary's County (MD)", 'Watonwan County (MN)', 'Cumberland County (NJ)', 'Tioga County (NY)', 'Newport County (RI)', 'Kitsap County (WA)'
      }
    }
  }
}

local validCountryNames = {}
local invalidCountryNames = {}
local invalidRegionNames = {}
local invalidCountyNames = {}

---------- function definitions ----------

function Dump(t, header)
  header = header or ''
  if type(t) == 'table' then
    for k,v in pairs(t) do
      if type(v) == 'table' then
        PGC.Log(header .. k .. ':\n')
        Dump(v, header .. '  ')
      else
        PGC.Log(header .. tostring(k) .. ':' .. tostring(v) .. '\n')
      end
    end
  else
    PGC.Log(header .. t .. '\n')
  end
end

-- test whether a given string starts with a given prefix
function StartsWith(str, prefix)
  return string.sub(str, 1, #prefix) == prefix
end

-- add PGC.GetContinentDefinitions() to aliasConfigs
function AddPgcContinents()
  local continents = PGC.GetContinentDefinitions()
  for continent, countries in pairs(continents) do
    local countryList = {}
    for _, country in pairs(countries) do -- need to use pair() since this table starts at index 0
      table.insert(countryList, country)
    end
    aliasConfigs['PGC.' .. continent] = countryList
  end
end

-- convert the "continents" definitions into corresponding "aliasConfigs"
function InitContinents()
  local splitCountries = {}
  local continentAliases = {}

  -- phase 1: define allowedCountries with allowedRegions
  for continent, countries in pairs(continents) do
    local allowedCountries = {}
    for _, country in ipairs(countries) do
      local countryName, regionName = string.match(country, "^(.-)/(.*)$")
      if countryName then
        if allowedCountries[countryName] == nil then
          allowedCountries[countryName] = {}
        end
        if allowedCountries[countryName].allowedRegions == nil then
          allowedCountries[countryName].allowedRegions = {}
          splitCountries[countryName] = allowedCountries[countryName]
        end
        table.insert(allowedCountries[countryName].allowedRegions, regionName)
      else
        if allowedCountries[country] == nil then
          allowedCountries[country] = {}
        end
      end
    end

    continentAliases[continent] = allowedCountries
  end

  -- phase 2: for all countries without allowedRegions, check if the country was defined with allowedRegions on a different continent and then exclude those regions on the primary continent
  for continent, countries in pairs(continentAliases) do
    for countryName, definition in pairs(countries) do
      if definition.allowedRegions == nil then
        local splitCountry = splitCountries[countryName]
        if splitCountry ~= nil and splitCountry.allowedRegions ~= nil then
          definition.excludedRegions = splitCountry.allowedRegions
        end
      end
    end
  end

  -- phase 3: set new aliases in global variables
  for continent, countries in pairs(continentAliases) do
    aliasConfigs[continent] = countries
  end

  -- phase 4: prepare lookup table to determine continent name from country/region/county
  for continent, countries in pairs(continents) do
    for _, country in ipairs(countries) do
      continentsLookupTable[country] = continent
    end
  end
end

-- replacement for '?:' operator
function IfElse(condition, value1, value2)
  if condition then
    return value1
  end
  return value2
end

-- return the given value if it is not nil, otherwise return default value
function GetOrDefault(n, default)
  if n ~= nil then
    return n
  end
  return default
end

-- convert single string or indexed table of countries / regions / counties into an associative table
-- this allows easier tag configs when e.g. only a list of countries or a single country shall be specified,
-- but makes processing the config uniform for the rest of the code
function ConvertToAssociativeTable(t)
  if type(t) == 'string' then
    -- convert simple string into associative table
    local newT = {}
    newT[t] = {}
    return newT
  end

  if type(t) == 'table' then
    if t[1] == nil then
      return t -- not indexed, return original table
    end

    -- convert indexed table to associative table
    local newT = {}
    for _, v in ipairs(t) do
      newT[v] = {}
    end
    return newT
  end

  return nil -- if no string and no table was passed in, return nil
end

-- convert the keys of an associative table to an indexed one
function ConvertKeysToIndexedTable(t)
  if type(t) ~= 'table' then
    return nil
  end

  local newT = {}
  for key, value in pairs(t) do
    table.insert(newT, key)
  end
  return newT
end

-- convert the values of an associative table to an indexed one
function ConvertValuesToIndexedTable(t)
  if type(t) ~= 'table' then
    return nil
  end

  local newT = {}
  for key, value in pairs(t) do
    table.insert(newT, value)
  end
  return newT
end

-- append the elements of one indexed table to another one
function AppendIndexedTable(resultTable, tableToAppend)
  for i = 1, #tableToAppend do
    resultTable[#resultTable + 1] = tableToAppend[i]
  end
end

-- count number of entries in associative or indexed table
function Count(t)
  if type(t) ~= 'table' then
    return 0 -- not a table
  end

  if t[1] ~= nil then
    return #t -- indexed table
  end

  -- associative table
  local count = 0
  for _, _ in pairs(t) do
    count = count + 1
  end
  return count
end

-- count elements in tableA that are not in tableB
function Count_A_minus_B(tableA, tableB)
  if type(tableB) ~= 'table' then
    tableB = {}
  end

  local n = 0

  if type(tableA) == 'table' then
    for k, _ in pairs(tableA) do
      if tableB[k] == nil then
        n = n + 1
      end
    end
  end

  return n
end

-- determine the country in which the player has the most finds
function GetMostFoundCountry()
  local finds = PGC.GetFinds(profileId, { fields = {'country'}, excludeDupFinds = true, excludeTravelingGeocaches = true, order = 'OLDESTFIRST'})

  local findsPerCountry = {}
  for _, cache in ipairs(finds) do
    if cache.country ~= nil then
      if findsPerCountry[cache.country] == nil then
        findsPerCountry[cache.country] = 1
      else
        findsPerCountry[cache.country] = findsPerCountry[cache.country] + 1
      end
    end
  end

  local bestCount = 0
  local mostFoundCountry = nil

  for country, count in pairs(findsPerCountry) do
    if count > bestCount then
      bestCount = count
      mostFoundCountry = country
    end
  end

  return mostFoundCountry
end

-- wrapper for PGC.GetNumberOfRegionsInCountry() that returns 1 if a country has no regions (i.e. 'Falkland Islands')
function GetNumberOfRegionsInCountry(countryName)
  if countryName == nil then
    PGC.print('Warning: GetNumberOfRegionsInCountry() called with nil parameter!\n')
    return nil
  end

  local num = PGC.GetNumberOfRegionsInCountry(countryName)
  if type(num) == 'number' then
    return num
  end
  return 1
end

-- wrapper for PGC.GetNumberOfCountiesInRegion() that returns 1 if a country has no counties
function GetNumberOfCountiesInRegion(countryName, regionName)
  if (countryName == nil) or (regionName == nil) then
    PGC.print('Warning: GetNumberOfCountiesInRegion() called with nil parameter!\n')
    return nil
  end

  local num = PGC.GetNumberOfCountiesInRegion(countryName, regionName)
  if type(num) == 'number' then
    return num
  end
  return 1
end

-- wrapper for PGC.GetNumberOfCountiesInCountry() that returns number of regions if a country has no counties
function GetNumberOfCountiesInCountry(countryName)
  if countryName == nil then
    PGC.print('Warning: GetNumberOfCountiesInCountry() called with nil parameter!\n')
    return nil
  end

  local num = PGC.GetNumberOfCountiesInCountry(countryName)
  if type(num) == 'number' then
    return num
  end
  return GetNumberOfRegionsInCountry(countryName)
end

-- check if a country has counties
function CountryHasCounties(countryName)
  if countryName == nil then
    PGC.print('Warning: CountryHasCounties() called with nil parameter!\n')
    return nil
  end

  if conf.CountryHasCounties == nil then
    conf.CountryHasCounties = {}
  end

  if conf.CountryHasCounties[countryName] == nil then
    conf.CountryHasCounties[countryName] = type(PGC.GetNumberOfCountiesInCountry(countryName)) == 'number'
  end

  return conf.CountryHasCounties[countryName]
end

-- check if a country has regions
function CountryHasRegions(countryName)
  if countryName == nil then
    PGC.print('Warning: CountryHasRegions() called with nil parameter!\n')
    return nil
  end

  if conf.CountryHasRegions == nil then
    conf.CountryHasRegions = {}
  end

  if conf.CountryHasRegions[countryName] == nil then
    conf.CountryHasRegions[countryName] = type(PGC.GetNumberOfRegionsInCountry(countryName)) == 'number'
  end

  return conf.CountryHasRegions[countryName]
end

-- get the number of regions in a country in which caches can be counted
-- if a country is allowed without restrictions to its regions, all regions in that country are counted
function GetNumAllowedRegionsInCountry(countryName)
  if countryName == nil then
    PGC.print('Warning: GetNumAllowedRegionsInCountry() called with nil parameter!\n')
    return nil
  end

  -- if conf.allowedCountries is defined, the country must be listed there
  if type(conf.allowedCountries) == 'table' then
    local listedCountry = conf.allowedCountries[countryName]
    if type(listedCountry) ~= 'table' then
      return 0 -- there are countries listed, but not the current one
    end

    local allowedRegions = listedCountry.allowedRegions
    if type(allowedRegions) == 'table' then -- there are regions listed
      return Count(allowedRegions)
    end

    local excludedRegions = listedCountry.excludedRegions
    if type(excludedRegions) == 'table' then -- there are excluded regions listed
      local regionsAndCounties = GetFetchedRegionAndCountyNamesForCountry(countryName)
      return Count_A_minus_B(regionsAndCounties, excludedRegions)
    end

    -- entire country is allowed
    return GetNumberOfRegionsInCountry(countryName)
  end

  -- no conf.allowedCountries defined, check if conf.excludedCountries is defined
  if type(conf.excludedCountries) == 'table' then
    local listedCountry = conf.excludedCountries[countryName]
    if type(listedCountry) ~= 'table' then
      return GetNumberOfRegionsInCountry(countryName) -- current country is not excluded
    end

    local excludedRegions = listedCountry.excludedRegions
    if type(excludedRegions) == 'table' then -- there are regions listed --> only those are excluded
      local regionsAndCounties = GetFetchedRegionAndCountyNamesForCountry(countryName)
      return Count_A_minus_B(regionsAndCounties, excludedRegions)
    end

    return 0 -- the entire country is excluded
  end

  -- no restrictions on country or no restrictions at all
  return GetNumberOfRegionsInCountry(countryName)
end

-- get the number of counties in a region in which caches can be counted
function GetNumAllowedCountiesInRegion(countryName, regionName)
  if (countryName == nil) or (regionName == nil) then
    PGC.print('Warning: GetNumAllowedCountiesInRegion() called with nil parameter!\n')
    return nil
  end

  -- check if we need to consider allowedCountries
  if type(conf.allowedCountries) == 'table' then
    local listedCountry = conf.allowedCountries[countryName]
    if type(listedCountry) ~= 'table' then
      return 0 -- there are countries listed, but not the current one
    end

    local regionsAndCounties = GetFetchedRegionAndCountyNamesForCountry(countryName)
    local countyNamesInRegion = regionsAndCounties[regionName]

    if #countyNamesInRegion == 0 then -- it's a country without counties, so count regions as counties
      if CanCacheBeCounted(countryName, regionName, '') then
        return 1
      end
    end

    local n = 0

    for _, countyName in ipairs(countyNamesInRegion) do
      if CanCacheBeCounted(countryName, regionName, countyName) then
        n = n + 1
      end
    end

    return n
  end

  -- check if we need to consider excludedCountries
  if type(conf.excludedCountries) == 'table' then
    local listedCountry = conf.excludedCountries[countryName]
    if type(listedCountry) ~= 'table' then
      return GetNumberOfCountiesInRegion(countryName, regionName) -- country is not excluded
    end

    local excludedRegions = listedCountry.excludedRegions
    if type(excludedRegions) == 'table' then -- there are excluded regions listed
      if excludedRegions[countryName] ~= nil then
        return 0 -- the region was excluded
      end
    end
  end

  -- neither allowedCountries nor excludedCountries defined or region is not excluded
  return GetNumberOfCountiesInRegion(countryName, regionName)
end

-- get the number of counties in a country in which caches can be counted
function GetNumAllowedCountiesInCountry(countryName)
  if countryName == nil then
    PGC.print('Warning: GetNumAllowedCountiesInCountry() called with nil parameter!\n')
    return nil
  end

  -- if neither allowedCountries nor excludedCountries defined, all counties are allowed
  if (type(conf.allowedCountries) ~= 'table') and (type(conf.excludedCountries) ~= 'table') then
    return GetNumberOfCountiesInCountry(countryName)
  end

  -- if allowedCountries is defined but not the current one --> no counties allowed at all
  if type(conf.allowedCountries) == 'table' then
    local listedCountry = conf.allowedCountries[countryName]
    if type(listedCountry) ~= 'table' then
      return 0 -- there are countries listed, but not the current one
    end
  end

  -- if the entire country is excluded --> no counties allowed at all
  if type(conf.excludedCountries) == 'table' then
    local listedCountry = conf.excludedCountries[countryName]
    if type(listedCountry) == 'table' then -- country is listed
      local excludedRegions = listedCountry.excludedRegions
      if type(excludedRegions) ~= 'table' then
        return 0 -- entire country exluded
      end
    end
  end

  -- go over all regions and count allowed counties there
  local n = 0

  local regionsAndCounties = GetFetchedRegionAndCountyNamesForCountry(countryName)
  for regionName, _ in pairs(regionsAndCounties) do
    n = n + GetNumAllowedCountiesInRegion(countryName, regionName)
  end

  return n
end

-- get the number of countries that are allowed in the tag
function GetNumAllowedCountries()
  return Count(conf.allowedCountries)
end

-- get the number of regions that are allowed in the tag
function GetNumAllowedRegions()
  local n = 0

  if type(conf.allowedCountries) == 'table' then
    for countryName, _ in pairs(conf.allowedCountries) do
      n = n + GetNumAllowedRegionsInCountry(countryName)
    end
  end

  return n
end

-- get the number of counties that are allowed in the tag
function GetNumAllowedCounties()
  local n = 0

  if type(conf.allowedCountries) == 'table' then
    for countryName, _ in pairs(conf.allowedCountries) do
      n = n + GetNumAllowedCountiesInCountry(countryName)
    end
  end

  return n
end

-- replace cache type macros with list of concrete types
function ResolveTypeMacros(types)
  if types['Events'] then
    types['Events'] = nil
    -- cache types that are regarded to be an event by geocaching.com
    types['Event Cache'] = true
    types['Cache In Trash Out Event'] = true
    types['Mega-Event Cache'] = true
    types['Giga-Event Cache'] = true
    types['Community Celebration Event'] = true
    types['Geocaching HQ Block Party'] = true
    types['Geocaching HQ Celebration'] = true
  end

  if types['Physical'] then
    types['Physical'] = nil
    -- cache types that have a container with a logbook
    types['Traditional Cache'] = true
    types['Mystery Cache'] = true
    types['Multi-Cache'] = true
    types['Letterbox Hybrid'] = true
    types['Wherigo Cache'] = true
    types['Project A.P.E. Cache'] = true
    types['Geocaching HQ Cache'] = true
  end
end

-- adapt config and add default values
function PrepareConfig()
  -- types can be a string with a single type or an array of types
  conf.types = ConvertToAssociativeTable(conf.types)
  if conf.types ~= nil then
    ResolveTypeMacros(conf.types)
    conf.filter = conf.filter or {}
    conf.filter.types = ConvertKeysToIndexedTable(conf.types)
  end

  -- excludedTypes can be a string with a single type or an array of types
  conf.excludedTypes = ConvertToAssociativeTable(conf.excludedTypes)
  if conf.excludedTypes ~= nil then
    ResolveTypeMacros(conf.excludedTypes)
  else
    conf.excludedTypes = {}
  end

  -- sizes/excludedSizes can be a string with a single size or an array of sizes
  local sizes = ConvertToAssociativeTable(conf.sizes or {"Micro", "Small", "Regular", "Large", "Other", "Virtual", "Not chosen"})
  local excludedSizes = ConvertToAssociativeTable(conf.excludedSizes)
  if excludedSizes ~= nil then
    for k, _ in pairs(excludedSizes) do
      sizes[k] = nil
    end
  end

  if (conf.sizes ~= nil) or (conf.excludedSizes ~= nil) then
    conf.filter = conf.filter or {}
    conf.filter.sizes = ConvertKeysToIndexedTable(sizes)
  end

  -- difficulties/excludedDifficulties can be an array with valid values (1.0-5.0)
  local difficulties = ConvertToAssociativeTable(conf.difficulties or {1.0, 1.5, 2.0, 2.5, 3.0, 3.5, 4.0, 4.5, 5.0})
  local excludedDifficulties = ConvertToAssociativeTable(conf.excludedDifficulties)
  if excludedDifficulties ~= nil then
    for k, _ in pairs(excludedDifficulties) do
      difficulties[k] = nil
    end
  end

  if (conf.difficulties ~= nil) or (conf.excludedDifficulties ~= nil) then
    conf.filter = conf.filter or {}
    conf.filter.difficulties = ConvertKeysToIndexedTable(difficulties)
  end

  -- terrains/excludedTerrains can be an array with valid values (1.0-5.0)
  local terrains = ConvertToAssociativeTable(conf.terrains or {1.0, 1.5, 2.0, 2.5, 3.0, 3.5, 4.0, 4.5, 5.0})
  local excludedTerrains = ConvertToAssociativeTable(conf.excludedTerrains)
  if excludedTerrains ~= nil then
    for k, _ in pairs(excludedTerrains) do
      terrains[k] = nil
    end
  end

  if (conf.terrains ~= nil) or (conf.excludedTerrains ~= nil) then
    conf.filter = conf.filter or {}
    conf.filter.terrains = ConvertKeysToIndexedTable(terrains)
  end

  -- excludedCaches can be an array with GC codes
  conf.excludedCaches = ConvertToAssociativeTable(conf.excludedCaches)
  if conf.excludedCaches == nil then
    conf.excludedCaches = {}
  end

  -- replace allowedCountries from tag config with hard-coded config when it is one
  if type(conf.allowedCountries) == 'string' then
    -- if allowedCountries starts with 'PGC.', use the country list from PGC.GetContinentDefinitions()
    if StartsWith(conf.allowedCountries, 'PGC.') then
      AddPgcContinents()
    end

    if aliasConfigs[conf.allowedCountries] ~= nil then
      conf.allowedCountries = aliasConfigs[conf.allowedCountries]
    end
  end

  -- make sure all countries / regions / counties are converted from string or indexed table to associative table
  conf.allowedCountries = ConvertToAssociativeTable(conf.allowedCountries)
  if type(conf.allowedCountries) == 'table' then
    for _, country in pairs(conf.allowedCountries) do
      country.allowedRegions = ConvertToAssociativeTable(country.allowedRegions)
      country.excludedRegions = ConvertToAssociativeTable(country.excludedRegions)
      country.allowedCounties = ConvertToAssociativeTable(country.allowedCounties)
    end
  end
  --[[
  conf.allowedCountries restrictions are optional. All restrictions are now in the associative form:
    conf.allowedCountries = {
      "Germany" = {
        "allowedRegions" = {
          "Bayern" = {}
        },
        "excludedRegions" = {
          "Berlin" = {}
        },
        "allowedCounties" = {
          "Bayreuth" = {}
        }
      }
    }
  When countries are listed, only caches are counted that are within one of the listed countries.
  When allowedRegions or allowedCounties are given for a country, only caches are counted in this country that
  are within one of the listed regions or counties.
  --]]

  -- check if the country with most finds shall be excluded
  if conf.excludedCountries == 'MostFoundCountry' then
    conf.excludedCountries = GetMostFoundCountry()
    PGC.print('Excluded ' .. conf.excludedCountries .. ' as the country with most finds\n')
  end

  -- convert excluded countries/regions to associative table
  conf.excludedCountries = ConvertToAssociativeTable(conf.excludedCountries)
  if type(conf.excludedCountries) == 'table' then
    for _, country in pairs(conf.excludedCountries) do
      country.excludedRegions = ConvertToAssociativeTable(country.excludedRegions)
    end
  end

  CheckIfAreaNamesAreValid()
  -- in case some invalid name was found, disable drawing polygons to prevent checker crash
  if (#invalidCountryNames > 0) or (#invalidRegionNames > 0) or (#invalidCountyNames > 0) then
    conf.showCountriesOnMap = false
    conf.showRegionsOnMap = false
    conf.showCountiesOnMap = false
  end

  -- attributes can be a single number or an array of number
  if type(conf.attributes) == 'number' then
    conf.attributes = { conf.attributes }
  end
  conf.attributesPerCache = tonumber(GetOrDefault(conf.attributesPerCache, 1))

  conf.findsTotal = tonumber(GetOrDefault(conf.findsTotal, 0))

  conf.continents = tonumber(GetOrDefault(conf.continents, 0))
  conf.findsPerContinent = tonumber(GetOrDefault(conf.findsPerContinent, 0))
  conf.typesPerContinent = tonumber(GetOrDefault(conf.typesPerContinent, 0))
  conf.sizesPerContinent = tonumber(GetOrDefault(conf.sizesPerContinent, 0))
  conf.countriesPerContinent = tonumber(GetOrDefault(conf.countriesPerContinent, 0))
  conf.regionsPerContinent = tonumber(GetOrDefault(conf.regionsPerContinent, 0))
  conf.countiesPerContinent = tonumber(GetOrDefault(conf.countiesPerContinent, 0))
  conf.showContinentsInList = GetOrDefault(conf.showContinentsInList, false)

  if conf.countries == 'all' then
    if #invalidCountryNames == 0 then
      conf.countries = GetNumAllowedCountries()
      PGC.print('ALL required countries resolved to ' .. conf.countries .. '\n')
    else
      conf.countries = 1000000
    end
  else
    conf.countries = tonumber(GetOrDefault(conf.countries, 0))
  end
  conf.findsPerCountry = tonumber(GetOrDefault(conf.findsPerCountry, 0))
  conf.typesPerCountry = tonumber(GetOrDefault(conf.typesPerCountry, 0))
  conf.sizesPerCountry = tonumber(GetOrDefault(conf.sizesPerCountry, 0))
  conf.regionsPerCountry = tonumber(GetOrDefault(conf.regionsPerCountry, 0))
  conf.regionsPerCountryPercent = tonumber(GetOrDefault(conf.regionsPerCountryPercent, 0))
  conf.countiesPerCountry = tonumber(GetOrDefault(conf.countiesPerCountry, 0))
  conf.countiesPerCountryPercent = tonumber(GetOrDefault(conf.countiesPerCountryPercent, 0))
  conf.showCountriesInList = GetOrDefault(conf.showCountriesInList, false)
  conf.showCountriesOnMap = GetOrDefault(conf.showCountriesOnMap, false)

  if conf.regions == 'all' then
    if (#invalidCountryNames == 0) and (#invalidRegionNames == 0) then
      conf.regions = GetNumAllowedRegions()
      PGC.print('ALL required regions resolved to ' .. conf.regions .. '\n')
    else
      conf.regions = 1000000
    end
  else
    conf.regions = tonumber(GetOrDefault(conf.regions, 0))
  end
  conf.findsPerRegion = tonumber(GetOrDefault(conf.findsPerRegion, 0))
  conf.typesPerRegion = tonumber(GetOrDefault(conf.typesPerRegion, 0))
  conf.sizesPerRegion = tonumber(GetOrDefault(conf.sizesPerRegion, 0))
  conf.countiesPerRegion = tonumber(GetOrDefault(conf.countiesPerRegion, 0))
  conf.countiesPerRegionPercent = tonumber(GetOrDefault(conf.countiesPerRegionPercent, 0))
  conf.showRegionsInList = GetOrDefault(conf.showRegionsInList, false)
  conf.showRegionsOnMap = GetOrDefault(conf.showRegionsOnMap, false)

  if conf.counties == 'all' then
    if (#invalidCountryNames == 0) and (#invalidRegionNames == 0) and (#invalidCountyNames == 0) then
      conf.counties = GetNumAllowedCounties()
      PGC.print('ALL required counties resolved to ' .. conf.counties .. '\n')
    else
      conf.counties = 1000000
    end
  else
    conf.counties = tonumber(GetOrDefault(conf.counties, 0))
  end
  conf.findsPerCounty = tonumber(GetOrDefault(conf.findsPerCounty, 0))
  conf.typesPerCounty = tonumber(GetOrDefault(conf.typesPerCounty, 0))
  conf.sizesPerCounty = tonumber(GetOrDefault(conf.sizesPerCounty, 0))
  conf.showCountiesInList = GetOrDefault(conf.showCountiesInList, false)
  conf.showCountiesOnMap = GetOrDefault(conf.showCountiesOnMap, false)

  conf.findsPerType = tonumber(GetOrDefault(conf.findsPerType, 1))
  conf.findsPerTypeCountdown = tonumber(GetOrDefault(conf.findsPerTypeCountdown, 0))
  conf.findsPerSize = tonumber(GetOrDefault(conf.findsPerSize, 1))
  conf.showTypesAsSummary = GetOrDefault(conf.showTypesAsSummary, false)
  conf.showSizesAsSummary = GetOrDefault(conf.showSizesAsSummary, false)

  conf.showCachesInList = GetOrDefault(conf.showCachesInList, false)
  conf.showCachesOnMap = GetOrDefault(conf.showCachesOnMap, false)

  conf.showProgressWhenQualified = GetOrDefault(conf.showProgressWhenQualified, false)

  -- add default colors and opacity
  conf.colorCountyPassed = GetOrDefault(conf.colorCountyPassed, '#00C000')
  conf.colorCountyMissing = GetOrDefault(conf.colorCountyMissing, '#C00000')
  conf.colorRegionPassed = GetOrDefault(conf.colorRegionPassed, '#008040')
  conf.colorRegionMissing = GetOrDefault(conf.colorRegionMissing, '#800040')
  conf.colorCountryPassed = GetOrDefault(conf.colorCountryPassed, '#006030')
  conf.colorCountryMissing = GetOrDefault(conf.colorCountryMissing, '#600030')
  conf.opacityCounty = GetOrDefault(conf.opacityCounty, 0.15)
  conf.opacityRegion = GetOrDefault(conf.opacityRegion, 0.1)
  conf.opacityCountry = GetOrDefault(conf.opacityCountry, 0.1)

  conf.excludeLocationless = GetOrDefault(conf.excludeLocationless, true)

  conf.ignoreBookmark = GetOrDefault(conf.ignoreBookmark, true) -- default to true

  conf.ignoreList = {}
  if conf.ignoreBookmark then
    PGC.print('Ignoring caches on bookmark list https://www.geocaching.com/plan/lists/BMAFMJR\n')

    local bookmarkList = PGC.GetBookmarklist('BMAFMJR')
    if type(bookmarkList) == 'table' then
      for _, gccode in ipairs(bookmarkList) do
        conf.ignoreList[gccode] = true
      end
    end
  end

  conf.minElevation = tonumber(conf.minElevation)
  conf.maxElevation = tonumber(conf.maxElevation)

  conf.fetchedCountryPolygons = {}
  conf.fetchedRegionPolygons = {}
  conf.fetchedCountyPolygons = {}
  conf.drawnCountries = 0
  conf.drawnRegions = 0
  conf.drawnCounties = 0
end

-- check if country names are valid
function CheckIfCountryNamesAreValid(countryNames)
  if type(countryNames) == 'table' then
    for countryName, countryObj in pairs(countryNames) do
      if validCountryNames[countryName] then
        CheckIfRegionNamesAreValid(countryName, countryObj.allowedRegions)
        CheckIfRegionNamesAreValid(countryName, countryObj.excludedRegions)
        CheckIfCountyNamesAreValid(countryName, countryObj.allowedCounties)
        CheckIfCountyNamesAreValid(countryName, countryObj.excludedCounties)
      else -- countryName is invalid
        table.insert(invalidCountryNames, countryName)
        PGC.print('Warning: Country ', countryName, ' does not exist!\n')
      end
    end
  end
end

-- check if region names in a country are valid
function CheckIfRegionNamesAreValid(countryName, regionNames)
  if type(regionNames) == 'table' then
    local storage = GetFetchedRegionAndCountyNamesForCountry(countryName)

    for regionName, _ in pairs(regionNames) do
      if storage[regionName] == nil then
        table.insert(invalidRegionNames, countryName .. ': '.. regionName)
        PGC.print('Warning: Region ', countryName .. ': '.. regionName .. ' does not exist!\n')
      end
    end
  end
end

-- check if county names in a country are valid
function CheckIfCountyNamesAreValid(countryName, countyNames)
  if type(countyNames) == 'table' then
    -- step 1: build associative table with county names
    local storage = GetFetchedRegionAndCountyNamesForCountry(countryName)
    local counties = {}

    for regionName, countyNames in pairs(storage) do
      if #countyNames > 0 then -- country has counties
        for _, countyName in ipairs(countyNames) do
          counties[countyName] = true
        end
      end
    end

    -- step 2: check if county names are valid
    for countyName, _ in pairs(countyNames) do
      if counties[countyName] == nil then
        table.insert(invalidCountyNames, countryName .. ': '.. countyName)
        PGC.print('Warning: County ', countryName .. ': '.. countyName .. ' does not exist!\n')
      end
    end
  end
end

-- check if country/region/county names in conf.allowedCountries and conf.excludedCountries are valid
function CheckIfAreaNamesAreValid()
  validCountryNames = PGC.GetIso3166_1alpha2Table(true)
  CheckIfCountryNamesAreValid(conf.allowedCountries)
  CheckIfCountryNamesAreValid(conf.excludedCountries)
end

-- get the name of the continent on which a cache is located
-- first try to find the continent based on country and region, then only based on country
-- maybe later we want to move some counties to a different continent (i.e. in Türkiye), therefore we already have countyName as parameter
function GetContinentName(countryName, regionName, countyName)
  local lookupName = countryName .. '/' .. regionName
  local continentName = continentsLookupTable[lookupName]
  if continentName ~= nil then
    return continentName
  end

  return continentsLookupTable[countryName]
end

-- get or create a counter for a continent
function GetContinentCounter(counters, continentName)
  if (counters == nil) or (counters.continents == nil) or (continentName == nil) then
    PGC.print('Warning: GetContinentCounter() called with nil parameter!\n')
    return nil
  end

  local continentCounter = counters.continents[continentName]
  if continentCounter == nil then
    continentCounter = {
      continentName = continentName,
      caches = {},
      types = {},
      sizes = {},
      countries = {},
      passedCountries = {},
      partialCountries = {},
      passedRegions = {},
      partialRegions = {},
      passedCounties = {},
      partialCounties = {}
    }
    counters.continents[continentName] = continentCounter
  end
  return continentCounter
end

-- get or create a counter for a country
function GetCountryCounter(parentCounters, countryName)
  if (parentCounters == nil) or (parentCounters.countries == nil) or (countryName == nil) then
    PGC.print('Warning: GetCountryCounter() called with nil parameter!\n')
    return nil
  end

  local countryCounter = parentCounters.countries[countryName]
  if countryCounter == nil then
    countryCounter = {
      countryName = countryName,
      caches = {},
      types = {},
      sizes = {},
      regions = {},
      counties = {},
      passedRegions = {},
      partialRegions = {},
      passedCounties = {},
      partialCounties = {}
    }
    parentCounters.countries[countryName] = countryCounter
  end
  return countryCounter
end

-- get or create a counter for a region in a country
function GetRegionCounter(countryCounter, regionName)
  if (countryCounter == nil) or (regionName == nil) then
    PGC.print('Warning: GetRegionCounter() called with nil parameter!\n')
    return nil
  end

  local countryName = countryCounter.countryName
  local regionCounter = countryCounter.regions[regionName]
  if regionCounter == nil then
    regionCounter = {
      countryName = countryName,
      regionName = regionName,
      caches = {},
      types = {},
      sizes = {},
      counties = {},
      passedCounties = {},
      partialCounties = {}
    }
    countryCounter.regions[regionName] = regionCounter
  end
  return regionCounter
end

-- get or create a counter for a county in a region in a country
function GetCountyCounter(countryCounter, regionName, countyName)
  if (countryCounter == nil) or (regionName == nil) or (countyName == nil) then
    PGC.print('Warning: GetCountyCounter() called with nil parameter!\n')
    return nil
  end

  local countryName = countryCounter.countryName
  local regionCounter = GetRegionCounter(countryCounter, regionName)
  local countyCounter = regionCounter.counties[countyName]
  if countyCounter == nil then
    countyCounter = {
      countryName = countryName,
      regionName = regionName,
      countyName = countyName,
      caches = {},
      types = {},
      sizes = {}
    }
    regionCounter.counties[countyName] = countyCounter
    -- store counter also under countryCounter
    countryCounter.counties[regionName .. '#' .. countyName] = countyCounter -- keep regionName in key for countries without counties
  end
  return countyCounter
end

-- sort function for counties: sort alphabetically by country name, then region name, then county name
function SortCountiesFct(a, b)
  return (a.countryName < b.countryName)
    or ((a.countryName == b.countryName) and (a.regionName < b.regionName))
    or ((a.countryName == b.countryName) and (a.regionName == b.regionName) and (a.countyName < b.countyName))
end

-- sort function for regions: sort alphabetically by country name, then by region name
function SortRegionsFct(a, b)
  return (a.countryName < b.countryName) or ((a.countryName == b.countryName) and ((a.regionName < b.regionName)))
end

-- sort function for countries: sort alphabetically by country name
function SortCountriesFct(a, b)
  return a.countryName < b.countryName
end

-- sort function for continents: sort alphabetically by continent name
function SortContinentsFct(a, b)
  return a.continentName < b.continentName
end

-- sort function for caches: oldest found first
function SortCachesFct(a, b)
  return a.foundNumber < b.foundNumber
end

-- check if a cache can be counted based on its country/region/county
function CanCacheBeCounted(countryName, regionName, countyName)
  if (countryName == nil) or (regionName == nil) or (countyName == nil) then
    PGC.print('Warning: CanCacheBeCounted() called with nil parameter!\n')
    return false
  end

  -- check if allowedCountries were defined
  local allowedCountries = conf.allowedCountries
  if type(allowedCountries) == 'table' then
    local listedCountry = allowedCountries[countryName]
    if listedCountry == nil then
      return false -- there are countries listed, but not the current one
    end

    local allowedRegions = listedCountry.allowedRegions
    if allowedRegions ~= nil then -- there are regions listed
      local listedRegion = allowedRegions[regionName]
      if listedRegion ~= nil then
        return true -- current region is listed
      end
    end

    local excludedRegions = listedCountry.excludedRegions
    if excludedRegions ~= nil then -- there are excluded regions listed
      if excludedRegions[regionName] ~= nil then
        return false -- current region is excluded
      end
    end

    local allowedCounties = listedCountry.allowedCounties
    if allowedCounties ~= nil then -- there are counties listed
      local listedCounty = allowedCounties[countyName]
      if listedCounty ~= nil then
        return true -- current county is listed
      end
    end

    -- neither current region nor current county are listed
    -- still OK, if neither regions nor countries were listed
    return (allowedRegions == nil) and (allowedCounties == nil)
  end

  -- check if excludedCountries were defined
  local excludedCountries = conf.excludedCountries
  if type(excludedCountries) == 'table' then
    local listedCountry = excludedCountries[countryName]
    if type(listedCountry) ~= 'table' then
      return true -- there are countries listed, but not the current one
    end

    local excludedRegions = listedCountry.excludedRegions
    if type(excludedRegions) ~= 'table' then -- no regions listed --> entire country is excluded
      return false
    end

    if excludedRegions[regionName] ~= nil then
      return false -- the region was excluded
    end
  end

  -- neither allowedCountries nor excludedCountries defined
  return true -- everything is allowed
end

-- bit operator (needed for attribute processing)
function Bit(p)
  return 2 ^ (p - 1) -- 1-based indexing
end

-- Typical call: if hasbit(x, bit(3)) then ...
function HasBit(x, p)
  return x % (p + p) >= p
end

-- check if an attribute is set on a cache; use negative number for negative attributes
function HasAttribute(attributeNumber, cache)
  local set1 = cache.attributes_set_1
  local set2 = cache.attributes_set_2
  local set3 = cache.attributes_set_3

  if attributeNumber < 0 then
    attributeNumber = -attributeNumber
    set1 = cache.attributes_unset_1
    set2 = cache.attributes_unset_2
    set3 = cache.attributes_unset_3
  end

  if attributeNumber <= 32 then
    if HasBit(set1, Bit(attributeNumber)) then
      return true
    else
      return false
    end
  end

  attributeNumber = attributeNumber - 32
  if attributeNumber <= 32 then
    if HasBit(set2, Bit(attributeNumber)) then
      return true
    else
      return false
    end
  end

  attributeNumber = attributeNumber - 32
  if attributeNumber <= 32 then
    if HasBit(set3, Bit(attributeNumber)) then
      return true
    else
      return false
    end
  end

  return false
end

-- remember caches sorted by their type
function RememberCachesByType(counter, cache)
  if (counter ~= nil) and (counter.types ~= nil) and (cache ~= nil) and (cache.type ~= nil) then
    if counter.types[cache.type] == nil then
      counter.types[cache.type] = {}
    end
    table.insert(counter.types[cache.type], cache)
  end
end

-- get number of cache types with enough caches per type
function GetNumQualifyingTypes(types, requiredFindsPerType)
  if (types == nil) or (requiredFindsPerType == nil) then
    PGC.print('Warning: GetNumQualifyingTypes() called with nil parameter!\n')
    return false
  end

  local numTypesfound = 0

  for type, caches in pairs(types) do
    if Count(caches) >= requiredFindsPerType then
      numTypesfound = numTypesfound + 1
    end
  end

  return numTypesfound
end

-- get caches per type, where types are sorted most finds first
function SortTypesByFindCount(types)
  local sorted = {}
  for type, caches in pairs(types) do
    table.insert(sorted, {type = type, caches = caches, count = Count(caches)})
  end

  table.sort(sorted, function(a, b) return a.count > b.count end)

  return sorted
end

-- remember caches sorted by their size
function RememberCachesBySize(counter, cache)
  if (counter ~= nil) and (counter.sizes ~= nil) and (cache ~= nil) and (cache.size ~= nil) then
    if counter.sizes[cache.size] == nil then
      counter.sizes[cache.size] = {}
    end
    table.insert(counter.sizes[cache.size], cache)
  end
end

-- get number of cache sizes with enough caches per size
function GetNumQualifyingSizes(sizes, requiredFindsPerSize)
  if (sizes == nil) or (requiredFindsPerSize == nil) then
    PGC.print('Warning: GetNumQualifyingSizes() called with nil parameter!\n')
    return false
  end

  local numSizesfound = 0

  for size, caches in pairs(sizes) do
    if Count(caches) >= requiredFindsPerSize then
      numSizesfound = numSizesfound + 1
    end
  end

  return numSizesfound
end

-- get caches per size, where sizes are sorted most finds first
function SortSizesByFindCount(sizes)
  local sorted = {}
  for size, caches in pairs(sizes) do
    table.insert(sorted, {size = size, caches = caches, count = Count(caches)})
  end

  table.sort(sorted, function(a, b) return a.count > b.count end)

  return sorted
end

-- process a found cache and add it to its country / region / county counters
-- if there are restrictions that the cache does not fulfill, it does not get added to the counters
function AddCacheToCounters(counters, cache)
  if (counters == nil) or (cache == nil) then
    PGC.print('Warning: AddCacheToCounters() called with nil parameter!\n')
    return
  end

  if (cache.country == nil) or (cache.country == '') then
    return -- can't count anything for a cache without country
  end

  if (cache.gccode ~= nil) then
    if conf.ignoreList[cache.gccode] then
      PGC.print('Not counting ' .. cache.gccode .. ', because it is on the ignore list\n')
      return
    end

    if conf.excludedCaches[cache.gccode] then
      PGC.print('Not counting ' .. cache.gccode .. ', because it is in the excludedCaches configuration\n')
      return
    end
  end

  if conf.excludeLocationless and (cache.type == 'Locationless Cache') then
    PGC.print('Not counting ' .. cache.gccode .. ', because Locationless Caches are excluded\n')
    return
  end

  if conf.excludedTypes[cache.type] ~= nil then
    return
  end

  cache.elevation = tonumber(cache.elevation)
  if (conf.minElevation ~= nil) and ((cache.elevation == nil) or (cache.elevation < conf.minElevation)) then
    return
  end

  if (conf.maxElevation ~= nil) and ((cache.elevation == nil) or (cache.elevation > conf.maxElevation)) then
    return
  end

  -- if region is undefined, use empty string as region
  if cache.region == nil then
    cache.region = ''
  end

  -- special exception: use country name as region name for the few countries that don't have regions defined yet
  if (cache.region == '') and (not CountryHasRegions(cache.country)) then
    cache.region = cache.country
  end

  -- if county is undefined, use empty string as county
  if cache.county == nil then
    cache.county = ''
  end

  local countryName = cache.country
  local regionName = cache.region
  local countyName = cache.county

  if not CanCacheBeCounted(countryName, regionName, countyName) then
    return
  end

  -- if attributes are required, check if has has those
  if (type(conf.attributes) == 'table') and (conf.attributesPerCache > 0) then
    local nAttributesOnCache = 0
    for _, attributeNumber in ipairs(conf.attributes) do
      if HasAttribute(attributeNumber, cache) then
        nAttributesOnCache = nAttributesOnCache + 1
      end
    end

    if nAttributesOnCache < conf.attributesPerCache then
      return -- cache does not have the required attributes
    end
  end

  -- count cache in its continent
  local continentCounter = GetContinentCounter(counters, GetContinentName(countryName, regionName, countyName))
  table.insert(continentCounter.caches, cache)
  RememberCachesByType(continentCounter, cache)
  RememberCachesBySize(continentCounter, cache)

  -- count cache in its country
  local countryCounterWorldwide = GetCountryCounter(counters, countryName)
  table.insert(countryCounterWorldwide.caches, cache)
  RememberCachesByType(countryCounterWorldwide, cache)
  RememberCachesBySize(countryCounterWorldwide, cache)

  local countryCounterPerContinent = GetCountryCounter(continentCounter, countryName)
  table.insert(countryCounterPerContinent.caches, cache)
  RememberCachesByType(countryCounterPerContinent, cache)
  RememberCachesBySize(countryCounterPerContinent, cache)

  if regionName == '' then
    return -- don't count regions with empty names
  end

  -- count cache in its region
  local regionCounterWorldwide = GetRegionCounter(countryCounterWorldwide, regionName)
  table.insert(regionCounterWorldwide.caches, cache)
  RememberCachesByType(regionCounterWorldwide, cache)
  RememberCachesBySize(regionCounterWorldwide, cache)

  local regionCounterPerContinent = GetRegionCounter(countryCounterPerContinent, regionName)
  table.insert(regionCounterPerContinent.caches, cache)
  RememberCachesByType(regionCounterPerContinent, cache)
  RememberCachesBySize(regionCounterPerContinent, cache)

  if (countyName == '') and CountryHasCounties(countryName) then
    return -- don't count caches without a county in countries that have counties
  end

  -- count cache in its county
  local countyCounterWorldwide = GetCountyCounter(countryCounterWorldwide, regionName, countyName)
  table.insert(countyCounterWorldwide.caches, cache)
  RememberCachesByType(countyCounterWorldwide, cache)
  RememberCachesBySize(countyCounterWorldwide, cache)

  local countyCounterPerContinent = GetCountyCounter(countryCounterPerContinent, regionName, countyName)
  table.insert(countyCounterPerContinent.caches, cache)
  RememberCachesByType(countyCounterPerContinent, cache)
  RememberCachesBySize(countyCounterPerContinent, cache)
end

-- check whether a county has fulfilled all requirements
function IsCountyPassed(countyCounter)
  return (countyCounter ~= nil) and countyCounter.HasEnoughFinds and countyCounter.HasEnoughTypes and countyCounter.HasEnoughSizes
end

-- check whether a region has fulfilled all requirements
function IsRegionPassed(regionCounter)
  return (regionCounter ~= nil) and regionCounter.HasEnoughCounties and regionCounter.HasEnoughFinds and regionCounter.HasEnoughTypes and regionCounter.HasEnoughSizes
end

-- check whether a country has fulfilled all requirements
function IsCountryPassed(countryCounter)
  return (countryCounter ~= nil) and countryCounter.HasEnoughRegions and countryCounter.HasEnoughCounties and countryCounter.HasEnoughFinds and countryCounter.HasEnoughTypes and countryCounter.HasEnoughSizes
end

-- check whether a continent has fulfilled all requirements
function IsContinentPassed(continentCounter)
  return (continentCounter ~= nil) and continentCounter.HasEnoughCountries and continentCounter.HasEnoughRegions and continentCounter.HasEnoughCounties and continentCounter.HasEnoughFinds and continentCounter.HasEnoughTypes and continentCounter.HasEnoughSizes
end

-- clear all qualification flags in the county counter for the next countdown
function ClearFlagsForCounty(countyCounter)
  if (countyCounter == nil) then
    PGC.print('Warning: ClearFlagsForCounty() called with nil parameter!\n')
    return
  end

  if countyCounter.AlreadyFound then
    return
  end

  countyCounter.PartiallyQualified = false
  countyCounter.HasEnoughFinds = false
  countyCounter.HasEnoughTypes = false
  countyCounter.HasEnoughSizes = false
end

-- clear all qualification flags in the region counter for the next countdown
function ClearFlagsForRegion(regionCounter)
  if (regionCounter == nil) then
    PGC.print('Warning: ClearFlagsForRegion() called with nil parameter!\n')
    return
  end

  if regionCounter.AlreadyFound then
    return
  end

  regionCounter.PartiallyQualified = false
  regionCounter.HasEnoughFinds = false
  regionCounter.HasEnoughTypes = false
  regionCounter.HasEnoughSizes = false
  regionCounter.HasEnoughCounties = false
end

-- clear all qualification flags in the country counter and its region/county counters for the next countdown
function ClearFlagsForCountry(countryCounter)
  if (countryCounter == nil) or (countryCounter.regions == nil) or (countryCounter.counties == nil) then
    PGC.print('Warning: ClearFlagsForCountry() called with nil parameter!\n')
    return
  end

  if countryCounter.AlreadyFound then
    return
  end

  countryCounter.PartiallyQualified = false
  countryCounter.HasEnoughFinds = false
  countryCounter.HasEnoughTypes = false
  countryCounter.HasEnoughSizes = false
  countryCounter.HasEnoughRegions = false
  countryCounter.HasEnoughCounties = false

  for _, regionCounter in pairs(countryCounter.regions) do
    ClearFlagsForRegion(regionCounter)
  end

  for _, countyCounter in pairs(countryCounter.counties) do
    ClearFlagsForCounty(countyCounter)
  end
end

-- clear all qualification flags in the continent counter and its country/region/county counters for the next countdown
function ClearFlagsForContinent(continentCounter)
  if (continentCounter == nil) or (continentCounter.countries == nil) then
    PGC.print('Warning: ClearFlagsForContinent() called with nil parameter!\n')
    return
  end

  if continentCounter.AlreadyFound then
    return
  end

  continentCounter.PartiallyQualified = false
  continentCounter.HasEnoughFinds = false
  continentCounter.HasEnoughTypes = false
  continentCounter.HasEnoughCountries = false
  continentCounter.HasEnoughRegions = false
  continentCounter.HasEnoughCounties = false

  for _, countryCounter in pairs(continentCounter.countries) do
    ClearFlagsForCountry(countryCounter)
  end
end

-- clear all qualification flags in the counters for the next countdown
function ClearFlags(counters)
  if (counters == nil) or (counters.countries == nil) or (counters.continents == nil) then
    PGC.print('Warning: ClearFlags() called with nil parameter!\n')
    return
  end

  for _, countryCounter in pairs(counters.countries) do
    ClearFlagsForCountry(countryCounter)
  end

  for _, continentCounter in pairs(counters.continents) do
    ClearFlagsForContinent(continentCounter)
  end
end

-- flag county whether it has enough found caches and enough found cache types and enough found cache sizes
function FlagEnoughFindsAndTypesAndSizesForCounty(countyCounter)
  if (countyCounter == nil) or (countyCounter.caches == nil) or (countyCounter.types == nil) or (countyCounter.sizes == nil) then
    PGC.print('Warning: FlagEnoughFindsAndTypesForCounty() called with nil parameter!\n')
    return
  end

  if countyCounter.AlreadyFound then
    return
  end

  countyCounter.findsPerCounty = conf.findsPerCounty
  countyCounter.typesPerCounty = conf.typesPerCounty
  countyCounter.sizesPerCounty = conf.sizesPerCounty
  countyCounter.findsPerType = conf.findsPerType
  countyCounter.findsPerSize = conf.findsPerSize

  local numCachesFound = Count(countyCounter.caches)
  if numCachesFound >= countyCounter.findsPerCounty then
    countyCounter.HasEnoughFinds = true
  elseif countyCounter.findsPerCounty > 0 then
    countyCounter.PartiallyQualified = true
  end

  local numTypesFound = GetNumQualifyingTypes(countyCounter.types, countyCounter.findsPerType)
  if numTypesFound >= countyCounter.typesPerCounty then
    countyCounter.HasEnoughTypes = true
  elseif countyCounter.typesPerCounty > 0 then
    countyCounter.PartiallyQualified = true
  end

  local numSizesFound = GetNumQualifyingSizes(countyCounter.sizes, countyCounter.findsPerSize)
  if numSizesFound >= countyCounter.sizesPerCounty then
    countyCounter.HasEnoughSizes = true
  elseif countyCounter.sizesPerCounty > 0 then
    countyCounter.PartiallyQualified = true
  end
end

-- flag region whether it has enough found caches and enough found cache types and enough found cache sizes
function FlagEnoughFindsAndTypesAndSizesForRegion(regionCounter)
  if (regionCounter == nil) or (regionCounter.caches == nil) or (regionCounter.types == nil) or (regionCounter.sizes == nil) then
    PGC.print('Warning: FlagEnoughFindsAndTypesForRegion() called with nil parameter!\n')
    return
  end

  if regionCounter.AlreadyFound then
    return
  end

  regionCounter.findsPerRegion = conf.findsPerRegion
  regionCounter.typesPerRegion = conf.typesPerRegion
  regionCounter.sizesPerRegion = conf.sizesPerRegion
  regionCounter.findsPerType = conf.findsPerType
  regionCounter.findsPerSize = conf.findsPerSize

  local numCachesFound = Count(regionCounter.caches)
  if numCachesFound >= regionCounter.findsPerRegion then
    regionCounter.HasEnoughFinds = true
  elseif regionCounter.findsPerRegion > 0 then
    regionCounter.PartiallyQualified = true
  end

  local numTypesFound = GetNumQualifyingTypes(regionCounter.types, regionCounter.findsPerType)
  if numTypesFound >= regionCounter.typesPerRegion then
    regionCounter.HasEnoughTypes = true
  elseif regionCounter.typesPerRegion > 0 then
    regionCounter.PartiallyQualified = true
  end

  local numSizesFound = GetNumQualifyingSizes(regionCounter.sizes, regionCounter.findsPerSize)
  if numSizesFound >= regionCounter.sizesPerRegion then
    regionCounter.HasEnoughSizes = true
  elseif regionCounter.sizesPerRegion > 0 then
    regionCounter.PartiallyQualified = true
  end
end

-- flag country whether it has enough found caches and enough found cache types and enough found cache sizes, do the same for its regions and counties
function FlagEnoughFindsAndTypesAndSizesForCountry(countryCounter)
  if (countryCounter == nil) or (countryCounter.caches == nil) or (countryCounter.types == nil) or (countryCounter.sizes == nil) or (countryCounter.regions == nil) or (countryCounter.counties == nil) then
    PGC.print('Warning: FlagEnoughFindsAndTypesForCountry() called with nil parameter!\n')
    return
  end

  if countryCounter.AlreadyFound then
    return
  end

  countryCounter.findsPerCountry = conf.findsPerCountry
  countryCounter.typesPerCountry = conf.typesPerCountry
  countryCounter.sizesPerCountry = conf.sizesPerCountry
  countryCounter.findsPerType = conf.findsPerType
  countryCounter.findsPerSize = conf.findsPerSize

  local numCachesFound = Count(countryCounter.caches)
  if numCachesFound >= countryCounter.findsPerCountry then
    countryCounter.HasEnoughFinds = true
  elseif countryCounter.findsPerCountry > 0 then
    countryCounter.PartiallyQualified = true
  end

  local numTypesFound = GetNumQualifyingTypes(countryCounter.types, countryCounter.findsPerType)
  if numTypesFound >= countryCounter.typesPerCountry then
    countryCounter.HasEnoughTypes = true
  elseif countryCounter.typesPerCountry > 0 then
    countryCounter.PartiallyQualified = true
  end

  local numSizesFound = GetNumQualifyingSizes(countryCounter.sizes, countryCounter.findsPerSize)
  if numSizesFound >= countryCounter.sizesPerCountry then
    countryCounter.HasEnoughSizes = true
  elseif countryCounter.sizesPerCountry > 0 then
    countryCounter.PartiallyQualified = true
  end

  for _, regionCounter in pairs(countryCounter.regions) do
    FlagEnoughFindsAndTypesAndSizesForRegion(regionCounter)
  end

  for _, countyCounter in pairs(countryCounter.counties) do
    FlagEnoughFindsAndTypesAndSizesForCounty(countyCounter)
  end
end

-- flag continent whether it has enough found caches and enough found cache types and enough found cache sizes, do the same for its countries
function FlagEnoughFindsAndTypesAndSizesForContinent(continentCounter)
  if (continentCounter == nil) or (continentCounter.caches == nil) or (continentCounter.types == nil) or (continentCounter.sizes == nil) or (continentCounter.countries == nil) then
    PGC.print('Warning: FlagEnoughFindsAndTypesForContinent() called with nil parameter!\n')
    return
  end

  if continentCounter.AlreadyFound then
    return
  end

  continentCounter.findsPerContinent = conf.findsPerContinent
  continentCounter.typesPerContinent = conf.typesPerContinent
  continentCounter.sizesPerContinent = conf.sizesPerContinent
  continentCounter.findsPerType = conf.findsPerType
  continentCounter.findsPerSize = conf.findsPerSize

  local numCachesFound = Count(continentCounter.caches)
  if numCachesFound >= continentCounter.findsPerContinent then
    continentCounter.HasEnoughFinds = true
  elseif continentCounter.findsPerContinent > 0 then
    continentCounter.PartiallyQualified = true
  end

  local numTypesFound = GetNumQualifyingTypes(continentCounter.types, continentCounter.findsPerType)
  if numTypesFound >= continentCounter.typesPerContinent then
    continentCounter.HasEnoughTypes = true
  elseif continentCounter.typesPerContinent > 0 then
    continentCounter.PartiallyQualified = true
  end

  local numSizesFound = GetNumQualifyingSizes(continentCounter.sizes, continentCounter.findsPerSize)
  if numSizesFound >= continentCounter.sizesPerContinent then
    continentCounter.HasEnoughSizes = true
  elseif continentCounter.sizesPerContinent > 0 then
    continentCounter.PartiallyQualified = true
  end

  for _, countryCounter in pairs(continentCounter.countries) do
    FlagEnoughFindsAndTypesAndSizesForCountry(countryCounter)
  end
end

-- flag all countries / regions / counties that have enough found caches and enough found cache types and enough found cache sizes
function FlagEnoughFindsAndTypesAndSizes(counters)
  if (counters == nil) or (counters.countries == nil) or (counters.continents == nil) then
    PGC.print('Warning: FlagEnoughFindsAndTypes() called with nil parameter!\n')
    return
  end

  for _, countryCounter in pairs(counters.countries) do
    FlagEnoughFindsAndTypesAndSizesForCountry(countryCounter)
  end

  for _, continentCounter in pairs(counters.continents) do
    FlagEnoughFindsAndTypesAndSizesForContinent(continentCounter)
  end
end

-- get number of counties that need to be found in a country
function GetNumCountiesRequiredInCountry(countryName)
  local numByRatio = 0
  if conf.countiesPerCountryPercent > 0 then
    numByRatio = GetNumAllowedCountiesInCountry(countryName) * (conf.countiesPerCountryPercent / 100.0)
  end

  return math.max(conf.countiesPerCountry, numByRatio)
end

-- get number of counties that need to be found in a country
function GetNumCountiesRequiredInRegion(countryName, regionName)
  local numByRatio = 0
  if conf.countiesPerRegionPercent > 0 then
    numByRatio = GetNumAllowedCountiesInRegion(countryName, regionName) * (conf.countiesPerRegionPercent / 100.0)
  end

  return math.max(conf.countiesPerRegion, numByRatio)
end

-- flag region whether it has enough found counties (which have enough caches/types in them)
function FlagEnoughCountiesForRegion(regionCounter)
  if (regionCounter == nil) or (regionCounter.counties == nil) then
    PGC.print('Warning: FlagEnoughCountiesForRegion() called with nil parameter!\n')
    return
  end

  if regionCounter.AlreadyFound then
    return
  end

  regionCounter.countiesPerRegion = GetNumCountiesRequiredInRegion(regionCounter.countryName, regionCounter.regionName)
  regionCounter.passedCounties = {}
  regionCounter.partialCounties = {}

  for _, countyCounter in pairs(regionCounter.counties) do
    if IsCountyPassed(countyCounter) then
      table.insert(regionCounter.passedCounties, countyCounter)
    elseif countyCounter.PartiallyQualified then
      table.insert(regionCounter.partialCounties, countyCounter)
    end
  end

  -- check if the region has enough counties
  local numCountiesFound = Count(regionCounter.passedCounties)
  if numCountiesFound >= regionCounter.countiesPerRegion then
    regionCounter.HasEnoughCounties = true
  elseif regionCounter.countiesPerRegion > 0 then
    regionCounter.PartiallyQualified = true
  end
end

-- flag country whether it has enough found counties (which have enough caches/types in them), do the same for its regions
function FlagEnoughCountiesForCountry(countryCounter)
  if (countryCounter == nil) or (countryCounter.regions == nil) or (countryCounter.counties == nil) then
    PGC.print('Warning: FlagEnoughCountiesForCountry() called with nil parameter!\n')
    return
  end

  if countryCounter.AlreadyFound then
    return
  end

  countryCounter.countiesPerCountry = GetNumCountiesRequiredInCountry(countryCounter.countryName)
  countryCounter.passedCounties = {}
  countryCounter.partialCounties = {}

  for _, countyCounter in pairs(countryCounter.counties) do
    if IsCountyPassed(countyCounter) then
      table.insert(countryCounter.passedCounties, countyCounter)
    elseif countyCounter.PartiallyQualified then
      table.insert(countryCounter.partialCounties, countyCounter)
    end
  end

  -- check if the country has enough counties
  local numCountiesFound = Count(countryCounter.passedCounties)
  if numCountiesFound >= countryCounter.countiesPerCountry then
    countryCounter.HasEnoughCounties = true
  elseif countryCounter.countiesPerCountry > 0 then
    countryCounter.PartiallyQualified = true
  end

  -- for every region in the country check if it has enough counties
  for _, regionCounter in pairs(countryCounter.regions) do
    FlagEnoughCountiesForRegion(regionCounter)
  end
end

-- flag continent whether it has enough found counties (which have enough caches/types in them), do the same for its countries
function FlagEnoughCountiesForContinent(continentCounter)
  if (continentCounter == nil) or (continentCounter.countries == nil) then
    PGC.print('Warning: FlagEnoughCountiesForContinent() called with nil parameter!\n')
    return
  end

  if continentCounter.AlreadyFound then
    return
  end

  continentCounter.countiesPerContinent = conf.countiesPerContinent
  continentCounter.passedCounties = {}
  continentCounter.partialCounties = {}

  for _, countryCounter in pairs(continentCounter.countries) do
    FlagEnoughCountiesForCountry(countryCounter)
    AppendIndexedTable(continentCounter.passedCounties, countryCounter.passedCounties)
    AppendIndexedTable(continentCounter.partialCounties, countryCounter.partialCounties)
  end

  -- check if the continent has enough counties
  local numCountiesFound = Count(continentCounter.passedCounties)
  if numCountiesFound >= continentCounter.countiesPerContinent then
    continentCounter.HasEnoughCounties = true
  elseif continentCounter.countiesPerContinent > 0 then
    continentCounter.PartiallyQualified = true
  end
end

-- flag all continents / countries / regions that have enough found counties (which have enough caches/types in them)
function FlagEnoughCounties(counters)
  if (counters == nil) or (counters.countries == nil) or (counters.continents == nil) then
    PGC.print('Warning: FlagEnoughCounties() called with nil parameter!\n')
    return
  end

  for _, countryCounter in pairs(counters.countries) do
    FlagEnoughCountiesForCountry(countryCounter)
  end

  for _, continentCounter in pairs(counters.continents) do
    FlagEnoughCountiesForContinent(continentCounter)
  end
end

-- get number of regions that need to be found in a country
function GetNumRegionsRequiredInCountry(countryName)
  local numByRatio = 0
  if conf.regionsPerCountryPercent > 0 then
    numByRatio = GetNumAllowedRegionsInCountry(countryName) * (conf.regionsPerCountryPercent / 100.0)
  end

  return math.max(conf.regionsPerCountry, numByRatio)
end

-- flag country whether it has enough found regions (which have enough caches/types and counties in them)
function FlagEnoughRegionsForCountry(countryCounter)
  if (countryCounter == nil) or (countryCounter.regions == nil) then
    PGC.print('Warning: FlagEnoughRegionsForCountry() called with nil parameter!\n')
    return
  end

  if countryCounter.AlreadyFound then
    return
  end

  countryCounter.regionsPerCountry = GetNumRegionsRequiredInCountry(countryCounter.countryName)
  countryCounter.passedRegions = {}
  countryCounter.partialRegions = {}

  for _, regionCounter in pairs(countryCounter.regions) do
    if IsRegionPassed(regionCounter) then
      table.insert(countryCounter.passedRegions, regionCounter)
    elseif regionCounter.PartiallyQualified then
      table.insert(countryCounter.partialRegions, regionCounter)
    end
  end

  -- check if the country has enough regions
  local numRegionsFound = Count(countryCounter.passedRegions)
  if numRegionsFound >= countryCounter.regionsPerCountry then
    countryCounter.HasEnoughRegions = true
  elseif countryCounter.regionsPerCountry > 0 then
    countryCounter.PartiallyQualified = true
  end
end

-- flag continent whether it has enough found regions (which have enough caches/types and counties in them)
function FlagEnoughRegionsForContinent(continentCounter)
  if (continentCounter == nil) or (continentCounter.countries == nil) then
    PGC.print('Warning: FlagEnoughRegionsForContinent() called with nil parameter!\n')
    return
  end

  if continentCounter.AlreadyFound then
    return
  end

  continentCounter.regionsPerContinent = conf.regionsPerContinent
  continentCounter.passedRegions = {}
  continentCounter.partialRegions = {}

  for _, countryCounter in pairs(continentCounter.countries) do
    FlagEnoughRegionsForCountry(countryCounter)
    AppendIndexedTable(continentCounter.passedRegions, countryCounter.passedRegions)
    AppendIndexedTable(continentCounter.partialRegions, countryCounter.partialRegions)
  end

  -- check if the continent has enough regions
  local numRegionsFound = Count(continentCounter.passedRegions)
  if numRegionsFound >= continentCounter.regionsPerContinent then
    continentCounter.HasEnoughRegions = true
  elseif continentCounter.regionsPerContinent > 0 then
    continentCounter.PartiallyQualified = true
  end
end

-- flag all countries that have enough found regions (which have enough caches/types and counties in them)
function FlagEnoughRegions(counters)
  if (counters == nil) or (counters.countries == nil) or (counters.continents == nil) then
    PGC.print('Warning: FlagEnoughRegions() called with nil parameter!\n')
    return
  end

  for _, countryCounter in pairs(counters.countries) do
    FlagEnoughRegionsForCountry(countryCounter)
  end

  for _, continentCounter in pairs(counters.continents) do
    FlagEnoughRegionsForContinent(continentCounter)
  end
end

-- flag continent whether it has enough countries (which have enough caches/types and regions/counties in them)
function FlagEnoughCountriesForContinent(continentCounter)
  if (continentCounter == nil) then
    PGC.print('Warning: FlagEnoughCountriesForContinent() called with nil parameter!\n')
    return
  end

  if continentCounter.AlreadyFound then
    return
  end

  continentCounter.countriesPerContinent = conf.countriesPerContinent
  continentCounter.passedCountries = {}
  continentCounter.partialCountries = {}

  for _, countryCounter in pairs(continentCounter.countries) do
    if IsCountryPassed(countryCounter) then
      table.insert(continentCounter.passedCountries, countryCounter)
    elseif countryCounter.PartiallyQualified then
      table.insert(continentCounter.partialCountries, countryCounter)
    end
  end

  -- check if the continent has enough countries
  local numCountriesFound = Count(continentCounter.passedCountries)
  if numCountriesFound >= continentCounter.countriesPerContinent then
    continentCounter.HasEnoughCountries = true
  elseif continentCounter.countriesPerContinent > 0 then
    continentCounter.PartiallyQualified = true
  end
end

-- flag all continents that have enough found countries (which have enough caches/types and regions/counties in them)
function FlagEnoughCountries(counters)
  if (counters == nil) or (counters.continents == nil) then
    PGC.print('Warning: FlagEnoughCountries() called with nil parameter!\n')
    return
  end

  for _, continentCounter in pairs(counters.continents) do
    FlagEnoughCountriesForContinent(continentCounter)
  end
end

-- print all caches in the list to the HTML output
function PrintCacheList(result, logList, title, showList, skipColumns)
  if (result == nil) or (result.html == nil) or (logList == nil) or (showList == nil) or (skipColumns == nil) then
    PGC.print('Warning: PrintCacheList() called with invalid parameter!\n')
    return
  end

  if (not showList) or (#logList == 0) or (#logList[1] == 0) then
    return
  end

  if title ~= nil then
    table.insert(result.html, title .. '<br>')
  end

  table.insert(result.html, '<table class="table-condensed" style="width:100%">')

  table.insert(result.html, '<tr>')
  table.insert(result.html, '<th style="width:5%">#</th>')

  if skipColumns < SKIP_COUNTRY then
    table.insert(result.html, '<th style="width:10%">Country</th>')
  end
  if skipColumns < SKIP_COUNTRY_REGION then
    table.insert(result.html, '<th style="width:15%">Region</th>')
  end
  if skipColumns < SKIP_COUNTRY_REGION_COUNTY then
    table.insert(result.html, '<th style="width:15%">County</th>')
  end

  table.insert(result.html, '<th>Cache</th>')
  table.insert(result.html, '<th style="width:10%">Found date</th>')
  table.insert(result.html, '</tr>')

  for _, logs in ipairs(logList) do
    for _, logTxt in ipairs(logs) do
      table.insert(result.html, logTxt)
    end
  end

  table.insert(result.html, '</table>')
end

-- print a summary how many caches were found for each type
function PrintTypeSummary(result, typesCollection, findsPerType, title, showList)
  -- typesCollection contains {type = type, caches = caches, count = Count(caches)}
  if (result == nil) or (result.html == nil) or (typesCollection == nil) or (findsPerType == nil) or (showList == nil) then
    PGC.print('Warning: PrintTypeSummary() called with invalid parameter!\n')
    return
  end

  if (not showList) then
    return
  end

  if title ~= nil then
    table.insert(result.html, title .. '<br>')
  end

  table.insert(result.html, '<table class="table-condensed">')
  table.insert(result.html, '<tr>')
  table.insert(result.html, '<th># finds</th>')
  table.insert(result.html, '<th>Type</th>')
  table.insert(result.html, '</tr>')

  for _, t in ipairs(typesCollection) do
    table.insert(result.html, '<tr>')
    table.insert(result.html, '<td align="right">' .. t.count .. '</td>')
    table.insert(result.html, '<td>' .. PGC.Icon.GeocacheType(t.type) .. '&nbsp;' .. t.type .. '</td>')
    table.insert(result.html, '</tr>')
  end

  table.insert(result.html, '</table>')
end

-- print a summary how many caches were found for each size
function PrintSizeSummary(result, sizesCollection, findsPerSize, title, showList)
  -- sizesCollection contains {size = size, caches = caches, count = Count(caches)}
  if (result == nil) or (result.html == nil) or (sizesCollection == nil) or (findsPerSize == nil) or (showList == nil) then
    PGC.print('Warning: PrintSizeSummary() called with invalid parameter!\n')
    return
  end

  if (not showList) then
    return
  end

  if title ~= nil then
    table.insert(result.html, title .. '<br>')
  end

  table.insert(result.html, '<table class="table-condensed">')
  table.insert(result.html, '<tr>')
  table.insert(result.html, '<th># finds</th>')
  table.insert(result.html, '<th>Size</th>')
  table.insert(result.html, '</tr>')

  for _, t in ipairs(sizesCollection) do
    table.insert(result.html, '<tr>')
    table.insert(result.html, '<td align="right">' .. t.count .. '</td>')
    table.insert(result.html, '<td>' .. PGC.Icon.GeocacheSize(t.size) .. '&nbsp;' .. t.size .. '</td>')
    table.insert(result.html, '</tr>')
  end

  table.insert(result.html, '</table>')
end

-- output the table headers for continents, when they shall be listed
function BeginTableForContinents(result, showInList, header)
  if showInList then
    table.insert(result.html, header)
    table.insert(result.html, '<br>')
    table.insert(result.html, '<table class="table-condensed" style="width:100%">')
    table.insert(result.html, '<tr>')
    table.insert(result.html, '<th>#</th>')
    table.insert(result.html, '<th>Continent</th>')
    table.insert(result.html, '<th>Caches</th>')
    table.insert(result.html, '<th>Types</th>')
    table.insert(result.html, '<th>Sizes</th>')
    table.insert(result.html, '<th>Countries</th>')
    table.insert(result.html, '<th>Regions</th>')
    table.insert(result.html, '<th>Counties</th>')
    table.insert(result.html, '</tr>')
  end
end

-- output the table headers for countries, when they shall be listed
function BeginTableForCountries(result, showInList, header)
  if showInList then
    table.insert(result.html, header)
    table.insert(result.html, '<br>')
    table.insert(result.html, '<table class="table-condensed" style="width:100%">')
    table.insert(result.html, '<tr>')
    table.insert(result.html, '<th>#</th>')
    table.insert(result.html, '<th>Country</th>')
    table.insert(result.html, '<th>Caches</th>')
    table.insert(result.html, '<th>Types</th>')
    table.insert(result.html, '<th>Sizes</th>')

    local txt = ''
    if conf.regionsPerCountryPercent > 0 then
      txt = ' (' .. conf.regionsPerCountryPercent .. '% required)'
    end
    table.insert(result.html, '<th>Regions' .. txt .. '</th>')

    txt = ''
    if conf.countiesPerCountryPercent > 0 then
      txt = ' (' .. conf.countiesPerCountryPercent .. '% required)'
    end
    table.insert(result.html, '<th>Counties' .. txt .. '</th>')

    table.insert(result.html, '</tr>')
  end
end

-- output the table headers for regions, when they shall be listed
function BeginTableForRegions(result, showInList, header)
  if showInList then
    table.insert(result.html, header)
    table.insert(result.html, '<br>')
    table.insert(result.html, '<table class="table-condensed" style="width:100%">')
    table.insert(result.html, '<tr>')
    table.insert(result.html, '<th>#</th>')
    table.insert(result.html, '<th>Country</th>')
    table.insert(result.html, '<th>Region</th>')
    table.insert(result.html, '<th>Caches</th>')
    table.insert(result.html, '<th>Types</th>')
    table.insert(result.html, '<th>Sizes</th>')

    local txt = ''
    if conf.countiesPerRegionPercent > 0 then
      txt = ' (' .. conf.countiesPerRegionPercent .. '% required)'
    end
    table.insert(result.html, '<th>Counties' .. txt .. '</th>')

    table.insert(result.html, '</tr>')
  end
end

-- output the table headers for counties, when they shall be listed
function BeginTableForCounties(result, showInList, header)
  if showInList then
    table.insert(result.html, header)
    table.insert(result.html, '<br>')
    table.insert(result.html, '<table class="table-condensed" style="width:100%">')
    table.insert(result.html, '<tr>')
    table.insert(result.html, '<th>#</th>')
    table.insert(result.html, '<th>Country</th>')
    table.insert(result.html, '<th>Region</th>')
    table.insert(result.html, '<th>County</th>')
    table.insert(result.html, '<th>Caches</th>')
    table.insert(result.html, '<th>Types</th>')
    table.insert(result.html, '<th>Sizes</th>')
    table.insert(result.html, '</tr>')
  end
end

-- end a table, if there was a table started
function EndTable(result, showInList)
  if showInList then
    table.insert(result.html, '</table>')
  end
end

-- return a text with the required number if it is >0
function GetRequiredText(required)
  if (required == nil) then
    PGC.print('Warning: GetRequiredText() called with invalid parameter!\n')
    return ""
  end

  if required > 0 then
    return ' (' .. required .. ' required)'
  end

  return ""
end

-- add a single cache to the list of passed caches
-- returns log text that can be added to the table of found caches
function AddPassedCache(result, cache, numFound, skipColumns, iconOrder)
  if (result == nil) or (cache == nil) or (numFound == nil) or (skipColumns == nil) or (iconOrder == nil) then
    PGC.print('Warning: AddPassedCache() called with invalid parameter!\n')
    return nil
  end

  if (cache.gccode == nil) or (cache.type == nil) or (cache.log_id == nil) then
    PGC.print('Warning: AddPassedCache() called with cache that is missing required properties!\n')
    return nil
  end

  -- store cache
  if type(result.passedCaches) == 'table' then
    result.passedCaches[cache.gccode] = cache
  end

  -- create log text for stored cache
  local typeTxt = PGC.Icon.GeocacheType(cache.type) .. '&nbsp;'
  local sizeTxt = PGC.Icon.GeocacheSize(cache.size) .. '&nbsp;'
  local cacheTxt = IfElse(iconOrder == SHOW_TYPE_FIRST, typeTxt .. sizeTxt, sizeTxt .. typeTxt)
  cacheTxt = cacheTxt .. '<a href="http://www.geocaching.com/seek/log.aspx?lid=' .. cache.log_id .. '" target="_blank">'
  cacheTxt = cacheTxt .. (cache.cache_name or '') .. ' (' .. cache.gccode .. ')</a>'

  local txt = '<tr>'
  txt = txt .. '<td>' .. numFound .. '</td>'

  if skipColumns < SKIP_COUNTRY then
    txt = txt .. '<td>' .. PGC.Icon.CountryFlag(cache.country) .. '&nbsp;' .. (cache.country or '') .. '</td>'
  end
  if skipColumns < SKIP_COUNTRY_REGION then
    txt = txt .. '<td>' .. (cache.region or '') .. '</td>'
  end
  if skipColumns < SKIP_COUNTRY_REGION_COUNTY then
    txt = txt .. '<td>' .. (cache.county or '') .. '</td>'
  end

  txt = txt .. '<td>' .. cacheTxt .. '</td>'
  txt = txt .. '<td>' .. PGC.Icon.GeocacheFound() .. '&nbsp;' .. (cache.visitdate or '') .. '</td>'
  txt = txt .. '</tr>'
  return txt
end

-- remember gccode of caches so that we can show them on the map
function AddPassedCaches(result, cachesToAdd, numCachesToAdd, skipColumns, iconOrder, prefix)
  if (result == nil) or (cachesToAdd == nil) or (numCachesToAdd == nil) or (skipColumns == nil) or (iconOrder == nil) then
    PGC.print('Warning: AddPassedCaches() called with nil parameter!\n')
    return nil
  end

  local numCachesAvailable = #cachesToAdd
  if numCachesToAdd > numCachesAvailable then
    numCachesToAdd = numCachesAvailable
  end

  table.sort(cachesToAdd, SortCachesFct)

  local cacheLogList = {}

  for i = 1, numCachesToAdd do
    table.insert(cacheLogList, AddPassedCache(result, cachesToAdd[i], (prefix or '' ) .. i, skipColumns, iconOrder))
  end

  return cacheLogList
end

-- remember county with its caches so that we can show it on the map
function AddPassedOrPartialCounty(result, countyCounter, numFound, showCountyInList, passed)
  if (result == nil) or (countyCounter == nil) or (numFound == nil) or (showCountyInList == nil) or (passed == nil) then
    PGC.print('Warning: AddPassedOrPartialCounty() called with nil parameter!\n')
    return
  end

  local countryName = countyCounter.countryName
  local regionName = countyCounter.regionName
  local countyName = countyCounter.countyName
  local findsPerCounty = countyCounter.findsPerCounty
  local typesPerCounty = countyCounter.typesPerCounty
  local sizesPerCounty = countyCounter.sizesPerCounty
  local findsPerType = countyCounter.findsPerType
  local findsPerSize = countyCounter.findsPerSize
  local caches = countyCounter.caches
  local types = countyCounter.types
  local sizes = countyCounter.sizes

  local key = countryName .. ' / ' .. regionName .. ' / ' .. countyName
  if passed then
    result.passedCounties[key] = countyCounter
  end

  -- create log text for a passed county
  local countTxt = numFound

  local numCaches = Count(caches)
  local cachesTxt = numCaches .. IfElse(numCaches == 1, ' cache', ' caches') .. GetRequiredText(findsPerCounty)

  local numQualifyingTypes = GetNumQualifyingTypes(types, findsPerType)
  local typesTxt = numQualifyingTypes .. IfElse(numQualifyingTypes == 1, ' type', ' types')
  if findsPerType > 1 then
    typesTxt = typesTxt .. ' with at least ' .. findsPerType .. ' finds'
  end
  typesTxt = typesTxt .. GetRequiredText(typesPerCounty)

  local numQualifyingSizes = GetNumQualifyingSizes(sizes, findsPerSize)
  local sizesTxt = numQualifyingSizes .. IfElse(numQualifyingSizes == 1, ' size', ' sizes')
  if findsPerSize > 1 then
    sizesTxt = sizesTxt .. ' with at least ' .. findsPerSize .. ' finds'
  end
  sizesTxt = sizesTxt .. GetRequiredText(sizesPerCounty)

  local txt = countTxt .. ' Found county ' .. key .. ' with ' .. cachesTxt .. ' and ' .. typesTxt .. ' and ' .. sizesTxt
  PGC.print(txt, '.\n')

  if showCountyInList then
    table.insert(result.html, '<tr>')
    table.insert(result.html, '<td>' .. countTxt .. '</td>')
    table.insert(result.html, '<td>' .. PGC.Icon.CountryFlag(countryName) .. '&nbsp;' .. countryName .. '</td>')
    table.insert(result.html, '<td>' .. regionName.. '</td>')
    table.insert(result.html, '<td>' .. countyName .. '</td>')
    table.insert(result.html, '<td>' .. cachesTxt .. '</td>')
    table.insert(result.html, '<td>' .. typesTxt .. '</td>')
    table.insert(result.html, '<td>' .. sizesTxt .. '</td>')
    table.insert(result.html, '</tr>')
    -- begin output of additional requirements
    table.insert(result.html, '<tr>')
    table.insert(result.html, '<td></td><td colspan="6">')
  end

  -- show county's caches on map
  local showCachesInList = showCountyInList and conf.showCachesInList
  local result2 = IfElse(passed, result, {}) -- show caches on map only when passed
  local showTitle = (findsPerCounty > 0) and (typesPerCounty > 0)

  local logList = {}
  table.insert(logList, AddPassedCaches(result2, caches, findsPerCounty, SKIP_COUNTRY_REGION_COUNTY, SHOW_TYPE_FIRST))
  PrintCacheList(result, logList, IfElse(showTitle, 'Found Caches', nil), showCachesInList, SKIP_COUNTRY_REGION_COUNTY)

  if typesPerCounty > 0 then
    local sortedTypes = SortTypesByFindCount(types)
    local title = IfElse(showTitle, 'Found Types', nil)
    logList = {}

    for idx, typeCollection in ipairs(sortedTypes) do
      if passed and (typeCollection.count < findsPerType) then
        break
      end

      table.insert(logList, AddPassedCaches(result2, typeCollection.caches, findsPerType, SKIP_COUNTRY_REGION_COUNTY, SHOW_TYPE_FIRST, idx .. ' / '))
    end

    if conf.showTypesAsSummary then
      PrintTypeSummary(result, sortedTypes, IfElse(passed, findsPerType, 1), title, showCachesInList)
    else
      PrintCacheList(result, logList, title, showCachesInList, SKIP_COUNTRY_REGION_COUNTY)
    end
  end

  if sizesPerCounty > 0 then
    local sortedSizes = SortSizesByFindCount(sizes)
    local title = IfElse(showTitle, 'Found Sizes', nil)
    logList = {}

    for idx, sizeCollection in ipairs(sortedSizes) do
      if passed and (sizeCollection.count < findsPerSize) then
        break
      end

      table.insert(logList, AddPassedCaches(result2, sizeCollection.caches, findsPerSize, SKIP_COUNTRY_REGION_COUNTY, SHOW_SIZE_FIRST, idx .. ' / '))
    end

    if conf.showSizesAsSummary then
      PrintSizeSummary(result, sortedSizes, IfElse(passed, findsPerSize, 1), title, showCachesInList)
    else
      PrintCacheList(result, logList, title, showCachesInList, SKIP_COUNTRY_REGION_COUNTY)
    end
  end

  if showCountyInList then
    -- end output of additional requirements
    table.insert(result.html, '</td></tr>')
  end
end

-- remember region with its countries and caches so that we can show it on the map
function AddPassedOrPartialRegion(result, regionCounter, numFound, showRegionInList, passed)
  if (result == nil) or (regionCounter == nil) or (numFound == nil) or (showRegionInList == nil) or (passed == nil) then
    PGC.print('Warning: AddPassedOrPartialRegion() called with nil parameter!\n')
    return
  end

  local countryName = regionCounter.countryName
  local regionName = regionCounter.regionName
  local findsPerRegion = regionCounter.findsPerRegion
  local typesPerRegion = regionCounter.typesPerRegion
  local sizesPerRegion = regionCounter.sizesPerRegion
  local findsPerType = regionCounter.findsPerType
  local findsPerSize = regionCounter.findsPerSize
  local countiesPerRegion = regionCounter.countiesPerRegion
  local caches = regionCounter.caches
  local types = regionCounter.types
  local sizes = regionCounter.sizes
  local passedCounties = regionCounter.passedCounties

  local key = countryName .. ' / ' .. regionName
  if passed then
    result.passedRegions[key] = regionCounter
  end

  -- create log text for a passed region
  local countTxt = numFound

  local numCaches = Count(caches)
  local cachesTxt = numCaches .. IfElse(numCaches == 1, ' cache', ' caches') .. GetRequiredText(findsPerRegion)

  local numQualifyingTypes = GetNumQualifyingTypes(types, findsPerType)
  local typesTxt = numQualifyingTypes .. IfElse(numQualifyingTypes == 1, ' type', ' types')
  if findsPerType > 1 then
    typesTxt = typesTxt .. ' with at least ' .. findsPerType .. ' finds'
  end
  typesTxt = typesTxt .. GetRequiredText(typesPerRegion)

  local numQualifyingSizes = GetNumQualifyingSizes(sizes, findsPerSize)
  local sizesTxt = numQualifyingSizes .. IfElse(numQualifyingSizes == 1, ' size', ' sizes')
  if findsPerSize > 1 then
    sizesTxt = sizesTxt .. ' with at least ' .. findsPerSize .. ' finds'
  end
  sizesTxt = sizesTxt .. GetRequiredText(sizesPerRegion)

  local numCounties = Count(passedCounties)
  local countiesTxt = numCounties .. IfElse(numCounties == 1, ' county', ' counties') .. GetRequiredText(countiesPerRegion)

  local txt = countTxt .. ' Found region ' .. key .. ' with ' .. cachesTxt .. ' and ' .. typesTxt .. ' and ' .. sizesTxt .. ' and ' .. countiesTxt
  PGC.print(txt, '.\n')

  if showRegionInList then
    table.insert(result.html, '<tr>')
    table.insert(result.html, '<td>' .. countTxt .. '</td>')
    table.insert(result.html, '<td>' .. PGC.Icon.CountryFlag(countryName) .. '&nbsp;' .. countryName .. '</td>')
    table.insert(result.html, '<td>' .. regionName .. '</td>')
    table.insert(result.html, '<td>' .. cachesTxt .. '</td>')
    table.insert(result.html, '<td>' .. typesTxt .. '</td>')
    table.insert(result.html, '<td>' .. sizesTxt .. '</td>')
    table.insert(result.html, '<td>' .. countiesTxt .. '</td>')
    table.insert(result.html, '</tr>')
    -- begin output of additional requirements
    table.insert(result.html, '<tr>')
    table.insert(result.html, '<td></td><td colspan="6">')
  end

  -- show region's caches on map
  local showCachesInList = showRegionInList and conf.showCachesInList
  local result2 = IfElse(passed, result, {}) -- show caches on map only when passed
  local showTitle = (findsPerRegion > 0) and (typesPerRegion > 0)

  local logList = {}
  table.insert(logList, AddPassedCaches(result2, caches, findsPerRegion, SKIP_COUNTRY_REGION, SHOW_TYPE_FIRST))
  PrintCacheList(result, logList, IfElse(showTitle, 'Found Caches', nil), showCachesInList, SKIP_COUNTRY_REGION)

  if typesPerRegion > 0 then
    local sortedTypes = SortTypesByFindCount(types)
    local title = IfElse(showTitle, 'Found Types', nil)
    logList = {}

    for idx, typeCollection in ipairs(sortedTypes) do
      if passed and (typeCollection.count < findsPerType) then
        break
      end

      table.insert(logList, AddPassedCaches(result2, typeCollection.caches, findsPerType, SKIP_COUNTRY_REGION, SHOW_TYPE_FIRST, idx .. ' / '))
    end

    if conf.showTypesAsSummary then
      PrintTypeSummary(result, sortedTypes, IfElse(passed, findsPerType, 1), title, showCachesInList)
    else
      PrintCacheList(result, logList, title, showCachesInList, SKIP_COUNTRY_REGION)
    end
  end

  if sizesPerRegion > 0 then
    local sortedSizes = SortSizesByFindCount(sizes)
    local title = IfElse(showTitle, 'Found Sizes', nil)
    logList = {}

    for idx, sizeCollection in ipairs(sortedSizes) do
      if passed and (sizeCollection.count < findsPerSize) then
        break
      end

      table.insert(logList, AddPassedCaches(result2, sizeCollection.caches, findsPerSize, SKIP_COUNTRY_REGION, SHOW_SIZE_FIRST, idx .. ' / '))
    end

    if conf.showSizesAsSummary then
      PrintSizeSummary(result, sortedSizes, IfElse(passed, findsPerSize, 1), title, showCachesInList)
    else
      PrintCacheList(result, logList, title, showCachesInList, SKIP_COUNTRY_REGION)
    end
  end

  -- if counties per region are required, add them as well
  local showCountiesInList = showRegionInList and conf.showCountiesInList

  if countiesPerRegion > 0 then
    table.sort(passedCounties, SortCountiesFct)

    BeginTableForCounties(result, showCountiesInList, 'Counties found in this region:')

    local numCountiesToList = math.min(Count(passedCounties), countiesPerRegion)
    for i = 1, numCountiesToList do
      AddPassedOrPartialCounty(result, passedCounties[i], i, showCountiesInList, true)
    end

    EndTable(result, showCountiesInList)
  end

  if showRegionInList then
    -- end output of additional requirements
    table.insert(result.html, '</td></tr>')
  end
end

-- remember country so that we can show it on the map
function AddPassedOrPartialCountry(result, countryCounter, numFound, showCountryInList, passed)
  if (result == nil) or (countryCounter == nil) or (numFound == nil) or (showCountryInList == nil) or (passed == nil) then
    PGC.print('Warning: AddPassedOrPartialCountry() called with nil parameter!\n')
    return
  end

  local countryName = countryCounter.countryName
  local findsPerCountry = countryCounter.findsPerCountry
  local typesPerCountry = countryCounter.typesPerCountry
  local sizesPerCountry = countryCounter.sizesPerCountry
  local findsPerType = countryCounter.findsPerType
  local findsPerSize = countryCounter.findsPerSize
  local countiesPerCountry = countryCounter.countiesPerCountry
  local regionsPerCountry = countryCounter.regionsPerCountry
  local caches = countryCounter.caches
  local types = countryCounter.types
  local sizes = countryCounter.sizes
  local passedRegions = countryCounter.passedRegions
  local passedCounties = countryCounter.passedCounties

  if passed then
    result.passedCountries[countryName] = true
  end

  -- create log text for a passed country
  local countTxt = numFound

  local numCaches = Count(caches)
  local cachesTxt = numCaches .. IfElse(numCaches == 1, ' cache', ' caches') .. GetRequiredText(findsPerCountry)

  local numQualifyingTypes = GetNumQualifyingTypes(types, findsPerType)
  local typesTxt = numQualifyingTypes .. IfElse(numQualifyingTypes == 1, ' type', ' types')
  if findsPerType > 1 then
    typesTxt = typesTxt .. ' with at least ' .. findsPerType .. ' finds'
  end
  typesTxt = typesTxt .. GetRequiredText(typesPerCountry)

  local numQualifyingSizes = GetNumQualifyingSizes(sizes, findsPerSize)
  local sizesTxt = numQualifyingSizes .. IfElse(numQualifyingSizes == 1, ' size', ' sizes')
  if findsPerSize > 1 then
    sizesTxt = sizesTxt .. ' with at least ' .. findsPerSize .. ' finds'
  end
  sizesTxt = sizesTxt .. GetRequiredText(sizesPerCountry)

  local numRegions = Count(passedRegions)
  local regionsTxt = numRegions .. IfElse(numRegions == 1, ' region', ' regions') .. GetRequiredText(regionsPerCountry)

  local numCounties = Count(passedCounties)
  local countiesTxt = numCounties .. IfElse(numCounties == 1, ' county', ' counties') .. GetRequiredText(countiesPerCountry)

  local txt = countTxt .. ' Found country ' .. countryName .. ' with ' .. cachesTxt .. ' and ' .. typesTxt .. ' and ' .. sizesTxt .. ' and ' .. regionsTxt .. ' and ' .. countiesTxt
  PGC.print(txt, '.\n')

  if showCountryInList then
    table.insert(result.html, '<tr>')
    table.insert(result.html, '<td>' .. countTxt .. '</td>')
    table.insert(result.html, '<td>' .. PGC.Icon.CountryFlag(countryName) .. '&nbsp;' .. countryName .. '</td>')
    table.insert(result.html, '<td>' .. cachesTxt .. '</td>')
    table.insert(result.html, '<td>' .. typesTxt .. '</td>')
    table.insert(result.html, '<td>' .. sizesTxt .. '</td>')
    table.insert(result.html, '<td>' .. regionsTxt .. '</td>')
    table.insert(result.html, '<td>' .. countiesTxt .. '</td>')
    table.insert(result.html, '</tr>')
    -- begin output of additional requirements
    table.insert(result.html, '<tr>')
    table.insert(result.html, '<td></td><td colspan="6">')
  end

  local showCachesInList = showCountryInList and conf.showCachesInList
  local result2 = IfElse(passed, result, {}) -- show caches on map only when passed
  local showTitle = (findsPerCountry > 0) and (typesPerCountry > 0)

  -- show country's caches on map
  local logList = {}
  table.insert(logList, AddPassedCaches(result2, caches, findsPerCountry, SKIP_COUNTRY, SHOW_TYPE_FIRST))
  PrintCacheList(result, logList, IfElse(showTitle, 'Found Caches', nil), showCachesInList, SKIP_COUNTRY)

  if typesPerCountry > 0 then
    local sortedTypes = SortTypesByFindCount(types)
    local title = IfElse(showTitle, 'Found Types', nil)
    logList = {}

    for idx, typeCollection in ipairs(sortedTypes) do
      if passed and (typeCollection.count < findsPerType) then
        break
      end

      table.insert(logList, AddPassedCaches(result2, typeCollection.caches, findsPerType, SKIP_COUNTRY, SHOW_TYPE_FIRST, idx .. ' / '))
    end

    if conf.showTypesAsSummary then
      PrintTypeSummary(result, sortedTypes, IfElse(passed, findsPerType, 1), title, showCachesInList)
    else
      PrintCacheList(result, logList, title, showCachesInList, SKIP_COUNTRY)
    end
  end

  if sizesPerCountry > 0 then
    local sortedSizes = SortSizesByFindCount(sizes)
    local title = IfElse(showTitle, 'Found Sizes', nil)
    logList = {}

    for idx, sizeCollection in ipairs(sortedSizes) do
      if passed and (sizeCollection.count < findsPerSize) then
        break
      end

      table.insert(logList, AddPassedCaches(result2, sizeCollection.caches, findsPerSize, SKIP_COUNTRY, SHOW_SIZE_FIRST, idx .. ' / '))
    end

    if conf.showSizesAsSummary then
      PrintSizeSummary(result, sortedSizes, IfElse(passed, findsPerSize, 1), title, showCachesInList)
    else
      PrintCacheList(result, logList, title, showCachesInList, SKIP_COUNTRY)
    end
  end

  -- if regions per country are required, add them as well
  local showRegionsInList = showCountryInList and conf.showRegionsInList

  if regionsPerCountry > 0 then
    table.sort(passedRegions, SortRegionsFct)

    BeginTableForRegions(result, showRegionsInList, 'Regions found in this country:')

    local numRegionsToList = math.min(Count(passedRegions), regionsPerCountry)
    for i = 1, numRegionsToList do
      AddPassedOrPartialRegion(result, passedRegions[i], i, showRegionsInList, true)
    end

    EndTable(result, showRegionsInList)
  end

  -- if counties per country are required, add them as well
  local showCountiesInList = showCountryInList and conf.showCountiesInList

  if countiesPerCountry > 0 then
    table.sort(passedCounties, SortCountiesFct)

    BeginTableForCounties(result, showCountiesInList, 'Counties found in this country:')

    local numCountiesToList = math.min(Count(passedCounties), countiesPerCountry)
    for i = 1, numCountiesToList do
      AddPassedOrPartialCounty(result, passedCounties[i], i, showCountiesInList, true)
    end

    EndTable(result, showCountiesInList)
  end

  if showCountryInList then
    -- end output of additional requirements
    table.insert(result.html, '</td></tr>')
  end
end

-- remember continent with its caches so that we can show it on the map
function AddPassedOrPartialContinent(result, continentCounter, numFound, showContinentInList, passed)
  if (result == nil) or (continentCounter == nil) or (numFound == nil) or (showContinentInList == nil) or (passed == nil) then
    PGC.print('Warning: AddPassedOrPartialContinent() called with nil parameter!\n')
    return
  end

  local continentName = continentCounter.continentName
  local findsPerContinent = continentCounter.findsPerContinent
  local typesPerContinent = continentCounter.typesPerContinent
  local sizesPerContinent = continentCounter.sizesPerContinent
  local findsPerType = continentCounter.findsPerType
  local findsPerSize = continentCounter.findsPerSize
  local countiesPerContinent = continentCounter.countiesPerContinent
  local regionsPerContinent = continentCounter.regionsPerContinent
  local countriesPerContinent = continentCounter.countriesPerContinent
  local caches = continentCounter.caches
  local types = continentCounter.types
  local sizes = continentCounter.sizes
  local passedCountries = continentCounter.passedCountries
  local passedRegions = continentCounter.passedRegions
  local passedCounties = continentCounter.passedCounties

  -- create log text for a passed continent
  local countTxt = numFound

  local numFinds = Count(caches)
  local cachesTxt = numFinds .. IfElse(numFinds == 1, ' cache', ' caches') .. GetRequiredText(findsPerContinent)

  local numQualifyingTypes = GetNumQualifyingTypes(types, findsPerType)
  local typesTxt = numQualifyingTypes .. IfElse(numQualifyingTypes == 1, ' type', ' types')
  if findsPerType > 1 then
    typesTxt = typesTxt .. ' with at least ' .. findsPerType .. ' finds'
  end
  typesTxt = typesTxt .. GetRequiredText(typesPerContinent)

  local numQualifyingSizes = GetNumQualifyingSizes(sizes, findsPerSize)
  local sizesTxt = numQualifyingSizes .. IfElse(numQualifyingSizes == 1, ' size', ' sizes')
  if findsPerSize > 1 then
    sizesTxt = sizesTxt .. ' with at least ' .. findsPerSize .. ' finds'
  end
  sizesTxt = sizesTxt .. GetRequiredText(sizesPerContinent)

  local numCountries = Count(passedCountries)
  local countriesTxt = numCountries .. IfElse(numCountries == 1, ' country', ' countries') .. GetRequiredText(countriesPerContinent)

  local numRegions = Count(passedRegions)
  local regionsTxt = numRegions .. IfElse(numRegions == 1, ' region', ' regions') .. GetRequiredText(regionsPerContinent)

  local numCounties = Count(passedCounties)
  local countiesTxt = numCounties .. IfElse(numCounties == 1, ' county', ' counties') .. GetRequiredText(countiesPerContinent)

  local txt = countTxt .. ' Found continent ' .. continentName .. ' with ' .. cachesTxt .. ' and ' .. typesTxt .. ' and ' .. sizesTxt .. ' and ' .. numCountries .. ' and ' .. regionsTxt .. ' and ' .. countiesTxt
  PGC.print(txt, '.\n')

  if showContinentInList then
    table.insert(result.html, '<tr>')
    table.insert(result.html, '<td>' .. countTxt .. '</td>')
    table.insert(result.html, '<td>' .. continentName .. '</td>')
    table.insert(result.html, '<td>' .. cachesTxt .. '</td>')
    table.insert(result.html, '<td>' .. typesTxt .. '</td>')
    table.insert(result.html, '<td>' .. sizesTxt .. '</td>')
    table.insert(result.html, '<td>' .. countriesTxt .. '</td>')
    table.insert(result.html, '<td>' .. regionsTxt .. '</td>')
    table.insert(result.html, '<td>' .. countiesTxt .. '</td>')
    table.insert(result.html, '</tr>')
    -- begin output of additional requirements
    table.insert(result.html, '<tr>')
    table.insert(result.html, '<td></td><td colspan="7">')
  end

  -- show continent's caches on map
  local showCachesInList = showContinentInList and conf.showCachesInList
  local result2 = IfElse(passed, result, {}) -- show caches on map only when passed
  local showTitle = (findsPerContinent > 0) and (typesPerContinent > 0)

  local logList = {}
  table.insert(logList, AddPassedCaches(result2, caches, findsPerContinent, SKIP_NONE, SHOW_TYPE_FIRST))
  PrintCacheList(result, logList, IfElse(showTitle, 'Found Caches', nil), showCachesInList, SKIP_NONE)

  if typesPerContinent > 0 then
    local sortedTypes = SortTypesByFindCount(types)
    local title = IfElse(showTitle, 'Found Types', nil)
    logList = {}

    for idx, typeCollection in ipairs(sortedTypes) do
      if passed and (typeCollection.count < findsPerType) then
        break
      end

      table.insert(logList, AddPassedCaches(result2, typeCollection.caches, findsPerType, SKIP_NONE, SHOW_TYPE_FIRST, idx .. ' / '))
    end

    if conf.showTypesAsSummary then
      PrintTypeSummary(result, sortedTypes, IfElse(passed, findsPerType, 1), title, showCachesInList)
    else
      PrintCacheList(result, logList, title, showCachesInList, SKIP_NONE)
    end
  end

  if sizesPerContinent > 0 then
    local sortedSizes = SortSizesByFindCount(sizes)
    local title = IfElse(showTitle, 'Found Sizes', nil)
    logList = {}

    for idx, sizeCollection in ipairs(sortedSizes) do
      if passed and (sizeCollection.count < findsPerSize) then
        break
      end

      table.insert(logList, AddPassedCaches(result2, sizeCollection.caches, findsPerSize, SKIP_NONE, SHOW_SIZE_FIRST, idx .. ' / '))
    end

    if conf.showSizesAsSummary then
      PrintSizeSummary(result, sortedSizes, IfElse(passed, findsPerSize, 1), title, showCachesInList)
    else
      PrintCacheList(result, logList, title, showCachesInList, SKIP_NONE)
    end
  end

  -- if countries per continent are required, add them as well
  local showCountriesInList = showContinentInList and conf.showCountriesInList

  if countriesPerContinent > 0 then
    table.sort(passedCountries, SortCountriesFct)

    BeginTableForCountries(result, showCountriesInList, 'Countries found in this continent:')

    local numCountriesToList = math.min(Count(passedCountries), countriesPerContinent)
    for i = 1, numCountriesToList do
      AddPassedOrPartialCountry(result, passedCountries[i], i, showCountriesInList, true)
    end

    EndTable(result, showCountriesInList)
  end

  -- if regions per continent are required, add them as well
  local showRegionsInList = showContinentInList and conf.showRegionsInList

  if regionsPerContinent > 0 then
    table.sort(passedRegions, SortRegionsFct)

    BeginTableForRegions(result, showRegionsInList, 'Regions found in this continent:')

    local numRegionsToList = math.min(Count(passedRegions), regionsPerContinent)
    for i = 1, numRegionsToList do
      AddPassedOrPartialRegion(result, passedRegions[i], i, showRegionsInList, true)
    end

    EndTable(result, showRegionsInList)
  end

  -- if counties per continent are required, add them as well
  local showCountiesInList = showContinentInList and conf.showCountiesInList

  if countiesPerContinent > 0 then
    table.sort(passedCounties, SortCountiesFct)

    BeginTableForCounties(result, showCountiesInList, 'Counties found in this continent:')

    local numCountiesToList = math.min(Count(passedCounties), countiesPerContinent)
    for i = 1, numCountiesToList do
      AddPassedOrPartialCounty(result, passedCounties[i], i, showCountiesInList, true)
    end

    EndTable(result, showCountiesInList)
  end

  if showContinentInList then
    -- end output of additional requirements
    table.insert(result.html, '</td></tr>')
  end
end

-- show counties for which the player has only partially qualified (as progress indicator)
function ShowPartiallyQualifiedCounties(counters, result)
  local partialCounties = {}
  for _, countryCounter in pairs(counters.countries) do
    for _, countyCounter in ipairs(countryCounter.partialCounties) do
      table.insert(partialCounties, countyCounter)
    end
  end

  if Count(partialCounties) > 0 then
    -- sort the table using our sort function
    table.sort(partialCounties, SortCountiesFct)

    BeginTableForCounties(result, conf.showCountiesInList, 'Partially Qualified Counties')
    local showInList = conf.showCountiesInList

    for i, countyCounter in ipairs(partialCounties) do
      AddPassedOrPartialCounty(result, countyCounter, i, showInList, false)
    end

    EndTable(result, conf.showCountiesInList)
  end
end

-- check if enough counties were found
function CheckCountiesOK(counters, result)
  if (counters == nil) or (result == nil) then
    PGC.print('Warning: CheckCountiesOK() called with nil parameter!\n')
    return false
  end

  local numCountiesRequired = conf.counties
  if (numCountiesRequired == 0) and (conf.showCountiesInList == false) then
    return true -- no counties required = PASSED
  end

  -- don't list counties if they are indirectly required
  if (numCountiesRequired == 0) and ((conf.countiesPerCountry > 0) or (conf.countiesPerCountryPercent > 0) or (conf.countiesPerRegion > 0) or (conf.countiesPerRegionPercent > 0) or (conf.countiesPerContinent > 0)) then
    return true -- no counties required = PASSED
  end

  -- collect all passed countries
  local foundCounties = {}
  for _, countryCounter in pairs(counters.countries) do
    AppendIndexedTable(foundCounties, countryCounter.passedCounties)
  end

  -- sort the table using our sort function
  table.sort(foundCounties, SortCountiesFct)

  return CheckCountiesOK_Internal(counters, result, foundCounties)
end

-- reusable function to output found list of counties
function CheckCountiesOK_Internal(counters, result, foundCounties)
  local numCountiesRequired = conf.counties
  local showInList = conf.showCountiesInList

  local countiesFound = #foundCounties

  local logHeader = conf.countiesLog
  if type(logHeader) ~= 'string' then
    local additionalRequirement = false
    logHeader = {}

    if numCountiesRequired > 0 then
      table.insert(logHeader, 'Find')
    else
      table.insert(logHeader, 'Found')
    end

    if conf.findsPerCounty > 0 then
      table.insert(logHeader, conf.findsPerCounty)
      table.insert(logHeader, IfElse(conf.findsPerCounty == 1, 'cache', 'caches'))
      additionalRequirement = true
    end

    if conf.typesPerCounty > 0 then
      if additionalRequirement then
        table.insert(logHeader, 'and')
      end
      table.insert(logHeader, conf.typesPerCounty)
      table.insert(logHeader, IfElse(conf.typesPerCounty == 1, 'type', 'types'))
      additionalRequirement = true
    end

    if conf.sizesPerCounty > 0 then
      if additionalRequirement then
        table.insert(logHeader, 'and')
      end
      table.insert(logHeader, conf.sizesPerCounty)
      table.insert(logHeader, IfElse(conf.sizesPerCounty == 1, 'size', 'sizes'))
      additionalRequirement = true
    end

    if additionalRequirement then
      table.insert(logHeader, 'in')
    end

    if numCountiesRequired > 0 then
      table.insert(logHeader, numCountiesRequired)
      table.insert(logHeader, IfElse(numCountiesRequired == 1, 'county', 'counties'))
    else
      table.insert(logHeader, 'counties')
    end

    logHeader = table.concat(logHeader, ' ')
  end

  BeginTableForCounties(result, conf.showCountiesInList, logHeader)

  local numCountiesToList = numCountiesRequired
  if type(showInList) == 'number' then
    numCountiesToList = showInList
  end
  if showInList == 'all' then
    numCountiesToList = 0
  end

  for i, countyCounter in ipairs(foundCounties) do
    AddPassedOrPartialCounty(result, countyCounter, i, showInList and ((i <= numCountiesToList) or (numCountiesToList == 0)), true)
  end

  EndTable(result, conf.showCountiesInList)

  local txt = logHeader .. ' (' .. countiesFound .. ' counties found).'

  if numCountiesRequired > 0 then
    local passed = countiesFound >= numCountiesRequired
    if passed then
      txt = 'PASSED: ' .. txt
      table.insert(result.log, txt)
      table.insert(result.html, txt .. '<br><br>')
      PGC.print(txt .. '\n')
  
      if conf.showProgressWhenQualified then
        ShowPartiallyQualifiedCounties(counters, result)
      end
    else
      txt = 'FAILED: ' .. txt
      table.insert(result.html, txt .. '<br><br>')
      PGC.print(txt .. '\n')
      ShowPartiallyQualifiedCounties(counters, result)
    end
  
    return passed
  end

  table.insert(result.html, '<br>')
  return true
end

-- show regions for which the player has only partially qualified (as progress indicator)
function ShowPartiallyQualifiedRegions(counters, result)
  local partialRegions = {}
  for _, countryCounter in pairs(counters.countries) do
    for _, regionCounter in ipairs(countryCounter.partialRegions) do
      table.insert(partialRegions, regionCounter)
    end
  end

  if Count(partialRegions) > 0 then
    -- sort the table using our sort function
    table.sort(partialRegions, SortRegionsFct)

    BeginTableForRegions(result, conf.showRegionsInList, 'Partially Qualified Regions')
    local showInList = conf.showRegionsInList

    for i, regionCounter in ipairs(partialRegions) do
      AddPassedOrPartialRegion(result, regionCounter, i, showInList, false)
    end

    EndTable(result, conf.showRegionsInList)
  end
end

-- check if enough regions were found
function CheckRegionsOK(counters, result)
  if (counters == nil) or (result == nil) then
    PGC.print('Warning: CheckRegionsOK() called with nil parameter!\n')
    return false
  end

  local numRegionsRequired = conf.regions
  if (numRegionsRequired == 0) and (conf.showRegionsInList == false) then
    return true -- no regions required = PASSED
  end

  -- don't list regions if they are indirectly required
  if (numRegionsRequired == 0) and ((conf.regionsPerCountry > 0) or (conf.regionsPerCountryPercent > 0) or (conf.regionsPerContinent > 0)) then
    return true -- no counties required = PASSED
  end

  -- collect all passed regions
  local foundRegions = {}
  for _, countryCounter in pairs(counters.countries) do
    AppendIndexedTable(foundRegions, countryCounter.passedRegions)
  end

  -- sort the table using our sort function
  table.sort(foundRegions, SortRegionsFct)

  return CheckRegionsOK_Internal(counters, result, foundRegions)
end

-- reusable function to output found list of regions
function CheckRegionsOK_Internal(counters, result, foundRegions)
  local numRegionsRequired = conf.regions
  local showInList = conf.showRegionsInList

  local regionsFound = #foundRegions

  local logHeader = conf.regionsLog
  if type(logHeader) ~= 'string' then
    local additionalRequirement = false
    logHeader = {}

    if numRegionsRequired > 0 then
      table.insert(logHeader, 'Find')
    else
      table.insert(logHeader, 'Found')
    end

    if conf.findsPerRegion > 0 then
      table.insert(logHeader, conf.findsPerRegion)
      table.insert(logHeader, IfElse(conf.findsPerRegion == 1, 'cache', 'caches'))
      additionalRequirement = true
    end

    if conf.typesPerRegion > 0 then
      if additionalRequirement then
        table.insert(logHeader, 'and')
      end
      table.insert(logHeader, conf.typesPerRegion)
      table.insert(logHeader, IfElse(conf.typesPerRegion == 1, 'type', 'types'))
      additionalRequirement = true
    end

    if conf.sizesPerRegion > 0 then
      if additionalRequirement then
        table.insert(logHeader, 'and')
      end
      table.insert(logHeader, conf.sizesPerRegion)
      table.insert(logHeader, IfElse(conf.sizesPerRegion == 1, 'size', 'sizes'))
      additionalRequirement = true
    end

    if conf.countiesPerRegionPercent > 0 then
      if additionalRequirement then
        table.insert(logHeader, 'and')
      end
      if conf.countiesPerRegionPercent == 100 then
        table.insert(logHeader, 'all')
      else
        table.insert(logHeader, conf.countiesPerRegionPercent .. '% of the')
      end
      table.insert(logHeader, 'counties')
      if conf.countiesPerRegion > 1 then
        table.insert(logHeader, '(at least')
        table.insert(logHeader, conf.countiesPerRegion .. ')')
      end
      additionalRequirement = true
    elseif conf.countiesPerRegion > 0 then
      if additionalRequirement then
        table.insert(logHeader, 'and')
      end
      table.insert(logHeader, conf.countiesPerRegion)
      table.insert(logHeader, IfElse(conf.countiesPerRegion == 1, 'county', 'counties'))
      additionalRequirement = true
    end

    if additionalRequirement then
      table.insert(logHeader, 'in')
    end

    if numRegionsRequired > 0 then
      table.insert(logHeader, numRegionsRequired)
      table.insert(logHeader, IfElse(numRegionsRequired == 1, 'region', 'regions'))
    else
      table.insert(logHeader, 'regions')
    end

    logHeader = table.concat(logHeader, ' ')
  end

  BeginTableForRegions(result, conf.showRegionsInList, logHeader)

  local numRegionsToList = numRegionsRequired
  if type(showInList) == 'number' then
    numRegionsToList = showInList
  end
  if showInList == 'all' then
    numRegionsToList = 0
  end

  for i, regionCounter in ipairs(foundRegions) do
    AddPassedOrPartialRegion(result, regionCounter, i, showInList and ((i <= numRegionsToList) or (numRegionsToList == 0)), true)
  end

  EndTable(result, conf.showRegionsInList)

  local txt = logHeader .. ' (' .. regionsFound .. ' regions found).'

  if numRegionsRequired > 0 then
    local passed = regionsFound >= numRegionsRequired

    if passed then
      txt = 'PASSED: ' .. txt
      table.insert(result.log, txt)
      table.insert(result.html, txt .. '<br><br>')
      PGC.print(txt .. '\n')
  
      if conf.showProgressWhenQualified then
        ShowPartiallyQualifiedRegions(counters, result)
      end
    else
      txt = 'FAILED: ' .. txt
      table.insert(result.html, txt .. '<br><br>')
      PGC.print(txt .. '\n')
      ShowPartiallyQualifiedRegions(counters, result)
    end
  
    return passed
  end

  table.insert(result.html, '<br>')
  return true
end

-- show countries for which the player has only partially qualified (as progress indicator)
function ShowPartiallyQualifiedCountries(counters, result)
  local partialCountries = {}
  for _, countryCounter in pairs(counters.countries) do
    if countryCounter.PartiallyQualified then
      table.insert(partialCountries, countryCounter)
    end
  end

  if Count(partialCountries) > 0 then
    -- sort the table using our sort function
    table.sort(partialCountries, SortCountriesFct)

    BeginTableForCountries(result, conf.showCountriesInList, 'Partially Qualified Countries')
    local showInList = conf.showCountriesInList

    for i, countryCounter in ipairs(partialCountries) do
      AddPassedOrPartialCountry(result, countryCounter, i, showInList, false)
    end

    EndTable(result, conf.showCountriesInList)
  end
end

-- check if enough countries were found
function CheckCountriesOK(counters, result)
  if (counters == nil) or (result == nil) then
    PGC.print('Warning: CheckCountriesOK() called with nil parameter!\n')
    return false
  end

  local numCountriesRequired = conf.countries
  if (numCountriesRequired == 0) and (conf.showCountriesInList == false) then
    return true -- no countries required = PASSED
  end

  -- don't list countries if they are indirectly required
  if (numCountriesRequired == 0) and ((conf.countriesPerContinent > 0)) then
    return true -- no counties required = PASSED
  end

  -- collect all passed countries
  local foundCountries = {}
  for _, countryCounter in pairs(counters.countries) do
    if IsCountryPassed(countryCounter) then
      table.insert(foundCountries, countryCounter)
    end
  end

  -- sort the table using our sort function
  table.sort(foundCountries, SortCountriesFct)

  return CheckCountriesOK_Internal(counters, result, foundCountries)
end

-- reusable function to output found list of countries
function CheckCountriesOK_Internal(counters, result, foundCountries)
  local numCountriesRequired = conf.countries
  local showInList = conf.showCountriesInList

  local countriesFound = #foundCountries

  local logHeader = conf.countriesLog
  if type(logHeader) ~= 'string' then
    local additionalRequirement = false
    logHeader = {}

    if numCountriesRequired > 0 then
      table.insert(logHeader, 'Find')
    else
      table.insert(logHeader, 'Found')
    end

    if conf.findsPerCountry > 0 then
      table.insert(logHeader, conf.findsPerCountry)
      table.insert(logHeader, IfElse(conf.findsPerCountry == 1, 'cache', 'caches'))
      additionalRequirement = true
    end

    if conf.typesPerCountry > 0 then
      if additionalRequirement then
        table.insert(logHeader, 'and')
      end
      table.insert(logHeader, conf.typesPerCountry)
      table.insert(logHeader, IfElse(conf.typesPerCountry == 1, 'type', 'types'))
      additionalRequirement = true
    end

    if conf.sizesPerCountry > 0 then
      if additionalRequirement then
        table.insert(logHeader, 'and')
      end
      table.insert(logHeader, conf.sizesPerCountry)
      table.insert(logHeader, IfElse(conf.sizesPerCountry == 1, 'size', 'sizes'))
      additionalRequirement = true
    end

    if conf.regionsPerCountryPercent > 0 then
      if additionalRequirement then
        table.insert(logHeader, 'and')
      end
      if conf.regionsPerCountryPercent == 100 then
        table.insert(logHeader, 'all')
      else
        table.insert(logHeader, conf.regionsPerCountryPercent .. '% of the')
      end
      table.insert(logHeader, 'regions')
      if conf.regionsPerCountry > 1 then
        table.insert(logHeader, '(at least')
        table.insert(logHeader, conf.regionsPerCountry .. ')')
      end
      additionalRequirement = true
    elseif conf.regionsPerCountry > 0 then
      if additionalRequirement then
        table.insert(logHeader, 'and')
      end
      table.insert(logHeader, conf.regionsPerCountry)
      table.insert(logHeader, IfElse(conf.regionsPerCountry == 1, 'region', 'regions'))
      additionalRequirement = true
    end

    if conf.countiesPerCountryPercent > 0 then
      if additionalRequirement then
        table.insert(logHeader, 'and')
      end
      if conf.countiesPerCountryPercent == 100 then
        table.insert(logHeader, 'all')
      else
        table.insert(logHeader, conf.countiesPerCountryPercent .. '% of the')
      end
      table.insert(logHeader, 'counties')
      if conf.countiesPerCountry > 1 then
        table.insert(logHeader, '(at least')
        table.insert(logHeader, conf.countiesPerCountry .. ')')
      end
      additionalRequirement = true
    elseif conf.countiesPerCountry > 0 then
      if additionalRequirement then
        table.insert(logHeader, 'and')
      end
      table.insert(logHeader, conf.countiesPerCountry)
      table.insert(logHeader, IfElse(conf.countiesPerCountry == 1, 'county', 'counties'))
      additionalRequirement = true
    end

    if additionalRequirement then
      table.insert(logHeader, 'in')
    end

    if numCountriesRequired > 0 then
      table.insert(logHeader, numCountriesRequired)
      table.insert(logHeader, IfElse(numCountriesRequired == 1, 'country', 'countries'))
    else
      table.insert(logHeader, 'countries')
    end

    logHeader = table.concat(logHeader, ' ')
  end

  BeginTableForCountries(result, conf.showCountriesInList, logHeader)

  local numCountriesToList = numCountriesRequired
  if type(showInList) == 'number' then
    numCountriesToList = showInList
  end
  if showInList == 'all' then
    numCountriesToList = 0
  end

  for i, countryCounter in ipairs(foundCountries) do
    AddPassedOrPartialCountry(result, countryCounter, i, showInList and ((i <= numCountriesToList) or (numCountriesToList == 0)), true)
  end

  EndTable(result, conf.showCountriesInList)

  local txt = logHeader .. ' (' .. countriesFound .. ' countries found).'

  if numCountriesRequired > 0 then
    local passed = countriesFound >= numCountriesRequired
    if passed then
      txt = 'PASSED: ' .. txt
      table.insert(result.log, txt)
      table.insert(result.html, txt .. '<br><br>')
      PGC.print(txt .. '\n')
  
      if conf.showProgressWhenQualified then
        ShowPartiallyQualifiedCountries(counters, result)
      end
    else
      txt = 'FAILED: ' .. txt
      table.insert(result.html, txt .. '<br><br>')
      PGC.print(txt .. '\n')
      ShowPartiallyQualifiedCountries(counters, result)
    end

    return passed
  end
  
  table.insert(result.html, '<br>')
  return true
end

-- show continents for which the player has only partially qualified (as progress indicator)
function ShowPartiallyQualifiedContinents(counters, result)
  local partialContinents = {}
  for _, continentCounter in pairs(counters.continents) do
    if continentCounter.PartiallyQualified then
      table.insert(partialContinents, continentCounter)
    end
  end

  if Count(partialContinents) > 0 then
    -- sort the table using our sort function
    table.sort(partialContinents, SortContinentsFct)

    BeginTableForContinents(result, conf.showContinentsInList, 'Partially Qualified Continents')
    local showInList = conf.showContinentsInList

    for i, continentCounter in ipairs(partialContinents) do
      AddPassedOrPartialContinent(result, continentCounter, i, showInList, false)
    end

    EndTable(result, conf.showContinentsInList)
  end
end

-- check if enough continents were found
function CheckContinentsOK(counters, result)
  if (counters == nil) or (result == nil) then
    PGC.print('Warning: CheckContinentsOK() called with nil parameter!\n')
    return false
  end

  if (conf.continents == 0) and (conf.showContinentsInList == false) then
    return true -- no continents required = PASSED
  end

  -- collect all passed continents
  local foundContinents = {}
  for _, continentCounter in pairs(counters.continents) do
    if IsContinentPassed(continentCounter) then
      table.insert(foundContinents, continentCounter)
    end
  end

  -- sort the table using our sort function
  table.sort(foundContinents, SortContinentsFct)

  return CheckContinentsOK_Internal(counters, result, foundContinents)
end

-- reusable function to output found list of continents
function CheckContinentsOK_Internal(counters, result, foundContinents)
  local numContinentsRequired = conf.continents
  local showInList = conf.showContinentsInList

  local continentsFound = #foundContinents

  local logHeader = conf.continentsLog
  if type(logHeader) ~= 'string' then
    local additionalRequirement = false
    logHeader = {}

    if numContinentsRequired > 0 then
      table.insert(logHeader, 'Find')
    else
      table.insert(logHeader, 'Found')
    end

    if conf.findsPerContinent > 0 then
      table.insert(logHeader, conf.findsPerContinent)
      table.insert(logHeader, IfElse(conf.findsPerContinent == 1, 'cache', 'caches'))
      additionalRequirement = true
    end

    if conf.typesPerContinent > 0 then
      if additionalRequirement then
        table.insert(logHeader, 'and')
      end
      table.insert(logHeader, conf.typesPerContinent)
      table.insert(logHeader, IfElse(conf.typesPerContinent == 1, 'type', 'types'))
      additionalRequirement = true
    end

    if conf.sizesPerContinent > 0 then
      if additionalRequirement then
        table.insert(logHeader, 'and')
      end
      table.insert(logHeader, conf.sizesPerContinent)
      table.insert(logHeader, IfElse(conf.sizesPerContinent == 1, 'size', 'sizes'))
      additionalRequirement = true
    end

    if conf.countriesPerContinent > 0 then
      if additionalRequirement then
        table.insert(logHeader, 'and')
      end
      table.insert(logHeader, conf.countriesPerContinent)
      table.insert(logHeader, IfElse(conf.countriesPerContinent == 1, 'country', 'countries'))
      additionalRequirement = true
    end

    if conf.regionsPerContinent > 0 then
      if additionalRequirement then
        table.insert(logHeader, 'and')
      end
      table.insert(logHeader, conf.regionsPerContinent)
      table.insert(logHeader, IfElse(conf.regionsPerContinent == 1, 'region', 'regions'))
      additionalRequirement = true
    end

    if conf.countiesPerContinent > 0 then
      if additionalRequirement then
        table.insert(logHeader, 'and')
      end
      table.insert(logHeader, conf.countiesPerContinent)
      table.insert(logHeader, IfElse(conf.countiesPerContinent == 1, 'county', 'counties'))
      additionalRequirement = true
    end

    if additionalRequirement then
      table.insert(logHeader, 'in')
    end

    if numContinentsRequired > 0 then
      table.insert(logHeader, numContinentsRequired)
      table.insert(logHeader, IfElse(numContinentsRequired == 1, 'continent', 'continents'))
    else
      table.insert(logHeader, 'continents')
    end

    logHeader = table.concat(logHeader, ' ')
  end

  BeginTableForContinents(result, conf.showContinentsInList, logHeader)

  local numContinentsToList = numContinentsRequired
  if type(showInList) == 'number' then
    numContinentsToList = showInList
  end
  if showInList == 'all' then
    numContinentsToList = 0
  end

  for i, continentCounter in ipairs(foundContinents) do
    AddPassedOrPartialContinent(result, continentCounter, i, showInList and ((i <= numContinentsToList) or (numContinentsToList == 0)), true)
  end

  EndTable(result, conf.showContinentsInList)

  local txt = logHeader .. ' (' .. continentsFound .. ' continents found).'

  if numContinentsRequired > 0 then
    local passed = continentsFound >= numContinentsRequired
    if passed then
      txt = 'PASSED: ' .. txt
      table.insert(result.log, txt)
      table.insert(result.html, txt .. '<br><br>')
      PGC.print(txt .. '\n')
  
      if conf.showProgressWhenQualified then
        ShowPartiallyQualifiedContinents(counters, result)
      end
    else
      txt = 'FAILED: ' .. txt
      table.insert(result.html, txt .. '<br><br>')
      PGC.print(txt .. '\n')
      ShowPartiallyQualifiedContinents(counters, result)
    end

    return passed
  end
  
  table.insert(result.html, '<br>')
  return true
end

-- check if enough caches were found in total
function CheckFindsTotalOK(counters, result)
  if (counters == nil) or (result == nil) then
    PGC.print('Warning: CheckFindsTotalOK() called with nil parameter!\n')
    return false
  end

  local numFindsTotalRequired = conf.findsTotal
  if numFindsTotalRequired == 0 then
    return true -- no total number of finds required = PASSED
  end

  -- collect all counted caches
  local allCountedCaches = {}
  for _, countryCounter in pairs(counters.countries) do
    for _, cache in ipairs(countryCounter.caches) do
      table.insert(allCountedCaches, cache)
    end
  end

  local logHeader = conf.findsTotalLog
  if type(logHeader) ~= 'string' then
    logHeader = {}
    table.insert(logHeader, 'Find')
    table.insert(logHeader, numFindsTotalRequired)
    table.insert(logHeader, IfElse(numFindsTotalRequired == 1, 'cache', 'caches'))
    table.insert(logHeader, 'in total')
    logHeader = table.concat(logHeader, ' ')
  end

  -- show required caches on map
  local logList = {}
  table.insert(logList, AddPassedCaches(result, allCountedCaches, numFindsTotalRequired, SKIP_NONE, SHOW_TYPE_FIRST))
  PrintCacheList(result, logList, logHeader, conf.showCachesInList, SKIP_NONE)

  local numCachesFound = Count(allCountedCaches)
  local txt = logHeader .. ' (' .. numCachesFound .. ' caches found).'

  local passed = numCachesFound >= numFindsTotalRequired
  if passed then
    txt = 'PASSED: ' .. txt
    table.insert(result.log, txt)
    table.insert(result.html, txt .. '<br><br>')
    PGC.print(txt .. '\n')
  else
    txt = 'FAILED: ' .. txt
    table.insert(result.html, txt .. '<br><br>')
    PGC.print(txt .. '\n')
  end

  return passed
end

-- check if the required qualifications were met
function CheckQualifications(counters)
  if counters == nil then
    PGC.print('Warning: CheckQualifications() called with nil parameter!\n')
    return false
  end

  local result = {
    ok = false,
    log = {},
    html = {},
    passedCaches = {},
    passedCounties = {},
    passedRegions = {},
    passedCountries = {}
  }

  if type(conf.log) == 'string' then
    table.insert(result.html, conf.log)
    table.insert(result.html, '<br><br>')

    table.insert(result.log, conf.log)
  end

  local continentsOK = true
  local countriesOK = true
  local regionsOK = true
  local countiesOK = true

  -- check with types countdown
  if conf.findsPerTypeCountdown > 0 then
    PGC.print('CheckQualifications() in findsPerTypeCountdown mode\n')
    local findsPerTypeOriginal = conf.findsPerType

    if (conf.continents > 0) and (conf.typesPerContinent > 0) then
      local foundContinents = {}

      for i = 1, conf.continents do
        ClearFlags(counters)
        FlagEnoughFindsAndTypesAndSizes(counters)
        FlagEnoughCounties(counters)
        FlagEnoughRegions(counters)
        FlagEnoughCountries(counters)

        local oneMoreFound = false

        for _, continentCounter in pairs(counters.continents) do
          if continentCounter.HasEnoughFinds and continentCounter.HasEnoughTypes and (not continentCounter.AlreadyFound) then
            table.insert(foundContinents, continentCounter)
            continentCounter.AlreadyFound = true
            oneMoreFound = true
            break
          end
        end

        if not oneMoreFound then
          break
        end

        conf.findsPerType = conf.findsPerType - conf.findsPerTypeCountdown
      end

      continentsOK = CheckContinentsOK_Internal(counters, result, foundContinents)
      conf.findsPerType = findsPerTypeOriginal
    end

    if (conf.countries > 0) and (conf.typesPerCountry > 0) then
      local foundCountries = {}

      for i = 1, conf.countries do
        ClearFlags(counters)
        FlagEnoughFindsAndTypesAndSizes(counters)
        FlagEnoughCounties(counters)
        FlagEnoughRegions(counters)
        FlagEnoughCountries(counters)

        local oneMoreFound = false

        for _, countryCounter in pairs(counters.countries) do
          if countryCounter.HasEnoughFinds and countryCounter.HasEnoughTypes and countryCounter.HasEnoughRegions and countryCounter.HasEnoughCounties and (not countryCounter.AlreadyFound) then
            table.insert(foundCountries, countryCounter)
            countryCounter.AlreadyFound = true
            oneMoreFound = true
            break
          end
        end

        if not oneMoreFound then
          break
        end

        conf.findsPerType = conf.findsPerType - conf.findsPerTypeCountdown
      end
      
      countriesOK = CheckCountriesOK_Internal(counters, result, foundCountries)
      conf.findsPerType = findsPerTypeOriginal
    end

    if (conf.regions > 0) and (conf.typesPerRegion > 0) then
      local foundRegions = {}

      for i = 1, conf.regions do
        ClearFlags(counters)
        FlagEnoughFindsAndTypesAndSizes(counters)
        FlagEnoughCounties(counters)
        FlagEnoughRegions(counters)
        FlagEnoughCountries(counters)

        local oneMoreFound = false

        for _, countryCounter in pairs(counters.countries) do
          for _, regionCounter in ipairs(countryCounter.passedRegions) do
            if not regionCounter.AlreadyFound then
              table.insert(foundRegions, regionCounter)
              regionCounter.AlreadyFound = true
              oneMoreFound = true
              break
            end
          end
          if oneMoreFound then
            break
          end
        end

        if not oneMoreFound then
          break
        end

        conf.findsPerType = conf.findsPerType - conf.findsPerTypeCountdown
      end
      
      regionsOK = CheckRegionsOK_Internal(counters, result, foundRegions)
      conf.findsPerType = findsPerTypeOriginal
    end
    
    if (conf.counties > 0) and (conf.typesPerCounty > 0) then
      local foundCounties = {}

      for i = 1, conf.counties do
        ClearFlags(counters)
        FlagEnoughFindsAndTypesAndSizes(counters)
        FlagEnoughCounties(counters)
        FlagEnoughRegions(counters)
        FlagEnoughCountries(counters)

        local oneMoreFound = false

        for _, countryCounter in pairs(counters.countries) do
          for _, countyCounter in ipairs(countryCounter.passedCounties) do
            if not countyCounter.AlreadyFound then
              table.insert(foundCounties, countyCounter)
              countyCounter.AlreadyFound = true
              oneMoreFound = true
              break
            end
          end
          if oneMoreFound then
            break
          end
        end

        if not oneMoreFound then
          break
        end

        conf.findsPerType = conf.findsPerType - conf.findsPerTypeCountdown
      end
      
      countiesOK = CheckCountiesOK_Internal(counters, result, foundCounties)
      conf.findsPerType = findsPerTypeOriginal
    end
  else
    PGC.print('CheckQualifications() in regular mode\n')

    -- regular check without countdown
    FlagEnoughFindsAndTypesAndSizes(counters)
    FlagEnoughCounties(counters)
    FlagEnoughRegions(counters)
    FlagEnoughCountries(counters)

    continentsOK = CheckContinentsOK(counters, result)
    countriesOK = CheckCountriesOK(counters, result)
    regionsOK = CheckRegionsOK(counters, result)
    countiesOK = CheckCountiesOK(counters, result)
  end

  local findsTotalOK = CheckFindsTotalOK(counters, result)

  result.ok = continentsOK and countriesOK and regionsOK and countiesOK and findsTotalOK
  return result
end

-- initialize the map object when used for the first time
function InitMap(map)
  if map == nil then
    map = { polygons = {}, caches = {}, correctedCoordinatesInUse = false }
  end
  return map
end

-- sets/extends the map outbox to include the given min/max coordinates
function UpdateOutboundBox(map, minLat, minLon, maxLat, maxLon)
  minLat = tonumber(minLat)
  minLon = tonumber(minLon)
  maxLat = tonumber(maxLat)
  maxLon = tonumber(maxLon)

  if (map == nil) or (minLat == nil) or (minLon == nil) or (maxLat == nil) or (maxLon == nil) then
    return
  end

  if map.outboundBox ~= nil then
    if map.outboundBox[1] < minLat then
      minLat = map.outboundBox[1]
    end
    if map.outboundBox[2] < minLon then
      minLon = map.outboundBox[2]
    end
    if map.outboundBox[3] > maxLat then
      maxLat = map.outboundBox[3]
    end
    if map.outboundBox[4] > maxLon then
      maxLon = map.outboundBox[4]
    end
  end

  map.outboundBox = { minLat, minLon, maxLat, maxLon }
end

-- get country polygon, fetches polygon data into cache and returns cached instance on second call
function GetCountryPolygon(countryName)
  if (countryName == nil) then
    PGC.print('Warning: GetCountryPolygon() called with nil parameter!\n')
    return nil
  end

  local countryPolygon = conf.fetchedCountryPolygons[countryName]
  if countryPolygon == nil then
    local elapsedSecond = os.time() - startTime
    if (elapsedSecond + 5) > maxExecutionTime then
      return nil -- skip this part if less than 5 seconds left before timeout
    end

    local polygonData = PGC.GetCountryPolygonInfo(countryName)
    if polygonData ~= nil then
      countryPolygon = polygonData[1]
      conf.fetchedCountryPolygons[countryName] = countryPolygon
    end
  end

  return countryPolygon
end

-- get region polygon, fetches polygon data into cache and returns cached instance on second call
function GetRegionPolygon(countryName, regionName)
  if (countryName == nil) or (regionName == nil) then
    PGC.print('Warning: GetRegionPolygon() called with nil parameter!\n')
    return nil
  end

  local regionsPolygons = conf.fetchedRegionPolygons[countryName]
  if regionsPolygons == nil then
    local elapsedSecond = os.time() - startTime
    if (elapsedSecond + 5) > maxExecutionTime then
      return nil -- skip this part if less than 5 seconds left before timeout
    end

    local polygonData = PGC.GetRegionPolygonInfoFromCountry(countryName)

    regionsPolygons = {}
    conf.fetchedRegionPolygons[countryName] = regionsPolygons

    for _, polygon in ipairs(polygonData) do
      regionsPolygons[polygon.name] = polygon
    end
  end

  return regionsPolygons[regionName]
end

-- get county polygon, fetches polygon data into cache and returns cached instance on second call
function GetCountyPolygon(countryName, countyName)
  if (countryName == nil) or (countyName == nil) then
    PGC.print('Warning: GetCountyPolygon() called with nil parameter!\n')
    return nil
  end

  local countyPolygons = conf.fetchedCountyPolygons[countryName]
  if countyPolygons == nil then
    local elapsedSecond = os.time() - startTime
    if (elapsedSecond + 5) > maxExecutionTime then
      return nil -- skip this part if less than 5 seconds left before timeout
    end

    local polygonData = PGC.GetCountyPolygonInfoFromCountry(countryName)

    countyPolygons = {}
    conf.fetchedCountyPolygons[countryName] = countyPolygons

    for _, polygon in ipairs(polygonData) do
      countyPolygons[polygon.name] = polygon
    end
  end

  return countyPolygons[countyName]
end

-- get all region names for a country and then all county names for the regions
function GetFetchedRegionAndCountyNamesForCountry(countryName)
  if countryName == nil then
    PGC.print('Warning: GetFetchedRegionAndCountyNamesForCountry() called with nil parameter!\n')
    return nil
  end

  if conf.RegionAndCountyNames == nil then
    conf.RegionAndCountyNames = {}
  end

  local storage = conf.RegionAndCountyNames[countryName]

  if storage == nil then -- not yet fetched before
    storage = {}
    conf.RegionAndCountyNames[countryName] = storage
    -- get all region names for the country
    local regionNames = PGC.GetRegionNamesInCountry(countryName)
    if type(regionNames) == 'table' then
      for _, regionName in ipairs(regionNames) do
        -- get all county names for the region
        storage[regionName] = PGC.GetCountyNamesInRegion(countryName, regionName)
      end
    end
  end

  return storage
end

-- show a polygon on the map and update the outbound box of the map to include the polygon
function ShowPolygonOnMap(map, polygon, color, fillOpacity, htmlTooltip)
  if (map == nil) or (polygon == nil) then
    PGC.print('Warning: ShowPolygonOnMap() called with nil parameter!\n')
    return
  end

  local minLat = tonumber(polygon.minLat)
  local maxLat = tonumber(polygon.maxLat)
  local minLon = tonumber(polygon.minLon)
  local maxLon = tonumber(polygon.maxLon)
  if (minLat == nil) or (minLon == nil) or (maxLat == nil) or (maxLon == nil) then
    PGC.print('Warning: ShowPolygonOnMap() called with polygon that misses minLat/maxLat/minLon/maxLon!\n')
    return
  end

  if polygon.id == nil then -- show rectangle
    local vertices = {}
    table.insert(vertices, { minLat, minLon })
    table.insert(vertices, { maxLat, minLon })
    table.insert(vertices, { maxLat, maxLon })
    table.insert(vertices, { minLat, maxLon })
    polygon.id = vertices
  end

  table.insert(map.polygons, { polygon = polygon.id, color = color, fillOpacity = fillOpacity, htmlTooltip = htmlTooltip })
  UpdateOutboundBox(map, minLat, minLon, maxLat, maxLon)
end

-- show a country polygon in the given color on the map
function DrawCountryPolygon(map, color, opacity, countryName)
  if (map == nil) or (countryName == nil) then
    PGC.print('Warning: DrawCountryPolygon() called with nil parameter!\n')
    return
  end

  local countryPolygon = GetCountryPolygon(countryName)
  if countryPolygon ~= nil then
    ShowPolygonOnMap(map, countryPolygon, color, opacity, countryName)
    conf.drawnCountries = conf.drawnCountries + 1
  else
    PGC.print('DrawCountryPolygon("', countryName or "", '"): polygon not found!\n')
  end
end

-- show a region polygon in the given color on the map
function DrawRegionPolygon(map, color, opacity, countryName, regionName)
  if (map == nil) or (countryName == nil) or (regionName == nil) then
    PGC.print('Warning: DrawRegionPolygon() called with nil parameter!\n')
    return
  end

  if (regionName == '') or (not CountryHasRegions(countryName)) then
    DrawCountryPolygon(map, color, opacity, countryName)
    return
  end

  local regionPolygon = GetRegionPolygon(countryName, regionName)
  if regionPolygon ~= nil then
    ShowPolygonOnMap(map, regionPolygon, color, opacity, countryName .. ' / ' .. regionName)
    conf.drawnRegions = conf.drawnRegions + 1
  else
    PGC.print('DrawRegionPolygon("', countryName or "", '", "', regionName or "", '"): polygon not found!\n')
  end
end

-- show a county polygon in the given color on the map
-- if no county polygon exists, draw a region polygon instead (some countries don't have counties)
function DrawCountyPolygon(map, color, opacity, countryName, regionName, countyName)
  if (map == nil) or (countryName == nil) or (regionName == nil) or (countyName == nil) then
    PGC.print('Warning: DrawCountyPolygon() called with nil parameter!\n')
    return
  end

  if countyName == '' then
    DrawRegionPolygon(map, color, opacity, countryName, regionName)
    return
  end

  local countyPolygon = GetCountyPolygon(countryName, countyName)
  if countyPolygon ~= nil then
    ShowPolygonOnMap(map, countyPolygon, color, opacity, countryName .. ' / ' .. regionName .. ' / ' .. countyName)
    conf.drawnCounties = conf.drawnCounties + 1
  else
    PGC.print('DrawCountyPolygon("', countryName or "", '", "', regionName or "", '", "', countyName or "", '"): polygon not found!\n')
  end
end

-- show all passed countries in colorPassed (e.g. green) on the map
-- shows missing countries in colorMissing (e.g. red) on the map, if allowed countries are restricted
function ShowCountriesOnMap(map, result)
  if (map == nil) or (result == nil) then
    PGC.print('Warning: ShowCountriesOnMap() called with nil parameter!\n')
    return
  end

  local passedCountries = result.passedCountries
  local colorPassed = conf.colorCountryPassed
  local colorMissing = conf.colorCountryMissing
  local fillOpacity = conf.opacityCountry

  -- show passed polygons in colorPassed on the map
  for countryName, _ in pairs(passedCountries) do
    DrawCountryPolygon(map, colorPassed, fillOpacity, countryName)
  end

  -- show missing countries
  local allowedCountries = conf.allowedCountries
  if type(allowedCountries) == 'table' then
    for countryName, _ in pairs(allowedCountries) do
      if not passedCountries[countryName] then
        DrawCountryPolygon(map, colorMissing, fillOpacity, countryName)
      end
    end
  end
end

-- show all passed regions in colorPassed (e.g. green) on the map
-- shows missing regions in colorMissing (e.g. red) on the map, if allowed countries are restricted
function ShowRegionsOnMap(map, counters, result)
  if (map == nil) or (counters == nil) or (result == nil) then
    PGC.print('Warning: ShowRegionsOnMap() called with nil parameter!\n')
    return
  end

  local passedRegions = result.passedRegions
  local colorPassed = conf.colorRegionPassed
  local colorMissing = conf.colorRegionMissing
  local fillOpacity = conf.opacityRegion

  -- show passed regions in colorPassed on the map
  for _, regionCounter in pairs(passedRegions) do
    local countryName = regionCounter.countryName
    local regionName = regionCounter.regionName
    DrawRegionPolygon(map, colorPassed, fillOpacity, countryName, regionName)
    regionCounter.DrawnAsPassed = true -- remember that this region is already shown on map
  end

  -- if allowed countries are restricted, draw missing region
  local allowedCountries = conf.allowedCountries
  if (type(allowedCountries) == 'table') and (conf.regions > 0) then
    for countryName, _ in pairs(allowedCountries) do
      local countryCounter = GetCountryCounter(counters, countryName)
      local regionsAndCounties = GetFetchedRegionAndCountyNamesForCountry(countryName)
      for regionName, _ in pairs(regionsAndCounties) do
        if CanCacheBeCounted(countryName, regionName, '') then -- caches can be searched here
          local regionCounter = GetRegionCounter(countryCounter, regionName)
          if not regionCounter.DrawnAsPassed then
            DrawRegionPolygon(map, colorMissing, fillOpacity, countryName, regionName)
          end
        end
      end
    end
  end
end

-- show all passed counties in colorPassed (e.g. green) on the map
-- shows missing counties in colorMissing (e.g. red) on the map, if allowed countries are restricted
function ShowCountiesOnMap(map, counters, result)
  if (map == nil) or (counters == nil) or (result == nil) then
    PGC.print('Warning: ShowCountiesOnMap() called with nil parameter!\n')
    return
  end

  local passedCounties = result.passedCounties
  local colorPassed = conf.colorCountyPassed
  local colorMissing = conf.colorCountyMissing
  local fillOpacity = conf.opacityCounty

  -- show passed polygons in colorPassed on the map
  for _, countyCounter in pairs(passedCounties) do
    local countryName = countyCounter.countryName
    local regionName = countyCounter.regionName
    local countyName = countyCounter.countyName
    DrawCountyPolygon(map, colorPassed, fillOpacity, countryName, regionName, countyName)
    countyCounter.DrawnAsPassed = true -- remember that this county is already shown on map
  end

  -- if allowed countries are restricted, draw missing counties
  local allowedCountries = conf.allowedCountries
  if (type(allowedCountries) == 'table') and (conf.counties > 0) then
    for countryName, _ in pairs(allowedCountries) do
      local countryCounter = GetCountryCounter(counters, countryName)

      local regionsAndCounties = GetFetchedRegionAndCountyNamesForCountry(countryName)
      for regionName, countyNames in pairs(regionsAndCounties) do
        if #countyNames > 0 then -- country has counties
          for _, countyName in ipairs(countyNames) do
            if CanCacheBeCounted(countryName, regionName, countyName) then -- caches can be searched here
              local countyCounter = GetCountyCounter(countryCounter, regionName, countyName)
              if not countyCounter.DrawnAsPassed then
                DrawCountyPolygon(map, colorMissing, fillOpacity, countryName, regionName, countyName)
              end
            end
          end
        else -- country does not have counties
          local countyName = ''
          if CanCacheBeCounted(countryName, regionName, countyName) then -- caches can be searched here
            local countyCounter = GetCountyCounter(countryCounter, regionName, countyName)
            if not countyCounter.DrawnAsPassed then
              DrawCountyPolygon(map, colorMissing, fillOpacity, countryName, regionName, countyName)
            end
          end
        end
      end
    end
  end
end

-- show all passed caches on the map
function ShowCachesOnMap(map, result)
  if (map == nil) or (result == nil) then
    PGC.print('Warning: ShowCachesOnMap() called with nil parameter!\n')
    return
  end

  local passedCaches = result.passedCaches

  for gccode, cache in pairs(passedCaches) do
    table.insert(map.caches, gccode)
    UpdateOutboundBox(map, cache.latitude, cache.longitude, cache.latitude, cache.longitude)
  end
end

---------- do the actual work ----------
InitContinents()
PrepareConfig()

local fields = {'gccode', 'type', 'size', 'cache_name', 'visitdate', 'log_id', 'country', 'region', 'county'}

if conf.attributes ~= nil then
  table.insert(fields, 'attributes_set')
  table.insert(fields, 'attributes_unset')
end

if conf.showCachesOnMap then
  table.insert(fields, 'latitude')
  table.insert(fields, 'longitude')
end

if (conf.minElevation ~= nil) or (conf.maxElevation ~= nil) then
  table.insert(fields, 'elevation')
end

-- We are injecting the conf.filter variable straight into GetFinds here. This adds automatic dynamic to the checker script
local finds = PGC.GetFinds(profileId, { fields = fields, order = 'OLDESTFIRST', filter = conf.filter })
PGC.print('Got ', #finds, ' found caches\n')

-- Do calculations
local counters = {}
counters.countries = {}
counters.continents = {}
local countedCaches = {}
local duplicatedLogs = {}
local numDuplicatedLogs = 0

for idx, cache in ipairs(finds) do
  if cache.gccode == gccode then
    PGC.print('Not counting this challenge ', cache.gccode, ' towards its qualifications\n')
  elseif countedCaches[cache.gccode] == true then
    numDuplicatedLogs = numDuplicatedLogs + 1
    duplicatedLogs[cache.gccode] = true
  else
    countedCaches[cache.gccode] = true
    cache.foundNumber = idx
    AddCacheToCounters(counters, cache)
  end
end

if numDuplicatedLogs > 0 then
  PGC.print(numDuplicatedLogs, ' duplicated logs on ', Count(duplicatedLogs), ' different caches ignored\n')
end

-- debug log the found numbers
for countryName, countryCounter in pairs(counters.countries) do
  local numCaches = Count(countryCounter.caches)
  local numTypes = Count(countryCounter.types)
  local numSizes = Count(countryCounter.sizes)
  local numRegions = Count(countryCounter.regions)
  local numCounties = Count(countryCounter.counties)
  PGC.print(countryName .. ': ' .. numCaches .. ' caches, ' .. numTypes .. ' types, ' .. numSizes .. ' sizes, ' .. numRegions .. ' regions, ' .. numCounties .. ' counties\n')
end

for continentName, continentCounter in pairs(counters.continents) do
  local numCaches = Count(continentCounter.caches)
  local numTypes = Count(continentCounter.types)
  local numSizes = Count(continentCounter.sizes)
  local numCountries = Count(continentCounter.countries)
  PGC.print(continentName .. ': ' .. numCaches .. ' caches, ' .. numTypes .. ' types, ' .. numSizes .. ' sizes, ' .. numCountries .. ' countries\n')
end

local result = CheckQualifications(counters)
local ok = result.ok

-- Allow unattended checks to return without worrying about generating logs, html, or maps
if args[1].environmentSettings.cli then
  return { ok = ok }
end

-- prepare map
local map = nil

if conf.showCountriesOnMap then
  map = InitMap(map)
  ShowCountriesOnMap(map, result)
end

if conf.showRegionsOnMap then
  map = InitMap(map)
  ShowRegionsOnMap(map, counters, result)
end

if conf.showCountiesOnMap then
  map = InitMap(map)
  ShowCountiesOnMap(map, counters, result)
end

if conf.showCachesOnMap then
  map = InitMap(map)
  ShowCachesOnMap(map, result)
end

if type(conf.additionalPolygons) == 'table' then
  map = InitMap(map)
  for name, polygon in pairs(conf.additionalPolygons) do
    table.insert(map.polygons, { polygon = polygon.vertices, color = (polygon.color or 'blue'), weight = (polygon.weight or 1), opacity = (polygon.opacity or 1), htmlTooltip = name })
  end
end

if conf.drawnCountries > 0 then
  PGC.print('Showing ', conf.drawnCountries, ' country polygons on map.\n')
end

if conf.drawnRegions > 0 then
  PGC.print('Showing ', conf.drawnRegions, ' region polygons on map.\n')
end

if conf.drawnCounties > 0 then
  PGC.print('Showing ', conf.drawnCounties, ' county polygons on map.\n')
end

if (#invalidCountryNames > 0) or (#invalidRegionNames > 0) or (#invalidCountyNames > 0) then
  table.insert(result.html, '<h1>Warning: invalid checker configuration!</h1>')
  for _, name in ipairs(invalidCountryNames) do
    table.insert(result.html, 'Country "' .. name .. '" does not exist!<br>')
  end

  for _, name in ipairs(invalidRegionNames) do
    table.insert(result.html, 'Region "' .. name .. '" does not exist!<br>')
  end

  for _, name in ipairs(invalidCountyNames) do
    table.insert(result.html, 'County "' .. name .. '" does not exist!<br>')
  end
end

local log = table.concat(result.log, '\n')
local html = table.concat(result.html, '')

return { ok = result.ok, log = log, html = html, map = map }
