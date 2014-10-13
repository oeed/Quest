Text = nil
TextColour = colours.black
BackgroundColour = colours.transparent
Attributes = nil
Children = nil
Tag = nil

Initialise = function(self, node)
	local new = {}    -- the new instance
	setmetatable( new, {__index = self} )
	local attr = node._attr
	new.Tag = node._tag
	new.Attributes = attr
	new.Text = node[1]
	new.Children = {}
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
	-- print('make heading')
	-- print(new.Text)
	-- print(new.TextColour)
	-- print(new.BackgroundColour)

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
-- print('crate at '..y)
	return parentObject:AddObject({
		Element = self,
		Y = y,
		X = 1,
		Width = "100%",
		Align = "Center",
		Type = "HeadingView",
		Text = self.Text,
		TextColour = self.TextColour,
		BackgroundColour = self.BackgroundColour
	})
end