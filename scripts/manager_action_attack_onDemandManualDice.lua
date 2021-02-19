
--	change "not rRoll.bTower and OptionsManager.isOption("MANUALROLL", "on")" to
--	"not rRoll.bTower and (OptionsManager.isOption("MANUALROLL", "on") or (User.isHost and Input.isControlPressed()))"
local function roll_new(rSource, vTargets, rRoll, bMultiTarget)
	if ActionsManager.doesRollHaveDice(rRoll) then
		if not rRoll.bTower and (OptionsManager.isOption("MANUALROLL", "on") or (User.isHost and Input.isControlPressed())) then
			local wManualRoll = Interface.openWindow("manualrolls", "");
			wManualRoll.addRoll(rRoll, rSource, vTargets);
		else
			local rThrow = ActionsManager.buildThrow(rSource, vTargets, rRoll, bMultiTarget);
			Comm.throwDice(rThrow);
		end
	else
		if bMultiTarget then
			ActionsManager.handleResolution(rRoll, rSource, vTargets);
		else
			ActionsManager.handleResolution(rRoll, rSource, { vTargets });
		end
	end
end

-- replace default roll with roll_new to allow
-- control-dice click to prompt for manual roll
function onInit()
  ActionsManager.roll = roll_new;
end