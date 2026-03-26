local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("Bugsworth") then return end

S:AddCallbackForAddon("!Bugsworth", "Bugsworth", function()
	if not E.private.addOnSkins.Bugsworth then return end

	local BC = _G.Bugsworth
	if not BC then return end

	S:SecureHook(BC, "OpenViewer", function()
		local frame = _G.BugsworthFrame
		if not frame or frame.isSkinned then return end

		frame:StripTextures()
		frame:SetTemplate("Transparent")

		for _, child in ipairs({frame:GetChildren()}) do
			if child:IsObjectType("Button") and child.GetNormalTexture and child:GetNormalTexture() then
				local tex = child:GetNormalTexture():GetTexture()
				if tex and tostring(tex):find("UI%-Panel%-MinimizeButton") then
					S:HandleCloseButton(child)
				end
			end
		end
		for _, child in ipairs({frame:GetChildren()}) do
			if child:IsObjectType("Button") and not child:GetText() and child:GetWidth() < 40 then
				local point = child:GetPoint()
				if point == "TOPRIGHT" then
					S:HandleCloseButton(child, frame)
					break
				end
			end
		end

		local navPanel, detailPanel
		for _, child in ipairs({frame:GetChildren()}) do
			if child:IsObjectType("Frame") and not child:GetName() and child:GetWidth() < 200 then
				if child.GetBackdrop and child:GetBackdrop() then
					navPanel = child
				end
			end
		end

		if navPanel then
			navPanel:StripTextures()
			navPanel:SetTemplate("Transparent")
		end

		local searchBox = _G.BugsworthSearchBox
		if searchBox then
			S:HandleEditBox(searchBox)
			searchBox:Height(18)
		end

		local navScroll = _G.BugsworthNavScroll
		if navScroll then
			S:HandleScrollBar(_G.BugsworthNavScrollScrollBar)
		end

		local detailScroll = _G.BugsworthDetailScroll
		if detailScroll then
			S:HandleScrollBar(_G.BugsworthDetailScrollScrollBar)
		end

		S:HandleButton(_G.BugsworthNextButton)
		S:HandleButton(_G.BugsworthPrevButton)
		S:HandleButton(_G.BugsworthClearButton)
		S:HandleButton(_G.BugsworthCopyButton)

		local tabAll = _G.BugsworthTabAll
		local tabSession = _G.BugsworthTabSession
		local tabPrev = _G.BugsworthTabPrev

		if tabAll then
			tabAll:Point("TOPLEFT", frame, "BOTTOMLEFT", 0, 2)
			S:HandleTab(tabAll)
		end
		if tabSession then S:HandleTab(tabSession) end
		if tabPrev then S:HandleTab(tabPrev) end

		frame.isSkinned = true
		S:Unhook(BC, "OpenViewer")
	end)

	local mmButton = _G.BugsworthMinimapButton
	if mmButton then
		mmButton:SetHighlightTexture(nil)

		local regions = {mmButton:GetRegions()}
		for _, region in ipairs(regions) do
			if region:IsObjectType("Texture") then
				local tex = region:GetTexture()
				if tex and tostring(tex):find("MiniMap%-TrackingBorder") then
					region:Hide()
				end
			end
		end

		if mmButton.icon then
			mmButton:SetTemplate("Default")
			mmButton:SetSize(26, 26)
			mmButton.icon:SetInside(mmButton, 2, 2)
			mmButton.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		end
	end
end)
