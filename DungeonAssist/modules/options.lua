local _G = _G
local DA = DungeonAssist
local L = DA.L
local AceConfig = DA.LS("AceConfig-3.0")
local AceConfigDialog = DA.LS("AceConfigDialog-3.0")

local function createMainPanel()
	local frame = CreateFrame("Frame", "DungeonAssistOptionsMain", UIParent)
	local title = frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
	local version = frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
	local authors = frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
	-- local contributors = frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
	title:SetFormattedText("%s", "Dungeon Assist")
	title:SetPoint("CENTER", frame, "CENTER", 0, 170)
	version:SetFormattedText("%s %s", _G.GAME_VERSION_LABEL, GetAddOnMetadata("DungeonAssist", "Version"))
	version:SetPoint("CENTER", frame, "CENTER", 0, 130)
	authors:SetFormattedText("%s: Elannah-Farstriders, Sunyata-Farstriders", L["AUTHORS"])
	authors:SetPoint("CENTER", frame, "CENTER", 0, 100)
	-- contributors:SetFormattedText("%s: ", L["CONTRIBUTORS"])
	-- contributors:SetPoint("CENTER", frame, "CENTER", 0, 100)
	return frame
end

local optionsPanel = {
    order = 1,
    type = "group",
    name = _G.MAIN_MENU,
    args = {
        minimap = {
            order = 1,
            type = "toggle",
            width = "full",
            name = L["ENABLE_MINIMAP_BUTTON"],
            get = function() return DungeonAssistSettings.general.show_minimap_button.isEnabled end,
            set = function(info, value)
                    DungeonAssistSettings.general.show_minimap_button.isEnabled = value
                    if DungeonAssistSettings.general.show_minimap_button.isEnabled then
                        DA.icon:Show('DungeonAssist')
                    else
                        DA.icon:Hide('DungeonAssist')
                    end
                end,
        },
    },
}

function DA:createOptions()
    DA.DungeonAssistOptionsMain = createMainPanel()
	DA.DungeonAssistOptionsMain.name = "Dungeon Assist"
	InterfaceOptions_AddCategory(DA.DungeonAssistOptionsMain)

    DA.DungeonAssistOptionsMain.Open = function()
        -- Open the Options menu.
        if InterfaceOptionsFrame:IsVisible() then
            InterfaceOptionsFrame_Show();
        else
            InterfaceOptionsFrame_OpenToCategory(DA.OptionsFrame);
            InterfaceOptionsFrame_OpenToCategory(DA.OptionsFrame);
        end
    end

	AceConfig:RegisterOptionsTable("DungeonAssistOptionsPanel", optionsPanel)
    DA.OptionsFrame = AceConfigDialog:AddToBlizOptions("DungeonAssistOptionsPanel", _G.MAIN_MENU, "Dungeon Assist")
	DA.OptionsFrame.default = function() resetoptions() end
end