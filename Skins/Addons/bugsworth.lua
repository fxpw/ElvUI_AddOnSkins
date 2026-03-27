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
			if child:IsObjectType("Button") and not child:GetText() and child:GetWidth() < 40 then
				local point = child:GetPoint()
				if point == "TOPRIGHT" then
					S:HandleCloseButton(child, frame)
					break
				end
			end
		end

		for _, child in ipairs({frame:GetChildren()}) do
			if child:IsObjectType("Frame") and not child:GetName() and child:GetWidth() < 200 then
				if child.GetBackdrop and child:GetBackdrop() then
					child:StripTextures()
					child:SetTemplate("Transparent")
					break
				end
			end
		end

		if _G.BugsworthSearchBox then
			S:HandleEditBox(_G.BugsworthSearchBox)
			_G.BugsworthSearchBox:Height(18)
		end

		if _G.BugsworthNavScrollScrollBar then
			S:HandleScrollBar(_G.BugsworthNavScrollScrollBar)
		end
		if _G.BugsworthDetailScrollScrollBar then
			S:HandleScrollBar(_G.BugsworthDetailScrollScrollBar)
		end

		S:HandleButton(_G.BugsworthNextButton)
		S:HandleButton(_G.BugsworthPrevButton)
		S:HandleButton(_G.BugsworthClearButton)
		S:HandleButton(_G.BugsworthCopyButton)

		local function skinTab(tab)
			if not tab then return end
			S:HandleTab(tab)
			local name = tab:GetName()
			if name then
				for _, suffix in ipairs({"HighlightLeft", "HighlightMiddle", "HighlightRight", "HighlightTexture"}) do
					local tex = _G[name .. suffix]
					if tex then tex:SetTexture(nil) tex:Hide() end
				end
			end
		end

		if _G.BugsworthTabAll then
			_G.BugsworthTabAll:Point("TOPLEFT", frame, "BOTTOMLEFT", 0, 2)
		end
		skinTab(_G.BugsworthTabAll)
		skinTab(_G.BugsworthTabSession)
		skinTab(_G.BugsworthTabPrev)

		frame.isSkinned = true
		S:Unhook(BC, "OpenViewer")
	end)

	local configPanel
	for _, cat in ipairs(INTERFACEOPTIONS_ADDONCATEGORIES) do
		if cat.name == "Bugsworth" then
			configPanel = cat
			break
		end
	end

	if configPanel then
		S:SecureHookScript(configPanel, "OnShow", function(panel)
			if panel.isSkinned then return end

			local checkboxNames = {
				"BugsworthCheckАвто-открытиеприошибке",
				"BugsworthCheckУведомлениевчат",
				"BugsworthCheckОтключитьзвукошибки",
				"BugsworthCheckФильтрошибокдействийаддонов",
				"BugsworthCheckОграничениечастыхошибок",
				"BugsworthCheckСкрытьстандартноеокноошибок",
				"BugsworthCheckМногоуровневыелокальные",
				"BugsworthCheckЗахватпамятиаддона",
			}

			for _, name in ipairs(checkboxNames) do
				local cb = _G[name]
				if cb then S:HandleCheckBox(cb) end
			end

			for _, child in ipairs({panel:GetChildren()}) do
				if child:IsObjectType("Slider") then
					S:HandleSliderFrame(child)
				elseif child:IsObjectType("Button") and child:GetText() == "Очистить все ошибки" then
					S:HandleButton(child)
				end
			end

			if panel.rebuildIgnoreList then
				local origRebuild = panel.rebuildIgnoreList
				panel.rebuildIgnoreList = function(...)
					origRebuild(...)
					for _, child in ipairs({panel:GetChildren()}) do
						if child:IsObjectType("Frame") and not child:GetName() and child:GetHeight() == 120 then
							for _, row in ipairs({child:GetChildren()}) do
								if row:IsShown() then
									for _, btn in ipairs({row:GetChildren()}) do
										if btn:IsObjectType("Button") and not btn.isSkinned then
											S:HandleButton(btn)
											btn.isSkinned = true
										end
									end
								end
							end
							break
						end
					end
				end
				panel.rebuildIgnoreList()
			end

			panel.isSkinned = true
		end)
	end

	S:SecureHook(BC, "OpenTaintViewer", function()
		local tf = _G.BugsworthTaintFrame
		if not tf or tf.isSkinned then return end

		tf:StripTextures()
		tf:SetTemplate("Transparent")

		for _, child in ipairs({tf:GetChildren()}) do
			if child:IsObjectType("Button") and not child:GetText() and child:GetWidth() < 40 then
				local point = child:GetPoint()
				if point == "TOPRIGHT" then
					S:HandleCloseButton(child, tf)
					break
				end
			end
		end

		for _, child in ipairs({tf:GetChildren()}) do
			if child:IsObjectType("Frame") and not child:GetName() and child:GetWidth() < 220 then
				if child.GetBackdrop and child:GetBackdrop() then
					child:StripTextures()
					child:SetTemplate("Transparent")
					break
				end
			end
		end

		if _G.BugsworthTaintListScrollScrollBar then
			S:HandleScrollBar(_G.BugsworthTaintListScrollScrollBar)
		end
		if _G.BugsworthTaintDetailScrollScrollBar then
			S:HandleScrollBar(_G.BugsworthTaintDetailScrollScrollBar)
		end

		S:HandleButton(_G.BugsworthTaintSessionBtn)
		S:HandleButton(_G.BugsworthTaintClearBtn)
		S:HandleButton(_G.BugsworthTaintCopyBtn)
		S:HandleButton(_G.BugsworthTaintCopyAllBtn)

		tf.isSkinned = true
		S:Unhook(BC, "OpenTaintViewer")
	end)

	local mmButton = _G.BugsworthMinimapButton
	if mmButton then
		mmButton:SetHighlightTexture(nil)

		for _, region in ipairs({mmButton:GetRegions()}) do
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
