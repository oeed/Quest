Text = nil
TextColour = colours.blue
BackgroundColour = colours.transparent
Attributes = nil
Children = nil
Tag = nil
Align = 'Left'
Width = "100%"
URL = nil

Initialise = function(self, node)
	local new = {}    -- the new instance
	setmetatable( new, {__index = self} )
	local attr = node._attr
	new.Tag = node._tag
	new.Attributes = attr
	new.Children = {}

	if type(node[1]) == 'string' then
		new.Text = node[1]
	end
	if attr.colour then
		new.TextColour = self:ParseColour(attr.colour)
	elseif attr.color then
		new.TextColour = self:ParseColour(attr.color)
	end

	if attr.bgcolour then
		new.BackgroundColour = self:ParseColour(attr.bgcolour)
	elseif attr.bgcolor then
		new.BackgroundColour = self:ParseColour(attr.bgcolor)
	end

	if attr.width then
		new.Width = attr.width
	end

	if attr.height then
		new.Height = attr.height
	end

	if attr.href then
		new.URL = attr.href
	end

	if attr.align then
		if attr.align:lower() == 'left' or attr.align:lower() == 'center' or attr.align:lower() == 'right' then
			new.Align = attr.align:lower():gsub("^%l", string.upper)
		end
	end

	return new
end


ParseColour = function(self, str)
	if str and type(str) == 'string' then
		if colours[str] and type(colours[str]) == 'number' then
			return colours[str]
		elseif colors[str] and type(colors[str]) == 'number' then
			return colors[str]
		end
	end
end

CreateObject = function(self, parentObject, y)
	return parentObject:AddObject({
		Element = self,
		Y = y,
		X = 1,
		Width = self.Width,
		Align = self.Align,
		Type = "LinkView",
		Text = self.Text,
		TextColour = self.TextColour,
		BackgroundColour = self.BackgroundColour,
		URL = resolveFullUrl(self.URL)
	})
end