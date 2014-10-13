BackgroundColour = colours.lightGrey
TextColour = colours.black
Text = 'Submit'
Attributes = nil
Children = nil
Tag = nil
Width = nil
InputName = ''
Value = nil

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
		Type = "Button",
		Text = self.Text,
		TextColour = self.TextColour,
		BackgroundColour = self.BackgroundColour,
		InputName = self.InputName,
		OnClick = function(_self, event, side, x, y)
			local form = self
			local step = 0
			while form.Tag ~= 'form' and step < 50 do
				form = form.Parent
			end
			self.Value = _self.Text
			if form and form.Submit then
				form:Submit()
			end
		end
	})
end