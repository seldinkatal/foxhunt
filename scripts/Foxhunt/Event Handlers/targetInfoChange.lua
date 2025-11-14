--Event:
--gmcp.IRE.Target.Info

function targetInfoChange()
	system.hunting.vars.currentTargetId = gmcp.IRE.Target.Info.id
end