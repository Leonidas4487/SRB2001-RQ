freeslot("MT_DSPRING","S_DSPRING0","S_DSPRING1","S_DSPRING2","S_DSPRING3","SPR_DSPR")

mobjinfo[MT_DSPRING] = {
	--$Category Springs and Fans\Custom Springs
	--$Name Diagonal Spring
	--$Sprite DSPRA1
	--$Arg0 Color Index
	--$Arg1 Strength
	--$Arg0Default 51
	--$Arg1Default 20
	--$Angled
	doomednum = 563,
	spawnstate = S_DSPRING0,
	spawnhealth = 1000,
	raisestate = S_DSPRING1,
	painsound = sfx_spring,
	radius = 16*FU,
	height = 16*FU,
	mass = 20*FU,
	damage = 20*FU,
	flags = MF_SPECIAL|MF_SOLID,
}

states[S_DSPRING0] = {SPR_DSPR, A, -1, A_None, 0, 0, S_DSPRING0}
states[S_DSPRING1] = {SPR_DSPR, B, 4, A_Pain, 0, 0, S_DSPRING2}
states[S_DSPRING2] = {SPR_DSPR, C, 1, A_None, 0, 0, S_DSPRING3}
states[S_DSPRING3] = {SPR_DSPR, D, 1, A_None, 0, 0, S_DSPRING0}

addHook("MapThingSpawn", function(m)
	local col = m.spawnpoint.args[0]
	if col == 0 then col = 51 end

	m.color = col
end, MT_DSPRING)

addHook("TouchSpecial", function(m,p)
	local mass = m.spawnpoint.args[1]
	if mass == 0 then mass = 36 end

	m.info.mass = mass*FU
	m.info.damage = mass*FU

	P_DoSpring(m,p)
	return true
end, MT_DSPRING)

addHook("MobjSpawn",function(m) m.color = SKINCOLOR_YSP end,MT_YELLOWDIAG)
addHook("MobjSpawn",function(m) m.color = SKINCOLOR_RSP end,MT_REDDIAG)
addHook("MobjSpawn",function(m) m.color = SKINCOLOR_BSP end,MT_BLUEDIAG)