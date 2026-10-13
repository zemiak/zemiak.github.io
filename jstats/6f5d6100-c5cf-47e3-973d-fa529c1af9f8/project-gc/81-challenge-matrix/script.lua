--[[
Parameters:
"same": { [optional] can be used when the check shall be repeated over all properties of a certain field and must pass some number of times
  "field": [string] cache property for whose values the test shall be repeated. Each test is using only caches with the same value.
  "limit": [int, default: 1] number of field values for which the tests must pass to pass the entire challenge
  "num_hints": [int, default: 0] when the challenge fails, a total of "limit" + "num_hints" best results are printed to give additional options to work on your qualification
  "combine_results": [bool, default: false] when true, the achieved results over all values are combined and only a single test is done on the overall test results
                     Adds values for testing "conditions". "unique_entries" needs to be passed only once to count as overall passed.
                     When this flag is true, "limit" specifies how many grids shall be shown in the output (to prevent that output gets too big for too many grids). 0 means all.
  "sort": optional sorting order "A-Z" or "Z-A" for passed or combined tests. Defaults to "A-Z".
          When "combine_results" is not used, the hints are sorted by "closest to pass" independently of this sort order
  "showAllTestResults": [bool, default: false] when true, all test runs are performed instead of stopping once the challenge has passed (unless the script aborts due to timeout);
                         the output then always shows every passed and partial result, whether or not the challenge passed overall. Has no effect when "combine_results" is used.
                         Only the first "limit" of the displayed results are written to the plain-text "log" output (in display order); "html" always shows every displayed result.
},
"conditions": {
  "entries": [int], number of DT combinations with at least "minValue" found caches
  "loops": [int], number of needed loops
  "loopsPer": [int] You need one loop per loopsPer finds more than specified in "loops" (for loops=1 and loopsPer=1000 and 2300 finds you need 3 loops)

  "vertical": 1..9 (unlimited when combine_results is used) number of vertical lines (lines with equal T value)
  "horizontal": 1..9 (unlimited when combine_results is used) number of horizontal lines (lines with equal D value)
  "vertical_horizontal": 1..18, (unlimited when combine_results is used) numbers vertical and/or horizontal (any non diagonal)

  "left_diagonal": 1 (unlimited when combine_results is used), diagonal line with D=T
  "right_diagonal": 1 (unlimited when combine_results is used), diagonal line from 5/1 to 1/5
  "diagonal": 1..2 (unlimited when combine_results is used) number of diagonal lines

  "total_lines": 1..20, (unlimited when combine_results is used) total numbers of lines

  "vertical_sum": 1..9 (unlimited when combine_results is used) number of vertical lines (lines with equal T value) that have the required sum
  "horizontal_sum": 1..9 (unlimited when combine_results is used) number of horizontal lines (lines with equal D value) that have the required sum
  "vertical_horizontal_sum": 1..18, (unlimited when combine_results is used) numbers vertical and/or horizontal (any non diagonal) that have the required sum
  "total_lines_sum": 1..20, (unlimited when combine_results is used) total numbers of lines that have the required sum

  "total": [int], total number of caches in enabled cells that must have been found
  "passedEntriesTotal": [int], total number of caches in passed cells that must have been found

  "line2_sum_min": [number] the sum over the line 2 value in each entry must be at least the given value (i.e. sum of FPs)
  "line2_sum_max": [number] the sum over the line 2 value in each entry must not exceed the given value (i.e. sum of lowest elevations)

  "unique_entries": [int] number of entries for which a cache property (e.g. "type") must be unique (see "unique_entry_property")
},
"constraints": { optional additional constraints can be defined that "entries" need to fulfill, e.g. use a single type only for a certain number of DTs
  -- mutually exclusive with "diversityConstraints"
  "field": [string] the field whose values shall be constrained, e.g. "type"
  "maxRepeatedValueTotal": [int, default: 81] the number how often the same value can appear in total in the matrix
  "maxRepeatedValuePerHorizontal": [int, default: 9] the number how often the same value can appear in a horizontal
  "maxRepeatedValuePerVertical": [int, default: 9] the number how often the same value can appear in a vertical
},
"diversityConstraints": { optional constraint requiring a minimum diversity of a cache property among "entries", e.g. require using at least 3 different types
  -- mutually exclusive with "constraints". At least one of the three minDifferentValues* settings below must be set, but not necessarily all of them.
  "field": [string] the field whose values shall be diversified, e.g. "type"
  "minDifferentValuesTotal": [int] the minimum number of different values that must appear across the whole grid
  "minDifferentValuesPerHorizontal": [int] the minimum number of different values that must appear in each horizontal (row with equal D)
  "minDifferentValuesPerVertical": [int] the minimum number of different values that must appear in each vertical (column with equal T)
},
"minValue": [int, default: 1], only cells with this many finds are counted as "passed entry"
"minValue": [10, 20, 50, 100, 500, 1000] -- find entries with these minimum values anywhere in the grid
                 -- Note: any enabled cell not covered by this list gets no requirement of its own and can then never
                 -- count as "passed" -- do not combine this flat-list form with completed line conditions ("vertical" / "horizontal" / 
                 -- "diagonal" / ...) unless every enabled cell is covered by the list
"minValue": [
  [50,  1,  1,  1,  1,  1,  1,  1, 50],
  [ 1, 50,  1,  1,  1,  1,  1, 50,  1],
  [ 1,  1, 50,  1,  1,  1, 50,  1,  1],
  [ 1,  1,  1, 50,  1, 50,  1,  1,  1],
  [ 1,  1,  1,  1, 50,  1,  1,  1,  1],
  [ 1,  1,  1, 50,  1, 50,  1,  1,  1],
  [ 1,  1, 50,  1,  1,  1, 50,  1,  1],
  [ 1, 50,  1,  1,  1,  1,  1, 50,  1],
  [50,  1,  1,  1,  1,  1,  1,  1, 50]
],
"mask": [
  "100000001",
  "010000010",
  "001000100",
  "000101000",
  "000010000",
  "000101000",
  "001000100",
  "010000010",
  "100000001"
],
"minSum": [int], minimum value for the sum in a line to make the line count
"sumOnlyPassedEntries": [bool] when true, only passed entries (cells with at least "minValue" finds) are counted for the line sum, otherwise all entries in the line are counted
"showSums": [bool, default: true] when set to false, the sums on the right and bottom are not shown
"cell_format_line1": [string, default: "n"] the output format of the cell, typically one of "n", "gccode", "gccode_with_n" or any other of the known fields. This line is linked to the cache page unless links are disabled.
"cell_format_line2": [string, default: not used] 2nd line in a cell, one of e.g. "type", "size", "favorite_points" or any other of the known fields
"sort_by_line2": [string, optional] "less" or "greater"
"line2_sum_all_entries": [bool, default: false] when true, all found entries are used for the sum, when false only the best required "entries" number of entries will be summed up
"unique_entry_property": [string, optional] cache property that must be different in "unique_entries" entries, e.g. 9 of the D/T combinations must be filled with different types
"unique_passed_entries_only": [bool, default: false] when true, only caches found in passed entries (see "minValue") are considered for "unique_entries", instead of all caches found in enabled entries
"showAsIcon": [bool] when true, "type", "size" and "country" will be shown as an icon (useful with "unique_entry_property", where the log shall contain type/size/country as text)

Parameters for map polygons drawn via DrawCountryPolygon() / DrawRegionPolygon() / DrawCountyPolygon():
"colorCountyPassed": [string, default: '#00C000'] fill color of a county polygon when "passed" is true
"colorCountyMissing": [string, default: '#C00000'] fill color of a county polygon when "passed" is false
"colorRegionPassed": [string, default: '#008040'] fill color of a region polygon when "passed" is true
"colorRegionMissing": [string, default: '#800040'] fill color of a region polygon when "passed" is false
"colorCountryPassed": [string, default: '#006030'] fill color of a country polygon when "passed" is true
"colorCountryMissing": [string, default: '#600030'] fill color of a country polygon when "passed" is false
"opacityCounty": [number, default: 0.15] fill opacity of a county polygon
"opacityRegion": [number, default: 0.1] fill opacity of a region polygon
"opacityCountry": [number, default: 0.1] fill opacity of a country polygon
Those polygons are shown when "unique_entry_property" is country / region / unique_region / county / unique_county.
"showMap": [boolean, default: true] when set to false, no polygons or caches are drawn on the map

"ElevationBands": optional non-empty array of elevations (m or feet) as whole numbers, needed when 'elevation_band' or 'elevation_band_ft' is used. Values must be configured in ascending order.
"links": [boolean, default: true] When caches are printed in the HTML Script output, GC-codes and visit dates are linked to the cache page or log page
"showFiltersInExampleLog": [boolean, default: true] when set to false, the configured filters are only shown in the HTML output, not in the plain-text example log
"GetHides": [boolean, default: false] when set to true, hidden caches are used instead of found caches. Attention: not all filters work for this
"weekStartsOnMonday": [boolean, default: false] when set to true, weekday name are sorted starting with Monday and "visit_weekn" / "hidden_weekn" / "publish_weekn" also start on Monday
"ShowTimeZoneDefinitions": [boolean, default: false] when set to true, a list of all time zones and the countries/regions used to determine them is printed to the HTML output
"ShowContinentDefinitions": [boolean, default: false] when set to true, a list of all continents and the countries/regions used to determine them is printed to the HTML output
"continent_remap": [optional] object mapping a continent name to an array of countries to (re)assign to that continent; each country is removed from wherever it was previously assigned first.
                   Each array element is either a country name, or an object mapping one country to its list of regions on that continent (same "country" vs. "country = {region1, region2}" shape as the built-in continent definitions), e.g.:
{
  "Europe": ["Greenland", "Spain"],
  "Africa": ["Egypt", {"Spain": ["Islas Canarias"]}]
}
"debug": [boolean, default: false] when set to true, additional information is printed to the debug output

Parameters for filtering of caches:
"country" (string or array of strings): only finds in the listed countries will count (default: no restriction), supports PGC continents: "PGC.Europe", "PGC.Asia", "PGC.Africa",
  "PGC.Central America", "PGC.Oceania", "PGC.North America", "PGC.South America", "PGC.Antarctic and subantarctic islands"
"excludedCountry" (string or array of strings): finds in the listed countries will NOT count (default: no restriction)
"excludeMostFoundCountry": when set to true, the country with most finds gets excluded

"region" (string or array of strings): only finds in the listed regions will count (default: no restriction)
"excludedRegion" (string or array of strings): finds in the listed regions will NOT count (default: no restriction)

"county" (string or array of strings): only finds in the listed counties will count (default: no restriction)
"excludedCounty" (string or array of strings): finds in the listed counties will NOT count (default: no restriction)

"minVisitDate" (string): YYYY-MM-DD, the date will be included, ie: >= date; can be a dynamic offset like "5 years ago"
"maxVisitDate" (string): YYYY-MM-DD, the date will be included, ie: <= date; can be a dynamic offset like "5 years ago"
"minHiddenDate" (string): YYYY-MM-DD, the date will be included, ie: >= date; can be a dynamic offset like "5 years ago"
"maxHiddenDate" (string): YYYY-MM-DD, the date will be included, ie: <= date; can be a dynamic offset like "5 years ago"

"monthnames" (string or array of strings): List of January/February/March/April/May/June/July/August/September/October/November/December
"daynames" (string or array of strings): List of Monday/Tuesday/Wednesday/Thursday/Friday/Saturday/Sunday

"types" (string or array of strings): only finds of the listed types will count (default: no restriction)
"excludedTypes" (string or array of strings): finds of the listed types will NOT count (default: no restriction)
Both properties accept standard cache types as well as 'Events' and 'Physical'.

"sizes" (string or array of strings): only finds of the listed sizes will count (default: no restriction)
"excludedSizes" (string or array of strings): finds of the listed sizes will NOT count (default: no restriction)

"difficulties" (number or array of numbers): only finds of the listed difficulties will count (default: no restriction)
"excludedDifficulties" (number or array of numbers): finds of the listed difficulties will NOT count (default: no restriction)

"terrains" (number or array of numbers): only finds of the listed terrains will count (default: no restriction)
"excludedTerrains" (number or array of numbers): finds of the listed terrains will NOT count (default: no restriction)

"minFavoritePoints" (int): Minimum amount of favorite points required

"minElevation" (int): minimum elevation in meters required (value included)
"maxElevation" (int): maximum elevation in meters required (value included)
"minElevation_ft" (int): same as "minElevation", but in feet
"maxElevation_ft" (int): same as "maxElevation", but in feet

"attribute": attribute number 1..96, only caches with this attribute will count (use -1..-96 or 97..192 for negative attribute)
"excludedAttribute": attribute number 1..96, caches with this attribute will NOT count (use -1..-96 or 97..192 for negative attribute)

"excludeTravelingGeocaches": do not count caches on the official "Caches Excluded from Souvenirs and Statistics" list (https://www.geocaching.com/plan/lists/BMAFMJR) (default: false)
"excludeDupFinds": ignore duplicated finds of the same cache (default: true)
"includeLabCaches": true or false
"excludedCaches" (string or array of strings): optional GC code(s) that shall be ignored (default: none). The GC code of the challenge for which a checker is created is excluded automatically.

"filters": optional array of filters that all have to be fulfilled (AND filters). Instead of a single filter you can add another array [] to switch between AND and OR filtering
  Each individual filter is an object with the following properties:
  "field": the cache field that shall be tested (either an original PGC.GetFinds() field or one of the "known_fields" macros)
  "include": value or array of values, the field of the cache must have one of these values
  "exclude": value or array of values, the field of the cache must NOT have any of these values
  When "field" is "type", "include" and "exclude" also accept 'Events' and 'Physical' in addition to standard cache types.
  When "field" is "attribute", "include" and "exclude" instead contain attribute number(s) (1..96 for positive, -1..-96 or 97..192 for negative attributes), and the cache is checked via HasAttribute() for having at least one of them.
  Unlike every other "field", "include" and "exclude" may be combined when "field" is "attribute" (since a cache can have several attributes at once): the cache fails when "include" is set and none of its attributes are present, then (if not already failed) fails when "exclude" is set and at least one of its attributes is present, and passes otherwise.
  When "field" is "attribute", only "include"/"exclude" are supported; "min", "max", "op" and "field2" are not.
  "min": the minimum value that the field must have
  "max": the maximum value that the field must have
  You can use "min" and "max" together or only one of them.
  If both "min" and the field of the cache are strings, they are compared as strings. If one of them is a number, the other will also be converted to a number for the comparison. When this conversion results in a nil value, the filter treats the comparison as failed.
  The same applies to "max".
  "op": optional operator to compare the value of "field" with the value of "field2". Can be one of: "EQ" (equals), "NE" (not equals), "GT" (greater than), "GE" (greater than or equal), "LT" (less than), "LE" (less than or equal)
  "field2": the 2nd cache field that shall be compared when using "op"
]]
--------------- global variables ---------------
local args = {...}
local conf = args[1].config
local profileName = args[1].profileName
local profileId = args[1].profileId
local gccode = args[1].gccode -- gccode from the tag
PGC.print('Got profile name, ', profileName, '\n')

local userSetExcludeTravelingGeocaches = (conf.excludeTravelingGeocaches ~= nil)

-- need to use os.time() to determine elapsed runtime, as PGC.GetCPUUsage() doesn't return useful data to prevent checker timeout
local startTime = os.time()
local maxExecutionTime = args[1].environmentSettings.maxExecutionTime

local datetoday = Date {}
local isotoday = string.format('%04d-%02d-%02d', datetoday.tab.year, datetoday.tab.month, datetoday.tab.day)

-- background colors for table cells to visualize different conditions
local colors = {
  gray1     = '#f2f3f5',
  gray2     = '#cfd2d6',
  failed1   = '#f1aeb5',
  progress1 = '#ffe69c',
  passed1   = '#a9dfbf',
  selected1 = '#81c784',
  failed2   = '#f8d7da',
  progress2 = '#fff3cd',
  passed2   = '#d4edda',
  stripe1Even = '#e1e9ff',
  stripe1Odd  = '#d2ddff',
  stripe2Even = '#e2f5ea',
  stripe2Odd  = '#d2eedf'
}

-- cache types that are regarded to be an event by geocaching.com
local macro_events = 'Events'
local event_types = { 'Event Cache', 'Cache In Trash Out Event', 'Mega-Event Cache', 'Giga-Event Cache', 'Community Celebration Event', 'Geocaching HQ Block Party', 'Geocaching HQ Celebration' }
-- cache types that have a container with a logbook
local macro_physical = 'Physical'
local physical_types = { 'Traditional Cache', 'Mystery Cache', 'Multi-Cache', 'Letterbox Hybrid', 'Wherigo Cache', 'Project A.P.E. Cache', 'Geocaching HQ Cache' }

local type_Labcache = 'Lab Cache'
local all_types = { macro_physical, 'Traditional Cache', 'Multi-Cache', 'Mystery Cache', 'Letterbox Hybrid', 'Wherigo Cache', 'EarthCache', 'Virtual Cache', 'Webcam Cache', macro_events, 'Event Cache', 'Cache In Trash Out Event', 'Mega-Event Cache', 'Giga-Event Cache', 'Community Celebration Event', 'Geocaching HQ Block Party', 'Geocaching HQ Celebration', 'GPS Adventures Maze Exhibit', 'Project A.P.E. Cache', 'Geocaching HQ Cache', 'Locationless Cache', type_Labcache }
local all_types_sort_index = {}

local all_sizes = { 'Micro', 'Small', 'Regular', 'Large', 'Other', 'Virtual', 'Not chosen' }
local all_sizes_sort_index = {}

local all_ratings = { 1.0, 1.5, 2.0, 2.5, 3.0, 3.5, 4.0, 4.5, 5.0 }

local daynames_long = { 'Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday' }
local daynames_short = { 'Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat' }
local daynames_sort_index = {}

local monthnames_long = { 'January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December' }
local monthnames_short = { 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec' }
local monthnames_sort_index = {}

local days_in_month = { 31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 }

-- the 38 common IANA time zones (distinct standard UTC offsets in current use worldwide), each mapped to its countries.
-- a country that spans multiple time zones is listed without a region in the time zone where most of its regions are (its "default" time zone).
-- in every other time zone it has regions in, it's listed as ['country'] = { 'region1', 'region2', ... }.
-- when even a single region isn't small enough (i.e. it itself spans multiple time zones), specific counties of that country can be carved out as
-- an unnamed nested table: ['country'] = { 'region1', { 'county1', 'county2' } }. A county entry always takes priority over a region entry, which
-- always takes priority over the country's default. Converted into 'timezones_lookup' in Initialize_GlobalVariables().
local timezones = {
  -- ['UTC-12:00 (Etc/GMT+12)'] = {},
  ['UTC-11:00 (Pacific/Pago_Pago)'] = { 'American Samoa', 'Niue', ['US Minor Outlying Islands'] = { { 'Midway Atoll' } } },
  ['UTC-10:00 (Pacific/Honolulu)'] = { 'Cook Islands', 'French Polynesia', ['US Minor Outlying Islands'] = { { 'Johnston Atoll' } }, ['United States'] = { 'Hawaii' } },
  ['UTC-09:30 (Pacific/Marquesas)'] = { ['French Polynesia'] = { 'Marquises' } },
  ['UTC-09:00 (America/Anchorage)'] = { ['French Polynesia'] = { { 'Gambier' } }, ['United States'] = { 'Alaska' } },
  ['UTC-08:00 (America/Los_Angeles)'] = { ['Mexico'] = { 'Baja California' }, 'Pitcairn', ['United States'] = { 'California', 'Nevada', 'Oregon', 'Washington', { 'Benewah County (ID)', 'Bonner County (ID)', 'Boundary County (ID)', 'Clearwater County (ID)', 'Idaho County (ID)', 'Kootenai County (ID)', 'Latah County (ID)', 'Lewis County (ID)', 'Nez Perce County (ID)', 'Shoshone County (ID)' } } },
  ['UTC-07:00 (America/Denver)'] = { 'Canada', ['Canada'] = { { 'Kitikmeot' } }, ['Mexico'] = { 'Baja California Sur', 'Chihuahua', 'Nayarit', 'Sinaloa', 'Sonora' }, ['United States'] = { 'Arizona', 'Colorado', 'Idaho', 'Montana', 'New Mexico', 'Utah', 'Wyoming', { 'Adams County (ND)', 'Arthur County (NE)', 'Banner County (NE)', 'Bennett County (SD)', 'Billings County (ND)', 'Bowman County (ND)', 'Box Butte County (NE)', 'Butte County (SD)', 'Chase County (NE)', 'Cherry County (NE)', 'Cheyenne County (NE)', 'Corson County (SD)', 'Custer County (SD)', 'Dawes County (NE)', 'Deuel County (NE)', 'Dewey County (SD)', 'Dundy County (NE)', 'El Paso County (TX)', 'Fall River County (SD)', 'Garden County (NE)', 'Golden Valley County (ND)', 'Grant County (ND)', 'Grant County (NE)', 'Greeley County (KS)', 'Haakon County (SD)', 'Hamilton County (KS)', 'Harding County (SD)', 'Hettinger County (ND)', 'Hooker County (NE)', 'Hudspeth County (TX)', 'Jackson County (SD)', 'Keith County (NE)', 'Kimball County (NE)', 'Lawrence County (SD)', 'Malheur County (OR)', 'Meade County (SD)', 'Morrill County (NE)', 'Oglala Lakota County (SD)', 'Pennington County (SD)', 'Perkins County (NE)', 'Perkins County (SD)', 'Scotts Bluff County (NE)', 'Sheridan County (NE)', 'Sherman County (KS)', 'Sioux County (NE)', 'Slope County (ND)', 'Stark County (ND)', 'Wallace County (KS)', 'Ziebach County (SD)' } } },
  ['UTC-06:00 (America/Chicago)'] = { 'Belize', ['Canada'] = { 'Manitoba', 'Saskatchewan', { 'East Kootenay', 'Kenora', 'Kivalliq', 'Rainy River' } }, ['Chile'] = { { 'Isla de Pascua' } }, 'Costa Rica', ['Ecuador'] = { 'Galápagos' }, 'El Salvador', 'Guatemala', 'Honduras', 'Mexico', 'Nicaragua', ['United States'] = { 'Alabama', 'Arkansas', 'Illinois', 'Iowa', 'Kansas', 'Louisiana', 'Minnesota', 'Mississippi', 'Missouri', 'Nebraska', 'North Dakota', 'Oklahoma', 'South Dakota', 'Tennessee', 'Texas', 'Wisconsin', { 'Adair County (KY)', 'Allen County (KY)', 'Ballard County (KY)', 'Barren County (KY)', 'Bay County (FL)', 'Breckinridge County (KY)', 'Butler County (KY)', 'Caldwell County (KY)', 'Calhoun County (FL)', 'Calloway County (KY)', 'Carlisle County (KY)', 'Christian County (KY)', 'Clinton County (KY)', 'Crittenden County (KY)', 'Cumberland County (KY)', 'Daviess County (KY)', 'Dickinson County (MI)', 'Edmonson County (KY)', 'Escambia County (FL)', 'Fulton County (KY)', 'Gibson County (IN)', 'Gogebic County (MI)', 'Graves County (KY)', 'Grayson County (KY)', 'Green County (KY)', 'Gulf County (FL)', 'Hancock County (KY)', 'Hart County (KY)', 'Henderson County (KY)', 'Hickman County (KY)', 'Holmes County (FL)', 'Hopkins County (KY)', 'Iron County (MI)', 'Jackson County (FL)', 'Jasper County (IN)', 'Lake County (IN)', 'LaPorte County (IN)', 'Livingston County (KY)', 'Logan County (KY)', 'Lyon County (KY)', 'McCracken County (KY)', 'McLean County (KY)', 'Marshall County (KY)', 'Menominee County (MI)', 'Metcalfe County (KY)', 'Monroe County (KY)', 'Muhlenberg County (KY)', 'Newton County (IN)', 'Ohio County (KY)', 'Okaloosa County (FL)', 'Perry County (IN)', 'Porter County (IN)', 'Posey County (IN)', 'Russell County (KY)', 'Santa Rosa County (FL)', 'Simpson County (KY)', 'Spencer County (IN)', 'Starke County (IN)', 'Todd County (KY)', 'Trigg County (KY)', 'Union County (KY)', 'Vanderburgh County (IN)', 'Walton County (FL)', 'Warren County (KY)', 'Warrick County (IN)', 'Washington County (FL)', 'Webster County (KY)' } } },
  ['UTC-05:00 (America/New_York)'] = { 'Bahamas', ['Brazil'] = { 'Acre' }, ['Canada'] = { 'Québec', 'Ontario', 'Nunavut' }, 'Cayman Islands', 'Colombia', 'Cuba', 'Ecuador', 'Haiti', 'Jamaica', ['Mexico'] = { 'Quintana Roo' }, 'Panama', 'Peru', 'Turks and Caicos Islands', 'United States' },
  ['UTC-04:00 (America/Halifax)'] = { 'Anguilla', 'Antigua and Barbuda', 'Aruba', 'Barbados', 'Bermuda', 'Bolivia', 'Bonaire, Sint Eustatius and Saba', ['Brazil'] = { 'Amazonas', 'Mato Grosso', 'Mato Grosso do Sul', 'Rondônia', 'Roraima' }, 'British Virgin Islands', ['Canada'] = { 'Nova Scotia', 'Prince Edward Island', 'New Brunswick', { 'Labrador', 'Le Golfe-du-Saint-Laurent', 'Les Îles-de-la-Madeleine' } }, 'Chile', 'Curaçao', 'Dominica', 'Dominican Republic', 'Grenada', ['Greenland'] = { { 'Pituffik' } }, 'Guadeloupe', 'Guyana', 'Martinique', 'Montserrat', 'Paraguay', 'Puerto Rico', 'Saint Barthélemy', 'Saint Kitts and Nevis', 'Saint Lucia', 'Saint Martin', 'Saint Vincent and the Grenadines', 'Sint Maarten', 'Trinidad and Tobago', 'US Virgin Islands', 'Venezuela' },
  ['UTC-03:30 (America/St_Johns)'] = { ['Canada'] = { 'Newfoundland and Labrador' } },
  ['UTC-03:00 (America/Sao_Paulo)'] = { 'Argentina', 'Brazil', 'Falkland Islands', 'French Guiana', 'Saint Pierre and Miquelon', 'Suriname', 'Uruguay' },
  ['UTC-02:00 (America/Noronha)'] = { 'Greenland', 'South Georgia and the South Sandwich Islands' },
  ['UTC-01:00 (Atlantic/Azores)'] = { 'Cabo Verde', ['Portugal'] = { 'Arquipélago dos Açores' }, ['Saint Helena'] = { 'Tristan da Cunha' } },
  ['UTC+00:00 (Europe/London)'] = { 'Bouvet Island', 'Burkina Faso', "Côte d'Ivoire", 'Faroe Islands', 'Gambia', 'Ghana', ['Greenland'] = { { 'Unincorporated area' } }, 'Guernsey', 'Guinea', 'Guinea-Bissau', 'Iceland', 'Ireland', 'Isle of Man', 'Jersey', 'Liberia', 'Mali', 'Mauritania', 'Portugal', 'Saint Helena', 'Sao Tome and Principe', 'Sark', 'Senegal', 'Sierra Leone', ['Spain'] = { 'Islas Canarias' }, 'Togo', 'United Kingdom' },
  ['UTC+01:00 (Europe/Paris)'] = { 'Albania', 'Algeria', 'Andorra', 'Angola', 'Austria', 'Belgium', 'Benin', 'Bosnia and Herzegovina', 'Cameroon', 'Central African Republic', 'Chad', 'Congo', 'Croatia', 'Czechia', ['Democratic Republic of the Congo'] = { 'Bandundu', 'Kasaï-Occidental', 'Kinshasa', 'Kongo-Central', 'Équateur' }, 'Denmark', 'Equatorial Guinea', 'France', 'Gabon', 'Germany', 'Gibraltar', 'Hungary', 'Italy', 'Liechtenstein', 'Luxembourg', 'Malta', 'Monaco', 'Montenegro', 'Morocco', 'Netherlands', 'Niger', 'Nigeria', 'North Macedonia', 'Norway', 'Poland', 'San Marino', 'Serbia', 'Slovakia', 'Slovenia', 'Spain', 'Svalbard and Jan Mayen Islands', 'Sweden', 'Switzerland', 'Tunisia', 'Vatican City State', 'Western Sahara' },
  ['UTC+02:00 (Europe/Helsinki)'] = { 'Åland Islands', 'Botswana', 'Bulgaria', 'Burundi', 'Cyprus', 'Democratic Republic of the Congo', 'Egypt', 'Estonia', 'Eswatini', 'Finland', 'Greece', 'Israel', 'Latvia', 'Lebanon', 'Lesotho', 'Libya', 'Lithuania', 'Malawi', 'Moldova', 'Mozambique', 'Namibia', 'Palestine', 'Romania', ['Russia'] = { { 'Kaliningrad' } }, 'Rwanda', 'South Africa', 'South Sudan', 'Sudan', 'Ukraine', 'Zambia', 'Zimbabwe' },
  ['UTC+03:00 (Europe/Moscow)'] = { 'Bahrain', 'Belarus', 'Comoros', ['Cyprus'] = { 'Northern Cyprus' }, 'Djibouti', 'Eritrea', 'Ethiopia', 'Iraq', 'Jordan', 'Kenya', 'Kuwait', 'Madagascar', 'Mayotte', 'Qatar', 'Russia', 'Saudi Arabia', 'Somalia', 'Syria', 'Tanzania', 'Türkiye', 'Uganda', 'Yemen' },
  ['UTC+03:30 (Asia/Tehran)'] = { 'Iran' },
  ['UTC+04:00 (Asia/Dubai)'] = { 'Armenia', 'Azerbaijan', 'Georgia', 'Mauritius', 'Oman', 'Réunion', ['Russia'] = { { 'Astrakhan Oblast', 'Samara Oblast', 'Saratov Oblast', 'Udmurtia', 'Ulyanovsk Oblast' } }, 'Seychelles', 'United Arab Emirates' },
  ['UTC+04:30 (Asia/Kabul)'] = { 'Afghanistan' },
  ['UTC+05:00 (Asia/Karachi)'] = { 'French Southern and Antarctic Territories', 'Heard Island and McDonald Islands', 'Kazakhstan', 'Maldives', 'Pakistan', ['Russia'] = { 'Ural Federal District', { 'Bashkortostan', 'Orenburg Oblast', 'Perm Krai' } }, 'Tajikistan', 'Turkmenistan', 'Uzbekistan' },
  ['UTC+05:30 (Asia/Kolkata)'] = { 'India', 'Sri Lanka' },
  ['UTC+05:45 (Asia/Kathmandu)'] = { 'Nepal' },
  ['UTC+06:00 (Asia/Dhaka)'] = { 'Bangladesh', 'Bhutan', 'British Indian Ocean Territory', 'Kyrgyzstan', ['Russia'] = { { 'Omsk Oblast' } } },
  ['UTC+06:30 (Asia/Yangon)'] = { 'Cocos (Keeling) Islands', 'Myanmar' },
  ['UTC+07:00 (Asia/Bangkok)'] = { 'Cambodia', 'Christmas Island', ['Indonesia'] = { 'Jawa', 'Sumatra', { 'Kalimantan Barat', 'Kalimantan Tengah' } }, 'Laos', ['Mongolia'] = { 'Bayan-Ölgii', 'Khovd', 'Uvs' }, ['Russia'] = { 'Siberian Federal District' }, 'Thailand', 'Vietnam' },
  ['UTC+08:00 (Asia/Shanghai)'] = { ['Australia'] = { 'Western Australia' }, 'Brunei', 'China', 'Hong Kong', 'Indonesia', 'Macao', 'Malaysia', 'Mongolia', 'Philippines', ['Russia'] = { { 'Buryatia', 'Irkutsk Oblast', 'Zabaykalsky Krai' } }, 'Singapore', 'Taiwan' },
  -- ['UTC+08:45 (Australia/Eucla)'] = {},
  ['UTC+09:00 (Asia/Tokyo)'] = { ['Indonesia'] = { 'Kepulauan Maluku', 'Papua' }, 'Japan', 'North Korea', 'Palau', ['Russia'] = { { 'Amur Oblast', 'Sakha Republic' } }, 'South Korea', 'Timor-Leste' },
  ['UTC+09:30 (Australia/Darwin)'] = { ['Australia'] = { 'Northern Territory', 'South Australia' } },
  ['UTC+10:00 (Australia/Brisbane)'] = { 'Australia', 'Guam', 'Micronesia', 'Northern Mariana Islands', 'Papua New Guinea', ['Russia'] = { 'Far Eastern Federal District' } },
  -- ['UTC+10:30 (Australia/Lord_Howe)'] = {},
  ['UTC+11:00 (Pacific/Guadalcanal)'] = { ['Micronesia'] = { 'Kosrae', 'Pohnpei' }, 'New Caledonia', 'Norfolk Island', ['Papua New Guinea'] = { { 'Bougainville' } }, ['Russia'] = { { 'Magadan Oblast', 'Sakhalin Oblast' } }, 'Solomon Islands', 'Vanuatu' },
  ['UTC+12:00 (Pacific/Auckland)'] = { 'Fiji', 'Kiribati', 'Marshall Islands', 'Nauru', 'New Zealand', ['Russia'] = { { 'Chukotka Autonomous Okrug', 'Kamchatka Krai' } }, 'Tuvalu', 'US Minor Outlying Islands', 'Wallis and Futuna Islands' },
  ['UTC+12:45 (Pacific/Chatham)'] = { ['New Zealand'] = { 'Chatham Islands' } },
  ['UTC+13:00 (Pacific/Tongatapu)'] = { ['Kiribati'] = { 'Phoenix Islands' }, 'Samoa', 'Tokelau', 'Tonga' },
  ['UTC+14:00 (Pacific/Kiritimati)'] = { ['Kiribati'] = { 'Line Islands' } }
}
local timezones_lookup = {} -- built from 'timezones' in Initialize_GlobalVariables()
local timezones_sort_index = {} -- built from 'timezones' in Initialize_GlobalVariables(), used by TimezoneLess()/TimezoneGreater()

-- continents list countries that mostly belong to that continent from the geographical point of view. For some countries that span more than 1 continent, some regions on the second continent are defined
local continents = {
  ["Europe"] = { "Åland Islands", "Albania", "Andorra", "Austria", "Belarus", "Belgium", "Bosnia and Herzegovina", "Bulgaria", "Croatia", "Czechia", "Denmark", "Estonia", "Faroe Islands", "Finland", "France", "Germany", "Gibraltar", "Greece", "Guernsey", "Hungary", "Iceland", "Ireland", "Isle of Man", "Italy", "Jersey", "Latvia", "Liechtenstein", "Lithuania", "Luxembourg", "Malta", "Moldova", "Monaco", "Montenegro", "Netherlands", "North Macedonia", "Norway", "Poland", "Portugal", "Romania", "Russia", "San Marino", "Sark", "Serbia", "Slovakia", "Slovenia", "Spain", "Svalbard and Jan Mayen Islands", "Sweden", "Switzerland", "Ukraine", "United Kingdom", "Vatican City State" },
  ["North America"] = { "Anguilla", "Antigua and Barbuda", "Bahamas", "Barbados", "Belize", "Bermuda", "British Virgin Islands", "Canada", "Cayman Islands", "Costa Rica", "Cuba", "Dominica", "Dominican Republic", "El Salvador", "Greenland", "Grenada", "Guadeloupe", "Guatemala", "Haiti", "Honduras", "Jamaica", "Martinique", "Mexico", "Montserrat", "Nicaragua", "Panama", "Puerto Rico", "Saint Barthélemy", "Saint Kitts and Nevis", "Saint Lucia", "Saint Martin", "Saint Pierre and Miquelon", "Saint Vincent and the Grenadines", "Sint Maarten", "Turks and Caicos Islands", "United States", "US Virgin Islands" },
  ["South America"] = { "Argentina", "Aruba", "Bolivia", "Bonaire, Sint Eustatius and Saba", "Brazil", "Chile", "Colombia", "Curaçao", "Ecuador", "Falkland Islands", "French Guiana", "Guyana", "Paraguay", "Peru", "South Georgia and the South Sandwich Islands", "Suriname", "Trinidad and Tobago", "Uruguay", "Venezuela" },
  ["Africa"] = { "Algeria", "Angola", "Benin", "Botswana", "Burkina Faso", "Burundi", "Cabo Verde", "Cameroon", "Central African Republic", "Chad", "Comoros", "Congo", "Côte d'Ivoire", "Democratic Republic of the Congo", "Djibouti", "Egypt", "Equatorial Guinea", "Eritrea", "Eswatini", "Ethiopia", "Gabon", "Gambia", "Ghana", "Guinea", "Guinea-Bissau", "Kenya", "Lesotho", "Liberia", "Libya", "Madagascar", "Malawi", "Mali", "Mauritania", "Mauritius", "Mayotte", "Morocco", "Mozambique", "Namibia", "Niger", "Nigeria", ["Portugal"] = { "Arquipélago da Madeira" }, "Réunion", "Rwanda", "Saint Helena", "Sao Tome and Principe", "Senegal", "Seychelles", "Sierra Leone", "Somalia", "South Africa", "South Sudan", ["Spain"] = { "Ceuta", "Islas Canarias", "Melilla" }, "Sudan", "Tanzania", "Togo", "Tunisia", "Uganda", "Western Sahara", ["Yemen"] = { "Socotra" }, "Zambia", "Zimbabwe" },
  ["Asia"] = { "Afghanistan", "Armenia", "Azerbaijan", "Bahrain", "Bangladesh", "Bhutan", "British Indian Ocean Territory", "Brunei", "Cambodia", "China", "Christmas Island", "Cocos (Keeling) Islands", "Cyprus", ["Egypt"] = { "North Sinai", "South Sinai" }, "Georgia", "Hong Kong", "India", "Indonesia", "Iran", "Iraq", "Israel", "Japan", "Jordan", "Kazakhstan", "Kuwait", "Kyrgyzstan", "Laos", "Lebanon", "Macao", "Malaysia", "Maldives", "Mongolia", "Myanmar", "Nepal", "North Korea", "Oman", "Pakistan", "Palestine", "Philippines", "Qatar", ["Russia"] = { "Far Eastern Federal District", "Siberian Federal District", "Ural Federal District" }, "Saudi Arabia", "Singapore", "South Korea", "Sri Lanka", "Syria", "Taiwan", "Tajikistan", "Thailand", "Timor-Leste", "Türkiye", "Turkmenistan", "United Arab Emirates", "Uzbekistan", "Vietnam", "Yemen" },
  ["Oceania"] = { "American Samoa", "Australia", "Cook Islands", "Fiji", "French Polynesia", "Guam", ["Indonesia"] = { "Papua" }, "Kiribati", "Marshall Islands", "Micronesia", "Nauru", "New Caledonia", "New Zealand", "Niue", "Norfolk Island", "Northern Mariana Islands", "Palau", "Papua New Guinea", "Pitcairn", "Samoa", "Solomon Islands", "Tokelau", "Tonga", "Tuvalu", "US Minor Outlying Islands", "Vanuatu", "Wallis and Futuna Islands" },
  ["Antarctica"] = { "Antarctica", "Bouvet Island", "French Southern and Antarctic Territories", "Heard Island and McDonald Islands", ["South Georgia and the South Sandwich Islands"] = { "South Sandwich Islands" } }
}
local continents_lookup = {} -- built from 'continents' in BuildContinentsLookup(), called from Initialize_Common()

local known_fields = {
  ['profileName'] = {
    ['name']  = 'Profile Name',
    ['read']  = function(c) return profileName end
  },
  ['gccode'] = {
    ['name']  = 'GC code',
    ['names'] = 'GC codes'
  },
  ['cache_name'] = {
    ['name']  = 'Cache name',
    ['names'] = 'Cache names'
  },
  ['cache_name_firstchar'] = {
    ['name']  = '1st character of cache name',
    ['names'] = '1st character of cache names',
    ['need']  = { 'cache_name' },
    ['read']  = function(c) return PGC.UTF8ToUpper(PGC.UTF8SubStr(c.cache_name, 1, 1)) end
  },
  ['type'] = {
    ['name']  = 'Type',
    ['names'] = 'Types'
  },
  ['type_group_physical'] = {
    ['name']  = 'Type',
    ['names'] = 'Types',
    ['need']  = { 'type' },
    ['read']  = function(c) if physical_types[c.type] then return macro_physical else return c.type end end
  },
  ['type_group_events'] = {
    ['name']  = 'Type',
    ['names'] = 'Types',
    ['need']  = { 'type' },
    ['read']  = function(c) if event_types[c.type] then return macro_events else return c.type end end
  },
  ['type_group_events_and_maze'] = {
    ['name']  = 'Type',
    ['names'] = 'Types',
    ['need']  = { 'type' },
    ['read']  = function(c) if event_types[c.type] or (c.type == 'GPS Adventures Maze Exhibit') then return macro_events else return c.type end end
  },
  ['size'] = {
    ['name']  = 'Size',
    ['names'] = 'Sizes'
  },
  ['difficulty'] = {
    ['name']  = 'Difficulty',
    ['names'] = 'Difficulties'
  },
  ['terrain'] = {
    ['name']  = 'Terrain',
    ['names'] = 'Terrains'
  },
  ['D'] = {
    ['name']  = 'Difficulty',
    ['names'] = 'Difficulties',
    ['need']  = { 'difficulty' },
    ['read']  = function(c) if c.difficulty then return 'D' .. c.difficulty end end
  },
  ['T'] = {
    ['name']  = 'Terrain',
    ['names'] = 'Terrains',
    ['need']  = { 'terrain' },
    ['read']  = function(c) if c.terrain then return 'T' .. c.terrain end end
  },
  ['DT'] = {
    ['name']  = 'D/T',
    ['names'] = 'D/Ts',
    ['need']  = { 'difficulty', 'terrain' },
    ['read']  = function(c) if c.difficulty and c.terrain then return 'D' .. c.difficulty .. '/T' .. c.terrain end end
  },
  ['D+T'] = {
    ['name']  = 'Sum of D and T',
    ['names'] = 'Sums of D and T',
    ['need']  = { 'difficulty', 'terrain' },
    ['read']  = function(c) local d = tonumber(c.difficulty) local t = tonumber(c.terrain) if d and t then return string.format('%.1f', d + t) end end
  },
  ['D*T'] = {
    ['name']  = 'Product of D and T',
    ['names'] = 'Products of D and T',
    ['need']  = { 'difficulty', 'terrain' },
    ['read']  = function(c) local d = tonumber(c.difficulty) local t = tonumber(c.terrain) if d and t then return string.format('%.1f', d * t) end end
  },
  ['elevation'] = {
    ['name']  = 'Elevation (m)',
    ['names'] = 'Elevations (m)',
    ['read']  = function(c) return tonumber(c.elevation) end,
    ['location_based'] = true
  },
  ['elevation_ft'] = {
    ['name']  = 'Elevation (ft)',
    ['names'] = 'Elevations (ft)',
    ['need']  = { 'elevation' },
    ['read']  = function(c) local l = tonumber(c.elevation) if l then return math.floor(l / .3048 + .5) end end,
    ['location_based'] = true
  },
  ['elevation_band'] = {
    ['name']  = 'Elevation band (m)',
    ['names'] = 'Elevation bands (m)',
    ['need']  = { 'elevation' },
    ['read']  = function(c) return ElevationBand(c, 'elevation', 'm') end,
    ['location_based'] = true
  },
  ['elevation_band_ft'] = {
    ['name']  = 'Elevation band (ft)',
    ['names'] = 'Elevation bands (ft)',
    ['need']  = { 'elevation' },
    ['read']  = function(c) return ElevationBand(c, 'elevation_ft', 'ft') end,
    ['location_based'] = true
  },
  ['owner'] = {
    ['name']  = 'Owner',
    ['names'] = 'Owners',
    ['need']  = { 'owner_id' },
    ['read']  = function(c) return PGC_ProfileId2Name(c.owner_id) end
  },
  ['visitdate'] = {
    ['name']  = 'Found date',
    ['names'] = 'Found dates'
  },
  ['visit_year'] = {
    ['name']  = 'Found year',
    ['names'] = 'Found years',
    ['need']  = { 'visitdate' },
    ['read']  = function(c) if type(c.visitdate) == 'string' then return string.sub(c.visitdate, 1, 4) end end
  },
  ['visit_month'] = {
    ['name']  = 'Found month',
    ['names'] = 'Found months',
    ['need']  = { 'visitdate' },
    ['read']  = function(c) if type(c.visitdate) == 'string' then return string.sub(c.visitdate, 6, 7) end end
  },
  ['visit_monthname'] = {
    ['name']  = 'Found month',
    ['names'] = 'Found months',
    ['need']  = { 'visitdate' },
    ['read']  = function(c) if type(c.visitdate) == 'string' then return monthnames_long[tonumber(string.sub(c.visitdate, 6, 7))] end end
  },
  ['visit_monthname_short'] = {
    ['name']  = 'Found month',
    ['names'] = 'Found months',
    ['need']  = { 'visitdate' },
    ['read']  = function(c) if type(c.visitdate) == 'string' then return monthnames_short[tonumber(string.sub(c.visitdate, 6, 7))] end end
  },
  ['visit_day'] = {
    ['name']  = 'Found day',
    ['names'] = 'Found days',
    ['need']  = { 'visitdate' },
    ['read']  = function(c) if type(c.visitdate) == 'string' then return string.sub(c.visitdate, 9, 10) end end
  },
  ['visit_yymm'] = {
    ['name']  = 'Found YYMM',
    ['names'] = 'Found YYMMs',
    ['need']  = { 'visitdate' },
    ['read']  = function(c) if type(c.visitdate) == 'string' then return string.sub(c.visitdate, 1, 7) end end
  },
  ['visit_mmdd'] = {
    ['name']  = 'Found MMDD',
    ['names'] = 'Found MMDDs',
    ['need']  = { 'visitdate' },
    ['read']  = function(c) if type(c.visitdate) == 'string' then return string.sub(c.visitdate, 6, 10) end end
  },
  ['visit_weekday'] = {
    ['name']  = 'Found weekday',
    ['names'] = 'Found weekdays',
    ['need']  = { 'visitdate' },
    ['read']  = function(c) return DayOfWeek(c.visitdate, 'long') end
  },
  ['visit_weekday_short'] = {
    ['name']  = 'Found weekday',
    ['names'] = 'Found weekdays',
    ['need']  = { 'visitdate' },
    ['read']  = function(c) return DayOfWeek(c.visitdate, 'short') end
  },
  ['visit_weekn'] = {
    ['name'] = 'Found week#',
    ['need'] = { 'visitdate' },
    ['read'] = function(c) return WeekNumber(c.visitdate) end
  },
  ['hidden'] = {
    ['name']  = 'Hidden date',
    ['names'] = 'Hidden dates'
  },
  ['hidden_year'] = {
    ['name']  = 'Hidden year',
    ['names'] = 'Hidden years',
    ['need']  = { 'hidden' },
    ['read']  = function(c) if type(c.hidden) == 'string' then return string.sub(c.hidden, 1, 4) end end
  },
  ['hidden_month'] = {
    ['name']  = 'Hidden month',
    ['names'] = 'Hidden months',
    ['need']  = { 'hidden' },
    ['read']  = function(c) if type(c.hidden) == 'string' then return string.sub(c.hidden, 6, 7) end end
  },
  ['hidden_monthname'] = {
    ['name']  = 'Hidden month',
    ['names'] = 'Hidden months',
    ['need']  = { 'hidden' },
    ['read']  = function(c) if type(c.hidden) == 'string' then return monthnames_long[tonumber(string.sub(c.hidden, 6, 7))] end end
  },
  ['hidden_monthname_short'] = {
    ['name']  = 'Hidden month',
    ['names'] = 'Hidden months',
    ['need']  = { 'hidden' },
    ['read']  = function(c) if type(c.hidden) == 'string' then return monthnames_short[tonumber(string.sub(c.hidden, 6, 7))] end end
  },
  ['hidden_day'] = {
    ['name']  = 'Hidden day',
    ['names'] = 'Hidden days',
    ['need']  = { 'hidden' },
    ['read']  = function(c) if type(c.hidden) == 'string' then return string.sub(c.hidden, 9, 10) end end
  },
  ['hidden_yymm'] = {
    ['name']  = 'Hidden YYMM',
    ['names'] = 'Hidden YYMMs',
    ['need']  = { 'hidden' },
    ['read']  = function(c) if type(c.hidden) == 'string' then return string.sub(c.hidden, 1, 7) end end
  },
  ['hidden_mmdd'] = {
    ['name']  = 'Hidden MMDD',
    ['names'] = 'Hidden MMDDs',
    ['need']  = { 'hidden' },
    ['read']  = function(c) if type(c.hidden) == 'string' then return string.sub(c.hidden, 6, 10) end end
  },
  ['hidden_weekday'] = {
    ['name']  = 'Hidden weekday',
    ['names'] = 'Hidden weekdays',
    ['need']  = { 'hidden' },
    ['read']  = function(c) return DayOfWeek(c.hidden, 'long') end
  },
  ['hidden_weekday_short'] = {
    ['name']  = 'Hidden weekday',
    ['names'] = 'Hidden weekdays',
    ['need']  = { 'hidden' },
    ['read']  = function(c) return DayOfWeek(c.hidden, 'short') end
  },
  ['hidden_weekn'] = {
    ['name'] = 'Hidden week#',
    ['need'] = { 'hidden' },
    ['read'] = function(c) return WeekNumber(c.hidden) end
  },
  ['last_publish_date'] = {
    ['name']  = 'Publish date',
    ['names'] = 'Publish dates'
  },
  ['publish_year'] = {
    ['name']  = 'Publish year',
    ['names'] = 'Publish years',
    ['need']  = { 'last_publish_date' },
    ['read']  = function(c) if type(c.last_publish_date) == 'string' then return string.sub(c.last_publish_date, 1, 4) end end
  },
  ['publish_month'] = {
    ['name']  = 'Publish month',
    ['names'] = 'Publish months',
    ['need']  = { 'last_publish_date' },
    ['read']  = function(c) if type(c.last_publish_date) == 'string' then return string.sub(c.last_publish_date, 6, 7) end end
  },
  ['publish_monthname'] = {
    ['name']  = 'Publish month',
    ['names'] = 'Publish months',
    ['need']  = { 'last_publish_date' },
    ['read']  = function(c) if type(c.last_publish_date) == 'string' then return monthnames_long[tonumber(string.sub(c.last_publish_date, 6, 7))] end end
  },
  ['publish_monthname_short'] = {
    ['name']  = 'Publish month',
    ['names'] = 'Publish months',
    ['need']  = { 'last_publish_date' },
    ['read']  = function(c) if type(c.last_publish_date) == 'string' then return monthnames_short[tonumber(string.sub(c.last_publish_date, 6, 7))] end end
  },
  ['publish_day'] = {
    ['name']  = 'Publish day',
    ['names'] = 'Publish days',
    ['need']  = { 'last_publish_date' },
    ['read']  = function(c) if type(c.last_publish_date) == 'string' then return string.sub(c.last_publish_date, 9, 10) end end
  },
  ['publish_yymm'] = {
    ['name']  = 'Publish YYMM',
    ['names'] = 'Publish YYMMs',
    ['need']  = { 'last_publish_date' },
    ['read']  = function(c) if type(c.last_publish_date) == 'string' then return string.sub(c.last_publish_date, 1, 7) end end
  },
  ['publish_mmdd'] = {
    ['name']  = 'Publish MMDD',
    ['names'] = 'Publish MMDDs',
    ['need']  = { 'last_publish_date' },
    ['read']  = function(c) if type(c.last_publish_date) == 'string' then return string.sub(c.last_publish_date, 6, 10) end end
  },
  ['publish_weekday'] = {
    ['name']  = 'Publish weekday',
    ['names'] = 'Publish weekdays',
    ['need']  = { 'last_publish_date' },
    ['read']  = function(c) return DayOfWeek(c.last_publish_date, 'long') end
  },
  ['publish_weekday_short'] = {
    ['name']  = 'Publish weekday',
    ['names'] = 'Publish weekdays',
    ['need']  = { 'last_publish_date' },
    ['read']  = function(c) return DayOfWeek(c.last_publish_date, 'short') end
  },
  ['publish_weekn'] = {
    ['name'] = 'Publish week#',
    ['need'] = { 'last_publish_date' },
    ['read'] = function(c) return WeekNumber(c.last_publish_date) end
  },
  ['found_after_days'] = {
    ['name']  = 'Age in days when found',
    ['names'] = 'Ages in days when found',
    ['need']  = { 'visitdate', 'hidden' },
    ['read']  = function(c) return DateDiffInDays(c.hidden, c.visitdate) end
  },
  ['age_days'] = {
    ['name']  = 'Age in days',
    ['names'] = 'Ages in days',
    ['need']  = { 'hidden' },
    ['read']  = function(c) return AgeInDays(c.hidden) end
  },
  ['age_weeks'] = {
    ['name']  = 'Age in weeks',
    ['names'] = 'Ages in weeks',
    ['need']  = { 'hidden' },
    ['read']  = function(c) return AgeInWeeks(c.hidden) end
  },
  ['age_months'] = {
    ['name']  = 'Age in months',
    ['names'] = 'Ages in months',
    ['need']  = { 'hidden' },
    ['read']  = function(c) return AgeInMonths(c.hidden) end
  },
  ['age_years'] = {
    ['name']  = 'Age in years',
    ['names'] = 'Ages in years',
    ['need']  = { 'hidden' },
    ['read']  = function(c) return AgeInYears(c.hidden) end
  },
  ['country'] = {
    ['name']  = 'Country',
    ['names'] = 'Countries',
    ['location_based'] = true
  },
  ['region'] = {
    ['name']  = 'Region Name',
    ['names'] = 'Region Names',
    ['read']  = function(c) if c.region ~= '' then return c.region end end,
    ['location_based'] = true
  },
  ['county'] = {
    ['name']  = 'County Name',
    ['names'] = 'County Names',
    ['read']  = function(c) if c.county ~= '' then return c.county end end,
    ['location_based'] = true
  },
  ['unique_region'] = { -- get 'Region (Country)'. Falls back to 'Country' if country has no regions.
    ['name']  = 'Region',
    ['names'] = 'Regions',
    ['need']  = { 'country', 'region' },
    ['read']  = function(c) return UniqueRegion(c) end,
    ['location_based'] = true
  },
  ['unique_county'] = { -- get 'County (Country)'. Falls back to 'Region (Country)' if county is not set and country does not have counties. Falls back to 'Country' if country has no regions.
    ['name']  = 'County',
    ['names'] = 'Counties',
    ['need']  = { 'country', 'region', 'county' },
    ['read']  = function(c) return UniqueCounty(c) end,
    ['location_based'] = true
  },
  ['de_region_or_country'] = {
    ['name']  = 'Bundesland/Country',
    ['names'] = 'Bundesländer/Countries',
    ['need']  = { 'country', 'region' },
    ['read']  = function(c) if c.country == 'Germany' then return UniqueRegion(c) else return c.country end end,
    ['location_based'] = true
  },
  ['us_region_or_country'] = {
    ['name']  = 'US State/Country',
    ['names'] = 'US States/Countries',
    ['need']  = { 'country', 'region' },
    ['read']  = function(c) if c.country == 'United States' then return UniqueRegion(c) else return c.country end end,
    ['location_based'] = true
  },
  ['us_au_region_or_country'] = {
    ['name']  = 'US State/AU State/Country',
    ['names'] = 'US States/AU States/Countries',
    ['need']  = { 'country', 'region' },
    ['read']  = function(c) if c.country == 'United States' or c.country == 'Australia' then return UniqueRegion(c) else return c.country end end,
    ['location_based'] = true
  },
  ['us_ca_region_or_country'] = {
    ['name']  = 'US State/CA Prov/Country',
    ['names'] = 'US States/CA Provinces/Countries',
    ['need']  = { 'country', 'region' },
    ['read']  = function(c) if c.country == 'United States' or c.country == 'Canada' then return UniqueRegion(c) else return c.country end end,
    ['location_based'] = true
  },
  ['us_ca_au_region_or_country'] = {
    ['name']  = 'US State/CA Prov/AU State/Country',
    ['names'] = 'US States/CA Provinces/AU States/Countries',
    ['need']  = { 'country', 'region' },
    ['read']  = function(c) if c.country == 'United States' or c.country == 'Canada' or c.country == 'Australia' then return UniqueRegion(c) else return c.country end end,
    ['location_based'] = true
  },
  ['timezone'] = {
    ['name']  = 'Time Zone',
    ['names'] = 'Time Zones',
    ['need']  = { 'country', 'region', 'county' },
    ['read']  = function(c) return GetTimeZone(c) end,
    ['location_based'] = true
  },
  ['continent'] = {
    ['name']  = 'Continent',
    ['names'] = 'Continents',
    ['need']  = { 'country', 'region' },
    ['read']  = function(c) return GetContinent(c) end,
    ['location_based'] = true
  },
  ['favorite_points'] = {
    ['name'] = 'Favorite points',
    ['read'] = function(c) return tonumber(c.favorite_points) end
  }
}

local canExcludeLocationRelatedCaches = false
local excludedCountries = {}
local excludedRegions = {}
local excludedCounties = {}
local excludedTypes = {}
local excludedCaches = {}
local invalidConfigPrinted = false
local usesElevationBands = false
local abort = false
local fields = { 'gccode' }

local ok = false
local log = {}
local html = {}
local map = nil

local numCountryPolygonsShown = 0
local numRegionPolygonsShown = 0
local numCountyPolygonsShown = 0

--------------- wrappers for PGC functions that cache the return values to improve performance on repeated calls ---------------

-- Get list of all known attributes.
-- Returns an associative array (attributeName, groupId, groupName, imageFaded, imageSet, imageUnset) with all known attributes, indexed by attribute id.
local lut_PGC_GetAttributeList = nil
function PGC_GetAttributeList()
  if lut_PGC_GetAttributeList == nil then
    lut_PGC_GetAttributeList = { PGC.GetAttributeList() }
  end

  return lut_PGC_GetAttributeList[1]
end

-- Returns an associative array with country-abbreviation as key and country name as value (or the opposite if flip is used)
local lut_PGC_GetIso3166_1alpha2Table = {}
function PGC_GetIso3166_1alpha2Table(flip)
  flip = flip or false
  local cached = lut_PGC_GetIso3166_1alpha2Table[flip]
  if cached == nil then
    cached = { PGC.GetIso3166_1alpha2Table(flip) }
    lut_PGC_GetIso3166_1alpha2Table[flip] = cached
  end
  return cached[1]
end

-- Get continent definitions.
-- Returns an associative array with continents and their belonging countries.
local lut_PGC_GetContinentDefinitions = nil
function PGC_GetContinentDefinitions()
  if lut_PGC_GetContinentDefinitions == nil then
    lut_PGC_GetContinentDefinitions = { PGC.GetContinentDefinitions() }
  end

  return lut_PGC_GetContinentDefinitions[1]
end

-- Returns number of regions in a country.
-- The number returned is based on Project-GC's polygon data. If no such data exists, 0 will be returned.
local lut_PGC_GetNumberOfRegionsInCountry = {}
function PGC_GetNumberOfRegionsInCountry(countryName)
  if not IsValidCountry(countryName) then
    PGC.print('Warning: PGC_GetNumberOfRegionsInCountry() called with invalid country "' .. tostring(countryName) .. '"!\n')
    return nil
  end

  local numberOfRegions = lut_PGC_GetNumberOfRegionsInCountry[countryName]

  if numberOfRegions == nil then
    numberOfRegions = PGC.GetNumberOfRegionsInCountry(countryName)
    if type(numberOfRegions) ~= 'number' then
      numberOfRegions = 0
    end
    lut_PGC_GetNumberOfRegionsInCountry[countryName] = numberOfRegions
  end

  return numberOfRegions
end

-- Returns a list of region names given a country.
local lut_PGC_GetRegionNamesInCountry = {}
function PGC_GetRegionNamesInCountry(countryName)
  if not IsValidCountry(countryName) then
    PGC.print('Warning: PGC_GetRegionNamesInCountry() called with invalid country "' .. tostring(countryName) .. '"!\n')
    return nil
  end

  local cached = lut_PGC_GetRegionNamesInCountry[countryName]

  if cached == nil then
    cached = { PGC.GetRegionNamesInCountry(countryName) }
    lut_PGC_GetRegionNamesInCountry[countryName] = cached
  end

  return cached[1]
end

-- Returns number of counties in a country.
-- The number returned is based on Project-GC's polygon data. If no such data exists, 0 will be returned.
local lut_PGC_GetNumberOfCountiesInCountry = {}
function PGC_GetNumberOfCountiesInCountry(countryName)
  if not IsValidCountry(countryName) then
    PGC.print('Warning: PGC_GetNumberOfCountiesInCountry() called with invalid country "' .. tostring(countryName) .. '"!\n')
    return nil
  end

  local numberOfCounties = lut_PGC_GetNumberOfCountiesInCountry[countryName]

  if numberOfCounties == nil then
    numberOfCounties = PGC.GetNumberOfCountiesInCountry(countryName)
    if type(numberOfCounties) ~= 'number' then
      numberOfCounties = 0
    end
    lut_PGC_GetNumberOfCountiesInCountry[countryName] = numberOfCounties
  end

  return numberOfCounties
end

-- Returns a list of county names given a country.
local lut_PGC_GetCountyNamesInCountry = {}
function PGC_GetCountyNamesInCountry(countryName)
  if not IsValidCountry(countryName) then
    PGC.print('Warning: PGC_GetCountyNamesInCountry() called with invalid country "' .. tostring(countryName) .. '"!\n')
    return nil
  end

  local cached = lut_PGC_GetCountyNamesInCountry[countryName]

  if cached == nil then
    cached = { PGC.GetCountyNamesInCountry(countryName) }
    lut_PGC_GetCountyNamesInCountry[countryName] = cached
  end

  return cached[1]
end

-- Returns number of counties in a region.
-- The number returned is based on Project-GC's polygon data. If no such data exists, 0 will be returned.
local lut_PGC_GetNumberOfCountiesInRegion = {}
function PGC_GetNumberOfCountiesInRegion(countryName, regionName)
  if not IsValidRegion(countryName, regionName) then
    PGC.print('Warning: PGC_GetNumberOfCountiesInRegion() called with invalid country/region "' .. tostring(countryName) .. '/' .. tostring(regionName) .. '"!\n')
    return nil
  end

  local regions = lut_PGC_GetNumberOfCountiesInRegion[countryName]
  if regions == nil then
    regions = {}
    lut_PGC_GetNumberOfCountiesInRegion[countryName] = regions
  end

  local numberOfCounties = regions[regionName]
  if numberOfCounties == nil then
    numberOfCounties = PGC.GetNumberOfCountiesInRegion(countryName, regionName)
    if type(numberOfCounties) ~= 'number' then
      numberOfCounties = 0
    end
    regions[regionName] = numberOfCounties
  end

  return numberOfCounties
end

-- Returns a list of county names given a region.
local lut_PGC_GetCountyNamesInRegion = {}
function PGC_GetCountyNamesInRegion(countryName, regionName)
  if not IsValidRegion(countryName, regionName) then
    PGC.print('Warning: PGC_GetCountyNamesInRegion() called with invalid country/region "' .. tostring(countryName) .. '/' .. tostring(regionName) .. '"!\n')
    return nil
  end

  local regions = lut_PGC_GetCountyNamesInRegion[countryName]
  if regions == nil then
    regions = {}
    lut_PGC_GetCountyNamesInRegion[countryName] = regions
  end

  local cached = regions[regionName]
  if cached == nil then
    cached = { PGC.GetCountyNamesInRegion(countryName, regionName) }
    regions[regionName] = cached
  end

  return cached[1]
end

-- get polygon information for a country
local lut_PGC_GetCountryPolygonInfo = {}
function PGC_GetCountryPolygonInfo(countryName)
  if not IsValidCountry(countryName) then
    PGC.print('Warning: PGC_GetCountryPolygonInfo() called with invalid country "' .. tostring(countryName) .. '"!\n')
    return nil
  end

  local cached = lut_PGC_GetCountryPolygonInfo[countryName]
  if cached == nil then
    local polygonData = PGC.GetCountryPolygonInfo(countryName)
    if polygonData ~= nil then
      cached = { polygonData[1] }
    else
      cached = {}
    end
    lut_PGC_GetCountryPolygonInfo[countryName] = cached
  end

  return cached[1]
end

-- get polygon information for the regions of a country
local lut_PGC_GetRegionPolygonInfoFromCountry = {}
function PGC_GetRegionPolygonInfoFromCountry(countryName)
  if not IsValidCountry(countryName) then
    PGC.print('Warning: PGC_GetRegionPolygonInfoFromCountry() called with invalid country "' .. tostring(countryName) .. '"!\n')
    return nil
  end

  local cached = lut_PGC_GetRegionPolygonInfoFromCountry[countryName]
  if cached == nil then
    local polygonData = PGC.GetRegionPolygonInfoFromCountry(countryName)
    if polygonData ~= nil then
      local regionsPolygons = {}
      for _, polygon in ipairs(polygonData) do
        regionsPolygons[polygon.name] = polygon
      end
      cached = { regionsPolygons }
    else
      cached = {}
    end

    lut_PGC_GetRegionPolygonInfoFromCountry[countryName] = cached
  end

  return cached[1]
end

-- get polygon information for the counties of a country
local lut_PGC_GetCountyPolygonInfoFromCountry = {}
function PGC_GetCountyPolygonInfoFromCountry(countryName)
  if not IsValidCountry(countryName) then
    PGC.print('Warning: PGC_GetCountyPolygonInfoFromCountry() called with invalid country "' .. tostring(countryName) .. '"!\n')
    return nil
  end

  local cached = lut_PGC_GetCountyPolygonInfoFromCountry[countryName]
  if cached == nil then
    local polygonData = PGC.GetCountyPolygonInfoFromCountry(countryName)
    if polygonData ~= nil then
      local countyPolygons = {}
      for _, polygon in ipairs(polygonData) do
        countyPolygons[polygon.name] = polygon
      end

      cached = { countyPolygons }
    else
      cached = {}
    end

    lut_PGC_GetCountyPolygonInfoFromCountry[countryName] = cached
  end

  return cached[1]
end

-- Returns the Profile name of a user from given Profile ID.
-- Returns Profile Name as a string. Can also return FALSE in case the name is unknown (GDPR optout for example)
local lut_PGC_ProfileId2Name = {}
function PGC_ProfileId2Name(profileId)
  if profileId == nil then
    PGC.print('Warning: PGC_ProfileId2Name() called with nil parameter!\n')
    return nil
  end

  local cached = lut_PGC_ProfileId2Name[profileId]

  if cached == nil then
    cached = { PGC.ProfileId2Name(profileId) }
    lut_PGC_ProfileId2Name[profileId] = cached
  end

  return cached[1]
end

-- Returns the Profile ID of a user from given Profile name.
local lut_PGC_ProfileName2Id = {}
function PGC_ProfileName2Id(profileName)
  if profileName == nil then
    PGC.print('Warning: PGC_ProfileName2Id() called with nil parameter!\n')
    return nil
  end

  local cached = lut_PGC_ProfileName2Id[profileName]

  if cached == nil then
    cached = { PGC.ProfileName2Id(profileName) }
    lut_PGC_ProfileName2Id[profileName] = cached
  end

  return cached[1]
end

-- Returns an icon for a cache type as an <i> html tag.
local lut_PGC_Icon_GeocacheType = {}
function PGC_Icon_GeocacheType(type)
  if type == nil then
    PGC.print('Warning: PGC_Icon_GeocacheType() called with nil parameter!\n')
    return nil
  end

  local cached = lut_PGC_Icon_GeocacheType[type]

  if cached == nil then
    cached = { PGC.Icon.GeocacheType(type) }
    lut_PGC_Icon_GeocacheType[type] = cached
  end

  return cached[1]
end

-- Returns an icon for a cache size as an <i> html tag.
local lut_PGC_Icon_GeocacheSize = {}
function PGC_Icon_GeocacheSize(size)
  if size == nil then
    PGC.print('Warning: PGC_Icon_GeocacheSize() called with nil parameter!\n')
    return nil
  end

  local cached = lut_PGC_Icon_GeocacheSize[size]

  if cached == nil then
    cached = { PGC.Icon.GeocacheSize(size) }
    lut_PGC_Icon_GeocacheSize[size] = cached
  end

  return cached[1]
end

-- Returns an icon indicating a found as an <i> html tag.
local lut_PGC_Icon_GeocacheFound = nil
function PGC_Icon_GeocacheFound()
  if lut_PGC_Icon_GeocacheFound == nil then
    lut_PGC_Icon_GeocacheFound = { PGC.Icon.GeocacheFound() }
  end

  return lut_PGC_Icon_GeocacheFound[1]
end

-- Returns an icon as an <i> html tag.
local lut_PGC_Icon_GeocacheOwned = nil
function PGC_Icon_GeocacheOwned()
  if lut_PGC_Icon_GeocacheOwned == nil then
    lut_PGC_Icon_GeocacheOwned = { PGC.Icon.GeocacheOwned() }
  end

  return lut_PGC_Icon_GeocacheOwned[1]
end

-- Returns an icon as an <i> html tag.
local lut_PGC_Icon_Challenge = nil
function PGC_Icon_Challenge()
  if lut_PGC_Icon_Challenge == nil then
    lut_PGC_Icon_Challenge = { PGC.Icon.Challenge() }
  end

  return lut_PGC_Icon_Challenge[1]
end

-- Returns an icon as an <i> html tag. Defaults to 16px, make large true to get 32px.
local lut_PGC_Icon_Check = {}
function PGC_Icon_Check(large)
  local key = large or false
  local cached = lut_PGC_Icon_Check[key]

  if cached == nil then
    cached = { PGC.Icon.Check(large) }
    lut_PGC_Icon_Check[key] = cached
  end

  return cached[1]
end

-- Returns an icon as an <i> html tag. Defaults to 16px, make large true to get 32px.
local lut_PGC_Icon_Stop = {}
function PGC_Icon_Stop(large)
  local key = large or false
  local cached = lut_PGC_Icon_Stop[key]

  if cached == nil then
    cached = { PGC.Icon.Stop(large) }
    lut_PGC_Icon_Stop[key] = cached
  end

  return cached[1]
end

-- Returns a flag icon as an <img> html tag.
local lut_PGC_Icon_CountryFlag = {}
function PGC_Icon_CountryFlag(countryName)
  if not IsValidCountry(countryName) then
    PGC.print('Warning: PGC_Icon_CountryFlag() called with invalid country "' .. tostring(countryName) .. '"!\n')
    return nil
  end

  local cached = lut_PGC_Icon_CountryFlag[countryName]

  if cached == nil then
    cached = { PGC.Icon.CountryFlag(countryName) }
    lut_PGC_Icon_CountryFlag[countryName] = cached
  end

  return cached[1]
end

-- Returns an icon as an <img> html tag. 
local lut_PGC_Icon_Attribute = {}
function PGC_Icon_Attribute(attribute, state)
  if attribute == nil then
    PGC.print('Warning: PGC_Icon_Attribute() called with nil parameter!\n')
    return nil
  end

  local icons = lut_PGC_Icon_Attribute[attribute]
  if icons == nil then
    icons = {}
    lut_PGC_Icon_Attribute[attribute] = icons
  end

  local stateKey = state or ''
  local cached = icons[stateKey]
  if cached == nil then
    cached = { PGC.Icon.Attribute(attribute, state) }
    icons[stateKey] = cached
  end

  return cached[1]
end

--------------- generic helper functions ---------------

-- dump an object to PGC.print() or PGC.Log() in YAML format
function LogAsYAML(value, loggingFct, indent)
  if loggingFct == nil then loggingFct = PGC.print end
  indent = indent or ''

  if type(value) == 'table' then
    for k, v in pairs(value) do
      if type(v) == 'table' then
        loggingFct(indent .. tostring(k) .. ':\n')
        LogAsYAML(v, loggingFct, indent .. '  ')
      else
        loggingFct(indent .. tostring(k) .. ': ' .. tostring(v) .. '\n')
      end
    end
  else
    loggingFct(indent .. tostring(value) .. '\n')
  end
end

-- try to avoid "Unknown error fetching html output" (problem seems to be too many HTML tags)
function SafeConcatHTML(html)
  local tagLimit = 77000

  -- step 1: count how many HTML elements are currently used
  local tagCount = {}
  local totalTagCount = 0
  for idx, line in ipairs(html) do
    local count = 0
    local pos = string.find(line, '<', 1, true)
    while pos do
      count = count + 1
      pos = string.find(line, '<', pos + 1, true)
    end
    tagCount[idx] = count
    totalTagCount = totalTagCount + count + 1 -- +1 is for <br>
  end
  totalTagCount = math.max(totalTagCount - 1, 0) -- last line doesn't get <br> anymore / correctly handle empty html

  -- step 2: remove entire tables if we have too many tags
  if totalTagCount > tagLimit then
    for i = #html, 1, -1 do
      local line = html[i]
      if StartsWith(line, '<table') and EndsWith(line, '</table>') then
        html[i] = '[table omitted, because the output exceeded the maximum supported size]'
        totalTagCount = totalTagCount - tagCount[i]
        tagCount[i] = 0 -- keep tagCount accurate for step 3, in case this same line gets dropped there too
        if totalTagCount <= tagLimit then
          break
        end
      end
    end
  end

  -- step 3: if removing whole tables wasn't enough, drop lines from the end until we're within the limit
  if totalTagCount > tagLimit then
    while (totalTagCount > tagLimit) and (#html > 0) do
      local i = #html
      totalTagCount = totalTagCount - tagCount[i] - Ternary(i > 1, 1, 0) -- also drop the <br> separator this line no longer needs, unless it was the only remaining line
      table.remove(html, i) -- removing the last element is O(1), no shifting needed
    end
    if #html > 0 then
      totalTagCount = totalTagCount + 1 -- the appended message below adds one more <br> separator
    end
    table.insert(html, '[Content omitted, because the output exceeded the maximum supported size]')
  end

  html = table.concat(html, '<br>')
  if conf.debug then
    PGC.print('HTML output contains ', totalTagCount, ' tags. Size: ', #html, ' bytes.\n')
  end
  return html
end

--------------- math and logic functions ---------------

-- replacement for '?:' operator (i.e. "cond ? a : b")
function Ternary(cond, a, b)
  if cond then
    return a
  end
  return b
end

-- return the given value if it is not nil, otherwise return default value
function GetOrDefault(n, default)
  if n ~= nil then
    return n
  end
  return default
end

-- clamp a value to be in the interval [minValue, maxValue]
function Clamp(value, minValue, maxValue)
  return math.max(minValue, math.min(value, maxValue))
end

--------------- string helper functions ---------------

-- test whether a given string starts with a given prefix. Returns true if prefix is empty string.
function StartsWith(str, prefix)
  return (type(str) == 'string') and string.sub(str, 1, #prefix) == prefix
end

-- test whether a given string ends with a given suffix. Returns true if suffix is empty string.
function EndsWith(str, suffix)
  return (type(str) == 'string') and (#suffix == 0 or string.sub(str, -#suffix) == suffix)
end

-- put quotes around the value, if it is of type string. Otherwise return the value as it is
function QuoteIfString(v, quote)
  if type(v) == 'string' then
    quote = quote or '"'
    return quote .. v .. quote
  end

  return v
end

--------------- helper functions for indexed tables ---------------

-- convert a non-table value to an indexed table containing this value
function IndexedTable_FromValue(v)
  if type(v) == 'table' then
    return v
  end

  if v ~= nil then
    return { v }
  end
end

-- create an indexed table that contain 'num' times the value 'value'
function IndexedTable_Create(num, value)
  local t = {}
  for i = 1, num do
    t[i] = TableCopy(value)
  end
  return t
end

-- add a value to an indexed table if it is not nil
function IndexedTable_InsertIfNotNil(t, v)
  if (type(t) == 'table') and (v ~= nil) then
    table.insert(t, v)
  end
end

-- append the elements of one indexed table to another one
function IndexedTable_Append(resultTable, tableToAppend)
  local j = #resultTable
  for i = 1, #tableToAppend do
    j = j + 1
    resultTable[j] = tableToAppend[i]
  end
end

-- copy the first n elements of an indexed table and return them in a new table
function IndexedTable_Take(t, n)
  local result = {}
  for i = 1, math.min(n, #t) do
    result[i] = t[i]
  end
  return result
end

-- binary search over an indexed table 't' that is sorted ascending according to 'less' (default:
-- numeric/string '<'). Returns the index of the first element for which 'less(t[i], value)' is
-- false, i.e. the first element not ordered before 'value' -- #t + 1 if every element is ordered
-- before 'value'. Mirrors C++'s std::lower_bound(); pass e.g. 'function(a, b) return a <= b end'
-- to instead get std::upper_bound()-style behavior (first element strictly greater than 'value').
function IndexedTable_LowerBound(t, value, less)
  less = less or function(a, b) return a < b end

  local lo, hi = 1, #t + 1
  while lo < hi do
    local mid = math.floor((lo + hi) / 2)
    if less(t[mid], value) then
      lo = mid + 1
    else
      hi = mid
    end
  end

  return lo
end

-- remove a given value from an indexed table, returns true when value was removed and false when value was not found
function IndexedTable_RemoveValue(t, value)
  for i, v in ipairs(t) do
    if v == value then
      table.remove(t, i)
      return true
    end
  end
  return false
end

-- move a given value to the front in an indexed table, if the table contains that value
function IndexedTable_MoveValueToFront(t, value)
  if IndexedTable_RemoveValue(t, value) then
    table.insert(t, 1, value)
    return true
  end
  return false
end

-- remove duplicated values from an indexed table and return the new table
function IndexedTable_RemoveDuplicates(t)
  if type(t) ~= 'table' then
    return t
  end

  local seen = {}
  local result = {}
  local i = 1
  for _, value in ipairs(t) do
    if not seen[value] then
      result[i] = value
      i = i + 1
      seen[value] = true
    end
  end
  return result
end

-- concatenate values in a table, quoting them if they are of type string
function IndexedTable_ConcatQuoted(t, separator, quote)
  separator = separator or ', '

  local tmp = {}
  for i, v in ipairs(t) do
    tmp[i] = tostring(QuoteIfString(v, quote))
  end

  return table.concat(tmp, separator)
end

--------------- helper functions for associative tables ---------------

-- perform a deep copy of a table
function TableCopy(orig)
  if type(orig) ~= 'table' then
    return orig
  end

  local copy = {}
  for k, v in pairs(orig) do
    copy[k] = TableCopy(v)
  end
  return copy
end

-- count number of entries in a table. Works with associative / indexed / mixed tables.
function Count(t)
  local count = 0

  if type(t) == 'table' then
    for _ in pairs(t) do count = count + 1 end
  end

  return count
end

-- convert single value or indexed table of values into an associative table
-- using the indexed values as key and assigning a given value to it
function ConvertToAssociativeTable(t, value)
  value = Ternary(value ~= nil, value, true)

  if type(t) == 'table' then
    if t[1] == nil then
      return TableCopy(t) -- not indexed, return copy of original table
    end

    -- convert indexed table to associative table
    local newT = {}
    for _, key in ipairs(t) do
      newT[key] = value
    end
    return newT
  end

  if type(t) ~= 'nil' then
    -- convert simple value into associative table
    local newT = {}
    newT[t] = value
    return newT
  end

  return nil -- no value was passed in, return nil
end

-- convert the keys of an associative table to an indexed one
function AssociativeTable_KeysToIndexedTable(t)
  if type(t) ~= 'table' then
    return nil
  end

  local newT = {}
  local idx = 1
  for key in pairs(t) do
    newT[idx] = key
    idx = idx + 1
  end
  return newT
end

-- convert the values of an associative table to an indexed one
function AssociativeTable_ValuesToIndexedTable(t)
  if type(t) ~= 'table' then
    return nil
  end

  local newT = {}
  local idx = 1
  for _, value in pairs(t) do
    newT[idx] = value
    idx = idx + 1
  end
  return newT
end

-- remove all elements from table a that are contained in table b
function AssociativeTable_Except(a, b)
  if (type(a) == 'table') and (type(b) == 'table') then
    for k, _ in pairs(b) do
      a[k] = nil
    end
  end
end

-- add all elements from table b to table a (possibly overriding elements in table a)
function AssociativeTable_Join(a, b)
  if (type(a) == 'table') and (type(b) == 'table') then
    for k, v in pairs(b) do
      a[k] = v
    end
  end
end

-- call tonumber() on all keys of the table and return a new table containing everything that did not result in nil
function AssociativeTable_KeysToNumber(t)
  local tmp = {}

  if type(t) == 'table' then
    for k, v in pairs(t) do
      local n = tonumber(k)
      if n then
        tmp[n] = v
      end
    end
  end

  return tmp
end

--------------- date helper functions ---------------

--[[
  Fast YYYY-MM-DD <-> day number conversion for Lua 5.1.
  Day numbers are days since 0000-03-01 (proleptic Gregorian); "2000-01-01" == 730425.
  Pure arithmetic: no os.time / os.date, so it is timezone-, DST- and 32-bit-time_t-independent.

  Internally the calendar is shifted so the year starts on March 1st, which
  makes the leap day the last day of the year and removes all special casing.
--]]

-- "YYYY-MM-DD" --> Integer day number
function DateToDayNumber(dateString)
  if type(dateString) ~= "string" or #dateString ~= 10 then return nil end

  -- Digits are decoded straight from their character codes in a single string.byte call,
  -- so no temporary strings are allocated and tonumber is never invoked.
  local y1, y2, y3, y4, _, m1, m2, _, d1, d2 = dateString:byte(1, 10)
  local y = ((y1 * 10 + y2) * 10 + y3) * 10 + y4 - 53328 -- subtract ASCII '0', 53328 == 48*1111
  local m = m1 * 10 + m2 - 528 -- subtract ASCII '0', 528 == 48*11
  local d = d1 * 10 + d2 - 528 -- subtract ASCII '0', 528 == 48*11

  -- Shift so that March == 0, ... , January == 10, February == 11.
  if m < 3 then y, m = y - 1, m + 9 else m = m - 3 end

  return 365 * y + math.floor(y / 4) - math.floor(y / 100) + math.floor(y / 400) + math.floor((153 * m + 2) / 5) + d - 1
end

-- Integer day number -> "YYYY-MM-DD"
function DayNumberToDate(dayNumber)
  local era = math.floor(dayNumber / 146097) -- 400-year cycle index
  local doe = dayNumber - era * 146097 -- day of era [0, 146096]
  local yoe = math.floor((doe - math.floor(doe / 1460) + math.floor(doe / 36524) - math.floor(doe / 146096)) / 365) -- [0, 399]
  local doy = doe - (365 * yoe + math.floor(yoe / 4) - math.floor(yoe / 100))
  local mp  = math.floor((5 * doy + 2) / 153) -- [0, 11]

  local d = doy - math.floor((153 * mp + 2) / 5) + 1
  local m = mp < 10 and mp + 3 or mp - 9
  return string.format("%04d-%02d-%02d", yoe + era * 400 + (m < 3 and 1 or 0), m, d)
end

-- adjust a given date string by the given number of days (positive or negative) and return the corresponding new date as string
function AdjustDateByDays(dateStr, daysToAdd)
  local dayNumber = DateToDayNumber(dateStr)
  if dayNumber then
    return DayNumberToDate(dayNumber + daysToAdd)
  end
end

-- get the difference between 2 dates in days (returns positive number if date1 is older than date2, otherwise a negative value)
function DateDiffInDays(date1, date2)
  local day1 = DateToDayNumber(date1)
  local day2 = DateToDayNumber(date2)
  if day1 and day2 then
    return day2 - day1
  end
end

-- get the difference in days between the given date string and the current time
function AgeInDays(oldDateString)
  return DateDiffInDays(oldDateString, isotoday)
end

-- get the difference in whole weeks between the given date string and the current time
function AgeInWeeks(oldDateString)
  local days = AgeInDays(oldDateString)
  if days then
    return math.floor(days / 7)
  end
end

-- get the number of days in the given month, taking leap years into account
function DaysInMonth(year, month)
  local lastDay = days_in_month[month]
  if lastDay == nil then
    return nil
  end

  -- days_in_month[2] is 29, so a non-leap February has to be corrected down
  if (month == 2) and not ((year % 4 == 0) and ((year % 100 ~= 0) or (year % 400 == 0))) then
    lastDay = 28
  end

  return lastDay
end

-- get the difference in whole months between the given date string and the current time
function AgeInMonths(oldDateString)
  if type(oldDateString) ~= 'string' or #oldDateString ~= 10 then return nil end

  local y1, y2, y3, y4, _, m1, m2, _, d1, d2 = oldDateString:byte(1, 10)
  local oldYear  = ((y1 * 10 + y2) * 10 + y3) * 10 + y4 - 53328
  local oldMonth = m1 * 10 + m2 - 528
  local oldDay   = d1 * 10 + d2 - 528

  local today  = datetoday.tab -- hoisted: one lookup instead of three
  local months = (today.year - oldYear) * 12 + (today.month - oldMonth)

  -- Actual length of the current month.
  local lastDay = DaysInMonth(today.year, today.month)

  -- Difference in whole calendar months.  The anniversary is oldDay clamped
  -- into the current month, so that 01-31 -> 02-28/29 counts as a whole month
  -- and a 02-29 birthday falls on 02-28 in non-leap years.
  if oldDay > lastDay then oldDay = lastDay end
  if today.day < oldDay then
    months = months - 1
  end

  return months
end

-- get the difference in whole years between the given date string and the current time
-- Convention: a 02-29 date has its anniversary on 02-28 in non-leap years, so
-- it is consistent with AgeInMonths (AgeInYears == floor(AgeInMonths / 12)).
function AgeInYears(oldDateString)
  if type(oldDateString) ~= 'string' or #oldDateString ~= 10 then return nil end

  local y1, y2, y3, y4, _, m1, m2, _, d1, d2 = oldDateString:byte(1, 10)
  local oldYear  = ((y1 * 10 + y2) * 10 + y3) * 10 + y4 - 53328
  local oldMonth = m1 * 10 + m2 - 528
  local oldDay   = d1 * 10 + d2 - 528

  local today = datetoday.tab -- hoisted: one lookup instead of three
  -- Difference in whole calendar years only.
  local years = today.year - oldYear

  -- 02-29 does not exist in a non-leap year; its anniversary becomes 02-28.
  -- Both tests short-circuit for almost every date, so the leap-year check itself is rarely reached.
  if oldMonth == 2 and oldDay == 29 then
    oldDay = DaysInMonth(today.year, oldMonth)
  end

  -- Adjust if the current date is before the old date's anniversary this year.
  if (today.month < oldMonth) or (today.month == oldMonth and today.day < oldDay) then
    years = years - 1
  end

  return years
end

-- Sunday at the start of week 0 used by WeekNumber().
local weekNumberStartSunday = DateToDayNumber('1999-12-26')

-- get the week number, starting beginning at the year 2000
function WeekNumber(date)
  local dayNumber = DateToDayNumber(date)
  if dayNumber then
    local weekStart = weekNumberStartSunday
    if conf.weekStartsOnMonday then
      weekStart = weekStart + 1
    end
    return math.floor((dayNumber - weekStart) / 7)
  end
end

-- get the day of the week as a day name
function DayOfWeek(date, format)
  local dayNumber = DateToDayNumber(date)
  if dayNumber then
    local wday = (dayNumber + 3) % 7 + 1 -- convert to 1=Sunday, ..., 7=Saturday.

    if format == 'short' then
      return daynames_short[wday]
    elseif format == 'long' then
      return daynames_long[wday]
    end

    return wday
  end
end

-- accepted units for relative dates, mapping singular and plural forms to a canonical name
local relativeDateUnits = {
  ['day']    = 'days',
  ['days']   = 'days',
  ['week']   = 'weeks',
  ['weeks']  = 'weeks',
  ['month']  = 'months',
  ['months'] = 'months',
  ['year']   = 'years',
  ['years']  = 'years'
}

-- resolve a configured date into an absolute "YYYY-MM-DD" date.
-- Accepted are a fixed date "YYYY-MM-DD" and a relative date of the scheme
-- "<number> <unit> ago" (e.g. "5 years ago"), counted back from today.
-- Units may be singular or plural and are case-insensitive: day(s), week(s), month(s), year(s).
-- Surrounding and repeated inner whitespace is ignored.
-- Anything else is reported as a configuration error, so the caller can return early.
-- Only intended to be used during initialization.
function ResolveRelativeDate(dateString, parameterName)
  if dateString == nil then
    return nil -- parameter is not set, nothing to resolve
  end

  local formatHint = ' Expected a fixed date "YYYY-MM-DD" or a relative date like "5 years ago" (units: day(s), week(s), month(s), year(s)).'

  local function InvalidValue(reason)
    PrintInvalidConfigHeader()
    table.insert(html, 'Parameter "' .. PGC.HTMLEscape(tostring(parameterName)) .. '" ' .. reason)
    return dateString
  end

  if type(dateString) ~= 'string' then
    return InvalidValue('must be a string, but has type ' .. type(dateString) .. '.' .. formatHint)
  end

  local text = string.lower(string.match(dateString, '^%s*(.-)%s*$'))

  -- relative date: "<number> <unit> ago"
  local number, unit = string.match(text, '^(%d+)%s+(%a+)%s+ago$')
  if number ~= nil then
    local canonicalUnit = relativeDateUnits[unit]
    if canonicalUnit == nil then
      return InvalidValue('uses the unknown unit "' .. PGC.HTMLEscape(unit) .. '" in "' .. PGC.HTMLEscape(dateString) .. '". Supported units are day(s), week(s), month(s) and year(s).')
    end

    number = tonumber(number)

    local result
    if canonicalUnit == 'days' then
      result = AdjustDateByDays(isotoday, -number)
    elseif canonicalUnit == 'weeks' then
      result = AdjustDateByDays(isotoday, -number * 7)
    else
      if canonicalUnit == 'years' then
        number = number * 12 -- a year is just 12 months, so both share the same calendar arithmetic
      end

      local today = datetoday.tab
      local year  = today.year
      local month = today.month
      local day   = today.day

      -- count months from year 0 so that the subtraction cannot underflow a month boundary
      local totalMonths = year * 12 + (month - 1) - number
      year  = math.floor(totalMonths / 12)
      month = totalMonths % 12 + 1

      -- clamp the day into the target month, e.g. "1 month ago" from 03-31 gives 02-28/29,
      -- and "1 year ago" from 02-29 gives 02-28 (same convention as AgeInMonths/AgeInYears)
      local lastDay = DaysInMonth(year, month)
      if day > lastDay then
        day = lastDay
      end

      result = string.format('%04d-%02d-%02d', year, month, day)
    end

    -- guard against an offset so large that the result is no longer a usable date
    if (result == nil) or (string.match(result, '^%d%d%d%d%-%d%d%-%d%d$') == nil) then
      return InvalidValue('has the value "' .. PGC.HTMLEscape(dateString) .. '", which results in a date outside the supported range.')
    end

    return result
  end

  -- fixed date "YYYY-MM-DD": digits only at the digit positions, hyphens in between
  local year, month, day = string.match(text, '^(%d%d%d%d)%-(%d%d)%-(%d%d)$')
  if year == nil then
    return InvalidValue('has the invalid value "' .. PGC.HTMLEscape(dateString) .. '".' .. formatHint)
  end

  year, month, day = tonumber(year), tonumber(month), tonumber(day)

  if (month < 1) or (month > 12) then
    return InvalidValue('has the invalid month ' .. month .. ' in "' .. PGC.HTMLEscape(dateString) .. '".')
  end

  local lastDay = DaysInMonth(year, month)
  if (day < 1) or (day > lastDay) then
    return InvalidValue('has the invalid day ' .. day .. ' in "' .. PGC.HTMLEscape(dateString) .. '", because ' .. string.format('%04d-%02d', year, month) .. ' has ' .. lastDay .. ' days.')
  end

  return string.format('%04d-%02d-%02d', year, month, day)
end

--------------- elevation band helper functions ---------------

-- get the elevation band for the given cache
function ElevationBand(c, field, unit)
  local elevation = GetValue(c, field)
  if elevation == nil then
    return nil
  end

  local bands = conf.ElevationBands
  local idx = IndexedTable_LowerBound(bands, elevation, function(a, b) return a <= b end) -- first band boundary strictly greater than 'elevation'

  if idx == 1 then
    return '<= ' .. tostring(bands[1] - 1) .. tostring(unit)
  end

  if idx > #bands then
    return '>= ' .. tostring(bands[#bands]) .. tostring(unit)
  end

  return tostring(bands[idx - 1]) .. tostring(unit) .. ' to ' .. tostring(bands[idx] - 1) .. tostring(unit)
end

-- return the first number from an elevation band value
function FirstNumberOfElevationBand(s)
  if type(s) == 'string' then
    return tonumber(string.match(s, "-?%d+"))
  end
end

--------------- helper functions related to continent / country / region / county ---------------

-- check if a country name is valid (i.e. it exists)
function IsValidCountry(countryName)
  local countryNames = PGC_GetIso3166_1alpha2Table(true)
  return countryNames[countryName] ~= nil
end

-- check if a region name is valid for the given country (i.e. it exists)
local lut_IsValidRegion = {}
function IsValidRegion(countryName, regionName)
  if not IsValidCountry(countryName) then
    return false
  end

  local regions = lut_IsValidRegion[countryName]
  if regions == nil then
    regions = {}
    local regionNames = PGC_GetRegionNamesInCountry(countryName)
    if type(regionNames) == 'table' then
      for _, name in ipairs(regionNames) do
        regions[name] = true
      end
    end
    lut_IsValidRegion[countryName] = regions
  end

  return regions[regionName] == true
end

-- check if a country has counties
function CountryHasCounties(countryName)
  local numCounties = PGC_GetNumberOfCountiesInCountry(countryName)
  return numCounties and (numCounties > 0)
end

-- check if a country has regions
function CountryHasRegions(countryName)
  local numRegions = PGC_GetNumberOfRegionsInCountry(countryName)
  return numRegions and (numRegions > 0)
end

-- in case PGC continent names are used in conf.filter.country, resolve them to a list of countries
function ResolveContinentNames()
  if conf.filter.country == nil then
    return
  end

  -- phase 1: check if we need to get continent definitions and replace continent names
  local usesContinent = false
  local countries = Ternary(type(conf.filter.country) == 'table', conf.filter.country, { conf.filter.country })
  for _, countryName in ipairs(countries) do
    if StartsWith(countryName, 'PGC.') then
      usesContinent = true
      break
    end
  end

  if usesContinent then
    local continents = PGC_GetContinentDefinitions()
    local newCountries = {}
    for _, countryName in ipairs(countries) do
      if StartsWith(countryName, 'PGC.') then
        local plainContinentName = string.sub(countryName, 5) -- remove the 'PGC.' (1-based index, start at index 5)
        local continent = continents[plainContinentName]
        if continent then
          for _, country in pairs(continent) do -- need to use pair() since this table starts at index 0
            table.insert(newCountries, country)
          end
        else
          PrintInvalidConfigHeader()
          table.insert(html, 'Continent "' .. PGC.HTMLEscape(plainContinentName) .. '" does not exist!<br>')
        end
      else
        table.insert(newCountries, countryName)
      end
    end
    conf.filter.country = newCountries
  end
end

-- check if provided country/region/county names are valid
function VerifyAreaNames()
  local invalidCountries = {}
  local invalidRegions = {}
  local invalidCounties = {}

  if conf.filter.country then
    local validRegions = {}
    local validCounties = {}

    local includedCountries = Ternary(type(conf.filter.country) == 'table', conf.filter.country, { conf.filter.country })
    for _, countryName in ipairs(includedCountries) do
      if IsValidCountry(countryName) then
        if conf.filter.region then
          local regionNames = PGC_GetRegionNamesInCountry(countryName)
          if type(regionNames) == 'table' then
            for _, regionName in ipairs(regionNames) do
              validRegions[regionName] = true
            end
          end
        end

        if conf.filter.county then
          local countyNames = PGC_GetCountyNamesInCountry(countryName)
          if type(countyNames) == 'table' then
            for _, countyName in ipairs(countyNames) do
              validCounties[countyName] = true
            end
          end
        end
      else
        table.insert(invalidCountries, countryName)
      end
    end

    local includedRegions = Ternary(type(conf.filter.region) == 'table', conf.filter.region, { conf.filter.region })
    for _, regionName in ipairs(includedRegions) do
      if validRegions[regionName] ~= true then
        table.insert(invalidRegions, regionName)
      end
    end

    local includedCounties = Ternary(type(conf.filter.county) == 'table', conf.filter.county, { conf.filter.county })
    for _, countyName in ipairs(includedCounties) do
      if validCounties[countyName] ~= true then
        table.insert(invalidCounties, countyName)
      end
    end
  elseif conf.filter.region or conf.filter.county then
    table.insert(html, '<h1>Warning: region or county specified without country!</h1>')
    table.insert(html, 'Please always specify restrictions on regions or counties together with their country.')
  end

  for _, countryName in ipairs(AssociativeTable_KeysToIndexedTable(excludedCountries)) do
    if not IsValidCountry(countryName) then
      table.insert(invalidCountries, countryName)
    end
  end

  if (#invalidCountries > 0) or (#invalidRegions > 0) or (#invalidCounties > 0) then
    PrintInvalidConfigHeader()
    for _, name in ipairs(invalidCountries) do
      table.insert(html, 'Country "' .. PGC.HTMLEscape(name) .. '" does not exist!<br>')
    end

    for _, name in ipairs(invalidRegions) do
      table.insert(html, 'Region "' .. PGC.HTMLEscape(name) .. '" does not exist in the given countries!<br>')
    end

    for _, name in ipairs(invalidCounties) do
      table.insert(html, 'County "' .. PGC.HTMLEscape(name) .. '" does not exist in the given countries!<br>')
    end
  end
end

-- get county and country with fallback to region and country or only country for countries without counties or regions
-- returns nil if county or region are not set for a country that has counties or regions
function UniqueCounty(c)
  local country = GetValue(c, 'country')
  if (country == nil) or (country == '') then
    return nil
  end

  local county = GetValue(c, 'county')
  if county then
    return tostring(county) .. ' (' .. tostring(country) .. ')'
  end

  if CountryHasCounties(country) then
    return nil -- don't count a cache without a county in a country that has counties
  end

  -- fallback to region, country
  return UniqueRegion(c)
end

-- get region and country with fallback to only country for countries without regions
-- returns nil if region is not set for a country that has regions
function UniqueRegion(c)
  local country = GetValue(c, 'country')
  if (country == nil) or (country == '') then
    return nil
  end

  local region = GetValue(c, 'region')
  if region then
    return tostring(region) .. ' (' .. tostring(country) .. ')'
  end

  if CountryHasRegions(country) then
    return nil -- don't count a cache without a region in a country that has regions
  end

  -- fallback to country
  return country
end

-- get the time zone of a cache, based on its country, region and county ('country//county' takes priority over 'country/region', which takes
-- priority over just 'country'); returns nil if none is found
function GetTimeZone(cache)
  local country = GetValue(cache, 'country')
  if country ~= nil then
    local county = GetValue(cache, 'county')
    if county ~= nil then
      local timezone = timezones_lookup[country .. '//' .. county]
      if timezone ~= nil then
        return timezone
      end
    end

    local region = GetValue(cache, 'region')
    if region ~= nil then
      local timezone = timezones_lookup[country .. '/' .. region]
      if timezone ~= nil then
        return timezone
      end
    end

    return timezones_lookup[country]
  end

  return nil
end

-- parse the UTC offset (in minutes) out of a "UTC+HH:MM (...)"-style time zone label, e.g. for sorting; nil for anything else
function TimezoneOffsetInMinutes(timezone)
  if type(timezone) ~= 'string' then
    return nil
  end

  local sign, hh, mm = string.match(timezone, '^UTC([%+%-])(%d%d):(%d%d)')
  if sign == nil then
    return nil
  end

  local minutes = tonumber(hh) * 60 + tonumber(mm)
  return Ternary(sign == '-', -minutes, minutes)
end

-- print the definition of the time zones to the HTML output
function PrintTimeZoneDefinitions()
  -- determine which countries have a region-specific entry (*) and/or a county-specific entry (**) in at least one time zone
  local hasRegionSplit = {}
  local hasCountySplit = {}
  for _, countriesAndRegions in pairs(timezones) do
    for key, value in pairs(countriesAndRegions) do
      if type(value) == 'table' then
        for _, regionOrCounties in pairs(value) do
          if type(regionOrCounties) == 'table' then
            hasCountySplit[key] = true
          else
            hasRegionSplit[key] = true
          end
        end
      end
    end
  end

  table.insert(html, '<h3>Time Zone Definitions</h3>')
  table.insert(html, 'Time zones are determined from the country, region and county of a cache. No user-defined polygons are involved.')
  table.insert(html, '')

  local sortedTimezones = AssociativeTable_KeysToIndexedTable(timezones)
  table.sort(sortedTimezones, TimezoneLess)

  local usedRegionFootnote = false
  local usedCountyFootnote = false
  for _, timezone in ipairs(sortedTimezones) do
    local entries = {}
    for key, value in pairs(timezones[timezone]) do
      if type(value) == 'table' then
        -- key is a country with region- and/or county-specific entries in this time zone
        local names = {}
        for _, regionOrCounties in pairs(value) do
          if type(regionOrCounties) == 'table' then
            -- an unnamed list of specific counties of this country in this time zone
            for _, county in ipairs(regionOrCounties) do
              table.insert(names, county)
            end
          else
            -- a region name
            table.insert(names, regionOrCounties)
          end
        end
        table.sort(names)
        table.insert(entries, PGC.HTMLEscape(key) .. ' (' .. PGC.HTMLEscape(table.concat(names, ', ')) .. ')')
      elseif hasRegionSplit[value] or hasCountySplit[value] then
        -- value is the "default" entry of a country that has regions and/or counties in other time zones too
        local marker = Ternary(hasRegionSplit[value] == true, ' (*)', '') .. Ternary(hasCountySplit[value] == true, ' (**)', '')
        table.insert(entries, PGC.HTMLEscape(value) .. marker)
        usedRegionFootnote = usedRegionFootnote or (hasRegionSplit[value] == true)
        usedCountyFootnote = usedCountyFootnote or (hasCountySplit[value] == true)
      else
        -- value is a country with a single time zone
        table.insert(entries, PGC.HTMLEscape(value))
      end
    end
    table.sort(entries)

    table.insert(html, '<b>' .. PGC.HTMLEscape(timezone) .. ':</b> ' .. Ternary(#entries > 0, table.concat(entries, ', '), '-'))
  end

  if usedRegionFootnote or usedCountyFootnote then
    table.insert(html, '')
  end
  if usedRegionFootnote then
    table.insert(html, '(*) Some regions of this country belong to other time zones.')
  end
  if usedCountyFootnote then
    table.insert(html, '(**) Some counties of this country belong to other time zones.')
  end
end

-- get the continent of a cache, based on its country and region ('country/region' takes priority over just 'country'); returns nil if none is found
function GetContinent(cache)
  local country = GetValue(cache, 'country')
  local region = GetValue(cache, 'region')

  if (country ~= nil) and (region ~= nil) then
    local continent = continents_lookup[country .. '/' .. region]
    if continent ~= nil then
      return continent
    end
  end

  return continents_lookup[country] -- safely returns nil if country is nil
end

-- print the definition of the continents to the HTML output
function PrintContinentDefinitions()
  -- determine which countries have a region-specific entry in at least one continent (i.e. span more than one continent)
  local hasRegionSplit = {}
  for _, countriesAndRegions in pairs(continents) do
    for key, value in pairs(countriesAndRegions) do
      if type(value) == 'table' then
        hasRegionSplit[key] = true
      end
    end
  end

  table.insert(html, '<h3>Continent Definitions</h3>')
  table.insert(html, 'Continents are determined from the country and region of a cache. No user-defined polygons are involved.')
  table.insert(html, '')

  local sortedContinents = AssociativeTable_KeysToIndexedTable(continents)
  table.sort(sortedContinents)

  local usedFootnote = false
  for _, continent in ipairs(sortedContinents) do
    local entries = {}
    for key, value in pairs(continents[continent]) do
      if type(value) == 'table' then
        -- key is a country with region-specific entries on this continent
        local regions = TableCopy(value)
        table.sort(regions)
        table.insert(entries, PGC.HTMLEscape(key) .. ' (' .. PGC.HTMLEscape(table.concat(regions, ', ')) .. ')')
      elseif hasRegionSplit[value] then
        -- value is the "default" entry of a country that has regions on other continents too
        table.insert(entries, PGC.HTMLEscape(value) .. ' (*)')
        usedFootnote = true
      else
        -- value is a country that lies entirely on this continent
        table.insert(entries, PGC.HTMLEscape(value))
      end
    end
    table.sort(entries)

    table.insert(html, '<b>' .. PGC.HTMLEscape(continent) .. ':</b> ' .. Ternary(#entries > 0, table.concat(entries, ', '), '-'))
  end

  if usedFootnote then
    table.insert(html, '')
    table.insert(html, '(*) Some regions of this country belong to a different continent.')
  end
end

--------------- helper functions related to map ---------------

-- initialize the map object when used for the first time
function InitMap()
  if map == nil then
    map = { polygons = {}, caches = {}, correctedCoordinatesInUse = false }
  end
end

-- sets/extends the map outbox to include the given min/max coordinates
function UpdateOutboundBox(minLat, minLon, maxLat, maxLon)
  minLat = tonumber(minLat)
  minLon = tonumber(minLon)
  maxLat = tonumber(maxLat)
  maxLon = tonumber(maxLon)

  if (minLat == nil) or (minLon == nil) or (maxLat == nil) or (maxLon == nil) then
    return
  end

  InitMap()

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

-- show a polygon on the map and update the outbound box of the map to include the polygon
function ShowPolygonOnMap(polygon, color, fillOpacity, htmlTooltip)
  if polygon == nil then
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

  InitMap()
  table.insert(map.polygons, { polygon = polygon.id, color = color, fillOpacity = fillOpacity, htmlTooltip = htmlTooltip })
  UpdateOutboundBox(minLat, minLon, maxLat, maxLon)
end

-- get the polygon info for a country; returns nil if no such polygon exists
function GetCountryPolygon(countryName)
  return PGC_GetCountryPolygonInfo(countryName)
end

-- show a country polygon in the given color on the map
function DrawCountryPolygon(passed, countryName)
  if (passed == nil) or (countryName == nil) then
    PGC.print('Warning: DrawCountryPolygon() called with nil parameter!\n')
    return
  end

  local countryPolygon = GetCountryPolygon(countryName)
  if countryPolygon ~= nil then
    ShowPolygonOnMap(countryPolygon, Ternary(passed, conf.colorCountryPassed, conf.colorCountryMissing), conf.opacityCountry, countryName)
    numCountryPolygonsShown = numCountryPolygonsShown + 1
  else
    PGC.print('DrawCountryPolygon("', countryName or '', '"): polygon not found!\n')
  end
end

-- get the polygon info for a region of a country; returns nil if no such polygon exists
function GetRegionPolygon(countryName, regionName)
  local regionsPolygons = PGC_GetRegionPolygonInfoFromCountry(countryName)
  if regionsPolygons == nil then
    return nil
  end

  return regionsPolygons[regionName]
end

-- show a region polygon in the given color on the map; falls back to a country polygon when the country has no regions, or no matching region polygon is found
function DrawRegionPolygon(passed, countryName, regionName)
  if (passed == nil) or (countryName == nil) then
    PGC.print('Warning: DrawRegionPolygon() called with nil parameter!\n')
    return
  end

  if CountryHasRegions(countryName) then
    local regionPolygon = GetRegionPolygon(countryName, regionName)
    if regionPolygon ~= nil then
      ShowPolygonOnMap(regionPolygon, Ternary(passed, conf.colorRegionPassed, conf.colorRegionMissing), conf.opacityRegion, countryName .. ' / ' .. regionName)
      numRegionPolygonsShown = numRegionPolygonsShown + 1
      return
    end
  end

  DrawCountryPolygon(passed, countryName)
end

-- get the polygon info for a county of a country; returns nil if no such polygon exists
function GetCountyPolygon(countryName, countyName)
  local countyPolygons = PGC_GetCountyPolygonInfoFromCountry(countryName)
  if countyPolygons == nil then
    return nil
  end

  return countyPolygons[countyName]
end

-- show a county polygon in the given color on the map; falls back to a region polygon (which may itself fall back to a country polygon) when the country has no counties, or no matching county polygon is found
function DrawCountyPolygon(passed, countryName, regionName, countyName)
  if (passed == nil) or (countryName == nil) then
    PGC.print('Warning: DrawCountyPolygon() called with nil parameter!\n')
    return
  end

  if CountryHasCounties(countryName) then
    local countyPolygon = GetCountyPolygon(countryName, countyName)
    if countyPolygon ~= nil then
      ShowPolygonOnMap(countyPolygon, Ternary(passed, conf.colorCountyPassed, conf.colorCountyMissing), conf.opacityCounty, countryName .. ' / ' .. (regionName or '') .. ' / ' .. countyName)
      numCountyPolygonsShown = numCountyPolygonsShown + 1
      return
    end
  end

  DrawRegionPolygon(passed, countryName, regionName)
end

--------------- helper functions related to attributes ---------------

-- precomputed powers of two for bit positions 1..32, built once at load time
-- (avoids a '^' pow() call via "function Bit(p) return 2 ^ (p - 1) end" on every HasAttribute() check)
local bitValues = {} -- initialized in Initialize_GlobalVariables()

-- check whether a bit is set in a bit mask
function HasBit(bitMask, bitNumber)
  local p = bitValues[bitNumber]
  return bitMask % (p + p) >= p
end

-- normalize an attribute number: 97..192 map to -1..-96 (the same attributes, expressed as negative numbers)
function NormalizeAttributeNumber(attributeNumber)
  if attributeNumber > 96 then
    return 96 - attributeNumber
  end
  return attributeNumber
end

-- check if an attribute is set on a cache; use negative number, or 97..192, for negative attributes
function HasAttribute(attributeNumber, cache)
  attributeNumber = NormalizeAttributeNumber(attributeNumber)

  local set1 = cache.attributes_set_1 or 0
  local set2 = cache.attributes_set_2 or 0
  local set3 = cache.attributes_set_3 or 0

  if attributeNumber < 0 then
    attributeNumber = -attributeNumber
    set1 = cache.attributes_unset_1 or 0
    set2 = cache.attributes_unset_2 or 0
    set3 = cache.attributes_unset_3 or 0
  end

  if attributeNumber <= 32 then
    return HasBit(set1, attributeNumber)
  end

  attributeNumber = attributeNumber - 32
  if attributeNumber <= 32 then
    return HasBit(set2, attributeNumber)
  end

  attributeNumber = attributeNumber - 32
  if attributeNumber <= 32 then
    return HasBit(set3, attributeNumber)
  end

  return false
end

-- get the name of an attribute from its number (negative number, or 97..192, for negative attribute)
function GetAttributeName(attribute)
  attribute = NormalizeAttributeNumber(attribute)

  local attributes = PGC_GetAttributeList()

  local txt = ''
  local posAttribute = attribute
  if attribute < 0 then
    posAttribute = -attribute
    txt = 'No '
  end

  local attribEntry = attributes[posAttribute]
  if attribEntry then
    return txt .. attribEntry.attributeName
  end

  return 'Unknown attribute ' .. tostring(attribute)
end

--------------- functions related to getting cache properties ---------------

local supported_GetFinds_fields = {
  'gccode', 'cache_id', 'cache_name', 'type', 'difficulty', 'terrain', 'size', 'owner_id', 'placed_by', 'latitude', 'longitude', 'elevation', 'hidden', 'last_publish_date', 'country', 'region', 'county',
  'archived', 'disabled', 'premium', 'attributes_set', 'attributes_unset', 'last_find_date', 'last_archive_date', 'num_finds', 'latest_logs', 'favorite_points', 'favorite_points_pct',
  'favorite_points_wilson', 'last_cache_harvest', 'last_log_harvest', 'log_id', 'visitdate', 'length', 'words', 'ftf', 'cache_description'
}

-- get the fields that are required in PGC.GetFinds for a given key
function GetRequiredFields(key)
  if key ~= nil then
    if (key == 'elevation_band') or (key == 'elevation_band_ft') then
      usesElevationBands = true
    end

    local dimension = known_fields[key]
    if (dimension ~= nil) and (dimension.need ~= nil) then
      return dimension.need
    end

    if supported_GetFinds_fields[key] then
      return { key }
    end
  end

  return {}
end

-- get a value for a required field of a cache
function GetValue(c, key)
  if (c == nil) or (key == nil) then
    return nil
  end

  local field = known_fields[key]
  if field and field.read then
    local flag = field.readFlag -- automatically computed during initialization of the script

    if not c[flag] then
      c[key] = field.read(c)
      c[flag] = true
    end
  end

  return c[key]
end

-- get an optional additional unit for certain key
function GetValueUnit(key)
  if key == 'elevation' then
    return 'm'
  elseif key == 'elevation_ft' then
    return 'ft'
  elseif key == 'favorite_points' then
    return ' 💙'
  end
  return ''
end

-- get the name to be printed for a value
function GetValueLabel(key)
  if key == nil then
    return nil
  end

  local dimension = known_fields[key]
  if (dimension ~= nil) and (dimension.name ~= nil) then
    return dimension.name
  end

  return key
end

-- get the name to be printed for a value in its plural form
function GetValueLabelPlural(key)
  if key == nil then
    return nil
  end

  local dimension = known_fields[key]
  if (dimension ~= nil) and (dimension.names ~= nil) then
    return dimension.names
  end

  return GetValueLabel(key)
end

-- check if a property is based on the location of the cache (can be used to exclude Locationless caches or travelling caches)
function IsBasedOnCacheLocation(key)
  if key == nil then
    return nil
  end

  local dimension = known_fields[key]
  return dimension and dimension.location_based
end

--------------- custom sorter functions ---------------

local boolean_sort_index = { [true] = 1, [false] = 2 }

-- table sorting function for "less" that correctly sorts boolean values (true before false)
function BooleanLess(a, b)
  return NilSafeLess(boolean_sort_index[a], boolean_sort_index[b]) -- boolean_sort_index[nil] just returns nil, so it's safe
end

-- table sorting function for "greater" that correctly sorts boolean values (false before true)
function BooleanGreater(a, b)
  return NilSafeGreater(boolean_sort_index[a], boolean_sort_index[b]) -- boolean_sort_index[nil] just returns nil, so it's safe
end

-- table sorting function for "less" that safely handles nil values (moving them to the end) and boolean values (via BooleanLess)
function NilSafeLess(a, b)
  if a == nil then return false end   -- nil goes after everything
  if b == nil then return true end    -- non-nil goes before nil
  if type(a) == 'boolean' then return BooleanLess(a, b) end
  return a < b
end

-- table sorting function for "greater" that safely handles nil values (moving them to the end) and boolean values (via BooleanGreater)
function NilSafeGreater(a, b)
  if a == nil then return false end   -- nil goes after everything
  if b == nil then return true end    -- non-nil goes before nil
  if type(a) == 'boolean' then return BooleanGreater(a, b) end
  return a > b
end

-- table sorting function for "less" that correctly sorts elevation band values
function ElevationBandLess(a, b)
  return NilSafeLess(FirstNumberOfElevationBand(a), FirstNumberOfElevationBand(b))
end

-- table sorting function for "greater" that correctly sorts elevation band values
function ElevationBandGreater(a, b)
  return NilSafeGreater(FirstNumberOfElevationBand(a), FirstNumberOfElevationBand(b))
end

-- table sorting function for "less" that correctly sorts cache types
function TypeLess(a, b)
  return NilSafeLess(all_types_sort_index[a], all_types_sort_index[b]) -- all_types_sort_index[nil] just returns nil, so it's safe
end

-- table sorting function for "greater" that correctly sorts cache types
function TypeGreater(a, b)
  return NilSafeGreater(all_types_sort_index[a], all_types_sort_index[b]) -- all_types_sort_index[nil] just returns nil, so it's safe
end

-- table sorting function for "less" that correctly sorts cache sizes
function SizeLess(a, b)
  return NilSafeLess(all_sizes_sort_index[a], all_sizes_sort_index[b]) -- all_sizes_sort_index[nil] just returns nil, so it's safe
end

-- table sorting function for "greater" that correctly sorts cache sizes
function SizeGreater(a, b)
  return NilSafeGreater(all_sizes_sort_index[a], all_sizes_sort_index[b]) -- all_sizes_sort_index[nil] just returns nil, so it's safe
end

-- table sorting function for "less" that correctly sorts time zones chronologically (UTC-12:00 to UTC+14:00)
function TimezoneLess(a, b)
  return NilSafeLess(timezones_sort_index[a], timezones_sort_index[b]) -- timezones_sort_index[nil] just returns nil, so it's safe
end

-- table sorting function for "greater" that correctly sorts time zones chronologically (UTC-12:00 to UTC+14:00)
function TimezoneGreater(a, b)
  return NilSafeGreater(timezones_sort_index[a], timezones_sort_index[b]) -- timezones_sort_index[nil] just returns nil, so it's safe
end

-- table sorting function for "less" that correctly sorts weekday names (short or long format)
function DaynameLess(a, b)
  return NilSafeLess(daynames_sort_index[a], daynames_sort_index[b]) -- daynames_sort_index[nil] just returns nil, so it's safe
end

-- table sorting function for "greater" that correctly sorts weekday names (short or long format)
function DaynameGreater(a, b)
  return NilSafeGreater(daynames_sort_index[a], daynames_sort_index[b]) -- daynames_sort_index[nil] just returns nil, so it's safe
end

-- table sorting function for "less" that correctly sorts month names (short or long format)
function MonthnameLess(a, b)
  return NilSafeLess(monthnames_sort_index[a], monthnames_sort_index[b]) -- monthnames_sort_index[nil] just returns nil, so it's safe
end

-- table sorting function for "greater" that correctly sorts month names (short or long format)
function MonthnameGreater(a, b)
  return NilSafeGreater(monthnames_sort_index[a], monthnames_sort_index[b]) -- monthnames_sort_index[nil] just returns nil, so it's safe
end

-- lookup table to get Less/Greater custom sorter for the given fields
local lut_CustomSorters = {
  elevation_band = { less = ElevationBandLess, greater = ElevationBandGreater },
  elevation_band_ft = { less = ElevationBandLess, greater = ElevationBandGreater },
  types = { less = TypeLess, greater = TypeGreater },
  excludedTypes = { less = TypeLess, greater = TypeGreater },
  type = { less = TypeLess, greater = TypeGreater },
  type_group_events = { less = TypeLess, greater = TypeGreater },
  type_group_events_and_maze = { less = TypeLess, greater = TypeGreater },
  type_group_physical = { less = TypeLess, greater = TypeGreater },
  sizes = { less = SizeLess, greater = SizeGreater },
  size = { less = SizeLess, greater = SizeGreater },
  timezone = { less = TimezoneLess, greater = TimezoneGreater },
  visit_weekday = { less = DaynameLess, greater = DaynameGreater },
  visit_weekday_short = { less = DaynameLess, greater = DaynameGreater },
  hidden_weekday = { less = DaynameLess, greater = DaynameGreater },
  hidden_weekday_short = { less = DaynameLess, greater = DaynameGreater },
  publish_weekday = { less = DaynameLess, greater = DaynameGreater },
  publish_weekday_short = { less = DaynameLess, greater = DaynameGreater },
  daynames = { less = DaynameLess, greater = DaynameGreater },
  visit_monthname = { less = MonthnameLess, greater = MonthnameGreater },
  visit_monthname_short = { less = MonthnameLess, greater = MonthnameGreater },
  hidden_monthname = { less = MonthnameLess, greater = MonthnameGreater },
  hidden_monthname_short = { less = MonthnameLess, greater = MonthnameGreater },
  publish_monthname = { less = MonthnameLess, greater = MonthnameGreater },
  publish_monthname_short = { less = MonthnameLess, greater = MonthnameGreater },
  monthnames = { less = MonthnameLess, greater = MonthnameGreater }
}

-- select a suited sort function for a given field for "less" sorting
function SelectLessSorter(field)
  local sorter = lut_CustomSorters[field]
  if sorter then
    return sorter.less
  end
  return NilSafeLess
end

-- select a suited sort function for a given field for "greater" sorting
function SelectGreaterSorter(field)
  local sorter = lut_CustomSorters[field]
  if sorter then
    return sorter.greater
  end
  return NilSafeGreater
end

--------------- helper functions related to find count ---------------

-- determine the total finds count without any filters
function GetFindCount()
  local finds = PGC.GetFinds(profileId, { fields = {}, excludeDupFinds = true, includeLabCaches = conf.includeLabCaches, order = 'OLDESTFIRST'})
  PGC.print('Total find count (duplicated finds excluded): ', #finds, '\n')
  return #finds
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

--------------- helper functions for Bipartite matching (Kuhn's algorithm) ---------------

-- try to find an augmenting path for leftVertex (Kuhn's algorithm): follow an edge to some
-- not-yet-visited rightVertex; if that rightVertex is unmatched, or its current owner can itself
-- be rerouted to a different rightVertex (recursively), leftVertex takes over rightVertex.
-- 'visitedRight' is shared across the whole recursive attempt (not reset per edge), so the same
-- rightVertex is never reconsidered twice within one call to UniqueFindMaximumMatching's caller loop.
function UniqueTryAugment(leftVertex, neighbors, matchedLeftOfRight, visitedRight)
  for _, rightVertex in ipairs(neighbors[leftVertex]) do
    if not visitedRight[rightVertex] then
      visitedRight[rightVertex] = true

      local currentOwner = matchedLeftOfRight[rightVertex]
      if (currentOwner == nil) or UniqueTryAugment(currentOwner, neighbors, matchedLeftOfRight, visitedRight) then
        matchedLeftOfRight[rightVertex] = leftVertex
        return true
      end
    end
  end

  return false
end

-- compute the maximum matching between the left and right vertices of a bipartite graph via
-- Kuhn's algorithm (repeated augmenting-path search, the standard polynomial-time algorithm for
-- maximum bipartite matching). This always finds the true maximum. When the graph doesn't allow
-- matching every left vertex, which ones stay unmatched depends on processing order -- left
-- vertices are processed in the order given by 'leftVertices', so whichever ones come last are
-- the ones left open if not enough pairs exist. Building 'neighbors' (adjacency list:
-- neighbors[left] = indexed array of the right vertices left can pair with) and sorting
-- 'leftVertices' into the desired processing order are both the caller's responsibility, since
-- both are specific to each checker's data while the matching algorithm itself is not.
-- Returns the matching as an indexed table of { left = ..., right = ... } pairs.
-- Runtime is O(#leftVertices * #edges), which stays well within a second for any realistic
-- problem size, so no execution-time guard is needed here.
function UniqueFindMaximumMatching(leftVertices, neighbors)
  local matchedLeftOfRight = {} -- rightVertex -> leftVertex currently matched to it
  for _, leftVertex in ipairs(leftVertices) do
    UniqueTryAugment(leftVertex, neighbors, matchedLeftOfRight, {})
  end

  local matching = {}
  for rightVertex, leftVertex in pairs(matchedLeftOfRight) do
    table.insert(matching, { left = leftVertex, right = rightVertex })
  end

  return matching
end

--------------- helper functions related to cache filtering ---------------

-- add fields that are required for filters
function AddFilterFields(filters)
  if type(filters) == 'table' then
    for _, f in ipairs(filters) do
      if f[1] then
        AddFilterFields(f)
      else
        if f.field == 'attribute' then
          table.insert(fields, 'attributes_set')
          table.insert(fields, 'attributes_unset')
        else
          IndexedTable_Append(fields, GetRequiredFields(f.field))
        end
        IndexedTable_Append(fields, GetRequiredFields(f.field2))
      end
    end
  end
end

-- print and advanced AND filter
function PrintAdvancedFilterAND(filters)
  local andFilters = {}

  for _, filter in ipairs(filters) do
    if filter[1] then
      table.insert(andFilters, '(' .. PrintAdvancedFilterOR(filter) .. ')')
    else
      table.insert(andFilters, PrintAdvancedFilter(filter))
    end
  end

  return table.concat(andFilters, ' AND ')
end

-- print and advanced OR filter
function PrintAdvancedFilterOR(filters)
  local orFilters = {}

  for _, filter in ipairs(filters) do
    if filter[1] then
      table.insert(orFilters, '(' .. PrintAdvancedFilterAND(filter) .. ')')
    else
      table.insert(orFilters, PrintAdvancedFilter(filter))
    end
  end

  return table.concat(orFilters, ' OR ')
end

-- print and advanced filter
function PrintAdvancedFilter(filter)
  local txt = tostring(filter.field) .. ':'

  if filter.include ~= nil then
    local sortedInclude = AssociativeTable_KeysToIndexedTable(filter.include)
    table.sort(sortedInclude, SelectLessSorter(filter.field))
    if filter.field == 'attribute' then
      for i, attributeNumber in ipairs(sortedInclude) do
        sortedInclude[i] = GetAttributeName(attributeNumber)
      end
    end
    txt = txt .. ' include=[' .. IndexedTable_ConcatQuoted(sortedInclude) .. ']'
  end

  if filter.exclude ~= nil then
    local sortedExclude = AssociativeTable_KeysToIndexedTable(filter.exclude)
    table.sort(sortedExclude, SelectLessSorter(filter.field))
    if filter.field == 'attribute' then
      for i, attributeNumber in ipairs(sortedExclude) do
        sortedExclude[i] = GetAttributeName(attributeNumber)
      end
    end
    txt = txt .. ' exclude=[' .. IndexedTable_ConcatQuoted(sortedExclude) .. ']'
  end

  if filter.min ~= nil then
    txt = txt .. ' min=' .. tostring(QuoteIfString(filter.min))
  end

  if filter.max ~= nil then
    txt = txt .. ' max=' .. tostring(QuoteIfString(filter.max))
  end

  if filter.op == 'EQ' then
    txt = txt .. '==' .. tostring(filter.field2)
  elseif filter.op == 'NE' then
    txt = txt .. '!=' .. tostring(filter.field2)
  elseif filter.op == 'GT' then
    txt = txt .. '>' .. tostring(filter.field2)
  elseif filter.op == 'GE' then
    txt = txt .. '>=' .. tostring(filter.field2)
  elseif filter.op == 'LT' then
    txt = txt .. '<' .. tostring(filter.field2)
  elseif filter.op == 'LE' then
    txt = txt .. '<=' .. tostring(filter.field2)
  end

  return txt
end

-- check if a cache passes a filter (returns true when filter passed)
function CheckFilter(filter, cache)
  if filter.field == 'attribute' then
    if filter.include ~= nil then
      local includeMatched = false
      for attributeNumber, _ in pairs(filter.include) do
        if HasAttribute(attributeNumber, cache) then
          includeMatched = true
          break
        end
      end
      if not includeMatched then
        return false
      end
    end

    if filter.exclude ~= nil then
      for attributeNumber, _ in pairs(filter.exclude) do
        if HasAttribute(attributeNumber, cache) then
          return false
        end
      end
    end

    return true
  end

  local fieldVal = GetValue(cache, filter.field)

  if filter.include ~= nil then
    return filter.include[fieldVal] == true
  elseif filter.exclude ~= nil then
    return filter.exclude[fieldVal] ~= true
  end

  if filter.min ~= nil then
    local minVal = filter.min
    if type(minVal) == 'number' then
      fieldVal = tonumber(fieldVal)
    elseif type(fieldVal) == 'number' then
      minVal = tonumber(minVal)
    end
    local comparable = (type(fieldVal) == 'number') or (type(fieldVal) == 'string')
    if (fieldVal == nil) or (minVal == nil) or (type(fieldVal) ~= type(minVal)) or (not comparable) or (fieldVal < minVal) then
      return false
    end
  end

  if filter.max ~= nil then
    local maxVal = filter.max
    if type(maxVal) == 'number' then
      fieldVal = tonumber(fieldVal)
    elseif type(fieldVal) == 'number' then
      maxVal = tonumber(maxVal)
    end
    local comparable = (type(fieldVal) == 'number') or (type(fieldVal) == 'string')
    if (fieldVal == nil) or (maxVal == nil) or (type(fieldVal) ~= type(maxVal)) or (not comparable) or (fieldVal > maxVal) then
      return false
    end
  end

  if filter.op then
    local fieldVal2 = GetValue(cache, filter.field2)

    if type(fieldVal) == 'number' then
      fieldVal2 = tonumber(fieldVal2)
    elseif type(fieldVal2) == 'number' then
      fieldVal = tonumber(fieldVal)
    end

    if (fieldVal == nil) or (fieldVal2 == nil) then
      return false
    end

    local val1IsNumberOrString = (type(fieldVal) == 'number') or (type(fieldVal) == 'string')
    local val2IsNumberOrString = (type(fieldVal2) == 'number') or (type(fieldVal2) == 'string')

    if filter.op == 'EQ' then
      return fieldVal == fieldVal2
    elseif filter.op == 'NE' then
      return fieldVal ~= fieldVal2
    elseif filter.op == 'GT' then
      return val1IsNumberOrString and val2IsNumberOrString and (fieldVal > fieldVal2)
    elseif filter.op == 'GE' then
      return val1IsNumberOrString and val2IsNumberOrString and (fieldVal >= fieldVal2)
    elseif filter.op == 'LT' then
      return val1IsNumberOrString and val2IsNumberOrString and (fieldVal < fieldVal2)
    elseif filter.op == 'LE' then
      return val1IsNumberOrString and val2IsNumberOrString and (fieldVal <= fieldVal2)
    end
    return false
  end

  return true
end

-- process filters combined via 'AND'
function FilterAND(filters, cache)
  local filterPassed = false

  for _, filter in ipairs(filters) do
    if filter[1] then
      filterPassed = FilterOR(filter, cache)
    else
      filterPassed = CheckFilter(filter, cache)
    end

    if not filterPassed then
      return false
    end
  end

  return true
end

-- process filters combined via 'OR'
function FilterOR(filters, cache)
  local filterPassed = false

  for _, filter in ipairs(filters) do
    if filter[1] then
      filterPassed = FilterAND(filter, cache)
    else
      filterPassed = CheckFilter(filter, cache)
    end

    if filterPassed then
      return true
    end
  end

  return false
end

-- filter cache by given criteria
function FilterCache(c)
  if (c.country ~= nil) and excludedCountries[c.country] then
    return false
  end

  local region = GetValue(c, 'region')
  if (region ~= nil) and excludedRegions[region] then
    return false
  end

  local county = GetValue(c, 'county')
  if (county ~= nil) and excludedCounties[county] then
    return false
  end

  if (c.type ~= nil) and excludedTypes[c.type] then
    return false
  end

  if (c.gccode ~= nil) and excludedCaches[c.gccode] then
    return false
  end

  if (conf.minElevation ~= nil) or (conf.maxElevation ~= nil) then
    local elevation = GetValue(c, 'elevation')
    if elevation == nil then
      return false
    end

    if (conf.minElevation ~= nil) and (elevation < conf.minElevation) then
      return false
    end

    if (conf.maxElevation ~= nil) and (elevation > conf.maxElevation) then
      return false
    end
  end

  if (conf.minElevation_ft ~= nil) or (conf.maxElevation_ft ~= nil) then
    local elevation_ft = GetValue(c, 'elevation_ft')
    if elevation_ft == nil then
      return false
    end

    if (conf.minElevation_ft ~= nil) and (elevation_ft < conf.minElevation_ft) then
      return false
    end

    if (conf.maxElevation_ft ~= nil) and (elevation_ft > conf.maxElevation_ft) then
      return false
    end
  end

  if (conf.attribute ~= nil) and (not HasAttribute(conf.attribute, c)) then
    return false
  end

  if (conf.excludedAttribute ~= nil) and HasAttribute(conf.excludedAttribute, c) then
    return false
  end

  if type(conf.filters) == 'table' then
    return FilterAND(conf.filters, c)
  end

  return true
end

-- return a table with filtered caches
function FilterCaches(caches)
  local filtered = {}

  if type(caches) == 'table' then
    for _, c in ipairs(caches) do
      if c.gccode == gccode then
        PGC.print('Not counting the challenge GC code ', gccode, ' towards qualifications\n')
      elseif FilterCache(c) then
        table.insert(filtered, c)
      end
    end
  end

  return filtered
end

-- return printable text for a single filter
function FilterAsText(filterName, filterValue)
  if filterValue == nil then
    return nil
  end

  if type(filterValue) == 'table' then
    table.sort(filterValue, SelectLessSorter(filterName))

    local tmp = {}
    for i, v in ipairs(filterValue) do
      tmp[i] = tostring(QuoteIfString(v))
    end
    return filterName .. '=[' .. table.concat(tmp, ', ') .. ']'
  end

  return filterName .. '=' .. tostring(QuoteIfString(filterValue))
end

-- create filters text that can be printed in the checker result
function PrintSimpleFilters(includeAttributeFilters)
  local filterTexts = {}
  IndexedTable_InsertIfNotNil(filterTexts, FilterAsText('country', conf.filter.country))
  IndexedTable_InsertIfNotNil(filterTexts, FilterAsText('region', conf.filter.region))
  IndexedTable_InsertIfNotNil(filterTexts, FilterAsText('county', conf.filter.county))
  IndexedTable_InsertIfNotNil(filterTexts, FilterAsText('excludedCountry', conf.excludedCountry))
  IndexedTable_InsertIfNotNil(filterTexts, FilterAsText('excludedRegion', conf.excludedRegion))
  IndexedTable_InsertIfNotNil(filterTexts, FilterAsText('excludedCounty', conf.excludedCounty))
  IndexedTable_InsertIfNotNil(filterTexts, FilterAsText('minVisitDate', conf.filter.minVisitDate))
  IndexedTable_InsertIfNotNil(filterTexts, FilterAsText('maxVisitDate', conf.filter.maxVisitDate))
  IndexedTable_InsertIfNotNil(filterTexts, FilterAsText('minHiddenDate', conf.filter.minHiddenDate))
  IndexedTable_InsertIfNotNil(filterTexts, FilterAsText('maxHiddenDate', conf.filter.maxHiddenDate))
  IndexedTable_InsertIfNotNil(filterTexts, FilterAsText('gccodes', conf.filter.gccodes))
  IndexedTable_InsertIfNotNil(filterTexts, FilterAsText('types', conf.filter.types))
  IndexedTable_InsertIfNotNil(filterTexts, FilterAsText('excludedTypes', conf.excludedTypes))
  IndexedTable_InsertIfNotNil(filterTexts, FilterAsText('sizes', conf.filter.sizes))
  IndexedTable_InsertIfNotNil(filterTexts, FilterAsText('difficulties', conf.filter.difficulties))
  IndexedTable_InsertIfNotNil(filterTexts, FilterAsText('terrains', conf.filter.terrains))
  IndexedTable_InsertIfNotNil(filterTexts, FilterAsText('minFavoritePoints', conf.filter.minFavoritePoints))
  IndexedTable_InsertIfNotNil(filterTexts, FilterAsText('minFavoritePointsPercent', conf.filter.minFavoritePointsPercent))
  IndexedTable_InsertIfNotNil(filterTexts, FilterAsText('minFavoritePointsWilson', conf.filter.minFavoritePointsWilson))
  IndexedTable_InsertIfNotNil(filterTexts, FilterAsText('monthnames', conf.filter.monthnames))
  IndexedTable_InsertIfNotNil(filterTexts, FilterAsText('daynames', conf.filter.daynames))
  IndexedTable_InsertIfNotNil(filterTexts, FilterAsText('excludedCaches', conf.excludedCaches))
  -- TableInsertIfTruthy(filterTexts, FilterAsText('radius', conf.filter.radius)) algorithm / distance / latitude / longitude / minMax

  local txt = FilterAsText('minElevation', conf.minElevation)
  if txt then
    table.insert(filterTexts, txt .. 'm')
  end

  txt = FilterAsText('maxElevation', conf.maxElevation)
  if txt then
    table.insert(filterTexts, txt .. 'm')
  end

  txt = FilterAsText('minElevation', conf.minElevation_ft)
  if txt then
    table.insert(filterTexts, txt .. 'ft')
  end

  txt = FilterAsText('maxElevation', conf.maxElevation_ft)
  if txt then
    table.insert(filterTexts, txt .. 'ft')
  end

  if includeAttributeFilters then
    if conf.attribute then
      IndexedTable_InsertIfNotNil(filterTexts, FilterAsText('attribute', GetAttributeName(conf.attribute)))
    end

    if conf.excludedAttribute then
      IndexedTable_InsertIfNotNil(filterTexts, FilterAsText('excludedAttribute', GetAttributeName(conf.excludedAttribute)))
    end
  end

  IndexedTable_InsertIfNotNil(filterTexts, FilterAsText('excludeTravelingGeocaches', conf.excludeTravelingGeocaches))
  IndexedTable_InsertIfNotNil(filterTexts, FilterAsText('excludeDupFinds', conf.excludeDupFinds))
  IndexedTable_InsertIfNotNil(filterTexts, FilterAsText('includeLabCaches', conf.includeLabCaches))

  if #filterTexts > 0 then
    return 'Filters: ' .. table.concat(filterTexts, ', ')
  end

  return nil
end

-- print all filters
function PrintFilters()
  local filtersTxt = PrintSimpleFilters(true)
  if filtersTxt and conf.showFiltersInExampleLog then
    table.insert(log, filtersTxt)
  end

  local hasAdvancedFilters = (type(conf.filters) == 'table') and (#conf.filters > 0) and ((not conf.filters.hidden) or conf.debug)
  local filtersPrinted = (filtersTxt ~= nil) or hasAdvancedFilters

  filtersTxt = PrintSimpleFilters(false)
  if filtersTxt then
    table.insert(html, PGC.HTMLEscape(filtersTxt))
  end

  if hasAdvancedFilters then
    filtersTxt = 'Advanced Filters: ' .. PrintAdvancedFilterAND(conf.filters)
    if conf.showFiltersInExampleLog then
      table.insert(log, filtersTxt)
    end
    table.insert(html, PGC.HTMLEscape(filtersTxt))
  end

  -- show attribute filters again with icon in HTML output
  if conf.attribute then
    local normalizedAttribute = NormalizeAttributeNumber(conf.attribute)
    table.insert(html, PGC_Icon_Attribute(math.abs(normalizedAttribute), Ternary(normalizedAttribute < 0, 'no', 'yes')) .. ' <b>' .. GetAttributeName(conf.attribute) .. ':</b> Only caches with this attribute are included.')
  end

  if conf.excludedAttribute then
    local normalizedExcludedAttribute = NormalizeAttributeNumber(conf.excludedAttribute)
    table.insert(html, PGC_Icon_Attribute(math.abs(normalizedExcludedAttribute), Ternary(normalizedExcludedAttribute < 0, 'no', 'yes')) .. ' <b>' .. GetAttributeName(conf.excludedAttribute) .. ':</b> Caches with this attribute are excluded.')
  end

  if filtersPrinted then
    if conf.showFiltersInExampleLog then
      table.insert(log, '')
    end
    table.insert(html, '')
  end
end

--------------- helper functions related to printing caches and test results ---------------

-- return a matching icon indicating whether a test was passed or failed
function TestPassedIcon(passed)
  if passed then
    return PGC_Icon_Check()
  end
  return PGC_Icon_Stop()
end

local lut_SizeIconsSmall = {
  ['Micro'] = 'https://s3.amazonaws.com/gs-geo-images/5ba59e5d-0ac5-4c07-b5f5-57ad6705521d.png',
  ['Small'] = 'https://s3.amazonaws.com/gs-geo-images/418cf0b4-486e-4f20-8a67-f8bb7ba99625.png',
  ['Regular'] = 'https://s3.amazonaws.com/gs-geo-images/6e132ca6-63c3-42f8-aca2-1531a7b11f27.png',
  ['Large'] = 'https://s3.amazonaws.com/gs-geo-images/1cc4ac6c-cdf0-46ae-a6c1-db2edb24dd2e.png',
  ['Other'] = 'https://s3.amazonaws.com/gs-geo-images/e75480bc-4610-4bd0-bc2d-5b34438f54be.png',
  ['Virtual'] = 'https://s3.amazonaws.com/gs-geo-images/90c97153-7d37-4318-81e6-35fbe67ed6f5.png',
  ['Not chosen'] = 'https://s3.amazonaws.com/gs-geo-images/93dc0f81-20fd-4879-9286-fcfa788a3c86.png'
}

-- get the icon for a value, if the field supports icons (i.e. for type (including grouped types), size, country)
-- returns smaller icon for size when 'small' is true
function GetIcon(field, value, small)
  if value == nil then return end

  if (field == 'type') or (field == 'type_group_events') or (field == 'type_group_events_and_maze') or (field == 'type_group_physical') then
    -- decide which icon(s) shall be shown
    local types = {}
    if value == macro_events then
      AssociativeTable_Join(types, event_types)
      if field == 'type_group_events_and_maze' then
        types['GPS Adventures Maze Exhibit'] = true
      end
    elseif value == macro_physical then
      AssociativeTable_Join(types, physical_types)
    else
      types[value] = true
    end

    -- create icon(s) in the standard sorting order
    types = AssociativeTable_KeysToIndexedTable(types)
    table.sort(types, TypeLess)
    local icons = {}
    for _, typeName in ipairs(types) do
      table.insert(icons, PGC_Icon_GeocacheType(typeName))
    end
    return table.concat(icons)
  elseif field == 'size' then
    if small then
      local src = lut_SizeIconsSmall[value]
      if src then
        return '<img src="' .. lut_SizeIconsSmall[value] .. '" title="' .. value .. '"/>'
      end
      return nil
    else
      return PGC_Icon_GeocacheSize(value)
    end
  elseif field == 'country' then
    return PGC_Icon_CountryFlag(value)
  end
end

-- format a field value as plain text and, if an icon exists for it, as escaped HTML with icon prefix
-- (or icon-only, replacing the text, when showAsIcon is true)
function FormatValueWithIcon(field, value, showAsIcon)
  local txtValue = tostring(value)
  local htmlValue = PGC.HTMLEscape(txtValue)
  local icon = GetIcon(field, value)
  if icon then
    if showAsIcon then
      htmlValue = icon
    else
      htmlValue = icon .. '&nbsp;' .. htmlValue
    end
  end
  return txtValue, htmlValue
end

-- wrap 'value' in a link to the cache's listing page. Pass 'value' to use as the link text (returned
-- unwrapped if the cache has no gccode); when omitted, the gccode itself is used as text (returns nil
-- if the cache has no gccode)
function LinkToListing(cache, value)
  local gccode = GetValue(cache, 'gccode')
  local usingDefault = (value == nil)
  if usingDefault then
    if gccode == nil then
      return nil
    end
    value = PGC.HTMLEscape(gccode)
  end

  if gccode == nil then
    return Ternary(usingDefault, nil, value)
  end

  return '<a href="http://coord.info/' .. gccode .. '" target="_blank">' .. value .. '</a>'
end

-- link to the cache's found-log entry. Pass 'value' to use as the link text (returned unwrapped if the
-- cache has no log_id); when omitted, the visit date is used as text (returns nil if the cache has no
-- log_id or visitdate)
function LinkToLog(cache, value)
  local logId = GetValue(cache, 'log_id')
  local usingDefault = (value == nil)
  if usingDefault then
    value = GetValue(cache, 'visitdate')
    if value == nil then
      return nil
    end
    value = PGC.HTMLEscape(value)
  end

  if logId == nil then
    return Ternary(usingDefault, nil, value)
  end

  return '<a href="http://www.geocaching.com/seek/log.aspx?lid=' .. logId .. '" target="_blank">' .. value .. '</a>'
end

-- matches the placeholders in a log format string, e.g. "{gccode}" or
-- "{difficulty%.1f}". Used by both PrintCache() and AddFormatStringFields() so
-- the two can never disagree about what counts as a placeholder.
local formatStringPattern = '(.-){([%w_#]+)([%w%%. ]*)}()'

-- print a cache using a format string
function PrintCache(cache, formatString, forHtml, showIcons, logNr)
  if (cache == nil) or (formatString == nil) then
    PGC.print('Error: PrintCache() called with nil parameter!\n')
    return
  end

  local line = {}
  local position = 1

  for separator, field, format, pos in string.gmatch(formatString, formatStringPattern) do
    table.insert(line, separator)

    local txt
    if forHtml and conf.links and (field == 'visitdate') then
      txt = LinkToLog(cache) or ''
    else
      local value = GetValue(cache, field)
      txt = Ternary(field == '#', logNr, value)
      if txt == nil then
        txt = ''
      else
        -- ignore incidental whitespace around the format spec (e.g. "{field %10s}"),
        -- and ignore anything that isn't actually a '%' format directive at all
        -- (e.g. a typo like "{field oops}"), rather than silently discarding the value
        format = format:match('^%s*(.-)%s*$')
        if format:find('%%') then
          txt = string.format(format, txt)
        else
          txt = tostring(txt)
        end
      end

      if forHtml then
        txt = PGC.HTMLEscape(txt)

        if showIcons then
          local icon = GetIcon(field, value)
          if icon then
            txt = icon .. '&nbsp;' .. txt
          end
        end

        if conf.links and (field == 'gccode') then
          txt = LinkToListing(cache, txt)
        end
      end
    end

    table.insert(line, txt)
    position = pos
  end

  table.insert(line, string.sub(formatString, position))
  return table.concat(line)
end

-- add the fields that are required by the format string
function AddFormatStringFields(formatString)
  if type(formatString) == 'string' then
    for separator, field, format, pos in string.gmatch(formatString, formatStringPattern) do
      IndexedTable_Append(fields, GetRequiredFields(field))
      if conf.links and (field == 'visitdate') then
        IndexedTable_Append(fields, { 'log_id' })
      end
    end
  end
end

-- print the given caches. Set 'generateHtml' to false to skip the html output (default: true)
function PrintCaches(caches, generateHtml)
  generateHtml = GetOrDefault(generateHtml, true)

  -- pre-sort caches if sortByProperty is given
  local alreadySorted = false
  if conf.log and conf.log.sortByProperty then
    if conf.log.sort == 'A-Z' then
      local sorter = SelectLessSorter(conf.log.sortByProperty)
      table.sort(caches, function(a, b) return sorter(GetValue(a, conf.log.sortByProperty), GetValue(b, conf.log.sortByProperty)) end)
      alreadySorted = true
    end

    if conf.log.sort == 'Z-A' then
      local sorter = SelectGreaterSorter(conf.log.sortByProperty)
      table.sort(caches, function(a, b) return sorter(GetValue(a, conf.log.sortByProperty), GetValue(b, conf.log.sortByProperty)) end)
      alreadySorted = true
    end

    if type(conf.log.sort) == 'table' then
      local sortIndices = {}
      for idx, v in ipairs(conf.log.sort) do
        sortIndices[v] = idx
      end

      local function SortIndex(c)
        local v = GetValue(c, conf.log.sortByProperty)
        if v then
          v = sortIndices[v]
        end
        return v or math.huge
      end

      table.sort(caches, function(a, b) return SortIndex(a) < SortIndex(b) end)
      alreadySorted = true
    end
  end

  -- prepare output
  local numPrinted = 0
  local tmpLog = {}
  for idx, c in ipairs(caches) do
    local lineHtml
    if generateHtml then
      lineHtml = PrintCache(c, conf.log.format, true, conf.log.showIcons, idx)
    end
    local lineTxt = PrintCache(c, conf.log.format, false, false, idx)

    IndexedTable_InsertIfNotNil(tmpLog, { lineHtml = lineHtml, lineTxt = lineTxt })
    numPrinted = numPrinted + 1
    if conf.log.limit and (numPrinted >= conf.log.limit) then
      break
    end
  end

  -- if logs shall be sorted but not by "sortByProperty", sort them by text
  if not alreadySorted then
    if conf.log.sort == 'A-Z' then
      table.sort(tmpLog, function(a, b) return NilSafeLess(a.lineTxt, b.lineTxt) end)
    end

    if conf.log.sort == 'Z-A' then
      table.sort(tmpLog, function(a, b) return NilSafeGreater(a.lineTxt, b.lineTxt) end)
    end
  end

  for _, line in ipairs(tmpLog) do
    table.insert(log, line.lineTxt)
    if generateHtml then
      table.insert(html, line.lineHtml)
    end
  end
end

--------------- helper functions related to parameter validation ---------------

-- print the big header that the configuration is invalid, if not yet done
function PrintInvalidConfigHeader()
  if invalidConfigPrinted then
    return
  end

  table.insert(html, '<h1>Error: invalid checker configuration!</h1>')
  invalidConfigPrinted = true
end

-- reports "Parameter <label> is mandatory[ <reason>]." if 'value' is nil (skipped entirely if
-- 'requiredWhen' is given and false). Returns true if the value is present (or not required),
-- false if a violation was reported -- use the return value to guard code that would otherwise
-- crash on the nil value.
function EnsureMandatory(value, label, requiredWhen, reason)
  if (requiredWhen == nil or requiredWhen) and (value == nil) then
    PrintInvalidConfigHeader()
    table.insert(html, 'Parameter "' .. PGC.HTMLEscape(label) .. '" is mandatory' .. (reason and (' ' .. reason) or '') .. '.')
    return false
  end
  return true
end

-- reports 'message' if every value in the 'conditions' array (each meaning "is this option set")
-- is false/nil. 'conditions' can have any number of elements. Returns true if at least one was
-- set, false if a violation was reported.
function EnsureAtLeastOne(conditions, message)
  for _, isSet in ipairs(conditions) do
    if isSet then
      return true
    end
  end

  PrintInvalidConfigHeader()
  table.insert(html, message)
  return false
end

-- reports 'message' if both 'conditionA' and 'conditionB' are set. Returns true if not both are
-- set, false if a violation was reported.
function EnsureMutuallyExclusive(conditionA, conditionB, message)
  if conditionA and conditionB then
    PrintInvalidConfigHeader()
    table.insert(html, message)
    return false
  end
  return true
end

-- splits 'text' on top-level occurrences of the single-character 'separator', ignoring any
-- separator nested inside a matching pair of (), [], {} or <>, e.g. splitting
-- "int[1,]|array<int[1,]>(1,)" on '|' yields { "int[1,]", "array<int[1,]>(1,)" } -- a '|' that
-- a nested schema itself contains (e.g. inside "array<int|string>(1,)", a supported form: an
-- array whose elements may be either an int or a string) is likewise skipped, not split on.
function SplitTopLevel(text, separator)
  local parts = {}
  local depth = 0
  local startIdx = 1

  for i = 1, #text do
    local ch = text:sub(i, i)
    if (ch == '(') or (ch == '[') or (ch == '{') or (ch == '<') then
      depth = depth + 1
    elseif (ch == ')') or (ch == ']') or (ch == '}') or (ch == '>') then
      depth = depth - 1
    elseif (ch == separator) and (depth == 0) then
      table.insert(parts, text:sub(startIdx, i - 1))
      startIdx = i + 1
    end
  end
  table.insert(parts, text:sub(startIdx))

  return parts
end

-- parses an optional size spec "(min,max)", "(min,)", "(,max)" or "(exact)" -- used for both
-- "array<...>(sizeSpec)" and a string's length constraint "(sizeSpec)" -- into
-- (minLength, maxLength); maxLength is nil for "no maximum". An empty 'sizeSpec' (no parens at
-- all) means "(0,)", i.e. no constraint. Note: a literal "()" (empty parens) is not a valid
-- size spec and silently produces (nil, nil) instead of falling back to "no constraint" -- omit
-- the parens entirely for that.
function ParseSizeSpec(sizeSpec)
  local minLength, maxLength = 0, nil
  if sizeSpec ~= '' then
    local minText, maxText = sizeSpec:match('^%((%d*),(%d*)%)$')
    if minText ~= nil then
      minLength = tonumber(minText) or 0
      maxLength = tonumber(maxText) -- nil means "no maximum"
    else
      minLength = tonumber(sizeSpec:match('^%((%d+)%)$')) -- "(N)" means exactly N
      maxLength = minLength
    end
  end
  return minLength, maxLength
end

-- parses a single scalar schema fragment (no top-level '|', no leading "[array]", not an
-- "array<...>" form) into its constraint parts. See ValidateValue()'s doc comment for the
-- syntax of "schemaValue". The returned table has:
--   luaType            the Lua type() the value must have ('table' for a bare "table")
--   requireWholeNumber  true for "int" (a "number" that must additionally be a whole number)
--   minValue/maxValue   from an optional "[min,max]" range (int/number only, either side may be nil)
--   minLength/maxLength from an optional "(min,max)" length spec (string only, via
--                       ParseSizeSpec()), either side may be nil, both nil if no spec was given
--   allowedValues       a set of the allowed values, from an optional "{v1,v2,...}" list
--                       (int/number/string/boolean), or nil if no such list was given
--   allowedValuesText   the allowed values as written in the schema, for error messages
function ParseScalarSchema(schemaValue)
  local typeName = schemaValue:match('^%a+')
  local rest = schemaValue:sub(#typeName + 1)

  local info = { luaType = typeName, requireWholeNumber = (typeName == 'int') }

  if (typeName == 'int') or (typeName == 'number') then
    info.luaType = 'number'
    if rest:sub(1, 1) == '[' then
      info.minValue = tonumber(rest:match('^%[(%-?%d*%.?%d+)'))
      info.maxValue = tonumber(rest:match(',(%-?%d*%.?%d+)%]$'))
    elseif rest:sub(1, 1) == '{' then
      info.allowedValuesText = rest:sub(2, -2)
      info.allowedValues = {}
      for v in rest:gmatch('%-?%d*%.?%d+') do
        info.allowedValues[tonumber(v)] = true
      end
    end
  elseif typeName == 'string' then
    if rest:sub(1, 1) == '{' then
      info.allowedValuesText = rest:sub(2, -2)
      info.allowedValues = {}
      -- %1 is a back reference, so that each value has to be enclosed in matching quotes
      for _, v in rest:gmatch([[(["'])(.-)%1]]) do
        info.allowedValues[v] = true
      end
    elseif rest:sub(1, 1) == '(' then
      info.minLength, info.maxLength = ParseSizeSpec(rest)
    end
  elseif typeName == 'boolean' then
    if rest:sub(1, 1) == '{' then
      info.allowedValuesText = rest:sub(2, -2)
      info.allowedValues = {}
      for v in rest:gmatch('%a+') do
        info.allowedValues[v == 'true'] = true
      end
    end
  end
  -- 'table' (bare) needs no further parsing here; ScalarValueMatches() special-cases it

  return info
end

-- true if 'value' (of any Lua type) satisfies the parsed scalar constraints in 'info' (see
-- ParseScalarSchema()). A bare "table" schema accepts any table value without further checks.
function ScalarValueMatches(value, info)
  if type(value) ~= info.luaType then
    return false
  end

  if info.luaType == 'table' then
    return true
  end

  if info.allowedValues ~= nil then
    return info.allowedValues[value] == true
  end

  if info.luaType == 'number' then
    if info.requireWholeNumber and (value % 1 ~= 0) then
      return false
    end
    if (info.minValue ~= nil) and (value < info.minValue) then
      return false
    end
    if (info.maxValue ~= nil) and (value > info.maxValue) then
      return false
    end
  elseif info.luaType == 'string' then
    if (info.minLength ~= nil) and (#value < info.minLength) then
      return false
    end
    if (info.maxLength ~= nil) and (#value > info.maxLength) then
      return false
    end
  end

  return true
end

-- if 'schemaValue' has the form "array<elementSchema>" optionally followed by a size spec
-- "(min,max)", "(min,)", "(,max)" or "(exact)", returns elementSchema, minLength, maxLength
-- (maxLength is nil for "no maximum"; omitting the size spec entirely means "(0,)", i.e. an
-- empty array is valid too). Returns nil for any other shape (so the caller can try treating
-- schemaValue as a scalar fragment instead). 'elementSchema' may itself be any schema,
-- including a nested "array<...>" (recursively) or a '|'-separated union, e.g.
-- "array<array<int[0,]>(31)>(12)" or "array<int|string>(1,)"
function ParseArraySchema(schemaValue)
  if schemaValue:sub(1, 6) ~= 'array<' then
    return nil
  end

  -- find the '>' that matches the '<' right after "array", honoring nested "array<...>"
  local depth = 0
  local closeIdx = nil
  for i = 7, #schemaValue do
    local ch = schemaValue:sub(i, i)
    if (ch == '(') or (ch == '[') or (ch == '{') or (ch == '<') then
      depth = depth + 1
    elseif (ch == ')') or (ch == ']') or (ch == '}') or (ch == '>') then
      if depth == 0 then
        closeIdx = i
        break
      end
      depth = depth - 1
    end
  end

  local elementSchema = schemaValue:sub(7, closeIdx - 1)
  local minLength, maxLength = ParseSizeSpec(schemaValue:sub(closeIdx + 1))

  return elementSchema, minLength, maxLength
end

-- true if 'value' is a gap-free array: empty, or with keys exactly 1..n (n = Count(value), so
-- a table like {[1]=x, [3]=y} -- a hole at index 2 -- or {[1]=x, foo=y} is rejected here, even
-- though a plain '#'-based length check could miss either), each element from 1..n matching
-- 'elementSchema' (via SchemaAccepts(), so this stays silent/side-effect-free).
function ArrayElementsMatch(value, elementSchema, n)
  for i = 1, n do
    if not SchemaAccepts(value[i], elementSchema) then
      return false
    end
  end
  return true
end

-- "[array]X" is pure syntactic sugar for "X|array<X>(1,)" (a single value matching X, or a
-- non-empty array of such values) -- expanding it up front means the rest of the engine only
-- ever has to deal with the two primitive alternative forms (a scalar fragment, or
-- "array<...>"), instead of treating "[array]" as a third special case everywhere. Idempotent:
-- expanding a schema that contains no "[array]" alternative returns it unchanged.
function ExpandArrayShorthand(schemaValue)
  local expandedAlts = {}
  for _, alt in ipairs(SplitTopLevel(schemaValue, '|')) do
    if alt:sub(1, 7) == '[array]' then
      local innerSchema = alt:sub(8)
      table.insert(expandedAlts, innerSchema)
      table.insert(expandedAlts, 'array<' .. innerSchema .. '>(1,)')
    else
      table.insert(expandedAlts, alt)
    end
  end
  return table.concat(expandedAlts, '|')
end

-- silently (no error messages) checks whether 'value' matches ANY top-level '|' alternative
-- of 'schemaValue'. This is the single source of truth for accept/reject decisions, used both
-- for the top-level check in ValidateValue() and recursively for elements inside an
-- "array<...>" alternative.
function SchemaAccepts(value, schemaValue)
  local valueType = type(value)

  for _, alt in ipairs(SplitTopLevel(ExpandArrayShorthand(schemaValue), '|')) do
    local elementSchema, minLength, maxLength = ParseArraySchema(alt)
    if elementSchema ~= nil then
      if valueType == 'table' then
        local n = Count(value) -- not '#', which is undefined for a table with a gap or a stray non-index key
        if (n >= minLength) and ((maxLength == nil) or (n <= maxLength)) and ArrayElementsMatch(value, elementSchema, n) then
          return true
        end
      end
      -- an "array<...>" alternative never matches anything else (in particular, a value
      -- with the wrong length/elements must NOT fall through to a bare-table match)
    elseif ScalarValueMatches(value, ParseScalarSchema(alt)) then
      return true
    end
  end

  return false
end

-- turns (minLength, maxLength) into the English phrase used in the "must be an array with
-- ..." error message, e.g. "exactly 12 elements", "at least 1 element", "at most 20 elements",
-- "between 5 and 10 elements"
function DescribeLengthConstraint(minLength, maxLength)
  local function ElementWord(n)
    return (n == 1) and 'element' or 'elements'
  end

  if maxLength == minLength then
    return 'exactly ' .. minLength .. ' ' .. ElementWord(minLength)
  elseif maxLength == nil then
    return 'at least ' .. minLength .. ' ' .. ElementWord(minLength)
  elseif minLength == 0 then
    return 'at most ' .. maxLength .. ' ' .. ElementWord(maxLength)
  else
    return 'between ' .. minLength .. ' and ' .. maxLength .. ' elements'
  end
end

-- a schema with more than one top-level '|' alternative doesn't fully explain itself through
-- just "the reason this particular alternative failed" -- the other alternatives that were
-- also available are useful context. Returns that as a message suffix, e.g.
-- ' Allowed schema: "int[1,]|array<int[1,]>(1,)".', or '' when 'schemaValue' has only a single
-- alternative (there listing it again would be pure repetition of the type-mismatch message).
--
-- the common "X|array<X>(1,)" shape (a scalar schema alongside a non-empty array of that exact
-- same schema -- what "[array]X" expands into via ExpandArrayShorthand()) gets a short, fixed
-- phrase instead: repeating a potentially long scalar schema (e.g. a big enum) three times over
-- in one message (once for the value/range itself, twice more inside both union alternatives)
-- would be noise, not information, since the two alternatives don't differ in any way that
-- needs spelling out again.
function SchemaOptionsSuffix(schemaValue)
  local alts = SplitTopLevel(schemaValue, '|')
  if #alts <= 1 then
    return ''
  end

  if (#alts == 2) and (alts[2] == 'array<' .. alts[1] .. '>(1,)') then
    return ' (a non-empty array of the above is also allowed)'
  end

  return ' Allowed schema: "' .. schemaValue .. '".'
end

-- 'value' is a non-table value that failed SchemaAccepts() against every alternative in
-- 'schemaValue'; 'scalarSchema' is the '|'-separated subset of 'schemaValue's alternatives
-- that are scalar (non-array) fragments. Reports the specific reason (wrong type, disallowed
-- value, out of range, or not a whole number), plus -- via SchemaOptionsSuffix() -- the full
-- original schema when it has more than one alternative (which may include array alternatives
-- that 'scalarSchema' itself has already filtered out). If several alternatives share the same
-- Lua type with different constraints, only the first one is used to explain the mismatch --
-- schemas in practice don't do that, so this is not a real limitation.
function ReportScalarMismatch(label, value, scalarSchema, schemaValue)
  local valueType = type(value)
  local matchingTypeInfo = nil

  for _, alt in ipairs(SplitTopLevel(scalarSchema, '|')) do
    local info = ParseScalarSchema(alt)
    if info.luaType == valueType then
      matchingTypeInfo = info
      break
    end
  end

  if matchingTypeInfo == nil then
    PrintInvalidConfigHeader()
    table.insert(html, 'Parameter "' .. PGC.HTMLEscape(label) .. '" has type ' .. valueType .. '. Only these types are allowed: ' .. schemaValue)
  elseif matchingTypeInfo.allowedValues ~= nil then
    PrintInvalidConfigHeader()
    table.insert(html, 'Parameter "' .. PGC.HTMLEscape(label) .. '" has value ' .. QuoteIfString(value) .. '. Only these values are allowed: ' .. matchingTypeInfo.allowedValuesText .. '.' .. SchemaOptionsSuffix(schemaValue))
  elseif valueType == 'number' then
    if matchingTypeInfo.requireWholeNumber and (value % 1 ~= 0) then
      PrintInvalidConfigHeader()
      table.insert(html, 'Parameter "' .. PGC.HTMLEscape(label) .. '" has value ' .. tostring(value) .. '. Only whole numbers are allowed.' .. SchemaOptionsSuffix(schemaValue))
    elseif (matchingTypeInfo.minValue ~= nil) and (value < matchingTypeInfo.minValue) then
      PrintInvalidConfigHeader()
      table.insert(html, 'Parameter "' .. PGC.HTMLEscape(label) .. '" has value ' .. tostring(value) .. '. Minimum allowed value is ' .. matchingTypeInfo.minValue .. '.' .. SchemaOptionsSuffix(schemaValue))
    elseif (matchingTypeInfo.maxValue ~= nil) and (value > matchingTypeInfo.maxValue) then
      PrintInvalidConfigHeader()
      table.insert(html, 'Parameter "' .. PGC.HTMLEscape(label) .. '" has value ' .. tostring(value) .. '. Maximum allowed value is ' .. matchingTypeInfo.maxValue .. '.' .. SchemaOptionsSuffix(schemaValue))
    end
  elseif (valueType == 'string') and (matchingTypeInfo.minLength ~= nil) then
    if #value < matchingTypeInfo.minLength then
      PrintInvalidConfigHeader()
      table.insert(html, 'Parameter "' .. PGC.HTMLEscape(label) .. '" has ' .. #value .. ' ' .. Ternary(#value == 1, 'character', 'characters') .. '. Minimum allowed length is ' .. matchingTypeInfo.minLength .. '.' .. SchemaOptionsSuffix(schemaValue))
    elseif (matchingTypeInfo.maxLength ~= nil) and (#value > matchingTypeInfo.maxLength) then
      PrintInvalidConfigHeader()
      table.insert(html, 'Parameter "' .. PGC.HTMLEscape(label) .. '" has ' .. #value .. ' ' .. Ternary(#value == 1, 'character', 'characters') .. '. Maximum allowed length is ' .. matchingTypeInfo.maxLength .. '.' .. SchemaOptionsSuffix(schemaValue))
    end
  end
end

-- 'value' is a Lua array that failed SchemaAccepts() against every alternative in 'schemaValue';
-- 'arrayAlts' is the subset of 'schemaValue's alternatives that are array-shaped (each
-- { elementSchema, minLength, maxLength }, from "array<...>" alternatives -- "schemaValue" is
-- assumed to already have gone through ExpandArrayShorthand()). Picks whichever alternative
-- would produce the clearest explanation -- preferring one whose length is actually valid, and
-- among those (or if none qualify) the one whose elements come closest to matching -- and
-- reports against that one specifically (plus, via SchemaOptionsSuffix(), the full original
-- schema when it has more than one alternative), recursing per element. Uses Count(), not '#',
-- and checks indices 1..n directly instead of ipairs() (which would silently stop at the first
-- gap), so a gap is reported like any other element mismatch: as a nil at that index.
function ReportArrayMismatch(label, value, arrayAlts, schemaValue)
  local n = Count(value)
  local bestAlt = nil
  local bestLengthOk = false
  local bestMismatches = nil

  for _, alt in ipairs(arrayAlts) do
    local lengthOk = (n >= alt.minLength) and ((alt.maxLength == nil) or (n <= alt.maxLength))
    local mismatches = 0
    for i = 1, n do
      if not SchemaAccepts(value[i], alt.elementSchema) then
        mismatches = mismatches + 1
      end
    end

    if (bestAlt == nil) or (lengthOk and not bestLengthOk) or ((lengthOk == bestLengthOk) and (mismatches < bestMismatches)) then
      bestAlt = alt
      bestLengthOk = lengthOk
      bestMismatches = mismatches
    end
  end

  if not bestLengthOk then
    PrintInvalidConfigHeader()
    table.insert(html, 'Parameter "' .. PGC.HTMLEscape(label) .. '" must be an array with ' .. DescribeLengthConstraint(bestAlt.minLength, bestAlt.maxLength) .. '.' .. SchemaOptionsSuffix(schemaValue))
  end

  for idx = 1, n do
    ValidateValue(label .. '[' .. idx .. ']', value[idx], bestAlt.elementSchema)
  end

  -- make sure the array has no gaps and no other properties that are not indices 1..n
  for k in pairs(value) do
    if (type(k) ~= 'number') or (k % 1 ~= 0) or (k < 1) or (k > n) then
      PrintInvalidConfigHeader()
      table.insert(html, 'Parameter "' .. PGC.HTMLEscape(label) .. '" must be a gap-free array. Parameter "' .. PGC.HTMLEscape(tostring(k)) .. '" is not allowed here.' .. SchemaOptionsSuffix(schemaValue))
    end
  end
end

-- validate a single config value against a schema. 'label' is the fully qualified parameter
-- name used in error messages, e.g. "conf.terrains" or "conf.minValue[3]" for an array element.
--
-- the schema can list one or multiple allowed alternatives, separated by '|'; 'value' is valid
-- if it matches AT LEAST ONE alternative. Each alternative is one of:
--
--   a scalar type, optionally constrained:
--     "boolean", "number", "string", "table" (a table accepted without any further validation,
--     e.g. for passing through native PGC filters)
--     "int" is a "number" that must additionally be a whole number
--     "number" and "int" accept an optional range "[min,max]" (min/max each optional), e.g.
--       "int", "int[1,]", "int[,192]", "int[-96,192]", "number[1.5,4.5]"
--     "int", "number", "string" and "boolean" accept an optional list of all allowed values,
--       e.g. "int{1,2,3}", "number{1,1.5,2,2.5,3,3.5,4,4.5,5}", "string{'A-Z','Z-A'}" (both '
--       and " work as quotes), "boolean{true,false}"
--     "string" additionally accepts an optional length constraint "(sizeSpec)", using the exact
--       same syntax as an array's size spec (see below): "(N)" exactly N characters, "(N,)" at
--       least N, "(,N)" at most N, "(N,M)" between N and M (all inclusive), e.g. "string(1,20)",
--       "string(6)". Mutually exclusive with the "{...}" allowed-values list above.
--
--   "[array]<scalarSchema>"            shorthand for "<scalarSchema>|array<<scalarSchema>>(1,)"
--                                       (see below): <scalarSchema> itself, or a non-empty
--                                       array of values that each match <scalarSchema>, e.g.
--                                       "[array]number{1,1.5,2,2.5,3,3.5,4,4.5,5}" accepts
--                                       both 3.5 and {3, 3.5, 4}
--
--   "array<elementSchema>(sizeSpec)"   always an array (a plain scalar value is never allowed
--                                       here) whose elements each match <elementSchema>, which
--                                       may itself be any schema, including a nested
--                                       "array<...>" (recursively) or a '|'-separated union.
--                                       An array must be gap-free: if non-empty, its keys start
--                                       at 1 and each following index is exactly 1 greater than
--                                       the previous one -- a hole, a non-integer index, or any
--                                       other stray key makes the value not match at all,
--                                       regardless of size.
--                                       "(sizeSpec)" is optional (an empty array is then also
--                                       valid) and can be:
--                                         "(N)"    exactly N elements
--                                         "(N,)"   at least N elements
--                                         "(,N)"   at most N elements
--                                         "(N,M)"  between N and M elements (both inclusive)
--                                       e.g. "array<int[1,]>(1,)" is a non-empty array of
--                                       whole numbers >= 1, and
--                                       "array<array<int[0,]>(31)>(12)" is an array of exactly
--                                       12 elements, each itself an array of exactly 31 whole
--                                       numbers >= 0 (e.g. a per-month, per-day-of-month table)
--                                       "()" without a number is not allowed, omit it entirely to allow an empty table
--
-- multiple alternatives can be combined freely, e.g. "int[1,]|array<int[1,]>(1,)|array<array<int[0,]>(31)>(12)"
-- accepts a single whole number >= 1, or a flat non-empty array of such numbers, or a
-- 12-element array of 31-element arrays of whole numbers >= 0.
function ValidateValue(label, value, schemaValue)
  schemaValue = ExpandArrayShorthand(schemaValue)

  if SchemaAccepts(value, schemaValue) then
    return
  end

  local valueType = type(value)
  local scalarAlts = {}
  local arrayAlts = {}

  for _, alt in ipairs(SplitTopLevel(schemaValue, '|')) do
    local elementSchema, minLength, maxLength = ParseArraySchema(alt)
    if elementSchema ~= nil then
      table.insert(arrayAlts, { elementSchema = elementSchema, minLength = minLength, maxLength = maxLength })
    else
      table.insert(scalarAlts, alt)
    end
  end

  if (valueType == 'table') and (#arrayAlts > 0) then
    ReportArrayMismatch(label, value, arrayAlts, schemaValue)
  elseif (valueType ~= 'table') and (#scalarAlts > 0) then
    ReportScalarMismatch(label, value, table.concat(scalarAlts, '|'), schemaValue)
  else
    PrintInvalidConfigHeader()
    table.insert(html, 'Parameter "' .. PGC.HTMLEscape(label) .. '" has type ' .. valueType .. '. Only these types are allowed: ' .. schemaValue)
  end
end

-- check if 'config' has any properties that are not defined in 'schema' or have the wrong type
function ValidateParameters(level, config, schema)
  level = level .. '.'
  for parameter, value in pairs(config) do
    local valueType = type(value)
    local schemaValue = schema[parameter]
    local schemaType = type(schemaValue)

    if schemaType == 'nil' then
      PrintInvalidConfigHeader()
      table.insert(html, 'Parameter "' .. PGC.HTMLEscape(level .. parameter) .. '" is unknown.')
    elseif schemaType == 'string' then -- see ValidateValue() for the schema syntax
      ValidateValue(level .. parameter, value, schemaValue)
    elseif schemaType == 'table' then -- definition of allowed sub-properties of a table parameter
      if valueType == 'table' then
        if schemaValue[1] then
          for idx, v in ipairs(value) do
            ValidateParameters(level .. parameter .. '[' .. idx .. ']', v, schemaValue[1])
          end

          -- make sure no other properties exist that are not indices of the table
          for k, v in pairs(value) do
            if type(k) ~= 'number' then
              PrintInvalidConfigHeader()
              table.insert(html, 'Parameter "' .. PGC.HTMLEscape(level .. parameter) .. '" must be an array. Parameter "' .. PGC.HTMLEscape(tostring(k)) .. '" is not allowed here.')
            end
          end
        else
          ValidateParameters(level .. parameter, value, schemaValue)
        end
      else
        PrintInvalidConfigHeader()
        table.insert(html, 'Parameter "' .. PGC.HTMLEscape(level .. parameter) .. '" has type ' .. valueType.. '. Expected to be a table.')
      end
    else
      PrintInvalidConfigHeader()
      table.insert(html, 'Parameter "' .. PGC.HTMLEscape(level .. parameter) .. '" has unsupported type in schema!')
    end
  end
end

-- the set of properties a single advanced filter (leaf) object may have, and their allowed types
local filterObjectSchema = {
  field   = "string(1,)",
  field2  = "string(1,)",
  include = "[array]boolean|[array]number|[array]string",
  exclude = "[array]boolean|[array]number|[array]string",
  min     = "number|string",
  max     = "number|string",
  op      = "string{'EQ','NE','GT','GE','LT','LE'}"
}

-- recursively validate conf.filters: each element is either a filter object
-- (validated against filterObjectSchema) or a nested array of the same kind
-- (alternating AND/OR grouping) -- mirrors FilterAND()/FilterOR()'s own
-- filter[1] test exactly, so validation can never disagree with execution.
--
-- the generic "is this an array, are all elements tables, are there no stray non-index keys"
-- shape check -- at every nesting level, since this function recurses for nested groups -- is
-- now delegated to ValidateValue()/"array<table>" instead of hand-rolled here; a Lua table
-- element can still be either a leaf object or a nested group, which the schema mini-language
-- has no way to tell apart (it only knows "any table"), so that distinction, filterObjectSchema,
-- and the mutual-exclusivity business rules below still need to be checked by hand.
function ValidateFilters(level, filters)
  ValidateValue(level, filters, "array<table>")
  if type(filters) ~= 'table' then
    return -- ValidateValue() already reported the type mismatch above
  end

  for idx, filter in ipairs(filters) do
    local sublevel = level .. '[' .. idx .. ']'
    if type(filter) == 'table' then -- otherwise ValidateValue() already reported this element above
      if filter[1] then
        ValidateFilters(sublevel, filter)  -- nested group: recurse
      else
        -- leaf filter object
        ValidateParameters(sublevel, filter, filterObjectSchema)

        EnsureMandatory(filter.field, sublevel .. '.field')

        -- a filter must use EXACTLY one of these mutually exclusive check styles:
        --   include alone | exclude alone | min and/or max | op with field2
        -- when field=='attribute', include and exclude may be combined, but none of the others are allowed
        local hasInclude = filter.include ~= nil
        local hasExclude = filter.exclude ~= nil
        local hasIncludeExclude = Ternary(filter.field == 'attribute', hasInclude or hasExclude, nil)
        local hasMinMax = (filter.min ~= nil) or (filter.max ~= nil)
        local hasOpStyle = (filter.op ~= nil) or (filter.field2 ~= nil)

        if (filter.field == 'attribute') and (hasMinMax or hasOpStyle) then
          PrintInvalidConfigHeader()
          table.insert(html, 'Parameter "' .. PGC.HTMLEscape(sublevel) .. '" only supports "include" and "exclude" when "field" is "attribute". "min", "max", "op" and "field2" are not supported there.')
        end

        local categories
        if hasIncludeExclude ~= nil then
          categories = { hasIncludeExclude, hasMinMax, hasOpStyle }
        else
          categories = { hasInclude, hasExclude, hasMinMax, hasOpStyle }
        end

        local categoryCount = 0
        for _, hasCategory in ipairs(categories) do
          if hasCategory then categoryCount = categoryCount + 1 end
        end

        if EnsureAtLeastOne(categories, 'Parameter "' .. PGC.HTMLEscape(sublevel) .. '" must set exactly one of: include, exclude, min and/or max, or op with field2.') then
          if categoryCount > 1 then
            PrintInvalidConfigHeader()
            table.insert(html, 'Parameter "' .. PGC.HTMLEscape(sublevel) .. '" combines multiple check styles (include/exclude/min-max/op-field2). Only one is allowed; the others would be silently ignored.')
          elseif hasOpStyle and ((filter.op == nil) or (filter.field2 == nil)) then
            PrintInvalidConfigHeader()
            table.insert(html, 'Parameter "' .. PGC.HTMLEscape(sublevel) .. '" must set both op and field2 together.')
          end
        end
      end
    end
  end
end

-- recursively normalize an already-validated conf.filters: a scalar or array 'include'/'exclude'
-- becomes an associative table -- so CheckFilter() only ever needs a direct key lookup.
-- Mirrors ValidateFilters()'s own filter[1] group-vs-leaf recursion.
function NormalizeFilters(filters)
  for _, filter in ipairs(filters) do
    if filter[1] then
      NormalizeFilters(filter) -- nested group: recurse
    else
      if filter.include ~= nil then
        filter.include = ConvertToAssociativeTable(filter.include)
        if filter.field == 'type' then
          ResolveTypeMacros(filter.include)
        end
      end

      if filter.exclude ~= nil then
        filter.exclude = ConvertToAssociativeTable(filter.exclude)
        if filter.field == 'type' then
          ResolveTypeMacros(filter.exclude)
        end
      end
    end
  end
end

-- validate conf.continent_remap: an object mapping a continent name to an array of entries,
-- where each entry is either a country name, or an object mapping one or more countries to
-- their list of regions on that continent (same shape as the internal 'continents' definitions)
function ValidateContinentRemap(level, remap)
  ValidateValue(level, remap, "table")
  if type(remap) ~= 'table' then
    return -- ValidateValue() already reported the type mismatch above
  end

  for continentName, entries in pairs(remap) do
    local sublevel = level .. '.' .. tostring(continentName)
    ValidateValue(sublevel, entries, "array<string(1,)|table>(1,)")
    if type(entries) == 'table' then
      for idx, entry in ipairs(entries) do
        if type(entry) == 'table' then
          local entrySublevel = sublevel .. '[' .. idx .. ']'
          if Count(entry) == 0 then
            PrintInvalidConfigHeader()
            table.insert(html, 'Parameter "' .. PGC.HTMLEscape(entrySublevel) .. '" must contain at least one country/regions pair.')
          else
            for country, regions in pairs(entry) do
              ValidateValue(entrySublevel .. '.' .. tostring(country), regions, "array<string(1,)>(1,)")
            end
          end
        end
      end
    end
  end
end

--------------- helper functions related to checker initialization ---------------

-- initialize global variables
function Initialize_GlobalVariables()
  supported_GetFinds_fields = ConvertToAssociativeTable(supported_GetFinds_fields)
  event_types = ConvertToAssociativeTable(event_types)
  physical_types = ConvertToAssociativeTable(physical_types)

  for idx, value in ipairs(all_types) do
    all_types_sort_index[value] = idx
  end

  for idx, value in ipairs(all_sizes) do
    all_sizes_sort_index[value] = idx
  end

  for idx, value in ipairs(daynames_long) do
    daynames_sort_index[value] = Ternary(conf.weekStartsOnMonday and (idx == 1), 8, idx)
  end

  for idx, value in ipairs(daynames_short) do
    daynames_sort_index[value] = Ternary(conf.weekStartsOnMonday and (idx == 1), 8, idx)
  end

  for idx, value in ipairs(monthnames_long) do
    monthnames_sort_index[value] = idx
  end

  for idx, value in ipairs(monthnames_short) do
    monthnames_sort_index[value] = idx
  end

  -- initialize names for the flag that indicates that read() was already called. Only needed on fields that have a read function.
  for key, field in pairs(known_fields) do
    if field.read ~= nil then
      field.readFlag = '_read_' .. key
    end
  end

  local v = 1
  for i = 1, 32 do
    bitValues[i] = v
    v = v * 2
  end

  -- build the time zone sort order (chronologically, UTC-12:00 to UTC+14:00) from 'timezones''s own keys
  local sortedTimezones = AssociativeTable_KeysToIndexedTable(timezones)
  table.sort(sortedTimezones, function(a, b) return TimezoneOffsetInMinutes(a) < TimezoneOffsetInMinutes(b) end)
  for idx, timezone in ipairs(sortedTimezones) do
    timezones_sort_index[timezone] = idx
  end

  -- build the 'country'/'country/region'/'country//county' -> time zone lookup table from 'timezones'
  for timezone, countriesAndRegions in pairs(timezones) do
    for key, value in pairs(countriesAndRegions) do
      if type(value) == 'table' then
        -- key is the country, value is a list of its regions (and/or unnamed county lists) in this time zone
        for _, regionOrCounties in ipairs(value) do
          if type(regionOrCounties) == 'table' then
            -- regionOrCounties is an unnamed list of specific counties of this country in this time zone
            for _, county in ipairs(regionOrCounties) do
              timezones_lookup[key .. '//' .. county] = timezone
            end
          else
            -- regionOrCounties is a region name
            timezones_lookup[key .. '/' .. regionOrCounties] = timezone
          end
        end
      else
        -- value is a whole country, with no region breakdown needed in this time zone
        timezones_lookup[value] = timezone
      end
    end
  end
end

-- collect the set of countries referenced by conf.continent_remap (a plain string entry
-- contributes itself, a single-key {country = regions} entry contributes its key)
function CollectCountriesFromRemap(remap)
  local countries = {}
  for _, entries in pairs(remap) do
    for _, entry in ipairs(entries) do
      if type(entry) == 'table' then
        for country, _ in pairs(entry) do
          countries[country] = true
        end
      else
        countries[entry] = true
      end
    end
  end
  return countries
end

-- remove every entry (whole-country string, or country-with-regions hash key) belonging to
-- one of 'countriesToRemove' from every continent in 'continents'
function RemoveCountriesFromContinents(countriesToRemove)
  for continentName, entries in pairs(continents) do
    local filtered = {}
    for key, value in pairs(entries) do
      if type(key) == 'number' then
        if not countriesToRemove[value] then
          table.insert(filtered, value)
        end
      elseif not countriesToRemove[key] then
        filtered[key] = value
      end
    end
    continents[continentName] = filtered
  end
end

-- merge conf.continent_remap's entries into 'continents', creating a new continent if needed
function MergeContinentRemap(remap)
  for continentName, entries in pairs(remap) do
    continents[continentName] = continents[continentName] or {}
    for _, entry in ipairs(entries) do
      if type(entry) == 'table' then
        for country, regions in pairs(entry) do
          continents[continentName][country] = regions
        end
      else
        table.insert(continents[continentName], entry)
      end
    end
  end
end

-- apply conf.continent_remap to 'continents': first remove every referenced country from
-- wherever it currently is, then merge conf.continent_remap's entries in
function ApplyContinentRemap()
  if conf.continent_remap == nil then
    return
  end

  local countriesToRemove = CollectCountriesFromRemap(conf.continent_remap)
  RemoveCountriesFromContinents(countriesToRemove)
  MergeContinentRemap(conf.continent_remap)
end

-- build the 'country'/'country/region' -> continent lookup table from 'continents'
function BuildContinentsLookup()
  continents_lookup = {}
  for continent, countriesAndRegions in pairs(continents) do
    for key, value in pairs(countriesAndRegions) do
      if type(value) == 'table' then
        -- key is the country, value is the list of its regions on this continent
        for _, region in ipairs(value) do
          continents_lookup[key .. '/' .. region] = continent
        end
      else
        -- value is a whole country, with no region breakdown needed on this continent
        continents_lookup[value] = continent
      end
    end
  end
end

-- replace cache type macros with list of concrete types
function ResolveTypeMacros(types)
  if types == nil then
    return
  end

  if types[macro_events] then
    types[macro_events] = nil
    for eventType in pairs(event_types) do
      types[eventType] = true
    end
  end

  if types[macro_physical] then
    types[macro_physical] = nil
    for physicalType in pairs(physical_types) do
      types[physicalType] = true
    end
  end
end

-- exclude travelling caches and locationless cache if not yet configured otherwise
function ExcludeLocationRelatedCachesByDefault()
  if canExcludeLocationRelatedCaches then
    conf.excludeTravelingGeocaches = true

    if Count(conf.filter.types) == 0 then
      conf.excludedTypes = 'Locationless Cache'
      excludedTypes = ConvertToAssociativeTable(conf.excludedTypes)
      table.insert(fields, 'type')
    end
    canExcludeLocationRelatedCaches = false
  end
end

-- build the "{v1,v2,...}" number-enum fragment of a schema type spec from a list of numbers,
-- e.g. all_ratings -> "1,1.5,2,2.5,3,3.5,4,4.5,5"
function BuildNumberEnumList(values)
  local parts = {}
  for idx, value in ipairs(values) do
    parts[idx] = (value % 1 == 0) and string.format('%d', value) or tostring(value)
  end
  return table.concat(parts, ',')
end

-- build the "{'v1','v2',...}" string-enum fragment of a schema type spec from a list of strings,
-- e.g. all_sizes -> "'Micro','Small','Regular','Large','Other','Virtual','Not chosen'"
function BuildStringEnumList(values)
  local parts = {}
  for idx, value in ipairs(values) do
    parts[idx] = "'" .. value .. "'"
  end
  return table.concat(parts, ',')
end

-- all allowed parameters with their types; will be filled by RegisterCommonParameters() and RegisterScriptIndividualParameters()
local supportedParameters = {}

-- register the scheme for parameters that are common for all scripts
function RegisterCommonParameters()
  -- difficulties and terrains share the same 1.0..5.0 rating scale, in 0.5 steps
  local ratingsSchema = "[array]number{" .. BuildNumberEnumList(all_ratings) .. "}"
  local sizesSchema = "[array]string{" .. BuildStringEnumList(all_sizes) .. "}"
  local typesSchema = "[array]string{" .. BuildStringEnumList(all_types) .. "}"
  local monthnamesSchema = "[array]string{" .. BuildStringEnumList(monthnames_long) .. "}"
  local daynamesSchema = "[array]string{" .. BuildStringEnumList(daynames_long) .. "}"

  supportedParameters = {
    ElevationBands = "array<int>(1,)", -- array of ints with at least 1 element
    links = "boolean",
    showFiltersInExampleLog = "boolean",
    GetHides = "boolean",
    country = "[array]string(1,)",
    excludedCountry = "[array]string(1,)",
    excludeMostFoundCountry = "boolean",
    region = "[array]string(1,)",
    excludedRegion = "[array]string(1,)",
    county = "[array]string(1,)",
    excludedCounty = "[array]string(1,)",
    minVisitDate = "string(1,)",
    maxVisitDate = "string(1,)",
    minHiddenDate = "string(1,)",
    maxHiddenDate = "string(1,)",
    monthnames = monthnamesSchema,
    daynames = daynamesSchema,
    types = typesSchema,
    excludedTypes = typesSchema,
    sizes = sizesSchema,
    excludedSizes = sizesSchema,
    difficulties = ratingsSchema,
    excludedDifficulties = ratingsSchema,
    terrains = ratingsSchema,
    excludedTerrains = ratingsSchema,
    minFavoritePoints = "int[1,]",
    minElevation = "int",
    maxElevation = "int",
    minElevation_ft = "int",
    maxElevation_ft = "int",
    attribute = "int[-96,192]",
    excludedAttribute = "int[-96,192]",
    excludeTravelingGeocaches = "boolean",
    excludeDupFinds = "boolean",
    includeLabCaches = "boolean",
    excludedCaches = "[array]string(3,)",
    filter = "table", -- allow native PGC.GetFinds() filters without further validation
    filters = "table", -- detailed structure is checked seperately via ValidateFilters() since it has a more complicated structure
    continent_remap = "table", -- detailed structure is checked seperately via ValidateContinentRemap() since it has a more complicated structure
    log = {
      format = "string(1,)",
      showIcons = "boolean",
      sort = "string{'A-Z','Z-A'}|array<boolean|number|string>(1,)",
      sortByProperty = "string(1,)",
      limit = "int[1,]"
    },
    weekStartsOnMonday = "boolean",
    ShowTimeZoneDefinitions = "boolean",
    ShowContinentDefinitions = "boolean",
    colorCountyPassed = "string(1,)",
    colorCountyMissing = "string(1,)",
    colorRegionPassed = "string(1,)",
    colorRegionMissing = "string(1,)",
    colorCountryPassed = "string(1,)",
    colorCountryMissing = "string(1,)",
    opacityCounty = "number[0,1]",
    opacityRegion = "number[0,1]",
    opacityCountry = "number[0,1]",
    debug = "boolean"
  }
end

-- do the common part of the initialization
function Initialize_Common()
  ApplyContinentRemap()
  BuildContinentsLookup()

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

  conf.filter = conf.filter or {}
  conf.filter.country = conf.filter.country or conf.country
  conf.filter.region = conf.filter.region or conf.region
  conf.filter.county = conf.filter.county or conf.county
  conf.filter.minVisitDate = ResolveRelativeDate(conf.filter.minVisitDate or conf.minVisitDate, 'conf.minVisitDate')
  conf.filter.maxVisitDate = ResolveRelativeDate(conf.filter.maxVisitDate or conf.maxVisitDate, 'conf.maxVisitDate')
  conf.filter.minHiddenDate = ResolveRelativeDate(conf.filter.minHiddenDate or conf.minHiddenDate, 'conf.minHiddenDate')
  conf.filter.maxHiddenDate = ResolveRelativeDate(conf.filter.maxHiddenDate or conf.maxHiddenDate, 'conf.maxHiddenDate')
  conf.filter.monthnames = IndexedTable_FromValue(conf.filter.monthnames or conf.monthnames)
  conf.filter.daynames = IndexedTable_FromValue(conf.filter.daynames or conf.daynames)
  conf.filter.minFavoritePoints = conf.filter.minFavoritePoints or conf.minFavoritePoints

  ResolveContinentNames()
  conf.filter.country = IndexedTable_RemoveDuplicates(conf.filter.country)
  conf.filter.region = IndexedTable_RemoveDuplicates(conf.filter.region)
  conf.filter.county = IndexedTable_RemoveDuplicates(conf.filter.county)

  local types = ConvertToAssociativeTable(conf.filter.types or conf.types)
  ResolveTypeMacros(types)
  if types and types[type_Labcache] then
    types[type_Labcache] = nil
    conf.includeLabCaches = true
  end
  conf.filter.types = AssociativeTable_KeysToIndexedTable(types)

  if (conf.filter.sizes ~= nil) or (conf.sizes ~= nil) or (conf.excludedSizes ~= nil) then
    local sizes = ConvertToAssociativeTable(conf.filter.sizes or conf.sizes or all_sizes)
    AssociativeTable_Except(sizes, ConvertToAssociativeTable(conf.excludedSizes))
    conf.filter.sizes = AssociativeTable_KeysToIndexedTable(sizes)
  end

  if (conf.filter.difficulties ~= nil) or (conf.difficulties ~= nil) or (conf.excludedDifficulties ~= nil) then
    -- conf.filter.difficulties is not schema-validated, so it may contain non-number keys (e.g. strings); normalize them to numbers here
    local difficulties = AssociativeTable_KeysToNumber(ConvertToAssociativeTable(conf.filter.difficulties or conf.difficulties or all_ratings))
    local excludedDifficulties = ConvertToAssociativeTable(conf.excludedDifficulties)
    AssociativeTable_Except(difficulties, excludedDifficulties)
    conf.filter.difficulties = AssociativeTable_KeysToIndexedTable(difficulties)
  end

  if (conf.filter.terrains ~= nil) or (conf.terrains ~= nil) or (conf.excludedTerrains ~= nil) then
    -- conf.filter.terrains is not schema-validated, so it may contain non-number keys (e.g. strings); normalize them to numbers here
    local terrains = AssociativeTable_KeysToNumber(ConvertToAssociativeTable(conf.filter.terrains or conf.terrains or all_ratings))
    local excludedTerrains = ConvertToAssociativeTable(conf.excludedTerrains)
    AssociativeTable_Except(terrains, excludedTerrains)
    conf.filter.terrains = AssociativeTable_KeysToIndexedTable(terrains)
  end

  excludedTypes = ConvertToAssociativeTable(conf.excludedTypes) or {}
  ResolveTypeMacros(excludedTypes)
  if (Count(excludedTypes) > 0) then
    table.insert(fields, 'type')
    conf.excludedTypes = AssociativeTable_KeysToIndexedTable(excludedTypes)
  end

  canExcludeLocationRelatedCaches = (conf.excludeTravelingGeocaches == nil) and (Count(excludedTypes) == 0)

  excludedCountries = ConvertToAssociativeTable(conf.excludedCountry) or {}
  if (Count(excludedCountries) > 0) then
    table.insert(fields, 'country')
    ExcludeLocationRelatedCachesByDefault()
  end

  excludedRegions = ConvertToAssociativeTable(conf.excludedRegion) or {}
  if (Count(excludedRegions) > 0) then
    table.insert(fields, 'region')
    ExcludeLocationRelatedCachesByDefault()
  end

  excludedCounties = ConvertToAssociativeTable(conf.excludedCounty) or {}
  if (Count(excludedCounties) > 0) then
    table.insert(fields, 'county')
    ExcludeLocationRelatedCachesByDefault()
  end

  VerifyAreaNames()

  excludedCaches = ConvertToAssociativeTable(conf.excludedCaches) or {}

  if conf.minElevation or conf.maxElevation or conf.minElevation_ft or conf.maxElevation_ft then
    table.insert(fields, 'elevation')
    ExcludeLocationRelatedCachesByDefault()
  end

  if conf.filter.country or conf.filter.region or conf.filter.county or conf.excludeMostFoundCountry then
    ExcludeLocationRelatedCachesByDefault()
  end

  -- attribute numbers are 1..96 for positive and -1..-96 for negative attributes.
  -- ValidateParameters() already ensured a whole number in the range -96..192, so 0 is the only remaining invalid value.
  if conf.attribute == 0 then
    PrintInvalidConfigHeader()
    table.insert(html, 'Parameter "conf.attribute" must not be 0.')
  end

  if conf.excludedAttribute == 0 then
    PrintInvalidConfigHeader()
    table.insert(html, 'Parameter "conf.excludedAttribute" must not be 0.')
  end

  if (conf.attribute ~= nil) or (conf.excludedAttribute ~= nil) then
    table.insert(fields, 'attributes_set')
    table.insert(fields, 'attributes_unset')
  end

  if conf.excludeMostFoundCountry then
    table.insert(fields, 'country')
    local mostFoundCountry = GetMostFoundCountry()
    local txt = ''
    if mostFoundCountry ~= nil then
      txt = 'Excluded ' .. mostFoundCountry .. ' as the country with most finds.'
      excludedCountries[mostFoundCountry] = true
    else
      txt = 'Error: could not determine which country has the most finds.'
    end
    PGC.print(txt, '\n')
    table.insert(log, txt)
    table.insert(html, PGC.HTMLEscape(txt))
  end

  if type(conf.ElevationBands) == 'table' then
    for i = 2, #conf.ElevationBands do
      if not (conf.ElevationBands[i] > conf.ElevationBands[i - 1]) then
        PrintInvalidConfigHeader()
        table.insert(html, 'Parameter "conf.ElevationBands" must be configured in ascending order: value ' .. conf.ElevationBands[i] .. ' at index ' .. i .. ' is not greater than value ' .. conf.ElevationBands[i - 1] .. ' at index ' .. (i - 1) .. '.')
      end
    end
  end

  if conf.includeLabCaches then
    -- PGC.GetFinds() does not apply its own minVisitDate/maxVisitDate/monthnames/daynames
    -- filtering to Lab Caches, so replicate those criteria (if set) as Advanced Filters
    -- instead -- FilterCache() applies conf.filters to every cache, Lab or not.
    if conf.filters == nil then
      conf.filters = {}
      conf.filters.hidden = true -- no filters were configured before these Lab Cache filters got auto-added, so don't print them to not show the same filters twice
    end

    if (conf.filter.minVisitDate ~= nil) or (conf.filter.maxVisitDate ~= nil) then
      table.insert(conf.filters, { field = 'visitdate', min = conf.filter.minVisitDate, max = conf.filter.maxVisitDate })
    end

    if conf.filter.monthnames ~= nil then
      table.insert(conf.filters, { field = 'visit_monthname', include = ConvertToAssociativeTable(conf.filter.monthnames) })
    end

    if conf.filter.daynames ~= nil then
      table.insert(conf.filters, { field = 'visit_weekday', include = ConvertToAssociativeTable(conf.filter.daynames) })
    end
  end

  AddFilterFields(conf.filters)

  conf.links = GetOrDefault(conf.links, true)
  conf.showFiltersInExampleLog = GetOrDefault(conf.showFiltersInExampleLog, true)

  -- add fields needed for logging and validate "sort", if set
  if conf.log then
    if type(conf.log.sort) == 'table' then
      if #conf.log.sort == 0 then
        PrintInvalidConfigHeader()
        table.insert(html, 'Parameter "conf.log.sort" must not be an empty array.')
      end
    end

    -- add fields that shall be printed
    AddFormatStringFields(conf.log.format)

    -- add fields that are used to sort the log entries
    if conf.log.sortByProperty then
      IndexedTable_Append(fields, GetRequiredFields(conf.log.sortByProperty))
    end

    conf.log.showIcons = GetOrDefault(conf.log.showIcons, true)
  end

  if conf.GetHides and (conf.includeLabCaches ~= nil or userSetExcludeTravelingGeocaches or (conf.excludeDupFinds ~= nil) or (Count(conf.filter) > 0)) then
    PrintInvalidConfigHeader()
    table.insert(html, 'PGC.GetHides() does not support "includeLabCaches", "excludeTravelingGeocaches", "excludeDupFinds", or "filter". Please use Advanced Filters instead.')
  end

  if #html > 0 then
    table.insert(log, '')
    table.insert(html, '')
  end
end

-- perform the initialization steps and get the caches if no configuration error is detected
function Init()
  Initialize_GlobalVariables()
  RegisterCommonParameters()
  RegisterScriptIndividualParameters() -- this must be done after RegisterCommonParameters()

  ValidateParameters('conf', conf, supportedParameters)

  if (conf.filters ~= nil) and not invalidConfigPrinted then
    ValidateFilters('conf.filters', conf.filters)

    if not invalidConfigPrinted then
      NormalizeFilters(conf.filters)
    end
  end

  if (conf.continent_remap ~= nil) and not invalidConfigPrinted then
    ValidateContinentRemap('conf.continent_remap', conf.continent_remap)
  end

  if not invalidConfigPrinted then
    Initialize_Common()
    Initialize_ScriptIndividual()

    EnsureMandatory(conf.ElevationBands, 'conf.ElevationBands', usesElevationBands, 'because elevation bands are used')
  end

  if invalidConfigPrinted then
    return nil -- early abort due to configuration errors, so that no caches are fetched and no further processing is done
  end

  -- everything is valid, so print the filters and get the caches
  PrintFilters()

  fields = IndexedTable_RemoveDuplicates(fields)
  if conf.debug then
    PGC.print('Fields:\n')
    LogAsYAML(fields)
  end

  local caches = {}
  if conf.GetHides then
    -- get all hides of profile
    caches = FilterCaches(PGC.GetHides(profileId, { fields = fields }))
    PGC.print(#caches, ' caches hidden that satisfy filter criteria.\n')
    table.insert(html, 'Attention: This checker uses OWNED caches instead of FOUND caches.')
  else
    -- get all finds of profile
    local excludeDupFinds = GetOrDefault(conf.excludeDupFinds, true)
    caches = FilterCaches(PGC.GetFinds(profileId, { fields = fields, excludeDupFinds = excludeDupFinds, excludeTravelingGeocaches = conf.excludeTravelingGeocaches, includeLabCaches = conf.includeLabCaches, order = 'OLDESTFIRST', filter = conf.filter }))
    PGC.print(#caches, ' caches found that satisfy filter criteria (duplicated finds ', Ternary(excludeDupFinds, 'excluded', 'included'), ').\n')
  end

  if #caches == 0 then
    table.insert(html, TestPassedIcon(false) .. ' No caches were ' .. Ternary(conf.GetHides, 'hidden', 'found') .. ' that match the filter criteria.')
    return nil
  end

  return caches
end

------------------------ script individual global variables ------------------------

local abortDuringConstraintChecking = false
local abortDuringDiversityChecking = false
local cellEnabled = {}
local numEnabledCells = 81
local minValueGrid = {}
local showMinValues = false

--------------- hooks that need to be implemented by the derived script ---------------

-- register the scheme for parameters that are individual for this script
function RegisterScriptIndividualParameters()
  local individualParameters = {
    same = {
      field = "string(1,)",
      limit = "int[0,]",
      num_hints = "int[0,]",
      combine_results = "boolean",
      sort = "string{'A-Z','Z-A'}",
      showAllTestResults = "boolean",
    },
    conditions = {
      entries = "int[1,]",
      loops = "int[1,]",
      loopsPer = "int[1,]",
      vertical = "int[1,]",
      horizontal = "int[1,]",
      vertical_horizontal = "int[1,]",
      left_diagonal = "int[1,]",
      right_diagonal = "int[1,]",
      diagonal = "int[1,]",
      total_lines = "int[1,]",
      vertical_sum = "int[1,]",
      horizontal_sum = "int[1,]",
      vertical_horizontal_sum = "int[1,]",
      total_lines_sum = "int[1,]",
      total = "int[1,]",
      passedEntriesTotal = "int[1,]",
      line2_sum_min = "number",
      line2_sum_max = "number",
      unique_entries = "int[1,]"
    },
    constraints = {
      field = "string(1,)",
      maxRepeatedValueTotal = "int[1,]",
      maxRepeatedValuePerHorizontal = "int[1,]",
      maxRepeatedValuePerVertical = "int[1,]"
    },
    diversityConstraints = {
      field = "string(1,)",
      minDifferentValuesTotal = "int[1,]",
      minDifferentValuesPerHorizontal = "int[1,]",
      minDifferentValuesPerVertical = "int[1,]"
    },
    minValue = "int[1,]|array<int[1,]>(1,)|array<array<int[0,]>(9)>(9)",
    mask = "array<string(9)>(9)",
    minSum = "int[1,]",
    sumOnlyPassedEntries = "boolean",
    showSums = "boolean",
    cell_format_line1 = "string(1,)",
    cell_format_line2 = "string(1,)",
    sort_by_line2 = "string{'less','greater'}",
    line2_sum_all_entries = "boolean",
    unique_entry_property = "string(1,)",
    unique_passed_entries_only = "boolean",
    showAsIcon = "boolean",
    showMap = "boolean"
  }
  AssociativeTable_Join(supportedParameters, individualParameters)
  supportedParameters.log = nil
end

-- do the script individual part of the initialization
function Initialize_ScriptIndividual()
  conf.showMap = GetOrDefault(conf.showMap, true)

  table.insert(fields, 'difficulty')
  table.insert(fields, 'terrain')

  local combine_results = false

  if (type(conf.same) == 'table') then
    if conf.same.field then
      IndexedTable_Append(fields, GetRequiredFields(conf.same.field))
      if IsBasedOnCacheLocation(conf.same.field) then
        ExcludeLocationRelatedCachesByDefault()
      end

      conf.same.limit = GetOrDefault(conf.same.limit, 1)
      conf.same.num_hints = GetOrDefault(conf.same.num_hints, 0)
      conf.same.showAllTestResults = GetOrDefault(conf.same.showAllTestResults, false)
      combine_results = conf.same.combine_results
    else
      EnsureMandatory(conf.same.field, 'conf.same.field', true, 'when "conf.same" is used')
    end
  else
    conf.same = nil
  end

  if type(conf.constraints) == 'table' then
    if conf.constraints.field then
      IndexedTable_Append(fields, GetRequiredFields(conf.constraints.field))
      if IsBasedOnCacheLocation(conf.constraints.field) then
        ExcludeLocationRelatedCachesByDefault()
      end
      conf.constraints.maxRepeatedValueTotal = GetOrDefault(conf.constraints.maxRepeatedValueTotal, 81)
      conf.constraints.maxRepeatedValuePerHorizontal = GetOrDefault(conf.constraints.maxRepeatedValuePerHorizontal, 9)
      conf.constraints.maxRepeatedValuePerVertical = GetOrDefault(conf.constraints.maxRepeatedValuePerVertical, 9)
    else
      EnsureMandatory(conf.constraints.field, 'conf.constraints.field', true, 'when "conf.constraints" is used')
      return
    end
  end

  if type(conf.diversityConstraints) == 'table' then
    if conf.diversityConstraints.field then
      IndexedTable_Append(fields, GetRequiredFields(conf.diversityConstraints.field))
      if IsBasedOnCacheLocation(conf.diversityConstraints.field) then
        ExcludeLocationRelatedCachesByDefault()
      end

      if not EnsureAtLeastOne({
        conf.diversityConstraints.minDifferentValuesTotal ~= nil,
        conf.diversityConstraints.minDifferentValuesPerHorizontal ~= nil,
        conf.diversityConstraints.minDifferentValuesPerVertical ~= nil
      }, 'At least one of "minDifferentValuesTotal", "minDifferentValuesPerHorizontal" or "minDifferentValuesPerVertical" must be set in "conf.diversityConstraints".') then
        return
      end
    else
      EnsureMandatory(conf.diversityConstraints.field, 'conf.diversityConstraints.field', true, 'when "conf.diversityConstraints" is used')
      return
    end
  end

  if not EnsureMutuallyExclusive(type(conf.constraints) == 'table', type(conf.diversityConstraints) == 'table', '"conf.constraints" and "conf.diversityConstraints" cannot be used together.') then
    return
  end

  cellEnabled = CreateGrid(true)

  if type(conf.mask) == 'table' then
    for d = 1, 9 do
      local mask = conf.mask[d]
      for t = 1, 9 do
        local char = mask:sub(t, t)
        if char == '0' then
          cellEnabled[d][t] = false
          numEnabledCells = numEnabledCells - 1
        elseif char ~= '1' then
          PrintInvalidConfigHeader()
          table.insert(html, 'conf.mask[' .. d .. '][' .. t .. '] must be only "0" for disabled or "1" for enabled.')
          return
        end
      end
    end

    if numEnabledCells < 1 then
      PrintInvalidConfigHeader()
      table.insert(html, 'At least one cell must be enabled in conf.mask.')
      return
    end
  end

  if conf.conditions == nil then
    conf.conditions = {}
  end

  conf.conditions.entries = GetOrDefault(conf.conditions.entries, 0)
  conf.conditions.loops = GetOrDefault(conf.conditions.loops, 0)
  conf.conditions.loopsPer = GetOrDefault(conf.conditions.loopsPer, 0)
  if conf.conditions.loopsPer > 0 then
    conf.conditions.loops = conf.conditions.loops + math.floor(GetFindCount() / conf.conditions.loopsPer)
  end

  conf.conditions.vertical = GetOrDefault(conf.conditions.vertical, 0)
  conf.conditions.horizontal = GetOrDefault(conf.conditions.horizontal, 0)
  conf.conditions.vertical_horizontal = GetOrDefault(conf.conditions.vertical_horizontal, 0)
  conf.conditions.left_diagonal = GetOrDefault(conf.conditions.left_diagonal, 0)
  conf.conditions.right_diagonal = GetOrDefault(conf.conditions.right_diagonal, 0)
  conf.conditions.diagonal = GetOrDefault(conf.conditions.diagonal, 0)
  conf.conditions.total_lines = GetOrDefault(conf.conditions.total_lines, 0)
  conf.conditions.vertical_sum = GetOrDefault(conf.conditions.vertical_sum, 0)
  conf.conditions.horizontal_sum = GetOrDefault(conf.conditions.horizontal_sum, 0)
  conf.conditions.vertical_horizontal_sum = GetOrDefault(conf.conditions.vertical_horizontal_sum, 0)
  conf.conditions.total_lines_sum = GetOrDefault(conf.conditions.total_lines_sum, 0)
  conf.conditions.total = GetOrDefault(conf.conditions.total, 0)
  conf.conditions.passedEntriesTotal = GetOrDefault(conf.conditions.passedEntriesTotal, 0)

  conf.minSum = GetOrDefault(conf.minSum, 0)
  conf.sumOnlyPassedEntries = GetOrDefault(conf.sumOnlyPassedEntries, false)
  conf.line2_sum_all_entries = GetOrDefault(conf.line2_sum_all_entries, false)
  conf.showSums = GetOrDefault(conf.showSums, true)

  conf.cell_format_line1 = GetOrDefault(conf.cell_format_line1, 'n')
  IndexedTable_Append(fields, GetRequiredFields(conf.cell_format_line1))
  IndexedTable_Append(fields, GetRequiredFields(conf.cell_format_line2))
  if IsBasedOnCacheLocation(conf.cell_format_line2) then -- not needed for line1, only line2 can influence the passed/failed result
    ExcludeLocationRelatedCachesByDefault()
  end

  conf.conditions.unique_entries = GetOrDefault(conf.conditions.unique_entries, 0)
  if conf.conditions.unique_entries > 0 then
    table.insert(fields, 'cache_name')
  end

  EnsureMandatory(conf.unique_entry_property, 'conf.unique_entry_property', conf.conditions.unique_entries > 0, 'when "conf.conditions.unique_entries" is used')

  IndexedTable_Append(fields, GetRequiredFields(conf.unique_entry_property))
  if conf.unique_entry_property == 'region' then -- DrawUniqueEntryPolygon() also needs 'country'
    IndexedTable_Append(fields, { 'country' })
  elseif conf.unique_entry_property == 'county' then -- DrawUniqueEntryPolygon() also needs 'country' and 'region'
    IndexedTable_Append(fields, { 'country', 'region' })
  end
  if IsBasedOnCacheLocation(conf.unique_entry_property) then
    ExcludeLocationRelatedCachesByDefault()
  end

  conf.unique_passed_entries_only = GetOrDefault(conf.unique_passed_entries_only, false)

  -- clamp values to valid range
  if not combine_results then
    conf.conditions.vertical = Clamp(conf.conditions.vertical, 0, 9)
    conf.conditions.horizontal = Clamp(conf.conditions.horizontal, 0, 9)
    conf.conditions.vertical_horizontal = Clamp(conf.conditions.vertical_horizontal, 0, 18)
    conf.conditions.left_diagonal = Clamp(conf.conditions.left_diagonal, 0, 1)
    conf.conditions.right_diagonal = Clamp(conf.conditions.right_diagonal, 0, 1)
    conf.conditions.diagonal = Clamp(conf.conditions.diagonal, 0, 2)
    conf.conditions.total_lines = Clamp(conf.conditions.total_lines, 0, 20)
    conf.conditions.vertical_sum = Clamp(conf.conditions.vertical_sum, 0, 9)
    conf.conditions.horizontal_sum = Clamp(conf.conditions.horizontal_sum, 0, 9)
    conf.conditions.vertical_horizontal_sum = Clamp(conf.conditions.vertical_horizontal_sum, 0, 18)
    conf.conditions.total_lines_sum = Clamp(conf.conditions.total_lines_sum, 0, 20)
    conf.conditions.unique_entries = Clamp(conf.conditions.unique_entries, 0, numEnabledCells)
  end

  -- case 1: if loops are required, set minValue to number of loops
  if (conf.conditions.loops > 0) and (type(conf.minValue) ~= 'table') then
    conf.minValue = conf.conditions.loops
  end

  -- case 2: conf.minValue is a single number (or missing)
  if type(conf.minValue) ~= 'table' then
    conf.minValue = GetOrDefault(conf.minValue, 1)
    minValueGrid = CreateGrid(conf.minValue)
  else -- conf.minValue is a table of numbers or table of tables
    showMinValues = true
    minValueGrid = CreateGrid(0)

    if type(conf.minValue[1]) == 'table' then -- full DT grid
      for d = 1, 9 do
        local minValuesRow = conf.minValue[d]
        for t = 1, 9 do
          minValueGrid[d][t] = minValuesRow[t]
        end
      end
    else -- table of single numbers (i.e. not a full grid)
      local numEntriesGiven = #conf.minValue

      if conf.conditions.loops > 0 then -- if loops are required, set conf.conditions.entries to the number of enabled cells and fill up with the loop value
        local numEntriesToAdd = numEnabledCells - numEntriesGiven
        for i = 1, numEntriesToAdd do -- gets skipped if no more entries need to be added
          conf.minValue[numEntriesGiven + i] = conf.conditions.loops
        end
      else -- no loops required. if more entries are requested than minValues are given, fill up with value "1"
        local numEntriesToAdd = conf.conditions.entries - numEntriesGiven
        for i = 1, numEntriesToAdd do -- gets skipped if no more entries need to be added
          conf.minValue[numEntriesGiven + i] = 1
        end
      end

      table.sort(conf.minValue, function(a, b) return a > b end) -- sort required find counts (biggest number first)
      conf.conditions.entries = #conf.minValue

      if conf.conditions.entries > numEnabledCells then
        PrintInvalidConfigHeader()
        table.insert(html, 'Parameter "conf.minValue" has ' .. conf.conditions.entries .. ' entries, but only ' .. numEnabledCells .. ' cells are enabled in the grid. Every required find count needs its own cell.')
      end
    end
  end

  -- set required find count of all disabled cells to 0
  for d = 1, 9 do
    for t = 1, 9 do
      if not cellEnabled[d][t] then
        minValueGrid[d][t] = 0
      end
    end
  end

  if not combine_results then
    conf.conditions.entries = Clamp(conf.conditions.entries, 0, numEnabledCells)
  end

  EnsureAtLeastOne({
    conf.conditions.total > 0,
    conf.conditions.passedEntriesTotal > 0,
    conf.conditions.entries > 0,
    conf.conditions.loops > 0,
    conf.conditions.line2_sum_min ~= nil,
    conf.conditions.line2_sum_max ~= nil,
    conf.conditions.vertical_sum > 0,
    conf.conditions.horizontal_sum > 0,
    conf.conditions.vertical_horizontal_sum > 0,
    conf.conditions.total_lines_sum > 0,
    conf.conditions.vertical > 0,
    conf.conditions.horizontal > 0,
    conf.conditions.vertical_horizontal > 0,
    conf.conditions.left_diagonal > 0,
    conf.conditions.right_diagonal > 0,
    conf.conditions.diagonal > 0,
    conf.conditions.total_lines > 0,
    type(conf.constraints) == 'table',
    type(conf.diversityConstraints) == 'table',
    (conf.conditions.unique_entries > 0) and (conf.unique_entry_property ~= nil)
  }, 'No valid test conditions were specified. At least one of conf.conditions.* (or conf.constraints, or conf.diversityConstraints) must be set.')
end

--------------- more script individual function definitions ---------------

-- return a D/T grid that is initialized with the given value
function CreateGrid(value)
  local grid = {}

  for d = 1, 9 do
    grid[d] = {}
    for t = 1, 9 do
      grid[d][t] = TableCopy(value)
    end
  end

  return grid
end

-- sort caches into grid and return that grid
function FillGrid(caches)
  local grid = CreateGrid({})

  for _, c in ipairs(caches) do
    local d = tonumber(c.difficulty)
    local t = tonumber(c.terrain)
    if d and t then
      d = d * 2 - 1
      t = t * 2 - 1
      -- put cache into grid only if indices are valid and cell is enabled
      if cellEnabled[d] and cellEnabled[d][t] then
        c.dIndex = d
        c.tIndex = t
        table.insert(grid[d][t], c)
      end
    end
  end

  -- check if caches in each cell shall be sorted
  local sortFct = nil
  local sortField = conf.cell_format_line2
  if type(sortField) == 'string' then
    if (conf.sort_by_line2 == "less") then
      sortFct = function(a, b) return NilSafeLess(GetValue(a, sortField), GetValue(b, sortField)) end
    elseif (conf.sort_by_line2 == "greater") then
      sortFct = function(a, b) return NilSafeGreater(GetValue(a, sortField), GetValue(b, sortField)) end
    end
  end

  if sortFct then
    for d = 1, 9 do
      for t = 1, 9 do
        table.sort(grid[d][t], sortFct)
      end
    end
  end

  return grid
end

-- move the cache with the given gccode to the front and select it
function SelectCache(caches, gccode)
  if (type(caches) == 'table') and gccode then
    for _, c in ipairs(caches) do
      if c.gccode == gccode then
        c.IsSelected = true
        IndexedTable_MoveValueToFront(caches, c)
        return
      end
    end
  end
end

-- convert a 1-9 index for D or T back to the normal 1.0 .. 5.0 format
function DtToString(idxD, idxT)
  return string.format('D%.1f/T%.1f', (idxD + 1) / 2, (idxT + 1) / 2)
end

-- prepare a test run for the given caches
function InitTestRun(finds, sameLabel, sameValue)
  local testRun = {}
  if (sameLabel ~= nil) and (sameValue ~= nil) then
    testRun.sameValue = sameValue
    testRun.sameValueHeader = sameLabel .. tostring(sameValue)
    if conf.debug then
      PGC.print('InitTestRun ', testRun.sameValueHeader, ', ', #finds, ' caches\n')
    end
  end
  testRun.findsGrid = FillGrid(finds)
  testRun.results = {}
  testRun.results.entries = 0
  testRun.results.loops = 0
  testRun.results.passedVerticals = { numPassedLines = 0 }
  testRun.results.passedHorizontals = { numPassedLines = 0 }
  testRun.results.passedVerticalHorizontal = 0
  testRun.results.passedLeftDiagonal = 0
  testRun.results.passedRightDiagonal = 0
  testRun.results.passedDiagonals = 0
  testRun.results.passedTotalLines = 0
  testRun.results.verticalSumsNr = 0
  testRun.results.horizontalSumsNr = 0
  testRun.results.verticalHorizontalSumsNr = 0
  testRun.results.totalLinesSumsNr = 0
  testRun.results.total = 0
  testRun.results.passedEntriesTotal = 0
  testRun.results.line2Sum = 0
  testRun.constraintsBestSolution = { totalSelected = 0 }
  testRun.diversityConstraintsOk = false
  testRun.unique_ok = false
  testRun.unique_bestSolutionCount = 0
  testRun.tests = {}
  testRun.score = 0 -- score how much was completed (used to sort best test runs)
  testRun.ok = true
  return testRun
end

-- collect all data for the tests
function ComputeTestResults(testRun)
  CheckConditions(testRun)
  CheckConstraints(testRun)
  CheckDiversityConstraints(testRun)
  CheckUniqueEntries(testRun)
end

-- combine results from an additional test run into the combined test run
function CombineTestResults(combinedTestRun, testRun)
  combinedTestRun.results.entries = combinedTestRun.results.entries + testRun.results.entries
  combinedTestRun.results.loops = combinedTestRun.results.loops + testRun.results.loops
  combinedTestRun.results.passedVerticals.numPassedLines = combinedTestRun.results.passedVerticals.numPassedLines + testRun.results.passedVerticals.numPassedLines
  combinedTestRun.results.passedHorizontals.numPassedLines = combinedTestRun.results.passedHorizontals.numPassedLines + testRun.results.passedHorizontals.numPassedLines
  combinedTestRun.results.passedVerticalHorizontal = combinedTestRun.results.passedVerticalHorizontal + testRun.results.passedVerticalHorizontal
  combinedTestRun.results.passedLeftDiagonal = combinedTestRun.results.passedLeftDiagonal + testRun.results.passedLeftDiagonal
  combinedTestRun.results.passedRightDiagonal = combinedTestRun.results.passedRightDiagonal + testRun.results.passedRightDiagonal
  combinedTestRun.results.passedDiagonals = combinedTestRun.results.passedDiagonals + testRun.results.passedDiagonals
  combinedTestRun.results.passedTotalLines = combinedTestRun.results.passedTotalLines + testRun.results.passedTotalLines
  combinedTestRun.results.verticalSumsNr = combinedTestRun.results.verticalSumsNr + testRun.results.verticalSumsNr
  combinedTestRun.results.horizontalSumsNr = combinedTestRun.results.horizontalSumsNr + testRun.results.horizontalSumsNr
  combinedTestRun.results.verticalHorizontalSumsNr = combinedTestRun.results.verticalHorizontalSumsNr + testRun.results.verticalHorizontalSumsNr
  combinedTestRun.results.totalLinesSumsNr = combinedTestRun.results.totalLinesSumsNr + testRun.results.totalLinesSumsNr
  combinedTestRun.results.total = combinedTestRun.results.total + testRun.results.total
  combinedTestRun.results.passedEntriesTotal = combinedTestRun.results.passedEntriesTotal + testRun.results.passedEntriesTotal
  combinedTestRun.results.line2Sum = combinedTestRun.results.line2Sum + testRun.results.line2Sum
  combinedTestRun.constraintsBestSolution.totalSelected = combinedTestRun.constraintsBestSolution.totalSelected + testRun.constraintsBestSolution.totalSelected
  combinedTestRun.diversityConstraintsOk = combinedTestRun.diversityConstraintsOk or testRun.diversityConstraintsOk
  combinedTestRun.unique_ok = combinedTestRun.unique_ok or testRun.unique_ok
  combinedTestRun.unique_bestSolutionCount = math.max(combinedTestRun.unique_bestSolutionCount, testRun.unique_bestSolutionCount)
end

-- perform the tests on the collected test results
function PerformTests(testRun)
  -- check total find count in enabled cells
  if conf.conditions.total > 0 then
    testRun.tests.total = testRun.results.total >= conf.conditions.total
    testRun.ok = testRun.ok and testRun.tests.total
    testRun.score = testRun.score + math.min(testRun.results.total / conf.conditions.total, 1)
  end

  -- check total find count in passed cells
  if conf.conditions.passedEntriesTotal > 0 then
    testRun.tests.passedEntriesTotal = testRun.results.passedEntriesTotal >= conf.conditions.passedEntriesTotal
    testRun.ok = testRun.ok and testRun.tests.passedEntriesTotal
    testRun.score = testRun.score + math.min(testRun.results.passedEntriesTotal / conf.conditions.passedEntriesTotal, 1)
  end

  -- check number of entries with enough finds
  if conf.conditions.entries > 0 then
    testRun.tests.entries = testRun.results.entries >= conf.conditions.entries
    testRun.ok = testRun.ok and testRun.tests.entries
    testRun.score = testRun.score + math.min(testRun.results.entries / conf.conditions.entries, 1)
  end

  -- check loop count
  if conf.conditions.loops > 0 then
    testRun.tests.loops = testRun.results.loops >= conf.conditions.loops
    testRun.ok = testRun.ok and testRun.tests.loops
    testRun.score = testRun.score + math.min(testRun.results.loops / conf.conditions.loops, 1)
  end

  -- check line 2 sum
  if conf.conditions.line2_sum_min then
    testRun.tests.line2_sum_min = testRun.results.line2Sum >= conf.conditions.line2_sum_min
    testRun.ok = testRun.ok and testRun.tests.line2_sum_min
    testRun.score = testRun.score + math.min(testRun.results.line2Sum / conf.conditions.line2_sum_min, 1)
  end

  if conf.conditions.line2_sum_max then
    testRun.tests.line2_sum_max = testRun.results.line2Sum <= conf.conditions.line2_sum_max
    testRun.ok = testRun.ok and testRun.tests.line2_sum_max
    if testRun.results.line2Sum > 0 then
      testRun.score = testRun.score + math.min(conf.conditions.line2_sum_max / testRun.results.line2Sum, 1)
    end
  end

  -- check if enough vertical lines have a sufficient sum
  if conf.conditions.vertical_sum > 0 then
    testRun.tests.vertical_sum = testRun.results.verticalSumsNr >= conf.conditions.vertical_sum
    testRun.ok = testRun.ok and testRun.tests.vertical_sum
    testRun.score = testRun.score + math.min(testRun.results.verticalSumsNr / conf.conditions.vertical_sum, 1)
  end

  -- check if enough horizontal lines have a sufficient sum
  if conf.conditions.horizontal_sum > 0 then
    testRun.tests.horizontal_sum = testRun.results.horizontalSumsNr >= conf.conditions.horizontal_sum
    testRun.ok = testRun.ok and testRun.tests.horizontal_sum
    testRun.score = testRun.score + math.min(testRun.results.horizontalSumsNr / conf.conditions.horizontal_sum, 1)
  end

  -- check if enough vertical or horizontal lines have a sufficient sum
  if conf.conditions.vertical_horizontal_sum > 0 then
    testRun.tests.vertical_horizontal_sum = testRun.results.verticalHorizontalSumsNr >= conf.conditions.vertical_horizontal_sum
    testRun.ok = testRun.ok and testRun.tests.vertical_horizontal_sum
    testRun.score = testRun.score + math.min(testRun.results.verticalHorizontalSumsNr / conf.conditions.vertical_horizontal_sum, 1)
  end

  -- check if enough vertical / horizontal / diagonal lines have a sufficient sum
  if conf.conditions.total_lines_sum > 0 then
    testRun.tests.total_lines_sum = testRun.results.totalLinesSumsNr >= conf.conditions.total_lines_sum
    testRun.ok = testRun.ok and testRun.tests.total_lines_sum
    testRun.score = testRun.score + math.min(testRun.results.totalLinesSumsNr / conf.conditions.total_lines_sum, 1)
  end

  -- check if enough vertical lines are completely filled
  if conf.conditions.vertical > 0 then
    testRun.tests.vertical = testRun.results.passedVerticals.numPassedLines >= conf.conditions.vertical
    testRun.ok = testRun.ok and testRun.tests.vertical
    testRun.results.highlightVertical = true
    testRun.score = testRun.score + math.min(testRun.results.passedVerticals.numPassedLines / conf.conditions.vertical, 1)
  end

  -- check if enough horizontal lines are completely filled
  if conf.conditions.horizontal > 0 then
    testRun.tests.horizontal = testRun.results.passedHorizontals.numPassedLines >= conf.conditions.horizontal
    testRun.ok = testRun.ok and testRun.tests.horizontal
    testRun.results.highlightHorizontal = true
    testRun.score = testRun.score + math.min(testRun.results.passedHorizontals.numPassedLines / conf.conditions.horizontal, 1)
  end

  -- check if enough vertical or horizontal lines are completely filled
  if conf.conditions.vertical_horizontal > 0 then
    testRun.tests.vertical_horizontal = testRun.results.passedVerticalHorizontal >= conf.conditions.vertical_horizontal
    testRun.ok = testRun.ok and testRun.tests.vertical_horizontal
    testRun.results.highlightVertical = true
    testRun.results.highlightHorizontal = true
    testRun.score = testRun.score + math.min(testRun.results.passedVerticalHorizontal / conf.conditions.vertical_horizontal, 1)
  end

  -- check if left diagonal is completely filled
  if conf.conditions.left_diagonal > 0 then
    testRun.tests.left_diagonal = testRun.results.passedLeftDiagonal >= conf.conditions.left_diagonal
    testRun.ok = testRun.ok and testRun.tests.left_diagonal
    testRun.results.highlightLeftDiagonal = true
    testRun.score = testRun.score + math.min(testRun.results.passedLeftDiagonal / conf.conditions.left_diagonal, 1)
  end

  -- check if right diagonal is completely filled
  if conf.conditions.right_diagonal > 0 then
    testRun.tests.right_diagonal = testRun.results.passedRightDiagonal >= conf.conditions.right_diagonal
    testRun.ok = testRun.ok and testRun.tests.right_diagonal
    testRun.results.highlightRightDiagonal = true
    testRun.score = testRun.score + math.min(testRun.results.passedRightDiagonal / conf.conditions.right_diagonal, 1)
  end

  -- check if enough diagonals are completely filled
  if conf.conditions.diagonal > 0 then
    testRun.tests.diagonal = testRun.results.passedDiagonals >= conf.conditions.diagonal
    testRun.ok = testRun.ok and testRun.tests.diagonal
    testRun.results.highlightLeftDiagonal = true
    testRun.results.highlightRightDiagonal = true
    testRun.score = testRun.score + math.min(testRun.results.passedDiagonals / conf.conditions.diagonal, 1)
  end

  -- check if enough total lines are completely filled
  if conf.conditions.total_lines > 0 then
    testRun.tests.total_lines = testRun.results.passedTotalLines >= conf.conditions.total_lines
    testRun.ok = testRun.ok and testRun.tests.total_lines
    testRun.results.highlightVertical = true
    testRun.results.highlightHorizontal = true
    testRun.results.highlightLeftDiagonal = true
    testRun.results.highlightRightDiagonal = true
    testRun.score = testRun.score + math.min(testRun.results.passedTotalLines / conf.conditions.total_lines, 1)
  end

  -- check if we have enough selected caches to fulfill the constraints
  if type(conf.constraints) == 'table' then
    testRun.tests.constraints = testRun.constraintsBestSolution.totalSelected >= conf.conditions.entries
    testRun.ok = testRun.ok and testRun.tests.constraints
    testRun.score = testRun.score + math.min(testRun.constraintsBestSolution.totalSelected / conf.conditions.entries, 1)
  end

  -- check if the required value diversity could be achieved
  if type(conf.diversityConstraints) == 'table' then
    testRun.tests.diversityConstraints = testRun.diversityConstraintsOk
    testRun.ok = testRun.ok and testRun.tests.diversityConstraints
    testRun.score = testRun.score + (testRun.diversityConstraintsOk and 1 or 0)
  end

  -- if unique entries are needed, check if we found enough
  if (conf.conditions.unique_entries > 0) and (conf.unique_entry_property ~= nil) then
    testRun.tests.unique_entries = testRun.unique_ok
    testRun.ok = testRun.ok and testRun.tests.unique_entries
    testRun.score = testRun.score + math.min(testRun.unique_bestSolutionCount / conf.conditions.unique_entries, 1)
  end
end

--------------- check simple conditions ---------------

-- get the completely filled horizontal lines
function PassedHorizontalLines(testRun)
  local passedCells = testRun.results.passedCells

  local passedLines = { false, false, false, false, false, false, false, false, false }
  passedLines.numPassedLines = 0

  for d = 1, 9 do
    local passed = true
    local hasEnabledCells = false

    for t = 1, 9 do
      if cellEnabled[d][t] then
        hasEnabledCells = true
        passed = passed and passedCells[d][t]
      end
    end

    passedLines[d] = passed and hasEnabledCells
    if passedLines[d] then
      passedLines.numPassedLines = passedLines.numPassedLines + 1
    end
  end

  return passedLines
end

-- get the completely filled vertical lines
function PassedVerticalLines(testRun)
  local passedCells = testRun.results.passedCells

  local passedLines = { false, false, false, false, false, false, false, false, false }
  passedLines.numPassedLines = 0

  for t = 1, 9 do
    local passed = true
    local hasEnabledCells = false

    for d = 1, 9 do
      if cellEnabled[d][t] then
        hasEnabledCells = true
        passed = passed and passedCells[d][t]
      end
    end

    passedLines[t] = passed and hasEnabledCells
    if passedLines[t] then
      passedLines.numPassedLines = passedLines.numPassedLines + 1
    end
  end

  return passedLines
end

-- check if left diagonal (1/1 to 5/5) is passed
function PassedLeftDiagonal(testRun)
  local passedCells = testRun.results.passedCells

  local passed = true
  local hasEnabledCells = false

  for _, dt in ipairs({{1, 1}, {2, 2}, {3, 3}, {4, 4}, {5, 5}, {6, 6}, {7, 7}, {8, 8}, {9, 9}}) do
    local d, t = dt[1], dt[2]
    if cellEnabled[d][t] then
      hasEnabledCells = true
      passed = passed and passedCells[d][t]
    end
  end

  return passed and hasEnabledCells
end

-- check if right diagonal (5/1 to 1/5) is passed
function PassedRightDiagonal(testRun)
  local passedCells = testRun.results.passedCells

  local passed = true
  local hasEnabledCells = false

  for _, dt in ipairs({{1, 9}, {2, 8}, {3, 7}, {4, 6}, {5, 5}, {6, 4}, {7, 3}, {8, 2}, {9, 1}}) do
    local d, t = dt[1], dt[2]
    if cellEnabled[d][t] then
      hasEnabledCells = true
      passed = passed and passedCells[d][t]
    end
  end

  return passed and hasEnabledCells
end

-- get the find count in a cell that shall be used for sums (depending on conf.sumOnlyPassedEntries either all finds or only those that pass the entry condition)
function GetFindCountForSum(findsGrid, minGrid, d, t)
  if not cellEnabled[d][t] then
    return 0 -- cell disabled
  end

  local numFindsInCell = #(findsGrid[d][t])
  return Ternary(conf.sumOnlyPassedEntries and (numFindsInCell < minGrid[d][t]), 0, numFindsInCell)
end

-- calculate the horizontal sum of enabled cells
function HorizontalSums(testRun)
  local findsGrid = testRun.findsGrid
  local minGrid = testRun.minValueGrid

  local horizontalSums = { 0, 0, 0, 0, 0, 0, 0, 0, 0 }

  for d = 1, 9 do
    local sum = 0

    for t = 1, 9 do
      sum = sum + GetFindCountForSum(findsGrid, minGrid, d, t)
    end

    horizontalSums[d] = sum
  end

  return horizontalSums
end

-- calculate the vertical sum of enabled cells
function VerticalSums(testRun)
  local findsGrid = testRun.findsGrid
  local minGrid = testRun.minValueGrid

  local verticalSums = { 0, 0, 0, 0, 0, 0, 0, 0, 0 }

  for t = 1, 9 do
    local sum = 0

    for d = 1, 9 do
      sum = sum + GetFindCountForSum(findsGrid, minGrid, d, t)
    end

    verticalSums[t] = sum
  end

  return verticalSums
end

-- calculate the sum of enabled cells in the left diagonal (1/1 to 5/5)
function LeftDiagonalSum(testRun)
  local findsGrid = testRun.findsGrid
  local minGrid = testRun.minValueGrid

  local sum = 0

  for _, dt in ipairs({{1, 1}, {2, 2}, {3, 3}, {4, 4}, {5, 5}, {6, 6}, {7, 7}, {8, 8}, {9, 9}}) do
    sum = sum + GetFindCountForSum(findsGrid, minGrid, dt[1], dt[2])
  end

  return sum
end

-- calculate the sum of enabled cells in the right diagonal (5/1 to 1/5)
function RightDiagonalSum(testRun)
  local findsGrid = testRun.findsGrid
  local minGrid = testRun.minValueGrid

  local sum = 0

  for _, dt in ipairs({{1, 9}, {2, 8}, {3, 7}, {4, 6}, {5, 5}, {6, 4}, {7, 3}, {8, 2}, {9, 1}}) do
    sum = sum + GetFindCountForSum(findsGrid, minGrid, dt[1], dt[2])
  end

  return sum
end

-- check which "normal" conditions are fulfilled
function CheckConditions(testRun)
  -- if different find counts are required anywhere in the grid --> fit highest required find count to highest achieved finds
  if (type(conf.minValue) == 'table') and (type(conf.minValue[1]) == 'number') then
    -- collect the find counts for all enabled cells
    local enabledCells = {}
    for d = 1, 9 do
      for t = 1, 9 do
        if cellEnabled[d][t] then
          table.insert(enabledCells, { d = d, t = t, numCaches = #(testRun.findsGrid[d][t]) })
        end
      end
    end

    -- sort cells by find count (biggest number first)
    table.sort(enabledCells, function(a, b) return a.numCaches > b.numCaches end)

    -- for all enabled cells assign a required find count according to conf.minValue (biggest number first)
    testRun.minValueGrid = CreateGrid(0) -- start this test run with a fresh grid
    for i = 1, math.min(#enabledCells, #conf.minValue) do
      local numFindsRequired = conf.minValue[i]
      if numFindsRequired > 0 then
        local cell = enabledCells[i]
        testRun.minValueGrid[cell.d][cell.t] = numFindsRequired
      end
    end
  else
    testRun.minValueGrid = minValueGrid -- no copy needed, as the grid will not change
  end
  local minGrid = testRun.minValueGrid

  -- remember find counts for all enabled cells to determine the number of achieved loops, and
  -- determine which cells passed (enabled, required, and enough finds) -- needed below by
  -- PassedHorizontalLines() and friends, so this must run before those are called
  testRun.results.passedCells = CreateGrid(false)
  local enabledCellCounts = {}
  local line2ValuesOfPassedEntries = {}

  for d = 1, 9 do
    for t = 1, 9 do
      if cellEnabled[d][t] then
        local findsInCell = testRun.findsGrid[d][t]
        local numFindsInCell = #findsInCell
        table.insert(enabledCellCounts, numFindsInCell) -- remember 0 finds as well, so that loop can be 0 then
        testRun.results.total = testRun.results.total + numFindsInCell

        local numFindsRequired = minGrid[d][t]
        if numFindsRequired > 0 then -- don't count enabled cells that are not needed to pass when conf.minValue is a flat list
          if numFindsInCell >= numFindsRequired then
            testRun.results.entries = testRun.results.entries + 1
            testRun.results.passedEntriesTotal = testRun.results.passedEntriesTotal + numFindsInCell
            testRun.results.passedCells[d][t] = true

            -- line2Sum shall only include passed cells
            if conf.conditions.line2_sum_min or conf.conditions.line2_sum_max then
              local line2Value = tonumber(GetValue(findsInCell[1], conf.cell_format_line2)) or 0
              testRun.results.line2Sum = testRun.results.line2Sum + line2Value -- total sum, may be replaced by best sum later
              table.insert(line2ValuesOfPassedEntries, {d = d, t = t, n = line2Value})
            end
          end
        end
      end
    end
  end

  -- check which conditions were fulfilled
  testRun.results.passedHorizontals = PassedHorizontalLines(testRun)
  testRun.results.passedVerticals = PassedVerticalLines(testRun)
  testRun.results.passedLeftDiagonal = Ternary(PassedLeftDiagonal(testRun), 1, 0)
  testRun.results.passedRightDiagonal = Ternary(PassedRightDiagonal(testRun), 1, 0)
  testRun.results.passedVerticalHorizontal = testRun.results.passedVerticals.numPassedLines + testRun.results.passedHorizontals.numPassedLines
  testRun.results.passedDiagonals = testRun.results.passedLeftDiagonal + testRun.results.passedRightDiagonal
  testRun.results.passedTotalLines = testRun.results.passedVerticalHorizontal + testRun.results.passedDiagonals
  testRun.results.horizontalSums = HorizontalSums(testRun)
  testRun.results.verticalSums = VerticalSums(testRun)
  testRun.results.leftDiagonalSum = LeftDiagonalSum(testRun)
  testRun.results.rightDiagonalSum = RightDiagonalSum(testRun)

  if conf.line2_sum_all_entries ~= true then
    if conf.conditions.line2_sum_min then
      table.sort(line2ValuesOfPassedEntries, function(a, b) return a.n > b.n end) -- put largest numbers first
    end

    if conf.conditions.line2_sum_max then
      table.sort(line2ValuesOfPassedEntries, function(a, b) return a.n < b.n end) -- put smallest numbers first
    end

    testRun.results.line2Sum = 0

    for i = 1, conf.conditions.entries do
      local entry = line2ValuesOfPassedEntries[i]
      if entry then
        testRun.results.line2Sum = testRun.results.line2Sum + entry.n
        local c = testRun.findsGrid[entry.d][entry.t][1]
        if c then
          c.IsSelected = true
        end
      end
    end
  end

  -- get loop count
  if #enabledCellCounts > 0 then
    table.sort(enabledCellCounts, function(a, b) return a < b end)
    testRun.results.loops = enabledCellCounts[1]
  end

  -- check how many lines reach the required sum
  for _, sum in ipairs(testRun.results.verticalSums) do
    if sum >= conf.minSum then
      testRun.results.verticalSumsNr = testRun.results.verticalSumsNr + 1
    end
  end

  for _, sum in ipairs(testRun.results.horizontalSums) do
    if sum >= conf.minSum then
      testRun.results.horizontalSumsNr = testRun.results.horizontalSumsNr + 1
    end
  end

  testRun.results.verticalHorizontalSumsNr = testRun.results.verticalSumsNr + testRun.results.horizontalSumsNr

  testRun.results.totalLinesSumsNr = testRun.results.verticalHorizontalSumsNr

  if testRun.results.leftDiagonalSum >= conf.minSum then
    testRun.results.totalLinesSumsNr = testRun.results.totalLinesSumsNr + 1
  end

  if testRun.results.rightDiagonalSum >= conf.minSum then
    testRun.results.totalLinesSumsNr = testRun.results.totalLinesSumsNr + 1
  end
end

--------------- check constraints ---------------

-- calculate for each D/T, how many value are left
function CalculateNumberOfValuesForDT(dtsPerValue)
  local numValuesPerDT = {}
  for _, dts in ipairs(dtsPerValue) do
    for i, entry in ipairs(dts) do -- table of { d = d, t = t, value = value, gccode = gccode }
      local dt = DtToString(entry.d, entry.t)
      if numValuesPerDT[dt] == nil then
        numValuesPerDT[dt] = 1
      else
        numValuesPerDT[dt] = numValuesPerDT[dt] + 1
      end
    end
  end

  return numValuesPerDT
end

-- remove a given D/T combination from the remaining values
function RemoveDtFromDtsPerValue(d, t, dtsPerValue)
  -- remove given D/T from all values
  for _, dts in ipairs(dtsPerValue) do
    for i, entry in ipairs(dts) do -- table of { d = d, t = t, value = value, gccode = gccode }
      if entry.d == d and entry.t == t then
        table.remove(dts, i)
        break
      end
    end
  end

  -- sort values by their number of D/Ts
  table.sort(dtsPerValue, function(a, b) return #a < #b end)

  -- remove values that no longer have a D/T
  while #dtsPerValue > 0 and #dtsPerValue[1] == 0 do
    table.remove(dtsPerValue, 1)
  end
end

-- select a single cache using backtracking
function ConstraintsBacktrackSelectCache(testRun, solution, cacheNumber, dts, startIndex, cachesByD, cachesByT, dtsPerValue)
  if abort or (testRun.constraintsBestSolution.totalSelected == testRun.constraintsBestSolution.numDtsFound) then
    return
  end

  local elapsedSecond = os.time() - startTime
  if (elapsedSecond + 2) > maxExecutionTime then
    abort = true
    abortDuringConstraintChecking = true
    return -- emergency abort before timeout
  end

  for i = startIndex, #dts do -- table of { d = d, t = t, value = value, gccode = gccode }
    local entry = dts[i]
    if (cachesByD[entry.d] < conf.constraints.maxRepeatedValuePerHorizontal) and (cachesByT[entry.t] < conf.constraints.maxRepeatedValuePerVertical) then
      -- select cache
      cachesByD[entry.d] = cachesByD[entry.d] + 1
      cachesByT[entry.t] = cachesByT[entry.t] + 1

      local newSolution = TableCopy(solution)
      newSolution.selected[entry.d][entry.t] = entry.gccode
      newSolution.totalSelected = newSolution.totalSelected + 1

      if testRun.constraintsBestSolution.totalSelected < newSolution.totalSelected then
        testRun.constraintsBestSolution = TableCopy(newSolution)
      end

      local newDtsPerValue = TableCopy(dtsPerValue)
      RemoveDtFromDtsPerValue(entry.d, entry.t, newDtsPerValue)

      -- try extending the selection for THIS value further, if there is room
      if (i < #dts) and (cacheNumber < conf.constraints.maxRepeatedValueTotal) then
        ConstraintsBacktrackSelectCache(testRun, newSolution, cacheNumber + 1, dts, i + 1, cachesByD, cachesByT, TableCopy(newDtsPerValue))
        if abort or (testRun.constraintsBestSolution.totalSelected == testRun.constraintsBestSolution.numDtsFound) then
          return
        end
      end

      -- ALSO try stopping here (with just the cells selected so far for this
      -- value) and moving on to the next value -- this is always a valid
      -- option, not only when extending further happens to be impossible,
      -- since leaving a cell unclaimed can free it up for a later value
      ConstraintsSelectCacheOfNextValue(testRun, newSolution, newDtsPerValue)

      if abort or (testRun.constraintsBestSolution.totalSelected == testRun.constraintsBestSolution.numDtsFound) then
        return
      end

      -- undo cache selection
      cachesByD[entry.d] = cachesByD[entry.d] - 1
      cachesByT[entry.t] = cachesByT[entry.t] - 1
    end
  end
end

-- start picking caches of the next value
function ConstraintsSelectCacheOfNextValue(testRun, solution, dtsPerValue)
  if abort or (#dtsPerValue == 0) or (testRun.constraintsBestSolution.totalSelected == testRun.constraintsBestSolution.numDtsFound) then
    return
  end

  -- calculate which D/T has how many types left
  local numValuesPerDT = CalculateNumberOfValuesForDT(dtsPerValue)

  local dts = dtsPerValue[1]
  table.remove(dtsPerValue, 1)

  -- check if we can select all cache for the current value
  local canSelectAllCaches = #dts <= conf.constraints.maxRepeatedValueTotal
  if canSelectAllCaches then
    local cachesByD = IndexedTable_Create(9, 0)
    local cachesByT = IndexedTable_Create(9, 0)

    for _, entry in ipairs(dts) do -- table of { d = d, t = t, value = value, gccode = gccode }
      cachesByD[entry.d] = cachesByD[entry.d] + 1
      cachesByT[entry.t] = cachesByT[entry.t] + 1
      if (cachesByD[entry.d] > conf.constraints.maxRepeatedValuePerHorizontal) or (cachesByT[entry.t] > conf.constraints.maxRepeatedValuePerVertical) then
        canSelectAllCaches = false
        break
      end
    end

    if canSelectAllCaches then
      -- select all caches
      for _, entry in ipairs(dts) do
        solution.selected[entry.d][entry.t] = entry.gccode
        solution.totalSelected = solution.totalSelected + 1
        RemoveDtFromDtsPerValue(entry.d, entry.t, dtsPerValue)
      end

      if testRun.constraintsBestSolution.totalSelected < solution.totalSelected then
        testRun.constraintsBestSolution = TableCopy(solution)
      end

      -- proceed with next value
      ConstraintsSelectCacheOfNextValue(testRun, solution, dtsPerValue)
      return
    end
  end

  -- can't select all caches --> use backtracking

  -- sort dts so that the D/T with the least amount of values comes first
  table.sort(dts, function(a, b) return numValuesPerDT[DtToString(a.d, a.t)] < numValuesPerDT[DtToString(b.d, b.t)] end)

  ConstraintsBacktrackSelectCache(testRun, solution, 1, dts, 1, IndexedTable_Create(9, 0), IndexedTable_Create(9, 0), TableCopy(dtsPerValue))
end

-- check additional constraints
function CheckConstraints(testRun)
  if type(conf.constraints) ~= 'table' then
    return
  end

  local field = conf.constraints.field
  local dtsPerValue = {}
  local numDtsFound = 0

  for d = 1, 9 do
    for t = 1, 9 do
      local caches = testRun.findsGrid[d][t]
      if type(caches) == 'table' then
        if #caches > 0 then
          numDtsFound = numDtsFound + 1

          local fieldValuesOfCurrentDT = {}
          for _, c in ipairs(caches) do
            local value = GetValue(c, field)
            if (value ~= nil) and c.gccode then
              fieldValuesOfCurrentDT[value] = c.gccode
            end
          end

          for value, gccode in pairs(fieldValuesOfCurrentDT) do
            if dtsPerValue[value] == nil then
              dtsPerValue[value] = {}
            end
            table.insert(dtsPerValue[value], { d = d, t = t, value = value, gccode = gccode })
          end
        end
      end
    end
  end

  -- convert dtsPerValue to indexed table so that we can sort it
  dtsPerValue = AssociativeTable_ValuesToIndexedTable(dtsPerValue)
  table.sort(dtsPerValue, function(a, b) return #a < #b end)

  -- dump dtsPerValue
  if conf.debug then
    for _, dts in ipairs(dtsPerValue) do
      local tmp = {}
      for _, dt in ipairs(dts) do
        table.insert(tmp, DtToString(dt.d, dt.t))
      end
      PGC.print(tostring(dts[1].value) .. ' (' .. #dts .. ' DTs): ' .. table.concat(tmp, ', ') .. '\n')
    end
  end

  local solution = {}
  solution.numDtsFound = numDtsFound
  solution.totalSelected = 0
  solution.selected = { {}, {}, {}, {}, {}, {}, {}, {}, {} }

  testRun.constraintsBestSolution = TableCopy(solution)

  ConstraintsSelectCacheOfNextValue(testRun, solution, dtsPerValue)

  -- update matrix to show selected caches
  for d = 1, 9 do
    for t = 1, 9 do
      SelectCache(testRun.findsGrid[d][t], testRun.constraintsBestSolution.selected[d][t])
    end
  end
end

--------------- check diversity constraints ---------------

-- build a flat list of { d, t, candidates = {values...}, gccodeOf = {value -> gccode} }, one
-- entry per found D/T cell that has at least one non-nil value for 'field'
function DiversityCellList(testRun, field)
  local list = {}

  for d = 1, 9 do
    for t = 1, 9 do
      local caches = testRun.findsGrid[d][t]
      if type(caches) == 'table' and #caches > 0 then
        local seen = {}
        local candidates = {}
        for _, c in ipairs(caches) do
          local value = GetValue(c, field)
          if (value ~= nil) and (seen[value] == nil) then
            seen[value] = c.gccode
            table.insert(candidates, value)
          end
        end
        if #candidates > 0 then
          table.insert(list, { d = d, t = t, candidates = candidates, gccodeOf = seen })
        end
      end
    end
  end

  return list
end

-- exact (not heuristic) check: if the union of ALL candidate values within some required scope
-- is already smaller than that scope's requirement, no assignment can ever satisfy it -- lets
-- genuinely impossible configurations fail immediately without any search
function DiversityQuickInfeasible(cellList, reqTotal, reqH, reqV)
  if reqTotal ~= nil then
    local allValues = {}
    for _, cell in ipairs(cellList) do
      for _, v in ipairs(cell.candidates) do
        allValues[v] = true
      end
    end
    if Count(allValues) < reqTotal then
      return true
    end
  end

  if reqH ~= nil then
    local rowValues = {}
    for _, cell in ipairs(cellList) do
      if rowValues[cell.d] == nil then
        rowValues[cell.d] = {}
      end
      for _, v in ipairs(cell.candidates) do
        rowValues[cell.d][v] = true
      end
    end
    for _, values in pairs(rowValues) do
      if Count(values) < reqH then
        return true
      end
    end
  end

  if reqV ~= nil then
    local colValues = {}
    for _, cell in ipairs(cellList) do
      if colValues[cell.t] == nil then
        colValues[cell.t] = {}
      end
      for _, v in ipairs(cell.candidates) do
        colValues[cell.t][v] = true
      end
    end
    for _, values in pairs(colValues) do
      if Count(values) < reqV then
        return true
      end
    end
  end

  return false
end

-- higher score = more useful to assign 'v' to this cell right now, i.e. it still helps satisfy
-- an unmet requirement in the cell's row, column and/or the overall total
function DiversityValuePriority(d, t, v, rowVals, colVals, totalVals, reqTotal, reqH, reqV)
  local score = 0
  if (reqH ~= nil) and ((rowVals[d] == nil) or (rowVals[d][v] == nil)) and (Count(rowVals[d]) < reqH) then
    score = score + 4
  end
  if (reqV ~= nil) and ((colVals[t] == nil) or (colVals[t][v] == nil)) and (Count(colVals[t]) < reqV) then
    score = score + 2
  end
  if (reqTotal ~= nil) and (totalVals[v] == nil) and (Count(totalVals) < reqTotal) then
    score = score + 1
  end
  return score
end

-- process cells fewest-candidates-first (the "most constrained" ones get decided first)
function DiversityDeterministicOrder(cellList)
  local order = {}
  for i = 1, #cellList do
    order[i] = i
  end
  table.sort(order, function(a, b) return #cellList[a].candidates < #cellList[b].candidates end)
  return order
end

function DiversityRandomOrder(cellList)
  local order = {}
  for i = 1, #cellList do
    order[i] = i
  end
  for i = #order, 2, -1 do
    local j = math.random(i)
    order[i], order[j] = order[j], order[i]
  end
  return order
end

-- try a single greedy pass over 'order': at each cell, pick whichever candidate value
-- currently helps the most unmet requirement(s). Selecting more cells never hurts diversity,
-- so every found cell is always assigned -- there is never a reason to leave one out. Returns
-- (assignment, ok): 'assignment' (indexed by cellList index, each { d, t, value, gccode })
-- always covers every cell, even when 'ok' comes back false, so a failed attempt can still be
-- shown as "best effort" progress instead of being thrown away.
function DiversityGreedyAttempt(cellList, reqTotal, reqH, reqV, order)
  local rowVals = {}
  local colVals = {}
  local totalVals = {}
  local assignment = {}

  for _, idx in ipairs(order) do
    local cell = cellList[idx]
    local bestValue = nil
    local bestScore = -1
    for _, v in ipairs(cell.candidates) do
      local score = DiversityValuePriority(cell.d, cell.t, v, rowVals, colVals, totalVals, reqTotal, reqH, reqV)
      if (score > bestScore) or ((score == bestScore) and (math.random() < 0.5)) then
        bestScore = score
        bestValue = v
      end
    end

    if rowVals[cell.d] == nil then rowVals[cell.d] = {} end
    if colVals[cell.t] == nil then colVals[cell.t] = {} end
    rowVals[cell.d][bestValue] = true
    colVals[cell.t][bestValue] = true
    totalVals[bestValue] = true
    assignment[idx] = { d = cell.d, t = cell.t, value = bestValue, gccode = cell.gccodeOf[bestValue] }
  end

  local ok = true
  if reqTotal ~= nil then
    ok = Count(totalVals) >= reqTotal
  end
  if ok and (reqH ~= nil) then
    for _, values in pairs(rowVals) do
      if Count(values) < reqH then
        ok = false
        break
      end
    end
  end
  if ok and (reqV ~= nil) then
    for _, values in pairs(colVals) do
      if Count(values) < reqV then
        ok = false
        break
      end
    end
  end

  return assignment, ok
end

-- how close 'assignment' gets to satisfying every requirement -- used only to pick which
-- attempt to display as best-effort progress when none fully succeeds; never affects the
-- pass/fail verdict itself
function DiversityProgressScore(assignment, reqTotal, reqH, reqV, allRows, allCols)
  local rowVals = {}
  local colVals = {}
  local totalVals = {}
  for _, entry in pairs(assignment) do
    if rowVals[entry.d] == nil then rowVals[entry.d] = {} end
    if colVals[entry.t] == nil then colVals[entry.t] = {} end
    rowVals[entry.d][entry.value] = true
    colVals[entry.t][entry.value] = true
    totalVals[entry.value] = true
  end

  local score = 0
  if reqTotal ~= nil then
    score = score + math.min(Count(totalVals) / reqTotal, 1)
  end
  if reqH ~= nil then
    for d, _ in pairs(allRows) do
      score = score + math.min(Count(rowVals[d]) / reqH, 1)
    end
  end
  if reqV ~= nil then
    for t, _ in pairs(allCols) do
      score = score + math.min(Count(colVals[t]) / reqV, 1)
    end
  end
  return score
end

-- which requirement categories ("total"/"horizontal"/"vertical") 'assignment' falls short of --
-- used only for a short summary in the failure message, not to name individual rows/columns
function DiversityUnmetScopes(assignment, reqTotal, reqH, reqV, allRows, allCols)
  local rowVals = {}
  local colVals = {}
  local totalVals = {}
  for _, entry in pairs(assignment) do
    if rowVals[entry.d] == nil then rowVals[entry.d] = {} end
    if colVals[entry.t] == nil then colVals[entry.t] = {} end
    rowVals[entry.d][entry.value] = true
    colVals[entry.t][entry.value] = true
    totalVals[entry.value] = true
  end

  local unmet = {}
  if (reqTotal ~= nil) and (Count(totalVals) < reqTotal) then
    table.insert(unmet, 'total')
  end
  if reqH ~= nil then
    for d, _ in pairs(allRows) do
      if Count(rowVals[d]) < reqH then
        table.insert(unmet, 'horizontal')
        break
      end
    end
  end
  if reqV ~= nil then
    for t, _ in pairs(allCols) do
      if Count(colVals[t]) < reqV then
        table.insert(unmet, 'vertical')
        break
      end
    end
  end
  return unmet
end

-- cheap forward-checking used by the exact backtracking fallback: for each scope that still
-- has an unmet requirement, checks whether the union of already-achieved values plus every
-- still-reachable candidate could even in principle cover the deficit
function DiversityCanStillReach(cellList, order, pos, rowVals, colVals, totalVals, reqTotal, reqH, reqV, allRows, allCols)
  if reqTotal ~= nil then
    local need = reqTotal - Count(totalVals)
    if need > 0 then
      local potential = {}
      for i = pos, #order do
        for _, v in ipairs(cellList[order[i]].candidates) do
          if totalVals[v] == nil then
            potential[v] = true
          end
        end
      end
      if Count(potential) < need then
        return false
      end
    end
  end

  if reqH ~= nil then
    local remainingByRow = {}
    for i = pos, #order do
      local cell = cellList[order[i]]
      if remainingByRow[cell.d] == nil then remainingByRow[cell.d] = {} end
      for _, v in ipairs(cell.candidates) do
        remainingByRow[cell.d][v] = true
      end
    end
    for d, _ in pairs(allRows) do
      local have = rowVals[d] or {}
      if remainingByRow[d] ~= nil then
        local union = TableCopy(have)
        for v, _ in pairs(remainingByRow[d]) do
          union[v] = true
        end
        if Count(union) < reqH then
          return false
        end
      elseif Count(have) < reqH then
        return false
      end
    end
  end

  if reqV ~= nil then
    local remainingByCol = {}
    for i = pos, #order do
      local cell = cellList[order[i]]
      if remainingByCol[cell.t] == nil then remainingByCol[cell.t] = {} end
      for _, v in ipairs(cell.candidates) do
        remainingByCol[cell.t][v] = true
      end
    end
    for t, _ in pairs(allCols) do
      local have = colVals[t] or {}
      if remainingByCol[t] ~= nil then
        local union = TableCopy(have)
        for v, _ in pairs(remainingByCol[t]) do
          union[v] = true
        end
        if Count(union) < reqV then
          return false
        end
      elseif Count(have) < reqV then
        return false
      end
    end
  end

  return true
end

-- exact backtracking fallback for the rare cases the greedy attempts below don't resolve --
-- bounded by the same emergency-abort timeout the "constraints" feature already uses
function DiversityBacktrack(cellList, order, pos, rowVals, colVals, totalVals, assignment, reqTotal, reqH, reqV, allRows, allCols)
  if abort then
    return false
  end

  local elapsedSecond = os.time() - startTime
  if (elapsedSecond + 2) > maxExecutionTime then
    abort = true
    abortDuringDiversityChecking = true
    return false -- emergency abort before timeout
  end

  if not DiversityCanStillReach(cellList, order, pos, rowVals, colVals, totalVals, reqTotal, reqH, reqV, allRows, allCols) then
    return false
  end

  if pos > #order then
    return true
  end

  local cell = cellList[order[pos]]

  local candidates = TableCopy(cell.candidates)
  table.sort(candidates, function(a, b)
    return DiversityValuePriority(cell.d, cell.t, a, rowVals, colVals, totalVals, reqTotal, reqH, reqV)
         > DiversityValuePriority(cell.d, cell.t, b, rowVals, colVals, totalVals, reqTotal, reqH, reqV)
  end)

  for _, v in ipairs(candidates) do
    local hadRow = (rowVals[cell.d] ~= nil) and rowVals[cell.d][v]
    local hadCol = (colVals[cell.t] ~= nil) and colVals[cell.t][v]
    local hadTotal = totalVals[v]

    if rowVals[cell.d] == nil then rowVals[cell.d] = {} end
    if colVals[cell.t] == nil then colVals[cell.t] = {} end
    rowVals[cell.d][v] = true
    colVals[cell.t][v] = true
    totalVals[v] = true
    assignment[order[pos]] = { d = cell.d, t = cell.t, value = v, gccode = cell.gccodeOf[v] }

    if DiversityBacktrack(cellList, order, pos + 1, rowVals, colVals, totalVals, assignment, reqTotal, reqH, reqV, allRows, allCols) then
      return true
    end

    if abort then
      return false
    end

    if not hadRow then rowVals[cell.d][v] = nil end
    if not hadCol then colVals[cell.t][v] = nil end
    if not hadTotal then totalVals[v] = nil end
    assignment[order[pos]] = nil
  end

  return false
end

-- check diversity constraints: a minimum-diversity requirement never benefits from leaving a
-- found cell unselected (more assigned cells can only help, never hurt, a distinct-value
-- count), so this is a pure feasibility question -- if some value assignment exists that meets
-- every configured minimum, every found cell gets selected that way; otherwise nothing is
-- highlighted (highlighting the closest-but-failing attempt just marked every cell as
-- selected regardless of pass/fail, which wasn't informative), but the closest attempt is
-- still used to report which requirement categories (see DiversityUnmetScopes) fell short
function CheckDiversityConstraints(testRun)
  if type(conf.diversityConstraints) ~= 'table' then
    return
  end

  local reqTotal = conf.diversityConstraints.minDifferentValuesTotal
  local reqH = conf.diversityConstraints.minDifferentValuesPerHorizontal
  local reqV = conf.diversityConstraints.minDifferentValuesPerVertical

  local cellList = DiversityCellList(testRun, conf.diversityConstraints.field)
  if #cellList == 0 then
    return
  end

  local allRows = {}
  local allCols = {}
  for _, cell in ipairs(cellList) do
    allRows[cell.d] = true
    allCols[cell.t] = true
  end

  -- an unreachable requirement never becomes reachable through more searching, so this only
  -- gates the (otherwise pointless) exhaustive backtracking fallback further below -- the cheap
  -- greedy attempts still run regardless, to find the best progress to display
  local provenInfeasible = DiversityQuickInfeasible(cellList, reqTotal, reqH, reqV)

  local bestAssignment, ok = DiversityGreedyAttempt(cellList, reqTotal, reqH, reqV, DiversityDeterministicOrder(cellList))
  local bestScore = DiversityProgressScore(bestAssignment, reqTotal, reqH, reqV, allRows, allCols)

  if not ok then
    for _ = 1, 30 do
      if abort then
        break
      end
      local assignment, attemptOk = DiversityGreedyAttempt(cellList, reqTotal, reqH, reqV, DiversityRandomOrder(cellList))
      if attemptOk then
        bestAssignment = assignment
        ok = true
        break
      end
      local score = DiversityProgressScore(assignment, reqTotal, reqH, reqV, allRows, allCols)
      if score > bestScore then
        bestScore = score
        bestAssignment = assignment
      end
    end
  end

  if (not ok) and (not provenInfeasible) and (not abort) then
    local order = DiversityRandomOrder(cellList)
    local backtrackAssignment = {}
    if DiversityBacktrack(cellList, order, 1, {}, {}, {}, backtrackAssignment, reqTotal, reqH, reqV, allRows, allCols) then
      bestAssignment = backtrackAssignment
      ok = true
    end
  end

  testRun.diversityConstraintsOk = ok
  if ok then
    for _, entry in pairs(bestAssignment) do
      SelectCache(testRun.findsGrid[entry.d][entry.t], entry.gccode)
    end
  else
    testRun.diversityConstraintsUnmet = DiversityUnmetScopes(bestAssignment, reqTotal, reqH, reqV, allRows, allCols)
  end
end

--------------- check unique values ---------------

-- put the cache into table uniqueSortedCaches[key1Value][key2Value] (for unique pairs)
function UniqueSortCache(uniqueSortedCaches, c)
  local key1Value = GetValue(c, 'DT')
  local key2Value = GetValue(c, conf.unique_entry_property)
  if (key1Value == nil) or (key2Value == nil) then
    return
  end

  local key1Table = uniqueSortedCaches[key1Value]
  if key1Table == nil then
    key1Table = {}
    uniqueSortedCaches[key1Value] = key1Table
  end

  if key1Table[key2Value] ~= nil then
    return -- already have a cache with the same key1/key2 value pair, so skip this one
  end

  key1Table[key2Value] = c
end

-- get the cache from table sortedCaches[key1Value][key2Value]
function UniqueGetCache(uniqueSortedCaches, key1Value, key2Value)
  local key1Table = uniqueSortedCaches[key1Value]
  if key1Table then
    return key1Table[key2Value]
  end
  return nil
end

-- show the map polygon (and cache) for a cache selected by "unique_entries", when "unique_entry_property" is location-based
function DrawUniqueEntryPolygon(passed, c)
  if not conf.showMap then
    return
  end

  if conf.unique_entry_property == 'country' then
    DrawCountryPolygon(passed, GetValue(c, 'country'))
  elseif (conf.unique_entry_property == 'region') or (conf.unique_entry_property == 'unique_region') then
    DrawRegionPolygon(passed, GetValue(c, 'country'), GetValue(c, 'region'))
  elseif (conf.unique_entry_property == 'county') or (conf.unique_entry_property == 'unique_county') then
    DrawCountyPolygon(passed, GetValue(c, 'country'), GetValue(c, 'region'), GetValue(c, 'county'))
  else
    return
  end

  InitMap()
  table.insert(map.caches, GetValue(c, 'gccode'))
end

-- check if "unique_entries" is fulfilled
function CheckUniqueEntries(testRun)
  -- check if unique entries are required
  if (conf.conditions.unique_entries > 0) and (conf.unique_entry_property ~= nil) then
    testRun.uniqueSortedCaches = {}
    local key1SortKey = {} -- DT string -> D+T grid-index sum, used below to order key1Values

    -- find all values pairs (disabled cells never count towards fulfilling "unique_entries";
    -- when conf.unique_passed_entries_only is set, only cells that passed "minValue" count too)
    for d = 1, 9 do
      for t = 1, 9 do
        if cellEnabled[d][t] and ((not conf.unique_passed_entries_only) or testRun.results.passedCells[d][t]) then
          local caches = testRun.findsGrid[d][t]

          -- compute key1SortKey once per D/T grid cell (not once per cache in it), reading the DT
          -- string off an actual cache in the cell (if any).
          if #caches > 0 then
            local key1Value = GetValue(caches[1], 'DT')
            key1SortKey[key1Value] = d + t
          end

          for _, c in ipairs(caches) do
            UniqueSortCache(testRun.uniqueSortedCaches, c)
          end
        end
      end
    end

    -- process key1 values (DT combinations) highest D+T sum first, so the lowest D+T
    -- combinations are the ones left open if not enough pairs exist to match every key1 value.
    local key1Values = AssociativeTable_KeysToIndexedTable(testRun.uniqueSortedCaches)
    table.sort(key1Values, function(a, b)
      if key1SortKey[a] ~= key1SortKey[b] then
        return key1SortKey[a] > key1SortKey[b] -- highest D+T sum first
      end
      return a > b -- stable tiebreak, so combinations with an equal D+T sum still get a deterministic order
    end)

    -- build the adjacency list (key1Value -> indexed, sorted array of key2Values it can pair with)
    local neighbors = {}
    for _, key1Value in ipairs(key1Values) do
      local key2Values = AssociativeTable_KeysToIndexedTable(testRun.uniqueSortedCaches[key1Value])
      table.sort(key2Values)
      neighbors[key1Value] = key2Values
    end

    local matching = UniqueFindMaximumMatching(key1Values, neighbors)
    testRun.unique_bestSolution = {}
    for _, pair in ipairs(matching) do
      table.insert(testRun.unique_bestSolution, { key1 = pair.left, key2 = pair.right })
    end
    testRun.unique_bestSolutionCount = #testRun.unique_bestSolution
    testRun.unique_ok = testRun.unique_bestSolutionCount >= conf.conditions.unique_entries

    if conf.debug then
      PGC.print('Maximum matching of D/T and ', GetValueLabelPlural(conf.unique_entry_property), ': ', testRun.unique_bestSolutionCount, ' pairs.\n')
    end
  end
end

--------------- output test results ---------------

-- get the background color for a line header cell
function GetLineHeaderColor(highlight, passed)
  return Ternary(highlight, Ternary(passed, colors.passed2, colors.failed2), colors.gray1)
end

-- get background color for horizontal sums
function GetHorizontalSumColor(sum)
  local colorEnabled = (conf.conditions.horizontal_sum > 0) or (conf.conditions.vertical_horizontal_sum > 0) or (conf.conditions.total_lines_sum > 0)
  return Ternary(colorEnabled, GetSumColor(sum), colors.gray1)
end

-- get background color for vertical sums
function GetVerticalSumColor(sum)
  local colorEnabled = (conf.conditions.vertical_sum > 0) or (conf.conditions.vertical_horizontal_sum > 0) or (conf.conditions.total_lines_sum > 0)
  return Ternary(colorEnabled, GetSumColor(sum), colors.gray1)
end

-- get background color for a diagonal sum cell
function GetDiagonalSumColor(sum)
  local colorEnabled = conf.conditions.total_lines_sum > 0
  return Ternary(colorEnabled, GetSumColor(sum), colors.gray1)
end

-- get the background color for a sum cell
function GetSumColor(sum)
  return Ternary(conf.minSum > 0, Ternary((sum or 0) >= conf.minSum, colors.passed2, colors.failed2), colors.gray1)
end

-- generate the output of a cell
function PrintCell(d, t, grid, minGrid, format_line1, format_line2)
  local lines = {}
  IndexedTable_InsertIfNotNil(lines, PrintCellLine(d, t, grid, minGrid, format_line1, conf.links))

  local line2 = PrintCellLine(d, t, grid, minGrid, format_line2, false, true)
  if line2 ~= nil then
    line2 = line2 .. GetValueUnit(format_line2)
    IndexedTable_InsertIfNotNil(lines, line2)
  end

  return table.concat(lines, '<br>')
end

-- generate content to print a line according to the given format
function PrintCellLine(d, t, grid, minGrid, format, link, addIconInFrontOfValue)
  local numRequiredCaches = minGrid[d][t]
  local cachesOfCell = grid[d][t]
  local numCaches = #cachesOfCell
  local cache = cachesOfCell[1]

  local content = PrintCellLineInternal(numCaches, numRequiredCaches, cache, format, addIconInFrontOfValue)
  if content == nil then
    return nil
  end
  content = tostring(content)

  if link then
    content = LinkToListing(cache, content)
  end

  return content
end

-- generate content to print a line according to the given format. When 'addIconInFrontOfValue'
-- is set (used for line 2), an available icon is shown in front of the value.
function PrintCellLineInternal(numCaches, numRequiredCaches, cache, format, addIconInFrontOfValue)
  numCaches = tostring(numCaches)

  if showMinValues then
    numCaches = numCaches .. '/' .. tostring(numRequiredCaches)
  end

  if format == 'n' then
    return numCaches
  end

  if format == 'gccode_with_n' then
    return (GetValue(cache, 'gccode') or '') .. ' (' .. numCaches .. ')'
  end

  local value = GetValue(cache, format)
  local escapedValue = Ternary(value == nil, value, PGC.HTMLEscape(tostring(value)))

  if conf.showAsIcon then
    return GetIcon(format, value, false) or escapedValue
  end

  if addIconInFrontOfValue and (value ~= nil) then
    local icon = GetIcon(format, value, false)
    if icon then
      return icon .. '&nbsp;' .. escapedValue
    end
  end

  return escapedValue
end

-- print the findsGrid
function PrintGrid(testRun, isUniqueGrid, format_line1, format_line2, showSums)
  local grid = Ternary(isUniqueGrid, testRun.uniqueGrid, testRun.findsGrid)
  local minGrid = testRun.minValueGrid

  local tmp = {}
  table.insert(tmp, '<table class="table-bordered-black align-center valign-middle" style="border: none;">')
  table.insert(tmp, '<tr>')
  table.insert(tmp, '<th style="border: none;"></th>')
  table.insert(tmp, '<th style="border: none;"></th>')
  table.insert(tmp, '<th colspan="9" style="border: none;">Terrain</th>')
  if showSums then
    table.insert(tmp, '<th style="border: none;"></th>')
  end
  table.insert(tmp, '</tr>')

  table.insert(tmp, '<tr>')
  table.insert(tmp, '<th style="border: none;"></th>')
  local color = GetLineHeaderColor(testRun.results.highlightLeftDiagonal, testRun.results.passedLeftDiagonal > 0) -- top left corner

  if showSums then
    table.insert(tmp, '<th style="background-color: ' .. color .. ';">⇘</th>')
  else
    table.insert(tmp, '<th style="border: none;"></th>')
  end

  for t = 1, 9 do
    local color = GetLineHeaderColor(testRun.results.highlightVertical, testRun.results.passedVerticals[t])
    table.insert(tmp, '<th style="background-color: ' .. color .. ';">' .. string.format("%.1f", (t + 1) / 2) .. '</th>')
  end
  if showSums then
    local sum = testRun.results.rightDiagonalSum
    table.insert(tmp, '<td style="background-color: ' .. GetDiagonalSumColor(sum) .. ';">' .. sum .. '</td>')
  end
  table.insert(tmp, '</tr>')

  for d = 1, 9 do
    table.insert(tmp, '<tr>')
    if d == 1 then
      table.insert(tmp, '<th rowspan="9" style="border: none;">Difficulty</th>')
    end
    local color = GetLineHeaderColor(testRun.results.highlightHorizontal, testRun.results.passedHorizontals[d])
    table.insert(tmp, '<th style="background-color: ' .. color .. ';">' .. string.format("%.1f", (d + 1) / 2) .. '</th>')
    -- print actual find count
    for t = 1, 9 do
      if not cellEnabled[d][t] then -- cell disabled
        table.insert(tmp, '<td style="background-color: ' .. colors.gray2 .. ';">✖</td>')
      else
        local numCaches = #(grid[d][t])

        if isUniqueGrid then
          if numCaches > 0 then
            table.insert(tmp, '<td style="background-color: ' .. colors.selected1 .. ';">' .. PrintCell(d, t, grid, minGrid, format_line1, format_line2) .. '</td>')
          else
            table.insert(tmp, '<td></td>')
          end
        else
          local color = colors.failed1
          if numCaches >= minGrid[d][t] then
            color = colors.passed1
          elseif numCaches > 0 then
            color = colors.progress1
          end

          local c = grid[d][t][1]
          if c and c.IsSelected then
            color = colors.selected1
          end

          table.insert(tmp, '<td style="background-color: ' .. color .. ';">' .. PrintCell(d, t, grid, minGrid, format_line1, format_line2) .. '</td>')
        end
      end
    end
    -- print sum of row
    if showSums then
      local sum = testRun.results.horizontalSums[d]
      table.insert(tmp, '<td style="background-color: ' .. GetHorizontalSumColor(sum) .. ';">' .. sum .. '</td>')
    end
    table.insert(tmp, '</tr>')
  end

  if showSums then
    -- print sum of column
    table.insert(tmp, '<tr>')
    table.insert(tmp, '<th style="border: none;"></th>')
    local color = GetLineHeaderColor(testRun.results.highlightRightDiagonal, testRun.results.passedRightDiagonal > 0) -- bottom left corner
    table.insert(tmp, '<th style="background-color: ' .. color .. ';">⇗</th>')
    for t = 1, 9 do
      local sum = testRun.results.verticalSums[t]
      table.insert(tmp, '<td style="background-color: ' .. GetVerticalSumColor(sum) .. ';">' .. sum .. '</td>')
    end
    -- print sum of left diagonal
    local sum = testRun.results.leftDiagonalSum
    table.insert(tmp, '<td style="background-color: ' .. GetDiagonalSumColor(sum) .. ';">' .. sum .. '</td>')
    table.insert(tmp, '</tr>')
  end

  table.insert(tmp, '</table>')

  table.insert(html, table.concat(tmp))
end

-- show results of a single test run
function ShowTestResults(testRun, showGrid, showTests)
  if testRun.sameValueHeader then
    table.insert(html, '<b>' .. testRun.sameValueHeader .. '</b>')
    if showTests then
      table.insert(log, testRun.sameValueHeader)
    end
  end

  --table.insert(html, 'Test score: ' .. testRun.score)

  if showGrid then
    -- if the only condition is unique_entries, then don't show the normal grid
    if not ((Count(testRun.tests) == 1) and (testRun.tests.unique_entries ~= nil)) then
      PrintGrid(testRun, false, conf.cell_format_line1, conf.cell_format_line2, conf.showSums)
    end
  end

  if showTests then
    if testRun.tests.entries ~= nil then
      local txt = testRun.results.entries .. ' entries of ' .. conf.conditions.entries .. ' needed with '

      if type(conf.minValue) == 'number' then
        txt = txt .. 'at least ' .. conf.minValue .. ' found ' .. Ternary(conf.minValue == 1, 'cache.', 'caches.')
      else
        txt = txt .. 'a sufficient find count.'
      end

      table.insert(html, TestPassedIcon(testRun.tests.entries) .. ' ' .. txt)
      table.insert(log, txt)
    end

    if testRun.tests.constraints ~= nil then
      local txt = 'Constraints for entries could '
      txt = txt .. Ternary(testRun.tests.constraints, 'be fulfilled.', 'not be fulfilled.')
      table.insert(html, TestPassedIcon(testRun.tests.constraints) .. ' ' .. txt)
      table.insert(log, txt)

      -- log selected values if constraints were defined
      for d = 1, 9 do
        for t = 1, 9 do
          local caches = testRun.findsGrid[d][t]
          if #caches > 0 then
            local c = caches[1]
            if c.IsSelected then
              table.insert(log, DtToString(d, t) .. ' ' .. c.gccode .. ' ' .. tostring(GetValue(c, conf.constraints.field)))
            end
          end
        end
      end
    end

    if testRun.tests.diversityConstraints ~= nil then
      local txt = 'Required diversity of ' .. GetValueLabel(conf.diversityConstraints.field) .. ' could '
      txt = txt .. Ternary(testRun.tests.diversityConstraints, 'be achieved.', 'not be achieved.')
      if (not testRun.tests.diversityConstraints) and (type(testRun.diversityConstraintsUnmet) == 'table') and (#testRun.diversityConstraintsUnmet > 0) then
        txt = txt .. ' (' .. table.concat(testRun.diversityConstraintsUnmet, ', ') .. ' not fulfilled)'
      end
      table.insert(html, TestPassedIcon(testRun.tests.diversityConstraints) .. ' ' .. txt)
      table.insert(log, txt)

      -- log selected values if diversity constraints were defined
      for d = 1, 9 do
        for t = 1, 9 do
          local caches = testRun.findsGrid[d][t]
          if #caches > 0 then
            local c = caches[1]
            if c.IsSelected then
              table.insert(log, DtToString(d, t) .. ' ' .. c.gccode .. ' ' .. tostring(GetValue(c, conf.diversityConstraints.field)))
            end
          end
        end
      end
    end

    if testRun.tests.loops ~= nil then
      local txt = 'Found ' .. testRun.results.loops .. ' out of required ' .. conf.conditions.loops .. ' loops.'
      table.insert(html, TestPassedIcon(testRun.tests.loops) .. ' ' .. txt)
      table.insert(log, txt)
    end

    if testRun.tests.total ~= nil then
      local txt = testRun.results.total .. ' out of required ' .. conf.conditions.total  .. ' caches found.'
      table.insert(html, TestPassedIcon(testRun.tests.total) .. ' ' .. txt)
      table.insert(log, txt)
    end

    if testRun.tests.passedEntriesTotal ~= nil then
      local txt = testRun.results.passedEntriesTotal .. ' out of required ' .. conf.conditions.passedEntriesTotal  .. ' caches found in passed entries.'
      table.insert(html, TestPassedIcon(testRun.tests.passedEntriesTotal) .. ' ' .. txt)
      table.insert(log, txt)
    end

    if testRun.tests.line2_sum_min ~= nil then
      local unit = GetValueUnit(conf.cell_format_line2)
      local txt = 'Collected ' .. testRun.results.line2Sum .. unit .. ' out of required ' .. conf.conditions.line2_sum_min .. unit
      if conf.line2_sum_all_entries then
        txt = txt .. ' over all entries.'
      else
        txt = txt .. ' over ' .. conf.conditions.entries .. ' entries.'
      end
      table.insert(html, TestPassedIcon(testRun.tests.line2_sum_min) .. ' ' .. txt)
      table.insert(log, txt)
    end

    if testRun.tests.line2_sum_max ~= nil then
      local unit = GetValueUnit(conf.cell_format_line2)
      local txt = 'Collected ' .. testRun.results.line2Sum .. unit .. ' out of allowed ' .. conf.conditions.line2_sum_max .. unit
      if conf.line2_sum_all_entries then
        txt = txt .. ' over all entries.'
      else
        txt = txt .. ' over ' .. conf.conditions.entries .. ' entries.'
      end
      table.insert(html, TestPassedIcon(testRun.tests.line2_sum_max) .. ' ' .. txt)
      table.insert(log, txt)
    end

    if testRun.tests.vertical_sum ~= nil then
      local txt = testRun.results.verticalSumsNr .. ' out of required ' .. conf.conditions.vertical_sum .. ' vertical lines had a sum of at least ' .. conf.minSum .. '.'
      table.insert(html, TestPassedIcon(testRun.tests.vertical_sum) .. ' ' .. txt)
      table.insert(log, txt)
    end

    if testRun.tests.horizontal_sum ~= nil then
      local txt = testRun.results.horizontalSumsNr .. ' out of required ' .. conf.conditions.horizontal_sum .. ' horizontal lines had a sum of at least ' .. conf.minSum .. '.'
      table.insert(html, TestPassedIcon(testRun.tests.horizontal_sum) .. ' ' .. txt)
      table.insert(log, txt)
    end

    if testRun.tests.vertical_horizontal_sum ~= nil then
      local txt = testRun.results.verticalHorizontalSumsNr .. ' out of required ' .. conf.conditions.vertical_horizontal_sum .. ' vertical / horizontal lines had a sum of at least ' .. conf.minSum .. '.'
      table.insert(html, TestPassedIcon(testRun.tests.vertical_horizontal_sum) .. ' ' .. txt)
      table.insert(log, txt)
    end

    if testRun.tests.total_lines_sum ~= nil then
      local txt = testRun.results.totalLinesSumsNr .. ' out of required ' .. conf.conditions.total_lines_sum .. ' vertical / horizontal / diagonal lines had a sum of at least ' .. conf.minSum .. '.'
      table.insert(html, TestPassedIcon(testRun.tests.total_lines_sum) .. ' ' .. txt)
      table.insert(log, txt)
    end

    if testRun.tests.vertical ~= nil then
      local txt = testRun.results.passedVerticals.numPassedLines .. ' out of required ' .. conf.conditions.vertical .. ' vertical lines completely filled.'
      table.insert(html, TestPassedIcon(testRun.tests.vertical) .. ' ' .. txt)
      table.insert(log, txt)
    end

    if testRun.tests.horizontal ~= nil then
      local txt = testRun.results.passedHorizontals.numPassedLines .. ' out of required ' .. conf.conditions.horizontal .. ' horizontal lines completely filled.'
      table.insert(html, TestPassedIcon(testRun.tests.horizontal) .. ' ' .. txt)
      table.insert(log, txt)
    end

    if testRun.tests.vertical_horizontal ~= nil then
      local txt = testRun.results.passedVerticalHorizontal .. ' out of required ' .. conf.conditions.vertical_horizontal .. ' vertical / horizontal lines completely filled.'
      table.insert(html, TestPassedIcon(testRun.tests.vertical_horizontal) .. ' ' .. txt)
      table.insert(log, txt)
    end

    if testRun.tests.left_diagonal ~= nil then
      local txt = 'Left diagonal (1/1-5/5)' .. Ternary(testRun.results.passedLeftDiagonal > 0, ' completely filled.', ' not completely filled.')
      table.insert(html, TestPassedIcon(testRun.tests.left_diagonal) .. ' ' .. txt)
      table.insert(log, txt)
    end

    if testRun.tests.right_diagonal ~= nil then
      local txt = 'Right diagonal (5/1-1/5)' .. Ternary(testRun.results.passedRightDiagonal > 0, ' completely filled.', ' not completely filled.')
      table.insert(html, TestPassedIcon(testRun.tests.right_diagonal) .. ' ' .. txt)
      table.insert(log, txt)
    end

    if testRun.tests.diagonal ~= nil then
      local txt = testRun.results.passedDiagonals .. ' out of required ' .. conf.conditions.diagonal .. ' diagonals completely filled.'
      table.insert(html, TestPassedIcon(testRun.tests.diagonal) .. ' ' .. txt)
      table.insert(log, txt)
    end

    if testRun.tests.total_lines ~= nil then
      local txt = testRun.results.passedTotalLines .. ' out of required ' .. conf.conditions.total_lines .. ' vertical / horizontal / diagonal lines completely filled.'
      table.insert(html, TestPassedIcon(testRun.tests.total_lines) .. ' ' .. txt)
      table.insert(log, txt)
    end

    if testRun.tests.unique_entries ~= nil then
      if showGrid then
        local uniqueCaches = {}

        table.sort(testRun.unique_bestSolution, function(a, b) return a.key1 < b.key1 end)
        for _, p in ipairs(testRun.unique_bestSolution) do
          local c = UniqueGetCache(testRun.uniqueSortedCaches, p.key1, p.key2)
          table.insert(uniqueCaches, c)
          table.insert(log, p.key1 .. ': ' .. tostring(p.key2) .. ' - ' .. (GetValue(c, 'gccode') or '') .. ' - ' .. (GetValue(c, 'cache_name') or ''))
          DrawUniqueEntryPolygon(true, c)
        end

        testRun.uniqueGrid = FillGrid(uniqueCaches)
        PrintGrid(testRun, true, 'gccode', conf.unique_entry_property, false)
      end

      local txt = 'Found ' .. testRun.unique_bestSolutionCount .. ' of ' .. conf.conditions.unique_entries .. ' needed unique combinations of D/T and ' .. GetValueLabel(conf.unique_entry_property) .. '.'
      table.insert(html, TestPassedIcon(testRun.tests.unique_entries) .. ' ' .. txt)
      table.insert(log, txt)
    end
  else -- just show information about achieved results
    if testRun.tests.entries ~= nil then
      local txt = testRun.results.entries .. ' entries with '

      if type(conf.minValue) == 'number' then
        txt = txt .. 'at least ' .. conf.minValue .. ' found ' .. Ternary(conf.minValue == 1, 'cache.', 'caches.')
      else
        txt = txt .. 'a sufficient find count.'
      end

      table.insert(html, txt)
    end

    if testRun.tests.constraints ~= nil then
      local txt = 'Constraints for entries could ' .. Ternary(testRun.tests.constraints, 'be fulfilled.', 'not be fulfilled.')
      table.insert(html, txt)
    end

    if testRun.tests.diversityConstraints ~= nil then
      local txt = 'Required diversity of ' .. GetValueLabel(conf.diversityConstraints.field) .. ' could ' .. Ternary(testRun.tests.diversityConstraints, 'be achieved.', 'not be achieved.')
      if (not testRun.tests.diversityConstraints) and (type(testRun.diversityConstraintsUnmet) == 'table') and (#testRun.diversityConstraintsUnmet > 0) then
        txt = txt .. ' (' .. table.concat(testRun.diversityConstraintsUnmet, ', ') .. ' not fulfilled)'
      end
      table.insert(html, txt)
    end

    if testRun.tests.loops ~= nil then
      local txt = 'Found ' .. testRun.results.loops .. ' loops.'
      table.insert(html, txt)
    end

    if testRun.tests.total ~= nil then
      local txt = testRun.results.total .. ' caches found.'
      table.insert(html, txt)
      table.insert(log, txt)
    end

    if testRun.tests.passedEntriesTotal ~= nil then
      local txt = testRun.results.passedEntriesTotal .. ' caches found in passed entries.'
      table.insert(html, txt)
    end

    if testRun.tests.line2_sum_min ~= nil then
      local unit = GetValueUnit(conf.cell_format_line2)
      local txt = 'Collected ' .. testRun.results.line2Sum .. unit
      if conf.line2_sum_all_entries then
        txt = txt .. ' over all entries.'
      else
        txt = txt .. ' over ' .. conf.conditions.entries .. ' entries.'
      end
      table.insert(html, txt)
    end

    if testRun.tests.line2_sum_max ~= nil then
      local unit = GetValueUnit(conf.cell_format_line2)
      local txt = 'Collected ' .. testRun.results.line2Sum .. unit
      if conf.line2_sum_all_entries then
        txt = txt .. ' over all entries.'
      else
        txt = txt .. ' over ' .. conf.conditions.entries .. ' entries.'
      end
      table.insert(html, txt)
    end

    if testRun.tests.vertical_sum ~= nil then
      local txt = testRun.results.verticalSumsNr .. ' vertical lines had a sum of at least ' .. conf.minSum .. '.'
      table.insert(html, txt)
    end

    if testRun.tests.horizontal_sum ~= nil then
      local txt = testRun.results.horizontalSumsNr .. ' horizontal lines had a sum of at least ' .. conf.minSum .. '.'
      table.insert(html, txt)
    end

    if testRun.tests.vertical_horizontal_sum ~= nil then
      local txt = testRun.results.verticalHorizontalSumsNr .. ' vertical / horizontal lines had a sum of at least ' .. conf.minSum .. '.'
      table.insert(html, txt)
    end

    if testRun.tests.total_lines_sum ~= nil then
      local txt = testRun.results.totalLinesSumsNr ..' vertical / horizontal / diagonal lines had a sum of at least ' .. conf.minSum .. '.'
      table.insert(html, txt)
    end

    if testRun.tests.vertical ~= nil then
      local txt = testRun.results.passedVerticals.numPassedLines ..' vertical lines completely filled.'
      table.insert(html, txt)
    end

    if testRun.tests.horizontal ~= nil then
      local txt = testRun.results.passedHorizontals.numPassedLines ..' horizontal lines completely filled.'
      table.insert(html, txt)
    end

    if testRun.tests.vertical_horizontal ~= nil then
      local txt = testRun.results.passedVerticalHorizontal .. ' vertical / horizontal lines completely filled.'
      table.insert(html, txt)
    end

    if testRun.tests.left_diagonal ~= nil then
      local txt = 'Left diagonal (1/1-5/5)' .. Ternary(testRun.results.passedLeftDiagonal > 0, ' completely filled.', ' not completely filled.')
      table.insert(html, txt)
    end

    if testRun.tests.right_diagonal ~= nil then
      local txt = 'Right diagonal (1/5-5/1)' .. Ternary(testRun.results.passedRightDiagonal > 0, ' completely filled.', ' not completely filled.')
      table.insert(html, txt)
    end

    if testRun.tests.diagonal ~= nil then
      local txt = testRun.results.passedDiagonals .. ' diagonals completely filled.'
      table.insert(html, txt)
    end

    if testRun.tests.total_lines ~= nil then
      local txt = testRun.results.passedTotalLines ..' vertical / horizontal / diagonal lines completely filled.'
      table.insert(html, txt)
    end

    if testRun.tests.unique_entries ~= nil then
      if showGrid then
        local uniqueCaches = {}

        table.sort(testRun.unique_bestSolution, function(a, b) return a.key1 < b.key1 end)
        for _, p in ipairs(testRun.unique_bestSolution) do
          local c = UniqueGetCache(testRun.uniqueSortedCaches, p.key1, p.key2)
          table.insert(uniqueCaches, c)
          table.insert(log, p.key1 .. ': ' .. tostring(p.key2) .. ' - ' .. (GetValue(c, 'gccode') or '') .. ' - ' .. (GetValue(c, 'cache_name') or ''))
          DrawUniqueEntryPolygon(true, c)
        end

        testRun.uniqueGrid = FillGrid(uniqueCaches)
        PrintGrid(testRun, true, 'gccode', conf.unique_entry_property, false)
      end

      local txt = 'Found ' .. testRun.unique_bestSolutionCount .. ' unique combinations of D/T and ' .. GetValueLabel(conf.unique_entry_property) .. '.'
      table.insert(html, txt)
    end
  end

  table.insert(html, '')
end

--------------- main program ---------------

local caches = Init()
if type(caches) ~= 'table' then
  return { ok = false, html = SafeConcatHTML(html) }
end

local numPassesRequired = 1
local numHints = 0
local testRuns = {}
local passedTestRuns = {}
local failedTestRuns = {}
local combine_results = conf.same and conf.same.combine_results
local combinedTestRun = InitTestRun({})

if conf.same then
  numPassesRequired = conf.same.limit
  numHints = conf.same.num_hints

  local findsBySameValue = {}
  for _, c in ipairs(caches) do
    local value = GetValue(c, conf.same.field)
    if value ~= nil then
      local cachesWithValue = findsBySameValue[value]
      if cachesWithValue == nil then
        cachesWithValue = {}
        findsBySameValue[value] = cachesWithValue
      end
      table.insert(cachesWithValue, c)
    end
  end

  findsBySameValue = AssociativeTable_ValuesToIndexedTable(findsBySameValue)
  table.sort(findsBySameValue, function(a, b) return #a > #b end) -- values with most finds first

  local sameLabel = GetValueLabel(conf.same.field) .. ': '

  for _, findsWithValue in ipairs(findsBySameValue) do
    local sameValue = GetValue(findsWithValue[1], conf.same.field)
    local testRun = InitTestRun(findsWithValue, sameLabel, sameValue)
    table.insert(testRuns, testRun)
  end
else -- simple test run over all caches (not using "same")
  table.insert(testRuns, InitTestRun(caches))
end

for _, testRun in ipairs(testRuns) do
  ComputeTestResults(testRun)
  PerformTests(testRun)

  if combine_results then
    table.insert(passedTestRuns, testRun)
  else
    if testRun.ok then
      table.insert(passedTestRuns, testRun)
      if #passedTestRuns >= numPassesRequired then
        ok = true
        if not (conf.same and conf.same.showAllTestResults) then
          break
        end
      end
    else
      table.insert(failedTestRuns, testRun)
    end
  end

  if abort then
    break -- out of time, do not attempt any further test runs
  end
end

if combine_results then
  for _, testRun in ipairs(testRuns) do
    CombineTestResults(combinedTestRun, testRun)
  end
  PerformTests(combinedTestRun)
  ok = combinedTestRun.ok
end

-- Allow unattended checks to return without worrying about generating logs, html, or maps
if args[1].environmentSettings.cli then
  return { ok = ok }
end

-- output general information only once

if conf.cell_format_line2 then
  local label = GetValueLabel(conf.cell_format_line2) or ''
  local txt = 'Second line of table cells shows '
  if conf.sort_by_line2 == 'less' then
    txt = txt .. 'lowest ' .. label .. ' of caches found in that cell.'
  elseif conf.sort_by_line2 == 'greater' then
    txt = txt .. 'highest ' .. label .. ' of caches found in that cell.'
  else
    txt = txt .. label .. ' of the first cache that was found in that cell.'
  end
  table.insert(html, txt)
  table.insert(html, '')
end

-- show result of test run(s)

if #passedTestRuns > 1 then
  local sorter = Ternary(conf.same.sort == 'Z-A', SelectGreaterSorter(conf.same.field), SelectLessSorter(conf.same.field))
  table.sort(passedTestRuns, function(a, b) return sorter(a.sameValue, b.sameValue) end)
end

local logEntriesShown = 0
for idx, testRun in ipairs(passedTestRuns) do
  local showGrid = (idx <= numPassesRequired) or (numPassesRequired == 0) or not combine_results
  local logLenBefore = #log
  ShowTestResults(testRun, showGrid, not combine_results)
  logEntriesShown = logEntriesShown + 1
  if logEntriesShown > numPassesRequired then
    for i = #log, logLenBefore + 1, -1 do table.remove(log, i) end
  end
end

local showAllTestResults = conf.same and conf.same.showAllTestResults

if conf.same and not combine_results then
  local txt = #passedTestRuns .. ' of ' .. numPassesRequired .. ' required ' .. GetValueLabelPlural(conf.same.field) .. ' passed.'
  table.insert(html, txt)
  table.insert(log, txt)

  if (not ok) or showAllTestResults then
    table.insert(html, '')
    table.insert(html, 'Best progress:')
    table.insert(html, '')
  end
end

if (not ok) or showAllTestResults then
  local numRunsPrinted = #passedTestRuns
  local numRunsToPrint = showAllTestResults and (#passedTestRuns + #failedTestRuns) or (numPassesRequired + numHints)
  table.sort(failedTestRuns, function(a, b) return a.score > b.score end)
  for _, testRun in ipairs(failedTestRuns) do
    local logLenBefore = #log
    ShowTestResults(testRun, true, true)
    logEntriesShown = logEntriesShown + 1
    if logEntriesShown > numPassesRequired then
      for i = #log, logLenBefore + 1, -1 do table.remove(log, i) end
    end
    numRunsPrinted = numRunsPrinted + 1
    if numRunsPrinted >= numRunsToPrint then
      break
    end
  end
end

if combine_results then
  local txt = 'Overall result over ' .. #passedTestRuns .. ' ' .. GetValueLabelPlural(conf.same.field) .. ':'
  table.insert(html, txt)
  table.insert(log, txt)
  ShowTestResults(combinedTestRun, false, true)
end

if conf.ShowTimeZoneDefinitions then
  PrintTimeZoneDefinitions()
end

if conf.ShowContinentDefinitions then
  PrintContinentDefinitions()
end

if abortDuringConstraintChecking or abortDuringDiversityChecking then
  table.insert(html, '')
  table.insert(html, 'The checker had to abort the search for a solution, because it was running out of time.')
  table.insert(html, 'This negative result does not necessarily mean that you are not qualified.')
end

if numCountryPolygonsShown > 0 then
  PGC.print('Showing ', numCountryPolygonsShown, ' country polygons on map.\n')
end

if numRegionPolygonsShown > 0 then
  PGC.print('Showing ', numRegionPolygonsShown, ' region polygons on map.\n')
end

if numCountyPolygonsShown > 0 then
  PGC.print('Showing ', numCountyPolygonsShown, ' county polygons on map.\n')
end

return { ok = ok, log = table.concat(log, '\n'), html = SafeConcatHTML(html), map = map }
