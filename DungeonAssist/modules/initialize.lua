local _G = _G
local DA = DungeonAssist
DA.LS = LibStub
DA.L = DA.LS("AceLocale-3.0"):GetLocale("DungeonAssist")

DA.addon = DA.LS("AceAddon-3.0"):NewAddon("DungeonAssist", "AceConsole-3.0", "AceEvent-3.0", "AceComm-3.0")

local dungeonAssistLDB = DA.LS("LibDataBroker-1.1"):NewDataObject("DungeonAssist", {
    type = "data source",
	text = "DungeonAssist",
	icon = "Interface\\AddOns\\DungeonAssist\\media\\texture\\logo@2x",
	OnClick = function(self, button)
		if button == 'LeftButton' then 
			DA:toggle()
		elseif button == 'RightButton' then
            DA.DungeonAssistOptionsMain.Open()
		end  
	end,
	OnTooltipShow = function(tooltip)
		tooltip:AddLine("Dungeon Assist")
		tooltip:AddLine('Left click to toggle Dungeon Assist window')
		tooltip:AddLine('Right Click to toggle options')
	end,
})

DA.icon = DA.LS("LibDBIcon-1.0")

function DA.addon:OnInitialize()
    DA:addDefaultSettings('general', 'show_minimap_button', 
    {
        isEnabled = true,
    })
    DA:addDefaultSettings('window', 'position', {
        point = "CENTER",
        xOfs = 0,
        yOfs = 0
    })
    
	self.db = DA.LS("AceDB-3.0"):New("DungeonAssistMinimap", {
		profile = {
			minimap = {
				hide = not DungeonAssistSettings.general.show_minimap_button.isEnabled,
			},
		},
	})

	DA.icon:Register("DungeonAssist", dungeonAssistLDB, self.db.profile.minimap)

    DA:createOptions()
end

function DA.addon:OnEnable()
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	DA.addon:RegisterComm("DAEvent")
end

function DA.addon:OnCommReceived(prefix, message, distribution, sender)
	DA:onDungeonAssistEvent(prefix, message, distribution, sender)
end