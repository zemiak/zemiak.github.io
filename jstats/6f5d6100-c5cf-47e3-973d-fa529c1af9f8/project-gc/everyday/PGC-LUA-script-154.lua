-- FIXME: Consider foo.bar vs. foo['bar'].


-- Get information about user.
local args = {...}
profileName = args[1]['profileName']
PGC.print('Got profile name, ', profileName, "\n")
profileId = PGC.ProfileName2Id(profileName)
PGC.print('Converted to id ', profileId, "\n")
conf = args[1].config


-- Icons for all cache types (plus a checkbox).
local Type_Icons = {
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
  -- Not really the right icon for L&F-events (old version).
  ["Community Celebration Event"] =   "/images/gc-icons/3653.gif",
  ["Geocaching HQ Block Party"] =      "/images/gc-icons/4738_16.gif",
  ["Geocaching HQ Celebration"] = "/images/gc-icons/3774.gif",
  ["GPS Adventures Maze Exhibit"] =       "/images/gc-icons/2134.gif",
  ["Geocaching HQ Cache"] =               "/images/gc-icons/3773.gif",
  ["Project A.P.E. Cache"] =            "/images/gc-icons/ape_16.gif",
  ["Lab Cache"] =                    "/images/gc-icons/labcache_16.png",
}

local daysinmonth = { 31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 }
local alltypes = {
  "Traditional Cache",
  "Multi-Cache",
  "Mystery Cache",
  "EarthCache",
  "Letterbox Hybrid",
  "Wherigo Cache",
  "Virtual Cache",
  "Webcam Cache",
  "Event Cache",
  "Cache In Trash Out Event",
  "Mega-Event Cache",
  "Locationless Cache",
  "Giga-Event Cache",
  "Community Celebration Event",
  "Geocaching HQ Block Party",
  "Geocaching HQ Celebration",
  "GPS Adventures Maze Exhibit",
  "Geocaching HQ Cache",
  "Project A.P.E. Cache",
  "Lab Cache",
}


-- Clean up contents of conf hash (set default values, etc).
function CleanupConfig(conf)
  if conf.type ~= nil then
    if type(conf.type) == "string" and conf.type ~= "" then
      if conf.types == nil then
        conf.types = {}
      end
      table.insert(conf.types, conf.type)
    elseif type(conf.type) == "table" then
      if conf.types == nil then
        conf.types = {}
      end
      for _,v in pairs (conf.type) do
        conf.types[v] = v
      end
    end
  end
  conf.type = nil

  if conf.limit == nil then
    conf.limit = 1
  else
    conf.limit = tonumber(conf.limit)
  end

  if conf.years == nil then
    conf.years = 1
  else
    conf.years = tonumber(conf.years)
  end

  if conf.needed == nil then
    conf.needed = 366
  else
    conf.needed = tonumber(conf.needed)
  end

  if conf.leapday == "allow" then
    conf.leapday = "false"
  else
    conf.leapday = "true"
  end

  if conf.placed == nil then
    conf.placed = "false"
  else
    if conf.placed ~= "birthday" then
      conf.placed = "true"
    end
  end

  if conf.nooftypes ~= nil then
    conf.limit = conf.nooftypes
  end
  
  if conf.labs == nil or conf.labs == "true" then
    conf.labs = true  -- By default, labs are active.
  end
  if conf.placed ~= "false" then
    conf.labs = false -- Labs have no placement date.
  end

  if debug then
    PGC.print("Types: ", conf.types, "\n")
    PGC.print("Limit: ", conf.limit, "\n")
    PGC.print("Years: ", conf.years, "\n")
    PGC.print("Needed: ", conf.needed, "\n")
    PGC.print("Leapday: ", conf.leapday, "\n")
    PGC.print("Icontype: ", icontype, "\n")
    PGC.print("Placed: ", conf.placed, "\n")
    PGC.print("No of types: ", conf.nooftypes, "\n")
    PGC.print("Labs: ", conf.labs, "\n")
  end

  return conf
end


-- Set up filters.
function FilterFromConfig(conf)
  local filter = conf['filter'] or { }
  
  filter['country']       = filter['country']       or conf.country
  filter['region']        = filter['region']        or conf.region
  filter['county']        = filter['county']        or conf.county
  filter['minVisitDate']  = filter['minVisitDate']  or conf.minVisitDate
  filter['maxVisitDate']  = filter['maxVisitDate']  or conf.maxVisitDate
  filter['minHiddenDate'] = filter['minHiddenDate'] or conf.minHiddenDate
  filter['maxHiddenDate'] = filter['maxHiddenDate'] or conf.maxHiddenDate
  filter['excludeTypes']  = filter['excludeTypes']  or conf.excludeTypes
  filter['types']         = filter['types']         or conf.types
  filter['sizes']         = filter['sizes']         or conf.sizes
  filter['difficulties']  = filter['difficulties']  or conf.difficulties
  filter['terrains']      = filter['terrains']      or conf.terrains
  return filter
end


