local _G = _G
local DA = DungeonAssist

local function DungeonAssistSlashCommands(msg, editbox)
    DA.showMainFrame()
end

SLASH_DUNGEONASSIST1, SLASH_DUNGEONASSIST2, SLASH_DUNGEONASSIST3 = '/da', '/dungeonassist', '/dungeon-assist'

SlashCmdList["DUNGEONASSIST"] = DungeonAssistSlashCommands