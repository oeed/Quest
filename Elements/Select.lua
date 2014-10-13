BackgroundColour = colours.lightGrey
TextColour = colours.black
Attributes = nil
Children = nil
Tag = nil
Width = 20
InputName = ''

Initialise = function(self, node)
	local new = {}    -- the new instance
	setmetatable( new, {__index = self} )
	local attr = node._attr
	new.Tag = node._tag
	new.Attributes = attr
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

	if attr.width then
		new.Width = attr.width
	end

	if attr.value then
		new.Text = attr.value
	end

	if attr.name then
		new.InputName = attr.name
	end

	return new
end

UpdateValue = function(self)
	self.Value = self.Object.MenuItems[self.Object.Selected].Value
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
		Type = "SelectView",
		TextColour = self.TextColour,
		BackgroundColour = self.BackgroundColour,
		InputName = self.InputName,
	})
end