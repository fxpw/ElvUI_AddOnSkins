-- Auctionator 9.1.3 for sirus

local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("Auctionator") then return end

local _G = _G



local function HandleSellItemButton(self)
	-- if not self.IsSkinned then
	self.IconBorder:Hide()
	self.IconBorder2 = CreateFrame("Frame", nil, self)
	self.IconBorder2:SetTemplate()
	self.IconBorder2:SetBackdropColor(0, 0, 0, 0)
	self.IconBorder2:SetParent(self)
	self.IconBorder2:SetOutside(self.Icon)
	self.IconBorder2:SetBackdropBorderColor(
		ITEM_QUALITY_COLORS[self.itemInfo.quality].r,
		ITEM_QUALITY_COLORS[self.itemInfo.quality].g,
		ITEM_QUALITY_COLORS[self.itemInfo.quality].b,
		1
	)
	self.Icon:SetTexCoord(unpack(E.TexCoords))
	self.Text:SetDrawLayer("BORDER")
	self.Text:SetText(self.itemInfo.count)
	-- self.IsSkinned = true
	-- end
end



local function HandleEditItemAucFrame()
	local frames = {
		"AuctionatorEditItemFrame",
	}
	for _, frame in ipairs(frames) do
		frame = _G[frame]
		if frame then
			frame:StripTextures()
			frame:CreateBackdrop("Transarent")
		end
	end
	AuctionatorEditItemFrameInset:Hide()

	local buttons = {
		"AuctionatorEditItemFrameCancel",
		"AuctionatorEditItemFrameResetAllButton",
		"AuctionatorEditItemFrameFinished",
	}
	for _, button in ipairs(buttons) do
		S:HandleButton(_G[button])
	end

	AuctionatorEditItemFrameCancel:ClearAllPoints()
	AuctionatorEditItemFrameCancel:SetPoint("TOPLEFT", AuctionatorEditItemFrame, "BOTTOMLEFT", 11, 30)
	AuctionatorEditItemFrameResetAllButton:SetText("Сбросить")
	AuctionatorEditItemFrameFinished:SetText("Сохранить")
	AuctionatorEditItemFrameFinished:ClearAllPoints()
	AuctionatorEditItemFrameFinished:SetPoint("TOPLEFT", AuctionatorEditItemFrameResetAllButton, "TOPRIGHT", 0, 0)
	AuctionatorEditItemFrameFinished:Width(120)

	local editboxes = {
		"AuctionatorEditItemFrameSearchContainerSearchString",
		"AuctionatorEditItemFrameLevelRangeMinBox",
		"AuctionatorEditItemFrameLevelRangeMaxBox",
		"AuctionatorEditItemFramePriceRangeMinBox",
		"AuctionatorEditItemFramePriceRangeMaxBox",
		"AuctionatorEditItemFrameItemLevelRangeMinBox",
		"AuctionatorEditItemFrameItemLevelRangeMaxBox",
		"AuctionatorEditItemFrameCraftedLevelRangeMinBox",
		"AuctionatorEditItemFrameCraftedLevelRangeMaxBox",
	}
	for _, editbox in ipairs(editboxes) do
		editbox = _G[editbox]
		if editbox then
			S:HandleEditBox(editbox)
		end
	end
	local refreshbuttons = {
		"AuctionatorEditItemFrameSearchContainerAuctionatorResetButton",
		"AuctionatorEditItemFrameFilterKeySelectorResetButton",
		"AuctionatorEditItemFrameLevelRangeResetButton",
		"AuctionatorEditItemFramePriceRangeResetButton",
		"AuctionatorEditItemFrameItemLevelRangeResetButton",
		"AuctionatorEditItemFrameCraftedLevelRangeResetButton",
	}

	for _, refreshbutton in ipairs(refreshbuttons) do
		refreshbutton = _G[refreshbutton]
		if refreshbutton then
			S:HandleButton(refreshbutton)
		end
	end
	local dropdowns = {
		"AuctionatorEditItemFrameFilterKeySelector",
	}
	for _, dropdown in ipairs(dropdowns) do
		dropdown = _G[dropdown]
		if dropdown then
			S:HandleDropDownBox(dropdown)
		end
	end
	local checkboxes = {
		"AuctionatorEditItemFrameSearchContainerIsExact"
	}
	for _, checkbox in ipairs(checkboxes) do
		checkbox = _G[checkbox]
		if checkbox then
			S:HandleCheckBox(checkbox)
		end
	end

	AuctionatorEditItemFrameFilterKeySelector:SetWidth(200)
	AuctionatorEditItemFrameFilterKeySelectorResetButton:ClearAllPoints()
	AuctionatorEditItemFrameFilterKeySelectorResetButton:SetPoint("TOPLEFT", AuctionatorEditItemFrameFilterKeySelector,
		"TOPRIGHT", -5, -6)
