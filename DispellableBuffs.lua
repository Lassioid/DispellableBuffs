local defensive_auras = {
    ["Ice Barrier"] = "Interface\\ICONS\\Spell_Ice_Lament.blp",
    ["Power Word: Shield"] = "Interface\\ICONS\\Spell_Holy_PowerWordShield.blp",
    ["Sacred Shield"] = "Interface\\ICONS\\ability_paladin_blessedmending.blp",
}

function isListedAura(auras, aura)
    if auras[aura] ~= nil 
        then return auras[aura] 
        else return false
    end
end

function hasAura(auras)
    local isActive
    for y = 1, 25 do
        local auraY = UnitBuff("target", y);
        if auraY ~= nil then
            isActive = isListedAura(auras, auraY)
        end
    end
    return isActive
end

local Portrait = CreateFrame("ScrollFrame", "Player_Buff_Portrait", TargetFrame)

Portrait:SetPoint("CENTER", 41, 6)
Portrait:SetSize(64, 64)
Portrait:SetClipsChildren(true)

Portrait.tex = Portrait:CreateTexture(nil, "ARTWORK")
Portrait.tex:SetAllPoints(Portrait)
Portrait.tex:SetTexture("Interface/Tooltips/UI-Tooltip-Background")
Portrait.tex:SetColorTexture(0, 0, 0, 0)

Portrait.mask = Portrait:CreateMaskTexture()
Portrait.mask:SetAllPoints(Portrait.tex)
Portrait.mask:SetTexture("Interface/CHARACTERFRAME/TempPortraitAlphaMask", "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
Portrait.tex:AddMaskTexture(Portrait.mask)

local SpellIcon = CreateFrame("Frame", nil, Portrait)

SpellIcon:SetPoint("CENTER")
SpellIcon:SetSize(64, 64)

SpellIcon.tex = SpellIcon:CreateTexture()
SpellIcon.tex:SetAllPoints(SpellIcon)

local UnitAuraKit = CreateFrame("Frame", nil, TargetFrame)

UnitAuraKit:RegisterEvent("UNIT_AURA")
UnitAuraKit:RegisterEvent("PLAYER_TARGET_CHANGED")

UnitAuraKit:SetScript("OnEvent", function(self, event, unit)

    if event == "PLAYER_TARGET_CHANGED" then
        if UnitIsPlayer("target") then 
            for x = 1, 25 do
                local buff = UnitBuff("target", x)
                if buff ~= nil then 
                    if isListedAura(defensive_auras, buff) then
                        SetPortraitToTexture(SpellIcon.tex, defensive_auras[buff])
                        SpellIcon:Show()
                    end
                end
            end
        else
            SpellIcon:Hide()
        end 
    end

    if event == "UNIT_AURA" then 
        for x = 1, 25 do
            local buff = UnitBuff("target", x)
            if unit == "target" and buff ~= nil then
                if isListedAura(defensive_auras, buff) then
                    SetPortraitToTexture(SpellIcon.tex, defensive_auras[buff])
                    SpellIcon:Show()
                end
                if not hasAura(defensive_auras) then 
                    SpellIcon:Hide()
                end
            end   
        end
    end

end)


--Interface\\ICONS\\Spell_Holy_PowerWordShield.blp
--Interface\\ICONS\\Spell_Holy_PowerWordShield.blp
--Interface\\ICONS\\ability_paladin_blessedmending.blp
--Interface\\ICONS\\Spell_Ice_Lament.blp
--PLAYER_TARGET_CHANGED
--ZONE_CHANGED_NEW_AREA