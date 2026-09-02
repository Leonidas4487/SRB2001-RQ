freeslot("MT_VSPRING","S_VSPRING0","S_VSPRING1","S_VSPRING2","SPR_VSPR")

mobjinfo[MT_VSPRING] = {
	--$Category Springs and Fans\Custom Springs
	--$Name Vertical Spring
	--$Sprite VSPRA0
	--$Arg0 Color Index
	--$Arg1 Strength
	--$Arg0Default 51
	--$Arg1Default 20
	doomednum = 561,
	spawnstate = S_VSPRING0,
	spawnhealth = 1000,
	seestate = S_VSPRING0,
	raisestate = S_VSPRING1,
	painsound = sfx_spring,
	radius = 20*FU,
	height = 16*FU,
	mass = 20*FU,
	flags = MF_SCENERY|MF_SPECIAL|MF_SOLID,
}

states[S_VSPRING0] = {SPR_VSPR, A, -1, A_None, 0, 0, S_VSPRING0}
states[S_VSPRING1] = {SPR_VSPR, B, 4, A_Pain, 0, 0, S_VSPRING2}
states[S_VSPRING2] = {SPR_VSPR, C|FF_ANIMATE, 2, A_None, 1, 1, S_VSPRING0}

addHook("MapThingSpawn", function(m)
	local col = m.spawnpoint.args[0]
	if col == 0 then col = 51 end

	m.color = col
end, MT_VSPRING)

addHook("TouchSpecial", function(m,p)
	local mass = m.spawnpoint.args[1]
	if mass == 0 then mass = 20 end

	m.info.mass = mass*FU

	P_DoSpring(m,p)
	return true
end, MT_VSPRING)

addHook("MobjSpawn",function(m) m.color = SKINCOLOR_YSP end,MT_YELLOWSPRING)
addHook("MobjSpawn",function(m) m.color = SKINCOLOR_RSP end,MT_REDSPRING)
addHook("MobjSpawn",function(m) m.color = SKINCOLOR_BSP end,MT_BLUESPRING)