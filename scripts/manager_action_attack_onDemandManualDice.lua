function onInit()
  -- replace default roll with adnd_roll to allow
  -- control-dice click to prompt for manual roll
  Debug.console("manager_action_attack_onDemandManualDice.lua","onInit","Initializing");
  ActionsManager.roll = adnd_roll;
  --
end

-- replace default roll with adnd_roll to allow
-- control-dice click to prompt for manual roll
function adnd_roll(rSource, vTargets, rRoll, bMultiTarget)
	if ActionsManager.doesRollHaveDice(rRoll) then
		DiceManager.onPreEncodeRoll(rRoll);
	
		if not rRoll.bTower and (OptionsManager.isOption("MANUALROLL", "on") or (Session.IsHost and Input.isControlPressed())) then
			ManualRollManager.addRoll(rRoll, rSource, vTargets);
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