end

local function HandleAddItemAucFrame()
	local frames = {
		"AuctionatorAddItemFrame",

	}
	for _, frame in ipairs(frames) do
		frame = _G[frame]
		if frame then
			frame:StripTextures()
			frame:CreateBackdrop("Transarent")
		end
	end
	AuctionatorAddItemFrameInset:Hide()

	local buttons = {
		"AuctionatorAddItemFrameCancel",
		"AuctionatorAddItemFrameResetAllButton",
		"AuctionatorAddItemFrameFinished",
	}
	for _, button in ipairs(buttons) do
		S:HandleButton(_G[button])
	end

	AuctionatorAddItemFrameCancel:ClearAllPoints()
	AuctionatorAddItemFrameCancel:SetPoint("TOPLEFT", AuctionatorAddItemFrame, "BOTTOMLEFT", 11, 30)
	AuctionatorAddItemFrameResetAllButton:SetText("Сбросить")
	AuctionatorAddItemFrameFinished:SetText("Сохранить")
	AuctionatorAddItemFrameFinished:ClearAllPoints()
	AuctionatorAddItemFrameFinished:SetPoint("TOPLEFT", AuctionatorAddItemFrameResetAllButton, "TOPRIGHT", 0, 0)
	AuctionatorAddItemFrameFinished:Width(120)

	local editboxes = {
		"AuctionatorAddItemFrameSearchContainerSearchString",
		"AuctionatorAddItemFrameLevelRangeMinBox",
		"AuctionatorAddItemFrameLevelRangeMaxBox",
		"AuctionatorAddItemFramePriceRangeMinBox",
		"AuctionatorAddItemFramePriceRangeMaxBox",
		"AuctionatorAddItemFrameItemLevelRangeMinBox",
		"AuctionatorAddItemFrameItemLevelRangeMaxBox",
		"AuctionatorAddItemFrameCraftedLevelRangeMinBox",
		"AuctionatorAddItemFrameCraftedLevelRangeMaxBox",
	}
	for _, editbox in ipairs(editboxes) do
		editbox = _G[editbox]
		if editbox then
			S:HandleEditBox(editbox)
		end
	end
	local refreshbuttons = {
		"AuctionatorAddItemFrameSearchContainerAuctionatorResetButton",
		"AuctionatorAddItemFrameFilterKeySelectorResetButton",
		"AuctionatorAddItemFrameLevelRangeResetButton",
		"AuctionatorAddItemFramePriceRangeResetButton",
		"AuctionatorAddItemFrameItemLevelRangeResetButton",
		"AuctionatorAddItemFrameCraftedLevelRangeResetButton",
	}

	for _, refreshbutton in ipairs(refreshbuttons) do
		refreshbutton = _G[refreshbutton]
		if refreshbutton then
			S:HandleButton(refreshbutton)
		end
	end
	local dropdowns = {
		"AuctionatorAddItemFrameFilterKeySelector",
	}
	for _, dropdown in ipairs(dropdowns) do
		dropdown = _G[dropdown]
		if dropdown then
			S:HandleDropDownBox(dropdown)
		end
	end
	local checkboxes = {
		"AuctionatorAddItemFrameSearchContainerIsExact"
	}
	for _, checkbox in ipairs(checkboxes) do
		checkbox = _G[checkbox]
		if checkbox then
			S:HandleCheckBox(checkbox)
		end
	end

	AuctionatorAddItemFrameFilterKeySelector:SetWidth(200)
	AuctionatorAddItemFrameFilterKeySelectorResetButton:ClearAllPoints()
	AuctionatorAddItemFrameFilterKeySelectorResetButton:SetPoint("TOPLEFT", AuctionatorAddItemFrameFilterKeySelector,
		"TOPRIGHT", -5, -6)
