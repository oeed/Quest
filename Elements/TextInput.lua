Inherit = 'SecureTextInput'

OnCreateObject = function(self, parentObject, y)
	return {
		Element = self,
		Y = y,
		X = 1,
		Width = self.Width,
		Type = "TextBox",
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