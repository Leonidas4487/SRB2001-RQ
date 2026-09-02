
// credits to TheLastKitchenGun https://mb.srb2.org/members/thelastkitchengun.16608/

	freeslot("SPR_SFSP", "MT_SUPERFORMSPARKLE", "S_SUPERFORMSPARKLE")
	
	mobjinfo[MT_SUPERFORMSPARKLE] = {
	doomednum = -1,
	spawnstate = S_SUPERFORMSPARKLE,
	deathstate = S_NULL,
	spawnhealth = 999,
	deathsound = sfx_none,
	seesound = sfx_none,
	attacksound = sfx_none,
	painsound = sfx_none,
	activesound = sfx_none,
	painstate = S_NULL,
	speed = 10*FRACUNIT,
	radius = 48*FRACUNIT,
	height = 48*FRACUNIT,
	flags = MF_SCENERY|MF_NOGRAVITY|MF_NOCLIPHEIGHT|MF_NOCLIP
	}
	
	states[S_SUPERFORMSPARKLE] = {
	sprite = SPR_SFSP,
	frame = FF_ANIMATE|FF_SEMIBRIGHT|A,
	tics = 33,
	var1 = 10,
	var2 = 1,
	action = A_None,
	nextstate = S_NULL
	}
	
	//states[S_SUPERFORMSPARKLE] = {
	//sprite = SPR_IVSP,
	//frame = FF_ANIMATE|FF_SEMIBRIGHT|A,
	//tics = -1,
	//var1 = 5,
	//var2 = 1,
	//nextstate = S_NULL
	//}
	
	addHook("PlayerThink", function(player)
		if (player.spectator)
		return end
			if (player.mo and player.mo.valid)
				if (player.mo.state >= S_PLAY_SUPER_TRANS1 and player.mo.state <= S_PLAY_SUPER_TRANS6)
				return end
					if (player.powers[pw_super]) or (player.solchar and player.solchar.istransformed) or (player.hypermysticsonic or player.mysticsuper)
					and (leveltime % TICRATE * 3)
					player.sparkle = P_SpawnMobjFromMobj(player.mo, P_RandomRange(-10, 10)<<FRACBITS, P_RandomRange(-10, 10)<<FRACBITS, P_RandomRange(0, player.mo.height/FRACUNIT)<<FRACBITS, MT_SUPERFORMSPARKLE)
					player.sparkle.scale = player.mo.scale
					player.sparkle.color = player.mo.color
					player.sparkle.isthereabetterwaytogetthesourcemo = player.mo
					end
			end
	end)
	
	addHook("MobjThinker", function(sparkle)
		sparkle.color = sparkle.isthereabetterwaytogetthesourcemo.color
	end, MT_SUPERFORMSPARKLE)