function makekey(month, day)
  return string.format("%02d-%02d", month, day)
end


function BuildLog(conf, status, years, notypes, ok, numdone, icontype)
  local html = ""
  local slog = ""
  local missing = { }
  local statustable = { }

  slog = numdone .. " dates of " .. conf.needed .. " completed. "
  if conf.leapday == "false" then
    slog = slog .. "This challenge allows leap day to be skipped. "
  end

  -- Show what is done and what is missing.
  if ok == false then
    if conf.nooftypes == nil then
      table.insert(statustable, '<br>Numbers in the calendar in ' 
        .. '<span style="color:red">red</span> are the number of ' 
        .. 'finds needed to meet the requirement that day.<br>')
    else
      table.insert(statustable, '<br>Completed days have a green checkmark. '
        .. 'Non-completed days show the icons for the cache types you '
        .. 'have found on that date so far.<br>')
    end
  end
  table.insert(statustable, 
    "<table class=\"table table-bordered\"><tr><td></td>")
  table.insert(statustable, "<tr>")
  table.insert(statustable, "<td style=\"padding: 1px;\"></td>")
  for day = 1, 31 do
    table.insert(statustable, "<td style=\"padding: 1px;\">" .. day .. "</td>")
  end
  table.insert(statustable, "</tr>")
  for month = 1, 12 do
    table.insert(statustable, "<tr>")
    table.insert(statustable, "<td style=\"padding: 1px;\">" .. month .. "</td>")
    for day = 1, 31 do
      local key = makekey(month, day)
      if day <= daysinmonth[month] then
        if conf.nooftypes == nil then
          if conf.years == 1 then
            -- Regular cache logs are counted.
            if status[key] == nil or status[key] < conf.limit then
              local diff = status[key] or 0
              diff = conf.limit - diff
              if ok == false then
                if month == 2 and day == 29 and conf.leapday == "false" then
                  table.insert(statustable, '<td><span style="color:red">(' 
                                           .. diff .. ")</span></td>")
                else
                  table.insert(statustable, '<td><span style="color:red">' 
                                           .. diff .. "</span></td>")
                end
              else
                table.insert(statustable, '<td></td>')
              end
              table.insert(missing, key)
            else
              table.insert(statustable, "<td><img src=\"" 
                                       .. Type_Icons[icontype] .. "\"></td>")
            end
          else
            -- Only one log per distinct year counts.
            local num = 0
            if years[key] ~= nil then
              for year, gccode in pairs(years[key]) do
                num = num + 1
              end
            end

            if num < conf.years then
              local diff = 0
              diff = conf.years - num
              if ok == false then
                if month == 2 and day == 29 and conf.leapday == "false" then
                  table.insert(statustable, '<td><span style="color:red">(' 
                                           .. diff .. ")</span></td>")
                else
                  table.insert(statustable, '<td><span style="color:red">' 
                                           .. diff .. "</span></td>")
                end
              else
                table.insert(statustable, '<td></td>')
              end
              table.insert(missing, key)
            else
              table.insert(statustable, "<td><img src=\"" .. Type_Icons['checkbox'] .. "\"></td>")
            end
          end
        else
          if status[key] >= conf.limit then
            table.insert(statustable, "<td><img src=\"" 
                                     .. Type_Icons['checkbox'] .. "\"></td>")
          else
            if status[key] == 0 then
              table.insert(statustable, "<td></td>")
            else
              local str = "<td>"
              for i, type in ipairs(alltypes) do
                if (notypes[key][type] ~= nil) then
                  str = str .. "<img src=\"" .. Type_Icons[type] .. "\"> "
                end
              end
              str = str .. "</td>"
              table.insert(statustable, str)
            end
          end
        end
      else
        table.insert(statustable, "<td>X</td>")
      end
    end
    table.insert(statustable, "</tr>")
  end
  table.insert(statustable, "</table>")

  -- PGC.print list of missing dates to debug, for those that want a text list.
  PGC.print(table.concat(missing, ", "))

  html = table.concat(statustable, "\n")

  return slog, html
end


