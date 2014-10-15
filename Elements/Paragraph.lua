Text = nil
TextColour = colours.black
BackgroundColour = colours.transparent
Attributes = nil
Children = nil
Tag = nil
Align = 'Left'
Width = "100%"

Initialise = function(self, node)
	local new = {}    -- the new instance
	setmetatable( new, {__index = self} )
	local attr = node._attr
	new.Tag = node._tag
	new.Attributes = attr
	new.Text = node[1] or ''
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

	if attr.height then
		new.Height = attr.height
	end

	if attr.align then
		if attr.align:lower() == 'left' or attr.align:lower() == 'center' or attr.align:lower() == 'right' then
			new.Align = attr.align:lower():gsub("^%l", string.upper)
		end
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
		Width = self.Width,
		Height = self.Height,
		Align = self.Align,
		Type = "Label",
		Text = self.Text,
		TextColour = self.TextColour,
		BackgroundColour = self.BackgroundColour,
		OnUpdate = function(_self, value)
		    if value == 'Text' then
		        if not self.Attributes.height then
            		_self.Height = #_self.Bedrock.Helpers.WrapText(_self.Text, _self.Width)
					_self.Bedrock:GetObject('WebView'):RepositionLayout()
		        end
		    end
		end
	})
end