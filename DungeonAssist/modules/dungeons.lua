local _G = _G
local DA = DungeonAssist
local L = DA.L

local function getDungeonData(dungeon)
    data = {}
    hasMoreBosses = true
    bossNum = 1

    while hasMoreBosses do
        if L[dungeon .. '_BOSS_' .. bossNum .. '_NAME'] ~= nil then
            data[bossNum] = {boss="", icon="", mechanics={}}
            data[bossNum].bossShortName = L[dungeon .. '_BOSS_' .. bossNum .. '_SHORT_NAME']
            data[bossNum].boss = L[dungeon .. '_BOSS_' .. bossNum .. '_NAME']
            data[bossNum].icon = L[dungeon .. '_BOSS_' .. bossNum .. '_ICON']
            
            hasMoreMechanics = true
            mechanicsNum = 1
            while hasMoreMechanics do
                if L[dungeon .. '_BOSS_' .. bossNum .. '_MECHANICS_' .. mechanicsNum] ~= nil then
                    data[bossNum].mechanics[mechanicsNum] = L[dungeon .. '_BOSS_' .. bossNum .. '_MECHANICS_' .. mechanicsNum]
                else
                    hasMoreMechanics = false
                end
                mechanicsNum = mechanicsNum + 1
            end
            bossNum = bossNum + 1
        else
            hasMoreBosses = false
        end
    end

    return data
end

function DA:GetDungeonData(mapId)
    -- Found on https://wowpedia.fandom.com/wiki/InstanceID

        if mapId == 2291 then return getDungeonData("DE_OTHER_SIDE")
    elseif mapId == 2287 then return getDungeonData("HALLS_OF_ATONEMENT")
    elseif mapId == 2290 then return getDungeonData("MISTS_OF_TIRNA_SCITHE")
    elseif mapId == 2289 then return getDungeonData("PLAGUEFALL")
    elseif mapId == 2284 then return getDungeonData("SANGUINE_DEPTHS")
    elseif mapId == 2285 then return getDungeonData("SPIRES_OF_ASCENSION")
    elseif mapId == 2286 then return getDungeonData("THE_NECROTIC_WAKE")
    elseif mapId == 2293 then return getDungeonData("THEATER_OF_PAIN")
    elseif mapId == 2296 then return getDungeonData("CASTLE_NATHRIA")
    end
end