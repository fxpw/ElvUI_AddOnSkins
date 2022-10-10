local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("TellMeWhen") then return end

-- local _G = _G
-- local unpack = unpack

-- TellMeWhen 1.2.7
-- https://github.com/fxpw/TMW_Sirus

S:AddCallbackForAddon("TellMeWhen", "TellMeWhen", function()
	if not E.private.addOnSkins.TellMeWhen then return end
	if true then return end
	-- TELLMEWHEN_ICONSPACING = E.Border

	-- if TELLMEWHEN_VERSION == "1.3.5" then
	-- 	hooksecurefunc("TellMeWhen_Group_Update", function(groupID)
	-- 		local group = TellMeWhen_Settings.Groups[groupID] or TellMeWhen_Group_Defaults
	-- 		if not group.Enabled then return end

	-- 		-- local currentSpec = C_Talent.GetActiveTalentGroup()

	-- 		-- if (currentSpec == 1 and not group.PrimarySpec)
	-- 		-- or (currentSpec == 2 and not group.SecondarySpec)
	-- 		-- then
	-- 			-- return
	-- 		-- en

	-- 		local groupName = "TellMeWhen_Group" .. groupID

	-- 		for row = 1, group.Rows do
	-- 			for column = 1, group.Columns do
	-- 				local iconID = (row - 1) * group.Columns + column
	-- 				local iconName = groupName .. "_Icon" .. iconID
	-- 				local icon = _G[iconName]

	-- 				if icon and not icon.isSkinned then
	-- 					icon:SetTemplate("Default")

	-- 					icon:GetRegions():SetTexture(nil)

	-- 					_G[iconName .. "Texture"]:SetTexCoord(unpack(E.TexCoords))
	-- 					_G[iconName .. "Texture"]:SetInside()

	-- 					_G[iconName .. "Count"]:FontTemplate()

	-- 					_G[iconName .. "Highlight"]:SetTexture(1, 1, 1, 0.3)
	-- 					_G[iconName .. "Highlight"]:SetInside()

	-- 					E:RegisterCooldown(_G[iconName .. "Cooldown"])

	-- 					icon.isSkinned = true
	-- 				end
	-- 			end
	-- 		end
	-- 	end)


	-- 	local dropdownArrowColor = {1, 0.8, 0}
	-- 	--options
	-- 	for i = 1,8 do
	-- 		S:HandleButton(_G["InterfaceOptionsTellMeWhenPanelGroup"..i.."GroupResetButton"])

	-- 		S:HandleNextPrevButton(_G["InterfaceOptionsTellMeWhenPanelGroup"..i.."ColumnsWidgetRightButton"], "right", dropdownArrowColor)
	-- 		_G["InterfaceOptionsTellMeWhenPanelGroup"..i.."ColumnsWidgetRightButton"]:Size(20)
	-- 		S:HandleNextPrevButton(_G["InterfaceOptionsTellMeWhenPanelGroup"..i.."ColumnsWidgetLeftButton"], "left", dropdownArrowColor)
	-- 		_G["InterfaceOptionsTellMeWhenPanelGroup"..i.."ColumnsWidgetLeftButton"]:Size(20)

	-- 		S:HandleNextPrevButton(_G["InterfaceOptionsTellMeWhenPanelGroup"..i.."RowsWidgetRightButton"], "right", dropdownArrowColor)
	-- 		_G["InterfaceOptionsTellMeWhenPanelGroup"..i.."RowsWidgetRightButton"]:Size(20)
	-- 		S:HandleNextPrevButton(_G["InterfaceOptionsTellMeWhenPanelGroup"..i.."RowsWidgetLeftButton"], "left", dropdownArrowColor)
	-- 		_G["InterfaceOptionsTellMeWhenPanelGroup"..i.."RowsWidgetLeftButton"]:Size(20)

	-- 		-- S:HandleCheckBox(_G["InterfaceOptionsTellMeWhenPanelGroup"..i.."EnableButton"])
	-- 		S:HandleCheckBox(_G["InterfaceOptionsTellMeWhenPanelGroup"..i.."OnlyInCombatButton"])
	-- 		S:HandleCheckBox(_G["InterfaceOptionsTellMeWhenPanelGroup"..i.."Spec1Button"])
	-- 		S:HandleCheckBox(_G["InterfaceOptionsTellMeWhenPanelGroup"..i.."Spec2Button"])
	-- 		S:HandleCheckBox(_G["InterfaceOptionsTellMeWhenPanelGroup"..i.."Spec3Button"])
	-- 		S:HandleCheckBox(_G["InterfaceOptionsTellMeWhenPanelGroup"..i.."Spec4Button"])
	-- 	end
	-- 	S:HandleButton(InterfaceOptionsTellMeWhenPanelLockUnlockButton)
	-- -- else
	-- -- 	hooksecurefunc("TellMeWhen_Group_Update", function(groupID)
	-- -- 		local group = _G["TellMeWhen_Group" .. groupID]
	-- -- 		if not group.Enabled then return end

	-- -- 		for row = 1, group.Rows do
	-- -- 			for column = 1, group.Columns do
	-- -- 				local iconID = (row - 1) * group.Columns + column
	-- -- 				local iconName = group.groupName .. "_Icon" .. iconID
	-- -- 				local icon = _G[iconName]

	-- -- 				if icon and not icon.isSkinned then
	-- -- 					_G[iconName]:StyleButton()
	-- -- 					icon:SetTemplate("Default")

	-- -- 					icon:GetRegions():SetTexture(nil)

	-- -- 					_G[iconName .. "Icon"]:SetTexCoord(unpack(E.TexCoords))
	-- -- 					_G[iconName .. "Icon"]:SetInside()

	-- -- 					_G[iconName .. "Count"]:FontTemplate()

	-- -- 					E:RegisterCooldown(_G[iconName .. "Cooldown"])

	-- -- 					icon.isSkinned = true
	-- -- 				end
	-- -- 			end
	-- -- 		end
	-- -- 	end)
	-- end

end)
