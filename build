--  Hideously Smashed Together by Compilr, a Hideous Smash-Stuff-Togetherer, (c) 2014 oeed  --

--  This file REALLLLLLLY isn't suitable to be used for anything other than being executed --

--  To extract all the files, run: "<filename> --extract" in the Shell --
local files = {["Wireless"]="--This is just the OneOS Wireless API\
\
--OneOS uses channels between 4200 and 4300, avoid use where possible\
\
Channels = {\
	Ignored = 4299,\
	Ping = 4200,\
	PingReply = 4201,\
	QuestServerRequest = 4250,\
	QuestServerRequestReply = 4251,\
	QuestServerNameAvailable = 4252,\
	QuestServerNameAvailableReply = 4253,\
}\
\
local function isOpen(channel)\
	return Peripheral.CallType('wireless_modem', 'isOpen', channel)\
end\
\
local function open(channel)\
	if not isOpen(channel) then\
		Peripheral.CallType('wireless_modem', 'open', channel)\
	end\
end\
\
Open = open\
\
local function close(channel)\
	Peripheral.CallType('wireless_modem', 'close', channel)\
end\
\
local function closeAll()\
	Peripheral.CallType('wireless_modem', 'closeAll')\
end\
\
local function transmit(channel, replyChannel, message)\
	Peripheral.CallType('wireless_modem', 'transmit', channel, replyChannel, textutils.serialize(message))\
end\
\
function Present()\
	if Peripheral.GetPeripheral('wireless_modem') == nil then\
		return false\
	else\
		return true\
	end\
end\
\
local function FormatMessage(message, messageID, destinationID)\
	return {\
		content = textutils.serialize(message),\
		senderID = os.getComputerID(),\
		senderName = os.getComputerLabel(),\
		channel = channel,\
		replyChannel = reply,\
		messageID = messageID or math.random(10000),\
		destinationID = destinationID\
	}\
end\
\
local Timeout = function(func, time)\
	time = time or 1\
	parallel.waitForAny(func, function()\
		sleep(time)\
		--log('Timeout!'..time)\
	end)\
end\
\
RecieveMessage = function(_channel, messageID, timeout)\
	open(_channel)\
	local done = false\
	local event, side, channel, replyChannel, message = nil\
	Timeout(function()\
		while not done do\
			event, side, channel, replyChannel, message = os.pullEvent('modem_message')\
			if channel ~= _channel then\
				event, side, channel, replyChannel, message = nil\
			else\
				message = textutils.unserialize(message)\
				message.content = textutils.unserialize(message.content)\
				if messageID and messageID ~= message.messageID or (message.destinationID ~= nil and message.destinationID ~= os.getComputerID()) then\
					event, side, channel, replyChannel, message = nil\
				else\
					done = true\
				end\
			end\
		end\
	end,\
	timeout)\
	return event, side, channel, replyChannel, message\
end\
\
Initialise = function()\
	if Present() then\
		for i, c in pairs(Channels) do\
			open(c)\
		end\
	end\
end\
\
HandleMessage = function(event, side, channel, replyChannel, message, distance)\
	message = textutils.unserialize(message)\
	message.content = textutils.unserialize(message.content)\
\
	if channel == Channels.Ping then\
		if message.content == 'Ping!' then\
			SendMessage(replyChannel, 'Pong!', nil, message.messageID)\
		end\
	elseif message.destinationID ~= nil and message.destinationID ~= os.getComputerID() then\
	elseif Wireless.Responder then\
		Wireless.Responder(event, side, channel, replyChannel, message, distance)\
	end\
end\
\
SendMessage = function(channel, message, reply, messageID, destinationID)\
	reply = reply or channel + 1\
	open(channel)\
	open(reply)\
	local _message = FormatMessage(message, messageID, destinationID)\
	transmit(channel, reply, _message)\
	return _message\
end\
\
Ping = function()\
	local message = SendMessage(Channels.Ping, 'Ping!', Channels.PingReply)\
	RecieveMessage(Channels.PingReply, message.messageID)\
end",["parser"]="--[[\
    This API was not created by myself, it was copied from https://github.com/voidfiles/webscript-lua-modules/tree/master/html\
\
    It has been modified slightly to be more suitable for CCML (removed unused tags, cleaned up returned table a little, etc)\
\
    Original License:\
\
    Copyright (c) 2007 T. Kobayashi\
\
    Permission is hereby granted, free of charge, to any person obtaining a \
    copy of this software and associated documentation files (the \
    \"Software\"), to deal in the Software without restriction, including \
    without limitation the rights to use, copy, modify, merge, publish, \
    distribute, sublicense, and/or sell copies of the Software, and to \
    permit persons to whom the Software is furnished to do so, subject to \
    the following conditions: \
\
    The above copyright notice and this permission notice shall be included \
    in all copies or substantial portions of the Software. \
\
    THE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS \
    OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF \
    MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. \
    IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY \
    CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, \
    TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE \
    SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE. \
\
]]\
\
entity = {\
  nbsp = \" \",\
  lt = \"<\",\
  gt = \">\",\
  quot = \"\\\"\",\
  amp = \"&\",\
}\
\
-- keep unknown entity as is\
setmetatable(entity, {\
  __index = function (t, key)\
    return \"&\" .. key .. \";\"\
  end\
})\
\
block = {\
  \"address\",\
  \"blockquote\",\
  \"center\",\
  \"dir\", \"div\", \"dl\",\
  \"fieldset\", \"form\",\
  \"h\", \"h1\", \"h2\", \"h3\", \"h4\", \"h5\", \"h6\", \"hr\", \
  \"isindex\",\
  \"menu\",\
  \"noframes\",\
  \"ol\",\
  \"p\",\
  \"pre\",\
  \"table\",\
  \"ul\",\
}\
\
inline = {\
  \"a\", \"abbr\", \"acronym\", \"applet\",\
  \"b\", \"basefont\", \"bdo\", \"big\", \"br\", \"button\",\
  \"cite\", \"code\",\
  \"dfn\",\
  \"em\",\
  \"font\",\
  \"i\", \"iframe\", \"img\", \"input\",\
  \"kbd\",\
  \"label\",\
  \"map\",\
  \"object\",\
  \"q\",\
  \"s\", \"samp\", \"select\", \"small\", \"span\", \"strike\", \"strong\", \"sub\", \"sup\",\
  \"textarea\", \"tt\",\
  \"u\",\
  \"var\",\
}\
\
tags = {\
  a = { empty = false },\
  abbr = {empty = false} ,\
  acronym = {empty = false} ,\
  address = {empty = false} ,\
  applet = {empty = false} ,\
  area = {empty = true} ,\
  b = {empty = false} ,\
  base = {empty = true} ,\
  basefont = {empty = true} ,\
  bdo = {empty = false} ,\
  big = {empty = false} ,\
  blockquote = {empty = false} ,\
  body = { empty = false, },\
  br = {empty = true} ,\
  button = {empty = false} ,\
  caption = {empty = false} ,\
  center = {empty = false} ,\
  cite = {empty = false} ,\
  code = {empty = false} ,\
  col = {empty = true} ,\
  colgroup = {\
    empty = false,\
    optional_end = true,\
    child = {\"col\",},\
  },\
  dd = {empty = false} ,\
  del = {empty = false} ,\
  dfn = {empty = false} ,\
  dir = {empty = false} ,\
  div = {empty = false} ,\
  dl = {empty = false} ,\
  dt = {\
    empty = false,\
    optional_end = true,\
    child = {\
      inline,\
      \"del\",\
      \"ins\",\
      \"noscript\",\
      \"script\",\
    },\
  },\
  em = {empty = false} ,\
  fieldset = {empty = false} ,\
  font = {empty = false} ,\
  form = {empty = false} ,\
  frame = {empty = true} ,\
  frameset = {empty = false} ,\
  h1 = {empty = false} ,\
  h2 = {empty = false} ,\
  h3 = {empty = false} ,\
  h4 = {empty = false} ,\
  h5 = {empty = false} ,\
  h6 = {empty = false} ,\
  head = {empty = false} ,\
  hr = {empty = true} ,\
  html = {empty = false} ,\
  i = {empty = false} ,\
  iframe = {empty = false} ,\
  img = {empty = true} ,\
  input = {empty = true} ,\
  ins = {empty = false} ,\
  isindex = {empty = true} ,\
  kbd = {empty = false} ,\
  label = {empty = false} ,\
  legend = {empty = false} ,\
  li = {\
    empty = false,\
    optional_end = true,\
    child = {\
      inline,\
      block,\
      \"del\",\
      \"ins\",\
      \"noscript\",\
      \"script\",\
    },\
  },\
  link = {empty = true} ,\
  map = {empty = false} ,\
  menu = {empty = false} ,\
  meta = {empty = true} ,\
  noframes = {empty = false} ,\
  noscript = {empty = false} ,\
  object = {empty = false} ,\
  ol = {empty = false} ,\
  optgroup = {empty = false} ,\
  option = {\
    empty = false,\
    optional_end = true,\
    child = {},\
  },\
  p = {\
    empty = false,\
    optional_end = true,\
    child = {\
      inline,\
      \"del\",\
      \"ins\",\
      \"noscript\",\
      \"script\",\
    },\
  } ,\
  param = {empty = true} ,\
  pre = {empty = false} ,\
  q = {empty = false} ,\
  s =  {empty = false} ,\
  samp = {empty = false} ,\
  script = {empty = false} ,\
  select = {empty = false} ,\
  small = {empty = false} ,\
  span = {empty = false} ,\
  strike = {empty = false} ,\
  strong = {empty = false} ,\
  style = {empty = false} ,\
  sub = {empty = false} ,\
  sup = {empty = false} ,\
  table = {empty = false} ,\
  tbody = {empty = false} ,\
  td = {\
    empty = false,\
    optional_end = true,\
    child = {\
      inline,\
      block,\
      \"del\",\
      \"ins\",\
      \"noscript\",\
      \"script\",\
    },\
  },\
  textarea = {empty = false} ,\
  tfoot = {\
    empty = false,\
    optional_end = true,\
    child = {\"tr\",},\
  },\
  th = {\
    empty = false,\
    optional_end = true,\
    child = {\
      inline,\
      block,\
      \"del\",\
      \"ins\",\
      \"noscript\",\
      \"script\",\
    },\
  },\
  thead = {\
    empty = false,\
    optional_end = true,\
    child = {\"tr\",},\
  },\
  title = {empty = false} ,\
  tr = {\
    empty = false,\
    optional_end = true,\
    child = {\
      \"td\", \"th\",\
    },\
  },\
  tt = {empty = false} ,\
  u = {empty = false} ,\
  ul = {empty = false} ,\
  var = {empty = false} ,\
}\
\
setmetatable(tags, {\
  __index = function (t, key)\
    return {empty = false}\
  end\
})\
\
-- string buffer implementation\
function newbuf ()\
  local buf = {\
    _buf = {},\
    clear =   function (self) self._buf = {}; return self end,\
    content = function (self) return table.concat(self._buf) end,\
    append =  function (self, s)\
      self._buf[#(self._buf) + 1] = s\
      return self\
    end,\
    set =     function (self, s) self._buf = {s}; return self end,\
  }\
  return buf\
end\
\
-- unescape character entities\
function unescape (s)\
  function entity2string (e)\
    return entity[e]\
  end\
  return s.gsub(s, \"&(#?%w+);\", entity2string)\
end\
\
-- iterator factory\
function makeiter (f)\
  local co = coroutine.create(f)\
  return function ()\
    local code, res = coroutine.resume(co)\
    return res\
  end\
end\
\
-- constructors for token\
function Tag (s) \
  return string.find(s, \"^</\") and\
    {type = \"End\",   value = s} or\
    {type = \"Start\", value = s}\
end\
\
function Text (s)\
  local unescaped = unescape(s) \
  return {type = \"Text\", value = unescaped} \
end\
\
-- lexer: text mode\
function text (f, buf)\
  local c = f:read(1)\
  if c == \"<\" then\
    if buf:content() ~= \"\" then coroutine.yield(Text(buf:content())) end\
    buf:set(c)\
    return tag(f, buf)\
  elseif c then\
    buf:append(c)\
    return text(f, buf)\
  else\
    if buf:content() ~= \"\" then coroutine.yield(Text(buf:content())) end\
  end\
end\
\
-- lexer: tag mode\
function tag (f, buf)\
  local c = f:read(1)\
  if c == \">\" then\
    coroutine.yield(Tag(buf:append(c):content()))\
    buf:clear()\
    return text(f, buf)\
  elseif c then\
    buf:append(c)\
    return tag(f, buf)\
  else\
    if buf:content() ~= \"\" then coroutine.yield(Tag(buf:content())) end\
  end\
end\
\
function parse_starttag(tag)\
  local tagname = string.match(tag, \"<%s*(%w+)\")\
  local elem = {_attr = {}}\
  elem._tag = tagname\
  for key, _, val in string.gmatch(tag, \"(%w+)%s*=%s*([\\\"'])(.-)%2\", i) do\
    local unescaped = unescape(val)\
    elem._attr[key] = unescaped\
  end\
  return elem\
end\
\
function parse_endtag(tag)\
  local tagname = string.match(tag, \"<%s*/%s*(%w+)\")\
  return tagname\
end\
\
-- find last element that satisfies given predicate\
function rfind(t, pred)\
  local length = #t\
  for i=length,1,-1 do\
    if pred(t[i]) then\
      return i, t[i]\
    end\
  end\
end\
\
function flatten(t, acc)\
  acc = acc or {}\
  for i,v in ipairs(t) do\
    if type(v) == \"table\" then\
      flatten(v, acc)\
    else\
      acc[#acc + 1] = v\
    end\
  end\
  return acc\
end\
\
function optional_end_p(elem)\
  if tags[elem._tag].optional_end then\
    return true\
  else\
    return false\
  end\
end\
\
function valid_child_p(child, parent)\
  local schema = tags[parent._tag].child\
  if not schema then return true end\
\
  for i,v in ipairs(flatten(schema)) do\
    if v == child._tag then\
      return true\
    end\
  end\
\
  return false\
end\
\
-- tree builder\
function parse(f)\
  local root = {_tag = \"#document\", _attr = {}}\
  local stack = {root}\
  for i in makeiter(function () return text(f, newbuf()) end) do\
    if i.type == \"Start\" then\
      local new = parse_starttag(i.value)\
      local top = stack[#stack]\
\
      while\
        top._tag ~= \"#document\" and \
        optional_end_p(top) and\
        not valid_child_p(new, top)\
      do\
        stack[#stack] = nil \
        top = stack[#stack]\
      end\
\
      top[#top+1] = new -- appendchild\
      if not tags[new._tag].empty then \
        stack[#stack+1] = new -- push\
      end\
    elseif i.type == \"End\" then\
      local tag = parse_endtag(i.value)\
      local openingpos = rfind(stack, function(v) \
          if v._tag == tag then\
            return true\
          else\
            return false\
          end\
        end)\
      if openingpos then\
        local length = #stack\
        for j=length,openingpos,-1 do\
          table.remove(stack, j)\
        end\
      end\
    else -- Text\
        if #string.gsub(string.gsub(i.value, \"%s+\", \"\"), '\\n', '') ~= 0 then\
            local top = stack[#stack]\
            top[#top+1] = i.value\
        end\
    end\
  end\
  return root\
end\
\
function parsestr(s)\
  local handle = {\
    _content = s,\
    _pos = 1,\
    read = function (self, length)\
      if self._pos > string.len(self._content) then return end\
      local ret = string.sub(self._content, self._pos, self._pos + length - 1)\
      self._pos = self._pos + length\
      return ret\
    end\
  }\
  return parse(handle)\
end",["Elements"]={["SecureTextInput.lua"]="Inherit = 'TextInput'\
\
UpdateValue = function(self)\
	self.Value = hash.sha256(self.Object.Text)\
end\
\
OnCreateObject = function(self, parentObject, y)\
	return {\
		Element = self,\
		Y = y,\
		X = 1,\
		Width = self.Width,\
		Type = \"SecureTextBox\",\
		Text = self.Value,\
		TextColour = self.TextColour,\
		BackgroundColour = self.BackgroundColour,\
		SelectedBackgroundColour = self.SelectedBackgroundColour,\
		SelectedTextColour = self.SelectedTextColour,\
		PlaceholderTextColour = self.PlaceholderTextColour,\
		Placeholder = self.Placeholder,\
		InputName = self.InputName,\
		OnChange = function(_self, event, keychar)\
			if keychar == keys.tab or keychar == keys.enter then\
				local form = self\
				local step = 0\
				while form.Tag ~= 'form' and step < 50 do\
					form = form.Parent\
				end\
				if keychar == keys.tab then\
					if form and form.Object and form.Object.OnTab then\
						form.Object:OnTab()\
					end\
				else\
					if form and form.Submit then\
						form:Submit(true)\
					end\
				end\
			end\
		end\
	}\
end",["Image.lua"]="URL = nil\
Format = nil\
\
OnInitialise = function(self, node)\
	local attr = self.Attributes\
	if attr.src then\
		self.URL = attr.src\
	end\
\
	if attr.type then\
		self.Format = attr.type\
	end\
\
	if attr.height then\
		self.Height = attr.height\
	end\
\
	if attr.width then\
		self.Width = attr.width\
	end\
end\
\
OnCreateObject = function(self, parentObject, y)\
	return {\
		Element = self,\
		Y = y,\
		X = 1,\
		Width = self.Width,\
		Height = self.Height,\
		URL = self.URL,\
		Format = self.Format,\
		Type = \"WebImageView\"\
	}\
end",["Script.lua"]="Text = nil\
URL = nil\
\
OnInitialise = function(self, node)\
	local attr = self.Attributes\
	self.Text = table.concat(node, '\\n')\
\
	if attr.src then\
		self.URL = attr.src\
		self.Text = nil\
	end\
end\
\
InsertScript = function(self, webView)\
	if self.Text then\
		webView:LoadScript(self.Text)\
	elseif self.URL then\
		fetchHTTPAsync(resolveFullUrl(self.URL), function(ok, event, response)\
			if ok then\
				self.Text = response.readAll()\
				webView:LoadScript(self.Text)\
			end\
		end)\
\
	end\
	return nil\
end",["Select.lua"]="Width = 20\
InputName = ''\
\
OnInitialise = function(self, node)\
	if attr.value then\
		new.Text = attr.value\
	end\
\
	if attr.name then\
		new.InputName = attr.name\
	end\
end\
\
UpdateValue = function(self)\
	self.Value = self.Object.MenuItems[self.Object.Selected].Value\
end\
\
OnCreateObject = function(self, parentObject, y)\
	return {\
		Element = self,\
		Y = y,\
		X = 1,\
		Width = self.Width,\
		Type = \"SelectView\",\
		TextColour = self.TextColour,\
		BackgroundColour = self.BackgroundColour,\
		InputName = self.InputName,\
	}\
end",["Paragraph.lua"]="Align = \"Left\"\
\
OnInitialise = function(self, node)\
	local attr = self.Attributes\
	self.Text = self.Text or ''\
	if attr.align then\
		if attr.align:lower() == 'left' or attr.align:lower() == 'center' or attr.align:lower() == 'right' then\
			self.Align = attr.align:lower():gsub(\"^%l\", string.upper)\
		end\
	end\
end\
\
OnCreateObject = function(self, parentObject, y)\
	return {\
		Element = self,\
		Y = y,\
		X = 1,\
		Width = self.Width,\
		Height = self.Height,\
		Align = self.Align,\
		Type = \"Label\",\
		Text = self.Text,\
		TextColour = self.TextColour,\
		BackgroundColour = self.BackgroundColour,\
		OnUpdate = function(_self, value)\
		    if value == 'Text' then\
		        if not self.Attributes.height then\
            		_self.Height = #_self.Bedrock.Helpers.WrapText(_self.Text, _self.Width)\
					_self.Bedrock:GetObject('WebView'):RepositionLayout()\
		        end\
		    end\
		end\
	}\
end",["HiddenInput.lua"]="InputName = ''\
\
OnInitialise = function(self, node)\
	local attr = self.Attributes\
	if attr.value then\
		self.Value = attr.value\
	end\
\
	if attr.name then\
		self.InputName = attr.name\
	end\
end",["ButtonInput.lua"]="BackgroundColour = colours.lightGrey\
TextColour = colours.black\
Text = 'Submit'\
InputName = ''\
\
OnInitialise = function(self, node)\
	local attr = self.Attributes\
	if attr.value then\
		self.Text = attr.value\
	end\
\
	if attr.name then\
		self.InputName = attr.name\
	end\
\
	if not attr.width then\
		self.Width = #self.Text + 2\
	end\
end\
\
UpdateValue = function(self, force)\
	if force then\
		self.Value = self.Object.Text\
	end\
end\
\
CreateObject = function(self, parentObject, y)\
	return parentObject:AddObject({\
		Element = self,\
		Y = y,\
		X = 1,\
		Width = self.Width,\
		Type = \"Button\",\
		Text = self.Text,\
		TextColour = self.TextColour,\
		BackgroundColour = self.BackgroundColour,\
		InputName = self.InputName,\
		OnClick = function(_self, event, side, x, y)\
			local form = self\
			local step = 0\
			while form.Tag ~= 'form' and step < 50 do\
				form = form.Parent\
			end\
			self.Value = _self.Text\
			if form and form.Submit then\
				form:Submit()\
			end\
		end\
	})\
end",["Float.lua"]="Align = \"Left\"\
\
OnInitialise = function(self, node)\
	local attr = self.Attributes\
	if attr.align then\
		if attr.align:lower() == 'left' or attr.align:lower() == 'right' then\
			self.Align = attr.align:lower():gsub(\"^%l\", string.upper)\
		end\
	end\
end\
\
OnCreateObject = function(self, parentObject, y)\
	return {\
		Element = self,\
		Y = y,\
		X = 1,\
		Width = self.Width,\
		Height = self.Height,\
		Align = self.Align,\
		BackgroundColour = self.BackgroundColour,\
		Type = \"FloatView\"\
	}\
end",["Element.lua"]="HasChildren = true\
Children = nil\
Tag = nil\
TextColour = colours.black\
BackgroundColour = colours.transparent\
Text = nil\
Attributes = nil\
Width = \"100%\"\
\
Initialise = function(self, node)\
	local new = {}    -- the new instance\
	setmetatable( new, {__index = self} )\
	local attr = node._attr\
	new.Tag = node._tag\
	new.Attributes = attr\
	if new.HasChildren then\
		new.Children = {}\
	end\
\
	if type(node[1]) == 'string' then\
		new.Text = node[1]\
	end\
	\
	if attr.colour then\
		new.TextColour = self:ParseColour(attr.colour)\
	elseif attr.color then\
		new.TextColour = self:ParseColour(attr.color)\
	end\
\
	if attr.bgcolour then\
		new.BackgroundColour = self:ParseColour(attr.bgcolour)\
	elseif attr.bgcolor then\
		new.BackgroundColour = self:ParseColour(attr.bgcolor)\
	end\
\
	if attr.height then\
		new.Height = attr.height\
	end\
\
	if attr.width then\
		new.Width = attr.width\
	end\
\
	if new.OnInitialise then\
		new:OnInitialise(node)\
	end\
\
	return new\
end\
\
ParseColour = function(self, str)\
	if str and type(str) == 'string' then\
		if colours[str] and type(colours[str]) == 'number' then\
			return colours[str]\
		elseif colors[str] and type(colors[str]) == 'number' then\
			return colors[str]\
		end\
	end\
end\
\
CreateObject = function(self, parentObject, y)\
	local object\
	if self.OnCreateObject then\
		object = self:OnCreateObject()\
	else\
		object = {\
			Element = self,\
			Y = y,\
			X = 1,\
			Width = self.Width,\
			Height = self.Height,\
			BackgroundColour = self.BackgroundColour,\
			Type = \"View\"\
		}\
	end\
\
	if object then\
		return parentObject:AddObject(object, parentObject, y)\
	end\
end",["Divider.lua"]="Char = nil\
\
OnInitialise = function(self, node)\
	local attr = self.Attributes\
	self.Text = self.Text or ''\
	if attr.char then\
		if #attr.char == 1 then\
			self.Char = attr.char\
		end\
	end\
end\
\
OnCreateObject = function(self, parentObject, y)\
	return {\
		Element = self,\
		Y = y,\
		X = 1,\
		Width = self.Width,\
		Height = self.Height,\
		BackgroundColour = self.BackgroundColour,\
		TextColour = self.TextColour,\
		Type = \"DividerView\",\
		Char = self.Char\
	}\
end",["Link.lua"]="Align = 'Left'\
Width = \"100%\"\
TextColour = colours.blue\
UnderlineColour = nil\
UnderlineVisible = true\
URL = nil\
\
OnInitialise = function(self, node)\
	local attr = self.Attributes\
	if attr.href then\
		self.URL = attr.href\
	end\
	\
	if attr.ulcolour then\
		if attr.ulcolour == 'none' then\
			self.UnderlineVisible = false\
		else\
			self.UnderlineColour = self:ParseColour(attr.ulcolour)\
		end\
	elseif attr.ulcolor then\
		if attr.ulcolor == 'none' then\
			self.UnderlineVisible = false\
		else\
			self.UnderlineColour = self:ParseColour(attr.ulcolor)\
		end\
	end\
\
	if attr.align then\
		if attr.align:lower() == 'left' or attr.align:lower() == 'center' or attr.align:lower() == 'right' then\
			self.Align = attr.align:lower():gsub(\"^%l\", string.upper)\
		end\
	end\
end\
\
OnCreateObject = function(self, parentObject, y)\
	return {\
		Element = self,\
		Y = y,\
		X = 1,\
		Width = self.Width,\
		Align = self.Align,\
		Type = \"LinkView\",\
		Text = self.Text,\
		TextColour = self.TextColour,\
		UnderlineColour = self.UnderlineColour,\
		BackgroundColour = self.BackgroundColour,\
		URL = resolveFullUrl(self.URL),\
		UnderlineVisible = self.UnderlineVisible\
	}\
end",["Center.lua"]="OnCreateObject = function(self, parentObject, y)\
	return {\
		Element = self,\
		Y = y,\
		X = 1,\
		Width = \"100%\",\
		Height = self.Height,\
		BackgroundColour = self.BackgroundColour,\
		Type = \"CenterView\"\
	}\
end",["Form.lua"]="Submit = function(self, onEnter)\
	local values = {}\
	\
	local node = false\
	node = function(elem)\
		if (elem.Tag == 'input' or elem.Tag == 'select') and elem.InputName then\
			local findSubmit = (onEnter and elem.Attributes and elem.Attributes.type == 'submit')\
			if elem.UpdateValue then\
				elem:UpdateValue(findSubmit)\
			end\
\
			if findSubmit then\
				onEnter = false\
			end\
\
			if elem.Value then\
				values[elem.InputName] = elem.Value\
			end\
		end\
\
		if elem.Children then\
			for i, child in ipairs(elem.Children) do\
				node(child)\
			end\
		end\
	end\
\
	node(self)\
\
	local url = false\
	if self.Attributes.action and #self.Attributes.action > 0 then\
		url = resolveFullUrl(self.Attributes.action) --TODO: this needs to show the fake url to the user\
	else\
		url = getCurrentFakeUrl()\
	end\
	local data = ''\
	for k, v in pairs(values) do\
		data = data .. textutils.urlEncode(k) .. '=' .. textutils.urlEncode(v) .. '&'\
	end\
	data = data:sub(1, #data - 1)\
\
	if self.Attributes.method and self.Attributes.method:lower() == 'post' then\
		goToUrl(url, data)\
	else\
		goToUrl(url .. '?' .. data)\
	end\
end\
\
OnCreateObject = function(self, parentObject, y)\
	return {\
		Element = self,\
		Y = y,\
		X = 1,\
		Width = \"100%\",\
		Height = self.Height,\
		Type = \"FormView\"\
	}\
end",["FileInput.lua"]="BackgroundColour = colours.lightGrey\
TextColour = colours.black\
Text = 'Choose File...'\
InputName = ''\
FilePath = 'test'\
\
OnInitialise = function(self, node)\
	local attr = self.Attributes\
	if attr.value then\
		self.Text = attr.value\
	end\
\
	if attr.name then\
		self.InputName = attr.name\
	end\
\
	if not attr.width then\
		self.Width = #self.Text + 2\
	end\
end\
\
UpdateValue = function(self, force)\
	if self.FilePath then\
		local f = fs.open(self.FilePath, 'r')\
		if f then\
			local content = f.readAll()\
			self.Value = '{\"name\": \"' .. fs.getName(self.FilePath):gsub('\"', '\\\\\"') .. '\", \"content\": \"' .. content:gsub('\"', '\\\\\"') .. '\"}'\
			f.close()\
		end\
	end\
end\
\
CreateObject = function(self, parentObject, y)\
	return parentObject:AddObject({\
		Element = self,\
		Y = y,\
		X = 1,\
		Width = self.Width,\
		Type = \"Button\",\
		Text = self.Text,\
		TextColour = self.TextColour,\
		BackgroundColour = self.BackgroundColour,\
		InputName = self.InputName,\
		OnClick = function(_self, event, side, x, y)\
			_self.Bedrock:DisplayOpenFileWindow(nil, function(success, path)\
				if success then\
					self.FilePath = path\
					_self.Text = 'File: '..fs.getName(path)\
					_self.Align = 'Left'\
				end\
			end)\
		end\
	})\
end",["Heading.lua"]="Align = \"Center\"\
\
OnInitialise = function(self, node)\
	local attr = self.Attributes\
	self.Text = self.Text or ''\
	if attr.align then\
		if attr.align:lower() == 'left' or attr.align:lower() == 'center' or attr.align:lower() == 'right' then\
			self.Align = attr.align:lower():gsub(\"^%l\", string.upper)\
		end\
	end\
end\
\
OnCreateObject = function(self, parentObject, y)\
	return {\
		Element = self,\
		Y = y,\
		X = 1,\
		Width = \"100%\",\
		Align = self.Align,\
		Type = \"HeadingView\",\
		Text = self.Text,\
		TextColour = self.TextColour,\
		BackgroundColour = self.BackgroundColour\
	}\
end",["TextInput.lua"]="SelectedBackgroundColour = colours.blue\
SelectedTextColour = colours.white\
PlaceholderTextColour = colours.grey\
Placeholder = ''\
Value = nil\
Attributes = nil\
Children = nil\
Tag = nil\
Width = 20\
InputName = ''\
\
OnInitialise = function(self, node)\
	local attr = self.Attributes\
	if attr.selbgcolour then\
		self.SelectedBackgroundColour = self:ParseColour(attr.selbgcolour)\
	elseif attr.selbgcolor then\
		self.SelectedBackgroundColour = self:ParseColour(attr.selbgcolor)\
	end\
\
	if attr.selcolour then\
		self.SelectedTextColour = self:ParseColour(attr.selcolour)\
	elseif attr.selcolor then\
		self.SelectedTextColour = self:ParseColour(attr.selcolor)\
	end\
\
	if attr.plcolour then\
		self.PlaceholderTextColour = self:ParseColour(attr.plcolour)\
	elseif attr.plcolour then\
		self.PlaceholderTextColour = self:ParseColour(attr.plcolour)\
	end\
\
	if attr.value then\
		self.Value = attr.value\
	end\
\
	if attr.placeholder then\
		self.Placeholder = attr.placeholder\
	end\
\
	if attr.name then\
		self.InputName = attr.name\
	end\
end\
\
UpdateValue = function(self)\
	self.Value = self.Object.Text\
end\
\
OnCreateObject = function(self, parentObject, y)\
	return {\
		Element = self,\
		Y = y,\
		X = 1,\
		Width = self.Width,\
		Type = \"TextBox\",\
		Text = self.Value,\
		TextColour = self.TextColour,\
		BackgroundColour = self.BackgroundColour,\
		SelectedBackgroundColour = self.SelectedBackgroundColour,\
		SelectedTextColour = self.SelectedTextColour,\
		PlaceholderTextColour = self.PlaceholderTextColour,\
		Placeholder = self.Placeholder,\
		InputName = self.InputName,\
		OnChange = function(_self, event, keychar)\
			if keychar == keys.tab or keychar == keys.enter then\
				local form = self\
				local step = 0\
				while form.Tag ~= 'form' and step < 50 do\
					form = form.Parent\
				end\
				if keychar == keys.tab then\
					if form and form.Object and form.Object.OnTab then\
						form.Object:OnTab()\
					end\
				else\
					if form and form.Submit then\
						form:Submit(true)\
					end\
				end\
			end\
		end\
	}\
end",["ElementTree.lua"]="Tree = nil\
FailHandler = nil\
\
Initialise = function(self, html)\
	local new = {}    -- the new instance\
	setmetatable( new, {__index = self} )\
	local err = nil\
	if html:sub(1,15) ~= '<!DOCTYPE ccml>' then\
		err = Errors.InvalidDoctype\
	end\
\
	html = html:gsub(\"<!%-%-*.-%-%->\",\"\")\
\
	local rawTree\
	if not err then\
		rawTree = parser.parsestr(html)[1]\
	end\
\
	if not err then\
		_, notok = pcall(function() new:LoadTree(rawTree) end)\
		if notok then\
			error(notok)\
			err = Errors.ParseFailed\
		end\
	end\
\
	if err then\
		return nil, err\
	end\
	return new\
end\
\
LoadTree = function(self, rawTree)\
	local tree = {}\
	local node = true\
	node = function (tbl, tr, parent)\
		for i, v in ipairs(tbl) do\
			if type(v) == 'table' and v._tag then\
				local class = self:GetElementClass(v._tag, v._attr)\
				if not class or not class.Initialise then\
					error('Unknown class: '..v._attr.type)\
				end\
				local element = class:Initialise(v)\
				element.Parent = parent\
				table.insert(tr, element)\
				if element.Children then\
					node(v, element.Children, element)\
				end\
			end\
		end\
	end\
\
	node(rawTree, tree)\
	self.Tree = tree\
end\
\
GetElement = function(self, tag)\
	local node = true\
	node = function(tbl)\
		for i,v in ipairs(tbl) do\
			if type(v) == 'table' and v.Tag then\
				if v.Tag == tag then\
					return v\
				end\
				if v.Children then\
					local r = node(v.Children)\
					if r then\
						return r\
					end\
				end\
			end\
		end\
	end\
	return node(self.Tree)\
end\
\
GetElementClass = function(self, tag, attr)\
	if tag == 'h' then\
		return Heading\
	elseif tag == 'div' then\
		return Divider\
	elseif tag == 'p' then\
		return Paragraph\
	elseif tag == 'center' then\
		return Center\
	elseif tag == 'img' then\
		return Image\
	elseif tag == 'a' then\
		return Link\
	elseif tag == 'float' then\
		return Float\
	elseif tag == 'br' then\
		return Element\
	elseif tag == 'input' then\
		if attr.type == 'text' then\
			return TextInput\
		elseif attr.type == 'password' then\
			return SecureTextInput\
		elseif attr.type == 'submit' or attr.type == 'button' then\
			return ButtonInput\
		elseif attr.type == 'file' then\
			return FileInput\
		elseif attr.type == 'hidden' then\
			return HiddenInput\
		else\
			return Element\
		end\
	elseif tag == 'select' then\
		return Select\
	elseif tag == 'option' then\
		return SelectOption\
	elseif tag == 'form' then\
		return Form\
	elseif tag == 'script' then\
		return Script\
	else\
		return Element\
	end\
end",["SelectOption.lua"]="Value = nil\
\
OnInitialise = function(self, node)\
	if attr.value then\
		new.Value = attr.value\
	end\
end\
\
OnCreateObject = function(self, parentObject, y)\
	if parentObject.AddMenuItem then\
		parentObject:AddMenuItem({\
			Value = self.Value,\
			Text = self.Text,\
			Type = \"Button\"\
		})\
	end\
end",},["startup"]="local QuestVersion = 'v0.9.0 Private Beta'\
if OneOS then\
	QuestVersion = QuestVersion .. '-OneOS ' .. OneOS.Version\
end\
\
-- TODO: have a much simpler API loader... not a 70+ line one\
local Extension = function(path, addDot)\
	if not path then\
		return nil\
	elseif not string.find(fs.getName(path), '%.') then\
		if not addDot then\
			return fs.getName(path)\
		else\
			return ''\
		end\
	else\
		local _path = path\
		if path:sub(#path) == '/' then\
			_path = path:sub(1,#path-1)\
		end\
		local extension = _path:gmatch('%.[0-9a-z]+$')()\
		if extension then\
			extension = extension:sub(2)\
		else\
			--extension = nil\
			return ''\
		end\
		if addDot then\
			extension = '.'..extension\
		end\
		return extension:lower()\
	end\
end\
\
local RemoveExtension = function(path)\
	if path:sub(1,1) == '.' then\
		return path\
	end\
	local extension = Extension(path)\
	if extension == path then\
		return fs.getName(path)\
	end\
	return string.gsub(path, extension, ''):sub(1, -2)\
end\
\
local tAPIsLoading = {}\
local function LoadAPI(_sPath)\
	local sName = RemoveExtension(fs.getName( _sPath ))\
	if tAPIsLoading[sName] == true then\
	end\
	tAPIsLoading[sName] = true\
		\
	local tEnv = {isStartup = true }\
	setmetatable( tEnv, { __index = getfenv()} )\
	local fnAPI, err = loadfile( _sPath )\
	if fnAPI then\
		setfenv( fnAPI, tEnv )\
		fnAPI()\
	else\
		printError( err )\
		log('Error: '..err)\
        tAPIsLoading[sName] = nil\
		return false\
	end\
	\
	local tAPI = {}\
	for k,v in pairs( tEnv ) do\
		tAPI[k] =  v\
	end\
	\
	_G[sName] = tAPI\
end\
\
_G.Errors = {\
	Unknown = 1,\
	InvalidDoctype = 2,\
	ParseFailed = 3,\
	NotFound = 404,\
	TimeoutStop = 408,\
}\
\
local bedrockPath='/' if OneOS then OneOS.LoadAPI('/System/API/Bedrock.lua', false)elseif fs.exists(bedrockPath..'/Bedrock')then os.loadAPI(bedrockPath..'/Bedrock')else if http then print('Downloading Bedrock...')local h=http.get('http://pastebin.com/raw.php?i=0MgKNqpN')if h then local f=fs.open(bedrockPath..'/Bedrock','w')f.write(h.readAll())f.close()h.close()os.loadAPI(bedrockPath..'/Bedrock')else error('Failed to download Bedrock. Is your internet working?') end else error('This program needs to download Bedrock to work. Please enable HTTP.') end end if Bedrock then Bedrock.BasePath = bedrockPath Bedrock.ProgramPath = shell.getRunningProgram() end\
\
os.loadAPI('parser')\
os.loadAPI('hash')\
os.loadAPI('lQuery')\
os.loadAPI('Peripheral')\
os.loadAPI('Wireless')\
\
LoadAPI('Elements/Element.lua')\
\
LoadAPI('Elements/ElementTree.lua')\
\
local elements = {\
	'Script',\
	'Center',\
	'Link',\
	'Image',\
	'Divider',\
	'Heading',\
	'Paragraph',\
	'Float',\
	'TextInput',\
	'FileInput',\
	'SecureTextInput',\
	'Select',\
	'Form',\
	'SelectOption',\
	'ButtonInput',\
	'HiddenInput',\
}\
\
for i, v in ipairs(elements) do\
	LoadAPI('Elements/' .. v .. '.lua')\
	local env = getfenv()\
	local super = Element\
	if env[v].Inherit then\
		super = env[env[v].Inherit]\
	end\
	env[v].__index = super\
	setmetatable(env[v], env[v])\
end\
\
local program = Bedrock:Initialise()\
\
local function split(str, pat)\
   local t = {}\
   local fpat = \"(.-)\" .. pat\
   local last_end = 1\
   local s, e, cap = str:find(fpat, 1)\
   while s do\
      if s ~= 1 or cap ~= \"\" then\
	 table.insert(t,cap)\
      end\
      last_end = e+1\
      s, e, cap = str:find(fpat, last_end)\
   end\
   if last_end <= #str then\
      cap = str:sub(last_end)\
      table.insert(t, cap)\
   end\
   return t\
end\
\
local httpQueue = {}\
\
program:RegisterEvent('http_success', function(self, event, url, response)\
	for i, request in ipairs(httpQueue) do\
		if request[3] == url then\
			request[2](true, url, response)\
			table.remove(httpQueue, i)\
			break\
		end\
	end\
end)\
\
program:RegisterEvent('http_failure', function(self, event, url)\
	for i, request in ipairs(httpQueue) do\
		if request[3] == url then\
			request[2](false, Errors.Unknown)\
			table.remove(httpQueue, i)\
			break\
		end\
	end\
end)\
\
program:RegisterEvent('modem_message', function(self, event, side, channel, replyChannel, message, distance)\
	Wireless.HandleMessage(event, side, channel, replyChannel, message, distance)\
end)\
\
local wifiQueue = {}\
\
Wireless.Responder = function(event, side, channel, replyChannel, message, distance)\
	if channel == Wireless.Channels.QuestServerRequestReply then\
		for i, request in ipairs(wifiQueue) do\
			if request[1] == message.content.url then\
				if message.content.content then\
					local line = 0\
					local lines = split(message.content.content, '\\n')\
					local handle = {\
						readAll = function()return message.content.content end,\
						readLine = function()\
							line = line + 1\
							return lines[line]\
						end,\
						close = function()end\
					}\
					request[2](true, message.content.url, handle)\
				else\
					request[2](false, 404)\
				end\
				table.remove(wifiQueue, i)\
				break\
			end\
		end\
	end\
end\
\
local function cancelHTTPAsync(url)\
	for i, request in ipairs(httpQueue) do\
		if request[1] == url then\
			request[2](false, Errors.TimeoutStop)\
			table.remove(httpQueue, i)\
			break\
		end\
	end\
end\
\
local settings = false\
\
local function fetchHTTPAsync(url, callback, post)\
	local components = urlComponents(url)\
	if components.protocol == 'quest' then\
		local file = fs.open(program.ProgramPath .. '/Pages/' .. components.filepathsansget, 'r')\
		callback(true, url, file)\
	elseif components.protocol == 'file' then\
		local file = fs.open(components.sansprotocol, 'r')\
		if file then\
			callback(true, url, file)\
		else\
			callback(false)\
		end\
	elseif components.protocol == 'wifi' then\
		if Wireless.Present() then\
			table.insert(wifiQueue, {url, callback})\
			Wireless.SendMessage(Wireless.Channels.QuestServerRequest, url)\
		else\
			callback(false, 7)\
		end\
	elseif components.protocol == 'http' then\
		local _url = resolveQuestHostUrl(url)\
		table.insert(httpQueue, {url, callback, _url})\
\
		if not post then\
			post = 'questClientIdentifier=' .. textutils.urlEncode(settings.ClientIdentifier)\
		else\
			post = post .. '&questClientIdentifier=' .. textutils.urlEncode(settings.ClientIdentifier)\
		end\
		http.request(_url, post, {\
			['User-Agent'] = 'Quest/'..QuestVersion\
		})\
	end\
end\
\
local questHost = 'http://quest.net76.net/sites/'\
\
local function findLast(haystack, needle)\
    local i=haystack:match(\".*\"..needle..\"()\")\
    if i==nil then return nil else return i-1 end\
end\
\
local hex_to_char = function(x)\
  return string.char(tonumber(x, 16))\
end\
\
local function urlUnencode( str )\
	-- essentially reverses textutils.urlDecode\
    if str then\
        str = string.gsub(str, \"+\", \" \")\
        str = string.gsub(str, \"\\r\\n\", \"\\n\")\
        term.setTextColor(colors.black)\
        str = str:gsub(\"%%(%x%x)\", hex_to_char)\
    end\
    return str    \
end\
\
local function urlComponents(url)\
	if url then\
		urlUnencode(textutils.urlEncode(url))\
		local components = {}\
		local parts = split(url, '[\\\\/]+')\
		if url:find('://') and parts[1]:sub(#parts[1]) == ':' then\
			components.protocol = parts[1]:sub(1, #parts[1]-1)\
			components.sansprotocol = url:sub(#components.protocol + 4)\
			components.host = parts[2]\
			components.fullhost = components.protocol .. '://' .. parts[2] .. '/'\
			components.filepath = url:sub(#components.fullhost)\
			if components.filepath:sub(#components.filepath) ~= '/' and components.filepath:find('?') then\
				components.filename = fs.getName(components.filepath:sub(1, components.filepath:find('?') - 1))\
			else\
				components.filename = fs.getName(components.filepath)\
			end\
			if components.filename == 'root' or components.filename == components.host then\
				components.filename = ''\
			end\
			components.base = url:sub(1, findLast(url, '/'))\
			components.get = {}\
			components.filepathsansget = components.sansprotocol\
			if url:find('?') then\
				local start = url:find('?')\
				components.filepathsansget = url:sub(#components.protocol + 4, start - 1)\
				local getString = url:sub(start + 1)\
				local values = split(getString, '&')\
				for i, v in ipairs(values) do\
					local keyvalue = split(v, '=')\
					components.get[keyvalue[1]] =  urlUnencode(keyvalue[2])\
				end\
			end\
			return components\
		end\
	end\
end\
\
local function resolveQuestHostUrl(url)\
	local components = urlComponents(url)\
	local hostParts = split(components.host, '%.')\
	local tld = hostParts[#hostParts]\
	if tld == 'qst' and #hostParts == 2 then\
		return questHost .. hostParts[1] .. components.filepath\
	end\
	return url\
end\
\
local function resolveFullUrl(url)\
	if url and type(url) ~= 'string' then\
	elseif url:find('://') then\
		return url\
	else\
		local components = urlComponents(program:GetObject('WebView').URL)\
		if components then\
			if url:sub(1,1) == '/' then\
				return components.fullhost .. url:sub(2)\
			else\
				return components.base .. url\
			end\
		end\
	end\
end\
\
local function getCurrentUrl()\
	return program:GetObject('WebView').URL\
end\
\
local function getCurrentFakeUrl()\
	return program:GetObject('WebView').FakeURL\
end\
\
local function goToUrl(url, post)\
	program:GetObject('WebView'):GoToURL(url, nil, nil, post)\
end\
\
--	Yes, it's evil and terrible, etc. But I'll hopefully change it later.\
_G.cancelHTTPAsync = cancelHTTPAsync\
_G.fetchHTTPAsync = fetchHTTPAsync\
_G.resolveFullUrl = resolveFullUrl\
_G.resolveQuestHostUrl = resolveQuestHostUrl\
_G.getCurrentUrl = getCurrentUrl\
_G.getCurrentFakeUrl = getCurrentFakeUrl\
_G.goToUrl = goToUrl\
_G.split = split\
_G.urlComponents = urlComponents\
_G.QuestVersion = QuestVersion\
\
local history = {}\
local historyItem = 0\
\
local function updateHistoryButtons()\
	if history[historyItem-1] then\
		program:GetObject('BackButton').Enabled = true\
	else\
		program:GetObject('BackButton').Enabled = false\
	end\
\
	if history[historyItem+1] then\
		program:GetObject('ForwardButton').Enabled = true\
	else\
		program:GetObject('ForwardButton').Enabled = false\
	end\
end\
\
local function addHistoryURL(url)\
	for i, v in ipairs(history) do\
		if i > historyItem then\
			history[i] = nil\
		end\
	end\
	table.insert(history, url)\
	historyItem = #history\
	updateHistoryButtons()\
end\
\
local defaultSettings = {\
	Home = 'http://thehub.qst/',\
	ClientIdentifier = nil\
}\
\
local function quit()\
	term.setBackgroundColour(colors.black)\
	shell.run('clear')\
	print('Thanks for using Quest, created by oeed.')\
	program:Quit()\
end\
\
local function goHome()\
	goToUrl(settings.Home)\
end\
\
local function saveSettings()\
	local f = fs.open('.Quest.settings', 'w')\
	if f then\
		f.write(textutils.serialize(settings))\
		f.close()\
	end\
end\
\
local function generateClientIdentifier()\
	program:DisplayWindow({\
		Children = {{\
			X = 2,\
			Y = 2,\
			Type = \"Label\",\
			Width = \"100%,-2\",\
			Height = 2,\
			Text = \"Registering computer with central server...\"\
		}},\
		Width = 28,\
		Height = 4\
	}, \"Please Wait\", false)\
	program:Draw()\
	local h = http.get('http://quest.net76.net/registerClient.php')\
	program.Window:Close()\
\
	if h then\
		settings.ClientIdentifier = h.readAll()\
		saveSettings()\
		h.close()\
		goHome()\
	else\
		program:DisplayAlertWindow(\"Register Failed\", \"Quest couldn't register your computer. There was something wrong with your internet connection. Please quit and try again.\", {'Quit'}, function(value)\
			quit()\
		end)\
	end\
\
end\
\
local function loadSettings()\
	if fs.exists('.Quest.settings') then\
		local f = fs.open('.Quest.settings', 'r')\
		if f then\
			settings = textutils.unserialize(f.readAll())\
			if not settings.ClientIdentifier then\
				generateClientIdentifier()\
			end\
			return settings\
		end\
	end\
\
	settings = defaultSettings\
	generateClientIdentifier()\
end\
\
program:Run(function()\
	local timeoutTimer = false\
\
	program:LoadView('main')\
\
	Wireless.Initialise()\
\
	loadSettings()\
\
	program:GetObject('BackButton').OnClick = function(self)\
		if history[historyItem-1] then\
			historyItem = historyItem - 1\
			program:GetObject('WebView'):GoToURL(history[historyItem], nil, true)\
			updateHistoryButtons()\
		end\
	end\
\
	program:GetObject('ForwardButton').OnClick = function(self)\
		if history[historyItem+1] then\
			historyItem = historyItem + 1\
			program:GetObject('WebView'):GoToURL(history[historyItem], nil, true)\
			updateHistoryButtons()\
		end\
	end\
\
	program:GetObject('URLTextBox').OnChange = function(self, event, keychar)\
		if keychar == keys.enter then\
			local url = self.Text\
			if not url:find('://') then\
				if url:find(' ') or not url:find('%.') then\
					url = 'http://thehub.qst/search.php?q='..textutils.urlEncode(url)\
				else\
					url = 'http://' .. url \
				end\
				self.Text = url\
			end\
			program:GetObject('WebView'):GoToURL(url)\
		end\
	end\
\
	program:GetObject('OptionsButton').OnClick = function(self, event, side, x, y)\
		if self:ToggleMenu('optionsmenu', x, y) then\
			program:GetObject('StopMenuItem').OnClick = function(self, event, side, x, y)\
				program:GetObject('WebView'):Stop()\
			end\
\
			program:GetObject('ReloadMenuItem').OnClick = function(self, event, side, x, y)\
				program:GetObject('WebView'):GoToURL(program:GetObject('WebView').URL)\
			end\
\
			program:GetObject('GoHomeMenuItem').OnClick = function(self, event, side, x, y)\
				goHome()\
			end\
\
			program:GetObject('SetHomeMenuItem').OnClick = function(self, event, side, x, y)\
				settings.Home = program:GetObject('WebView').FakeURL\
				saveSettings()\
			end\
\
			program:GetObject('QuitMenuItem').OnClick = function(self, event, side, x, y)\
				quit()\
			end\
		end\
	end\
\
	program:GetObject('WebView').OnPageLoadStart = function(self, url)\
		program:SetActiveObject()\
		-- program:GetObject('GoButton').Text = 'x'\
		program:GetObject('URLTextBox').Visible = false\
		program:GetObject('LoadingLabel').Visible = true\
		program:GetObject('PageTitleLabel').Text = ''\
\
		if url:find('http://') or url:find('https://') then\
			timeoutTimer = program:StartTimer(function()\
				program:GetObject('WebView'):Stop()\
			end, 20)\
		else\
			timeoutTimer = program:StartTimer(function()\
				program:GetObject('WebView'):Stop()\
			end, 1)\
		end\
	end\
\
	program:GetObject('WebView').OnPageLoadEnd = function(self, url, noHistory)\
		program:GetObject('URLTextBox').Text = url\
		program:GetObject('URLTextBox').Visible = true\
		program:GetObject('LoadingLabel').Visible = false\
\
		if self.Tree:GetElement('title') then\
			program:GetObject('PageTitleLabel').Text = self.Tree:GetElement('title').Text\
		end\
\
		if not noHistory then\
			addHistoryURL(url)\
		end\
\
		program.Timers[timeoutTimer] = nil\
	end\
\
	program:GetObject('WebView').OnPageLoadFailed = function(self, url, _error, noHistory)\
		program:GetObject('URLTextBox').Text = url\
		program:GetObject('URLTextBox').Visible = true\
		program:GetObject('LoadingLabel').Visible = false\
		program.Timers[timeoutTimer] = nil\
\
		if not noHistory then\
			addHistoryURL(url)\
		end\
\
		local get = ''\
		_error = _error or 1\
		if type(_error) == 'string' then\
			get = '?reason='..textutils.urlEncode(_error)\
			_error = 'text'\
		end\
\
		program:GetObject('WebView'):GoToURL('quest://'.._error..'.ccml'..get, true, true)\
	end\
\
	program:GetObject('Toolbar').OnClick = function(self, event, side, x, y)\
		program:SetActiveObject()\
	end\
\
	program:GetObject('WebView').OnClick = function(self, event, side, x, y)\
		program:SetActiveObject()\
	end\
\
	if settings.ClientIdentifier then\
		goHome()\
	end\
end)\
\
",["Bedrock"]="--Bedrock Build: 262\
--This code is squished down in to one, rather hard to read file.\
--As such it is not much good for anything other than being loaded as an API.\
--If you want to look at the code to learn from it, copy parts or just take a look,\
--you should go to the GitHub repo. http://github.com/oeed/Bedrock/\
\
--\
--		Bedrock is the core program framework used by all OneOS and OneCode programs.\
--							Inspired by Apple's Cocoa framework.\
--									   (c) oeed 2014\
--\
--		  For documentation see the Bedrock wiki, github.com/oeed/Bedrock/wiki/\
--\
\
local apis = {\
[\"Drawing\"] = [[\
local round = function(num, idp)\
	local mult = 10^(idp or 0)\
	return math.floor(num * mult + 0.5) / mult\
end\
\
local _w, _h = term.getSize()\
local copyBuffer = nil\
\
Screen = {\
	Width = _w,\
	Height = _h\
}\
\
Constraints = {\
	\
}\
\
CurrentConstraint = {1,1,_w,_h}\
IgnoreConstraint = false\
\
function AddConstraint(x, y, width, height)\
	local x2 = x + width - 1\
	local y2 = y + height - 1\
	table.insert(Drawing.Constraints, {x, y, x2, y2})\
	Drawing.GetConstraint()\
end\
\
function RemoveConstraint()\
	--table.remove(Drawing.Constraints, #Drawing.Constraints)\
	Drawing.Constraints[#Drawing.Constraints] = nil\
	Drawing.GetConstraint()\
end\
\
function GetConstraint()\
	local x = 1\
	local y = 1\
	local x2 = Drawing.Screen.Width\
	local y2 = Drawing.Screen.Height\
	for i, c in ipairs(Drawing.Constraints) do\
		if x < c[1] then\
			x = c[1]\
		end\
		if y < c[2] then\
			y = c[2]\
		end\
		if x2 > c[3] then\
			x2 = c[3]\
		end\
		if y2 > c[4] then\
			y2 = c[4]\
		end\
	end\
	Drawing.CurrentConstraint = {x, y, x2, y2}\
end\
\
function WithinContraint(x, y)\
	return Drawing.IgnoreConstraint or\
		  (x >= Drawing.CurrentConstraint[1] and\
		   y >= Drawing.CurrentConstraint[2] and\
		   x <= Drawing.CurrentConstraint[3] and\
		   y <= Drawing.CurrentConstraint[4])\
end\
\
colours.transparent = 0\
colors.transparent = 0\
\
DrawCharacters = function (x, y, characters, textColour, bgColour)\
	Drawing.WriteStringToBuffer(x, y, tostring(characters), textColour, bgColour)\
end\
\
DrawBlankArea = function (x, y, w, h, colour)\
	if colour ~= colours.transparent then\
		Drawing.DrawArea (x, y, w, h, \" \", 1, colour)\
	end\
end\
\
DrawArea = function (x, y, w, h, character, textColour, bgColour)\
	--width must be greater than 1, otherwise we get problems\
	if w < 0 then\
		w = w * -1\
	elseif w == 0 then\
		w = 1\
	end\
\
	for ix = 1, w do\
		local currX = x + ix - 1\
		for iy = 1, h do\
			local currY = y + iy - 1\
			Drawing.WriteToBuffer(currX, currY, character, textColour, bgColour)\
		end\
	end\
end\
\
DrawImage = function(_x,_y,tImage, w, h)\
	if tImage then\
		for y = 1, h do\
			if not tImage[y] then\
				break\
			end\
			for x = 1, w do\
				if not tImage[y][x] then\
					break\
				end\
				local bgColour = tImage[y][x]\
	            local textColour = tImage.textcol[y][x] or colours.white\
	            local char = tImage.text[y][x]\
	            Drawing.WriteToBuffer(x+_x-1, y+_y-1, char, textColour, bgColour)\
			end\
		end\
	elseif w and h then\
		Drawing.DrawBlankArea(_x, _y, w, h, colours.lightGrey)\
	end\
end\
\
--using .nft\
LoadImage = function(path, global)\
	local image = {\
		text = {},\
		textcol = {}\
	}\
	if fs.exists(path) then\
		local _io = io\
		if OneOS and global then\
			_io = OneOS.IO\
		end\
        local file = _io.open(path, \"r\")\
        if not file then\
        	error('Error Occured. _io:'..tostring(_io)..' OneOS: '..tostring(OneOS)..' OneOS.IO'..tostring(OneOS.IO)..' io: '..tostring(io))\
        end\
        local sLine = file:read()\
        local num = 1\
        while sLine do  \
            table.insert(image, num, {})\
            table.insert(image.text, num, {})\
            table.insert(image.textcol, num, {})\
                                        \
            --As we're no longer 1-1, we keep track of what index to write to\
            local writeIndex = 1\
            --Tells us if we've hit a 30 or 31 (BG and FG respectively)- next char specifies the curr colour\
            local bgNext, fgNext = false, false\
            --The current background and foreground colours\
            local currBG, currFG = nil,nil\
            for i=1,#sLine do\
                    local nextChar = string.sub(sLine, i, i)\
                    if nextChar:byte() == 30 then\
                            bgNext = true\
                    elseif nextChar:byte() == 31 then\
                            fgNext = true\
                    elseif bgNext then\
                            currBG = Drawing.GetColour(nextChar)\
		                    if currBG == nil then\
		                    	currBG = colours.transparent\
		                    end\
                            bgNext = false\
                    elseif fgNext then\
                            currFG = Drawing.GetColour(nextChar)\
		                    if currFG == nil or currFG == colours.transparent then\
		                    	currFG = colours.white\
		                    end\
                            fgNext = false\
                    else\
                            if nextChar ~= \" \" and currFG == nil then\
                                    currFG = colours.white\
                            end\
                            image[num][writeIndex] = currBG\
                            image.textcol[num][writeIndex] = currFG\
                            image.text[num][writeIndex] = nextChar\
                            writeIndex = writeIndex + 1\
                    end\
            end\
            num = num+1\
            sLine = file:read()\
        end\
        file:close()\
    else\
    	return nil\
	end\
 	return image\
end\
\
DrawCharactersCenter = function(x, y, w, h, characters, textColour,bgColour)\
	w = w or Drawing.Screen.Width\
	h = h or Drawing.Screen.Height\
	x = x or 0\
	y = y or 0\
	x = math.floor((w - #characters) / 2) + x\
	y = math.floor(h / 2) + y\
\
	Drawing.DrawCharacters(x, y, characters, textColour, bgColour)\
end\
\
GetColour = function(hex)\
	if hex == ' ' then\
		return colours.transparent\
	end\
    local value = tonumber(hex, 16)\
    if not value then return nil end\
    value = math.pow(2,value)\
    return value\
end\
\
Clear = function (_colour)\
	_colour = _colour or colours.black\
	Drawing.DrawBlankArea(1, 1, Drawing.Screen.Width, Drawing.Screen.Height, _colour)\
end\
\
Buffer = {}\
BackBuffer = {}\
\
TryRestore = false\
\
\
--TODO: make this quicker\
-- maybe sort the pixels in order of colour so it doesn't have to set the colour each time\
DrawBuffer = function()\
	if TryRestore and Restore then\
		Restore()\
	end\
\
	for y,row in pairs(Drawing.Buffer) do\
		for x,pixel in pairs(row) do\
			local shouldDraw = true\
			local hasBackBuffer = true\
			if Drawing.BackBuffer[y] == nil or Drawing.BackBuffer[y][x] == nil or #Drawing.BackBuffer[y][x] ~= 3 then\
				hasBackBuffer = false\
			end\
			if hasBackBuffer and Drawing.BackBuffer[y][x][1] == Drawing.Buffer[y][x][1] and Drawing.BackBuffer[y][x][2] == Drawing.Buffer[y][x][2] and Drawing.BackBuffer[y][x][3] == Drawing.Buffer[y][x][3] then\
				shouldDraw = false\
			end\
			if shouldDraw then\
				term.setBackgroundColour(pixel[3])\
				term.setTextColour(pixel[2])\
				term.setCursorPos(x, y)\
				term.write(pixel[1])\
			end\
		end\
	end\
	Drawing.BackBuffer = Drawing.Buffer\
	Drawing.Buffer = {}\
end\
\
ClearBuffer = function()\
	Drawing.Buffer = {}\
end\
\
WriteStringToBuffer = function (x, y, characters, textColour,bgColour)\
	for i = 1, #characters do\
		local character = characters:sub(i,i)\
		Drawing.WriteToBuffer(x + i - 1, y, character, textColour, bgColour)\
	end\
end\
\
WriteToBuffer = function(x, y, character, textColour,bgColour, cached)\
	if not cached and not Drawing.WithinContraint(x, y) then\
		return\
	end\
	x = round(x)\
	y = round(y)\
\
	if textColour == colours.transparent then\
		character = ' '\
	end\
\
	if bgColour == colours.transparent then\
		Drawing.Buffer[y] = Drawing.Buffer[y] or {}\
		Drawing.Buffer[y][x] = Drawing.Buffer[y][x] or {\"\", colours.white, colours.black}\
		Drawing.Buffer[y][x][1] = character\
		Drawing.Buffer[y][x][2] = textColour\
	else\
		Drawing.Buffer[y] = Drawing.Buffer[y] or {}\
		Drawing.Buffer[y][x] = {character, textColour, bgColour}\
	end\
\
	if copyBuffer then\
		copyBuffer[y] = copyBuffer[y] or {}\
		copyBuffer[y][x] = {character, textColour, bgColour}		\
	end\
end\
\
DrawCachedBuffer = function(buffer)\
	for y, row in pairs(buffer) do\
		for x, pixel in pairs(row) do\
			WriteToBuffer(x, y, pixel[1], pixel[2], pixel[3], true)\
		end\
	end\
end\
\
StartCopyBuffer = function()\
	copyBuffer = {}\
end\
\
EndCopyBuffer = function()\
	local tmpCopy = copyBuffer\
	copyBuffer = nil\
	return tmpCopy\
end\
]],\
[\"Helpers\"] = [[\
LongestString = function(input, key, isKey)\
	local length = 0\
	if isKey then\
		for k, v in pairs(input) do\
			local titleLength = string.len(k)\
			if titleLength > length then\
				length = titleLength\
			end\
		end\
	else\
		for i = 1, #input do\
			local value = input[i]\
			if key then\
				if value[key] then\
					value = value[key]\
				else\
					value = ''\
				end\
			end\
			local titleLength = string.len(value)\
			if titleLength > length then\
				length = titleLength\
			end\
		end\
	end\
	return length\
end\
\
Split = function(str,sep)\
    sep=sep or'/'\
    return str:match(\"(.*\"..sep..\")\")\
end\
\
Extension = function(path, addDot)\
	if not path then\
		return nil\
	elseif not string.find(fs.getName(path), '%.') then\
		if not addDot then\
			return fs.getName(path)\
		else\
			return ''\
		end\
	else\
		local _path = path\
		if path:sub(#path) == '/' then\
			_path = path:sub(1,#path-1)\
		end\
		local extension = _path:gmatch('%.[0-9a-z]+$')()\
		if extension then\
			extension = extension:sub(2)\
		else\
			--extension = nil\
			return ''\
		end\
		if addDot then\
			extension = '.'..extension\
		end\
		return extension:lower()\
	end\
end\
\
RemoveExtension = function(path)\
--local name = string.match(fs.getName(path), '(%a+)%.?.-')\
	if path:sub(1,1) == '.' then\
		return path\
	end\
	local extension = Helpers.Extension(path)\
	if extension == path then\
		return fs.getName(path)\
	end\
	return string.gsub(path, extension, ''):sub(1, -2)\
end\
\
RemoveFileName = function(path)\
	if string.sub(path, -1) == '/' then\
		path = string.sub(path, 1, -2)\
	end\
	local v = string.match(path, \"(.-)([^\\\\/]-%.?([^%.\\\\/]*))$\")\
	if type(v) == 'string' then\
		return v\
	end\
	return v[1]\
end\
\
TruncateString = function(sString, maxLength)\
	if #sString > maxLength then\
		sString = sString:sub(1,maxLength-3)\
		if sString:sub(-1) == ' ' then\
			sString = sString:sub(1,maxLength-4)\
		end\
		sString = sString  .. '...'\
	end\
	return sString\
end\
\
TruncateStringStart = function(sString, maxLength)\
	local len = #sString\
	if #sString > maxLength then\
		sString = sString:sub(len - maxLength, len - 3)\
		if sString:sub(-1) == ' ' then\
			sString = sString:sub(len - maxLength, len - 4)\
		end\
		sString = '...' .. sString\
	end\
	return sString\
end\
\
WrapText = function(text, maxWidth)\
	local lines = {''}\
    for word, space in text:gmatch('(%S+)(%s*)') do\
            local temp = lines[#lines] .. word .. space:gsub('\\n','')\
            if #temp > maxWidth then\
                    table.insert(lines, '')\
            end\
            if space:find('\\n') then\
                    lines[#lines] = lines[#lines] .. word\
                    \
                    space = space:gsub('\\n', function()\
                            table.insert(lines, '')\
                            return ''\
                    end)\
            else\
                    lines[#lines] = lines[#lines] .. word .. space\
            end\
    end\
	return lines\
end\
\
TidyPath = function(path)\
	path = '/'..path\
	if fs.exists(path) and fs.isDir(path) then\
		path = path .. '/'\
	end\
\
	path, n = path:gsub(\"//\", \"/\")\
	while n > 0 do\
		path, n = path:gsub(\"//\", \"/\")\
	end\
	return path\
end\
\
Capitalise = function(str)\
	return str:sub(1, 1):upper() .. str:sub(2, -1)\
end\
\
Round = function(num, idp)\
	local mult = 10^(idp or 0)\
	return math.floor(num * mult + 0.5) / mult\
end\
]],\
[\"Object\"] = [[\
X = 1\
Y = 1\
Width = 1\
Height = 1\
Parent = nil\
OnClick = nil\
Visible = true\
IgnoreClick = false\
Name = nil \
ClipDrawing = true\
UpdateDrawBlacklist = {}\
Fixed = false\
\
DrawCache = {}\
\
NeedsDraw = function(self)\
	if not self.Visible then\
		return false\
	end\
	\
	if not self.DrawCache.Buffer or self.DrawCache.AlwaysDraw or self.DrawCache.NeedsDraw then\
		return true\
	end\
\
	if self.OnNeedsUpdate then\
		if self.OnNeedsUpdate() then\
			return true\
		end\
	end\
\
	if self.Children then\
		for i, v in ipairs(self.Children) do\
			if v:NeedsDraw() then\
				return true\
			end\
		end\
	end\
end\
\
GetPosition = function(self)\
	return self.Bedrock:GetAbsolutePosition(self)\
end\
\
GetOffsetPosition = function(self)\
	if not self.Parent then\
		return {X = 1, Y = 1}\
	end\
\
	local offset = {X = 0, Y = 0}\
	if not self.Fixed and self.Parent.ChildOffset then\
		offset = self.Parent.ChildOffset\
	end\
\
	return {X = self.X + offset.X, Y = self.Y + offset.Y}\
end\
\
Draw = function(self)\
	if not self.Visible then\
		return\
	end\
\
	self.DrawCache.NeedsDraw = false\
	local pos = self:GetPosition()\
	Drawing.StartCopyBuffer()\
\
	if self.ClipDrawing then\
		Drawing.AddConstraint(pos.X, pos.Y, self.Width, self.Height)\
	end\
\
	if self.OnDraw then\
		self:OnDraw(pos.X, pos.Y)\
	end\
\
	self.DrawCache.Buffer = Drawing.EndCopyBuffer()\
	\
	if self.Children then\
		for i, child in ipairs(self.Children) do\
			local pos = child:GetOffsetPosition()\
			if pos.Y + self.Height > 1 and pos.Y <= self.Height and pos.X + self.Width > 1 and pos.X <= self.Width then\
				child:Draw()\
			end\
		end\
	end\
\
	if self.ClipDrawing then\
		Drawing.RemoveConstraint()\
	end	\
end\
\
ForceDraw = function(self, ignoreChildren, ignoreParent, ignoreBedrock)\
	if not ignoreBedrock and self.Bedrock then\
		self.Bedrock:ForceDraw()\
	end\
	self.DrawCache.NeedsDraw = true\
	if not ignoreParent and self.Parent then\
		self.Parent:ForceDraw(true, nil, true)\
	end\
	if not ignoreChildren and self.Children then\
		for i, child in ipairs(self.Children) do\
			child:ForceDraw(nil, true, true)\
		end\
	end\
end\
\
OnRemove = function(self)\
	if self == self.Bedrock:GetActiveObject() then\
		self.Bedrock:SetActiveObject()\
	end\
end\
\
local function ParseColour(value)\
	if type(value) == 'string' then\
		if colours[value] and type(colours[value]) == 'number' then\
			return colours[value]\
		elseif colors[value] and type(colors[value]) == 'number' then\
			return colors[value]\
		end\
	elseif type(value) == 'number' and (value == colours.transparent or (value >= colours.white and value <= colours.black)) then\
		return value\
	end\
	error('Invalid colour: \"'..tostring(value)..'\"')\
end\
\
Initialise = function(self, values)\
	local _new = values    -- the new instance\
	_new.DrawCache = {\
		NeedsDraw = true,\
		AlwaysDraw = false,\
		Buffer = nil\
	}\
	setmetatable(_new, {__index = self} )\
\
	local new = {} -- the proxy\
	setmetatable(new, {\
		__index = function(t, k)\
			if k:find('Color') then\
				k = k:gsub('Color', 'Colour')\
			end\
\
			if k:find('Colour') then\
				if _new[k] then\
					return ParseColour(_new[k])\
				end\
			elseif _new[k] ~= nil then\
				return _new[k]\
			end\
		end,\
\
		__newindex = function (t,k,v)\
			if k:find('Color') then\
				k = k:gsub('Color', 'Colour')\
			end\
\
			if k == 'Width' or k == 'X' or k == 'Height' or k == 'Y' then\
				v = new.Bedrock:ParseStringSize(new.Parent, k, v)\
			end\
\
			if v ~= _new[k] then\
				_new[k] = v\
				if t.OnUpdate then\
					t:OnUpdate(k)\
				end\
\
				if t.UpdateDrawBlacklist[k] == nil then\
					t:ForceDraw()\
				end\
			end\
		end\
	})\
	if new.OnInitialise then\
		new:OnInitialise()\
	end\
\
	return new\
end\
\
Click = function(self, event, side, x, y)\
	if self.Visible and not self.IgnoreClick then\
		if event == 'mouse_click' and self.OnClick and self:OnClick(event, side, x, y) ~= false then\
			return true\
		elseif event == 'mouse_drag' and self.OnDrag and self:OnDrag(event, side, x, y) ~= false then\
			return true\
		elseif event == 'mouse_scroll' and self.OnScroll and self:OnScroll(event, side, x, y) ~= false then\
			return true\
		else\
			return false\
		end\
	else\
		return false\
	end\
\
end\
\
ToggleMenu = function(self, name, x, y)\
	return self.Bedrock:ToggleMenu(name, self, x, y)\
end\
\
function OnUpdate(self, value)\
	if value == 'Z' then\
		self.Bedrock:ReorderObjects()\
	end\
end\
]],\
}\
local objects = {\
[\"Button\"] = [[\
BackgroundColour = colours.lightGrey\
ActiveBackgroundColour = colours.blue\
ActiveTextColour = colours.white\
TextColour = colours.black\
DisabledTextColour = colours.lightGrey\
Text = \"\"\
Toggle = nil\
Momentary = true\
AutoWidthAutoWidth = true\
Align = 'Center'\
Enabled = true\
\
OnUpdate = function(self, value)\
	if value == 'Text' and self.AutoWidth then\
		self.Width = #self.Text + 2\
	end\
end\
\
OnDraw = function(self, x, y)\
	local bg = self.BackgroundColour\
\
	if self.Toggle then\
		bg = self.ActiveBackgroundColour\
	end\
\
	local txt = self.TextColour\
	if self.Toggle then\
		txt = self.ActiveTextColour\
	end\
	if not self.Enabled then\
		txt = self.DisabledTextColour\
	end\
	Drawing.DrawBlankArea(x, y, self.Width, self.Height, bg)\
\
	local _x = 1\
    if self.Align == 'Right' then\
        _x = self.Width - #self.Text - 1\
    elseif self.Align == 'Center' then\
        _x = math.floor((self.Width - #self.Text) / 2)\
    end\
	Drawing.DrawCharacters(x + _x, y, self.Text, txt, bg)\
end\
\
OnLoad = function(self)\
	if self.Toggle ~= nil then\
		self.Momentary = false\
	end\
end\
\
Click = function(self, event, side, x, y)\
	if self.Visible and not self.IgnoreClick and self.Enabled and event ~= 'mouse_scroll' then\
		if self.OnClick then\
			if self.Momentary then\
				self.Toggle = true\
				self.Bedrock:StartTimer(function()self.Toggle = false end,0.25)\
			elseif self.Toggle ~= nil then\
				self.Toggle = not self.Toggle\
			end\
\
			self:OnClick(event, side, x, y, self.Toggle)\
		else\
			self.Toggle = not self.Toggle\
		end\
		return true\
	else\
		return false\
	end\
end\
]],\
[\"CollectionView\"] = [[\
Inherit = 'ScrollView'\
UpdateDrawBlacklist = {['NeedsItemUpdate']=true}\
\
TextColour = colours.black\
BackgroundColour = colours.white\
Items = false\
NeedsItemUpdate = false\
SpacingX = 2\
SpacingY = 1\
\
OnDraw = function(self, x, y)\
	if self.NeedsItemUpdate then\
		self:UpdateItems()\
		self.NeedsItemUpdate = false\
	end\
	Drawing.DrawBlankArea(x, y, self.Width, self.Height, self.BackgroundColour)\
end\
\
local function MaxIcons(self, obj)\
	local x, y = 2, 1\
	if not obj.Height or not obj.Width then\
		error('You must provide each object\\'s height when adding to a CollectionView.')\
	end\
	local slotHeight = obj.Height + self.SpacingY\
	local slotWidth = obj.Width + self.SpacingX\
	local maxX = math.floor((self.Width - 2) / slotWidth)\
	return x, y, maxX, slotWidth, slotHeight\
end\
\
local function IconLocation(self, obj, i)\
	local x, y, maxX, slotWidth, slotHeight = MaxIcons(self, obj)\
	local rowPos = ((i - 1) % maxX)\
	local colPos = math.ceil(i / maxX) - 1\
	x = x + (slotWidth * rowPos)\
	y = y + colPos * slotHeight\
	return x, y\
end\
\
local function AddItem(self, v, i)\
	local toggle = false\
	if not self.CanSelect then\
		toggle = nil\
	end\
	local x, y = IconLocation(self, v, i)\
	local item = {\
		[\"X\"]=x,\
		[\"Y\"]=y,\
		[\"Name\"]=\"CollectionViewItem\",\
		[\"Type\"]=\"View\",\
		[\"TextColour\"]=self.TextColour,\
		[\"BackgroundColour\"]=0F,\
		OnClick = function(itm)\
			if self.CanSelect then\
				for i2, _v in ipairs(self.Children) do\
					_v.Toggle = false\
				end\
				self.Selected = itm\
			end\
		end\
    }\
	for k, _v in pairs(v) do\
		item[k] = _v\
   	end\
	self:AddObject(item)\
end\
\
\
UpdateItems = function(self)\
	self:RemoveAllObjects()\
	local groupMode = false\
	for k, v in pairs(self.Items) do\
		if type(k) == 'string' then\
			groupMode = true\
			break\
		end\
	end\
\
	for i, v in ipairs(self.Items) do\
		AddItem(self, v, i)\
	end\
	self:UpdateScroll()\
end\
\
OnUpdate = function(self, value)\
	if value == 'Items' then\
		self.NeedsItemUpdate = true\
	end\
end\
]],\
[\"ImageView\"] = [[\
Image = false\
\
OnDraw = function(self, x, y)\
	Drawing.DrawImage(x, y, self.Image, self.Width, self.Height)\
end\
\
OnLoad = function(self)\
	if self.Path and fs.exists(self.Path) then\
		self.Image = Drawing.LoadImage(self.Path)\
	end\
end\
\
OnUpdate = function(self, value)\
	if value == 'Path' then\
		if self.Path and fs.exists(self.Path) then\
			self.Image = Drawing.LoadImage(self.Path)\
		end\
	end\
end\
]],\
[\"Label\"] = [[\
TextColour = colours.black\
BackgroundColour = colours.transparent\
Text = \"\"\
AutoWidth = false\
Align = 'Left'\
\
local wrapText = function(text, maxWidth)\
    local lines = {''}\
    for word, space in text:gmatch('(%S+)(%s*)') do\
        local temp = lines[#lines] .. word .. space:gsub('\\n','')\
        if #temp > maxWidth then\
            table.insert(lines, '')\
        end\
        if space:find('\\n') then\
            lines[#lines] = lines[#lines] .. word\
            \
            space = space:gsub('\\n', function()\
                    table.insert(lines, '')\
                    return ''\
            end)\
        else\
            lines[#lines] = lines[#lines] .. word .. space\
        end\
    end\
    if #lines[1] == 0 then\
        table.remove(lines,1)\
    end\
    return lines\
end\
\
OnUpdate = function(self, value)\
    if value == 'Text' then\
        if self.AutoWidth then\
            self.Width = #self.Text\
        else\
            self.Height = #wrapText(self.Text, self.Width)\
        end\
    end\
end\
\
OnDraw = function(self, x, y)\
	for i, v in ipairs(wrapText(self.Text, self.Width)) do\
        local _x = 0\
        if self.Align == 'Right' then\
            _x = self.Width - #v\
        elseif self.Align == 'Center' then\
            _x = math.floor((self.Width - #v) / 2)\
        end\
		Drawing.DrawCharacters(x + _x, y + i - 1, v, self.TextColour, self.BackgroundColour)\
	end\
end\
]],\
[\"ListView\"] = [[\
Inherit = 'ScrollView'\
UpdateDrawBlacklist = {['NeedsItemUpdate']=true}\
\
TextColour = colours.black\
BackgroundColour = colours.white\
HeadingColour = colours.lightGrey\
SelectionBackgroundColour = colours.blue\
SelectionTextColour = colours.white\
Items = false\
CanSelect = false\
Selected = nil\
NeedsItemUpdate = false\
ItemMargin = 1\
HeadingMargin = 0\
TopMargin = 0\
\
OnDraw = function(self, x, y)\
	if self.NeedsItemUpdate then\
		self:UpdateItems()\
	end\
	Drawing.DrawBlankArea(x, y, self.Width, self.Height, self.BackgroundColour)\
end\
\
local function AddItem(self, v, x, y, group)\
	local toggle = false\
	if not self.CanSelect then\
		toggle = nil\
	elseif v.Selected then\
		toggle = true\
	end\
	local item = {\
		[\"Width\"]=self.Width,\
		[\"X\"]=x,\
		[\"Y\"]=y,\
		[\"Name\"]=\"ListViewItem\",\
		[\"Type\"]=\"Button\",\
		[\"TextColour\"]=self.TextColour,\
		[\"BackgroundColour\"]=0,\
		[\"ActiveTextColour\"]=self.SelectionTextColour,\
		[\"ActiveBackgroundColour\"]=self.SelectionBackgroundColour,\
		[\"Align\"]='Left',\
		[\"Toggle\"]=toggle,\
		[\"Group\"]=group,\
		OnClick = function(itm)\
			if self.CanSelect then\
				self:SelectItem(itm)\
			elseif self.OnSelect then\
				self:OnSelect(itm.Text)\
			end\
		end\
    }\
    if type(v) == 'table' then\
    	for k, _v in pairs(v) do\
    		item[k] = _v\
    	end\
    else\
		item.Text = v\
    end\
	\
	local itm = self:AddObject(item)\
	if v.Selected then\
		self:SelectItem(itm)\
	end\
end\
\
UpdateItems = function(self)\
	if not self.Items or type(self.Items) ~= 'table' then\
		self.Items = {}\
	end\
	self.Selected = nil\
	self:RemoveAllObjects()\
	local groupMode = false\
	for k, v in pairs(self.Items) do\
		if type(k) == 'string' then\
			groupMode = true\
			break\
		end\
	end\
\
	if not groupMode then\
		for i, v in ipairs(self.Items) do\
			AddItem(self, v, self.ItemMargin, i)\
		end\
	else\
		local y = self.TopMargin\
		for k, v in pairs(self.Items) do\
			y = y + 1\
			AddItem(self, {Text = k, TextColour = self.HeadingColour, IgnoreClick = true}, self.HeadingMargin, y)\
			for i, _v in ipairs(v) do\
				y = y + 1\
				AddItem(self, _v, 1, y, k)\
			end\
			y = y + 1\
		end\
	end\
	self:UpdateScroll()\
	self.NeedsItemUpdate = false\
end\
\
OnKeyChar = function(self, event, keychar)\
	if keychar == keys.up or keychar == keys.down then\
		local n = self:GetIndex(self.Selected)\
		if keychar == keys.up then\
			n = n - 1\
		else\
			n = n + 1\
		end\
		local new = self:GetNth(n)\
		if new then\
			self:SelectItem(new)\
		end\
	elseif keychar == keys.enter and self.Selected then\
		self.Selected:Click('mouse_click', 1, 1, 1)\
	end\
end\
\
--returns the index/'n' of the given item\
GetIndex = function(self, obj)\
	local n = 1\
	for i, v in ipairs(self.Children) do\
		if not v.IgnoreClick then\
			if obj == v then\
				return n\
			end\
			n = n + 1\
		end\
	end\
end\
\
--gets the 'nth' list item (does not include headings)\
GetNth = function(self, n)\
	local _n = 1\
	for i, v in ipairs(self.Children) do\
		if not v.IgnoreClick then\
			if n == _n then\
				return v\
			end\
			_n = _n + 1\
		end\
	end\
end\
\
SelectItem = function(self, item)\
	for i, v in ipairs(self.Children) do\
		v.Toggle = false\
	end\
	self.Selected = item\
	item.Toggle = true\
	if self.OnSelect then\
		self:OnSelect(item.Text)\
	end\
end\
\
OnUpdate = function(self, value)\
	if value == 'Items' then\
		self.NeedsItemUpdate = true\
	end\
end\
]],\
[\"Menu\"] = [[\
Inherit = 'View'\
\
TextColour = colours.black\
BackgroundColour = colours.white\
HideTop = false\
\
OnDraw = function(self, x, y)\
	Drawing.IgnoreConstraint = true\
	Drawing.DrawBlankArea(x + 1, y + (self.HideTop and 0 or 1), self.Width, self.Height + (self.HideTop and 1 or 0), colours.grey)\
	Drawing.IgnoreConstraint = false\
	Drawing.DrawBlankArea(x, y, self.Width, self.Height, self.BackgroundColour)\
end\
\
OnLoad = function(self)\
	local owner = self.Owner\
	if type(owner) == 'string' then\
		owner = self.Bedrock:GetObject(self.Owner)\
	end\
\
	if owner then\
		if self.X == 0 and self.Y == 0 then\
			local pos = owner:GetPosition()\
			self.X = pos.X\
			self.Y = pos.Y + owner.Height\
		end\
		self.Owner = owner\
	else\
		self.Owner = nil\
	end\
end\
\
OnUpdate = function(self, value)\
	if value == 'Children' then\
		self.Width = self.Bedrock.Helpers.LongestString(self.Children, 'Text') + 2\
		self.Height = #self.Children + 1 + (self.HideTop and 0 or 1)\
		if not self.BaseY then\
			self.BaseY = self.Y\
		end\
\
		for i, v in ipairs(self.Children) do\
			if v.TextColour then\
				v.TextColour = self.TextColour\
			end\
			if v.BackgroundColour then\
				v.BackgroundColour = colours.transparent\
			end\
			if v.Colour then\
				v.Colour = colours.lightGrey\
			end\
			v.Align = 'Left'\
			v.X = 1\
			v.Y = i + (self.HideTop and 0 or 1)\
			v.Width = self.Width\
			v.Height = 1\
		end\
\
		self.Y = self.BaseY\
		local pos = self:GetPosition()\
		if pos.Y + self.Height + 1 > Drawing.Screen.Height then\
			self.Y = self.BaseY - ((self.Height +  pos.Y) - Drawing.Screen.Height)\
		end\
		\
		if pos.X + self.Width > Drawing.Screen.Width then\
			self.X = Drawing.Screen.Width - self.Width\
		end\
	end\
end\
\
Close = function(self, isBedrockCall)\
	self.Bedrock.Menu = nil\
	self.Parent:RemoveObject(self)\
	if self.Owner and self.Owner.Toggle then\
		self.Owner.Toggle = false\
	end\
	self.Parent:ForceDraw()\
	self = nil\
end\
\
OnChildClick = function(self, child, event, side, x, y)\
	self:Close()\
end\
]],\
[\"ProgressBar\"] = [[\
BackgroundColour = colours.lightGrey\
BarColour = colours.blue\
TextColour = colours.white\
ShowText = false\
Value = 0\
Maximum = 1\
Indeterminate = false\
AnimationStep = 0\
\
OnDraw = function(self, x, y)\
	Drawing.DrawBlankArea(x, y, self.Width, self.Height, self.BackgroundColour)\
\
	-- if self.Indeterminate then\
	-- 	for i = 1, self.Width do\
	-- 		local s = x + i - 1 + self.AnimationStep\
	-- 		if s % 4 == 1 or s % 4 == 2 then\
	-- 			Drawing.DrawBlankArea(s, y, 1, self.Height, self.BarColour)\
	-- 		end\
	-- 	end\
	-- 	self.AnimationStep = self.AnimationStep + 1\
	-- 	if self.AnimationStep >= 4 then\
	-- 		self.AnimationStep = 0\
	-- 	end\
	-- 	self.Bedrock:StartTimer(function()\
	-- 		self:Draw()\
	-- 	end, 0.25)\
	-- else\
		local values = self.Value\
		local barColours = self.BarColour\
		if type(values) == 'number' then\
			values = {values}\
		end\
		if type(barColours) == 'number' then\
			barColours = {barColours}\
		end\
		local total = 0\
		local _x = x\
		for i, v in ipairs(values) do\
			local width = self.Bedrock.Helpers.Round((v / self.Maximum) * self.Width)\
			total = total + v\
			Drawing.DrawBlankArea(_x, y, width, self.Height, barColours[((i-1)%#barColours)+1])\
			_x = _x + width\
		end\
\
		if self.ShowText then\
			local text = self.Bedrock.Helpers.Round((total / self.Maximum) * 100) .. '%'\
			Drawing.DrawCharactersCenter(x, y, self.Width, self.Height, text, self.TextColour, colours.transparent)\
		end\
	-- end\
end\
]],\
[\"ScrollBar\"] = [[\
BackgroundColour = colours.lightGrey\
BarColour = colours.lightBlue\
Scroll = 0\
MaxScroll = 0\
ClickPoint = nil\
Fixed = true\
\
OnUpdate = function(self, value)\
	if value == 'Text' and self.AutoWidth then\
		self.Width = #self.Text + 2\
	end\
end\
\
OnDraw = function(self, x, y)\
	local barHeight = self.Height * (self.Height / (self.Height + self.MaxScroll))\
    if barHeight < 3 then\
      barHeight = 3\
    end\
    local percentage = (self.Scroll/self.MaxScroll)\
\
    Drawing.DrawBlankArea(x, y, self.Width, self.Height, self.BackgroundColour)\
    Drawing.DrawBlankArea(x, y + math.ceil(self.Height*percentage - barHeight*percentage), self.Width, barHeight, self.BarColour)\
end\
\
OnScroll = function(self, event, direction, x, y)\
	if event == 'mouse_scroll' then\
		direction = self.Bedrock.Helpers.Round(direction * 3)\
	end\
	if self.Scroll < 0 or self.Scroll > self.MaxScroll then\
		return false\
	end\
	local old = self.Scroll\
	self.Scroll = self.Bedrock.Helpers.Round(self.Scroll + direction)\
	if self.Scroll < 0 then\
		self.Scroll = 0\
	elseif self.Scroll > self.MaxScroll then\
		self.Scroll = self.MaxScroll\
	end\
\
	if self.Scroll ~= old and self.OnChange then\
		self:OnChange()\
	end\
end\
\
OnClick = function(self, event, side, x, y)\
	if event == 'mouse_click' then\
		self.ClickPoint = y\
	else\
		local gapHeight = self.Height - (self.Height * (self.Height / (self.Height + self.MaxScroll)))\
		local barHeight = self.Height * (self.Height / (self.Height + self.MaxScroll))\
		--local delta = (self.Height + self.MaxScroll) * ((y - self.ClickPoint) / barHeight)\
		local delta = ((y - self.ClickPoint)/gapHeight)*self.MaxScroll\
		--l(((y - self.ClickPoint)/gapHeight))\
		--l(delta)\
		self.Scroll = self.Bedrock.Helpers.Round(delta)\
		--l(self.Scroll)\
		--l('----')\
		if self.Scroll < 0 then\
			self.Scroll = 0\
		elseif self.Scroll > self.MaxScroll then\
			self.Scroll = self.MaxScroll\
		end\
		if self.OnChange then\
			self:OnChange()\
		end\
	end\
\
	local relScroll = self.MaxScroll * ((y-1)/self.Height)\
	if y == self.Height then\
		relScroll = self.MaxScroll\
	end\
	self.Scroll = self.Bedrock.Helpers.Round(relScroll)\
\
\
end\
\
OnDrag = OnClick\
]],\
[\"ScrollView\"] = [[\
Inherit = 'View'\
ChildOffset = false\
ContentWidth = 0\
ContentHeight = 0\
\
CalculateContentSize = function(self)\
	local function calculateObject(obj)\
		local pos = obj:GetPosition()\
		local x2 = pos.X + obj.Width - 1\
		local y2 = pos.Y + obj.Height - 1\
		if obj.Children then\
			for i, child in ipairs(obj.Children) do\
				local _x2, _y2 = calculateObject(child)\
				if _x2 > x2 then\
					x2 = _x2\
				end\
				if _y2 > y2 then\
					y2 = _y2\
				end\
			end\
		end\
		return x2, y2\
	end\
\
	local pos = self:GetPosition()\
	local x2, y2 = calculateObject(self)\
	self.ContentWidth = x2 - pos.X + 1\
	self.ContentHeight = y2 - pos.Y + 1\
end\
\
UpdateScroll = function(self)\
	self.ChildOffset.Y = 0\
	self:CalculateContentSize()\
	if self.ContentHeight > self.Height then\
		if not self:GetObject('ScrollViewScrollBar') then\
			local _scrollBar = self:AddObject({\
				[\"Name\"] = 'ScrollViewScrollBar',\
				[\"Type\"] = 'ScrollBar',\
				[\"X\"] = self.Width,\
				[\"Y\"] = 1,\
				[\"Width\"] = 1,\
				[\"Height\"] = self.Height,\
				[\"Z\"]=999\
			})\
\
			_scrollBar.OnChange = function(scrollBar)\
				self.ChildOffset.Y = -scrollBar.Scroll\
				for i, child in ipairs(self.Children) do\
					child:ForceDraw()\
				end\
			end\
		end\
		self:GetObject('ScrollViewScrollBar').MaxScroll = self.ContentHeight - self.Height\
	else\
		self:RemoveObject('ScrollViewScrollBar')\
	end\
end\
\
OnScroll = function(self, event, direction, x, y)\
	if self:GetObject('ScrollViewScrollBar') then\
		self:GetObject('ScrollViewScrollBar'):OnScroll(event, direction, x, y)\
	end\
end\
\
OnLoad = function(self)\
	if not self.ChildOffset or not self.ChildOffset.X or not self.ChildOffset.Y then\
		self.ChildOffset = {X = 0, Y = 0}\
	end\
end\
]],\
[\"SecureTextBox\"] = [[\
Inherit = 'TextBox'\
MaskCharacter = '*'\
\
OnDraw = function(self, x, y)\
	Drawing.DrawBlankArea(x, y, self.Width, self.Height, self.BackgroundColour)\
	if self.CursorPos > #self.Text then\
		self.CursorPos = #self.Text\
	elseif self.CursorPos < 0 then\
		self.CursorPos = 0\
	end\
	local text = ''\
\
	for i = 1, #self.Text do\
		text = text .. self.MaskCharacter\
	end\
\
	if self.Bedrock:GetActiveObject() == self then\
		if #text > (self.Width - 2) then\
			text = text:sub(#text-(self.Width - 3))\
			self.Bedrock.CursorPos = {x + 1 + self.Width-2, y}\
		else\
			self.Bedrock.CursorPos = {x + 1 + self.CursorPos, y}\
		end\
		self.Bedrock.CursorColour = self.TextColour\
	end\
\
	if #tostring(text) == 0 then\
		Drawing.DrawCharacters(x + 1, y, self.Placeholder, self.PlaceholderTextColour, self.BackgroundColour)\
	else\
		if not self.Selected then\
			Drawing.DrawCharacters(x + 1, y, text, self.TextColour, self.BackgroundColour)\
		else\
			for i = 1, #text do\
				local char = text:sub(i, i)\
				local textColour = self.TextColour\
				local backgroundColour = self.BackgroundColour\
				if i > self.DragStart and i - 1 <= self.CursorPos then\
					textColour = self.SelectedTextColour\
					backgroundColour = self.SelectedBackgroundColour\
				end\
				Drawing.DrawCharacters(x + i, y, char, textColour, backgroundColour)\
			end\
		end\
	end\
end\
]],\
[\"Separator\"] = [[\
Colour = colours.grey\
\
OnDraw = function(self, x, y)\
	local char = \"|\"\
	if self.Width > self.Height then\
		char = '-'\
	end\
	Drawing.DrawArea(x, y, self.Width, self.Height, char, self.Colour, colours.transparent)\
end\
]],\
[\"TextBox\"] = [[\
BackgroundColour = colours.lightGrey\
SelectedBackgroundColour = colours.blue\
SelectedTextColour = colours.white\
TextColour = colours.black\
PlaceholderTextColour = colours.grey\
Placeholder = ''\
AutoWidth = false\
Text = \"\"\
CursorPos = nil\
Numerical = false\
DragStart = nil\
Selected = false\
SelectOnClick = false\
ActualDragStart = nil\
\
OnDraw = function(self, x, y)\
	Drawing.DrawBlankArea(x, y, self.Width, self.Height, self.BackgroundColour)\
	if self.CursorPos > #self.Text then\
		self.CursorPos = #self.Text\
	elseif self.CursorPos < 0 then\
		self.CursorPos = 0\
	end\
	local text = self.Text\
	local offset = self:TextOffset()\
	if #text > (self.Width - 2) then\
		text = text:sub(offset+1, offset + self.Width - 2)\
		-- self.Bedrock.CursorPos = {x + 1 + self.Width-2, y}\
	-- else\
	end\
	if self.Bedrock:GetActiveObject() == self then\
		self.Bedrock.CursorPos = {x + 1 + self.CursorPos - offset, y}\
		self.Bedrock.CursorColour = self.TextColour\
	else\
		self.Selected = false\
	end\
\
	if #tostring(text) == 0 then\
		Drawing.DrawCharacters(x + 1, y, self.Placeholder, self.PlaceholderTextColour, self.BackgroundColour)\
	else\
		if not self.Selected then\
			Drawing.DrawCharacters(x + 1, y, text, self.TextColour, self.BackgroundColour)\
		else\
			local startPos = self.DragStart - offset\
			local endPos = self.CursorPos - offset\
			if startPos > endPos then\
				startPos = self.CursorPos - offset\
				endPos = self.DragStart - offset\
			end\
			for i = 1, #text do\
				local char = text:sub(i, i)\
				local textColour = self.TextColour\
				local backgroundColour = self.BackgroundColour\
\
				if i > startPos and i - 1 <= endPos then\
					textColour = self.SelectedTextColour\
					backgroundColour = self.SelectedBackgroundColour\
				end\
				Drawing.DrawCharacters(x + i, y, char, textColour, backgroundColour)\
			end\
		end\
	end\
end\
\
TextOffset = function(self)\
	if #self.Text < (self.Width - 2) then\
		return 0\
	elseif self.Bedrock:GetActiveObject() ~= self then\
		return 0\
	else\
		local textWidth = (self.Width - 2)\
		local offset = self.CursorPos - textWidth\
		if offset < 0 then\
			offset = 0\
		end\
		return offset\
	end\
end\
\
OnLoad = function(self)\
	if not self.CursorPos then\
		self.CursorPos = #self.Text\
	end\
end\
\
OnClick = function(self, event, side, x, y)\
	if self.Bedrock:GetActiveObject() ~= self and self.SelectOnClick then\
		self.CursorPos = #self.Text - 1\
		self.DragStart = 0\
		self.ActualDragStart = x - 2 + self:TextOffset()\
		self.Selected = true\
	else\
		self.CursorPos = x - 2 + self:TextOffset()\
		self.DragStart = self.CursorPos\
		self.Selected = false\
	end\
	self.Bedrock:SetActiveObject(self)\
end\
\
OnDrag = function(self, event, side, x, y)\
	self.CursorPos = x - 2 + self:TextOffset()\
	if self.ActualDragStart then\
		self.DragStart = self.ActualDragStart\
		self.ActualDragStart = nil\
	end\
	if self.DragStart then\
		self.Selected = true\
	end\
end\
\
OnKeyChar = function(self, event, keychar)\
	local deleteSelected = function()\
		if self.Selected then\
			local startPos = self.DragStart\
			local endPos = self.CursorPos\
			if startPos > endPos then\
				startPos = self.CursorPos\
				endPos = self.DragStart\
			end\
			self.Text = self.Text:sub(1, startPos) .. self.Text:sub(endPos + 2)\
			self.CursorPos = startPos\
			self.DragStart = nil\
			self.Selected = false\
			return true\
		end\
	end\
\
	if event == 'char' then\
		deleteSelected()\
		if self.Numerical then\
			keychar = tostring(tonumber(keychar))\
		end\
		if keychar == 'nil' then\
			return\
		end\
		self.Text = string.sub(self.Text, 1, self.CursorPos ) .. keychar .. string.sub( self.Text, self.CursorPos + 1 )\
		if self.Numerical then\
			self.Text = tostring(tonumber(self.Text))\
			if self.Text == 'nil' then\
				self.Text = '1'\
			end\
		end\
		\
		self.CursorPos = self.CursorPos + 1\
		if self.OnChange then\
			self:OnChange(event, keychar)\
		end\
		return false\
	elseif event == 'key' then\
		if keychar == keys.enter then\
			if self.OnChange then\
				self:OnChange(event, keychar)\
			end\
		elseif keychar == keys.left then\
			-- Left\
			if self.CursorPos > 0 then\
				if self.Selected then\
					self.CursorPos = self.DragStart\
					self.DragStart = nil\
					self.Selected = false\
				else\
					self.CursorPos = self.CursorPos - 1\
				end\
				if self.OnChange then\
					self:OnChange(event, keychar)\
				end\
			end\
			\
		elseif keychar == keys.right then\
			-- Right				\
			if self.CursorPos < string.len(self.Text) then\
				if self.Selected then\
					self.CursorPos = self.CursorPos\
					self.DragStart = nil\
					self.Selected = false\
				else\
					self.CursorPos = self.CursorPos + 1\
				end\
				if self.OnChange then\
					self:OnChange(event, keychar)\
				end\
			end\
		\
		elseif keychar == keys.backspace then\
			-- Backspace\
			if not deleteSelected() and self.CursorPos > 0 then\
				self.Text = string.sub( self.Text, 1, self.CursorPos - 1 ) .. string.sub( self.Text, self.CursorPos + 1 )\
				self.CursorPos = self.CursorPos - 1					\
				if self.Numerical then\
					self.Text = tostring(tonumber(self.Text))\
					if self.Text == 'nil' then\
						self.Text = '1'\
					end\
				end\
				if self.OnChange then\
					self:OnChange(event, keychar)\
				end\
			end\
		elseif keychar == keys.home then\
			-- Home\
			self.CursorPos = 0\
			if self.OnChange then\
				self:OnChange(event, keychar)\
			end\
		elseif keychar == keys.delete then\
			if not deleteSelected() and self.CursorPos < string.len(self.Text) then\
				self.Text = string.sub( self.Text, 1, self.CursorPos ) .. string.sub( self.Text, self.CursorPos + 2 )		\
				if self.Numerical then\
					self.Text = tostring(tonumber(self.Text))\
					if self.Text == 'nil' then\
						self.Text = '1'\
					end\
				end\
				if self.OnChange then\
					self:OnChange(keychar)\
				end\
			end\
		elseif keychar == keys[\"end\"] then\
			-- End\
			self.CursorPos = string.len(self.Text)\
		else\
			if self.OnChange then\
				self:OnChange(event, keychar)\
			end\
			return false\
		end\
	end\
end\
]],\
[\"View\"] = [[\
BackgroundColour = colours.transparent\
Children = {}\
\
OnDraw = function(self, x, y)\
	if self.BackgroundColour then\
		Drawing.DrawBlankArea(x, y, self.Width, self.Height, self.BackgroundColour)\
	end\
end\
\
OnInitialise = function(self)\
	self.Children = {}\
end\
\
InitialiseFile = function(self, bedrock, file, name)\
	local _new = {}\
	_new.X = 1\
	_new.Y = 1\
	_new.Width = Drawing.Screen.Width\
	_new.Height = Drawing.Screen.Height\
	_new.BackgroundColour = file.BackgroundColour\
	_new.Name = name\
	_new.Children = {}\
	_new.Bedrock = bedrock\
	local new = self:Initialise(_new)\
	for i, obj in ipairs(file.Children) do\
		local view = bedrock:ObjectFromFile(obj, new)\
		if not view.Z then\
			view.Z = i\
		end\
		view.Parent = new\
		table.insert(new.Children, view)\
	end\
	return new\
end\
\
function CheckClick(self, object, x, y)\
	local offset = {X = 0, Y = 0}\
	if not object.Fixed and self.ChildOffset then\
		offset = self.ChildOffset\
	end\
	if object.X + offset.X <= x and object.Y + offset.Y <= y and  object.X + offset.X + object.Width > x and object.Y + offset.Y + object.Height > y then\
		return true\
	end\
end\
\
function DoClick(self, object, event, side, x, y)\
	if object then\
		if self:CheckClick(object, x, y) then\
			local offset = {X = 0, Y = 0}\
			if not object.Fixed and self.ChildOffset then\
				offset = self.ChildOffset\
			end\
			return object:Click(event, side, x - object.X - offset.X + 1, y - object.Y + 1 - offset.Y)\
		end\
	end	\
end\
\
Click = function(self, event, side, x, y, z)\
	if self.Visible and not self.IgnoreClick then\
		for i = #self.Children, 1, -1 do --children are ordered from smallest Z to highest, so this is done in reverse\
			local child = self.Children[i]\
			if self:DoClick(child, event, side, x, y) then\
				if self.OnChildClick then\
					self:OnChildClick(child, event, side, x, y)\
				end\
				return true\
			end\
		end\
		if event == 'mouse_click' and self.OnClick and self:OnClick(event, side, x, y) ~= false then\
			return true\
		elseif event == 'mouse_drag' and self.OnDrag and self:OnDrag(event, side, x, y) ~= false then\
			return true\
		elseif event == 'mouse_scroll' and self.OnScroll and self:OnScroll(event, side, x, y) ~= false then\
			return true\
		else\
			return false\
		end\
	else\
		return false\
	end\
end\
\
OnRemove = function(self)\
	if self == self.Bedrock:GetActiveObject() then\
		self.Bedrock:SetActiveObject()\
	end\
	for i, child in ipairs(self.Children) do\
		child:OnRemove()\
	end\
end\
\
local function findObjectNamed(view, name, minI)\
	local minI = minI or 0\
	if view and view.Children then\
		for i, child in ipairs(view.Children) do\
			if child.Name == name or child == name then\
				return child, i, view\
			elseif child.Children then\
				local found, index, foundView = findObjectNamed(child, name)\
				if found and minI <= index then\
					return found, index, foundView\
				end\
			end\
		end\
	end\
end\
\
function AddObject(self, info, extra)\
	if type(info) == 'string' then\
		local h = fs.open(self.Bedrock.ViewPath..info..'.view', 'r')\
		if h then\
			info = textutils.unserialize(h.readAll())\
			h.close()\
		else\
			error('Error in opening object: '..info)\
		end\
	end\
\
	if extra then\
		for k, v in pairs(extra) do\
			if v then\
				info[k] = v\
			end\
		end\
	end\
\
	local view = self.Bedrock:ObjectFromFile(info, self)\
	if not view.Z then\
		view.Z = #self.Children + 1\
	end\
	\
	table.insert(self.Children, view)\
	if self.Bedrock.View then\
		self.Bedrock:ReorderObjects()\
	end\
	self:ForceDraw()\
	return view\
end\
\
function GetObject(self, name)\
	return findObjectNamed(self, name)\
end\
\
local function findObjects(view, name)\
	local objects = {}\
	if view and view.Children then\
		for i, child in ipairs(view.Children) do\
			if child.Name == name or child == name then\
				table.insert(objects, child)\
			elseif child.Children then\
				local objs = findObjects(child, name)\
				if objs then\
					for i2, v in ipairs(objs) do\
						table.insert(objects, v)\
					end\
				end\
			end\
		end\
	end\
	return objects\
end\
\
function GetObjects(self, name)\
	return findObjects(self, name)\
end\
\
function RemoveObject(self, name)\
	local obj, index, view = findObjectNamed(self, name, minI)\
	if index then\
		view.Children[index]:OnRemove()\
		table.remove(view.Children, index)\
		if view.OnUpdate then\
			view:OnUpdate('Children')\
		end\
		return true\
	end\
	return false\
end\
\
function RemoveObjects(self, name)\
	local i = 1\
	while self:RemoveObject(name) and i < 100 do\
		i = i + 1\
	end\
	\
end\
\
function RemoveAllObjects(self)\
	for i, child in ipairs(self.Children) do\
		child:OnRemove()\
		self.Children[i] = nil\
	end\
	self:ForceDraw()\
end\
]],\
[\"Window\"] = [[\
Inherit = 'View'\
\
ToolBarColour = colours.lightGrey\
ToolBarTextColour = colours.black\
ShadowColour = colours.grey\
Title = ''\
Flashing = false\
CanClose = true\
OnCloseButton = nil\
\
OnLoad = function(self)\
	--self:GetObject('View') = self.Bedrock:ObjectFromFile({Type = 'View',Width = 10, Height = 5, BackgroundColour = colours.red}, self)\
end\
\
LoadView = function(self)\
	local view = self:GetObject('View')\
	if view.ToolBarColour then\
		window.ToolBarColour = view.ToolBarColour\
	end\
	if view.ToolBarTextColour then\
		window.ToolBarTextColour = view.ToolBarTextColour\
	end\
	view.X = 1\
	view.Y = 2\
\
	view:ForceDraw()\
	self:OnUpdate('View')\
	if self.OnViewLoad then\
		self.OnViewLoad(view)\
	end\
	self.Bedrock:SetActiveObject(view)\
end\
\
SetView = function(self, view)\
	self:RemoveObject('View')\
	table.insert(self.Children, view)\
	view.Parent = self\
	self:LoadView()\
end\
\
Flash = function(self)\
	self.Flashing = true\
	self:ForceDraw()\
	self.Bedrock:StartTimer(function()self.Flashing = false end, 0.4)\
end\
\
OnDraw = function(self, x, y)\
	local toolBarColour = (self.Flashing and colours.white or self.ToolBarColour)\
	local toolBarTextColour = (self.Flashing and colours.black or self.ToolBarTextColour)\
	if toolBarColour then\
		Drawing.DrawBlankArea(x, y, self.Width, 1, toolBarColour)\
	end\
	if toolBarTextColour then\
		local title = self.Bedrock.Helpers.TruncateString(self.Title, self.Width - 2)\
		Drawing.DrawCharactersCenter(self.X, self.Y, self.Width, 1, title, toolBarTextColour, toolBarColour)\
	end\
	Drawing.IgnoreConstraint = true\
	Drawing.DrawBlankArea(x + 1, y + 1, self.Width, self.Height, self.ShadowColour)\
	Drawing.IgnoreConstraint = false\
end\
\
Close = function(self)\
	self.Bedrock.Window = nil\
	self.Bedrock:RemoveObject(self)\
	if self.OnClose then\
		self:OnClose()\
	end\
	self = nil\
end\
\
OnUpdate = function(self, value)\
	if value == 'View' and self:GetObject('View') then\
		self.Width = self:GetObject('View').Width\
		self.Height = self:GetObject('View').Height + 1\
		self.X = math.ceil((Drawing.Screen.Width - self.Width) / 2)\
		self.Y = math.ceil((Drawing.Screen.Height - self.Height) / 2)\
	elseif value == 'CanClose' then\
		self:RemoveObject('CloseButton')\
		if self.CanClose then\
			local button = self:AddObject({X = 1, Y = 1, Width = 1, Height = 1, Type = 'Button', BackgroundColour = colours.red, TextColour = colours.white, Text = 'x', Name = 'CloseButton'})\
			button.OnClick = function(btn)\
				if self.OnCloseButton then\
					self:OnCloseButton()\
				end\
				self:Close()\
			end\
		end\
	end\
end\
]],\
}\
\
BasePath = ''\
ProgramPath = nil\
\
-- Program functions...\
\
local function main(...)\
	-- Code here...\
end\
\
-- Run\
local args = {...}\
local _, err = pcall(function() main(unpack(args)) end)\
if err then\
	-- Make a nice error handling screen here...\
	term.setBackgroundColor(colors.black)\
	term.setTextColor(colors.white)\
	term.clear()\
	term.setCursorPos(1, 3)\
	print(\" An Error Has Occured! D:\\n\\n\")\
	print(\" \" .. tostring(err) .. \"\\n\\n\")\
	print(\" Press any key to exit...\")\
	os.pullEvent(\"key\")\
end\
\
\
\
function LoadAPIs(self)\
	local function loadAPI(name, content)\
		local env = setmetatable({}, { __index = getfenv() })\
		local func, err = loadstring(content, name..' (Bedrock API)')\
		if not func then\
			return false, printError(err)\
		end\
		setfenv(func, env)\
		func()\
		local api = {}\
		for k,v in pairs(env) do\
			api[k] = v\
		end\
		_G[name] = api\
		return true\
	end\
\
	local env = getfenv()\
	local function loadObject(name, content)\
		loadAPI(name, content)\
		if env[name].Inherit then\
			if not getfenv()[env[name].Inherit] then	\
				if objects[env[name].Inherit] then\
					loadObject(env[name].Inherit, objects[env[name].Inherit])\
				elseif fs.exists(self.ProgramPath..'/Objects/'..env[name].Inherit..'.lua') then\
				end\
			end\
			env[name].__index = getfenv()[env[name].Inherit]\
		else\
			env[name].__index = Object\
		end\
		setmetatable(env[name], env[name])\
	end\
\
	for k, v in pairs(apis) do\
		loadAPI(k, v)\
		if k == 'Helpers' then\
			self.Helpers = Helpers\
		end\
	end\
\
	for k, v in pairs(objects) do\
		loadObject(k, v)\
	end\
	\
	local privateObjPath = self.ProgramPath..'/Objects/'\
	if fs.exists(privateObjPath) and fs.isDir(privateObjPath) then\
		for i, v in ipairs(fs.list(privateObjPath)) do\
			if v ~= '.DS_Store' then\
				local name = string.match(v, '(%a+)%.?.-')\
				local h = fs.open(privateObjPath..v, 'r')\
				loadObject(name, h.readAll())\
				h.close()\
			end\
		end\
	end\
end\
\
AllowTerminate = true\
\
View = nil\
Menu = nil\
\
ActiveObject = nil\
\
DrawTimer = nil\
DrawTimerExpiry = 0\
\
IsDrawing = false\
\
Running = true\
\
DefaultView = 'main'\
\
EventHandlers = {\
	\
}\
\
ObjectClickHandlers = {\
	\
}\
\
ObjectUpdateHandlers = {\
	\
}\
\
Timers = {\
	\
}\
\
function Initialise(self, programPath)\
	self.ProgramPath = programPath or self.ProgramPath\
	if not programPath then\
		if self.ProgramPath then\
			local prgPath = self.ProgramPath\
			local prgName = fs.getName(prgPath)\
			if prgPath:find('/') then \
				self.ProgramPath = prgPath:sub(1, #prgPath-#prgName-1)\
				self.ProgramPath = prgPath:sub(1, #prgPath-#prgName-1) \
			else \
		 		self.ProgramPath = '' \
		 	end\
		else\
			self.ProgramPath = ''\
		end\
	end\
	self:LoadAPIs()\
	self.ViewPath = self.ProgramPath .. '/Views/'\
	--first, check that the barebones APIs are available\
	local requiredApis = {\
		'Drawing',\
		'View'\
	}\
	local env = getfenv()\
	for i,v in ipairs(requiredApis) do\
		if not env[v] then\
			error('The API: '..v..' is not loaded. Please make sure you load it to use Bedrock.')\
		end\
	end\
\
	local copy = { }\
	for k, v in pairs(self) do\
		if k ~= 'Initialise' then\
			copy[k] = v\
		end\
	end\
	return setmetatable(copy, getmetatable(self))\
end\
\
function HandleClick(self, event, side, x, y)\
	if self.Window then\
		if not self.View:CheckClick(self.Window, x, y) then\
			self.Window:Flash()\
		else\
			self.View:DoClick(self.Window, event, side, x, y)\
		end\
	elseif self.Menu then\
		if not self.View:DoClick(self.Menu, event, side, x, y) then\
			self.Menu:Close()\
		end\
	elseif self.View then\
		if self.View:Click(event, side, x, y) ~= false then\
		end		\
	end\
end\
\
function HandleKeyChar(self, event, keychar)\
	if self:GetActiveObject() then\
		local activeObject = self:GetActiveObject()\
		if activeObject.OnKeyChar then\
			if activeObject:OnKeyChar(event, keychar) ~= false then\
				--self:Draw()\
			end\
		end\
	end\
end\
\
function ToggleMenu(self, name, owner, x, y)\
	if self.Menu then\
		self.Menu:Close()\
		return false\
	else\
		self:SetMenu(name, owner, x, y)\
		return true\
	end\
end\
\
function SetMenu(self, menu, owner, x, y)\
	x = x or 1\
	y = y or 1\
	if self.Menu then\
		self.Menu:Close()\
	end	\
	if menu then\
		local pos = owner:GetPosition()\
		self.Menu = self:AddObject(menu, {Type = 'Menu', Owner = owner, X = pos.X + x - 1, Y = pos.Y + y})\
	end\
end\
\
function ObjectClick(self, name, func)\
	self.ObjectClickHandlers[name] = func\
end\
\
function ClickObject(self, object, event, side, x, y)\
	if self.ObjectClickHandlers[object.Name] then\
		return self.ObjectClickHandlers[object.Name](object, event, side, x, y)\
	end\
	return false\
end\
\
function ObjectUpdate(self, name, func)\
	self.ObjectUpdateHandlers[name] = func\
end\
\
function UpdateObject(self, object, ...)\
	if self.ObjectUpdateHandlers[object.Name] then\
		self.ObjectUpdateHandlers[object.Name](object, ...)\
		--self:Draw()\
	end\
end\
\
function GetAbsolutePosition(self, obj)\
	if not obj.Parent then\
		return {X = obj.X, Y = obj.Y}\
	else\
		local pos = self:GetAbsolutePosition(obj.Parent)\
		local x = pos.X + obj.X - 1\
		local y = pos.Y + obj.Y - 1\
		if not obj.Fixed and obj.Parent.ChildOffset then\
			x = x + obj.Parent.ChildOffset.X\
			y = y + obj.Parent.ChildOffset.Y\
		end\
		return {X = x, Y = y}\
	end\
end\
\
function LoadView(self, name, draw)\
	if self.View and self.OnViewClose then\
		self.OnViewClose(self.View.Name)\
	end\
	if self.View then\
		self.View:OnRemove()\
	end\
	local success = false\
\
	if not fs.exists(self.ViewPath..name..'.view') then\
		error('The view: '..name..'.view does not exist.')\
	end\
\
	local h = fs.open(self.ViewPath..name..'.view', 'r')\
	if h then\
		local view = textutils.unserialize(h.readAll())\
		h.close()\
		if view then\
			self.View = View:InitialiseFile(self, view, name)\
			self:ReorderObjects()\
\
			if OneOS and view.ToolBarColour then\
				OneOS.ToolBarColour = view.ToolBarColour\
			end\
			if OneOS and view.ToolBarTextColour then\
				OneOS.ToolBarTextColour = view.ToolBarTextColour\
			end\
			if not self:GetActiveObject() then\
				self:SetActiveObject()\
			end\
			success = true\
		end\
	end\
\
	if success and self.OnViewLoad then\
		self.OnViewLoad(name)\
	end\
\
	if draw ~= false then\
		self:Draw()\
	end\
\
	if not success then\
		error('Failed to load view: '..name..'. It probably isn\\'t formatted correctly. Did you forget a } or ,?')\
	end\
\
	return success\
end\
\
function InheritFile(self, file, name)\
	local h = fs.open(self.ViewPath..name..'.view', 'r')\
	if h then\
		local super = textutils.unserialize(h.readAll())\
		if super then\
			if type(super) ~= 'table' then\
				error('View: \"'..name..'.view\" is not formatted correctly.')\
			end\
\
			for k, v in pairs(super) do\
				if not file[k] then\
					file[k] = v\
				end\
			end\
			return file\
		end\
	end\
	return file\
end\
\
function ParseStringSize(self, parent, k, v)\
		local parentSize = parent.Width\
		if k == 'Height' or k == 'Y' then\
			parentSize = parent.Height\
		end\
		local parts = {v}\
		if type(v) == 'string' and string.find(v, ',') then\
			parts = {}\
			for word in string.gmatch(v, '([^,]+)') do\
			    table.insert(parts, word)\
			end\
		end\
\
		v = 0\
		for i2, part in ipairs(parts) do\
			if type(part) == 'string' and part:sub(#part) == '%' then\
				v = v + math.ceil(parentSize * (tonumber(part:sub(1, #part-1)) / 100))\
			else\
				v = v + tonumber(part)\
			end\
		end\
		return v\
end\
\
function ObjectFromFile(self, file, view)\
	local env = getfenv()\
	if env[file.Type] then\
		if not env[file.Type].Initialise then\
			error('Malformed Object: '..file.Type)\
		end\
		local object = {}\
\
		if file.InheritView then\
			file = self:InheritFile(file, file.InheritView)\
		end\
		\
		object.AutoWidth = true\
		for k, v in pairs(file) do\
			if k == 'Width' or k == 'X' or k == 'Height' or k == 'Y' then\
				v = self:ParseStringSize(view, k, v)\
			end\
\
			if k == 'Width' then\
				object.AutoWidth = false\
			end\
			if k ~= 'Children' then\
				object[k] = v\
			else\
				object[k] = {}\
			end\
		end\
\
		object.Parent = view\
		object.Bedrock = self\
		if not object.Name then\
			object.Name = file.Type\
		end\
\
		object = env[file.Type]:Initialise(object)\
\
		if file.Children then\
			for i, obj in ipairs(file.Children) do\
				local _view = self:ObjectFromFile(obj, object)\
				if not _view.Z then\
					_view.Z = i\
				end\
				_view.Parent = object\
				table.insert(object.Children, _view)\
			end\
		end\
\
		if not object.OnClick then\
			object.OnClick = function(...) return self:ClickObject(...) end\
		end\
		--object.OnUpdate = function(...) self:UpdateObject(...) end\
\
		if object.OnUpdate then\
			for k, v in pairs(env[file.Type]) do\
				object:OnUpdate(k)\
			end\
\
			for k, v in pairs(object.__index) do\
				object:OnUpdate(k)\
			end\
		end\
\
		if object.Active then\
			object.Bedrock:SetActiveObject(object)\
		end\
		if object.OnLoad then\
			object:OnLoad()\
		end\
		return object\
	elseif not file.Type then\
		error('No object type specified. (e.g. Type = \"Button\")')\
	else\
		error('No Object: '..file.Type..'. The API probably isn\\'t loaded')\
	end\
end\
\
function ReorderObjects(self)\
	if self.View and self.View.Children then\
		table.sort(self.View.Children, function(a,b)\
			return a.Z < b.Z \
		end)\
	end\
end\
\
function AddObject(self, info, extra)\
	return self.View:AddObject(info, extra)\
end\
\
function GetObject(self, name)\
	return self.View:GetObject(name)\
end\
\
function GetObjects(self, name)\
	return self.View:GetObjects(name)\
end\
\
function RemoveObject(self, name)\
	return self.View:RemoveObject(name)\
end\
\
function RemoveObjects(self, name)\
	return self.View:RemoveObjects(name)\
end\
\
function ForceDraw(self)\
	if not self.DrawTimer or self.DrawTimerExpiry <= os.clock() then\
		self.DrawTimer = self:StartTimer(function()\
			self.DrawTimer = nil\
			self:Draw()\
		end, 0.05)\
		self.DrawTimerExpiry = os.clock() + 0.1\
	end\
end\
\
function DisplayWindow(self, _view, title, canClose)\
	if canClose == nil then\
		canClose = true\
	end\
	if type(_view) == 'string' then\
		local h = fs.open(self.ViewPath.._view..'.view', 'r')\
		if h then\
			_view = textutils.unserialize(h.readAll())\
			h.close()\
		end\
	end\
\
	self.Window = self:AddObject({Type = 'Window', Z = 999, Title = title, CanClose = canClose})\
	_view.Type = 'View'\
	_view.Name = 'View'\
	_view.BackgroundColour = _view.BackgroundColour or colours.white\
	self.Window:SetView(self:ObjectFromFile(_view, self.Window))\
end\
\
function DisplayAlertWindow(self, title, text, buttons, callback)\
	local func = function(btn)\
		self.Window:Close()\
		if callback then\
			callback(btn.Text)\
		end\
	end\
	local children = {}\
	local usedX = -1\
	if buttons then\
		for i, text in ipairs(buttons) do\
			usedX = usedX + 3 + #text\
			table.insert(children, {\
				[\"Y\"]=\"100%,-1\",\
				[\"X\"]=\"100%,-\"..usedX,\
				[\"Name\"]=text..\"Button\",\
				[\"Type\"]=\"Button\",\
				[\"Text\"]=text,\
				OnClick = func\
			})\
		end\
	end\
\
	local width = usedX + 2\
	if width < 28 then\
		width = 28\
	end\
\
	local canClose = true\
	if buttons and #buttons~=0 then\
		canClose = false\
	end\
\
	local height = 0\
	if text then\
		height = #Helpers.WrapText(text, width - 2)\
		table.insert(children, {\
			[\"Y\"]=2,\
			[\"X\"]=2,\
			[\"Width\"]=\"100%,-2\",\
			[\"Height\"]=height,\
			[\"Name\"]=\"Label\",\
			[\"Type\"]=\"Label\",\
			[\"Text\"]=text\
		})\
	end\
	local view = {\
		Children = children,\
		Width=width,\
		Height=3+height+(canClose and 0 or 1),\
		OnKeyChar = function(_view, keychar)\
			func({Text=buttons[1]})\
		end\
	}\
	self:DisplayWindow(view, title, canClose)\
end\
\
function DisplayTextBoxWindow(self, title, text, callback, textboxText, cursorAtEnd)\
	textboxText = textboxText or ''\
	local func = function(btn)\
		self.Window:Close()\
		if callback then\
			callback(btn.Text)\
		end\
	end\
	local children = {\
		{\
			[\"Y\"]=\"100%,-1\",\
			[\"X\"]=\"100%,-4\",\
			[\"Name\"]=\"OkButton\",\
			[\"Type\"]=\"Button\",\
			[\"Text\"]=\"Ok\",\
			OnClick = function()\
				local text = self.Window:GetObject('TextBox').Text\
				self.Window:Close()\
				callback(true, text)\
			end\
		},\
		{\
			[\"Y\"]=\"100%,-1\",\
			[\"X\"]=\"100%,-13\",\
			[\"Name\"]=\"CancelButton\",\
			[\"Type\"]=\"Button\",\
			[\"Text\"]=\"Cancel\",\
			OnClick = function()\
				self.Window:Close()\
				callback(false)\
			end\
		}\
	}\
\
	local height = -1\
	if text and #text ~= 0 then\
		height = #Helpers.WrapText(text, 26)\
		table.insert(children, {\
			[\"Y\"]=2,\
			[\"X\"]=2,\
			[\"Width\"]=\"100%,-2\",\
			[\"Height\"]=height,\
			[\"Name\"]=\"Label\",\
			[\"Type\"]=\"Label\",\
			[\"Text\"]=text\
		})\
	end\
	table.insert(children,\
		{\
			[\"Y\"]=3+height,\
			[\"X\"]=2,\
			[\"Width\"]=\"100%,-2\",\
			[\"Name\"]=\"TextBox\",\
			[\"Type\"]=\"TextBox\",\
			[\"Text\"]=textboxText,\
			[\"CursorPos\"]=(cursorAtEnd and 0 or nil)\
		})\
	local view = {\
		Children = children,\
		Width=28,\
		Height=5+height+(canClose and 0 or 1),\
	}\
	self:DisplayWindow(view, title)\
	self.Window:GetObject('TextBox').OnUpdate = function(txtbox, keychar)\
		if keychar == keys.enter then\
			self.Window:Close()\
			callback(true, txtbox.Text)\
		end\
	end\
	self:SetActiveObject(self.Window:GetObject('TextBox'))\
	self.Window.OnCloseButton = function()callback(false)end\
end\
\
function DisplayOpenFileWindow(self, title, callback)\
	title = title or 'Open File'\
	local func = function(btn)\
		self.Window:Close()\
		if callback then\
			callback(btn.Text)\
		end\
	end\
\
	local sidebarItems = {}\
\
	--this is a really, really super bad way of doing it\
	local separator = '                               !'\
\
	local function addFolder(path, level)\
		for i, v in ipairs(fs.list(path)) do\
			local fPath = path .. '/' .. v\
			if fPath ~= '/rom' and fs.isDir(fPath) then\
				table.insert(sidebarItems, level .. v..separator..fPath)\
				addFolder(fPath, level .. '  ')\
			end\
		end\
	end\
	addFolder('','')\
\
	local currentFolder = ''\
	local selectedPath = nil\
\
	local goToFolder = nil\
\
	local children = {\
		{\
			[\"Y\"]=\"100%,-2\",\
			[\"X\"]=1,\
			[\"Height\"]=3,\
			[\"Width\"]=\"100%\",\
			[\"BackgroundColour\"]=colours.lightGrey,\
			[\"Name\"]=\"SidebarListView\",\
			[\"Type\"]=\"View\"\
		},\
		{\
			[\"Y\"]=\"100%,-1\",\
			[\"X\"]=\"100%,-4\",\
			[\"Name\"]=\"OkButton\",\
			[\"Type\"]=\"Button\",\
			[\"Text\"]=\"Ok\",\
			[\"BackgroundColour\"]=colours.white,\
			[\"Enabled\"]=false,\
			OnClick = function()\
				if selectedPath then\
					self.Window:Close()\
					callback(true, Helpers.TidyPath(selectedPath))\
				end\
			end\
		},\
		{\
			[\"Y\"]=\"100%,-1\",\
			[\"X\"]=\"100%,-13\",\
			[\"Name\"]=\"CancelButton\",\
			[\"Type\"]=\"Button\",\
			[\"Text\"]=\"Cancel\",\
			[\"BackgroundColour\"]=colours.white,\
			OnClick = function()\
				self.Window:Close()\
				callback(false)\
			end\
		},\
		{\
			[\"Y\"]=1,\
			[\"X\"]=1,\
			[\"Height\"]=\"100%,-3\",\
			[\"Width\"]=\"40%,-1\",\
			[\"Name\"]=\"SidebarListView\",\
			[\"Type\"]=\"ListView\",\
			[\"CanSelect\"]=true,\
			[\"Items\"]={\
				[\"Computer\"] = sidebarItems\
			},\
			OnSelect = function(listView, text)\
				local _,s = text:find(separator)\
				if s then\
					local path = text:sub(s + 1)\
					goToFolder(path)\
				end\
			end,\
			OnClick = function(listView, event, side, x, y)\
				if y == 1 then\
					goToFolder('/')\
				end\
			end\
		},\
		{\
			[\"Y\"]=1,\
			[\"X\"]=\"40%\",\
			[\"Height\"]=\"100%,-3\",\
			[\"Width\"]=1,\
			[\"Type\"]=\"Separator\"\
		},\
		{\
			[\"Y\"]=1,\
			[\"X\"]=\"40%,2\",\
			[\"Width\"]=\"65%,-3\",\
			[\"Height\"]=1,\
			[\"Type\"]=\"Label\",\
			[\"Name\"]=\"PathLabel\",\
			[\"TextColour\"]=colours.lightGrey,\
			[\"Text\"]='/hello/there'\
		},\
		{\
			[\"Y\"]=2,\
			[\"X\"]=\"40%,1\",\
			[\"Height\"]=\"100%,-4\",\
			[\"Width\"]=\"65%,-1\",\
			[\"Name\"]=\"FilesListView\",\
			[\"Type\"]=\"ListView\",\
			[\"CanSelect\"]=true,\
			[\"Items\"]={},\
			OnSelect = function(listView, text)\
				selectedPath = Helpers.TidyPath(currentFolder .. '/' .. text)\
				self.Window:GetObject('OkButton').Enabled = true\
			end,\
			OnClick = function(listView, event, side, x, y)\
				if y == 1 then\
					goToFolder('/')\
				end\
			end\
		},\
	}\
	local view = {\
		Children = children,\
		Width=40,\
		Height= Drawing.Screen.Height - 4\
	}\
	self:DisplayWindow(view, title)\
\
	goToFolder = function(path)\
		path = Helpers.TidyPath(path)\
		self.Window:GetObject('PathLabel').Text = path\
		currentFolder = path\
\
		local filesListItems = {}\
		for i, v in ipairs(fs.list(path)) do\
			if not fs.isDir(currentFolder .. v) then\
				table.insert(filesListItems, v)\
			end\
		end\
		self.Window:GetObject('OkButton').Enabled = false\
		selectedPath = nil\
		self.Window:GetObject('FilesListView').Items = filesListItems\
\
	end\
\
	goToFolder('')\
\
	self.Window.OnCloseButton = function()callback(false)end\
end\
\
function RegisterEvent(self, event, func)\
	if not self.EventHandlers[event] then\
		self.EventHandlers[event] = {}\
	end\
	table.insert(self.EventHandlers[event], func)\
end\
\
function StartRepeatingTimer(self, func, interval)\
	local int = interval\
	if type(int) == 'function' then\
		int = int()\
	end\
	if not int or int <= 0 then\
		return\
	end\
	local timer = os.startTimer(int)\
\
	self.Timers[timer] = {func, true, interval}\
	return timer\
end\
\
function StartTimer(self, func, delay)\
	local timer = os.startTimer(delay)\
	self.Timers[timer] = {func, false}\
	return timer\
end\
\
function StopTimer(self, timer)\
	if self.Timers[timer] then\
		self.Timers[timer] = nil\
	end\
end\
\
function HandleTimer(self, event, timer)\
	if self.Timers[timer] then\
		local oldTimer = self.Timers[timer]\
		self.Timers[timer] = nil\
		local new = nil\
		if oldTimer[2] then\
			new = self:StartRepeatingTimer(oldTimer[1], oldTimer[3])\
		end\
		if oldTimer and oldTimer[1] then\
			oldTimer[1](new)\
		end\
	elseif self.OnTimer then\
		self.OnTimer(self, event, timer)\
	end\
end\
\
function SetActiveObject(self, object)\
	if object then\
		if object ~= self.ActiveObject then\
			self.ActiveObject = object\
			object:ForceDraw()\
		end\
	elseif self.ActiveObject ~= nil then\
		self.ActiveObject = nil\
		self.CursorPos = nil\
		self.View:ForceDraw()\
	end\
end\
\
function GetActiveObject(self)\
	return self.ActiveObject\
end\
\
OnTimer = nil\
OnClick = nil\
OnKeyChar = nil\
OnDrag = nil\
OnScroll = nil\
OnViewLoad = nil\
OnViewClose = nil\
OnDraw = nil\
OnQuit = nil\
\
local eventFuncs = {\
	OnClick = {'mouse_click'},\
	OnKeyChar = {'key', 'char'},\
	OnDrag = {'mouse_drag'},\
	OnScroll = {'mouse_scroll'},\
	HandleClick = {'mouse_click', 'mouse_drag', 'mouse_scroll'},\
	HandleKeyChar = {'key', 'char'},\
	HandleTimer = {'timer'}\
}\
\
local drawCalls = 0\
local ignored = 0\
function Draw(self)\
	self.IsDrawing = true\
	if self.OnDraw then\
		self:OnDraw()\
	end\
\
	if self.View and self.View:NeedsDraw() then\
		self.View:Draw()\
		Drawing.DrawBuffer()\
		if isDebug then\
			drawCalls = drawCalls + 1\
		end\
	elseif not self.View then\
		print('No loaded view. You need to do program:LoadView first.')\
	end	\
\
	if self:GetActiveObject() and self.CursorPos and type(self.CursorPos[1]) == 'number' and type(self.CursorPos[2]) == 'number' then\
		term.setCursorPos(self.CursorPos[1], self.CursorPos[2])\
		term.setTextColour(self.CursorColour)\
		term.setCursorBlink(true)\
	else\
		term.setCursorBlink(false)\
	end\
\
	self.IsDrawing = false\
end\
\
function EventHandler(self)\
	local event = { os.pullEventRaw() }\
	\
	if self.EventHandlers[event[1]] then\
		for i, e in ipairs(self.EventHandlers[event[1]]) do\
			e(self, unpack(event))\
		end\
	end\
end\
\
function Quit(self)\
	self.Running = false\
	if self.OnQuit then\
		self:OnQuit()\
	end\
	if OneOS then\
		OneOS.Close()\
	end\
end\
\
function Run(self, ready)\
	for name, events in pairs(eventFuncs) do\
		if self[name] then\
			for i, event in ipairs(events) do\
				self:RegisterEvent(event, self[name])\
			end\
		end\
	end\
\
	if self.AllowTerminate then\
		self:RegisterEvent('terminate', function()error('Terminated', 0) end)\
	end\
\
	if self.DefaultView and self.DefaultView ~= '' and fs.exists(self.ViewPath..self.DefaultView..'.view') then\
		self:LoadView(self.DefaultView)\
	end\
\
	if ready then\
		ready()\
	end\
	\
	self:Draw()\
\
	while self.Running do\
		self:EventHandler()\
	end\
end",[".gitignore"]=".DS_Store\
.Desktop.settings\
.OneOS.settings\
*.settings\
\
Desktop/.Desktop.settings\
\
.version",["hash"]="--\
--  Thanks to GravityScore for this!\
--  http://www.computercraft.info/forums2/index.php?/topic/8169-sha-256-in-pure-lua/\
--\
--  This is used to hash passwords sent with the secure text field. It just reduces the chance of people getting hacked.\
--\
\
--  \
--  Adaptation of the Secure Hashing Algorithm (SHA-244/256)\
--  Found Here: http://lua-users.org/wiki/SecureHashAlgorithm\
--  \
--  Using an adapted version of the bit library\
--  Found Here: https://bitbucket.org/Boolsheet/bslf/src/1ee664885805/bit.lua\
--  \
\
local MOD = 2^32\
local MODM = MOD-1\
\
local function memoize(f)\
	local mt = {}\
	local t = setmetatable({}, mt)\
	function mt:__index(k)\
		local v = f(k)\
		t[k] = v\
		return v\
	end\
	return t\
end\
\
local function make_bitop_uncached(t, m)\
	local function bitop(a, b)\
		local res,p = 0,1\
		while a ~= 0 and b ~= 0 do\
			local am, bm = a % m, b % m\
			res = res + t[am][bm] * p\
			a = (a - am) / m\
			b = (b - bm) / m\
			p = p*m\
		end\
		res = res + (a + b) * p\
		return res\
	end\
	return bitop\
end\
\
local function make_bitop(t)\
	local op1 = make_bitop_uncached(t,2^1)\
	local op2 = memoize(function(a) return memoize(function(b) return op1(a, b) end) end)\
	return make_bitop_uncached(op2, 2 ^ (t.n or 1))\
end\
\
local bxor1 = make_bitop({[0] = {[0] = 0,[1] = 1}, [1] = {[0] = 1, [1] = 0}, n = 4})\
\
local function bxor(a, b, c, ...)\
	local z = nil\
	if b then\
		a = a % MOD\
		b = b % MOD\
		z = bxor1(a, b)\
		if c then z = bxor(z, c, ...) end\
		return z\
	elseif a then return a % MOD\
	else return 0 end\
end\
\
local function band(a, b, c, ...)\
	local z\
	if b then\
		a = a % MOD\
		b = b % MOD\
		z = ((a + b) - bxor1(a,b)) / 2\
		if c then z = bit32_band(z, c, ...) end\
		return z\
	elseif a then return a % MOD\
	else return MODM end\
end\
\
local function bnot(x) return (-1 - x) % MOD end\
\
local function rshift1(a, disp)\
	if disp < 0 then return lshift(a,-disp) end\
	return math.floor(a % 2 ^ 32 / 2 ^ disp)\
end\
\
local function rshift(x, disp)\
	if disp > 31 or disp < -31 then return 0 end\
	return rshift1(x % MOD, disp)\
end\
\
local function lshift(a, disp)\
	if disp < 0 then return rshift(a,-disp) end \
	return (a * 2 ^ disp) % 2 ^ 32\
end\
\
local function rrotate(x, disp)\
    x = x % MOD\
    disp = disp % 32\
    local low = band(x, 2 ^ disp - 1)\
    return rshift(x, disp) + lshift(low, 32 - disp)\
end\
\
local k = {\
	0x428a2f98, 0x71374491, 0xb5c0fbcf, 0xe9b5dba5,\
	0x3956c25b, 0x59f111f1, 0x923f82a4, 0xab1c5ed5,\
	0xd807aa98, 0x12835b01, 0x243185be, 0x550c7dc3,\
	0x72be5d74, 0x80deb1fe, 0x9bdc06a7, 0xc19bf174,\
	0xe49b69c1, 0xefbe4786, 0x0fc19dc6, 0x240ca1cc,\
	0x2de92c6f, 0x4a7484aa, 0x5cb0a9dc, 0x76f988da,\
	0x983e5152, 0xa831c66d, 0xb00327c8, 0xbf597fc7,\
	0xc6e00bf3, 0xd5a79147, 0x06ca6351, 0x14292967,\
	0x27b70a85, 0x2e1b2138, 0x4d2c6dfc, 0x53380d13,\
	0x650a7354, 0x766a0abb, 0x81c2c92e, 0x92722c85,\
	0xa2bfe8a1, 0xa81a664b, 0xc24b8b70, 0xc76c51a3,\
	0xd192e819, 0xd6990624, 0xf40e3585, 0x106aa070,\
	0x19a4c116, 0x1e376c08, 0x2748774c, 0x34b0bcb5,\
	0x391c0cb3, 0x4ed8aa4a, 0x5b9cca4f, 0x682e6ff3,\
	0x748f82ee, 0x78a5636f, 0x84c87814, 0x8cc70208,\
	0x90befffa, 0xa4506ceb, 0xbef9a3f7, 0xc67178f2,\
}\
\
local function str2hexa(s)\
	return (string.gsub(s, \".\", function(c) return string.format(\"%02x\", string.byte(c)) end))\
end\
\
local function num2s(l, n)\
	local s = \"\"\
	for i = 1, n do\
		local rem = l % 256\
		s = string.char(rem) .. s\
		l = (l - rem) / 256\
	end\
	return s\
end\
\
local function s232num(s, i)\
	local n = 0\
	for i = i, i + 3 do n = n*256 + string.byte(s, i) end\
	return n\
end\
\
local function preproc(msg, len)\
	local extra = 64 - ((len + 9) % 64)\
	len = num2s(8 * len, 8)\
	msg = msg .. \"\\128\" .. string.rep(\"\\0\", extra) .. len\
	assert(#msg % 64 == 0)\
	return msg\
end\
\
local function initH256(H)\
	H[1] = 0x6a09e667\
	H[2] = 0xbb67ae85\
	H[3] = 0x3c6ef372\
	H[4] = 0xa54ff53a\
	H[5] = 0x510e527f\
	H[6] = 0x9b05688c\
	H[7] = 0x1f83d9ab\
	H[8] = 0x5be0cd19\
	return H\
end\
\
local function digestblock(msg, i, H)\
	local w = {}\
	for j = 1, 16 do w[j] = s232num(msg, i + (j - 1)*4) end\
	for j = 17, 64 do\
		local v = w[j - 15]\
		local s0 = bxor(rrotate(v, 7), rrotate(v, 18), rshift(v, 3))\
		v = w[j - 2]\
		w[j] = w[j - 16] + s0 + w[j - 7] + bxor(rrotate(v, 17), rrotate(v, 19), rshift(v, 10))\
	end\
\
	local a, b, c, d, e, f, g, h = H[1], H[2], H[3], H[4], H[5], H[6], H[7], H[8]\
	for i = 1, 64 do\
		local s0 = bxor(rrotate(a, 2), rrotate(a, 13), rrotate(a, 22))\
		local maj = bxor(band(a, b), band(a, c), band(b, c))\
		local t2 = s0 + maj\
		local s1 = bxor(rrotate(e, 6), rrotate(e, 11), rrotate(e, 25))\
		local ch = bxor (band(e, f), band(bnot(e), g))\
		local t1 = h + s1 + ch + k[i] + w[i]\
		h, g, f, e, d, c, b, a = g, f, e, d + t1, c, b, a, t1 + t2\
	end\
\
	H[1] = band(H[1] + a)\
	H[2] = band(H[2] + b)\
	H[3] = band(H[3] + c)\
	H[4] = band(H[4] + d)\
	H[5] = band(H[5] + e)\
	H[6] = band(H[6] + f)\
	H[7] = band(H[7] + g)\
	H[8] = band(H[8] + h)\
end\
\
function sha256(msg)\
	msg = preproc(msg, #msg)\
	local H = initH256({})\
	for i = 1, #msg, 64 do digestblock(msg, i, H) end\
	return str2hexa(num2s(H[1], 4) .. num2s(H[2], 4) .. num2s(H[3], 4) .. num2s(H[4], 4) ..\
		num2s(H[5], 4) .. num2s(H[6], 4) .. num2s(H[7], 4) .. num2s(H[8], 4))\
end",["Pages"]={["404.ccml"]="<!DOCTYPE ccml>\
<html>\
	<head>\
	  <title>Page Not Found</title>\
	</head>\
	<body>\
		<br/>\
		<br/>\
		<h colour=\"red\">404 Page Not Found</h>\
		<br/>\
		<center>\
			<p width=\"38\" align=\"center\">The page was not found on the server. Check the address and try again.</p>\
		</center>\
	</body>\
</html>",["6.ccml"]="<!DOCTYPE ccml>\
<html>\
	<head>\
	  <title>Download Failed</title>\
	</head>\
	<body>\
		<br/>\
		<br/>\
		<h colour=\"red\">Download Failed</h>\
		<br/>\
		<center>\
			<br>\
			<p width=\"38\" align=\"center\">The file you wanted failed to download. Try again or contact the file owner.</p>\
		</center>\
	</body>\
</html>",["7.ccml"]="<!DOCTYPE ccml>\
<html>\
	<head>\
	  <title>No Modem Connected</title>\
	</head>\
	<body>\
		<br/>\
		<br/>\
		<h colour=\"red\">No Modem Connected</h>\
		<br/>\
		<center>\
			<br>\
			<p width=\"38\" align=\"center\">Please attach a wirelss modem and restart Quest.</p>\
		</center>\
	</body>\
</html>",["download.ccml"]="<!DOCTYPE ccml>\
<html>\
	<head>\
		<title>Downloading File</title>\
	    <script type=\"lua\">\
	    	if window.get.path then\
	        	l('p').text('Quest is downloading your file to ' .. window.get.path .. '. Please wait a moment. Leaving this page will cancel the download.')\
	    	end\
	    </script>\
	</head>\
	<body>\
		<br/>\
		<br/>\
		<h colour=\"blue\">Downloading File</h>\
\
		<center>\
			<br>\
			<p width=\"48\" align=\"center\"></p>\
		</center>\
	</body>\
</html>",["408.ccml"]="<!DOCTYPE ccml>\
<html>\
	<head>\
	  <title>Page Not Found</title>\
	</head>\
	<body>\
		<br/>\
		<br/>\
		<h colour=\"red\">Page Load Cancelled</h>\
		<br/>\
		<center>\
			<p width=\"38\" align=\"center\">The page either took too long to load or you cancelled loading it.</p>\
		</center>\
	</body>\
</html>",["text.ccml"]="<!DOCTYPE ccml>\
<html>\
	<head>\
		<title>An Error Occured</title>\
	    <script type=\"lua\">\
	    	if window.get.reason then\
	        	l('p').text(window.get.reason)\
	    	end\
	    </script>\
	</head>\
	<body>\
		<br/>\
		<br/>\
		<h colour=\"red\">An Error Occured</h>\
		<br/>\
		<center>\
			<br>\
			<p width=\"48\" align=\"center\">Unknown Reason</p>\
		</center>\
	</body>\
</html>",["downloaded.ccml"]="<!DOCTYPE ccml>\
<html>\
	<head>\
		<title>Download Complete</title>\
	    <script type=\"lua\">\
	    	if window.get.path then\
	        	l('p').text('Your file has been saved to ' .. window.get.path .. '. You can now leave this page (use the back button).')\
	    	end\
	    </script>\
	</head>\
	<body>\
		<br/>\
		<br/>\
		<h colour=\"blue\">Download Complete</h>\
\
		<center>\
			<br>\
			<p width=\"48\" align=\"center\"></p>\
		</center>\
	</body>\
</html>",["1.ccml"]="<!DOCTYPE ccml>\
<html>\
	<head>\
	  <title>Failed to Download Page</title>\
	</head>\
	<body>\
		<br/>\
		<br/>\
		<h colour=\"red\">Failed to Download Page</h>\
		<br/>\
		<center>\
			<br>\
			<p width=\"38\" align=\"center\">The page you requested failed to download. The page may not exist, the server may be experiencing problems or you have connection issues.</p>\
		</center>\
	</body>\
</html>",["2.ccml"]="<!DOCTYPE ccml>\
<html>\
	<head>\
	  <title>Doctype Incorrect</title>\
	</head>\
	<body>\
		<br/>\
		<br/>\
		<h colour=\"red\">Doctype Incorrect</h>\
		<br/>\
		<center>\
			<br>\
			<p width=\"38\" align=\"center\">This page has an incorrect doctype and can not be rendered. Quest can not view standard web pages.</p>\
			<br>\
			<p width=\"38\" align=\"center\" color=\"grey\">If you made this page make sure the file starts with \"&lt;!DOCTYPE ccml&gt;\"</p>\
		</center>\
	</body>\
</html>",["3.ccml"]="<!DOCTYPE ccml>\
<html>\
	<head>\
	  <title>Failed to Parse Page</title>\
	</head>\
	<body>\
		<br/>\
		<br/>\
		<h colour=\"red\">Failed to Parse Page</h>\
		<br/>\
		<center>\
			<br>\
			<p width=\"38\" align=\"center\">The page you requested failed to parse. It is either malformed or your browser is out of date.</p>\
		</center>\
	</body>\
</html>",["4.ccml"]="<!DOCTYPE ccml>\
<html>\
	<head>\
	  <title>HTTP Not Enabled</title>\
	</head>\
	<body>\
		<br/>\
		<br/>\
		<h colour=\"red\">HTTP Not Enabled</h>\
		<br/>\
		<center>\
			<br>\
			<p width=\"38\" align=\"center\">You haven't enabled the HTTP API. To do so, take a look on the HTTP API page on the wiki for a link to a tutorial.</p>\
		</center>\
	</body>\
</html>",["5.ccml"]="<!DOCTYPE ccml>\
<html>\
	<head>\
	  <title>Page Not Whitelisted</title>\
	</head>\
	<body>\
		<br/>\
		<br/>\
		<h colour=\"red\">Page Not Whitelisted</h>\
		<br/>\
		<center>\
			<br>\
			<p width=\"38\" align=\"center\">The page you are trying to open isn't whitelisted. Please take a look on the forums or the wiki as to how to fix this.</p>\
		</center>\
	</body>\
</html>",},["lQuery"]="function fn(selector)\
	if not selector then\
	else\
		local elements = lQuery.webView:ResolveElements(selector)\
		local function relayout()\
			lQuery.webView:RepositionLayout()\
		end\
		if elements and #elements > 0 then\
			local each = function(func)\
				for i, v in ipairs(elements) do\
					func(v, i)\
				end\
			end\
\
			local response = {\
				text = function(text)\
					each(function(elem)\
						if elem.Text then\
							elem.Text = tostring(text)\
						end\
					end)\
				end,\
\
				width = function(width)\
					if type(width) == 'number' then\
						each(function(elem)\
							elem.Width = width\
						end)\
						relayout()\
					end\
				end,\
\
				height = function(height)\
					if type(height) == 'number' then\
						each(function(elem)\
							elem.Height = height\
						end)\
						relayout()\
					end\
				end,\
\
				colour = function(colour)\
					if type(colour) == 'number' then\
						each(function(elem)\
							if elem.TextColour then\
								elem.TextColour = colour\
							end\
						end)\
					end\
				end,\
\
				bgcolour = function(bgcolour)\
					if type(bgcolour) == 'number' then\
						each(function(elem)\
							if elem.BackgroundColour then\
								elem.BackgroundColour = bgcolour\
							end\
						end)\
					end\
				end,\
\
				align = function(align)\
					if type(align) == 'string' and align:lower() == 'left' or align:lower() == 'center' or align:lower() == 'right'  then\
						each(function(elem)\
							if elem.Align then\
								elem.Align = align:lower():gsub(\"^%l\", string.upper)\
							end\
						end)\
					end\
				end,\
\
				attr = function(name)\
					local values = {}\
					each(function(elem)\
						if elem.Element.Attributes and elem.Element.Attributes[name] then\
							table.insert(values, elem.Element.Attributes[name])\
						end\
					end)\
					return values\
				end,\
\
				remove = function()\
					each(function(elem)\
						lQuery.webView:RemoveElement(elem)\
						relayout()\
					end)\
				end,\
\
				focus = function()\
					each(function(elem)\
						elem.Bedrock:SetActiveObject(elem)\
					end)\
				end\
			}\
			response.color = response.colour\
			response.bgcolor = response.bgcolour\
\
			return response\
		end\
	end\
end",["Peripheral"]="GetPeripheral = function(_type)\
	for i, p in ipairs(GetPeripherals()) do\
		if p.Type == _type then\
			return p\
		end\
	end\
end\
\
Call = function(type, ...)\
	local tArgs = {...}\
	local p = GetPeripheral(type)\
	peripheral.call(p.Side, unpack(tArgs))\
end\
\
local getNames = peripheral.getNames or function()\
	local tResults = {}\
	for n,sSide in ipairs( rs.getSides() ) do\
		if peripheral.isPresent( sSide ) then\
			table.insert( tResults, sSide )\
			local isWireless = false\
			if pcall(function()isWireless = peripheral.call(sSide, 'isWireless') end) then\
				isWireless = true\
			end     \
			if peripheral.getType( sSide ) == \"modem\" and not isWireless then\
				local tRemote = peripheral.call( sSide, \"getNamesRemote\" )\
				for n,sName in ipairs( tRemote ) do\
					table.insert( tResults, sName )\
				end\
			end\
		end\
	end\
	return tResults\
end\
\
GetPeripherals = function(filterType)\
	local peripherals = {}\
	for i, side in ipairs(getNames()) do\
		local name = peripheral.getType(side):gsub(\"^%l\", string.upper)\
		local code = string.upper(side:sub(1,1))\
		if side:find('_') then\
			code = side:sub(side:find('_')+1)\
		end\
\
		local dupe = false\
		for i, v in ipairs(peripherals) do\
			if v[1] == name .. ' ' .. code then\
				dupe = true\
			end\
		end\
\
		if not dupe then\
			local _type = peripheral.getType(side)\
			local formattedType = _type:sub(1, 1):upper() .. _type:sub(2, -1)\
			local isWireless = false\
			if _type == 'modem' then\
				if not pcall(function()isWireless = peripheral.call(side, 'isWireless') end) then\
					isWireless = true\
				end     \
				if isWireless then\
					_type = 'wireless_modem'\
					formattedType = 'Wireless Modem'\
					name = 'W '..name\
				end\
			end\
			if not filterType or _type == filterType then\
				table.insert(peripherals, {Name = name:sub(1,8) .. ' '..code, Fullname = name .. ' ('..side:sub(1, 1):upper() .. side:sub(2, -1)..')', Side = side, Type = _type, Wireless = isWireless, FormattedType = formattedType})\
			end\
		end\
	end\
	return peripherals\
end\
\
GetSide = function(side)\
	for i, p in ipairs(GetPeripherals()) do\
		if p.Side == side then\
			return p\
		end\
	end\
end\
\
PresentNamed = function(name)\
	return peripheral.isPresent(name)\
end\
\
CallType = function(type, ...)\
	local tArgs = {...}\
	local p = GetPeripheral(type)\
	return peripheral.call(p.Side, unpack(tArgs))\
end\
\
CallNamed = function(name, ...)\
	local tArgs = {...}\
	return peripheral.call(name, unpack(tArgs))\
end\
\
GetInfo = function(p)\
	local info = {}\
	local buttons = {}\
	if p.Type == 'computer' then\
		local id = peripheral.call(p.Side:lower(),'getID')\
		if id then\
			info = {\
				ID = tostring(id)\
			}\
		else\
			info = {}\
		end\
	elseif p.Type == 'drive' then\
		local discType = 'No Disc'\
		local discID = nil\
		local mountPath = nil\
		local discLabel = nil\
		local songName = nil\
		if peripheral.call(p.Side:lower(), 'isDiskPresent') then\
			if peripheral.call(p.Side:lower(), 'hasData') then\
				discType = 'Data'\
				discID = peripheral.call(p.Side:lower(), 'getDiskID')\
				if discID then\
					discID = tostring(discID)\
				else\
					discID = 'None'\
				end\
				mountPath = '/'..peripheral.call(p.Side:lower(), 'getMountPath')..'/'\
				discLabel = peripheral.call(p.Side:lower(), 'getDiskLabel')\
			else\
				discType = 'Audio'\
				songName = peripheral.call(p.Side:lower(), 'getAudioTitle')\
			end\
		end\
		if mountPath then\
			table.insert(buttons, {Text = 'View Files', OnClick = function(self, event, side, x, y)GoToPath(mountPath)end})\
		elseif discType == 'Audio' then\
			table.insert(buttons, {Text = 'Play', OnClick = function(self, event, side, x, y)\
				if self.Text == 'Play' then\
					disk.playAudio(p.Side:lower())\
					self.Text = 'Stop'\
				else\
					disk.stopAudio(p.Side:lower())\
					self.Text = 'Play'\
				end\
			end})\
		else\
			diskOpenButton = nil\
		end\
		if discType ~= 'No Disc' then\
			table.insert(buttons, {Text = 'Eject', OnClick = function(self, event, side, x, y)disk.eject(p.Side:lower()) sleep(0) RefreshFiles() end})\
		end\
\
		info = {\
			['Disc Type'] = discType,\
			['Disc Label'] = discLabel,\
			['Song Title'] = songName,\
			['Disc ID'] = discID,\
			['Mount Path'] = mountPath\
		}\
	elseif p.Type == 'printer' then\
		local pageSize = 'No Loaded Page'\
		local _, err = pcall(function() return tostring(peripheral.call(p.Side:lower(), 'getPgaeSize')) end)\
		if not err then\
			pageSize = tostring(peripheral.call(p.Side:lower(), 'getPageSize'))\
		end\
		info = {\
			['Paper Level'] = tostring(peripheral.call(p.Side:lower(), 'getPaperLevel')),\
			['Paper Size'] = pageSize,\
			['Ink Level'] = tostring(peripheral.call(p.Side:lower(), 'getInkLevel'))\
		}\
	elseif p.Type == 'modem' then\
		info = {\
			['Connected Peripherals'] = tostring(#peripheral.call(p.Side:lower(), 'getNamesRemote'))\
		}\
	elseif p.Type == 'monitor' then\
		local w, h = peripheral.call(p.Side:lower(), 'getSize')\
		local screenType = 'Black and White'\
		if peripheral.call(p.Side:lower(), 'isColour') then\
			screenType = 'Colour'\
		end\
		local buttonTitle = 'Use as Screen'\
		if OneOS.Settings:GetValues()['Monitor'] == p.Side:lower() then\
			buttonTitle = 'Use Computer Screen'\
		end\
		table.insert(buttons, {Text = buttonTitle, OnClick = function(self, event, side, x, y)\
				self.Bedrock:DisplayAlertWindow('Reboot Required', \"To change screen you'll need to reboot your computer.\", {'Reboot', 'Cancel'}, function(value)\
					if value == 'Reboot' then\
						if buttonTitle == 'Use Computer Screen' then\
							OneOS.Settings:SetValue('Monitor', nil)\
						else\
							OneOS.Settings:SetValue('Monitor', p.Side:lower())\
						end\
						OneOS.Reboot()\
					end\
				end)\
			end\
		})\
		info = {\
			['Type'] = screenType,\
			['Width'] = tostring(w),\
			['Height'] = tostring(h),\
		}\
	end\
	info.Buttons = buttons\
	return info\
end",["Objects"]={["HeadingView.lua"]="Inherit = 'View'\
Height = 3\
\
OnLoad = function(self)\
	self:OnUpdate('Text')\
end\
\
OnUpdate = function(self, value)\
	if value == 'Text' then\
		self:RemoveAllObjects()\
		self:AddObject({\
			Y = 1,\
			X = 1,\
			Width = \"100%\",\
			Align = \"Center\",\
			Type = \"Label\",\
			Text = self.Text,\
			TextColour = self.TextColour,\
			BackgroundColour = self.BackgroundColour\
		})\
\
		local underline = ''\
		for i = 1, #self.Text + 2 do\
			underline = underline .. '='\
		end\
		self:AddObject({\
			Y = 2,\
			X = 1,\
			Width = \"100%\",\
			Align = \"Center\",\
			Type = \"Label\",\
			Text = underline,\
			TextColour = self.TextColour,\
			BackgroundColour = self.BackgroundColour\
		})\
	end\
end",["WebImageView.lua"]="URL = false\
Image = false\
\
OnDraw = function(self, x, y)\
	if not self.Image then\
		Drawing.DrawBlankArea(x, y, self.Width, self.Height, colours.lightGrey)\
	elseif self.Format == 'nft' then\
		Drawing.DrawImage(x, y, self.Image, self.Width, self.Height)\
	elseif self.Format == 'nfp' or self.Format == 'paint' then\
		for _x, col in ipairs(self.Image) do\
			for _y, colour in ipairs(col) do\
	            Drawing.WriteToBuffer(x+_x-1, y+_y-1, ' ', colours.white, colour)\
			end\
		end\
	elseif self.Format == 'skch' or self.Format == 'sketch' then\
		Drawing.DrawImage(x, y, self.Image, self.Width, self.Height)\
	end\
end\
\
OnUpdate = function(self, value)\
	if value == 'URL' and self.URL then\
		fetchHTTPAsync(resolveFullUrl(self.URL), function(ok, event, response)\
			if ok then\
				local width, height = self.Width, self.Height\
\
				local lines = {}\
				for line in response.readLine do\
					table.insert(lines, line)\
				end\
				response.close()\
				local content = table.concat(lines, '\\n')\
\
				if not self.Format then\
					self.Format = self:DetermineFormat(content)\
				end\
\
				if self.Format == 'nft' then\
					self.Image, self.Width, self.Height = self:ReadNFT(lines)\
				elseif self.Format == 'nfp' or self.Format == 'paint' then\
					self.Image, self.Width, self.Height = self:ReadNFP(lines)\
				elseif self.Format == 'skch' or self.Format == 'sketch' then\
					self.Image, self.Width, self.Height = self:ReadSKCH(content)\
				end\
				if (width ~= self.Width or height ~= self.Height) then\
					self.Bedrock:GetObject('WebView'):RepositionLayout()\
				end\
			end\
		end)\
	end\
end\
\
DetermineFormat = function(self, content)\
	if type(textutils.unserialize(content)) == 'table' then\
		-- It's a serlized table, asume sketch\
		return 'skch'\
	elseif string.find(content, string.char(30)) or string.find(content, string.char(31)) then\
		-- Contains the characters that set colours, asume nft\
		return 'nft'\
	else\
		-- Otherwise asume nfp\
		return 'nfp'\
	end\
end\
\
ReadSKCH = function(self, content)\
	local _layers = textutils.unserialize(content)\
	local layers = {}\
\
	local width, height = 1, 1\
\
	for i, layer in ipairs(_layers) do\
		if layer.Visible then\
			local nft, w, h = self:ReadNFT(layer.Pixels)\
			if w > width then\
				width = w\
			end\
			if h > height then\
				height = h\
			end\
			table.insert(layers, nft)\
		end\
	end\
\
	--flatten the layers\
	local image = {\
		text = {},\
		textcol = {}\
	}\
\
	for i, layer in ipairs(layers) do\
		for y, row in ipairs(layer) do\
			if not image[y] then\
				image[y] = {}\
			end\
			for x, pixel in ipairs(row) do\
				if not image[y][x] or pixel ~= colours.transparent then\
					image[y][x] = pixel\
				end\
			end\
		end\
		for y, row in ipairs(layer.text) do\
			if not image.text[y] then\
				image.text[y] = {}\
			end\
			for x, pixel in ipairs(row) do\
				if not image.text[y][x] or pixel ~= ' ' then\
					image.text[y][x] = pixel\
				end\
			end\
		end\
		for y, row in ipairs(layer.textcol) do\
			if not image.textcol[y] then\
				image.textcol[y] = {}\
			end\
			for x, pixel in ipairs(row) do\
				if not image.textcol[y][x] or layer.text[y][x] ~= ' ' then\
					image.textcol[y][x] = pixel\
				end\
			end\
		end\
	end\
\
	return image, width, height\
end\
\
local function getColourOf(hex)\
	if hex == ' ' then\
		return colours.transparent\
	end\
    local value = tonumber(hex, 16)\
    if not value then return nil end\
    value = math.pow(2,value)\
    return value\
end\
\
ReadNFP = function(self, lines)\
	local image = {}\
	local y = 1\
	for y, line in ipairs(lines) do\
		for x = 1, #line do\
			if not image[x] then\
				image[x] = {}\
			end\
			image[x][y] = getColourOf(line:sub(x,x))\
		end\
		line = file.readLine()\
	end\
	file.close()\
 	return image, #image, #image[1]\
end\
\
ReadNFT = function(self, lines)\
	local image = {\
		text = {},\
		textcol = {}\
	}\
	for num, sLine in ipairs(lines) do\
        table.insert(image, num, {})\
        table.insert(image.text, num, {})\
        table.insert(image.textcol, num, {})\
        local writeIndex = 1\
        local bgNext, fgNext = false, false\
        local currBG, currFG = nil,nil\
        for i=1,#sLine do\
                local nextChar = string.sub(sLine, i, i)\
                if nextChar:byte() == 30 then\
                        bgNext = true\
                elseif nextChar:byte() == 31 then\
                        fgNext = true\
                elseif bgNext then\
                        currBG = Drawing.GetColour(nextChar)\
	                    if currBG == nil then\
	                    	currBG = colours.transparent\
	                    end\
                        bgNext = false\
                elseif fgNext then\
                        currFG = Drawing.GetColour(nextChar)\
	                    if currFG == nil or currFG == colours.transparent then\
	                    	currFG = colours.white\
	                    end\
                        fgNext = false\
                else\
                        if nextChar ~= \" \" and currFG == nil then\
                                currFG = colours.white\
                        end\
                        image[num][writeIndex] = currBG\
                        image.textcol[num][writeIndex] = currFG\
                        image.text[num][writeIndex] = nextChar\
                        writeIndex = writeIndex + 1\
                end\
        end\
    end\
 	return image, #image[1], #image\
end",["CenterView.lua"]="Inherit = 'View'\
\
OnUpdate = function(self, value)\
	if value == 'Children' or value == 'Width' then\
		local y = 1\
		for i, v in ipairs(self.Children) do\
			v.Y = y\
			y = y + v.Height\
			v.X = math.floor((self.Width - v.Width) / 2) + 1\
		end\
		self.Height = y - 1\
	end\
end",["DividerView.lua"]="Inherit = 'View'\
Char = nil\
\
OnDraw = function(self, x, y)\
	if self.BackgroundColour then\
		if self.Char then\
			Drawing.DrawArea (x, y, self.Width, self.Height, self.Char, self.TextColour, self.BackgroundColour)\
		else\
			Drawing.DrawBlankArea(x, y, self.Width, self.Height, self.BackgroundColour)\
		end\
	end\
end",["LinkView.lua"]="Inherit = 'View'\
Height = 2\
UnderlineColour = colours.blue\
UnderlineVisible = true\
\
OnLoad = function(self)\
	if self.Text and #self.Text > 0 then\
		self:AddObject({\
			Y = 1,\
			X = 1,\
			Width = self.Width,\
			Align = self.Align,\
			Type = \"Label\",\
			Text = self.Text,\
			TextColour = self.TextColour,\
			BackgroundColour = self.BackgroundColour\
		})\
	end\
end\
\
OnRecalculateStart = function(self)\
	self:RemoveObject('UnderlineLabel')\
end\
\
OnRecalculateEnd = function(self, currentY)\
	if self.UnderlineVisible then\
		local underline = ''\
		local len = self.Width\
		if self.Text then\
			len = #self.Text\
		end\
\
		for i = 1, len do\
			underline = underline .. '-'\
		end\
		local col = self.UnderlineColour\
		if self.UnderlineColour == nil then\
			col = self.TextColour\
		end\
\
		local ul = self:AddObject({\
			Y = currentY,\
			X = 1,\
			Width = self.Width,\
			Align = self.Align,\
			Type = \"Label\",\
			Name = \"UnderlineLabel\",\
			Text = underline,\
			TextColour = col,\
			BackgroundColour = self.BackgroundColour\
		})	\
		return currentY + 1\
	else\
		return currentY\
	end\
end\
\
OnClick = function(self)\
	self.Bedrock:GetObject('WebView'):GoToURL(self.URL)\
end",["SelectView.lua"]="Inherit = 'Button'\
MenuItems = nil\
Children = {}\
Selected = nil\
\
OnUpdate = function(self, value)\
	if value == 'Height' and self.Height ~= 1 then\
		self.Height = 1\
	end\
end\
\
Select = function(self, index)\
	if self.MenuItems[index] then\
		local text = self.MenuItems[index].Text\
		for i = 1, self.Width - 3 - #text do\
			text = text .. ' '\
		end\
		text = text .. 'V'\
		self.Text = text\
		self.Selected = index\
	end\
end\
\
OnInitialise = function(self)\
	self:ClearMenuItems()\
end\
\
ClearMenuItems = function(self)\
	self.MenuItems = {}\
end\
\
AddMenuItem = function(self, item)\
	table.insert(self.MenuItems, item)\
	if not self.Selected then\
		if #self.MenuItems ~= 0 then\
			self:Select(1)\
		end\
	end\
end\
\
OnClick = function(self, event, side, x, y)\
	if self:ToggleMenu({\
		Type = \"Menu\",\
		HideTop = true,\
		Children = self.MenuItems\
	}, x, 1) then\
		for i, child in ipairs(self.Bedrock.Menu.Children) do\
			child.OnClick = function(_self, event, side, x, y)\
				self:Select(i)\
			end\
		end\
	end\
end",["WebView.lua"]="Inherit = 'ScrollView'\
URL = nil\
FakeURL = nil\
LoadingURL = nil\
Tree = nil\
BackgroundColour = colours.white\
ScriptEnvironment = nil\
Timers = nil\
Download = nil\
\
-- TODO: strip this down to remove positioning stuff\
UpdateLayout = function(self)\
	self:RemoveAllObjects()\
	self.BackgroundColour = colours.white\
	local body = self.Tree:GetElement('body')\
\
	--TODO: check that body exists, if not redirect to an error page\
\
	if body.BackgroundColour then\
		self.BackgroundColour = body.BackgroundColour\
	end\
\
	local node = true\
	node = function(children, parentObject)\
		local currentY = 1\
		for i, v in ipairs(children) do\
			local object = v:CreateObject(parentObject, currentY)\
			if object then\
				v.Object = object\
				if v.Children and #v.Children > 0 and object.Children then\
					local usedY = node(v.Children, object)\
					if not v.Attributes.height then\
						object.Height = usedY\
					end\
					object:OnUpdate('Children')\
				end\
				-- if not object.Height then\
				-- 	for k, v in pairs(object) do\
				-- 		error(v)\
				-- 	end	\
				-- 	error('Nope')\
				-- end\
				currentY = currentY + object.Height\
			end\
		end\
		return currentY - 1\
	end\
	node(body.Children, self)\
	\
	self:RepositionLayout()\
\
	local head = self.Tree:GetElement('head')\
	if head then\
		for i, child in ipairs(head.Children) do\
			if child.Tag == 'script' then\
				child:InsertScript(self)\
			end\
		end\
	end\
end\
\
RepositionLayout = function(self)\
	local node = true\
	node = function(children, isFloat, parent)\
		if parent.OnRecalculateStart then\
			parent:OnRecalculateStart()\
		end\
\
		local currentY = 1\
		local currentX = 1\
		local tallestChild = 1\
		for i, child in ipairs(children) do\
			if child.Type ~= 'ScrollBar' then\
				if isFloat then\
					if currentX ~= 1 and parent.Width - currentX + 1 < child.Width then\
						currentX = 1\
						currentY = currentY + tallestChild\
						tallestChild = 1\
					end\
\
					if parent.Align == \"Left\" then\
						child.X = currentX\
					elseif parent.Align == \"Right\" then\
						child.X = parent.Width - currentX - child.Width + 2\
					end\
				end\
				child.Y = currentY\
\
				if child.Children and #child.Children > 0 then\
					local usedY = node(child.Children, child.IsFloat, child)\
					child:OnUpdate('Children')\
					if not child.Element.Attributes.height then\
						child.Height = usedY\
					end\
				end\
\
				if child.Height > tallestChild then\
					tallestChild = child.Height\
				end\
\
				if isFloat then\
					currentX = currentX + child.Width\
				else\
					currentY = currentY + child.Height\
				end\
			end\
		end\
		if isFloat then\
			currentY = currentY + tallestChild\
		end\
		if parent.OnRecalculateEnd then\
			currentY = parent:OnRecalculateEnd(currentY)\
		end\
		return currentY - 1\
	end\
	node(self.Children, self.IsFloat, self)\
\
	self:UpdateScroll()\
end\
\
GoToURL = function(self, url, nonVerbose, noHistory, post)\
	self.BackgroundColour = colours.white\
	self:RemoveAllObjects()\
	if self.OnPageLoadStart and not nonVerbose then\
		self:OnPageLoadStart(url, noHistory)\
	end\
	self.LoadingURL = url\
	self.FakeURL = url\
	self:InitialiseScriptEnvironment()\
\
	if not http and url:find('http://') then\
		if self.OnPageLoadFailed then\
			self:OnPageLoadFailed(url, 4, noHistory)\
		end\
		return\
	end\
\
	-- error(fs.getName(url))\
	local parts = urlComponents(url)\
	-- if url:sub(#url) ~= '/' and url:find('?') then\
	-- 	fileName = fs.getName(url:sub(1, url:find('?') - 1))\
	-- else\
	-- 	fileName = fs.getName(url)\
	-- end\
\
	local fileName = parts.filename\
	local extension\
	if fileName == '' or url:sub(#url) == '/' then\
		extension = true\
	else\
		extension = fileName:match('%.[0-9a-z%?%%]+$')\
		if extension then\
			extension = extension:sub(2)\
		end\
	end\
\
	if not url:find('quest://download.ccml') and not url:find('quest://downloaded.ccml') then\
		self.Download = nil\
	else\
		extension = true\
	end\
\
	-- TODO: 404s are counted as downloads\
\
	if not extension or (extension ~= true and extension ~= '' and extension ~= 'ccml' and extension ~= 'html' and extension ~= 'php' and extension ~= 'asp' and extension ~= 'aspx' and extension ~= 'jsp' and extension ~= 'qst' and extension ~= 'com' and extension ~= 'me' and extension ~= 'net' and extension ~= 'info' and extension ~= 'au' and extension ~= 'nz') then\
		local downloadsFolder = '/Downloads/'\
		if OneOS then\
			downloadsFolder = '/Desktop/Documents/Downloads/'\
		end\
		if not fs.exists(downloadsFolder) then\
			fs.makeDir(downloadsFolder)\
		end\
\
		local downloadPath = downloadsFolder..fileName\
		local i = 1\
		while fs.exists(downloadPath) do\
			i = i + 1\
			downloadPath = downloadsFolder..fileName .. ' (' .. i .. ')'\
		end\
\
		self.Download = url\
		fetchHTTPAsync(url, function(ok, event, response)\
			if self.Download == url then\
				self.Download = nil\
				if ok then\
					if response.getResponseCode then\
						local code = response.getResponseCode()\
						if code ~= 200 then\
							self:OnPageLoadFailed(url, 6, noHistory)\
							response.close()\
							return\
						end\
					end\
					local f = fs.open(downloadPath, 'w')\
					if f then\
						f.write(response.readAll())\
						f.close()\
						self:GoToURL('quest://downloaded.ccml?path='..textutils.urlEncode(downloadPath), true, true)\
					else\
						self:OnPageLoadFailed(url, 6, noHistory)\
					end\
					response.close()\
				else\
					self:OnPageLoadFailed(url, 6, noHistory)\
				end\
			end\
		end)\
\
		self:GoToURL('quest://download.ccml?path='..textutils.urlEncode(downloadPath), true, true)\
		self:OnPageLoadEnd(url, noHistory)\
	else\
		fetchHTTPAsync(url, function(ok, event, response)\
			self.LoadingURL = nil\
			if ok then\
				if response.getResponseCode then\
					local code = response.getResponseCode()\
					if code ~= 200 then\
						if self.OnPageLoadFailed then\
							self:OnPageLoadFailed(url, code, noHistory)\
						end\
						response.close()\
						return\
					end\
				end\
\
				self.Tree, err = ElementTree:Initialise(response.readAll())\
				response.close()\
				if not err then\
					self.URL = url\
					self:UpdateLayout()\
					if self.OnPageLoadEnd and not nonVerbose then\
						self:OnPageLoadEnd(url, noHistory)\
					end\
				else\
					if self.OnPageLoadFailed then\
						self:OnPageLoadFailed(url, err, noHistory)\
					end\
				end\
			elseif self.OnPageLoadFailed and not nonVerbose then\
				self:OnPageLoadFailed(url, event, noHistory)\
			end\
		end, post)\
	end\
end\
\
Stop = function(self)\
	cancelHTTPAsync(self.LoadingURL)\
	if self.OnPageLoadFailed then\
		self:OnPageLoadFailed(url, Errors.TimeoutStop)\
	end\
end\
\
ResolveElements = function(self, selector)\
	local elements = {}\
	local node = true\
	local isClass = false\
	if selector:sub(1,1) == '.' then\
		isClass = true\
	end\
\
	node = function(tbl)\
		for i,v in ipairs(tbl) do\
			if type(v) == 'table' and v.Tag then\
				if not isClass and v.Tag:lower() == selector:lower() then\
					table.insert(elements, v.Object)\
				elseif isClass and v.Attributes.class and v.Attributes.class:lower() == selector:lower():sub(2) then\
					table.insert(elements, v.Object)\
				end\
				if v.Children then\
					local r = node(v.Children)\
				end\
			end\
		end\
	end\
	node(self.Tree.Tree)\
	return elements\
end\
\
InitialiseScriptEnvironment = function(self)\
	lQuery.webView = self\
	if self.Timers then\
		for i, timer in ipairs(self.Timers) do\
			-- error('clear '..timer)\
			self.Bedrock.Timers[timer] = nil\
		end\
	end\
	self.Timers = {}\
\
	local getValues = urlComponents(self.LoadingURL).get\
\
	self.ScriptEnvironment = {\
		keys = keys,\
		printError = printError, -- maybe don't have this\
		assert = assert,\
		getfenv = getfenv,\
		bit = bit,\
		rawset = rawset,\
		tonumber = tonumber,\
		loadstring = loadstring,\
		error = error, -- maybe don't have this\
		tostring = tostring,\
		type = type,\
		coroutine = coroutine,\
		next = next,\
		unpack = unpack,\
		colours = colours,\
		pcall = pcall,\
		math = math,\
		pairs = pairs,\
		rawget = rawget,\
		_G = _G,\
		__inext = __inext,\
		read = read,\
		ipairs = ipairs,\
		xpcall = xpcall,\
		rawequal = rawequal,\
		setfenv = setfenv,\
		http = http, --create an ajax thing to replace this\
		string = string,\
		setmetatable = setmetatable,\
		getmetatable = getmetatable,\
		table = table,\
		parallel = parallel, -- this mightn't work properly\
		textutils = textutils,\
		colors = colors,\
		vector = vector,\
		select = select,\
		os = {\
			version = os.version,\
			getComputerID = os.getComputerID,\
			getComputerLabel = os.getComputerLabel,\
			clock = os.clock,\
			time = os.time,\
			day = os.day,\
		},\
		lQuery = lQuery.fn,\
		l = lQuery.fn,\
		setTimeout = function(func, delay)\
			if type(func) == 'function' and type(delay) == 'number' then\
				local t = self.Bedrock:StartTimer(func, delay)\
				table.insert(self.Timers, t)\
				return t\
			end\
		end,\
		setInterval = function(func, interval)\
			if type(func) == 'function' and type(interval) == 'number' then\
				local t = self.Bedrock:StartRepeatingTimer(function(timer)\
					table.insert(self.Timers, timer)\
					func()\
				end, interval)\
				table.insert(self.Timers, t)\
				return t\
			end\
		end,\
		clearTimeout = function(timer)\
			self.Bedrock.Timers[timer] = nil\
		end,\
		clearInterval = function(timer)\
			self.Bedrock.Timers[timer] = nil\
		end,\
		window = {\
			location = self.URL,\
			realLocation = self.LoadingURL,\
			get = getValues,\
			version = QuestVersion\
		}\
	}\
end\
\
LoadScript = function(self, script)\
	local fn, err = loadstring(script, 'Script Tag Error: '..self.URL)\
	if fn then\
		setfenv(fn, self.ScriptEnvironment)\
		fn()\
	else\
		local start = err:find(': ')\
		self:OnPageLoadFailed(url, err:sub(start + 2), noHistory)\
	end\
end\
\
RemoveElement = function(self, elem)\
	local elements = {}\
	local node = true\
	node = function(tbl)\
		for i,v in ipairs(tbl) do\
			if type(v) == 'table' then\
				if v == elem.Element then\
					elem.Parent:RemoveObject(elem)\
					v = nil\
					return\
				end\
				if v.Children then\
					local r = node(v.Children)\
				end\
			end\
		end\
	end\
	node(self.Tree.Tree)\
end",["FloatView.lua"]="Inherit = 'View'\
IsFloat = true\
Align = \"Left\"",["FormView.lua"]="Inherit = 'View'\
\
OnTab = function(self)\
	local active = self.Bedrock:GetActiveObject()\
	local selected = nil\
	local selectNext = false\
	local function node(tree)\
		for i, v in ipairs(tree) do\
			if selectNext then\
				if v.Type == 'TextBox' or v.Type == 'SecureTextBox' then\
					selected = v\
					return\
				end\
			elseif v == active then\
				selectNext = true\
			end\
			if v.Children then\
				node(v.Children)\
			end\
		end\
	end\
	node(self.Children)\
\
	if selected then\
		self.Bedrock:SetActiveObject(selected)\
	end\
end",},["Views"]={["main.view"]="{\
  [\"Children\"]={\
    [1]={\
      [\"Y\"]=1,\
      [\"X\"]=1,\
      [\"Name\"]=\"Toolbar\",\
      [\"Type\"]=\"View\",\
      [\"InheritView\"]=\"toolbar\"\
    },\
    [2]={\
      [\"Y\"]=4,\
      [\"X\"]=1,\
      [\"Height\"]=\"100%,-3\",\
      [\"Width\"]=\"100%\",\
      [\"Name\"]=\"WebView\",\
      [\"Type\"]=\"WebView\"\
    },\
    [3]={\
      [\"Y\"]=1,\
      [\"X\"]=1,\
      [\"Height\"]=1,\
      [\"Width\"]=\"100%\",\
      [\"Name\"]=\"PageTitleLabel\",\
      [\"Type\"]=\"Label\",\
      [\"Align\"]=\"Center\",\
      [\"TextColour\"]=128,\
    },\
  },\
  [\"BackgroundColour\"]=1,\
  [\"ToolBarColour\"]=256,\
  [\"ToolBarTextColour\"]=1\
}",["optionsmenu.view"]="{\
  [\"Type\"]=\"Menu\",\
  [\"Owner\"]=\"OptionsButton\",\
  [\"Children\"]={\
    [1]={\
      [\"Name\"]=\"StopMenuItem\",\
      [\"Type\"]=\"Button\",\
      [\"Text\"]=\"Stop\"\
    },\
    [2]={\
      [\"Name\"]=\"ReloadMenuItem\",\
      [\"Type\"]=\"Button\",\
      [\"Text\"]=\"Reload\"\
    },\
    [3]={\
      [\"Name\"]=\"GoHomeMenuItem\",\
      [\"Type\"]=\"Button\",\
      [\"Text\"]=\"Go Home\"\
    },\
    [4]={\
      [\"Name\"]=\"SetHomeMenuItem\",\
      [\"Type\"]=\"Button\",\
      [\"Text\"]=\"Set Home\"\
    },\
    [5]={\
      [\"Name\"]=\"Separator\",\
      [\"Type\"]=\"Separator\"\
    },\
    [6]={\
      [\"Name\"]=\"QuitMenuItem\",\
      [\"Type\"]=\"Button\",\
      [\"Text\"]=\"Quit\"\
    }\
  },\
}",["toolbar.view"]="{\
  [\"Width\"]=\"100%\",\
  [\"Height\"]=3,\
  [\"Type\"]=\"View\",\
  [\"BackgroundColour\"]=256,\
  [\"Children\"]={\
    [1]={\
      [\"Y\"]=2,\
      [\"X\"]=2,\
      [\"Name\"]=\"BackButton\",\
      [\"Type\"]=\"Button\",\
      [\"Enabled\"]=false,\
      [\"TextColour\"]=128,\
      [\"Text\"]=\"<\",\
      [\"BackgroundColour\"]=1\
    },\
    [2]={\
      [\"Y\"]=2,\
      [\"X\"]=6,\
      [\"Name\"]=\"ForwardButton\",\
      [\"Type\"]=\"Button\",\
      [\"Enabled\"]=false,\
      [\"TextColour\"]=128,\
      [\"Text\"]=\">\",\
      [\"BackgroundColour\"]=1\
    },\
    [3]={\
      [\"Y\"]=2,\
      [\"X\"]=10,\
      [\"Width\"]=\"100%,-14\",\
      [\"Type\"]=\"View\",\
      [\"BackgroundColour\"]=1\
    },\
    [4]={\
      [\"Y\"]=2,\
      [\"X\"]=10,\
      [\"Width\"]=\"100%,-14\",\
      [\"Name\"]=\"URLTextBox\",\
      [\"Type\"]=\"TextBox\",\
      [\"TextColour\"]=128,\
      [\"Placeholder\"]=\"Website URL...\",\
      [\"PlaceholderTextColour\"]=256,\
      [\"BackgroundColour\"]=0,\
      [\"SelectOnClick\"]=true\
    },\
    [5]={\
      [\"Y\"]=2,\
      [\"X\"]=10,\
      [\"Width\"]=\"100%,-14\",\
      [\"Name\"]=\"LoadingLabel\",\
      [\"Type\"]=\"Label\",\
      [\"TextColour\"]=256,\
      [\"Text\"]=\"Loading...\",\
      [\"BackgroundColour\"]=1,\
      [\"Align\"]=\"Center\",\
      [\"Visible\"]=false\
    },\
    [6]={\
      [\"Y\"]=2,\
      [\"X\"]=\"100%,-3\",\
      [\"Name\"]=\"OptionsButton\",\
      [\"Type\"]=\"Button\",\
      [\"Text\"]=\"V\",\
      [\"TextColour\"]=128,\
      [\"BackgroundColour\"]=1\
    },\
  },\
}",},}

