local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("AdiBags") then return end

local _G = _G
local ipairs = ipairs
local type = type
local unpack = unpack

local GetItemInfo = GetItemInfo
local hooksecurefunc = hooksecurefunc

local ITEM_QUALITY_POOR = ITEM_QUALITY_POOR
local ITEM_QUALITY_UNCOMMON = ITEM_QUALITY_UNCOMMON
local TEXTURE_ITEM_QUEST_BANG = TEXTURE_ITEM_QUEST_BANG
local TEXTURE_ITEM_QUEST_BORDER = TEXTURE_ITEM_QUEST_BORDER

-- AdiBags by Accidev
-- https://github.com/accidev/AdiBags-for-Sirus

S:AddCallbackForAddon("AdiBags", "AdiBags", function()
	if not E.private.addOnSkins.AdiBags then return end

	if E.private.bags.enable then
		E.PopupDialogs.ADIBAGS_ELVUI_BAGS = {
			text = "У вас включен встроенный модуль Сумок |cff1784d1ElvUI|r, и при этом работает аддон |cff00bfffAdiBags|r. Это вызывает двойное открытие банков и инвентаря. Желаете отключить встроенный модуль сумок ElvUI?",
			button1 = ACCEPT,
			button2 = CANCEL,
			OnAccept = function()
				E.private.bags.enable = false
				ReloadUI()
			end,
			timeout = 0,
			whileDead = 1,
			hideOnEscape = false,
		}
		E:StaticPopup_Show("ADIBAGS_ELVUI_BAGS")
	end


	local AdiBags = LibStub("AceAddon-3.0"):GetAddon("AdiBags", true)
	if not AdiBags then return end

	local skinnedFrames = {}
	setmetatable(skinnedFrames, {__mode = "k"})

	local function FixBorder(frame)
		if not frame or not frame.GetBackdrop then return end
		local scale = AdiBags.db.profile and AdiBags.db.profile.scale or 1
		local mult = (E.mult / scale)

		if scale < 1 then
			mult = mult + (mult * 0.05)
		end

		local target = frame.backdrop or frame
		local backdrop = target:GetBackdrop()
		if backdrop then
			local r, g, b, a = target:GetBackdropColor()
			local br, bg, bb, ba = target:GetBackdropBorderColor()
			backdrop.edgeSize = mult
			target:SetBackdrop(backdrop)
			target:SetBackdropColor(r or 0, g or 0, b or 0, a or 0)
			target:SetBackdropBorderColor(br or 0, bg or 0, bb or 0, ba or 0)
		end

		if target.iborder then
			target.iborder:SetInside(target, mult, mult)
			local ibackdrop = target.iborder:GetBackdrop()
			if ibackdrop then
				ibackdrop.edgeSize = mult
				ibackdrop.insets.left = -mult
				ibackdrop.insets.right = -mult
				ibackdrop.insets.top = -mult
				ibackdrop.insets.bottom = -mult
				target.iborder:SetBackdrop(ibackdrop)
				target.iborder:SetBackdropBorderColor(0, 0, 0, 1)
			end
		end

		if target.oborder then
			target.oborder:SetOutside(target, mult, mult)
			local obackdrop = target.oborder:GetBackdrop()
			if obackdrop then
				obackdrop.edgeSize = mult
				obackdrop.insets.left = mult
				obackdrop.insets.right = mult
				obackdrop.insets.top = mult
				obackdrop.insets.bottom = mult
				target.oborder:SetBackdrop(obackdrop)
				target.oborder:SetBackdropBorderColor(0, 0, 0, 1)
			end
		end

		if frame.sectionHighlights then
			for _, tex in ipairs(frame.sectionHighlights) do
				if tex.isHoriz then
					tex:SetHeight(mult)
				else
					tex:SetWidth(mult)
				end
			end
		end
	end

	local function RegisterFrame(frame)
		if not frame then return end
		skinnedFrames[frame] = true
		FixBorder(frame)
	end

	hooksecurefunc(AdiBags, "ResetBagPositions", function(self)
		self.db.profile.scale = 1
		self:LayoutBags()
	end)

	hooksecurefunc(AdiBags, "LayoutBags", function()
		for frame in pairs(skinnedFrames) do
			FixBorder(frame)
		end
	end)

	local B = E:GetModule("Bags", true)
	if B then
		hooksecurefunc(B, "StopStacking", function(self, message, noUpdate)
			if not noUpdate then
				E:Delay(0.6, function()
					if AdiBags then
						AdiBags:SendMessage("AdiBags_FiltersChanged")
					end
				end)
			end
		end)
	end

	local function SkinContainer(frame)
		frame:SetTemplate("Transparent")
		RegisterFrame(frame)
		
		S:HandleCloseButton(frame.CloseButton)

		local B = E:GetModule("Bags")

		if tonumber(E.version) >= 7.99 then
			frame.deconstructButton = CreateFrame("Button", nil, frame)
			frame.deconstructButton:Size(16 + E.Border)
			frame.deconstructButton:SetTemplate()
			frame:AddHeaderWidget(frame.deconstructButton, -20, 16 + E.Border, 0)
			frame.deconstructButton:SetNormalTexture("Interface\\ICONS\\INV_Rod_Enchantedcobalt")
			frame.deconstructButton:GetNormalTexture():SetTexCoord(unpack(E.TexCoords))
			frame.deconstructButton:GetNormalTexture():SetInside()
			frame.deconstructButton:SetPushedTexture("Interface\\ICONS\\INV_Rod_Enchantedcobalt")
			frame.deconstructButton:GetPushedTexture():SetTexCoord(unpack(E.TexCoords))
			frame.deconstructButton:GetPushedTexture():SetInside()
			frame.deconstructButton:StyleButton(nil, true)
			frame.deconstructButton.ttText = L["Deconstruct Mode"]
			frame.deconstructButton:SetScript("OnEnter", B.Tooltip_Show)
			frame.deconstructButton:SetScript("OnLeave", function() GameTooltip:Hide() end)
			frame.deconstructButton:SetScript("OnClick", function(self)
				local D = B:GetModule("Deconstruct")
				if not D then return end
				
				if not D.DeconstructButton then
					D.DeconstructButton = self
				end

				if not D.DeconstructionReal then
					D:UpdateProfessions()
					D:ConstructRealDecButton()
					GameTooltip:HookScript('OnShow', function() D:DeconstructParser() end)
					GameTooltip:HookScript('OnUpdate', function() D:DeconstructParser() end)

					D:RegisterEvent('SKILL_LINES_CHANGED')
					D:RegisterEvent('SPELLS_CHANGED')
					D:RegisterEvent('LEARNED_SPELL_IN_TAB')
				end

				if D.ToggleMode then
					D:ToggleMode()
					AdiBags:SendMessage("AdiBags_UpdateAllButtons")
				end
			end)
			RegisterFrame(frame.deconstructButton)

			frame:HookScript("OnHide", function()
				local D = B:GetModule("Deconstruct")
				if D and D.DeconstructMode then
					D.DeconstructMode = false
					if D.DeconstructButton then
						local normalTex = D.DeconstructButton:GetNormalTexture()
						if normalTex then normalTex:SetTexture([[Interface\ICONS\INV_Rod_Enchantedcobalt]]) end
						ActionButton_HideOverlayGlow(D.DeconstructButton)
					end
					if D.DeconstructionReal then D.DeconstructionReal:OnLeave() end
					AdiBags:SendMessage("AdiBags_UpdateAllButtons")
					
					-- Keep original ElvUI behavior as well just in case
					if B.BagFrame then D:UpdateBagSlots(B.BagFrame, false) end
					if B.BankFrame then D:UpdateBagSlots(B.BankFrame, false) end
				end
			end)
		end

		frame.sortButton = CreateFrame("Button", nil, frame)
		frame.sortButton:Size(16 + E.Border)
		frame.sortButton:SetTemplate()
		frame:AddHeaderWidget(frame.sortButton, -21, 16 + E.Border, 0)
		frame.sortButton:SetNormalTexture(E.Media.Textures.Broom)
		frame.sortButton:GetNormalTexture():SetTexCoord(unpack(E.TexCoords))
		frame.sortButton:GetNormalTexture():SetInside()
		frame.sortButton:SetPushedTexture(E.Media.Textures.Broom)
		frame.sortButton:GetPushedTexture():SetTexCoord(unpack(E.TexCoords))
		frame.sortButton:GetPushedTexture():SetInside()
		frame.sortButton:SetDisabledTexture(E.Media.Textures.Broom)
		frame.sortButton:GetDisabledTexture():SetTexCoord(unpack(E.TexCoords))
		frame.sortButton:GetDisabledTexture():SetInside()
		frame.sortButton:GetDisabledTexture():SetDesaturated(true)
		frame.sortButton:StyleButton(nil, true)
		frame.sortButton.ttText = L["Sort Bags"]
		frame.sortButton:SetScript("OnEnter", B.Tooltip_Show)
		frame.sortButton:SetScript("OnLeave", function() GameTooltip:Hide() end)
		frame.sortButton:SetScript("OnClick", function()
			B:CommandDecorator(B.SortBags, "bags")()
		end)
		RegisterFrame(frame.sortButton)

		frame.vendorGraysButton = CreateFrame("Button", nil, frame)
		frame.vendorGraysButton:Size(16 + E.Border)
		frame.vendorGraysButton:SetTemplate()
		frame:AddHeaderWidget(frame.vendorGraysButton, -22, 16 + E.Border, 0)
		frame.vendorGraysButton:SetNormalTexture("Interface\\ICONS\\INV_Misc_Coin_01")
		frame.vendorGraysButton:GetNormalTexture():SetTexCoord(unpack(E.TexCoords))
		frame.vendorGraysButton:GetNormalTexture():SetInside()
		frame.vendorGraysButton:SetPushedTexture("Interface\\ICONS\\INV_Misc_Coin_01")
		frame.vendorGraysButton:GetPushedTexture():SetTexCoord(unpack(E.TexCoords))
		frame.vendorGraysButton:GetPushedTexture():SetInside()
		frame.vendorGraysButton:StyleButton(nil, true)
		frame.vendorGraysButton.ttText = L["Vendor / Delete Grays"]
		frame.vendorGraysButton:SetScript("OnEnter", B.Tooltip_Show)
		frame.vendorGraysButton:SetScript("OnLeave", function() GameTooltip:Hide() end)
		frame.vendorGraysButton:SetScript("OnClick", function()
			if not B.SellFrame then B:CreateSellFrame() end
			B:VendorGrayCheck()
		end)
		RegisterFrame(frame.vendorGraysButton)

		local bagSlots = frame.HeaderLeftRegion.widgets[1].widget
		bagSlots:SetTemplate()
		bagSlots:StyleButton(nil, true)
		RegisterFrame(bagSlots)

		local bagSlotsTex = bagSlots:GetNormalTexture()
		bagSlotsTex:SetInside()
		bagSlotsTex:SetTexCoord(unpack(E.TexCoords))

		frame.BagSlotPanel:SetTemplate("Transparent")
		RegisterFrame(frame.BagSlotPanel)

		for _, bag in ipairs(frame.BagSlotPanel.buttons) do
			bag:StripTextures()
			bag:SetTemplate()
			bag:StyleButton()
			RegisterFrame(bag)

			local icon = _G[bag:GetName().."IconTexture"]
			icon:SetInside()
			icon:SetTexCoord(unpack(E.TexCoords))
		end
	end

	S:RawHook(AdiBags, "CreateContainerFrame", function(self, ...)
		local frame = S.hooks[self].CreateContainerFrame(self, ...)

		SkinContainer(frame)

		return frame
	end)

	local qualityColors = {
		["questStarter"] = {E.db.bags.colors.items.questStarter.r, E.db.bags.colors.items.questStarter.g, E.db.bags.colors.items.questStarter.b},
		["questItem"] =	{E.db.bags.colors.items.questItem.r, E.db.bags.colors.items.questItem.g, E.db.bags.colors.items.questItem.b}
	}
	for i = 0, 7 do
		qualityColors[i] = {GetItemQualityColor(i)}
	end

	local LayeredRegionClass = AdiBags:GetClass("LayeredRegion")
	if LayeredRegionClass then
		hooksecurefunc(LayeredRegionClass.prototype, "AddWidget", function(self, widget)
			if widget:IsObjectType("Button") then
				if widget:GetText() then
					S:HandleButton(widget)
				else
					widget:StyleButton(true, true)
					if widget:GetNormalTexture() then
						widget:GetNormalTexture():SetTexCoord(unpack(E.TexCoords))
					end
					if widget:GetPushedTexture() then
						widget:GetPushedTexture():SetTexCoord(unpack(E.TexCoords))
					end
				end
				RegisterFrame(widget)
			elseif widget:IsObjectType("EditBox") then
				widget:DisableDrawLayer("BACKGROUND")
				S:HandleEditBox(widget)
				RegisterFrame(widget)

				if widget.clearButton then
					widget.clearButton:StripTextures()
					widget.clearButton:SetText("")
					S:HandleCloseButton(widget.clearButton)
				end
			end
		end)
	end

	local function updateBorderTexture(self, texture, g, b)
		if texture == TEXTURE_ITEM_QUEST_BANG then
			self:SetAlpha(1)
			self.parent:SetBackdropBorderColor(unpack(qualityColors.questStarter))
			self.parent._itemQuality = "questStarter"
		else
			self:SetAlpha(0)

			if texture == TEXTURE_ITEM_QUEST_BORDER then
				self.parent:SetBackdropBorderColor(unpack(qualityColors.questItem))
				self.parent._itemQuality = "questItem"
			elseif texture == "Interface\\Buttons\\UI-ActionButton-Border" then
				-- await for vertex color
				self.awaitColor = true

				local _, _, quality = GetItemInfo(self.parent.itemId)
				if quality and quality >= ITEM_QUALITY_UNCOMMON then
					self.parent._itemQuality = quality
				elseif quality == ITEM_QUALITY_POOR and AdiBags.db.profile.dimJunk then
					self.parent._itemQuality = 1 - 0.5 * AdiBags.db.profile.qualityOpacity
				end

				return
			elseif type(texture) == "number" then
				self.parent._itemQuality = 1
				self.parent:SetBackdropBorderColor(texture, g, b)
			end
		end
	end

	local function updateBorderVertexColor(self, r, g, b)
		if not self.awaitColor then return end

		self.parent:SetBackdropBorderColor(r, g, b)
		self.awaitColor = nil
	end

	local function updateDimJunk(self, mode)
		if mode == "MOD" and AdiBags.db.profile.dimJunk then
			local alpha = 1 - 0.5 * AdiBags.db.profile.qualityOpacity
			self.parent.IconTexture:SetVertexColor(1, 1, 1, alpha)
			self._dimmed = true
		elseif self.dimmed then
			self.parent.IconTexture:SetVertexColor(1, 1, 1, 1)
			self._dimmed = nil
		end
	end

	local function updateBorderOnHide(self)
		if not self._searchMode then
			if self._restoreBorder then
				local color = qualityColors[self.parent._itemQuality]
				self.parent:SetBackdropBorderColor(color[1], color[2], color[3], 1)
				self._restoreBorder = nil
			end

			self.parent:SetBackdropBorderColor(unpack(E.media.bordercolor))
			self.parent.IconTexture:SetVertexColor(1, 1, 1, 1)
		elseif self.parent._itemQuality then
			self._restoreBorder = true

			local color = qualityColors[self.parent._itemQuality]
			if color then
				self.parent:SetBackdropBorderColor(color[1], color[2], color[3], 0.2)
			else
				color = self.parent._itemQuality
				self.parent:SetBackdropBorderColor(color, color, color, 0.2)
			end
		end
	end

	local SectionClass = AdiBags:GetClass("Section")
	if SectionClass then
		hooksecurefunc(SectionClass.prototype, "OnCreate", function(self)
			local header = self.Header
			if header:GetHighlightTexture() then
				header:GetHighlightTexture():SetTexture(nil)
			else
				header:SetHighlightTexture("")
			end

			local r, g, b = unpack(E.media.rgbvaluecolor)

			local left = header:CreateTexture(nil, "HIGHLIGHT")
			left:SetTexture(r, g, b, 1)
			left:SetPoint("TOPLEFT")
			left:SetPoint("BOTTOMLEFT")
			left:SetWidth(1)

			local right = header:CreateTexture(nil, "HIGHLIGHT")
			right:SetTexture(r, g, b, 1)
			right:SetPoint("TOPRIGHT")
			right:SetPoint("BOTTOMRIGHT")
			right:SetWidth(1)

			local top = header:CreateTexture(nil, "HIGHLIGHT")
			top:SetTexture(r, g, b, 1)
			top:SetPoint("TOPLEFT")
			top:SetPoint("TOPRIGHT")
			top:SetHeight(1)
			top.isHoriz = true

			local bottom = header:CreateTexture(nil, "HIGHLIGHT")
			bottom:SetTexture(r, g, b, 1)
			bottom:SetPoint("BOTTOMLEFT")
			bottom:SetPoint("BOTTOMRIGHT")
			bottom:SetHeight(1)
			bottom.isHoriz = true

			header.sectionHighlights = {left, right, top, bottom}
			RegisterFrame(header)
		end)
	end

	local ItemButtonClass = AdiBags:GetClass("ItemButton")
	hooksecurefunc(ItemButtonClass.prototype, "OnCreate", function(self)
		self.NormalTexture:SetTexture(nil)
		self:SetTemplate("Default", true)
		self:StyleButton()

		self.IconTexture:SetInside()
		self.IconTexture:SetTexCoord(unpack(E.TexCoords))
		self.IconTexture.SetTexCoord = E.noop

		self.IconQuestTexture:SetInside()
		self.IconQuestTexture:SetTexture(E.Media.Textures.BagQuestIcon)
		self.IconQuestTexture:SetTexCoord(unpack(E.TexCoords))
		self.IconQuestTexture.SetTexCoord = E.noop
		self.IconQuestTexture.parent = self
		self.IconQuestTexture.SetTexture = updateBorderTexture
		self.IconQuestTexture.SetVertexColor = updateBorderVertexColor
		self.IconQuestTexture.SetBlendMode = updateDimJunk
		hooksecurefunc(self.IconQuestTexture, "Hide", updateBorderOnHide)

		E:RegisterCooldown(self.Cooldown)

		RegisterFrame(self)
	end)

	hooksecurefunc(ItemButtonClass.prototype, "Update", function(self)
		if not self:CanUpdate() then return end

		if not self.texture then
			self.IconTexture:SetTexture(nil)
		end

		local B = E:GetModule("Bags", true)
		local D = B and B:GetModule("Deconstruct", true)

		if D and D.DeconstructMode then
			local validBag = self.bag
			if validBag then
				local itemLink = GetContainerItemLink(self.bag, self.slot)
				local hasKey = false
				for key in pairs(D.Keys) do
					if GetItemCount(key) > 0 then hasKey = key; break end
				end
				if itemLink and D:CanProcessItem(itemLink, hasKey) then
					self:SetAlpha(1)
				else
					self:SetAlpha(0.3)
				end
			end
		else
			if self.hasItem then
				local _, _, itemQuality = GetItemInfo(self.itemId)
				if itemQuality == ITEM_QUALITY_POOR and AdiBags.db.profile.dimJunk then
					self:SetAlpha(0.5)
				else
					self:SetAlpha(1)
				end
			else
				self:SetAlpha(1)
			end
		end
	end)

	local AdiBags_SearchHighlight = AdiBags:GetModule("SearchHighlight", true)
	S:RawHook(AdiBags_SearchHighlight, "UpdateButton", function(self, event, button)
		button.IconQuestTexture._searchMode = true
		S.hooks[self].UpdateButton(self, event, button)
		button.IconQuestTexture._searchMode = nil
	end)
end)