function c_calendar(conf)
  local debug = conf.debug or false
  local status = { }
  local notypes = { }
  local years = { }

  -- Set default values and do some cleanup.
  conf = CleanupConfig(conf)

  -- Set up filtering.
  local filter = FilterFromConfig(conf)

  -- Set up types that should be excluded.
  local ExcludedTypes = {}
  if type(conf.ExcludedTypes) == "string" then
    if conf.ExcludedTypes ~= "Lab Cache" then
      ExcludedTypes[conf.ExcludedTypes] = conf.ExcludedTypes
    else
      conf.labs = false
    end
  elseif type(conf.ExcludedTypes) == "table" then 
    for _,v in pairs (conf.ExcludedTypes) do
      if v ~= "Lab Cache" then
        ExcludedTypes[v] = v
      else
        conf.labs = false
      end
    end
  end

  -- Figure out what icon to display.
  local icontype = "checkbox"
  if filter.types ~= nil and #filter.types == 1 and #ExcludedTypes == 0 then
    icontype = filter.types[1]
  end
  
  -- If types is given, we need to check if it contains labs and manually request
  -- them if so and otherwise turn them off.
  if filter.types ~= nil then
    conf.labs = false
    for _,v in pairs (filter.types) do
      if v == "Lab Cache" then
        conf.labs = true
      end
    end
  end

  -- If filter specifies just about anything, we need to turn labs off.
  if ((filter.difficulties ~= nil)
      or (filter.terrains ~= nil)
      or (filter.sizes ~= nil)
      or (filter.country ~= nil)
      or (filter.region ~= nil)
      or (filter.county ~= nil)) then
    conf.labs = false
  end

  myFinds = PGC.GetFinds(profileId, 
                         { includeLabCaches = conf.labs,
                           fields = { 'gccode', 
                                      'type', 
                                      'visitdate', 
                                      'hidden' },
                           order = 'OLDESTFIRST',
                           filter = filter } )

  local daysdone = 0
  for i, f in ipairs(myFinds) do
    -- Which caches count for the challenge can be determined due
    -- to find date, hidden date, or the cache being found on the
    -- same date that it was hidden ("birthday").
    if conf.placed == "true" then
      day = string.sub(f['hidden'], 6)
      year = string.sub(f['hidden'], 1, 4)
    else
      if conf.placed == "birthday" then
        -- FIXME: The combination of birthday and years is not handled.
        if string.sub(f['visitdate'], 6) == string.sub(f['hidden'], 6) 
          and string.len(f['visitdate']) == 10
          and string.len(f['hidden']) == 10 then
          day = string.sub(f['hidden'], 6)
        else
          day = "13-01"    -- Dummy date that will be ignored later.
        end
        year = string.sub(f['visitdate'], 1, 4)
      else
        day = string.sub(f['visitdate'], 6)
        year = string.sub(f['visitdate'], 1, 4)
      end
    end
  
    -- Keep track of number of types logged per day.
    -- FIXME: This does not consider ExcludedTypes.
    if notypes[day] == nil then
      notypes[day] = { }
    end
    if notypes[day][f['type']] == nil then
      notypes[day][f['type']] = { }
      notypes[day][f['type']] = f['gccode']
    end

    -- Keep track of the number of different years that the user has logged caches on.
    -- FIXME: This does not consider ExcludedTypes.
    if years[day] == nil then
      years[day] = { }
    end
    if years[day][year] == nil then
      years[day][year] = { }
      years[day][year] = f['gccode']
    end


    -- Regular checking of filled calendar.
    if ExcludedTypes[f.type] == nil then 
      -- Cache valid for challenge.
      if status[day] == nil then
        status[day] = 1
        daysdone = daysdone + 1
        -- PGC.print what day the challenge was completed.
        if daysdone == 366 then
          PGC.print("Completed date: " .. f['visitdate'] .. "\n")
        end
      else
        status[day] = status[day] + 1
      end
    end
  end


  -- What is done?
  local numdone = 0
  for month = 1, 12 do
    for day = 1, daysinmonth[month] do
      if conf.nooftypes == nil then
        -- We just look at number of finds.
        local key = makekey(month, day)
        if conf.years == 1 then
          if status[key] ~= nil and status[key] >= conf.limit then
            numdone = numdone + 1
          end
        else
          local num = 0
          if years[key] ~= nil then
            for type, gccode in pairs(years[key]) do
              num = num + 1
            end
            if num >= conf.years then
              numdone = numdone + 1
            end
          end
        end
      else
        -- We look at number of found cache types, not number of finds.
        local key = makekey(month, day)
        local num = 0
        if notypes[key] ~= nil then
          for type, gccode in pairs(notypes[key]) do
            num = num + 1
          end
          if num >= conf.nooftypes then
            numdone = numdone + 1
          end
        end
        status[key] = num
      end
    end
  end

  if debug then
    PGC.print("Completed " .. numdone .. " days of " .. conf.needed .. " needed.\n")
  end

  -- Check if completed.
  local ok = false
  if numdone >= conf.needed  
--    or (numdone == conf.needed - 1  -- bmuzzin change: https://project-gc.com/forum/read?11,107394,116810#msg-116810
    or (numdone == 365 and conf.needed == 366
    and conf.leapday == "false"
    and (status[makekey(2,29)] == nil 
      or (status[makekey(2,29)] ~= nil and status[makekey(2,29)] < conf.limit))
    ) then
    ok = true
  end

  -- Report results.
  local log = ""
  local slog = ""
  local html = ""
  local shtml = ""
  slog, html = BuildLog(conf, status, years, notypes, ok, numdone, icontype)
  shtml = slog 

  return { ok = ok, log = log, html = html, slog = slog, shtml = shtml }
end


-- Main function code
res = c_calendar(conf)

local ok = res.ok
local log = res.slog .. "\n\n" .. res.log
local html = res.shtml .. "<br>" .. res.html
return { ok = ok, log = log, html = html }
