freeslot(
	"MT_SPRINGCRAB","MT_SPRINGCRAB_D",
	"S_SPRCRAB_STND",
	"S_SPRCRAB_0","S_SPRCRAB_1","S_SPRCRAB_2","S_SPRCRAB_3",
	"S_SPRCRAB_P0","S_SPRCRAB_P1",
	"SPR_CRA2"
)

mobjinfo[MT_SPRINGCRAB] = {
	--$Category Enemies\Custom Enemies
	--$Name Custom Banpyura
	--$Sprite CRA2A0
	--$Arg0 Color Index
	--$Arg1 Strength
	--$Arg0Default 94
	--$Arg1Default 11
	doomednum = 140,
	spawnstate = S_SPRCRAB_0,
	deathstate = S_XPLD_FLICKY,
	deathsound = sfx_pop,
	spawnhealth = 1,
	reactiontime = 32,
	speed = 8,
	radius = 24*FU,
	height = 32*FU,
	flags = MF_ENEMY|MF_SPECIAL|MF_SHOOTABLE,
}

states[S_SPRCRAB_0] = {SPR_CRA2, A, 3, A_CrushstaceanWalk, 0, S_SPRCRAB_STND, S_SPRCRAB_1}
states[S_SPRCRAB_1] = {SPR_CRA2, B, 3, A_CrushstaceanWalk, 0, S_SPRCRAB_STND, S_SPRCRAB_2}
states[S_SPRCRAB_2] = {SPR_CRA2, A, 3, A_CrushstaceanWalk, 0, S_SPRCRAB_STND, S_SPRCRAB_3}
states[S_SPRCRAB_3] = {SPR_CRA2, C, 3, A_CrushstaceanWalk, 0, S_SPRCRAB_STND, S_SPRCRAB_0}
states[S_SPRCRAB_STND] = {SPR_CRA2, A, 40, A_None, 0, 0, S_SPRCRAB_0}

freeslot(
	"MT_SBRING",
	"S_SBRING0","S_SBRING1","S_SBRING2","S_SBRING3"
)

mobjinfo[MT_SBRING] = {
	doomednum = -1,
	spawnstate = S_SBRING0,
	seestate = S_SBRING1,
	raisestate = S_SBRING1,
	deathstate = S_XPLD1,
	painsound = sfx_cdfm08,
	deathsound = sfx_pop,
	spawnhealth = 1,
	speed = 300,
	radius = 22*FU,
	height = 22*FU,
	mass = 11*FU,
	damage = 11*FU,
	flags = MF_SOLID|MF_SPECIAL|MF_NOGRAVITY,
}

states[S_SBRING0] = {SPR_DSPR, A, 1, A_CrushclawAim, 40, 20, S_SBRING0}
states[S_SBRING1] = {SPR_DSPR, B, 1, A_Pain, 0, 0, S_SBRING2}
states[S_SBRING2] = {SPR_DSPR, C, 1, A_CrushclawAim, 40, 20, S_SBRING3}
states[S_SBRING3] = {SPR_DSPR, D, 1, A_CrushclawAim, 40, 20, S_SBRING0}

addHook("MapThingSpawn", function(m)
	local col = m.spawnpoint.args[0]
	local mass = m.spawnpoint.args[1]
	if col == 0 then col = 94 end
	if mass == 0 then mass = 11 end

	m.color = col
	m.shadowscale = FU

	local spr = P_SpawnMobjFromMobj(m,m.x, m.y, m.z, MT_SBRING)
	spr.momx = m.momx
	spr.momy = m.momy
	spr.momz = m.momz
	spr.angle = m.angle
	spr.scale = m.scale
	spr.flags2 = $ | MF2_OBJECTFLIP
	spr.color = m.color
	spr.springforce = mass
	spr.target = m
	spr.tracer = m

	return true
end, MT_SPRINGCRAB)

addHook("TouchSpecial", function(m,p)
	local mass = m.springforce
	if mass == 0 then mass = 11 end

	m.info.mass = mass*FU
	m.info.damage = mass*FU

	P_DoSpring(m,p)
	return true
end, MT_SBRING)

addHook("MobjSpawn",function(m) m.color = SKINCOLOR_FUCHSIA end,MT_BANPYURA)
addHook("MobjSpawn",function(m) m.color = SKINCOLOR_FUCHSIA end,MT_BANPSPRING)