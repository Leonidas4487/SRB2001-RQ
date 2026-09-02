addHook("MobjSpawn", function(emblem)
	emblem.origz = emblem.z
end, MT_EMBLEM)

addHook("MobjThinker", function(emblem)
	if not (emblem and emblem.valid) then return end
	if not (emblem.frame & FF_PAPERSPRITE) then
		emblem.frame = $|FF_PAPERSPRITE
	end
	emblem.angle = $ + FixedAngle(FRACUNIT)
	emblem.z = emblem.origz + 8 * abs(sin(FixedAngle(leveltime*4*FRACUNIT)))
	local emblemparticle = P_SpawnMobjFromMobj(emblem, P_RandomRange(-10, 10) * FRACUNIT, P_RandomRange(-10, 10) * FRACUNIT, 20*FRACUNIT, MT_SUPERSPARK)
	emblemparticle.momx = P_RandomRange(-2, 2) * FRACUNIT
	emblemparticle.momy = P_RandomRange(-2, 2) * FRACUNIT
	emblemparticle.momz =  P_RandomRange(-2, 2) * FRACUNIT
	emblemparticle.colorized = true
	emblemparticle.color = emblem.color
	emblemparticle.fuse = 10
	emblemparticle.scale = emblem.scale *1/6
	emblemparticle.source = emblem
	if (emblem.frame & FF_TRANSMASK) then
		emblemparticle.flags2 = MF2_DONTDRAW
	end
end, MT_EMBLEM)

addHook("MobjSpawn", function(cusemb)
	cusemb.origz = cusemb.z
end, MT_CUSEMB)

addHook("MobjThinker", function(cusemb)
	if not (cusemb and cusemb.valid) then return end
	if not (cusemb.frame & FF_PAPERSPRITE) then
		cusemb.frame = $|FF_PAPERSPRITE
	end
	cusemb.angle = $ + FixedAngle(FRACUNIT)
	cusemb.z = cusemb.origz + 8 * abs(sin(FixedAngle(leveltime*4*FRACUNIT)))
	local cusembparticle = P_SpawnMobjFromMobj(cusemb, P_RandomRange(-10, 10) * FRACUNIT, P_RandomRange(-10, 10) * FRACUNIT, 20*FRACUNIT, MT_SUPERSPARK)
	cusembparticle.momx = P_RandomRange(-2, 2) * FRACUNIT
	cusembparticle.momy = P_RandomRange(-2, 2) * FRACUNIT
	cusembparticle.momz =  P_RandomRange(-2, 2) * FRACUNIT
	cusembparticle.colorized = true
	cusembparticle.color = cusemb.color
	cusembparticle.fuse = 10
	cusembparticle.scale = cusemb.scale *1/6
	cusembparticle.source = cusemb
	if (cusemb.frame & FF_TRANSMASK) then
		cusembparticle.flags2 = MF2_DONTDRAW
	end
end, MT_CUSEMB)