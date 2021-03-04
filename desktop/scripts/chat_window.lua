-- 
-- Please see the license.html file included with this distribution for 
-- attribution and copyright information.
--
function onDrop(x, y, draginfo)
	local bReturn = ActionsManager.actionDrop(draginfo, nil);
	if bReturn then
		local aDice = draginfo.getDieList();
		if aDice and #aDice > 0 and (not OptionsManager.isOption("MANUALROLL", "on") and (not Input.isControlPressed() and Session.IsHost ) ) then
			return;
		end
		return true;
	end
	
	if draginfo.getType() == "language" then
		LanguageManager.setCurrentLanguage(draginfo.getStringData());
		return true;
	end
end
