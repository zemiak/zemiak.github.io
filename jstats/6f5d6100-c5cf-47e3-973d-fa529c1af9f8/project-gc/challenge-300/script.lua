-- Functions used for "func" definitions in the config

function func(funcs, value, test, cache)
  if not value then return false end
  for _,arg in ipairs(funcs) do
    -- functions available for "func" definitions in the configuration
    local functions = 
    {
      append = function() value = value..cache[arg[2]] end
      ,
      append2 = function() value = value..arg[2]..(cache[arg[3]] or '') end
      ,
      let = function() value = arg[2] end
      ,
      add = function() value = value+arg[2] end
      ,
      sub = function() value = value-arg[2] end
      ,
      subtract = function() value = value - func(arg[2],value,test,cache) end
      ,
      mul = function() value = value*arg[2] end
      ,
      multiply = function() value = value * func(arg[2],value,test,cache) end
      ,
      div = function() value = value/arg[2] end
      ,
      neg = function() value = -value end
      ,
      abs = function() value = math.abs(value) end
      ,
      int = function() value = math.floor(value) end
      ,
      ceil = function() value = math.ceil(value) end
      ,
      format = function() value = string.format(arg[2], value) end
      ,
      match = function() value = string.match(value, arg[2]) end
      ,
      upper = function() value = string.upper(value) end
      ,
      lower = function() value = string.lower(value) end
      ,
      tonumber = function() value = tonumber(value) end
      ,
      substr = function() value = string.sub(value,arg[2],arg[3]) end
      ,
      bitmask = function() value = hasbit(value, arg[2]) end
      ,
      weekday = function() value = iso:parse(value):weekday_name(true) end
      ,
      sort = function() table.sort(value) end
      ,
      rsort = function() table.sort(value, function(a,b) return a>b end) end
      ,
      select_if = function() if value then value = func(arg[2],value,test,cache) else value = func(arg[3],"",test,cache) end end
      ,
      select_sign = function() if value < 0 then value = func(arg[2],value,test,cache) else value = func(arg[3],value,test,cache) end end
      ,
      select_min = function() value = math.min(func(arg[2],value,test,cache), func(arg[3],value,test,cache)) end
      ,
      select_max = function() value = math.max(func(arg[2],value,test,cache), func(arg[3],value,test,cache)) end
      ,
      limits = function() value = value >= arg[2] and value <= arg[3] end
      ,

      equal = function()     local x = arg[2]; if type(x)=="table" then x = func(arg[2],value,test,cache) end  value = value == x end
      ,
      notequal = function()  local x = arg[2]; if type(x)=="table" then x = func(arg[2],value,test,cache) end  value = value ~= x end
      ,
      greater = function()   local x = arg[2]; if type(x)=="table" then x = func(arg[2],value,test,cache) end  value = value > x end
      ,
      less = function()      local x = arg[2]; if type(x)=="table" then x = func(arg[2],value,test,cache) end  value = value < x end
      ,
      greater_e = function() local x = arg[2]; if type(x)=="table" then x = func(arg[2],value,test,cache) end  value = value >= x end
      ,
      less_e = function()    local x = arg[2]; if type(x)=="table" then x = func(arg[2],value,test,cache) end  value = value <= x end
      ,
      compare = function()   local x = arg[2]; if type(x)=="table" then x = func(arg[2],value,test,cache) end  if x < value then value = 1 elseif x > value then value = -1 else value = 0 end end
      ,
      max = function()       local x = arg[2]; if type(x)=="table" then x = func(arg[2],value,test,cache) end  if x > value then value = x end end
      ,
      min = function()       local x = arg[2]; if type(x)=="table" then x = func(arg[2],value,test,cache) end  if x < value then value = x end end
      ,

      
      set = function() cache[arg[2]] = value end
      ,
      get = function() value = cache[arg[2]] end
      ,
      setconf = function() conf[arg[2]] = value end
      ,
      getconf = function() value = conf[arg[2]] end
      ,
      insert = function() cache[arg[2]][value] = arg[3] end
      ,
      findnum = function() value = #finds end
      ,
      debug = function() PGC.print(arg[2], '=', value, "\n") end
      ,
      solve = function() value = solvecount(test, arg[2]) end
      ,
      solve2 = function() value = solvecount2(test, arg[2]) end
      ,
      solver = function() value = solvecounts(test, arg[2],arg[3],arg[4]) end
      ,
      countlist = function() value = countlist(test) end
      ,
      countlist2 = function() value = countlist2(test) end
      ,
      countlist3 = function() value = countlist3(test) end
      ,
      histogram = function() value = histogram(arg[2]) end
      ,
      jasmer = function() local date = Date {}; value=(date:year()*12+date:month())-(arg[2]*12+arg[3])+1 end
      ,
      fizzy = function() value = fizzy(test, value, arg[2]) end
      ,
      settest = function() test[arg[2]] = value end
      ,
      years = function() value = tonumber(string.sub(isotoday,1,4))-tonumber(string.sub(value,1,4)) end
      ,
      timespan = function()  value = math.floor( iso:parse(func(arg[2],value,test,cache)):diff(iso:parse(func(arg[3],value,test,cache))).time/86400 + 0.5) end
      ,
      age = function()  value = (cache.archived=="1" and iso:parse(cache.last_archive_date or cache.last_find_date) or today):diff(iso:parse(value)).time/86400 end
      ,
      add_by = function() value = value+func(arg[2],value,test,cache) end
      ,
      sub_by = function() value = value-func(arg[2],value,test,cache) end
      ,
      mul_by = function() value = value*func(arg[2],value,test,cache) end
      ,
      div_by = function() value = value/func(arg[2],value,test,cache) end
      ,
      souvenirs = function() value = #PGC.GetSouvenirs(profileId) end
      ,
      membership = function() value = PGC.GetMembershipCreatedDate(profileId) end
      ,
      today = function() value = isotoday end
      ,
      order = function() value = order(arg[2],arg[3]) end
      ,
      funen = function() value = MaGeo526() end
      ,
      no = function() value = not value end
      ,
      attributes = function() value=attrbits(test,cache) end
      ,
      attributes_total = function() value=countattrs(test) end
      ,
      to_profile_name = function() if value then value = PGC.ProfileId2Name(value) if not value then value = "[OPTOUT]" end else value = "[DELETED_USER]" end end
      ,
      lookup = function() value = arg[2][value] end
    }
    functions[arg[1]]()
  end
  return value -- return false if the test is not passed
