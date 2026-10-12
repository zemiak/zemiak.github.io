local args={...}
local conf = args[1].config
local profileName = args[1].profileName
local profileId = args[1].profileId
local debug = conf.debug
local maxInGroup = conf.maxInGroup

field_details = {
  {field="words", toFetch={"words"}, isNumber=true},
  {field="visitdate_year_month", toFetch={"visitdate"}, isNumber=true},
  {field="visitdate_year", toFetch={"visitdate"}, isNumber=true},
  {field="visitdate_month_day", toFetch={"visitdate"}, isNumber=true},
  {field="visitdate_month", toFetch={"visitdate"}, isNumber=true},
  {field="visitdate_day", toFetch={"visitdate"}, isNumber=true},
  {field="visitdate_weekday", toFetch={"visitdate"}},
  {field="visitdate", toFetch={"visitdate"}},
  {field="type", toFetch={"type"}},
  {field="terrain", toFetch={"terrain"}, isNumber=true},
  {field="size", toFetch={"size"}},
  {field="reviewer", toFetch={}, isReviewer=true},
  {field="region", toFetch={"region"}},
  {field="premium", toFetch={"premium"}},
  {field="placed_by", toFetch={"placed_by"}},
  {field="owner_id", toFetch={"owner_id"}, isNumber=true},
  {field="num_finds", toFetch={"num_finds"}, isNumber=true},
  {field="longitude", toFetch={"longitude"}, isNumber=true},
  {field="log_id_url", toFetch={"log_id"}},
  {field="log_id", toFetch={"log_id"}},
  {field="length", toFetch={"length"}, isNumber=true},
  {field="latitude", toFetch={"latitude"}, isNumber=true},
  {field="latest_logs", toFetch={"latest_logs"}, isNumber=true},
  {field="last_publish_date_year_month", toFetch={"last_publish_date"}, isNumber=true},
  {field="last_publish_date_year", toFetch={"last_publish_date"}, isNumber=true},
  {field="last_publish_date_month_day", toFetch={"last_publish_date"}, isNumber=true},
  {field="last_publish_date_month", toFetch={"last_publish_date"}, isNumber=true},
  {field="last_publish_date_day", toFetch={"last_publish_date"}, isNumber=true},
  {field="last_publish_date", toFetch={"last_publish_date"}},
  {field="last_log_harvest", toFetch={"last_log_harvest"}},
  {field="last_find_date_year_month", toFetch={"last_find_date"}, isNumber=true},
  {field="last_find_date_year", toFetch={"last_find_date"}, isNumber=true},
  {field="last_find_date_month_day", toFetch={"last_find_date"}, isNumber=true},
  {field="last_find_date_month", toFetch={"last_find_date"}, isNumber=true},
  {field="last_find_date_day", toFetch={"last_find_date"}, isNumber=true},
  {field="last_find_date", toFetch={"last_find_date"}},
  {field="last_cache_harvest", toFetch={"last_cache_harvest"}},
  {field="last_archive_date", toFetch={"last_archive_date"}},
  {field="hidden_year_month", toFetch={"hidden"}, isNumber=true},
  {field="hidden_year", toFetch={"hidden"}, isNumber=true},
  {field="hidden_month_day", toFetch={"hidden"}, isNumber=true},
  {field="hidden_month", toFetch={"hidden"}, isNumber=true},
  {field="hidden_day", toFetch={"hidden"}, isNumber=true},
  {field="hidden_weekday", toFetch={"hidden"}, isNumber=true},
  {field="hidden", toFetch={"hidden"}},
  {field="gccode_url", toFetch={"gccode"}},
  {field="gccode", toFetch={"gccode"}},
  {field="ftf", toFetch={"ftf"}},
  {field="favorite_points_wilson", toFetch={"favorite_points_wilson"}, isNumber=true},
  {field="favorite_points_pct", toFetch={"favorite_points_pct"}, isNumber=true},
  {field="favorite_points", toFetch={"favorite_points"}, isNumber=true},
  {field="event", toFetch={"type"}},
  {field="elevation", toFetch={"elevation"}, isNumber=true},
  {field="disabled", toFetch={"disabled"}},
  {field="difficulty", toFetch={"difficulty"}, isNumber=true},
  {field="county", toFetch={"county"}},
  {field="country", toFetch={"country"}},
  {field="cache_name", toFetch={"cache_name"}},
  {field="cache_id", toFetch={"cache_id"}, isNumber=true},
  {field="attributes_unset_1", toFetch={"attributes_unset"}},
  {field="attributes_set_1", toFetch={"attributes_set"}},
  {field="attributes_unset_2", toFetch={"attributes_unset"}},
  {field="attributes_set_2", toFetch={"attributes_set"}},
  {field="attributes_unset_3", toFetch={"attributes_unset"}},
  {field="attributes_set_3", toFetch={"attributes_set"}},
  {field="attributes_unset", toFetch={"attributes_unset"}},
  {field="attributes_set", toFetch={"attributes_set"}},
  {field="archived", toFetch={"archived"}},
}

field_details_index = {}
for _, details in ipairs(field_details) do
  field_details_index[details.field] = details
end

if maxInGroup == nil then
  maxInGroup = 1000
end

if debug == nil then
  debug = false
end


function Log(...)
  if debug then
    PGC.Log (...)
    PGC.Log ("\n")
    PGC.print (...)
    PGC.print("\n")
  end
end

function boolean(value)
  if value then
    return "true"
  else
    return "false"
  end
end

function safe(val)
	if val == nil then
		return ""
	end
	return val
end

function comma_value(amount)
  local formatted = amount
  while true do
    formatted, k = string.gsub(formatted, "^(%-?%d+)(%d%d%d)", '%1,%2')
    if (k==0) then
      break
    end
  end
  return formatted
end

function fixed_length(str, length)
  if str == nil then
    str = ""
  end
  local formatted = str
  length = length + 1
  for i = string.len(str), length do
    formatted = formatted .. " "
  end
  return formatted
end

function fixed_length_right(str, length)
  local formatted = str
  length = length + 1
  for i = string.len(str), length do
    formatted = " " .. formatted
  end
  return formatted
end

function cachesToString(caches)
  retVal = ""
  for _, cache in pairs(caches) do
    retVal = retVal .. cache.gccode .. ", "
  end
  return retVal
end

function cloneTable(table)
  retVal = {}

  for key, value in pairs(table) do
      retVal[key] = value
    end

  return retVal
end

function removeElement(table, element)
  for i = 1, i <= #table do
    if table[i] == element then
      table.remove(table, i)
      return true
    end
  end
  return false
end

