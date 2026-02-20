local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("InnK-Auc") then return end

S:AddCallbackForAddon("InnK-Auc", "InnK-Auc", function()
	hooksecurefunc(InnKAuc, "CreateSettingsFrame", function()
		local f = _G["InnKAucSettingsFrame"]
		if f then
			f:StripTextures()
			f:CreateBackdrop("Transparent")
			
			local close = _G["InnKAucSettingsCloseButton"]
			if close then
				S:HandleCloseButton(close)
			end
			
			if f.scrollFrame then
				f.scrollFrame:StripTextures()
				S:HandleScrollBar(_G["InnKAucSettingsScrollScrollBar"])
			end
		end
	end)

    hooksecurefunc(InnKAuc, "GetSettingsLine", function(self)
        local line = self.SettingsLines[#self.SettingsLines]
        if line and not line.isSkinned then
             if line.iconFrame then
                 S:HandleIcon(line.icon)
             elseif line.icon then
                 S:HandleIcon(line.icon)
                 line.icon:SetDrawLayer("ARTWORK")
             end
             
             line.isSkinned = true
        end
    end)

    hooksecurefunc(InnKAuc, "CreateReagentWindow", function()
        local f = _G["InnKAucReagentWindow"]
        if f then
            f:StripTextures()
            f:CreateBackdrop("Transparent")
            
            local close = _G["InnKAucReagentWindowCloseButton"]
            if close then
                S:HandleCloseButton(close)
            end
            
            if f.scrollFrame then
                f.scrollFrame:StripTextures()
                S:HandleScrollBar(_G["InnKAucReagentWindowScrollScrollBar"])
            end
            
            local refreshBtn = _G["InnKAucRefreshButton"]
            if refreshBtn then
                S:HandleButton(refreshBtn)
            end
            
            local buyBtn = _G["InnKAucBuyButton"]
            if buyBtn then
                S:HandleButton(buyBtn)
            end
        end
    end)
    
    hooksecurefunc(InnKAuc, "GetReagentLine", function(self)
        local line = self.ReagentLines[#self.ReagentLines]
        if line and not line.isSkinned then
            line:SetHighlightTexture("")
            
            line:CreateBackdrop("Transparent")
            line.backdrop:SetInside(line, 2, 2)
            
            if line.icon then
                S:HandleIcon(line.icon)
            end
            
            if line.selectedIndicator then
                line.selectedIndicator:SetDrawLayer("OVERLAY")
            end
            
            line:HookScript("OnEnter", function(self)
                if self.backdrop then
                    self.backdrop:SetBackdropBorderColor(unpack(E.media.rgbvaluecolor))
                end
            end)
            
            line:HookScript("OnLeave", function(self)
                if self.backdrop then
                    if InnKAuc.SelectedReagentID == self.itemID then
                        self.backdrop:SetBackdropBorderColor(1, 0.82, 0, 1)
                    else
                        self.backdrop:SetBackdropBorderColor(unpack(E.media.bordercolor))
                    end
                end
            end)
            
            line.isSkinned = true
        end
    end)
    
    hooksecurefunc(InnKAuc, "UpdateReagentWindow", function(self)
        if not self.ReagentLines then return end
        for _, line in ipairs(self.ReagentLines) do
            if line.backdrop and line.itemID then
                if self.SelectedReagentID == line.itemID then
                    line.backdrop:SetBackdropBorderColor(1, 0.82, 0, 1)
                elseif self:IsItemIgnored(line.itemID) then
                    line.backdrop:SetBackdropBorderColor(0.5, 0.5, 0.5, 0.5)
                else
                    line.backdrop:SetBackdropBorderColor(unpack(E.media.bordercolor))
                end
            end
        end
    end)

    hooksecurefunc(InnKAuc, "CreateSellWindow", function()
        local f = _G["InnKAucSellWindow"]
        if f then
            f:StripTextures()
            f:CreateBackdrop("Transparent")
            
            local close = _G["InnKAucSellWindowCloseButton"]
            if close then
                S:HandleCloseButton(close)
            end
            
            if f.scrollFrame then
                f.scrollFrame:StripTextures()
                S:HandleScrollBar(_G["InnKAucSellWindowScrollScrollBar"])
            end
            
            local refreshBtn = _G["InnKAucSellRefreshButton"]
            if refreshBtn then
                S:HandleButton(refreshBtn)
            end
            
            local sellBtn = _G["InnKAucSellSelectedButton"]
            if sellBtn then
                S:HandleButton(sellBtn)
            end
        end
    end)
    
    hooksecurefunc(InnKAuc, "GetSellLine", function(self)
        local line = self.SellLines[#self.SellLines]
        if line and not line.isSkinned then
            line:SetHighlightTexture("")
            
            line:CreateBackdrop("Transparent")
            line.backdrop:SetInside(line, 2, 2)
            
            if line.icon then
                S:HandleIcon(line.icon)
            end
            
            if line.selectedIndicator then
                line.selectedIndicator:SetDrawLayer("OVERLAY")
            end
            
            line:HookScript("OnEnter", function(self)
                if self.backdrop then
                    self.backdrop:SetBackdropBorderColor(unpack(E.media.rgbvaluecolor))
                end
            end)
            
            line:HookScript("OnLeave", function(self)
                if self.backdrop then
                    if InnKAuc.SelectedSellReagentID == self.itemID then
                        self.backdrop:SetBackdropBorderColor(1, 0.82, 0, 1)
                    else
                        self.backdrop:SetBackdropBorderColor(unpack(E.media.bordercolor))
                    end
                end
            end)
            
            line.isSkinned = true
        end
    end)
    
    hooksecurefunc(InnKAuc, "UpdateSellWindow", function(self)
        if not self.SellLines then return end
        for _, line in ipairs(self.SellLines) do
            if line.backdrop and line.itemID then
                local hasItems = (GetItemCount(line.itemID) or 0) > 0
                if self.SelectedSellReagentID == line.itemID then
                    line.backdrop:SetBackdropBorderColor(1, 0.82, 0, 1)
                elseif not hasItems then
                    line.backdrop:SetBackdropBorderColor(0.5, 0.5, 0.5, 0.5)
                else
                    line.backdrop:SetBackdropBorderColor(unpack(E.media.bordercolor))
                end
            end
        end
    end)

	if _G["InnKAucQuickMailFrame"] then
		local quickMail = _G["InnKAucQuickMailFrame"]
		quickMail:StripTextures()
		quickMail:CreateBackdrop("Transparent")

		if _G["InnKAucQuickMailRecipient"] then
			S:HandleEditBox(_G["InnKAucQuickMailRecipient"])
		end
		
		if _G["InnKAucQuickMailItems"] then
			S:HandleEditBox(_G["InnKAucQuickMailItems"])
		end
		
		if _G["InnKAucQuickMailButton"] then
			S:HandleButton(_G["InnKAucQuickMailButton"])
		end
	end

	if InnKAucTabMixin then
		hooksecurefunc(InnKAucTabMixin, "CreateContent", function(self)
			if self.SettingsButton then
				S:HandleButton(self.SettingsButton)
			end
            if self.ShowReagentsButton then
                S:HandleButton(self.ShowReagentsButton)
            end
            if self.SellReagentsButton then
                S:HandleButton(self.SellReagentsButton)
            end
		end)
	end
end)