end

-- Common Function Definitions and script starts here

local atime = os.clock()
iso = Date.Format("yyyy-mm-dd")
today = Date {}
isotoday = iso:tostring(today)

-- Given a bit index, get the value if that bit was set to 1
-- e.g.  given 4, set the fourth bit from the right to 1.  Result:  8
function bit(p)
  return 2 ^ (p - 1)  -- 1-based indexing
end

-- Given a bitfield and bitmask, AND the two to determine if the bitmask is set in this field.
function hasbit(x, p)
  return x % (p + p) >= p       
end

-- Count number of all attribute bits
function countbits(test,bits,range)
  local nr = 32*range+1
  local bnr = 0
  while bits > 0 do
    if bits % 2 > 0 then
      test.attributes[nr]=(test.attributes[nr] or 0)+1
      bits=bits-1
      bnr=bnr+1
    end
    bits=bits/2
    nr=nr+1
  end
  return bnr
end

-- Count number of all attributes
function attrbits(test,cache)
  return
  countbits(test,cache.attributes_set_1,0)
  +countbits(test,cache.attributes_set_2,1)
  +countbits(test,cache.attributes_set_3,2)
  +countbits(test,cache.attributes_unset_1,3)
  +countbits(test,cache.attributes_unset_2,4)
  +countbits(test,cache.attributes_unset_3,5)
end

-- Count number of all set attributes
function countattrs(test)
  local bnr=0
  for nr = 1, 192 do
    if test.attributes[nr] then bnr=bnr+1 end
    nr=nr+1
  end
  return bnr
end

function TableConcatLog(tbl)
  local txt = table.concat(tbl,"\n")
  if conf.links then
  	txt = string.gsub(txt, '{(GC%w+)}', '[%1](https://coord.info/%1)')
  	txt = string.gsub(txt, '{GL(%d+)}', '[Log](https://www.geocaching.com/seek/log.aspx?lid=%1)')
  end
  txt = string.gsub(txt, '{ATTR:([%w-_]*)}', '[%1]')
  return txt 
end

function TableConcatHTML(tbl)
  local txt = table.concat(tbl,"<br/>\n")
  if conf.links then
    txt = string.gsub(txt, '{(GC%w+)}', '<a href="https://coord.info/%1">%1</a>')
    txt = string.gsub(txt, '{GL(%d+)}', '<a href="https://www.geocaching.com/seek/log.aspx?lid=%1">Log</a>')
  end
  txt = string.gsub(txt, '{ATTR:([%w-_]*)}', '<img src="https://www.geocaching.com/images/attributes/%1.png" style="width:20px;" alt="%1">')
  return txt
end

function binarysearch(table, field, value)
  -- find the lowest position from ordered list
  local bot = 1
  local top = #table
  while bot <= top do
    local mid = math.floor((bot+top)/2)
    if table[mid][field] < value then
      bot = mid+1
    else
      top = mid-1
    end
  end
  return bot
end

-- Initialization for optional "polygon" field

