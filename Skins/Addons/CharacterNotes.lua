local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("CharacterNotes") then return end


S:AddCallbackForAddon("CharacterNotes", "CharacterNotes", function()
	if not E.private.addOnSkins.CharacterNotes then return end
	if CharNoteTooltip then
		S:HandleFrame(CharNoteTooltip,true,true)
		S:HandleCloseButton(CharNoteTooltipCloseButton)
	end
	if CharacterNotesWindow then
		S:HandleFrame(CharacterNotesWindow,true,true)
		S:HandleFrame(ScrollTable1,true,true)
		-- :StripTextures()
		CharacterNotesWindow.searchterm:StripTextures()
		S:HandleEditBox(CharacterNotesWindow.searchterm,true)
		S:HandleButton(CharacterNotesWindow.closebutton)
		S:HandleButton(CharacterNotesWindow.clearbutton)
		S:HandleButton(CharacterNotesWindow.deletebutton)
		S:HandleButton(CharacterNotesWindow.editbutton)
		S:HandleButton(CharacterNotesWindow.searchbutton)
	end
	if CharacterNotesEditWindow then
		S:HandleFrame(CharacterNotesEditWindow,true,true)
		S:HandleScrollBar(CN_EditNote_EditScrollScrollBar)
		-- S:HandleEditBox(CharacterNotesEditWindow.editbox)
		S:HandleDropDownBox(CharacterNotesEditWindow.ratingDropdown)
		S:HandleButton(CharacterNotesEditWindow.savebutton)
		S:HandleButton(CharacterNotesEditWindow.cancelbutton)

	end
end)