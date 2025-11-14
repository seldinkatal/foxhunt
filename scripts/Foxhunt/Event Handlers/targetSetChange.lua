--Events:
--gmcp.IRE.Target.Set

function targetSetChange() 
	system.hunting.vars.currentTargetId = gmcp.IRE.Target.Set
end