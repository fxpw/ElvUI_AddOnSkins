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

	hooksecurefunc(AdiBags, "ResetBagPositions", function(self)
		self.db.profile.scale = 1
		self:LayoutBags()
	end)

	local function SkinContainer(frame)
		frame:SetTemplate("Transparent")
		S:HandleCloseButton(frame.CloseButton)

		local bagSlots = frame.HeaderLeftRegion.widgets[1].widget
		bagSlots:SetTemplate()
		bagSlots:StyleButton(nil, true)

		local bagSlotsTex = bagSlots:GetNormalTexture()
		bagSlotsTex:SetInside()
		bagSlotsTex:SetTexCoord(unpack(E.TexCoords))

		frame.BagSlotPanel:SetTemplate("Transparent")

		for _, bag in ipairs(frame.BagSlotPanel.buttons) do
			bag:StripTextures()
			bag:SetTemplate()
			bag:StyleButton()

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
			elseif widget:IsObjectType("EditBox") then
				widget:DisableDrawLayer("BACKGROUND")
				S:HandleEditBox(widget)

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

			local bottom = header:CreateTexture(nil, "HIGHLIGHT")
			bottom:SetTexture(r, g, b, 1)
			bottom:SetPoint("BOTTOMLEFT")
			bottom:SetPoint("BOTTOMRIGHT")
			bottom:SetHeight(1)
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
	end)

	hooksecurefunc(ItemButtonClass.prototype, "Update", function(self)
		if not self:CanUpdate() then return end

		if not self.texture then
			self.IconTexture:SetTexture(nil)
		end
	end)

	local AdiBags_SearchHighlight = AdiBags:GetModule("SearchHighlight", true)
	S:RawHook(AdiBags_SearchHighlight, "UpdateButton", function(self, event, button)
		button.IconQuestTexture._searchMode = true
		S.hooks[self].UpdateButton(self, event, button)
		button.IconQuestTexture._searchMode = nil
	end)
end)