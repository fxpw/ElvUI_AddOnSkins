local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

-- BigBrother
--


if not AS:IsAddonLODorEnabled("BigBrother") then return end


S:AddCallbackForAddon("BigBrother", "BigBrother", function()
	if not E.private.addOnSkins.BigBrother then return end
	local  function bbframe_onup()
		BigBrother_BuffWindow:StripTextures()
		BigBrother_BuffWindow:CreateBackdrop("Transparent")
		S:HandleCloseButton(BigBrother_BuffWindow.CloseButton)
		local dropdownArrowColor = {1, 0.8, 0}
		S:HandleNextPrevButton(BigBrother_BuffWindow.RightButton, "right", dropdownArrowColor)
		AuctionHouseFrameItemSellFrameDurationDropDownDropDownButton:Size(15)

		S:HandleNextPrevButton(BigBrother_BuffWindow.LeftButton, "left", dropdownArrowColor)
		AuctionHouseFrameItemSellFrameDurationDropDownDropDownButton:Size(15)
	end
	hooksecurefunc(BigBrother,"CreateBuffWindow",bbframe_onup)
end)