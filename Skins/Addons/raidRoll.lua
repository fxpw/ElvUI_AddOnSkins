local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("RaidRoll") then return end

-- RaidRoll 4.4.15
-- https://www.curseforge.com/wow/addons/raid-roll/files/450070

S:AddCallbackForAddon("RaidRoll", "RaidRoll", function()
	if not E.private.addOnSkins.RaidRoll then return end

	RR_RollFrame:SetTemplate("Transparent")
	if RR_NAME_FRAME then
		RR_NAME_FRAME:SetTemplate("Default")
	end
	S:HandleCloseButton(RR_Close_Button, RR_RollFrame)
	if RaidRoll_Slider_ID then
		RaidRoll_Slider_ID:SetHitRectInsets(0, 0, 0, 0)
		S:HandleSliderFrame(RaidRoll_Slider_ID)
	end

	S:HandleButton(RaidRoll_AnnounceWinnerButton)
	S:HandleButton(RR_Roll_5SecAndAnnounce)
	S:HandleButton(RR_Roll_RollButton)
	S:HandleButton(RR_Last)
	S:HandleButton(RR_Clear)
	S:HandleButton(RR_Next)
	S:HandleButton(RaidRoll_OptionButton)
	if RR_Roll_5SecAndAnnounce then
		RR_Roll_5SecAndAnnounce:ClearAllPoints()
		RR_Roll_5SecAndAnnounce:Point("BOTTOM", 0, 31)
	end
	if RR_Clear then
		RR_Clear:Point("BOTTOM", 0, 8)
	end
	if RR_Last then
		RR_Last:Point("BOTTOM", -45, 8)
	end
	if RR_Roll_RollButton then
		RR_Roll_RollButton:Point("BOTTOMRIGHT", RR_RollFrame, "BOTTOM", -65, 8)
	end
	if RR_Next then
		RR_Next:Point("BOTTOM", 45, 8)
	end
	if RaidRoll_OptionButton then
		RaidRoll_OptionButton:Size(20)
		RaidRoll_OptionButton:Point("BOTTOM", 75, 8)
	end
	if RR_Frame then
		RR_Frame:SetTemplate("Transparent")
		RR_Frame:Width(185)
		RR_Frame:Point("TOP", RR_RollFrame, "BOTTOM", 0, 1)
	end
	if RR_Frame and  RaidRoll_Catch_All and RaidRoll_Allow_All and RaidRollCheckBox_ExtraRolls then
		local rrframeLevel = RR_Frame:GetFrameLevel()
		RaidRoll_Catch_All:SetFrameLevel(rrframeLevel + 2)
		RaidRoll_Allow_All:SetFrameLevel(rrframeLevel + 2)
		RaidRollCheckBox_ExtraRolls:SetFrameLevel(rrframeLevel + 2)
	end
	S:HandleCheckBox(RaidRoll_Catch_All)
	S:HandleCheckBox(RaidRoll_Allow_All)
	S:HandleCheckBox(RaidRollCheckBox_ExtraRolls)

	S:HandleButton(Raid_Roll_ClearSymbols)
	S:HandleButton(Raid_Roll_ClearRolls)
	S:HandleButton(RaidRoll_ExtraOptionButton)

	for i = 1, 5 do
		local f = _G["Raid_Roll_SetSymbol"..i]
		if f then
			f:ClearAllPoints()
			f:Point("TOPLEFT", _G["RR_RollerPos"..i], "TOPRIGHT", -15, -1)
			f:Point("BOTTOMRIGHT", _G["RR_Rolled"..i], "BOTTOMLEFT", 45, -1)

			local highlight = f:GetHighlightTexture()
			highlight:SetTexture(E.Media.Textures.Highlight)
			highlight:SetVertexColor(0.9, 0.9, 0.9, 0.35)
		end
	end

	if E.private.general.replaceBlizzFonts and GetLocale() ~= "zhCN" then
		local fontTemplate = RR_Roller1.FontTemplate
		local function updateFont(self, font, size, flag)
			self.SetFont = nil
			fontTemplate(self, nil, nil, flag)
			self.SetFont = updateFont
		end

		for i = 1, 5 do
			if _G["RR_Roller"..i] then
				_G["RR_Roller"..i].SetFont = updateFont
			end
		end
	end
end)

S:AddCallbackForAddon("RaidRoll_LootTracker", "RaidRoll_LootTracker", function()
	if not E.private.addOnSkins.RaidRoll then return end
	if RR_LOOT_FRAME then
		RR_LOOT_FRAME:SetTemplate("Transparent")
	end

	S:HandleSliderFrame(RaidRoll_Loot_Slider_ID)

	S:HandleButton(RR_Loot_LinkLootButton)
	S:HandleButton(RR_Loot_ButtonClear)
	S:HandleButton(RR_Loot_ButtonFirst)
	S:HandleButton(RR_Loot_ButtonPrev)
	S:HandleButton(RR_Loot_ButtonNext)
	S:HandleButton(RR_Loot_ButtonLast)

	for i = 1, 4 do
		if _G["RR_Loot_Announce_1_Button_"..i] then
			_G["RR_Loot_Announce_1_Button_"..i]:Show()
		end
		if _G["RR_Loot_Announce_2_Button_"..i] then
			_G["RR_Loot_Announce_2_Button_"..i]:Show()
		end
		if _G["RR_Loot_Announce_3_Button_"..i] then
			_G["RR_Loot_Announce_3_Button_"..i]:Show()
		end
		if _G["RR_Loot_RaidRollButton_"..i] then
			_G["RR_Loot_RaidRollButton_"..i]:Show()
		end
		S:HandleButton(_G["RR_Loot_Announce_1_Button_"..i])
		S:HandleButton(_G["RR_Loot_Announce_2_Button_"..i])
		S:HandleButton(_G["RR_Loot_Announce_3_Button_"..i])
		S:HandleButton(_G["RR_Loot_RaidRollButton_"..i])
	end
	if RR_LOOT_FRAME then
		for i = 1, RR_LOOT_FRAME:GetNumChildren() do
			local child = select(i, RR_LOOT_FRAME:GetChildren())
			if child and child:IsObjectType("Button") and child:GetName() == "Close_Button" then
				S:HandleCloseButton(child)
				break
			end
		end
	end
end)