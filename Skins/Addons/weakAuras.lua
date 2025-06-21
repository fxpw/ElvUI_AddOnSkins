local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("WeakAuras") then return end

-- S:AddCallbackForAddon("WeakAuras", "WeakAuras", function()

-- 	-- if not E.private.addOnSkins.WeakAuras then return end
-- 	-- if WeakAuras.IsCorrectVersion then

-- 	-- 	-- WeakAurasOptions:StripTextures()
-- 	-- 	-- WeakAurasOptions:CreateBackdrop()
-- 	-- 	if WeakAuras and WeakAuras.OpenOptions then
-- 	-- 		-- hooksecurefunc(WeakAuras,"OpenOptions", function()
-- 	-- 		-- 	if WeakAurasOptions and not WeakAurasOptions.ElvUISkin then
-- 	-- 		-- 		WeakAurasOptions:StripTextures();
-- 	-- 		-- 		WeakAurasOptions:CreateBackdrop("Transparent");
-- 	-- 		-- 		S:HandleEditBox(WeakAurasFilterInput);

-- 	-- 		-- 		local close, waTitle, leftSizer, rightSizer, min = WeakAurasOptions:GetChildren();
-- 	-- 		-- 		close:StripTextures();
-- 	-- 		-- 		local closeButton = close:GetChildren();
-- 	-- 		-- 		S:HandleCloseButton(closeButton);
-- 	-- 		-- 		waTitle:StripTextures();
-- 	-- 		-- 		waTitle:CreateBackdrop("Transparent");
-- 	-- 		-- 		min:StripTextures();
-- 	-- 		-- 		local minButton = min:GetChildren();
-- 	-- 		-- 		minButton:Size(25)
-- 	-- 		-- 		local Normal,  Pushed = minButton:GetNormalTexture(),  minButton:GetPushedTexture()
-- 	-- 		-- 		minButton:SetNormalTexture(E.Media.Textures.ArrowUp)
-- 	-- 		-- 		minButton:SetPushedTexture(E.Media.Textures.ArrowUp)

-- 	-- 		-- 		Normal:SetRotation(S.ArrowRotation[WeakAurasOptions.minimized and "down" or "up"])
-- 	-- 		-- 		Pushed:SetRotation(S.ArrowRotation[WeakAurasOptions.minimized and "down" or "up"])



-- 	-- 		-- 		minButton:HookScript("OnClick", function(self)
-- 	-- 		-- 			self:Size(25)
-- 	-- 		-- 			Normal, Pushed = self:GetNormalTexture(), self:GetPushedTexture()
-- 	-- 		-- 			self:SetNormalTexture(E.Media.Textures.ArrowUp)
-- 	-- 		-- 			self:SetPushedTexture(E.Media.Textures.ArrowUp)
-- 	-- 		-- 			Normal:SetRotation(S.ArrowRotation[WeakAurasOptions.minimized and "down" or "up"])
-- 	-- 		-- 			Pushed:SetRotation(S.ArrowRotation[WeakAurasOptions.minimized and "down" or "up"])

-- 	-- 		-- 		end)
-- 	-- 		-- 		-- minButton:StripTextures();
-- 	-- 		-- 		-- local dropdownArrowColor = {1, 0.8, 0};
-- 	-- 		-- 		-- S:HandleNextPrevButton(minButton, "up", dropdownArrowColor);
-- 	-- 		-- 		-- minButton:Size(25);
-- 	-- 		-- 		-- test:StripTextures()
-- 	-- 		-- 		-- S:HandleButton(closeButton)
-- 	-- 		-- 		-- S:HandleCloseButton(close)
-- 	-- 		-- 		WeakAurasOptions.ElvUISkin = true;
-- 	-- 		-- 	end
-- 	-- 		-- end)
-- 	-- 	end
-- 	-- 	-- return
-- 	-- end
-- 	-- local function Skin_WeakAuras(frame, ftype)
-- 	-- 	if not frame.backdrop then
-- 	-- 		frame:CreateBackdrop("Transparent")
-- 	-- 		frame.icon:SetTexCoord(unpack(E.TexCoords))
-- 	-- 		frame.icon.SetTexCoord = E.noop
-- 	-- 	end

-- 	-- 	if ftype == "aurabar" then
-- 	-- 		if not E.db.addOnSkins.weakAuraAuraBar then
-- 	-- 			frame.backdrop:Hide()
-- 	-- 		else
-- 	-- 			frame.backdrop:Show()
-- 	-- 		end
-- 	-- 	elseif ftype == "icon" then
-- 	-- 		if E.db.addOnSkins.weakAuraIconCooldown then
-- 	-- 			frame.cooldown.CooldownOverride = "global"
-- 	-- 			E:RegisterCooldown(frame.cooldown)
-- 	-- 		end
-- 	-- 	end
-- 	-- end

-- 	-- local Create_Icon, Modify_Icon = WeakAuras.regionTypes.icon.create, WeakAuras.regionTypes.icon.modify
-- 	-- local Create_AuraBar, Modify_AuraBar = WeakAuras.regionTypes.aurabar.create, WeakAuras.regionTypes.aurabar.modify

-- 	-- WeakAuras.regionTypes.icon.create = function(parent, data)
-- 	-- 	local region = Create_Icon(parent, data)
-- 	-- 	Skin_WeakAuras(region, "icon")
-- 	-- 	return region
-- 	-- end

-- 	-- WeakAuras.regionTypes.aurabar.create = function(parent)
-- 	-- 	local region = Create_AuraBar(parent)
-- 	-- 	Skin_WeakAuras(region, "aurabar")
-- 	-- 	return region
-- 	-- end

-- 	-- WeakAuras.regionTypes.icon.modify = function(parent, region, data)
-- 	-- 	Modify_Icon(parent, region, data)
-- 	-- 	Skin_WeakAuras(region, "icon")
-- 	-- end

-- 	-- WeakAuras.regionTypes.aurabar.modify = function(parent, region, data)
-- 	-- 	Modify_AuraBar(parent, region, data)
-- 	-- 	Skin_WeakAuras(region, "aurabar")
-- 	-- end

-- 	-- for weakAura in pairs(WeakAuras.regions) do
-- 	-- 	if WeakAuras.regions[weakAura].regionType == "icon"
-- 	-- 	or WeakAuras.regions[weakAura].regionType == "aurabar"
-- 	-- 	then
-- 	-- 		Skin_WeakAuras(WeakAuras.regions[weakAura].region, WeakAuras.regions[weakAura].regionType)
-- 	-- 	end
-- 	-- end

-- end)