function preparepolygons()

  local initialpolygons = {}

  if conf.polygons ~= nil then
    initialpolygons = conf.polygons
  elseif conf.polysets ~= nil then
    for _, name in ipairs(conf.polysets) do
      PGC.print("name: "..name.."\n")
      local polygons = PGC.GetJsonData(name)
      PGC.print("Polygons: \n")
      PGC.print(polygons)
      if (not polygons) then
          return { ok = false, log = "", html = "Unknown polyset: " .. name }
      end
      for _, p in ipairs(polygons) do
        table.insert(initialpolygons, p)
      end
    end
  elseif conf.polyset ~= nil then
      initialpolygons = PGC.GetJsonData(conf.polyset)
      if (initialpolygons == nil) then
          return { ok = false, log = "", html = "Unknown polyset: " .. conf.polyset }
      end
  else
    return -- no polygons defined
  end

  -- initialize bboxes

  local numberofpolygons = 0
  local polynames = {}
  local polygons = {}
  local excludenames = {}
  if (conf.excludepolys ~= nil) then
    for _, name in ipairs(conf.excludepolys) do
       excludenames[name] = name      
    end
  end

  local replacenames = conf.replacenames or {} 
  -- PGC.print(replacenames)

  -- initialize bboxes and counters and merge duplicate polygons
  for name, poly in pairs(initialpolygons) do
    PGC.print(name,"\n")
      if (conf.IgnorePolysContaining == nil or string.match(name, conf.IgnorePolysContaining) == nil) and 
         (excludenames[name] == nil) then

        if (poly.rect ~= nil) then
          local north = poly.rect[1]
          local south = poly.rect[2]
          local east = poly.rect[3]
          local west = poly.rect[4]
          poly.polypoints = {{}}
          table.insert(poly.polypoints[1], {north, east})
          table.insert(poly.polypoints[1], {north, west})
          table.insert(poly.polypoints[1], {south, west})
          table.insert(poly.polypoints[1], {south, east})
          table.insert(poly.polypoints[1], {north, east})
          PGC.print("NSEW-convert: ")
          PGC.print(poly)      
        end
        -- handle the case multiple polygons should be treated as one, FL-061 and FL-061B
        local truename = name
        if replacenames[name] ~= nil then
          truename = replacenames[name]
        end
        if conf.ignorepolynamesuffix ~= nil then
          local suffixlen = string.len(conf.ignorepolynamesuffix)
          local strlen = string.len(truename)
          local namesuffix = string.sub(truename, string.len(truename)-suffixlen+1)
          PGC.print(strlen.." "..suffixlen.." ["..namesuffix.."]")
          if namesuffix == conf.ignorepolynamesuffix then
            truename = string.sub(truename, 1, string.len(truename)-suffixlen)
            PGC.print("removing suffix")
          end
        end

        -- names with "/" in them crashes the sorting routine...
        truename = string.gsub(truename, "/", " ")

        -- PGC.print(name .. ">" .. truename..": ")

        if (polygons[truename] == nil) then
          -- PGC.print("First found\n")
          local p = poly
          polygons[truename] = p
          table.insert(polynames, truename)
          p.fullname = name
          p.bbox = { max = {-1000, -1000}, min = {1000, 1000}}
          p.counter = 0 
          p.caches = {}
        else
          PGC.print("Merged\n")                                              
          local p = polygons[truename]
          -- transfer all polygons to the master name
          for _, list in ipairs(poly.polypoints) do
            table.insert(p.polypoints, list)
          end
          p.fullname = p.fullname .. ", "..name
        end
       --for _, list in ipairs(poly.polypoints) do
       --  list.name = name
       --end
     else
       PGC.print("Skipping polygon "..name.."\n")
     end

  end

  function extendbbox(value, bbox, index)

    if value > bbox.max[index] then
      bbox.max[index] = value
    end
    if value < bbox.min[index] then
      bbox.min[index] = value
    end
    if value > bbox.max[index] then
      bbox.max[index] = value
    end
    if value < bbox.min[index] then
      bbox.min[index] = value
    end
  end

  -- update bbox for all polygons
  local bbox = { max = {-1000, -1000}, min = {1000, 1000}}
  for name, poly in pairs(polygons) do
    for _, list in ipairs(poly.polypoints) do
      for _, coord in ipairs(list) do
        for i, value in ipairs(coord) do
          extendbbox(value, poly.bbox, i)
          extendbbox(value, bbox, i)
        end
      end
    end
    numberofpolygons = numberofpolygons + 1
  end

  PGC.print("Number of polygons = ", numberofpolygons,"\n")
  -- table.sort(polynames)

  function areIntersecting(v1x1, v1y1, v1x2, v1y2, v2x1, v2y1, v2x2, v2y2) 

    -- Convert vector 1 to a line (line 1) of infinite length.
    -- We want the line in linear equation standard form: A*x + B*y + C = 0
    -- See: http://en.wikipedia.org/wiki/Linear_equation
    local a1 = v1y2 - v1y1;
    local b1 = v1x1 - v1x2;
    local c1 = (v1x2 * v1y1) - (v1x1 * v1y2);

    -- Every point (x,y), that solves the equation above, is on the line,
    -- every point that does not solve it, is either above or below the line.
    -- We insert (x1,y1) and (x2,y2) of vector 2 into the equation above.
    local d1 = (a1 * v2x1) + (b1 * v2y1) + c1;
    local d2 = (a1 * v2x2) + (b1 * v2y2) + c1;

    -- If d1 and d2 both have the same sign, they are both on the same side of
    -- our line 1 and in that case no intersection is possible. Careful, 0 is
    -- a special case, that's why we don't test ">=" and "<=", but "<" and ">".
    if (d1 > 0 and d2 > 0) then return false end
    if (d1 < 0 and d2 < 0) then return false end

    -- We repeat everything above for vector 2.
    -- We start by calculating line 2 in linear equation standard form.
    local a2 = v2y2 - v2y1;
    local b2 = v2x1 - v2x2;
    local c2 = (v2x2 * v2y1) - (v2x1 * v2y2);

    -- Calulate d1 and d2 again, this time using points of vector 1
    local d1 = (a2 * v1x1) + (b2 * v1y1) + c2;
    local d2 = (a2 * v1x2) + (b2 * v1y2) + c2;

    -- Again, if both have the same sign (and neither one is 0),
    -- no intersection is possible.
    if (d1 > 0 and d2 > 0) then return false end
    if (d1 < 0 and d2 < 0) then return false end

    -- If we get here, only three possibilities are left. Either the two
    -- vectors intersect in exactly one point or they are collinear
    -- (they both lie both on the same infinite line), in which case they
    -- may intersect in an infinite number of points or not at all.
    if ((a1 * b2) - (a2 * b1) == 0) then return false end

    -- If they are not collinear, they must intersect in exactly one point.
    return true;
  end

  function IsInsidePoly(lat, lon, poly)
    local e = poly.bbox.max[1] - poly.bbox.min[1];
    local raystart = {poly.bbox.min[1]-e, lon}
    local rayend = {lat, lon}
    local intersections = 0;
    for i, list in ipairs(poly.polypoints) do
      local prevpoint = nil
      for _, point in ipairs(list) do
        if prevpoint ~= nil then                                                
          if areIntersecting(
              raystart[1], raystart[2], rayend[1], rayend[2],
              prevpoint[1], prevpoint[2], point[1], point[2]) then
            intersections = intersections + 1
          end
        end
        prevpoint = point
      end
    end
    return intersections % 2 == 1

  end

  -- fill polygon field to all finds
  
  for _,cache in ipairs(finds) do
    local lat = tonumber(cache.latitude)
    local lon = tonumber(cache.longitude)
    for _, polyname in pairs(polynames) do
      local poly = polygons[polyname]
      local bboxok = lat ~= nil and lon ~= nil and 
      lat >= poly.bbox.min[1] and lat <= poly.bbox.max[1] and
      lon >= poly.bbox.min[2] and lon <= poly.bbox.max[2] 

      if bboxok and IsInsidePoly(lat, lon, poly) then
        cache.polygon = polyname
        break
      end
    end

  end


