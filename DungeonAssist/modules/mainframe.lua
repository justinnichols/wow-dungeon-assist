local _G = _G
local DA = DungeonAssist
local AceGUI = DA.LS("AceGUI-3.0")
local L = DA.L
local CHAT_DELAY = 2
local IS_POSTING = false
local window = nil

function DA:onBossClick(numMembers, instanceType, bossData, isLFG)
    if (IS_POSTING) then return end

    IS_POSTING = true
    local chatType = "SAY"
    if (numMembers > 1) then
        if (isLFG) then chatType = "INSTANCE_CHAT"
        elseif (instanceType == "party") then chatType = "PARTY"
        elseif (instanceType == "raid") then chatType = "RAID"
        end
    end
    SendChatMessage("Boss Mechanics for: " .. bossData.boss, chatType)
    DA:wait(CHAT_DELAY, sendChat, bossData.mechanics, 1, chatType)
end

function sendChat(mechanics, index, chatType)
    if (index > #mechanics) then
        IS_POSTING = false
        return 
    end

    SendChatMessage(mechanics[index], chatType)

    DA:wait(CHAT_DELAY, sendChat, mechanics, index + 1, chatType)
end

function DA:toggle()
    if window == nil then
        DA:showMainFrame()
    else
        DA:hideMainFrame()
    end
end

function DA:hideMainFrame()
    if window ~= nil then
        window:Hide()
    end
end

function DA:showMainFrame()
    local instanceName, instanceType, _, instanceDifficulty, _, _, _, instanceMapID, _ = GetInstanceInfo()
    local numMembers = GetNumGroupMembers();
    local dungeonData = DA:GetDungeonData(instanceMapID)

    if window == nil then
        if (dungeonData ~= nil) then
            window = AceGUI:Create("Window")
            local title = instanceName
            if instanceDifficulty ~= nil and instanceDifficulty ~= '' then title = title .. " (" .. instanceDifficulty .. ")" end
            window:SetTitle(title)
            window:SetWidth(355)
            window:SetHeight((math.ceil(#dungeonData / 3) * 72) + 60)
            window:EnableResize(false)
            window:ClearAllPoints()
            window:SetPoint(
                DungeonAssistSettings.window.position.point,
                "UIParent",
                DungeonAssistSettings.window.position.point,
                DungeonAssistSettings.window.position.xOfs,
                DungeonAssistSettings.window.position.yOfs
            )
            window:SetCallback("OnClose", 
                function(widget) 
                    local point, _, _, xOfs, yOfs = window:GetPoint()
                    DungeonAssistSettings.window.position.point = point
                    DungeonAssistSettings.window.position.xOfs = xOfs
                    DungeonAssistSettings.window.position.yOfs = yOfs
                    AceGUI:Release(widget) 
                    window = nil
                end)
            window:SetLayout("Table")
            window:SetUserData("table", {
                columns = {110, 110, 110},
                space = 2,
                align = "middle"
            })

            for _, v in ipairs(dungeonData) do
                local icon = AceGUI:Create("Icon")
                icon:SetImage("Interface\\AddOns\\DungeonAssist\\" .. v.icon)
                icon:SetImageSize(100, 50)
                icon:SetLabel(v.boss)
                icon:SetCallback("OnClick", function(widget) DA:onBossClick(numMembers, instanceType, v, IsInGroup(LE_PARTY_CATEGORY_INSTANCE)) end)
                icon:SetCallback("OnEnter", function(widget) widget:SetImageSize(120, 60) end)
                icon:SetCallback("OnLeave", function(widget) widget:SetImageSize(100, 50) end)
                window:AddChild(icon)
            end
        else
            window = AceGUI:Create("Window")
            window:SetTitle("No Dungeon")
            window:SetWidth(360)
            window:SetHeight(130)
            window:EnableResize(false)
            window:ClearAllPoints()
            window:SetPoint(
                DungeonAssistSettings.window.position.point,
                "UIParent",
                DungeonAssistSettings.window.position.point,
                DungeonAssistSettings.window.position.xOfs,
                DungeonAssistSettings.window.position.yOfs
            )
            window:SetCallback("OnClose", 
                function(widget) 
                    local point, _, _, xOfs, yOfs = window:GetPoint()
                    DungeonAssistSettings.window.position.point = point
                    DungeonAssistSettings.window.position.xOfs = xOfs
                    DungeonAssistSettings.window.position.yOfs = yOfs
                    AceGUI:Release(widget) 
                    window = nil
                end)
            window:SetLayout("List")

            local spacer = AceGUI:Create("Icon")
            spacer:SetImage("Interface\\AddOns\\DungeonAssist\\icons\\1x1.tga")
            spacer:SetImageSize(0, 18)
            window:AddChild(spacer)

            local label = AceGUI:Create("Label")
            label:SetJustifyH("CENTER")
            label:SetJustifyV("MIDDLE")
            label:SetText(L["NOT_SUPPORTED"])
            label:SetFontObject(GameFontHighlightLarge)
            label:SetWidth(340)
            window:AddChild(label)
        end
    end
end

function DA.addon:PLAYER_ENTERING_WORLD(event)
    if window ~= nil then
        DA:hideMainFrame()
        DA:showMainFrame()
    end
end