BackgroundColour = colours.lightGrey
SelectedBackgroundColour = colours.blue
SelectedTextColour = colours.white
TextColour = colours.black
PlaceholderTextColour = colours.grey
Placeholder = ''
Value = nil
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

	if attr.selbgcolour then
		new.SelectedBackgroundColour = self:ParseColour(attr.selbgcolour)
	elseif attr.selbgcolor then
		new.SelectedBackgroundColour = self:ParseColour(attr.selbgcolor)
	end

	if attr.selcolour then
		new.SelectedTextColour = self:ParseColour(attr.selcolour)
	elseif attr.selcolor then
		new.SelectedTextColour = self:ParseColour(attr.selcolor)
	end

	if attr.plcolour then
		new.PlaceholderTextColour = self:ParseColour(attr.plcolour)
	elseif attr.plcolour then
		new.PlaceholderTextColour = self:ParseColour(attr.plcolour)
	end

	if attr.width then
		new.Width = attr.width
	end

	if attr.value then
		new.Value = attr.value
	end

	if attr.placeholder then
		new.Placeholder = attr.placeholder
	end

	if attr.name then
		new.InputName = attr.name
	end

	return new
end

UpdateValue = function(self)
	self.Value = self.Object.Text
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
		Type = "SecureTextBox",
		Text = self.Value,
		TextColour = self.TextColour,
		BackgroundColour = self.BackgroundColour,
		SelectedBackgroundColour = self.SelectedBackgroundColour,
		SelectedTextColour = self.SelectedTextColour,
		PlaceholderTextColour = self.PlaceholderTextColour,
		Placeholder = self.Placeholder,
		InputName = self.InputName
	})
end