end -- prepare polygons

-- Prepare fields

function attributes(number)
  if number <= 32 then
    return number, "attributes_set_1","attributes_set"
  elseif number <= 64 then
    return number-32, "attributes_set_2","attributes_set"
  elseif number <= 96 then
    return number-64, "attributes_set_3","attributes_set"
  elseif number <= 128 then
    return number-96, "attributes_unset_1","attributes_unset"
  elseif number <= 160 then
    return number-128, "attributes_unset_2","attributes_unset"
  elseif number <= 192 then
    return number-160,"attributes_unset_3","attributes_unset"
  end
  error = error[error] -- error!
end


function preparefield(filter)

  local n = string.match(filter.field, "^attribute:(%d+)$")
  if n then
    local b,f,g = attributes(tonumber(n))
    filter.field = f
    needed[g] = true
    if not filter.func then filter.func = {} end
    table.insert(filter.func, 1, {"bitmask",bit(b) } )
  else
    local f,a,b = string.match(filter.field, "^(.*)%[(%d+),(%d+)%]$")
    if f then
      filter.field = f
      needed[f] = true
      if not filter.func then filter.func = {} end
      table.insert(filter.func, 1, {"substr",tonumber(a),tonumber(b)} )
    else
      needed[filter.field]=true
    end
  end 

  if filter.value then 
    filter.select={}
    filter.select[filter.value] = true
    filter.selected = true
  end

  if filter.include then 
    filter.select={}
    for _,value in ipairs(filter.include) do
      filter.select[value] = true
    end
    filter.selected = true
  end

  if filter.exclude then 
    filter.select={}
    for _,value in ipairs(filter.exclude) do
      filter.select[value] = true
    end
    filter.selected = nil
  end

  if filter.age then 
    local date = Date {}
    date:add{ day = -filter.age }
    filter.max = iso:tostring(date)
    PGC.print("Age set to ",filter.max,"\n")
  end
  
end

function cacheprint(cache, log, details)
  if log.limit and #log.output >= log.limit then return end
  if log.init then func(log.init, details, log, cache) end
  local line = {}
  local position = 1
  local format = log.format
  for separator,field,format,pos in string.gmatch(format, '(.-){([%w_#]+)([%w%%. ]*)}()') do 
    table.insert(line,separator)
    local txt
    if field == '#' then
      txt = details
    else
      txt = cache[field]
      if conf.links then
        if field == 'gccode' then 
          txt = '{'..cache[field]..'}'
        else if field == 'log_id' then 
            txt = '{GL'..cache[field]..'}'
          end
        end
      end
    end
    if not txt then
      txt = ''
    elseif format > '' then
      txt = string.format(format,txt)
    end
    table.insert(line, txt)
    position=pos
  end
  table.insert(line, string.sub(format,position))
  table.insert(log.output, PGC.HTMLEscape(table.concat(line)))
  if log.exclude then cache.exclude = true end 
end

function prepareprint(log)
  local position = 1
  local format = log.format
  for separator,field,format,pos in string.gmatch(format, '(.-){([%w_#]+)([%w%%. ]*)}()') do 
    if field ~= '#' then needed[field]=true end
    position=pos
  end
end

function preparefilters(filter)
  if filter.field then 
    preparefield(filter)
    if (type(filter.max)=="number" or type(filter.min)=="number") and not conf.nofilterfix then 
      if not filter.func then filter.func = {} end
      table.insert(filter.func, 1, {"tonumber"} )
    end
  else
    for _,filters in ipairs(filter) do 
      preparefilters(filters)
    end
  end
end

function preparetest(tests)
  for _,test in ipairs(tests) do
    if test.filters then preparefilters(test.filters) end
    if test.count then 
      local count = test.count
      repeat
        preparefield(count) 
        if not count.min then count.min = 1 end
        count = count.count
      until not count
    end
    if test.count2 then --alternative counter values
      local count = test.count2
      repeat
        preparefield(count) 
        if not count.min then count.min = 1 end
        count = count.count
      until not count
    end
    if test.calc then preparefield(test.calc) end
    if test.log then prepareprint(test.log) end
    if test.visitdate then 
      needed['visitdate']=true
      if test.visitdate.tests then 
        preparetest(test.visitdate.tests) 
      end
    end
    test.attributes={}
  end
end

