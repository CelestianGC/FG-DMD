function onInit()
  -- replace default roll with adnd_roll to allow
  -- control-dice click to prompt for manual roll
  ActionsManager.roll = adnd_roll;
  --
end

-- replace default roll with adnd_roll to allow
-- control-dice click to prompt for manual roll
function adnd_roll(rSource, vTargets, rRoll, bMultiTarget)
	if #(rRoll.aDice) > 0 then
		if not rRoll.bTower and (OptionsManager.isOption("MANUALROLL", "on") or (Session.isHost and Input.isControlPressed())) then
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
