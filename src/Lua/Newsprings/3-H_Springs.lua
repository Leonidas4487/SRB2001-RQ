freeslot("MT_HSPRING","S_HSPRING0","S_HSPRING1","S_HSPRING2","S_HSPRING3","SPR_HSPR")

mobjinfo[MT_HSPRING] = {
	--$Category Springs and Fans\Custom Springs
	--$Name Horizontal Spring
	--$Sprite HSPRA1
	--$Arg0 Color Index
	--$Arg1 Strength
	--$Arg0Default 51
	--$Arg1Default 36
	--$Angled
	doomednum = 562,
	spawnstate = S_HSPRING0,
	spawnhealth = 1000,
	raisestate = S_HSPRING1,
	painsound = sfx_spring,
	radius = 16*FU,
	height = 32*FU,
	damage = 36*FU,
	flags = MF_SPECIAL|MF_NOGRAVITY,
}

states[S_HSPRING0] = {SPR_HSPR, A, -1, A_None, 0, 0, S_HSPRING0}
states[S_HSPRING1] = {SPR_HSPR, B, 4, A_Pain, 0, 0, S_HSPRING2}
states[S_HSPRING2] = {SPR_HSPR, C, 1, A_None, 0, 0, S_HSPRING3}
states[S_HSPRING3] = {SPR_HSPR, D, 1, A_None, 0, 0, S_HSPRING0}

addHook("MapThingSpawn", function(m)
	local col = m.spawnpoint.args[0]
	if col == 0 then col = 51 end

	m.color = col
end, MT_HSPRING)

addHook("TouchSpecial", function(m,p)
	local mass = m.spawnpoint.args[1]
	if mass == 0 then mass = 36 end

	m.info.damage = mass*FU

	P_DoSpring(m,p)
	return true
end, MT_HSPRING)

addHook("MobjSpawn",function(m) m.color = SKINCOLOR_YSP end,MT_YELLOWHORIZ)
addHook("MobjSpawn",function(m) m.color = SKINCOLOR_RSP end,MT_REDHORIZ)
addHook("MobjSpawn",function(m) m.color = SKINCOLOR_BSP end,MT_BLUEHORIZ)