end


local function HandleFirstAucTab()
	local buttons = {
		"AuctionatorShoppingListFrameImport",
		"AuctionatorShoppingListFrameExport",
		"AuctionatorShoppingListFrameRename",
		"AuctionatorShoppingListFrameDeleteList",
		"AuctionatorShoppingListFrameCreateList",
		"AuctionatorShoppingListFrameExportCSV",
		"AuctionatorShoppingListFrameManualSearch",
		"AuctionatorShoppingListFrameAddItem",
		-- "AuctionatorShoppingListFrameResultsListingHeaderContainerPoolFrameAuctionatorStringColumnHeaderTemplate1",
		-- "AuctionatorShoppingListFrameResultsListingHeaderContainerPoolFrameAuctionatorStringColumnHeaderTemplate2",
		-- "AuctionatorShoppingListFrameResultsListingHeaderContainerPoolFrameAuctionatorStringColumnHeaderTemplate3",
		-- "AuctionatorShoppingListFrameResultsListingHeaderContainerPoolFrameAuctionatorStringColumnHeaderTemplate4",
	}
	for _, button in ipairs(buttons) do
		if _G[button] then
			S:HandleButton(_G[button])
		end
	end
	-- if AuctionatorShoppingListFrameResultsListingHeaderContainerPoolFrameAuctionatorStringColumnHeaderTemplate1 then
	-- 	AuctionatorShoppingListFrameResultsListingHeaderContainerPoolFrameAuctionatorStringColumnHeaderTemplate1:ClearAllPoints()
	-- 	AuctionatorShoppingListFrameResultsListingHeaderContainerPoolFrameAuctionatorStringColumnHeaderTemplate1:SetPoint("BOTTOMLEFT", 15, 4)
	-- end
	local dropdowns = {
		"AuctionatorShoppingListFrameListDropdown",
	}
	for _, dropdown in ipairs(dropdowns) do
		dropdown = _G[dropdown]
		if dropdown then
			S:HandleDropDownBox(dropdown)
		end
	end
	local scrollbars = {
		"AuctionatorShoppingListFrameResultsListingScrollFrameScrollBar",
		"AuctionatorShoppingListFrameScrollListScrollFrameScrollBar",
	}
	for _, scrollbar in ipairs(scrollbars) do
		scrollbar = _G[scrollbar]
		if scrollbar then
			S:HandleScrollBar(scrollbar)
		end
	end
	local frames = {
		"AuctionatorShoppingListFrameScrollListScrollFrame",
		"AuctionatorShoppingListFrameResultsListingScrollFrame",
		"AuctionatorShoppingListFrameShoppingResultsInsetNineSlice",
		"AuctionatorShoppingListFrameShoppingResultsInset",
		"AuctionatorShoppingListFrameResultsListing",
		"AuctionatorShoppingListFrameScrollListScrollFrameScrollChild",
		"AuctionatorShoppingListFrameScrollListInsetFrame",
	}
	for _, frame in ipairs(frames) do
		frame = _G[frame]
		if frame then
			frame:StripTextures()
			-- frame:CreateBackdrop("Transparent")
		end
	end
	--frames createback
	frames = {
		-- "AuctionatorShoppingListFrameScrollListScrollFrame",
		-- "AuctionatorShoppingListFrameResultsListingScrollFrame",
		"AuctionatorShoppingListFrameShoppingResultsInsetNineSlice",
		"AuctionatorShoppingListFrameScrollListScrollFrameScrollChild",
		-- "AuctionatorShoppingListFrameShoppingResultsInset",
		-- "AuctionatorShoppingListFrameResultsListing",
		-- "AuctionatorShoppingListFrameResultsListingScrollFrame",
	}
	for _, frame in ipairs(frames) do
		frame = _G[frame]
		if frame then
			-- frame:StripTextures()
			frame:CreateBackdrop("Transparent")
		end
	end
	AuctionatorShoppingListFrameCreateList:ClearAllPoints()
	AuctionatorShoppingListFrameCreateList:SetPoint("LEFT", AuctionatorShoppingListFrameListDropdown, "RIGHT", 10, 2)
