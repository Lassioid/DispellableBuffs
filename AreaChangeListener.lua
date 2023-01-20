local WarZones = {
    "Warsong Gulch", 
    "Arathi Basin", 
    "Alterac Valley", 
    "Eye of the Storm",
    "Ruins of Lordaeron",
    "Blade's Edge Arena",
    "Dalaran Arena",
    "Nagrand Arena"
}

local AreaChangeKit = CreateFrame("Frame")

AreaChangeKit:RegisterEvent("ZONE_CHANGED_NEW_AREA")

AreaChangeKit:SetScript("OnEvent", function(self, evnet, ...)
    print(GetZoneText())
    --[[
        Register Events for SpellIcon Frame 
    --]]
end)