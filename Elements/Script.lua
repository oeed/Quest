Tag = nil
Text = nil
URL = nil

Initialise = function(self, node)
	local new = {}    -- the new instance
	setmetatable( new, {__index = self} )
	local attr = node._attr
	new.Tag = node._tag
	new.Attributes = attr
	new.Text = table.concat(node, '\n')

	if attr.src then
		new.URL = attr.src
		new.Text = nil
	end

	return new
end

InsertScript = function(self, webView)
	if self.Text then
		webView:LoadScript(self.Text)
	elseif self.URL then
		fetchHTTPAsync(resolveFullUrl(self.URL), function(ok, event, response)
			if ok then
				self.Text = response.readAll()
				webView:LoadScript(self.Text)
			end
		end)

	end
	return nil
end