end

local function HandleSecAucTab()
	AuctionatorSellingFrameSaleItemFrameIconIconBorder:StripTextures()
	AuctionatorSellingFrameSaleItemFrameIconEmptySlot:StripTextures()
	AuctionatorSellingFrameSaleItemFrameIcon.Icon:SetDrawLayer("BORDER")
	S:HandleIcon(AuctionatorSellingFrameSaleItemFrameIcon.Icon)
	local tabs = {
		"AuctionatorSellingFrameHistoryTabsContainerRealmHistoryTab",
		"AuctionatorSellingFrameHistoryTabsContainerYourHistoryTab"
	}
	for _, tab in ipairs(tabs) do
		tab = _G[tab]
		if tab then
			S:HandleTab(tab)
		end
	end
	local buttons = {
		"AuctionatorSellingFrameHistoricalPriceListingHeaderContainerPoolFrameAuctionatorStringColumnHeaderTemplate1",
		"AuctionatorSellingFrameHistoricalPriceListingHeaderContainerPoolFrameAuctionatorStringColumnHeaderTemplate2",
		"AuctionatorSellingFrameHistoricalPriceListingHeaderContainerPoolFrameAuctionatorStringColumnHeaderTemplate3",
		"AuctionatorSellingFrameHistoricalPriceListingHeaderContainerPoolFrameAuctionatorStringColumnHeaderTemplate4",
		"AuctionatorSellingFrameCurrentItemListingHeaderContainerPoolFrameAuctionatorStringColumnHeaderTemplate1",
		"AuctionatorSellingFrameCurrentItemListingHeaderContainerPoolFrameAuctionatorStringColumnHeaderTemplate2",
		"AuctionatorSellingFrameCurrentItemListingHeaderContainerPoolFrameAuctionatorStringColumnHeaderTemplate3",
		"AuctionatorSellingFrameCurrentItemListingHeaderContainerPoolFrameAuctionatorStringColumnHeaderTemplate4",
		"AuctionatorSellingFrameCurrentItemListingHeaderContainerPoolFrameAuctionatorStringColumnHeaderTemplate5",
		"AuctionatorSellingFrameCurrentItemListingHeaderContainerPoolFrameAuctionatorStringColumnHeaderTemplate6",
		"AuctionatorSellingFrameCurrentItemListingHeaderContainerPoolFrameAuctionatorStringColumnHeaderTemplate7",
		"AuctionatorSellingFrameSaleItemFrameMaxButton",
		"AuctionatorPostButton",
		"AuctionatorSellingFramePostingHistoryListingHeaderContainerPoolFrameAuctionatorStringColumnHeaderTemplate1",
		"AuctionatorSellingFramePostingHistoryListingHeaderContainerPoolFrameAuctionatorStringColumnHeaderTemplate2",
		"AuctionatorSellingFramePostingHistoryListingHeaderContainerPoolFrameAuctionatorStringColumnHeaderTemplate3",
		"AuctionatorSellingFramePostingHistoryListingHeaderContainerPoolFrameAuctionatorStringColumnHeaderTemplate4",
		"AuctionatorSellingFramePostingHistoryListingHeaderContainerPoolFrameAuctionatorStringColumnHeaderTemplate5",
	}
	for _, button in ipairs(buttons) do
		button = _G[button]
		if button then
			S:HandleButton(button)
		end
	end
	local scrollbars = {
		"AuctionatorSellingFramePostingHistoryListingScrollFrameScrollBar",
		"AuctionatorSellingFrameCurrentItemListingScrollFrameScrollBar",
		"AuctionatorSellingFrameHistoricalPriceListingScrollFrameScrollBar",
		"AuctionatorSellingFrameBagListingScrollFrameScrollBar",
	}
	for _, scrollbar in ipairs(scrollbars) do
		scrollbar = _G[scrollbar]
		if scrollbar then
			scrollbar:StripTextures()
			S:HandleScrollBar(scrollbar)
			-- scrollbar:ClearAllPoints()
			-- scrollbar:SetPoint("TOPLEFT", AuctionatorSellingFrameBagListingScrollFrame, "TOPRIGHT", 60, -16)
		end
	end
	local frames = {
		"AuctionatorSellingFramePostingHistoryListingScrollFrame",
		"AuctionatorSellingFrameCurrentItemListingScrollFrame",
		"AuctionatorSellingFrameHistoricalPriceListingScrollFrame",
	}
	for _, frame in ipairs(frames) do
		frame = _G[frame]
		if frame then
			frame:StripTextures()
			frame:CreateBackdrop("Transparent")
		end
	end
	local frames2 = {
		"AuctionatorSellingFramePostingHistoryListing",
		"AuctionatorSellingFrameCurrentItemListing",
		"AuctionatorSellingFrameHistoricalPriceListing",
		"AuctionatorSellingFramePostingHistoryListingScrollFrameScrollChild",
		"AuctionatorSellingFrameCurrentItemListingScrollFrameScrollChild",
		"AuctionatorSellingFrameHistoricalPriceListingScrollFrameScrollChild",
		"AuctionatorSellingFrameBagListingScrollFrame",
		"AuctionatorSellingFrameBagListingScrollFrameItemListingFrameWeaponItemsSectionTitle",
		"AuctionatorSellingFrameBagListingScrollFrameItemListingFrameArmorItemsSectionTitle",
		"AuctionatorSellingFrameBagListingScrollFrameItemListingFrameContainerItemsSectionTitle",
		"AuctionatorSellingFrameBagListingScrollFrameItemListingFrameGemItemsSectionTitle",
		"AuctionatorSellingFrameBagListingScrollFrameItemListingFrameConsumableItemsSectionTitle",
		"AuctionatorSellingFrameBagListingScrollFrameItemListingFrameGlyphItemsSectionTitle",
		"AuctionatorSellingFrameBagListingScrollFrameItemListingFrameTradeGoodItemsSectionTitle",
		"AuctionatorSellingFrameBagListingScrollFrameItemListingFrameRecipeItemsSectionTitle",
		"AuctionatorSellingFrameBagListingScrollFrameItemListingFrameQuestItemsSectionTitle",
		"AuctionatorSellingFrameBagListingScrollFrameItemListingFrameAmmoItemsSectionTitle",
		"AuctionatorSellingFrameBagListingScrollFrameItemListingFrameQuiverItemsSectionTitle",
		"AuctionatorSellingFrameBagListingScrollFrameItemListingFrameMiscItemsSectionTitle",
	}
	for _, frame in ipairs(frames2) do
		frame = _G[frame]
		if frame then
			frame:StripTextures()
		end
	end
	local frames3 = {
		"AuctionatorSellingFrameHistoricalPriceInset",
		"AuctionatorSellingFramePostingHistoryListingInset",
		"AuctionatorSellingFrameCurrentItemInset",
		"AuctionatorSellingFrameBagInset",
		-- "AuctionHouseFramePortrait",
		"AuctionatorSellingFrameBagListingScrollFrameScrollBarThumbTexture",
		"AuctionatorSellingFrameBagListingScrollFrameScrollBarChild",
	}
	for _, frame in ipairs(frames3) do
		frame = _G[frame]
		if frame then
			frame:Hide()
		end
	end

	local editboxes = {
		"AuctionatorSellingFrameSaleItemFramePriceMoneyInputGoldBox",
		"AuctionatorSellingFrameSaleItemFramePriceMoneyInputSilverBox",
		"AuctionatorSellingFrameSaleItemFrameQuantityInputBox"
	}
	for _, editbox in ipairs(editboxes) do
		editbox = _G[editbox]
		if editbox then
			S:HandleEditBox(editbox)
		end
	end
	AuctionatorSellingFrameSaleItemFramePriceMoneyInputSilverBoxIcon:ClearAllPoints()
	AuctionatorSellingFrameSaleItemFramePriceMoneyInputSilverBoxIcon:SetPoint("RIGHT",
		AuctionatorSellingFrameSaleItemFramePriceMoneyInputSilverBox, "RIGHT", -13.000000136774, 2)

	local checkbuttons = {
		"AuctionatorSellingFrameSaleItemFrameDurationDuration12RadioButton",
		"AuctionatorSellingFrameSaleItemFrameDurationDuration24RadioButton",
		"AuctionatorSellingFrameSaleItemFrameDurationDuration48RadioButton",
	}
	for _, checkbutton in ipairs(checkbuttons) do
		checkbutton = _G[checkbutton]
		if checkbutton then
			S:HandleCheckBox(checkbutton)
		end
	end
