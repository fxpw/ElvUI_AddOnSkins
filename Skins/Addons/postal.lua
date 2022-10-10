local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("Postal") then return end

local _G = _G
local select = select
-- local unpack = unpack

local hooksecurefunc = hooksecurefunc

local INBOXITEMS_TO_DISPLAY = INBOXITEMS_TO_DISPLAY

-- Postal r299
-- https://www.wowace.com/projects/postal/files/454610

S:AddCallbackForAddon("Postal", "Postal", function()
	-- if not E.private.addOnSkins.Postal then return end

	-- local Postal = LibStub("AceAddon-3.0"):GetAddon("Postal", true)
	-- if not Postal then return end

	-- S:HandleNextPrevButton(Postal_ModuleMenuButton, "down", nil, true)
	-- Postal_ModuleMenuButton:Point("TOPRIGHT", MailFrame, -60, -12)
	-- Postal_ModuleMenuButton:Size(26)

	-- hooksecurefunc(Postal, "CreateAboutFrame", function(self)
	-- 	self.aboutFrame:SetTemplate("Transparent")

	-- 	PostalAboutScroll:Point("TOPLEFT", 8, -26)
	-- 	PostalAboutScroll:Point("BOTTOMRIGHT", -29, 8)

	-- 	S:HandleScrollBar(PostalAboutScrollScrollBar)
	-- 	PostalAboutScrollScrollBar:Point("TOPLEFT", PostalAboutScroll, "TOPRIGHT", 3, -19)
	-- 	PostalAboutScrollScrollBar:Point("BOTTOMLEFT", PostalAboutScroll, "BOTTOMRIGHT", 3, 19)

	-- 	self.aboutFrame.editBox:Width(461)
	-- 	self.aboutFrame.editBox:Point("TOPLEFT", 1, -1)

	-- 	local closeButton = select(2, PostalAboutFrame:GetChildren())
	-- 	if closeButton then
	-- 		S:HandleCloseButton(closeButton, PostalAboutFrame)
	-- 	end
	-- end)

	-- local Postal_Select = Postal:GetModule("Select", true)
	-- if Postal_Select then
	-- 	local skinModule
	-- 	skinModule = function()
	-- 		S:HandleButton(PostalSelectOpenButton, true)
	-- 		PostalSelectOpenButton:Point("RIGHT", InboxFrame, "TOP", -29, -57)

	-- 		S:HandleButton(PostalSelectReturnButton, true)
	-- 		PostalSelectReturnButton:Point("LEFT", InboxFrame, "TOP", 8, -57)

	-- 		for i = 1, INBOXITEMS_TO_DISPLAY do
	-- 			local mail = _G["MailItem"..i]
	-- 			local inboxCB = _G["PostalInboxCB"..i]

	-- 			S:HandleCheckBox(inboxCB)
	-- 			inboxCB:Point("RIGHT", mail, "LEFT", 6, -5)
	-- 		end

	-- 		skinModule = nil
	-- 	end

	-- 	local function setPosition()
	-- 		MailItem1:Point("TOPLEFT", 38, -80)

	-- 		for i = 1, INBOXITEMS_TO_DISPLAY do
	-- 			_G["MailItem"..i.."ExpireTime"]:Point("TOPRIGHT", -4, -4)
	-- 		end
	-- 	end

	-- 	if PostalSelectOpenButton then
	-- 		skinModule()
	-- 		setPosition()
	-- 	end

	-- 	hooksecurefunc(Postal_Select, "OnEnable", function(self)
	-- 		if skinModule then
	-- 			skinModule()
	-- 		end
	-- 		setPosition()
	-- 	end)

	-- 	hooksecurefunc(Postal_Select, "OnDisable", function(self)
	-- 		MailItem1:Point("TOPLEFT", 24, -80)
	-- 	end)
	-- end

	-- local Postal_DoNotWant = Postal:GetModule("DoNotWant", true)
	-- if Postal_DoNotWant then
	-- 	local function skinModule()
	-- 		for i = 1, 7 do
	-- 			local returnIcon = _G["MailItem"..i.."ExpireTime"].returnicon
	-- 			returnIcon:StripTextures(true)
	-- 			S:HandleCloseButton(returnIcon)
	-- 			returnIcon:Size(26)
	-- 			returnIcon:ClearAllPoints()
	-- 			returnIcon:Point("TOPRIGHT", 32, -3)
	-- 		end
	-- 	end

	-- 	if MailItem1ExpireTime.returnicon then
	-- 		skinModule()
	-- 	else
	-- 		S:SecureHook(Postal_DoNotWant, "OnEnable", function(self)
	-- 			skinModule()
	-- 			S:Unhook(self, "OnEnable")
	-- 		end)
	-- 	end
	-- end

	-- local Postal_OpenAll = Postal:GetModule("OpenAll", true)
	-- if Postal_OpenAll then
	-- 	local function skinModule()
	-- 		S:HandleButton(PostalOpenAllButton, true)
	-- 		PostalOpenAllButton:Point("CENTER", InboxFrame, "TOP", -24, -408)

	-- 		S:HandleNextPrevButton(Postal_OpenAllMenuButton)
	-- 		Postal_OpenAllMenuButton:Size(25)
	-- 		Postal_OpenAllMenuButton:Point("LEFT", PostalOpenAllButton, "RIGHT", 3, 0)
	-- 	end

	-- 	if PostalOpenAllButton then
	-- 		skinModule()
	-- 	else
	-- 		S:SecureHook(Postal_OpenAll, "OnEnable", function(self)
	-- 			skinModule()
	-- 			S:Unhook(self, "OnEnable")
	-- 		end)
	-- 	end
	-- end

	-- local Postal_BlackBook = Postal:GetModule("BlackBook", true)
	-- if Postal_BlackBook then
	-- 	local function skinModule()
	-- 		S:HandleNextPrevButton(Postal_BlackBookButton)
	-- 		Postal_BlackBookButton:Size(20)
	-- 		Postal_BlackBookButton:Point("LEFT", SendMailNameEditBox, "RIGHT", 4, 0)
	-- 	end

	-- 	if Postal_BlackBookButton then
	-- 		skinModule()
	-- 	else
	-- 		S:SecureHook(Postal_BlackBook, "OnEnable", function(self)
	-- 			skinModule()
	-- 			S:Unhook(self, "OnEnable")
	-- 		end)
	-- 	end
	-- end

	-- local Postal_CarbonCopy = Postal:GetModule("CarbonCopy", true)
	-- if Postal_CarbonCopy then
	-- 	local function skinModule(self)
	-- 		self.button:SetTemplate()
	-- 		self.button:Size(12)
	-- 		self.button:Point("TOPRIGHT", 1, 3)

	-- 		local normalTexture = self.button:GetNormalTexture()
	-- 		normalTexture:SetTexCoord(unpack(E.TexCoords))
	-- 		normalTexture:SetInside()
	-- 	end

	-- 	if Postal_CarbonCopy.button then
	-- 		skinModule(Postal_CarbonCopy)
	-- 	else
	-- 		hooksecurefunc(Postal_CarbonCopy, "CreateButton", skinModule)
	-- 	end
	-- end

	if not E.private.addOnSkins.Postal then return end

	for i = 1, INBOXITEMS_TO_DISPLAY do
		local mail = _G["MailItem"..i]
		local button = _G["MailItem"..i.."Button"]
		local expire = _G["MailItem"..i.."ExpireTime"]
		local inboxCB = _G["PostalInboxCB"..i]

		button:SetScale(1)
		mail:Size(302, 45)

		if i == 1 then
			mail:Point("TOPLEFT", 25, -8)
		elseif i == 7 then
			mail:Point("TOPLEFT", InboxFrameRightContainer, 22, -8)
		end

		if expire then
			expire:Point("TOPRIGHT", -4, -2)

			if expire.returnicon then
				expire.returnicon:StripTextures(true)
				S:HandleCloseButton(expire.returnicon)
				expire.returnicon:SetHitRectInsets(0, 0, 0, 0)
				expire.returnicon:ClearAllPoints()
				expire.returnicon:Point("BOTTOMRIGHT", mail, -4, 2)
				expire.returnicon:Size(16)
			end
		end

		if inboxCB then
			S:HandleCheckBox(inboxCB)
			inboxCB:ClearAllPoints()
			inboxCB:Point("RIGHT", mail, "LEFT", -2, 0)
		end
	end

	if PostalSelectOpenButton then
		S:HandleButton(PostalSelectOpenButton, true)
		PostalSelectOpenButton:ClearAllPoints()
		PostalSelectOpenButton:Point("TOPLEFT", InboxFrame, "TOPLEFT", 21, 28)
	end

	if PostalSelectReturnButton then
		S:HandleButton(PostalSelectReturnButton, true)
		PostalSelectReturnButton:ClearAllPoints()
		PostalSelectReturnButton:Point("LEFT", PostalSelectOpenButton, "RIGHT", 77, 0)
	end

	if Postal_OpenAllMenuButton then
		S:HandleNextPrevButton(Postal_OpenAllMenuButton)
		Postal_OpenAllMenuButton:ClearAllPoints()
		Postal_OpenAllMenuButton:Point("LEFT", PostalOpenAllButton, "RIGHT", 2, 0)
		Postal_OpenAllMenuButton:Size(25)
	end

	if PostalOpenAllButton then
		S:HandleButton(PostalOpenAllButton, true)
	end

	if Postal_ModuleMenuButton then
		S:HandleNextPrevButton(Postal_ModuleMenuButton, nil, nil, true)
		Postal_ModuleMenuButton:Point("TOPRIGHT", MailFrame, -20, 2)
		Postal_ModuleMenuButton:Size(25)
	end

	if Postal_BlackBookButton then
		S:HandleNextPrevButton(Postal_BlackBookButton)
		Postal_BlackBookButton:ClearAllPoints()
		Postal_BlackBookButton:Point("LEFT", SendMailNameEditBox, "RIGHT", 2, 0)
		Postal_BlackBookButton:Size(20)
	end

	hooksecurefunc(Postal, "CreateAboutFrame", function()
		if PostalAboutFrame then
			PostalAboutFrame:StripTextures()
			PostalAboutFrame:SetTemplate("Transparent")

			if PostalAboutScroll then
				S:HandleScrollBar(PostalAboutScrollScrollBar)
			end

			local closeButton = select(2, PostalAboutFrame:GetChildren())
			if closeButton then
				S:HandleCloseButton(closeButton)
			end
		end
	end)
end)