local function run(tArgs)

  local fnFile, err = loadstring(files['startup'], 'startup')
  if err then
    error(err)
  end

  local function split(str, pat)
     local t = {}
     local fpat = "(.-)" .. pat
     local last_end = 1
     local s, e, cap = str:find(fpat, 1)
     while s do
        if s ~= 1 or cap ~= "" then
     table.insert(t,cap)
        end
        last_end = e+1
        s, e, cap = str:find(fpat, last_end)
     end
     if last_end <= #str then
        cap = str:sub(last_end)
        table.insert(t, cap)
     end
     return t
  end

  local function resolveTreeForPath(path, single)
    local _files = files
    local parts = split(path, '/')
    if parts then
      for i, v in ipairs(parts) do
        if #v > 0 then
          if _files[v] then
            _files = _files[v]
          else
            _files = nil
            break
          end
        end
      end
    elseif #path > 0 and path ~= '/' then
      _files = _files[path]
    end
    if not single or type(_files) == 'string' then
      return _files
    end
  end

  local oldFs = fs
  local env
  env = {
    fs = {
      list = function(path)
              local list = {}
              if fs.exists(path) then
            list = fs.list(path)
              end
        for k, v in pairs(resolveTreeForPath(path)) do
          if not fs.exists(path .. '/' ..k) then
            table.insert(list, k)
          end
        end
        return list
      end,

      exists = function(path)
        if fs.exists(path) then
          return true
        elseif resolveTreeForPath(path) then
          return true
        else
          return false
        end
      end,

      isDir = function(path)
        if fs.isDir(path) then
          return true
        else
          local tree = resolveTreeForPath(path)
          if tree and type(tree) == 'table' then
            return true
          else
            return false
          end
        end
      end,

      isReadOnly = function(path)
        if not fs.isReadOnly(path) then
          return false
        else
          return true
        end
      end,

      getName = fs.getName,

      getSize = fs.getSize,

      getFreespace = fs.getFreespace,

      makeDir = fs.makeDir,

      move = fs.move,

      copy = fs.copy,

      delete = fs.delete,

      combine = fs.combine,

      open = function(path, mode)
        if fs.exists(path) then
          return fs.open(path, mode)
        elseif type(resolveTreeForPath(path)) == 'string' then
          local handle = {close = function()end}
          if mode == 'r' then
            local content = resolveTreeForPath(path)
            handle.readAll = function()
              return content
            end

            local line = 1
            local lines = split(content, '\n')
            handle.readLine = function()
              if line > #lines then
                return nil
              else
                return lines[line]
              end
              line = line + 1
            end
                      return handle
          else
            error('Cannot write to read-only file (compilr archived).')
          end
        else
          return fs.open(path, mode)
        end
      end
    },

    loadfile = function( _sFile )
        local file = env.fs.open( _sFile, "r" )
        if file then
            local func, err = loadstring( file.readAll(), fs.getName( _sFile ) )
            file.close()
            return func, err
        end
        return nil, "File not found: ".._sFile
    end,

    dofile = function( _sFile )
        local fnFile, e = env.loadfile( _sFile )
        if fnFile then
            setfenv( fnFile, getfenv(2) )
            return fnFile()
        else
            error( e, 2 )
        end
    end
  }

  setmetatable( env, { __index = _G } )

  local tAPIsLoading = {}
  env.os.loadAPI = function( _sPath )
      local sName = fs.getName( _sPath )
      if tAPIsLoading[sName] == true then
          printError( "API "..sName.." is already being loaded" )
          return false
      end
      tAPIsLoading[sName] = true
          
      local tEnv = {}
      setmetatable( tEnv, { __index = env } )
      local fnAPI, err = env.loadfile( _sPath )
      if fnAPI then
          setfenv( fnAPI, tEnv )
          fnAPI()
      else
          printError( err )
          tAPIsLoading[sName] = nil
          return false
      end
      
      local tAPI = {}
      for k,v in pairs( tEnv ) do
          tAPI[k] =  v
      end
      
      env[sName] = tAPI    
      tAPIsLoading[sName] = nil
      return true
  end

  env.shell = shell

  setfenv( fnFile, env )
  fnFile(unpack(tArgs))
end

local function extract()
    local function node(path, tree)
        if type(tree) == 'table' then
            fs.makeDir(path)
            for k, v in pairs(tree) do
                node(path .. '/' .. k, v)
            end
        else
            local f = fs.open(path, 'w')
            if f then
                f.write(tree)
                f.close()
            end
        end
    end
    node('', files)
end

local tArgs = {...}
if #tArgs == 1 and tArgs[1] == '--extract' then
  extract()
else
  run(tArgs)
end
