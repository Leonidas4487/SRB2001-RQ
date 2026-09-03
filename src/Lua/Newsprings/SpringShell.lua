//Shoutouts to Glaber, Midiman and Monster Iestyn for the Spring Shells's code in Badnick Pack DX!

freeslot(
	"MT_SPRINGSHELLC","MT_VSPRING_SSD",
	"S_SPRINGSHELLC_STND",
	"S_SPRINGSHELLC0","S_SPRINGSHELLC1","S_SPRINGSHELLC2","S_SPRINGSHELLC3",
	"S_SPRINGSHELLC_S0","S_SPRINGSHELLC_S1","S_SPRINGSHELLC_S2",
	"S_SPRINGSHELLC_DEAD"
)

mobjinfo[MT_SPRINGSHELLC] = {
	--$Category Enemies\Custom Enemies
	--$Name Spring Shell
	--$Sprite SSHLA1
	--$Arg0 Color Index
	--$Arg1 Strength
	--$Arg2 Drop Spring?
	--$Arg0Default 56
	--$Arg1Default 15
	--$Arg2Default 0
	doomednum = 139,
	spawnstate = S_SPRINGSHELLC_STND,
	seestate = S_SPRINGSHELLC0,
	deathsound = sfx_pop,
	painsound = sfx_spring,
	deathstate = S_SPRINGSHELLC_DEAD,
	raisestate = S_SPRINGSHELLC_S0,
	spawnhealth = 1,
	reactiontime = 32,
	speed = 6,
	radius = 24*FU,
	height = 42*FU,
	mass = 15*FU,
	flags = MF_ENEMY|MF_SPECIAL|MF_SHOOTABLE,
}

states[S_SPRINGSHELLC_STND] = {SPR_SSHL, A, 4, A_Look, 0, 0, S_SPRINGSHELLC_STND}

states[S_SPRINGSHELLC0] = {SPR_SSHL, A, 4, A_Chase, 0, 0, S_SPRINGSHELLC1}
states[S_SPRINGSHELLC1] = {SPR_SSHL, B, 4, A_Chase, 0, 0, S_SPRINGSHELLC2}
states[S_SPRINGSHELLC2] = {SPR_SSHL, C, 4, A_Chase, 0, 0, S_SPRINGSHELLC3}
states[S_SPRINGSHELLC3] = {SPR_SSHL, D, 4, A_Chase, 0, 0, S_SPRINGSHELLC0}

states[S_SPRINGSHELLC_S0] = {SPR_SSHL, E, 4, A_Pain, 0, 0, S_SPRINGSHELLC_S1}
states[S_SPRINGSHELLC_S1] = {SPR_SSHL, F, 4, A_None, 0, 0, S_SPRINGSHELLC_S2}
states[S_SPRINGSHELLC_S2] = {SPR_SSHL, G, 4, A_None, 0, 0, S_SPRINGSHELLC0}

states[S_SPRINGSHELLC_DEAD] = {SPR_SSHL, E, 0, A_None, 0, 0, S_XPLD_FLICKY}

addHook("MapThingSpawn", function(m)
	local col = m.spawnpoint.args[0]
	if col == 0 then col = 56 end

	m.color = col
end, MT_SPRINGSHELLC)

local function NewSPRINGSHELLC(m,p)
	if p.player or (p.flags & MF_PUSHABLE and p.health > 0) then
		local _z = p.z
		local _mz = p.momz + _z
		local _h = m.z + m.height
		
		if m.eflags & MFE_VERTICALFLIP then
			_z = -(p.z + p.height)
			_mz = -p.momz + _z
			_h = -m.z
		end
		
		local total = FixedMul(8*FU,m.scale) * P_MobjFlip(m)

		if (_mz <= _h and _z > _h) or (_mz > _h - total and _mz < _h) then
			local mass = m.spawnpoint.args[1]
			if mass == 0 then mass = 15 end

			m.info.mass = mass*FU

			P_DoSpring(m,p)
			return true
		elseif (_z > _h - total and _z < _h) then
			return true
		end
	end
end

mobjinfo[MT_VSPRING_SSD] = {
	doomednum = -1,
	spawnstate = S_VSPRING0,
	spawnhealth = 1000,
	seestate = S_VSPRING0,
	raisestate = S_VSPRING1,
	painsound = sfx_spring,
	radius = 20*FU,
	height = 16*FU,
	flags = MF_SPECIAL|MF_SPRING|MF_SOLID,
}

addHook("TouchSpecial", function(m,p)
	local mass = m.springforce
	if mass == 0 then mass = 15 end

	m.info.mass = mass*FU

	P_DoSpring(m,p)
	return true
end, MT_VSPRING_SSD)

local function DropSpring(m)
	local drop = m.spawnpoint.args[2]
	local mass = m.spawnpoint.args[1]
	if mass == 0 then mass = 15 end

	if drop then
		local spr = P_SpawnMobj(m.x, m.y, m.z, MT_VSPRING_SSD)
		spr.momx = m.momx
		spr.momy = m.momy
		spr.momz = m.momz
		spr.angle = m.angle
		spr.scale = m.scale
		spr.flags2 = $ | MF2_OBJECTFLIP
		spr.color = m.color
		spr.springforce = mass
		return
	end
end

addHook("MobjCollide",NewSPRINGSHELLC,MT_SPRINGSHELLC)
addHook("MobjDeath",DropSpring,MT_SPRINGSHELLC)

addHook("MobjSpawn",function(m) m.color = SKINCOLOR_CHARTREUSE end,MT_SPRINGSHELL)
addHook("MobjSpawn",function(m) m.color = SKINCOLOR_YSP end,MT_YELLOWSHELL)