end


local function HandleThirdAucTab()
	local buttons = {
		"AuctionatorCancellingFrameScanStartScanButton",
		"AuctionatorCancelUndercutButton",
		"AuctionatorCancelAllButton",
		-- "AuctionatorCancellingFrameResultsListingHeaderContainerPoolFrameAuctionatorStringColumnHeaderTemplate2",
		-- "AuctionatorCancellingFrameResultsListingHeaderContainerPoolFrameAuctionatorStringColumnHeaderTemplate3",
		-- "AuctionatorCancellingFrameResultsListingHeaderContainerPoolFrameAuctionatorStringColumnHeaderTemplate4",
		-- "AuctionatorCancellingFrameResultsListingHeaderContainerPoolFrameAuctionatorStringColumnHeaderTemplate5",
		-- "AuctionatorCancellingFrameResultsListingHeaderContainerPoolFrameAuctionatorStringColumnHeaderTemplate6",
		-- "AuctionatorCancellingFrameResultsListingHeaderContainerPoolFrameAuctionatorStringColumnHeaderTemplate7",
	}
	for _, button in ipairs(buttons) do
		button = _G[button]
		if button then
			S:HandleButton(button)
		end
	end

	local editboxes = {
		"AuctionatorCancellingFrameSearchFilter",
	}
	for _, editbox in ipairs(editboxes) do
		editbox = _G[editbox]
		if editbox then
			S:HandleEditBox(editbox)
		end
	end
	local frames1 = {
		"AuctionatorCancellingFrameHistoricalPriceInset",
		"AuctionatorCancellingFrameHistoricalPriceInsetNineSlice",
	}
	for _, frame in ipairs(frames1) do
		frame = _G[frame]
		if frame then
			frame:StripTextures()
			frame:CreateBackdrop("Transparent")
		end
	end

	local frames2 = {
		"AuctionatorCancellingFrameResultsListingScrollFrameScrollChild",
		"AuctionatorCancellingFrameResultsListingScrollFrame",
		"AuctionatorCancellingFrameResultsListingHeaderContainer",
		"AuctionatorCancellingFrameResultsListing",
	}
	for _, frame in ipairs(frames2) do
		frame = _G[frame]
		if frame then
			frame:StripTextures()
		end
	end
	-- AuctionatorCancellingFrameResultsListing:Hide()

	local scrollbars = {
		"AuctionatorCancellingFrameResultsListingScrollFrameScrollBar",
		-- "AuctionatorCancellingFrameResultsListingScrollFrame",
		-- "AuctionatorCancellingFrameResultsListingHeaderContainer",
	}
	for _, scrollbar in ipairs(scrollbars) do
		scrollbar = _G[scrollbar]
		if scrollbar then
			S:HandleScrollBar(scrollbar)
		end
	end