function MaGeo526()
  local caches = PGC.GetFinds(7684056, { fields = fields, order = 'OLDESTFIRST', filter = conf.filter })
  PGC.print("Caches ",#caches,"\n")
  local num = 0
  for _,cache in ipairs(caches) do
    if Exclude[cache.gccode] ~= 1 and cache.archived=="0" and cache.disabled=="0" and cache.owner_id ~= profileId then
      num=num+1
      PGC.print("#",num," ",cache.gccode,"\n")
    end
  end
  return num
end


function histogram(field)
  -- Insert histogram based on given field. Insert "ord" field.
  local index = {}
  local hist = {}
  for _,cache in ipairs(finds) do
  	local value = cache[field]
    if value then
      if index[value] then
        index[value][2] = index[value][2] + 1
      else
        index[value] = {value,1}
        table.insert(hist,index[value])
      end
    end
  end
  table.sort(hist, function(a,b) return a[2]>b[2] end)
  local ord = 0
  local prev = 0
  for cur,record in ipairs(hist) do
    if record[2] == prev then -- shared ranks!
      record[3] = ord
    else
      record[3] = cur
      ord = cur
      prev = record[2]
    end
  end
  local ordfield = field..'_ord'
  for _,cache in ipairs(finds) do
  	local value = cache[field]
    if value then
      cache[ordfield] = index[value][3]
    end
  end
  return #hist
end

function order(field,direction)
  -- Insert order field based on given field. Insert "ord" field. Positive direction is ascending.
  local index = {}
  for _,cache in ipairs(finds) do
  	local value = cache[field]
    if value then
      table.insert(index, cache)
    end
  end
  if direction < 0 then
    table.sort(index, function(a,b) return tonumber(a[field])>tonumber(b[field]) end)
  else
    table.sort(index, function(a,b) return tonumber(a[field])<tonumber(b[field]) end)
  end
  local ordfield = field..'_ord'
  for ord,cache in ipairs(index) do
    cache[ordfield] = ord
  end
  return #index
end


function fizzy(test, value, limit)
  -- Test number of items and find the minimum subcount 

  PGC.print("Fizzy ", value, '/', limit, "\n")
  
  if value < limit then return 0 end
  
  value = NIL
  for key,value1 in pairs(test.count.values) do
	--PGC.print(key, '=', value1.count, "\n")
    if not value or value > value1.count then value = value1.count end
  end
  if not value then value = 0 end
  return value
end


function countlist(test)
  function counts(count,values)
    -- List values from secondary count tables
    if count.count then
      for key,value1 in pairs(values) do
        if value1.count >= count.min then counts(count.count,value1.values) end
      end
    else
      for key,value1 in pairs(values) do
        if test.log then cacheprint(value1.cache,test.log,key) end
      end
    end
  end
  
  --test.log.output = {}
  test.log.output = {}
  counts(test.count, test.count.values)
  return #test.log.output
end


function countlist2(test) -- as countlist but limited number of output values
  function counts(count,values,min,index)
    -- List values from secondary count tables up to minimum number
    if count.count then
      local m = 0
      for key,value1 in pairs(values) do
        if value1.count >= count.min then 
          m=m+1
          counts(count.count,value1.values, count.min, index..m.."/") 
          if m >= min then break end
        end
      end
    else
      local n = 0
      for key,value1 in pairs(values) do
        if test.log then 
          n=n+1
          cacheprint(value1.cache,test.log,index..n) 
          if n >= min then break end
        end
      end
    end
  end
  
  --test.log.output = {}
  test.log.output = {}
  counts(test.count, test.count.values, test.min, "")
  return #test.log.output
end


function countlist3(test)
  function counts(count,values,prefix)
    -- List all values from secondary count tables with order numbers
    if count.count then
      for key,value1 in pairs(values) do
        if value1.count >= count.min then counts(count.count,value1.values,prefix) else counts(count.count,value1.values,'FAILED ') end
      end
    else
      local n = 1
      for key,value1 in pairs(values) do
        if test.log then cacheprint(value1.cache,test.log,prefix..n) end
        n = n + 1
      end
    end
  end
  
  --test.log.output = {}
  test.log.output = {}
  counts(test.count, test.count.values,'')
  return #test.log.output
end


function solvecount(test,limit)
  -- Solve unique two level count values
  local used = {}
  local values1 = {}
  local back
  --local keys = {}

  for key,value1 in pairs(test.count.values) do
    value1.key = key
   	value1.nrkeys = 0
    for x,y in pairs(value1.values) do value1.nrkeys = value1.nrkeys + 1 end
    table.insert(values1,value1) 
    --PGC.print("Key ", key, "\n")

    --for x,y in pairs(value1) do
    --  PGC.print(x,"\n")
    --end
    --PGC.print("value1.values ", value1.values, "\n")

    --table.insert(keys,key) 
  end

  -- Optimizing solving order
  table.sort(values1, function(a,b) return a.nrkeys < b.nrkeys end)
  
  --PGC.print("Values ", #values1, "\n")

  test.log.output = {}
  local check = 0
  local success = true
  
  -- Recursive level solving
  function solve(level,result)
    if level > #values1 then 
      --PGC.print("result ",result,"/",#values1,"\n")
      back = limit - result
      if back <= 0 then return true end

      -- time-out handler
--	    check = check - 1
--      if check <= 0 then
--        check = 1000
--      	if conf.timeout and os.clock()-atime > conf.timeout then 
--          PGC.print("Solver time-out!\n")
--          success = false
--          return true 
--        end 
--      end

      return false 
    end

    local value1 = values1[level]
    for key,value2 in pairs(value1.values) do
      -- Try all values
      if not used[key] then
        used[key] = true
        
        --PGC.print(level,":",key,"\n")
        
        if solve(level+1,result+1) then
          -- Store found solution
          if test.log then cacheprint(value2.cache,test.log, value1.key) end
          return true
        end
        used[key] = false
        if back > 0 then return false end
      end
    end
    if solve(level+1,result) then return true end
    back = back - 1
    return false
  end  

  
  -- Try to solve starting from the first level
  if solve(1,0) and success then
    PGC.print("Solution found\n")
  else  
    PGC.print("No solution found\n")
    test.log.output = {}
--    if conf.timeout then return 0 end
    solve(1,limit) -- partial sample solution
  end
  return #test.log.output
end


function solvecount2(test,limit)
  -- Solve unique two level count values, (not skipping any keys)
  -- debug log: view-source:https://project-gc.com/Challenges?viewDebugLog={token}
  local used = {}
  local values1 = {}
  local best = 0
  
  for key,value1 in pairs(test.count.values) do
    value1.key = key
	value1.nrkeys = 0
    for x,y in pairs(value1.values) do value1.nrkeys = value1.nrkeys + 1 end
	--PGC.print("Key ", key," #",value1.nrkeys,"\n")
    table.insert(values1,value1) 
  end

  -- Recursive level solving
  function solve(level)
    if level > limit then return true end

    local value1 = values1[level]
    for key,value2 in pairs(value1.values) do
      -- Try all values
      if not used[key] then
        used[key] = true
        --PGC.Log(level,"/",value1.nrkeys,":",value1.key,"/",key,"\n")
        if solve(level+1) then
          -- Store found solution
          if test.log then cacheprint(value2.cache,test.log, value1.key) end
          return true
        end
        used[key] = false
      end
    end
    if level > best then best = level end
    return false
  end  


  --PGC.print("Values ", #values1, "\n")
  test.log.output = {}

  -- Optimizing solving order
  table.sort(values1, function(a,b) return a.nrkeys < b.nrkeys end)
  
  -- Try to solve starting from the first level
  if #values1 < limit then
    PGC.print("Not enough values\n")
    limit = #values1
  end
  if solve(1) then
    PGC.print("Solution found. Best=",limit,"\n")
  else  
    PGC.print("No solution found. Best=",best-1,"\n")
    if args[1].environmentSettings.cli ~= true then  --background job
      for i=limit-1,best-1,-1 do 
        if os.clock()-atime <= 30 then  --background job
          local r = solvecount(test,i)
          if r >= i then return r end
          PGC.print("No partial solution found for ",i,"\n")
        end
      end
    end
  end
  return #test.log.output
end


function solvecounts(test,limit,number,count)
  -- Solve unique two level count values (limit = number * count)
  -- limit = minimum number of first level items
  -- number = maximum number of second level items
  -- count = maximum number of first level items per second level item
  local used = {}
  local values1 = {}
  local back
  local values2 = 0
  local keys = {}
  
  for _,value1 in pairs(test.count.values) do 
    table.insert(values1,value1)
    table.insert(keys,key) 
  end
  
  test.log.output = {}

  -- Recursive level solving
  function solve(level,result)
    if level > #values1 then 
      back = limit - result
      if back <= 0 then return true end
      return false 
    end

    local value1 = values1[level]
    for key,value2 in pairs(value1.values) do
      -- Try all values
      local n = used[key] or 0
      if n == 0 then 
        if values2 >= number then
          n = count --not allowed
        else
          values2 = values2 + 1
        end
      end
      if n < count then
        used[key] = n+1
        if solve(level+1,result+1) then
          -- Store found solution
          if test.log then cacheprint(value2.cache,test.log,keys[level]) end
          return true
        end
        used[key] = n
        if n == 0 then 
          values2 = values2 - 1
        end
        if back > 0 then return false end
      end
    end
    if solve(level+1,result) then return true end
    back = back - 1
    return false
  end  

  -- Try to solve starting from the first level
  if solve(1,0) then
    PGC.print("Solution found\n")
  else  
    PGC.print("No solution found\n")
    solve(1,limit) -- partial sample solution
  end
  return #test.log.output
end

function inittest(tests)
  for _,test in ipairs(tests) do
    if test.init then func(test.init, true, test, test) end
    if test.count then 
      local count = test.count
      count.values = {} 
      repeat
        if count.init then func(count.init, true, test, count) end
        count = count.count
      until not count
    end
    if test.calc then 
      test.calc.total = 0
      test.calc.count = 0
      if test.calc.init then func(test.calc.init, true, test, test.calc) end
    end
    test.number = 0
    if test.visitdate then 
      test.visitdate.used = nil
      if test.visitdate.init then func(test.visitdate.init, true, test, test.visitdate) end
      if test.visitdate.tests then inittest(test.visitdate.tests) end
    end
    if test.filters then for _,filter in ipairs(test.filters) do
        if filter.init then func(filter.init, true, test, filter) end
      end
    end
    if test.log then test.log.output = {} end
  end
end


function qualify(test,index)

  local cache = finds[index]
  local passed = not cache.exclude

  function itemfilter(filter)
    local item = cache[filter.field]
    if filter.func then item = func(filter.func, item, test, cache) end
    if not item or
      filter.select and filter.select[item] ~= filter.selected or
      filter.max and item > filter.max or
      filter.min and item < filter.min
      then 
      return false 
    end
    return true
  end

  function testfilter_or(filters)
    if filters.field then return itemfilter(filters) end
    for _,filter in ipairs(filters) do
      if testfilter_and(filter) then return true end
    end 
    return false
  end

  function testfilter_and(filters)
    if filters.field then return itemfilter(filters) end
    for _,filter in ipairs(filters) do
      if not testfilter_or(filter) then return false end
    end 
    return true
  end

  if test.filters and not testfilter_and(test.filters) then passed = false end

  if passed then

    if test.count then 
      
      local find
      local match
      function counting(count, values)
        local item = cache[count.field]
        if count.func then item = func(count.func, item, test, cache) end
        if item then
          if count.count then 
            if values[item] == nil then values[item] = { count = 0, cache = cache, values = {} } end
            if counting(count.count, values[item].values) then
              values[item].count = values[item].count + 1
              if count.min == values[item].count then return true end
            end
          else
            if values[item] == nil then values[item] = { count = 0, cache = cache } end
            values[item].count = values[item].count + 1
            find = item
            if count.min >= values[item].count then
              	match = true
            	if count.min == values[item].count then return true end
            end
          end
        end
        return false
      end

      match = false
      if counting(test.count,test.count.values) then 
        test.number = test.number + 1
        if test.log then cacheprint(cache,test.log,find) end
      elseif match and test.log and test.log.showall then 
        cacheprint(cache,test.log,find) 
      end
      --alternative counter values
      if test.count2 and counting(test.count2,test.count.values) then
        test.number = test.number + 1
        if test.log then cacheprint(cache,test.log,find) end
      end
      
    elseif test.calc then
      local calc = test.calc
      local item = tonumber(cache[calc.field])
      if calc.func then item = func(calc.func, item, test, cache) end
      if item then
        calc.total = calc.total + item
        calc.count = calc.count + 1
        if calc.average then
          test.number = calc.total / calc.count
        else
          test.number = calc.total
        end
        if test.log then cacheprint(cache,test.log,test.number) end
      end
    elseif test.visitdate then
      local visitdate = test.visitdate
      if visitdate.tests then
        for _,caltest in ipairs(visitdate.tests) do
          if qualify(caltest,index) then 
            if not visitdate.used then visitdate.used = {} end
            table.insert(visitdate.used,cache)
          end
        end
      else
        if not visitdate.used then visitdate.used = {} end
        table.insert(visitdate.used,cache)
      end

    else
      test.number = test.number + 1
      if test.log then cacheprint(cache,test.log,test.number) end
    end
  end

  if test.visitdate then
    local visitdate = test.visitdate
    if visitdate.used then
      local next = finds[index+1]
      if not next 
        or visitdate.cycle == "streak" and (cache.visitdate ~= next.visitdate) and (iso:parse(next.visitdate):diff(iso:parse(cache.visitdate)).time > 129600)
        or visitdate.cycle == "daily" and (cache.visitdate ~= next.visitdate) 
        or visitdate.cycle == "monthly" and (string.sub(cache.visitdate,1,7) ~= string.sub(next.visitdate,1,7)) 
        or visitdate.cycle == "yearly" and (string.sub(cache.visitdate,1,4) ~= string.sub(next.visitdate,1,4)) then
        local count = 0
        if visitdate.tests then
          local ok = false
          for _,caltest in ipairs(visitdate.tests) do
            if caltest.func then caltest.number = func(caltest.func, caltest.number, caltest, cache) end
            if not caltest.number or
              caltest.min and caltest.number < caltest.min or
              caltest.max and caltest.number > caltest.max 
              then
              -- failed
            else
              count = count + 1
              ok = true
            end
            cache.total = caltest.number
            if caltest.log then
              if ok or caltest.log.showall then
                if caltest.log.func and not func(caltest.log.func, caltest.log.output, caltest) then
                  -- no print
                else
                  for _,line in ipairs(caltest.log.output) do
                    table.insert(test.log.output, line)
                  end
                end
              end
            end
          end
        else
          count = #visitdate.used
        end
        local ok = false
        if visitdate.min and count < visitdate.min or visitdate.max and count > visitdate.max then
          -- failed
        else
          if visitdate.func then 
            ok = func(visitdate.func, test.number, test, cache) 
            if ok > 0 then test.number = ok end
          else
            test.number = test.number + 1
            ok = true
          end
          --table.insert(print, cache.visitdate)
        end
        if test.log and (ok or test.log.showall) then 
          if visitdate.show then
            --local line = {}
            for _,cache in ipairs(visitdate.used) do
              cacheprint(cache,test.log) 
              --table.insert(line, code)
            end
            --cacheprint(cache,test.log, table.concat(line,",")) 
          else
            cacheprint(cache,test.log) 
          end
        end
        visitdate.used = nil
        if visitdate.tests then inittest(visitdate.tests) end
      end
    end
  end
  
  return passed;
end

-- MAIN program

args={...}
conf = args[1].config
profileName = args[1].profileName
profileId = args[1].profileId
conf.profileId = profileId
gccode = args[1].gccode or ''-- gccode from the tag
PGC.print('Got profile name, ', profileName, ' GC:',gccode, "\n") 

logs = {}
html = {}
needed = { gccode=true }
if conf.fields then 
  for _,field in ipairs(conf.fields) do
    needed[field] = true
  end
end

Exclude = {}
if type(conf.exclude) == "string" then
  Exclude[conf.exclude] = 1
elseif type(conf.exclude) == "table" then
  for _,key in ipairs(conf.exclude) do
    Exclude[key] = 1
  end
else
  Exclude[gccode] = 1
end

-- Preliminary preparing
preparetest(conf.tests)

-- Get data with optional global filter and fields needed

if conf.owned then needed.visitdate=true end -- for injecting with hidden dates
local fields={}
for field,_ in pairs(needed) do
  local o = string.match(field, "^(.*)_ord$")
  if o then 
    table.insert(fields,o)
  else
    table.insert(fields,field)
  end
end


finds = PGC.GetFinds(profileId, { fields = fields, order = 'OLDESTFIRST', filter = conf.filter,  
    excludeTravelingGeocaches = conf.excludeTravelingGeocaches,
  	excludeDupFinds = conf.excludeDupFinds })

PGC.print(#finds, " log entries found\n")

--create cache index if needed
if conf.owned or conf.favorites then
  for _,cache in ipairs(finds) do finds[cache.gccode] = cache end 
end

-- tag favorited caches
if conf.favorites then
  local favorites = PGC.GetFPDetailsForUser(profileId)
  count = 0
  if favorites then
    for _,gccode in ipairs(favorites) do
      if finds[gccode] then
        finds[gccode].favorite = true
        count = count + 1
      end
    end
  end
  PGC.print("Tagged ", count, " of ",#favorites, " favorited caches\n")
end

-- inserting owned caches to finds
if conf.owned then 
  --for _,cache in ipairs(finds) do finds[cache.gccode] = cache end --create cache index
  if not needed['hidden'] then table.insert(fields, 'hidden') end --used for "visitdate"
  for field,items in pairs(conf.owned) do 
    if not needed[field] then table.insert(fields, field) end
    for _,item in ipairs(items) do items[item]=true end --create filtering index
  end
  local hides = PGC.GetHides(profileId, { fields = fields })
  count = 0
  for _,cache in ipairs(hides) do
    if not finds[cache.gccode] then -- added only if not found
      local pass = true
      for field,items in pairs(conf.owned) do -- test filters
        if not items[cache[field]] then 
          pass = false 
          break
        end
      end
      if pass then -- insert to the correct position
        cache.visitdate = cache.hidden
        table.insert(finds, binarysearch(finds, 'visitdate', cache.hidden), cache)
        count = count + 1
        PGC.print(cache.gccode,"\n")
      end
    end
  end
  PGC.print("Included ", count, " of ",#hides, " owned hides\n")
end

-- inserting lab caches to finds
if conf.labs then 
  --for _,cache in ipairs(finds) do finds[cache.gccode] = cache end --create cache index
  local labs = PGC.GetLabCacheFinds(profileId)
  count = 0
  for _,cache in ipairs(labs) do
    local lab = {visitdate = cache.date_found, gccode = cache.guid, cache_name = cache.name, type = "Lab Cache"}
    table.insert(finds, binarysearch(finds, 'visitdate', lab.visitdate), lab)
    count = count + 1
  end
  PGC.print("Included ", count, " of ",#labs, " Lab Caches\n")
end


-- Preparing database

count = 0
PGC.print("Excluding")
for _,cache in ipairs(finds) do
  if Exclude[cache.gccode] then 
    cache.exclude = true -- no duplicates
    PGC.print(', ',cache.gccode)
  else
    Exclude[cache.gccode] = 2
    count = count + 1
  end
end
PGC.print("\n")
PGC.print(count, " log entries considered\n")

preparepolygons()

-- Testing

inittest(conf.tests)

if conf.debug then PGC.print("Tests: ",conf.tests) end -- show the actual configuration if debug set

local ok_number = 0
local testnumber = #conf.tests
for n,test in ipairs(conf.tests) do

  if test.condition and not func(test.condition, #finds, test, test) then 
    --table.remove(conf.tests,n)
    testnumber=testnumber-1
  else

    local atime = os.clock()
    PGC.print("Testing: ", test.name, "\n")
    --if test.log then test.log.output = {} end

    -- Do calculations
    for index = 1, #finds do
     qualify(test,index)
    end

    -- Post processing
    if test.func then test.number = func(test.func, test.number, test) end

    local verdict
      if not test.number or 
      test.min and test.number < test.min or
      test.max and test.number > test.max
      then
      verdict = "FAILED"
    else
      verdict = "PASSED"
      ok_number = ok_number + 1
    end

    PGC.print(test.number, " found ", verdict, "\n")
    local result = "Qualifying "..test.number
    if test.min and test.max then 
      result = result.." / "..test.min.."-"..test.max 
    elseif test.min or test.max then 
      result = result.." / "..(test.min or test.max)
    end    

    table.insert(logs, "\""..test.name.."\" "..result..', '..verdict)

    if #html > 0 then table.insert(html, "") end
    table.insert(html, "\""..test.name.."\"")
    if test.log then 
      if test.log.func and not func(test.log.func, test.log.output, test) then
        -- no print
      else
        if #test.log.output>0 then table.insert(html, table.concat(test.log.output, "<br/>\n")) end
        if test.log.samples and test.log.samples > 0 then
          local line = 1
          while line <= test.log.samples and line <= #test.log.output do
            table.insert(logs, test.log.output[line])
            line=line+1
          end
        end
      end
    end
    table.insert(html, result..', '..verdict)
    PGC.print("Time used ", os.clock() - atime," s\n")
  end
end

if not conf.min then conf.min = testnumber end
if 
  ok_number < conf.min
  or conf.max and ok_number > conf.max
  then
  verdict = "FAILED"
  ok = false
else
  verdict = "PASSED"
  ok = true
end

PGC.print("Qualified to ", ok_number, " tests ", verdict, "\n")

if testnumber > 1 or conf.min < testnumber or conf.max then
  local result = "All tests, Qualifying "..ok_number
  if conf.min and conf.max then 
    result = result.." / "..conf.min.."-"..conf.max 
  elseif conf.min or conf.max then 
    result = result.." / "..conf.min or conf.max 
  end    

  table.insert(logs, result..', '..verdict)
  table.insert(html, "")
  table.insert(html, result..', '..verdict)
end

logs = TableConcatLog(logs)
html = TableConcatHTML(html)

return { ok = ok, log = logs, html = html }
