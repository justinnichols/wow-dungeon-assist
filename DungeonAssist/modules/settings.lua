local _G = _G
local DA = DungeonAssist

if not DungeonAssistSettings then
	DungeonAssistSettings = {}
end

function DA:addDefaultSettings(category, name, data)
	if not category or type(category) ~= 'string' then
		error('addDefaultSettings(category, name, data) category: string expected, received ' .. type(category))
	end
	if data == nil then
		error('addDefaultSettings(data, name, data) data expected, received ' .. type(data))
	end

	if not DungeonAssistSettings[category] then
		DungeonAssistSettings[category] = {}
	end

	if DungeonAssistSettings[category][name] == nil then
		DungeonAssistSettings[category][name] = data
	else
		if type(data) == 'table' then
			for newKey, newValue in pairs(data) do
				local found = false
				for oldKey in pairs(DungeonAssistSettings[category][name]) do
					if oldKey == newKey then
						found = true
						break
					end
				end

				if not found then
					DungeonAssistSettings[category][name][newKey] = newValue
				end
			end
		end
	end
end