end


local function HandleFourAucTab()
	local buttons = {
		"AuctionatorConfigFrameOptionsButton",
		"AuctionatorConfigFrameScanButton",
	}
	for _, button in ipairs(buttons) do
		button = _G[button]
		if button then
			S:HandleButton(button)
		end
	end

	local frames = {
		"AuctionatorConfigFrame",
		"AuctionatorConfigFrameNineSlice",
	}
	for _, frame in ipairs(frames) do
		frame = _G[frame]
		if frame then
			frame:StripTextures()
			frame:CreateBackdrop("Transparent")
		end
	end
	local editboxes = {
		"AuctionatorConfigFrameDiscordLinkInputBox",
		"AuctionatorConfigFrameBugReportLinkInputBox",
		"AuctionatorConfigFrameTechnicalRoadmapInputBox",
	}
	for _, editbox in ipairs(editboxes) do
		editbox = _G[editbox]
		if editbox then
			S:HandleEditBox(editbox)
		end
	end
end



S:AddCallbackForAddon("Auctionator", "Auctionator", function()
	if not E.private.addOnSkins.Auctionator then return end

	hooksecurefunc(AuctionatorTabContainerMixin, "OnLoad", function(self, ...)
		local tab = AuctionatorTabs_ShoppingLists
		if (tab) then
			tab.HighlightLeft:StripTextures()
			tab.HighlightMiddle:StripTextures()
			tab.HighlightRight:StripTextures()
			S:HandleTab(tab)
		end
		local tab = AuctionatorTabs_Selling
		if (tab) then
			tab.HighlightLeft:StripTextures()
			tab.HighlightMiddle:StripTextures()
			tab.HighlightRight:StripTextures()
			S:HandleTab(tab)
		end
		local tab = AuctionatorTabs_Cancelling
		if (tab) then
			tab.HighlightLeft:StripTextures()
			tab.HighlightMiddle:StripTextures()
			tab.HighlightRight:StripTextures()
			S:HandleTab(tab)
		end
		local tab = AuctionatorTabs_Auctionator
		if (tab) then
			tab.HighlightLeft:StripTextures()
			tab.HighlightMiddle:StripTextures()
			tab.HighlightRight:StripTextures()
			S:HandleTab(tab)
		end
		-- S:HandleTab(AuctionatorTabs_ShoppingLists)
		-- S:HandleTab(AuctionatorTabs_Selling)
		-- S:HandleTab(AuctionatorTabs_Cancelling)
		-- S:HandleTab(AuctionatorTabs_Auctionator)

		HandleFirstAucTab()
		HandleAddItemAucFrame()
		HandleEditItemAucFrame()
		HandleSecAucTab()
		HandleThirdAucTab()
		HandleFourAucTab()
	end)
	-- AuctionatorTabMixin:Initialize(
	-- AuctionatorResultsListingMixin:UpdateTable()
	hooksecurefunc(AuctionatorStringColumnHeaderTemplateMixin, "Init", function(self)
		S:HandleButton(self)
		if self:GetText() == "Количество" then
			self:SetText("Кол-во")
		end
	end)

	hooksecurefunc(Auctionator.ReagentSearch, "InitializeSearchButton", function()
		S:HandleButton(AuctionatorTradeSkillSearch)
	end)


	hooksecurefunc(AuctionatorBagClassListingMixin, "UpdateForEmpty", function(self)
		for _, button in ipairs(self.buttons) do
			HandleSellItemButton(button)
		end
	end)
end)