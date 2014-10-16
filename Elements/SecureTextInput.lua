SelectedBackgroundColour = colours.blue
SelectedTextColour = colours.white
PlaceholderTextColour = colours.grey
Placeholder = ''
Value = nil
Attributes = nil
Children = nil
Tag = nil
Width = 20
InputName = ''

OnInitialise = function(self, node)
	if attr.selbgcolour then
		self.SelectedBackgroundColour = self:ParseColour(attr.selbgcolour)
	elseif attr.selbgcolor then
		self.SelectedBackgroundColour = self:ParseColour(attr.selbgcolor)
	end

	if attr.selcolour then
		self.SelectedTextColour = self:ParseColour(attr.selcolour)
	elseif attr.selcolor then
		self.SelectedTextColour = self:ParseColour(attr.selcolor)
	end

	if attr.plcolour then
		self.PlaceholderTextColour = self:ParseColour(attr.plcolour)
	elseif attr.plcolour then
		self.PlaceholderTextColour = self:ParseColour(attr.plcolour)
	end

	if attr.value then
		self.Value = attr.value
	end

	if attr.placeholder then
		self.Placeholder = attr.placeholder
	end

	if attr.name then
		self.InputName = attr.name
	end
end

UpdateValue = function(self)
	self.Value = self.Object.Text
end

OnCreateObject = function(self, parentObject, y)
	return {
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
	}
end