local function subsetIteratorNext(tracker)
  local count = tracker.numberItems
  for i=count,1,-1 do
    tracker.currentIndex[i] = tracker.currentIndex[i]+1
    if tracker.currentIndex[i] > (#tracker.originalList - (tracker.numberItems-i)) then
      if i == 1 then
        if tracker.numberItems <= tracker.minNumberItems then
          return nil
        else
          tracker.numberItems = tracker.numberItems - 1
          for i = 1,tracker.maxNumberItems, 1 do
            tracker.currentIndex[i] = i
          end
          break
        end
      end
    else 
      --reset everything below
      for j = i+1, tracker.numberItems do
        tracker.currentIndex[j] = tracker.currentIndex[j-1] +1
      end
      break
    end
  end
  
  local results = {}
  for i = 1, tracker.numberItems do
    results[i] = tracker.originalList[tracker.currentIndex[i]]
  end
  return results
end


local function ISubsetIterator(list, numberItems, maxNumberItems)
  Log("1Iterator: ", numberItems, "-", maxNumberItems, " (", type(maxNumberItems), ")")
  if maxNumberItems == nil then
    maxNumberItems = numberItems
  end
   Log("2Iterator: ", numberItems, "-", maxNumberItems, " (", type(maxNumberItems), ")")

  local tracker = { 
    originalList = cloneTable(list),
    currentIndex = {},
    numberItems = maxNumberItems,
    maxNumberItems = maxNumberItems,
    minNumberItems = numberItems,
  }
  for i = 1,maxNumberItems, 1 do
    tracker.currentIndex[i] = i
  end
  tracker.currentIndex[maxNumberItems] = maxNumberItems-1 
  return subsetIteratorNext, tracker
end

local function Parser()

  local self = {
      offset = 1,
      parentStack = {},
      usedFields = {gccode = true, visitdate=true, cache_name=true },
      lastCriteria = {},
      output = {
          truncateLists=true,
          criteria = {},
          output = {},
          defines={},
          groups={},
          groupsCreated = 0
      },
      fieldListUsage={},
    }

  local function mapUsedFields(fieldsToMap)
    retVal = {}
    for _,fieldDef in ipairs(field_details) do
      if fieldsToMap[fieldDef.field] == true then
        for _,mapping in ipairs(fieldDef.toFetch) do
          table.insert(retVal, mapping)
        end
      end
    end
    return retVal
  end

  local function expandMacros(expression, macros)
    local returnTable = {}
    if(type(expression) ~= "table") then
        expression = {expression}
    end
    
    for _, line in ipairs(expression) do
      if type(macros) == "table" then
        for pattern, replacement in pairs(macros) do
          line = string.gsub(line, pattern, replacement)
        end
      end
      table.insert(returnTable, line)
    end
    
    return table.concat(returnTable, "\n")
  end

  function self.parse(expression, macros)
    expression = expandMacros(expression, macros)
    lowerExpression = string.lower(expression)
    
    Log("Parsing: ", expression, "\n")
    while #self.currentState.next ~= 0 do
      local hasMatch = false
      local potentials = {}
      for _,nextState in ipairs(self.currentState.next) do
        table.insert(potentials, nextState.name)
--      Log("Attempting to match ", nextState.name, " (", nextState.pattern, ")")
      local expr 
        if nextState.preserveCase == true then
          expr = expression
        else
          expr = lowerExpression
        end
        i, j, group1, group2, group3 = string.find(expr, nextState.pattern, self.offset)
        if i ~= nil then
           -- Log("matched ", nextState.name)
              nextState.func(i, j, group1, group2, group3)
              self.currentState = nextState
            self.offset = j+1
          hasMatch = true
              break
         end
      if self.error ~= nil then
          break
        end
      end
      if self.error ~= nil then
        break;
      end
      if hasMatch == false then
         self.error = "Incomplete sentence expected " .. table.concat(potentials, " or ") .. " current position is " .. string.sub(expression,self.offset)
         break
      end
    end
  

    if self.error ~= nil then
      self.error = self.error .. "\n".. expression .."\n" .. fixed_length_right("^\n", self.offset)
      Log("Parsing failed: ", self.error, "\n")
    elseif self.currentState.isTerminal ~= true then
      self.error = "Coding error: " .. self.currentState.name .. " has no following states."
      Log(self.error, "\n")
    end
    self.output.fields = mapUsedFields(self.usedFields)
    self.output.usedFields = self.usedFields
   end



  local function clearTable(table)
    for key, value in pairs(table) do
        retVal[key] = nil
      end
  end

  local function func_with_name(i, j, name)
    self.lastCriteria.name = name
  end

  local function func_a_cache()
    self.lastCriteria.count = 1
    table.insert(self.output.criteria, self.lastCriteria)
    self.lastCriteria.definitionOrder = #self.output.criteria
  end

  local function func_n_caches(i, j, number)
    self.lastCriteria.count = number
    table.insert(self.output.criteria, self.lastCriteria)
    self.lastCriteria.definitionOrder = #self.output.criteria
  end

  local function func_grouped_by(i, j, field)
    self.lastCriteria.group=field
    self.usedFields[field] = true
  end

  local function func_with_unique(i, j, field)
    self.lastCriteria.unique =field
    self.usedFields[field] = true
  end

  local function func_noop()
  end

  local function func_field_lhs(i, j, fieldname)
    self.lastCriteria.field = fieldname
    self.usedFields[fieldname] = true
  end

  local function func_comparison(i, j, operator)
    self.lastCriteria.comparison = operator
  end

  local function func_field_rhs(i, j, fieldname)
    self.lastCriteria.field2 = fieldname
    self.lastCriteria.test = "fieldCompare"
    self.usedFields[fieldname] = true
  end


  local function func_literal_rhs(i, j, literal)
    self.lastCriteria.value = literal
    self.lastCriteria.test = "field"
  end
  
    local function func_literal_number_rhs(i, j, literal)
    self.lastCriteria.value = tonumber(literal)
    self.lastCriteria.test = "field"
  end




  local function func_join(i, j, operator)
    newLastCriteria = {}
    if #self.parentStack == 0 or self.parentStack[1].test ~= operator then
      newChild = cloneTable(self.lastCriteria)
      parentJoin = self.lastCriteria
      table.insert(self.parentStack, 1, parentJoin)
      parentJoin.test = operator
      parentJoin.value = {newChild, newLastCriteria}

      parentJoin.comparison = nil
      parentJoin.field = nil
      parentJoin.field2 = nil
    else
      table.insert(self.parentStack[1].value, newLastCriteria)
    end
    self.lastCriteria = newLastCriteria
  end

  local function func_open_bracket(i, j)
    self.lastCriteria.test = "bracket"
    newSelf = {}
    self.lastCriteria.value = {newSelf}
    table.insert(self.parentStack, 1, self.lastCriteria)
    self.lastCriteria = newSelf
  end

  local function func_close_bracket(i, j)
    if #self.parentStack == 0 then
      self.error = "Found closing bracket without matching opening bracket."
      return;
    end

    repeat
      popped = table.remove(self.parentStack, 1)
    until popped.test == "bracket" or #self.parentStack == 0

    self.lastCriteria = popped
  end

  local function func_end(i, j)
    while #self.parentStack > 0 do
      if table.remove(self.parentStack, 1).test == "bracket" then
        self.error = "Found closing bracket without matching opening bracket."
        return;
      end
    end
    self.lastCriteria = {}
  end



  local function func_define(i, j, fieldname)
    self.currentDefine = {list={}, stack = {}, field = fieldname, toFetch={}}
  end

  local function func_define_number(i, j, literal)
    table.insert(self.currentDefine.list, {type="literal", value=literal})
  end

  local function func_define_field(i, j, field)
    table.insert(self.currentDefine.list, {type="field", value=field})
    table.insert(self.currentDefine.toFetch, field)
  end

  local function func_define_operator(i, j, operator)
    local valueTable = {}
    valueTable["*"] = 3
    valueTable["/"] = 3
    valueTable["+"] = 2
    valueTable["-"] = 2
    local size = #self.currentDefine.stack

    local newOperatorValue = valueTable[operator]
    while size > 0 do
      existingOperatorValue = valueTable[self.currentDefine.stack[size]]
      if newOperatorValue < existingOperatorValue then
        existingOp = table.remove(self.currentDefine.stack)
        size = size -1
        table.insert(self.currentDefine.list, {type="operator", value=existingOp})
      else
        break
      end
    end
    table.insert(self.currentDefine.stack, operator)
  end

  local function func_define_open_bracket(i, j)
      table.insert(self.currentDefine.stack, "(")
    end


  local function func_define_close_bracket(i, j)
    while #self.currentDefine.stack > 0 do
      local head = table.remove(self.currentDefine.stack)
      if head == "(" then
        break;
      else
        table.insert(self.currentDefine.list, {type="operator", value=head})
      end
    end
  end

  local function func_define_end(i, j)
    table.insert(self.output.defines, self.currentDefine)
    for _, list in ipairs(self.fieldListUsage) do
    local first = list[1]
      table.insert(list, {name=self.currentDefine.field, pattern = "^%s*(".. self.currentDefine.field ..")", next = first.next, func = first.func})
    end
    table.insert(field_details, 1, self.currentDefine)
    field_details_index[self.currentDefine.field] = self.currentDefine
  end

  local function func_define_expr_end(i, j)
    while #self.currentDefine.stack > 0 do
      local head = table.remove(self.currentDefine.stack)
      table.insert(self.currentDefine.list, {type="operator", value=head})
    end
    
    func_define_end(i, j)
  end
  

  local function func_define_match_literal(i, j, pattern)
    table.insert(self.currentDefine.list, {type="literalStr", value=pattern})
  end

  local function func_define_match_field(i, j, field)
    table.insert(self.currentDefine.list, {type="fieldStr", value=field})
    table.insert(self.currentDefine.list, {type="operator", value="match"})
    table.insert(self.currentDefine.toFetch, field)
  end

  local function func_define_toupper(i, j, field)
    table.insert(self.currentDefine.list, {type="fieldStr", value=field})
    table.insert(self.currentDefine.list, {type="function1", value="toupper"})
    table.insert(self.currentDefine.toFetch, field)
  end

  local function func_output_any(i,j)
    table.insert(self.output.output, {ifWin=true, ifFail=true})
  end


  local function func_output_if_win(i,j)
    table.insert(self.output.output, {ifWin=true, ifFail=false})
  end


  local function func_output_if_fail(i,j)
    table.insert(self.output.output, {ifWin=false, ifFail=true})
  end

  local function func_output_sorted_by(i, j, field)
    self.output.output[#self.output.output].sortBy=field
    self.usedFields[field] = true
  end


  local function func_output_table(i, j)
    self.output.output[#self.output.output].type="table"
    self.output.output[#self.output.output].fields = {}
  end

  local function func_output_field(i, j, field)
    table.insert(self.output.output[#self.output.output].fields, {field=field, name=field})
    self.usedFields[field] = true
  end

  local function func_output_as(i, j, name)
    fields =  self.output.output[#self.output.output].fields
    fields[#fields].name = name
  end

  local function func_output_literal(i, j, str)
     self.output.output[#self.output.output].type="literal"
    self.output.output[#self.output.output].text=str
  end
  
  local function func_output_groups(i, j)
     self.output.output[#self.output.output].type="groups"
     self.output.output[#self.output.output].fields = {}
    self.output.output[#self.output.output].totals = false
    self.output.output[#self.output.output].gccodes = false
    self.output.output[#self.output.output].names = false
    self.output.output[#self.output.output].empty = false
    self.output.output[#self.output.output].all = false
    self.output.output[#self.output.output].needed = false
    self.output.output[#self.output.output].winning = false
    self.output.output[#self.output.output].winner = false
  end

  local function func_output_groups_args(i, j, arg)
    self.output.output[#self.output.output][arg] = true
  end

  local function func_within_n_days(i, j, days)
     self.output.window = tonumber(days)
  end

  local function func_with_unique_caches(i, j)
    self.output.groupsUniqueCaches = true
  end

  local function func_with_n_groups(i, j, num)
    self.output.groupsRequired = tonumber(num)
  end


  local function createFields(sourceStep, func, next)
    table.insert(self.fieldListUsage, sourceStep.next)
    for _, field in pairs(field_details) do
      table.insert(sourceStep.next, {name=field.field, pattern = "^%s*(".. field.field ..")", next = next, func = func})
    end
  end

  local START = {next = {}}
  local WITH_NAME = {name="with name", pattern = "^%s*with name", next = {}, func = func_noop}
  local WITH_NAME_NAME = {name="'name'", pattern = "^%s*'(.-)'", next = {}, func = func_with_name, preserveCase = true}
  local WITH_NAME_NAME_B = {name="`name`", pattern = "^%s*`(.-)`", next = {}, func = func_with_name, preserveCase = true}
  local FIND = {name="find", pattern = "^%s*find", next = {}, func = func_noop}
  local A_CACHE = {name="A cache", pattern = "^%s*a cache", next = {}, func = func_a_cache}
  local N_CACHES = {name = "n caches", pattern = "^%s*(%d+) caches", next = {}, func = func_n_caches}
  local GROUPED_BY = {name = "grouped by", pattern = "^%s*grouped by", next = {}, func = func_noop}
  local WITH_UNIQUE = {name="with unique", pattern ="^%s*with unique", next = {}, func=func_noop}

  local WHERE = {name = "where", pattern = "^%s*where", next = {}, func = func_noop}
  local FIELD = {name="field", pattern="^%s*field", next = {}, func=func_noop}
  local LITERAL = {name = "'literal'", pattern = "^%s*'(.-)'", func = func_literal_rhs, preserveCase = true}
  local LITERAL_B = {name = "`literal`", pattern = "^%s*`(.-)`", func = func_literal_rhs, preserveCase = true}
  local NUMBER = {name = "number", pattern = "^%s*(%-?%d*%.?%d+)", func = func_literal_number_rhs}
  local BOOL_TRUE = {name = "number", pattern = "^%s*(true)", func = func_literal_rhs}
  local BOOL_FALSE = {name = "number", pattern = "^%s*(false)", func = func_literal_rhs}
  
  local AND = {name = "and", pattern = "^%s*(and)", next = {}, func = func_join}
  local OR = {name = "or", pattern = "^%s*(or)", next = {}, func = func_join}
  local END = {name=".", pattern="^%s*%.", next = {}, func=func_end}
  local OPEN_BRACKET = {name = "(", pattern = "^%s*%(", next = {}, func = func_open_bracket}
  local CLOSE_BRACKET = {name = ")", pattern = "^%s*%)", next = {}, func = func_close_bracket}

  local COMP_LT = {name="<", pattern = "^%s*(<)", next = {}, func = func_comparison}
  local COMP_LTEQ = {name="<=", pattern = "^%s*(<=)", next = {}, func = func_comparison}
  local COMP_EQ = {name="==", pattern = "^%s*(==)", next = {}, func = func_comparison}
  local COMP_GT = {name=">", pattern = "^%s*(>)", next = {}, func = func_comparison}
  local COMP_GTEQ = {name=">=", pattern = "^%s*(>=)", next = {}, func = func_comparison}
  local COMP_NEQ = {name="<>", pattern = "^%s*(<>)", next = {}, func = func_comparison}
  local COMP_MATCHES = {name="matches", pattern = "^%s*(matches)", next = {}, func = func_comparison}
  local COMP_HAS = {name="has", pattern = "^%s*(has)", next = {}, func = func_comparison}
  local COMP_MISSING = {name="missing", pattern = "^%s*(missing)", next = {}, func = func_comparison}


  local OUTPUT_IF_WIN = {name="if win output", pattern = "^%s*if win output", next = {}, func = func_output_if_win}
  local OUTPUT_IF_FAIL = {name="if fail output", pattern = "^%s*if fail output", next = {}, func = func_output_if_fail}

  local OUTPUT_ANY = {name="output", pattern = "^%s*output", next = {}, func = func_output_any}
  
  local OUTPUT_GROUPS = {name="groups", pattern = "^%s*groups", next = {}, func = func_output_groups}
  local OUTPUT_GROUPS_IF_WINNING = {name="winning", pattern = "^%s*if (winning)", next = {}, func = func_output_groups_args}
  local OUTPUT_GROUPS_WITH = {name="with", pattern = "^%s*with", next = {}, func = func_noop}
  local OUTPUT_GROUPS_AND = {name="and", pattern = "^%s*and", next = {}, func = func_noop}
  local OUTPUT_GROUPS_TOTALS = {name="totals", pattern = "^%s*(totals)", next = {}, func = func_output_groups_args}
  local OUTPUT_GROUPS_GCCODES = {name="gccodes", pattern = "^%s*(gccodes)", next = {}, func = func_output_groups_args}
  local OUTPUT_GROUPS_NAMES = {name="names", pattern = "^%s*(names)", next = {}, func = func_output_groups_args}
  local OUTPUT_GROUPS_INCLUDING_EMPTY = {name="including empty", pattern = "^%s*including (empty)", next = {}, func = func_output_groups_args}
  local OUTPUT_GROUPS_ALL_MATCHES = {name="all matches", pattern = "^%s*(all) matches", next = {}, func = func_output_groups_args}
  local OUTPUT_GROUPS_VISITDATES = {name="visitdates", pattern = "^%s*(visit%s*dates)", next = {}, func = func_output_groups_args}
  local OUTPUT_GROUPS_NEEDED = {name="needed", pattern = "^%s*(needed)", next = {}, func = func_output_groups_args}
  
  local OUTPUT_SORTED_BY = {name="sorted by", pattern = "^%s*sorted by", next = {}, func = func_noop}
  local OUTPUT_TABLE = {name=" table", pattern = "^%s*table", next = {}, func = func_output_table}
  local OUTPUT_AS = {name="as 'name'", pattern = "^%s*as%s+'(.-)'", next = {}, func = func_output_as}
  local OUTPUT_COMMA = {name=",", pattern = "^%s*,", next = {}, func = func_noop}
  local OUTPUT_END = {name=".", pattern = "^%s*%.", next = {}, func = func_noop}
  local OUTPUT_LITERAL = {name="'string'", pattern = "^%s*'(.-)'", next = {}, func = func_output_literal, preserveCase = true}
  local OUTPUT_LITERAL_B = {name="`string`", pattern = "^%s*`(.-)`", next = {}, func = func_output_literal, preserveCase = true}

  local DEFINE = {name="define", pattern = "^%s*define", next = {}, func = func_noop}
  local DEFINE_NAME = {name="'name'", pattern = "^%s*'(.-)'", next = {}, func = func_define, preserveCase = true}
  local DEFINE_NAME_B = {name="`name`", pattern = "^%s*`(.-)`", next = {}, func = func_define, preserveCase = true}
  local DEFINE_AS = {name="as", pattern = "^%s*as", next = {}, func = func_noop}
  
  local DEFINE_END = {name=".(defend)", pattern = "^%s*%.", next = {}, func = func_define_end}

  local DEFINE_MATCH = {name="match", pattern = "^%s*match", next = {}, func = func_noop}
  local DEFINE_MATCH_LITERAL = {name="'pattern'", pattern = "^%s*'(.-)'", next = {}, func = func_define_match_literal, preserveCase = true}
  local DEFINE_MATCH_LITERAL_B = {name="`pattern`", pattern = "^%s*`(.-)`", next = {}, func = func_define_match_literal, preserveCase = true}
  local DEFINE_MATCH_ON = {name="on", pattern = "^%s*on", next = {}, func = func_noop}

  local DEFINE_UPPERCASE = {name="uppercase", pattern = "^%s*uppercase", next = {}, func = func_noop}

  local DEFINE_EXPRESSION = {name="expression", pattern = "^%s*expression", next = {}, func = func_noop}
  local DEFINE_EXPRESSION_NUMBER = {name="<number>", pattern = "^%s*(%-?%d*%.?%d+)", next = {}, func = func_define_number}
  local DEFINE_EXPRESSION_PLUS = {name="+", pattern = "^%s*(+)", next = {}, func = func_define_operator}
  local DEFINE_EXPRESSION_MINUS = {name="-", pattern = "^%s*(-)", next = {}, func = func_define_operator}
  local DEFINE_EXPRESSION_MULT = {name="*", pattern = "^%s*(*)", next = {}, func = func_define_operator}
  local DEFINE_EXPRESSION_DIV = {name="/", pattern = "^%s*(/)", next = {}, func = func_define_operator}
  local DEFINE_EXPRESSION_OPEN_BRACKET = {name="(", pattern = "^%s*%(", next = {}, func = func_define_open_bracket}
  local DEFINE_EXPRESSION_CLOSE_BRACKET = {name=")", pattern = "^%s*%)", next = {}, func = func_define_close_bracket}
  local DEFINE_EXPRESSION_END = {name=".(defend)", pattern = "^%s*%.", next = {}, func = func_define_expr_end}

  local FULFILLED = {name="fulfilled", pattern = "^%s*fulfilled", next = {}, func = func_noop}
  local WITHIN = {name="within n days", pattern = "^%s*within (%d+) days?", next = {}, func = func_within_n_days}
  local WITH_UNIQUE_CACHES = {name="with unique caches", pattern = "^%s*with unique caches", next = {}, func = func_with_unique_caches}
  local WITH_N_GROUPS = {name="with n groups", pattern = "^%s*with (%d+) groups?", next = {}, func = func_with_n_groups}
  local FULFILLED_AND = {name="and", pattern = "^%s*and", next = {}, func = func_noop}
  local FULFILLED_END = {name=".", pattern="^%s*%.", next = {}, func=func_noop}

  local TERMINAL_STATE = {name="end", pattern = "^%s*$", next = {}, func = func_noop, isTerminal = true}

  local COMP_NEXT = {COMP_NEQ,  COMP_LTEQ, COMP_EQ, COMP_GTEQ, COMP_GT,COMP_LT, COMP_MATCHES, COMP_HAS, COMP_MISSING }
  local POST_EXPRESSION_NEXT = {AND, OR, CLOSE_BRACKET, END}
  local EXPRESSION_OPERATOR = {DEFINE_EXPRESSION_PLUS, DEFINE_EXPRESSION_MINUS, DEFINE_EXPRESSION_MULT, DEFINE_EXPRESSION_DIV, DEFINE_EXPRESSION_CLOSE_BRACKET, DEFINE_EXPRESSION_END}

  START.next = {DEFINE, FULFILLED, WITH_NAME, FIND, A_CACHE, N_CACHES, OUTPUT_IF_WIN, OUTPUT_IF_FAIL, OUTPUT_ANY, TERMINAL_STATE}
  END.next = START.next
  OUTPUT_END.next = START.next
  FULFILLED_END.next = START.next


  createFields(DEFINE_EXPRESSION, func_define_field, EXPRESSION_OPERATOR)

  table.insert(DEFINE_EXPRESSION.next, 1, DEFINE_EXPRESSION_NUMBER)
  table.insert(DEFINE_EXPRESSION.next, 1, DEFINE_EXPRESSION_OPEN_BRACKET)
  DEFINE_EXPRESSION_NUMBER.next = EXPRESSION_OPERATOR
  DEFINE_EXPRESSION_OPEN_BRACKET.next = DEFINE_EXPRESSION.next
  for _, source in ipairs(EXPRESSION_OPERATOR) do
    source.next = DEFINE_EXPRESSION.next
  end
  
  createFields(DEFINE_UPPERCASE, func_define_toupper, {DEFINE_END})
  DEFINE_MATCH.next = {DEFINE_MATCH_LITERAL, DEFINE_MATCH_LITERAL_B}
  DEFINE_MATCH_LITERAL.next = {DEFINE_MATCH_ON}
  DEFINE_MATCH_LITERAL_B.next = {DEFINE_MATCH_ON}
  createFields(DEFINE_MATCH_ON, func_define_match_field, {DEFINE_END})
  
  DEFINE.next = {DEFINE_NAME, DEFINE_NAME_B}
  DEFINE_NAME.next = {DEFINE_AS}
  DEFINE_NAME_B.next = DEFINE_NAME.next
  
  DEFINE_AS.next = {DEFINE_EXPRESSION, DEFINE_MATCH, DEFINE_UPPERCASE}

  DEFINE_EXPRESSION_END.next = START.next
  DEFINE_END.next = START.next

  FULFILLED.next = {WITHIN, WITH_UNIQUE_CACHES, WITH_N_GROUPS}
  WITHIN.next = {FULFILLED_END, FULFILLED_AND}
  WITH_UNIQUE_CACHES.next = {FULFILLED_END, FULFILLED_AND}
  WITH_N_GROUPS.next = {FULFILLED_END, FULFILLED_AND}
  FULFILLED_AND.next = FULFILLED.next

  WITH_NAME.next = {WITH_NAME_NAME, WITH_NAME_NAME_B}
  WITH_NAME_NAME.next = {FIND}
  WITH_NAME_NAME_B.next = WITH_NAME_NAME.next 
  FIND.next = { A_CACHE, N_CACHES}
  A_CACHE.next = { WHERE}
  N_CACHES.next = {WITH_UNIQUE, GROUPED_BY, WHERE}
  createFields(WITH_UNIQUE, func_with_unique, {FIELD, GROUPED_BY, WHERE, END})
  FIELD.next = {WHERE, GROUPED_BY, END}
  createFields(GROUPED_BY, func_grouped_by, {WHERE, WITH_UNIQUE, END})
  
  LITERAL.next = POST_EXPRESSION_NEXT
  LITERAL_B.next = POST_EXPRESSION_NEXT
  NUMBER.next = POST_EXPRESSION_NEXT
  BOOL_TRUE.next = POST_EXPRESSION_NEXT
  BOOL_FALSE.next = POST_EXPRESSION_NEXT
  
  createFields(WHERE, func_field_lhs, COMP_NEXT)

  table.insert(WHERE.next, OPEN_BRACKET)
  AND.next = WHERE.next
  OR.next = WHERE.next
  OPEN_BRACKET.next = WHERE.next
  CLOSE_BRACKET.next = POST_EXPRESSION_NEXT

  for _, source in ipairs(COMP_NEXT) do
    createFields(source, func_field_rhs, POST_EXPRESSION_NEXT)
      table.insert(source.next, LITERAL)
      table.insert(source.next, LITERAL_B)
      table.insert(source.next, NUMBER)
      table.insert(source.next, BOOL_TRUE)
      table.insert(source.next, BOOL_FALSE)
  end
  OUTPUT_IF_WIN.next = {OUTPUT_SORTED_BY, OUTPUT_TABLE, OUTPUT_LITERAL, OUTPUT_LITERAL_B, OUTPUT_GROUPS}
  createFields(OUTPUT_SORTED_BY, func_output_sorted_by, {OUTPUT_TABLE})
  OUTPUT_IF_FAIL.next = OUTPUT_IF_WIN.next
  OUTPUT_ANY.next = OUTPUT_IF_WIN.next

  OUTPUT_LITERAL.next = {OUTPUT_END}
  OUTPUT_LITERAL_B.next = OUTPUT_LITERAL.next
  createFields(OUTPUT_TABLE, func_output_field, {OUTPUT_COMMA, OUTPUT_AS, OUTPUT_END})
  OUTPUT_COMMA.next = OUTPUT_TABLE.next
  OUTPUT_AS.next = {OUTPUT_COMMA, OUTPUT_END}
  OUTPUT_GROUPS.next = {OUTPUT_GROUPS_IF_WINNING, OUTPUT_GROUPS_INCLUDING_EMPTY, OUTPUT_END, OUTPUT_GROUPS_WITH}
  OUTPUT_GROUPS_IF_WINNING.next = {OUTPUT_END, OUTPUT_GROUPS_WITH}
  OUTPUT_GROUPS_INCLUDING_EMPTY.next = {OUTPUT_END, OUTPUT_GROUPS_WITH}
  OUTPUT_GROUPS_WITH.next = {OUTPUT_GROUPS_TOTALS, OUTPUT_GROUPS_GCCODES, OUTPUT_GROUPS_NAMES, OUTPUT_GROUPS_ALL_MATCHES, OUTPUT_GROUPS_VISITDATES, OUTPUT_GROUPS_NEEDED}
  createFields(OUTPUT_GROUPS_WITH, func_output_field, {OUTPUT_COMMA, OUTPUT_AS, OUTPUT_GROUPS_AND, OUTPUT_END})
  
  OUTPUT_GROUPS_AND.next = OUTPUT_GROUPS_WITH.next
  OUTPUT_GROUPS_TOTALS.next = {OUTPUT_END, OUTPUT_GROUPS_AND}
  OUTPUT_GROUPS_GCCODES.next = OUTPUT_GROUPS_TOTALS.next
  OUTPUT_GROUPS_NAMES.next = OUTPUT_GROUPS_TOTALS.next
  OUTPUT_GROUPS_ALL_MATCHES.next = OUTPUT_GROUPS_TOTALS.next
  OUTPUT_GROUPS_VISITDATES.next = OUTPUT_GROUPS_TOTALS.next
  OUTPUT_GROUPS_NEEDED.next = OUTPUT_GROUPS_TOTALS.next

  self.currentState = START
    return self
end
-- End of parser

local function Executor()
  local self = {  formatObj = Date.Format("yyyy-mm-dd")}
  local attribute_definitions = {}
    attribute_definitions["dogs allowed"] = 1
    attribute_definitions["access/parking fee"] = 2
    attribute_definitions["climbing gear required"] = 3
    attribute_definitions["boat required"] = 4
    attribute_definitions["scuba gear required"] = 5
    attribute_definitions["kid-friendly"] = 6
    attribute_definitions["takes less than 1 hour"] = 7
    attribute_definitions["scenic view"] = 8
    attribute_definitions["significant hike"] = 9
    attribute_definitions["difficult climbing"] = 10
    attribute_definitions["may require wading"] = 11
    attribute_definitions["may require swimming"] = 12
    attribute_definitions["available 24/7"] = 13
    attribute_definitions["recommended at night"] = 14
    attribute_definitions["available in winter"] = 15
    attribute_definitions["poison plants"] = 17
    attribute_definitions["dangerous animals"] = 18
    attribute_definitions["ticks"] = 19
    attribute_definitions["abandoned mine nearby"] = 20
    attribute_definitions["cliffs/falling rocks nearby"] = 21
    attribute_definitions["hunting area"] = 22
    attribute_definitions["dangerous area"] = 23
    attribute_definitions["wheelchair-accessible"] = 24
    attribute_definitions["parking available"] = 25
    attribute_definitions["public transit available"] = 26
    attribute_definitions["drinking water nearby"] = 27
    attribute_definitions["restrooms available"] = 28
    attribute_definitions["telephone nearby"] = 29
    attribute_definitions["picnic tables available"] = 30
    attribute_definitions["camping available"] = 31
    attribute_definitions["bikes allowed"] = 32
    attribute_definitions["motorcycles allowed"] = 33
    attribute_definitions["quads allowed"] = 34
    attribute_definitions["off-road vehicles allowed"] = 35
    attribute_definitions["snowmobiles allowed"] = 36
    attribute_definitions["horses allowed"] = 37
    attribute_definitions["campfires allowed"] = 38
    attribute_definitions["thorns"] = 39
    attribute_definitions["stealth required"] = 40
    attribute_definitions["stroller-accessible"] = 41
    attribute_definitions["needs maintenance"] = 42
    attribute_definitions["watch for livestock"] = 43
    attribute_definitions["flashlight required"] = 44
    attribute_definitions["lost and found"] = 45
    attribute_definitions["truck-driver-/rv-accessible"] = 46
    attribute_definitions["field puzzle"] = 47
    attribute_definitions["uv light required"] = 48
    attribute_definitions["may require snowshoes"] = 49
    attribute_definitions["cross-country skis required"] = 50
    attribute_definitions["special tool required"] = 51
    attribute_definitions["night cache"] = 52
    attribute_definitions["park-and-grab"] = 53
    attribute_definitions["in an abandoned structure"] = 54
    attribute_definitions["hike shorter than 1 km"] = 55
    attribute_definitions["hike between 1km-10km"] = 56
    attribute_definitions["hike longer than 10km"] = 57
    attribute_definitions["fuel nearby"] = 58
    attribute_definitions["food nearby"] = 59
    attribute_definitions["wireless beacon required"] = 60
    attribute_definitions["partnership cache"] = 61
    attribute_definitions["seasonal access only"] = 62
    attribute_definitions["recommended for tourists"] = 63
    attribute_definitions["tree-climbing required"] = 64
    attribute_definitions["in front yard (with permission)"] = 65
    attribute_definitions["teamwork required"] = 66
    attribute_definitions["part of a geotour"] = 67  
	attribute_definitions["bonus cache"] = 69
	attribute_definitions["power trail"] = 70
	attribute_definitions["challenge cache"] = 71
	attribute_definitions["geocaching.com solution checker"] = 72

  local function convertAttribute(attr)
    local result = tonumber(attr)
    if result == nil then
      result = attribute_definitions[string.lower(attr)]
    end
    if result == nil then
      Log("Error: Invalid attribute ", attr, "\n")
      result = 99999
    end
    return result
  end


  local comparisonFunctions = {
  ["=="] = function (left, right) 
	if left == nil and right == nil then
		return true
	end
	if left == nil or right == nil then
		return false
	end
    if type(left) == "number" or type(right) == "number" then 
      return tonumber(left) == tonumber(right)
    end
   return left == right end,
  [">="] = function (left, right) 
	if left == nil or right == nil then
		return false
	end
    if type(left) == "number" or type(right) == "number" then 
      return tonumber(left) >= tonumber(right)
    end
   return left >= right end,
  ["<="] = function (left, right)
	if left == nil or right == nil then
		return false
	end
    if type(left) == "number" or type(right) == "number" then 
      return tonumber(left) <= tonumber(right)
    end
   return left <= right end,
  ["<"] = function (left, right)
	if left == nil or right == nil then
		return false
	end
    if type(left) == "number" or type(right) == "number" then 
      return tonumber(left) < tonumber(right)
    end
   return left < right end,
  [">"] = function (left, right)
	if left == nil or right == nil then
		return false
	end
    if type(left) == "number" or type(right) == "number" then 
      return tonumber(left) > tonumber(right)
    end
   return left > right end,
  ["<>"] = function (left, right) 
	if left == nil and right == nil then
		return false
	end
	if left == nil or right == nil then
		return true
	end
    if type(left) == "number" or type(right) == "number" then 
      return tonumber(left) ~= tonumber(right)
    end
    return left ~= right end,
  ["matches"] = function (left, right)  return string.find(left, right) ~= nil end,
  ["has"] = function (left, right)  return left[convertAttribute(right)] == 1 end,
  ["missing"] = function (left, right)  return left[convertAttribute(right)] ~= 1 end
  }

  local function doComparison(comparison, valueLeft, valueRight)
    local result = comparisonFunctions[comparison](valueLeft, valueRight)
    return result
  end

  local filterFunctions = {}

  filterFunctions.field = function (filter, cache)
        local fieldValue = cache[filter.field]
--        Log("Checking filter.field:", filter.field, "<\n")
        if field_details_index[filter.field].isNumber == true then
          fieldValue = tonumber(fieldValue)
        end
        return doComparison(filter.comparison, fieldValue, filter.value)
    end

  filterFunctions.fieldCompare = function (filter, cache)
        local fieldValue = cache[filter.field]
        local fieldValue2 = cache[filter.field2]
        return doComparison(filter.comparison, fieldValue, fieldValue2)
    end
    
  filterFunctions["true"] = function(filter, cache)
     return true
  end

  filterFunctions["or"] = function (filter, cache)
        local result = false
        for _, childFilter in ipairs(filter.value) do
            result = filterFunctions[childFilter.test](childFilter, cache)
            if result then
                break
            end
        end
        return result
    end

   filterFunctions["and"] = function (filter, cache)
        local result = true

        for _, childFilter in ipairs(filter.value) do
            result = filterFunctions[childFilter.test](childFilter, cache)
            if not result then
                break
            end
        end
        return result
    end

    filterFunctions.bracket = function(filter, cache)
      local result = true
        for _, childFilter in ipairs(filter.value) do
            result = filterFunctions[childFilter.test](childFilter, cache)
            if not result then
                break
            end
        end
        return result
    end

  --end of dynamic functions

  local function incrementTable(table, key)
      if table[key] == nil then
          table[key] = 1
      else
          table[key] = table[key] + 1
      end
  end

  local function cachesIterator(state)
      result = nil
      finished = false
      while result == nil and not finished do
          state.currentIndex = state.currentIndex+1
          if state.currentIndex > #state.currentResults and state.currentDate > state.endDate then
              finished = true
          else
              while state.currentIndex > #state.currentResults  do
                  state.currentIndex = 1
                  formatObj = Date.Format("yyyy-mm-dd")
                  state.params.filter.minVisitDate = formatObj:tostring(state.currentDate)
                  state.currentDate:add(state.increment)
                  state.params.filter.maxVisitDate = formatObj:tostring(state.currentDate)
                  state.currentResults = state.func(state.profileId, state.params)
              end
              if #state.currentResults > 0 then
                  result = state.currentResults[state.currentIndex]
              end
          end
      end
      return result
  end

  local function runFilter(filter, cache)
      return filterFunctions[filter.test](filter, cache)
  end


  local function dateAsYear(date)
      return string.sub(date, 1, 4)
  end

  local function dateAsMonth(date)
      return string.sub(date, 6, 7)
  end

  local function dateAsDay(date)
      return string.sub(date, 9, 10)
  end

  local function evaluateExpression(statements, cache)
  Log("Evaluating expressions on cache ", cache.gccode)
    local stack = {}
  for _, statement in ipairs(statements) do

    if statement.type == "literal" then
        table.insert(stack, tonumber(statement.value))
      elseif statement.type == "field" then
        table.insert(stack, tonumber(cache[statement.value]))
      elseif statement.type == "literalStr" then
        table.insert(stack, statement.value)
      elseif statement.type == "fieldStr" then
        table.insert(stack, cache[statement.value])
      elseif statement.type == "operator" then
         local right = table.remove(stack)
         if right == nil then
			Log("Right value is null for cache ", cache.gccode)
         end
         local left = table.remove(stack)
		 if left == nil then
			Log("Left value is null for cache ", cache.gccode)
         end
         if left == nil or right == nil then
			table.insert(stack, nil)
		 elseif statement.value == "*" then
            table.insert(stack, left*right)
         elseif statement.value == "/" then
            table.insert(stack, left/right)
         elseif statement.value == "+" then
            table.insert(stack, left+right)
         elseif statement.value == "-" then
            table.insert(stack, left-right)
         elseif statement.value == "match" then
            local pattern = left
            local str = right
            local i, j, match = string.find(str, pattern)

            if match == nil and i ~= nil then
              match = string.sub(str, i, j)
            end
            if match == nil then
              match = ""
            end
          table.insert(stack, match)
         end
      elseif statement.type == "function1" then
        local left = table.remove(stack)
        if statement.value == "toupper" then
          table.insert(stack, string.upper(left))
        end
      end
    end
    return table.remove(stack)
  end

  local function insertMagicDates(cache, field)
      date = cache[field]
      if date then
          cache[field.."_date"] = self.formatObj:parse(date)
          cache[field.."_year"] = dateAsYear(date)
          cache[field.."_month"] = dateAsMonth(date)
          cache[field.."_day"] = dateAsDay(date)
          cache[field.."_year_month"] = dateAsYear(date)..dateAsMonth(date)
          cache[field.."_month_day"] = dateAsMonth(date)..dateAsDay(date)
          cache[field.."_weekday"] = cache[field.."_date"]:weekday_name(true)
      end
  end


  local function extractBitmask(result, value, offset)
    local i = offset+1
    while value > 0 do
      carry = value % 2
      value = math.floor(value / 2)
      result[i] = carry
      i = i + 1
    end
  end


  local function insertMagicAttributes(cache, field)
    cache[field] = {}
    if(cache[field.."_1"] ~= nil) then
        extractBitmask(cache[field], cache[field.."_1"], 0)
        extractBitmask(cache[field], cache[field.."_2"], 32)
        extractBitmask(cache[field], cache[field.."_3"], 64)
    end
  end
  
  local function insertMagicReviewer(options, cache)
    if options.usedFields.reviewer == true then
      cache.reviewer = options.reviewers[cache.gccode]
    end
  end
  
  local function insertMagicEvent(options, cache)
    if options.usedFields.event == true then
      if cache.type == "Event Cache" or cache.type == "Cache In Trash Out Event" or cache.type == "Mega-Event Cache" or cache.type == "Giga-Event Cache" or cache.type == "Community Celebration Event" then
        cache.event = "true"
      else
        cache.event = "false"
      end
    end
  end
  
  local function insertMagicLinks(cache)
	log_id = cache["log_id"]
	if log_id then
		cache["log_id_url"] = "[url=http://www.geocaching.com/seek/log.aspx?lid=" .. cache['log_id'] .. "]log[/url]"
	end
	cache["gccode_url"] = "[url=http://coord.info/" .. cache['gccode'] .. "]" .. cache['gccode'] .. "[/url]"
  end

  local function insertMagicFields(options, cache)
      insertMagicDates(cache, "hidden")
      insertMagicDates(cache, "last_find_date")
      insertMagicDates(cache, "last_publish_date")
      insertMagicDates(cache, "visitdate")
      insertMagicAttributes(cache, 'attributes_set')
      insertMagicAttributes(cache, 'attributes_unset')
      insertMagicLinks(cache)
      insertMagicReviewer(options, cache)
      insertMagicEvent(options, cache)
      for name, expr in ipairs(options.defines) do
        cache[expr.field] = evaluateExpression(expr.list, cache)
      end
  end

  local function convertFields(cache)
    for name, value in pairs(cache) do
      if field_details_index[name] ~= nil and field_details_index[name].isNumber == true then
        cache[name] = tonumber(value)
      end
    end
  end

  local function prepareFilter(id, filter)
      if filter.test == nil and filter.field ~= nil then
          filter.test = "field"
      end

      if filter.test == nil then
          filter.test = "true"
      end

      if (filter.test == "field" or filter.test == "fieldCompare") and filter.comparison == nil then
          filter.comparison = "=="
      end


      if filter.count == nil then
          filter.count = 1
      else
          filter.count = tonumber(filter.count)
      end

      if filter.test == "or" or filter.test == "and" then
          if filter.name == nil then
              filter.name = filter.test
          end

          for _, childFilter in ipairs(filter.value) do
              prepareFilter(id, childFilter)
          end
      end

      filter.internalName = "filter: "..id

      if filter.name == nil then
        filter.name = filter.internalName
      end
  end

  local function resetCriteria(step)
      for _,filter in ipairs(step) do
          filter.matches = {}
          filter.matchesCount = 0
      end
  end
  
  local function prepareCriteria(setup)
    for id,filter in ipairs(setup.criteria) do
      prepareFilter(id, filter)
    end
    
    if setup.groupsRequired == nil then
      setup.groupsRequired = #setup.criteria
    end
--    Log("Final setup", setup)
  end
  
  local function contains(table, element)
    for _, value in ipairs(table) do
      if value == element then
       return true
      end
    end
    return false
  end

  local function getFirstFind (profileId, param)
      local lastFinds = PGC.GetFinds( profileId, {fields = param.fields, order = 'OLDESTFIRST', limit = 1})
      --Log("First find ", lastFinds[1])
      return lastFinds[1]
  end

  local function getLastFind (profileId)
      local lastFinds =  PGC.GetFinds( profileId, { fields = { 'gccode', 'visitdate', 'cache_name'},
                  order = 'NEWESTFIRST',
                  limit = 1} )
      return lastFinds[1]
  end

  local function produceGroupOutput(outputTable, group, definition)
    if (definition.empty == true or group.matchesCount  > 0) and (definition.winning == false or group.winner == true) then
      table.insert(outputTable, group.name)
      table.insert(outputTable, ": ")
      if definition.totals == true then
        table.insert(outputTable, group.matchesCount )
        table.insert(outputTable, " ")
      end

      if definition.needed == true then
        table.insert(outputTable, "needed ")
        table.insert(outputTable, group.count)
        table.insert(outputTable, " ")
      end

      if definition.gccodes == true or definition.names == true or #definition.fields > 0 then
        local count = 0
        for _, cache in pairs(group.matches) do
          if definition.gccodes == true and definition.names == true then
            table.insert(outputTable, cache.gccode)
            table.insert(outputTable, ": ")
            table.insert(outputTable, cache.cache_name)
            table.insert(outputTable, ", ")
          elseif definition.gccodes == true then
            table.insert(outputTable, cache.gccode)
            table.insert(outputTable, ", ")
          else
            table.insert(outputTable, cache.cache_name)
            table.insert(outputTable, ", ")
          end
          if definition.visitdates == true then
            table.insert(outputTable, cache.visitdate)
            table.insert(outputTable, ", ")
          end
          for _, field in ipairs(definition.fields) do
            if cache[field.field] ~= nil then
              table.insert(outputTable, cache[field.field])
              table.insert(outputTable, ", ")
            end
          end

          count = count + 1
          if definition.all == false and count >= group.count then
            break
          end
        end
      end
      table.insert(outputTable, "\n")
    end
  end


  local function produceGroupsOutput(setup, definition)
    local outputTable = {}
    
    local outputted = {}
   
    for _, criteria in ipairs(setup.criteria) do
      if criteria.group == nil then
        local group = setup.groups[criteria.internalName]
        if group == nil then
          group = {internalName = criteria.internalName, name = criteria.name, matches = {}, matchesCount = 0}
        else
          outputted[group.internalName] = true
        end
        produceGroupOutput(outputTable, group, definition)
      end
    end
    
    local sortTable = {}
    for name, group in pairs(setup.groups) do
      if outputted[group.internalName] ~= true then
        table.insert(sortTable, group)
      end
    end

    table.sort(sortTable, function(left, right) return left.name < right.name end)
    
    for name, group in ipairs(sortTable) do
      produceGroupOutput(outputTable, group, definition)
    end
    return table.concat(outputTable, "")
  end


  local function produceTableOutput(setup, fields, sortBy)
    local outputTable = {}
    local maxLength = {}
    for _, field in ipairs(fields) do
      maxLength[field.field] = string.len(field.name)
    end

    local sortTable = {}
    for _, group in pairs(setup.groups) do
      for _,cache in pairs(group.matches) do
        table.insert(sortTable, cache)
        for _, field in ipairs(fields) do
          if cache[field.field] ~= nil then
            local len = string.len(cache[field.field])
            if maxLength[field.field] < len then
              maxLength[field.field] = len
            end
          end
        end
      end
    end
    if sortBy == nil then
      sortBy = "visitdate"
    end

    table.sort(sortTable, function(left, right) return safe(left[sortBy]) < safe(right[sortBy]) end)

    for _, field in ipairs(fields) do
      table.insert(outputTable, fixed_length(field.name, maxLength[field.field]))
      Log("maxLength of " , field.field, " is ", maxLength[field.field], "\n")
    end
    table.insert(outputTable, "\n")
    for i, cache in pairs(sortTable) do
      for _, field in ipairs(fields) do
        table.insert(outputTable,  fixed_length(cache[field.field], maxLength[field.field]))
      end
    table.insert(outputTable, "\n")
    end
    return table.concat(outputTable, "")
  end


  local function produceOutput(setup, definition, win, criteria)
    if definition.type == "literal" then
        return definition.text
    elseif definition.type == "table" then
      local producedOutput = produceTableOutput(setup, definition.fields, definition.sortBy)
      return producedOutput
    elseif definition.type == "groups" then
      local producedOutput = produceGroupsOutput(setup, definition)
      return producedOutput
    end
    return table.concat(outputTable, "")
  end

  local function generateFinalResults(setup)
    local win = setup.isWin == true
    local outputStrings = {}
      for _,definition in ipairs(setup.output) do
        if (win == true and definition.ifWin == true) or ( win == false and definition.ifFail == true) then
          producedOutput = produceOutput(setup, definition, win, criteria)
--          Log("Produced output: ", producedOutput)
          table.insert(outputStrings, producedOutput)
        end
      end

      log = table.concat(outputStrings, "")
      if not win then
          html = "<pre>"..log.."</pre><p />"
      end

      return { ok = win, log = log, html = html }
  end

  local function ICaches(func, profileId, params)
      first = getFirstFind(profileId, params)
      last = getLastFind(profileId)

      currentDate = self.formatObj:parse(first.visitdate)
      startDate = self.formatObj:parse(first.visitdate)
      endDate = self.formatObj:parse(last.visitdate)

      Log(first.gccode, " on ", first.visitdate)
      if params == nil then
          params = {}
      end

      if params.filter == nil then
          params.filter = {}
      end

      currentDate:add({day=-1})

      state = {
          func = func,
          profileId = profileId,
          params = params,
          startDate = startDate,
          endDate = endDate,
          currentDate = currentDate,
          currentResults = {},
          currentIndex = 0,
          increment = {day = 90}
      }
      return cachesIterator, state
  end

  local function removeOldCaches(setup, minDate)
    for groupKey, group in pairs(setup.groups) do
      for key, cache in pairs(group.matches) do
        if cache.visitdate_date < newLowDate then
          group.matches[key] = nil
          group.matchesCount = group.matchesCount-1
          if group.matchesCount == 0 then
            setup.groups[groupKey] = nil
            setup.groupsCreated = setup.groupsCreated - 1
          end
        end
      end
    end
  end
  
  function insertCache(setup, filter, cache)
    local uniqueValue = 0
    local groupBy = filter.internalName
    local groupName = filter.name
    local parentGroup = groupName
    if filter.group then
      groupBy = cache[filter.group]
      if groupBy == nil or groupBy == '' then
        --when doing group by ignore caches which have a nil/empty value
        return
      end
      parentGroup = groupName
      groupName = groupName .. " " .. groupBy
    end
      
    if filter.unique then
      uniqueValue = cache[filter.unique]
    else
      uniqueValue = cache.gccode
    end
--    Log("Inserting cache ", cache.gccode, " into ", groupBy, " with unique value ", uniqueValue)
    if groupBy ~= nil then
      local group = setup.groups[groupBy]
      if group == nil then
        setup.groups[groupBy] = { matches = {}, matchesCount = 0, count = filter.count, name = groupName, parentGroup = parentGroup, internalName = groupBy, definitionOrder = filter.definitionOrder}
        setup.groupsCreated = setup.groupsCreated + 1
        group = setup.groups[groupBy]
      end
      
      if group.matchesCount < maxInGroup then
        if uniqueValue ~= nil and group.matches[uniqueValue] == nil then
          group.matches[uniqueValue] = cache
          group.matchesCount = group.matchesCount+1
        end
      end
    end
  end

  local function updateSolutionList(listSolutions)
    local newList = {}
    for _, group in ipairs(listSolutions) do
      if group.slack >= 0 then
        table.insert(newList, group)
      end
    end
    table.sort(newList, function(left, right) return left.slack < right.slack end)
    
    return newList
  end

  local function listToMatches(input)
    if input == nil then
      return nil
    end
    local output = {}
    for _, cache in ipairs(input) do
      output[cache.gccode] = cache
    end
    return output
  end
  
  local function updateAvailableList(solution, usedCaches) 
    solution.available = {}
    for _, cache in pairs(solution.group.matches) do
      if usedCaches[cache.gccode] == nil then
        table.insert(solution.available, cache)
      end
    end
    solution.slack = #solution.available-solution.group.count
  end
  
  local function makeUniqueSolution(setup)
    
    local solutions = {}

    for groupKey, group in pairs(setup.groups) do
      solutions[groupKey] = cloneTable(group)
      solutions[groupKey].group = group
      solutions[groupKey].available = {}
      for _, cache in pairs(group.matches) do
        table.insert(solutions[groupKey].available, cache)
      end
      solutions[groupKey].matches = group.matches
      solutions[groupKey].slack = #solutions[groupKey].available-solutions[groupKey].group.count
    end
    
    
    local listSolutions = {}
    for _, group in pairs(solutions) do
      table.insert(listSolutions, group)
    end

    listSolutions = updateSolutionList(listSolutions)
    
--    Log("Attempting to find unique solution with the following:")
    for _, group in ipairs(listSolutions) do
      Log(group.name, " required ", group.count, " available ", #group.available, " caches ", cachesToString(group.available))
    end
    
    local usedCaches = {}
    usedCaches[0] = {}
    
    local maxLoops = 100000
    for currentSolution in ISubsetIterator(listSolutions, setup.groupsRequired, #listSolutions) do    
      --for a given set of groups
      local i = 1
      --set the first permutation iterator
      
      _, currentSolution[i].permutationState = ISubsetIterator(currentSolution[i].available, currentSolution[i].group.count)
      --now try each level trying to get permutations until we have one.
      local outOfSolutions = false
      repeat
        currentSolution[i].matches = listToMatches(subsetIteratorNext(currentSolution[i].permutationState))
        if currentSolution[i].matches == nil then
          -- go back a level
          i = i - 1
          if i == 0 then
            outOfSolutions = true
          end
        else
          usedCaches[i] = cloneTable(usedCaches[i-1])
          for _, cache in pairs( currentSolution[i].matches) do
            usedCaches[i][cache.gccode] = cache
          end
          local optionsOut = false
          
          for j = i+1, setup.groupsRequired do
            updateAvailableList(currentSolution[j], usedCaches[i])
            if currentSolution[j].slack < 0 then
              optionsOut = true
            end
          end
        
          if optionsOut == false then
            i = i+1
            if i > #currentSolution then
              setup.groups = {}
              
              for _, group in ipairs(currentSolution) do
                setup.groups[group.internalName] = group
              end
              setup.isWin = true
              return currentSolution
            else
              _, currentSolution[i].permutationState = ISubsetIterator(currentSolution[i].available, currentSolution[i].group.count)
            end
          end
          maxLoops = maxLoops - 1
          if maxLoops == 0 then
            Log("MaxLoops limit met\n")
            setup.isWin = false
            return nil
          end
        end
      until outOfSolutions == true 
    end
    setup.isWin = false
  end
  

  local function computeWin(setup)
    Log("Groups created ", setup.groupsCreated, " required ", setup.groupsRequired, "\n")
    if setup.groupsCreated < setup.groupsRequired then
      return nil
    end
    
    local winningGroups = 0
    
    for groupKey, solution in pairs(setup.groups) do
        Log("Results for group ", solution.name, " were ", cachesToString(solution.matches))
        if solution.matchesCount >= solution.count then
			solution.winner = true
          Log(solution.name, " is a winner")
            winningGroups = winningGroups + 1
        else
           solution.winner = false
        end
    end
    Log("Number of potentially winning groups ", winningGroups, " required ", setup.groupsRequired)
    
    Log("Number of winning groups ", winningGroups, " Required ", setup.groupsRequired, "\n")
    if winningGroups >= setup.groupsRequired then
      if setup.groupsUniqueCaches == true then
        makeUniqueSolution(setup)
      else 
        setup.isWin = true 
      end
    end
    return setup.isWin
  end
  
  
  local function fetchReviewers(profileId, setup)
    pubs = PGC.GetPublishers(profileId)
    setup.reviewers = {}
    for _, cache in ipairs(pubs) do
        if cache.publish_date <= cache.visitdate then
          setup.reviewers[cache.gccode] = cache.publisher_name
        end
    end  
  
  end
  ---

  function self.run (profileId, setup)
    if getFirstFind(profileId, { order = 'OLDESTFIRST', fields=setup.fields}) == nil then
      return {win=false, html="You need find some caches before you can complete any challenges!"}
    end
    
    prepareCriteria(setup)
    
    --Log("MyCriteria: ", setup)
    
    local toDo = 500000
    local log = ""
    local win = false
    local done = 1
    local lastvisit = ""
    local solution = nil
    if setup.usedFields["reviewer"] == true then
       fetchReviewers(profileId, setup)
    end
    
    --Log("Fetching fields ", setup.fields, "\n")
    for cache in ICaches( PGC.GetFinds, profileId,{ order = 'OLDESTFIRST', fields=setup.fields}) do
      convertFields(cache)
      insertMagicFields(setup, cache)
       if setup.window ~= nil and lastvisit ~= cache.visitdate then
          
          computeWin(setup) 
          if setup.isWin == true then
            break
          end

          lastvisit = cache.visitdate
          newLowDate = self.formatObj:parse(cache.visitdate)
          newLowDate:add({day = 1-setup.window})
          removeOldCaches(setup, newLowDate)
       end

      for _,filter in ipairs(setup.criteria) do
          if runFilter(filter, cache) then
            insertCache(setup, filter, cache)
          end
      end
    end
    Log("Finished cache loop")
    if setup.isWin ~= true then
      solution = computeWin(setup)
    end
    
    Log("Finished results: ", boolean(setup.isWin))
    return generateFinalResults(setup)
  end

  return self
end
--executor

parser = Parser()
if conf.challenge == nil then
  return { ok = false, log = "", html = "<pre>Missing script config</pre>" }
end
parser.parse(conf.challenge, conf.macros)
--Log("Results of parsing: ", parser.output)
if parser.error ~= nil then
  return { ok = false, log = "", html = "<pre>".. parser.error.."</pre>" }
end

executor = Executor()
return executor.run(profileId, parser.output)
