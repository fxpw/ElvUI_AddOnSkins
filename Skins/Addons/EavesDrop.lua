local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("EavesDrop") then return end

-- EavesDrop
--

S:AddCallbackForAddon("EavesDrop", "EavesDrop", function()
	if not E.private.addOnSkins.EavesDrop then return end

	EavesDropFrame:StripTextures()
	EavesDropFrame:CreateBackdrop("Transparent")
	EavesDropHistoryFrame:StripTextures()
	EavesDropHistoryFrame:CreateBackdrop("Transparent")
	--resetbutton
	S:HandleButton(EavesDropHistoryFrameReset)
	EavesDropHistoryFrameReset:SetText("Стереть")
	--tab butt
	S:HandleButton(EavesDropTab)
	EavesDropTab:Width(110)
	EavesDropTab:Height(40)
	EavesDropTab:ClearAllPoints()
	EavesDropTab:SetPoint("BOTTOM", EavesDropFrame, "TOP", 0, 0)

	--up and down butt
	local dropdownArrowColor = {1, 0.8, 0}
	S:HandleNextPrevButton(EavesDropFrameUpButton, "up", dropdownArrowColor)
	EavesDropFrameUpButton:Size(24)

	S:HandleNextPrevButton(EavesDropFrameDownButton, "down", dropdownArrowColor)
	EavesDropFrameDownButton:Size(24)

	S:HandleCloseButton(EavesDropHistoryFrameClose)
		--icons
	local texlist ={
		"EavesDropHistoryButtonNT",
		"EavesDropHistoryButtonPT",
		"EavesDropHistoryFrameOutgoingHitNT",
		"EavesDropHistoryFrameOutgoingHitPT",
		"EavesDropHistoryFrameOutgoingHealNT",
		"EavesDropHistoryFrameOutgoingHealPT",
		"EavesDropHistoryFrameIncomingHitNT",
		"EavesDropHistoryFrameIncomingHitPT",
		"EavesDropHistoryFrameIncomingHealNT",
		"EavesDropHistoryFrameIncomingHealPT",
	}
	for _,tex in ipairs(texlist)do
		local textc = _G[tex]
		if textc then
			textc:SetTexCoord(unpack(E.TexCoords))
		end
	end
end)