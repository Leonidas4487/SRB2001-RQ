freeslot("MT_BALLSPRING","S_BSPRING0","S_BSPRING1","S_BSPRING2","S_BSPRING3","SPR_BSPR")

mobjinfo[MT_BALLSPRING] = {
	--$Category Springs and Fans\Custom Springs
	--$Name Ball Spring
	--$Sprite BSPRA0
	--$Arg0 Color Index
	--$Arg1 Strength
	--$Arg0Default 51
	--$Arg1Default 20
	doomednum = 1132,
	spawnstate = S_BSPRING0,
	spawnhealth = 1000,
	seestate = S_BSPRING0,
	raisestate = S_BSPRING1,
	painsound = sfx_spring,
	activesound = sfx_mswing,
	deathsound = sfx_pop,
	displayoffset = 1,
	speed = 24*FU,
	radius = 17*FU,
	height = 34*FU,
	mass = 20*FU,
	flags = MF_SPECIAL|MF_SOLID|MF_SCENERY|MF_NOGRAVITY,
}

states[S_BSPRING0] = {SPR_BSPR, A, -1, A_None, 0, 0, S_BSPRING0}
states[S_BSPRING1] = {SPR_BSPR, B, 4, A_Pain, 0, 0, S_BSPRING2}
states[S_BSPRING2] = {SPR_BSPR, C, 1, A_None, 0, 0, S_BSPRING3}
states[S_BSPRING3] = {SPR_BSPR, D, 1, A_None, 0, 0, S_BSPRING0}

addHook("MapThingSpawn", function(m)
	local col = m.spawnpoint.args[0]
	if col == 0 then col = 51 end

	m.color = col
	m.shadowscale = FU
end, MT_BALLSPRING)

addHook("TouchSpecial", function(m,p)
	local mass = m.spawnpoint.args[1]
	if mass == 0 then mass = 20 end

	m.info.mass = mass*FU

	P_DoSpring(m,p)
	return true
end, MT_BALLSPRING)

addHook("MobjSpawn",function(m) m.color = SKINCOLOR_YSP end,MT_YELLOWSPRINGBALL)
addHook("MobjSpawn",function(m) m.color = SKINCOLOR_RSP end,MT_REDSPRINGBALL)
addHook("MobjSpawn",function(m) m.color = SKINCOLOR_BSP end,MT_BLUESPRINGBALL)