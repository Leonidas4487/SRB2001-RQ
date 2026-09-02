--Proper Super Abilities by KevTSP
--The Fang and Metal Sonic abilities are from XMomentum by Frostiikin
--Didn't bother with Sonic or Knuckles since they already have super abilities implemented on them in vanilla SRB2

addHook("ThinkFrame", do
	for player in players.iterate
		if player.mo and player.mo.skin == "tails"
			if player.powers[pw_super]
				if player.powers[pw_tailsfly] == 1*TICRATE then
					player.powers[pw_tailsfly] =  8*TICRATE
				end
			end
		end
	end
end)

addHook("PlayerThink", function(player)
		if player.mo.skin == "amy"
		and player.mo.state == S_PLAY_MELEE_FINISH
		and player.powers[pw_super]
		if not player.bombhit == true
		P_NukeEnemies(player.mo, player.mo, 400*FRACUNIT)
		if (player == displayplayer)
			P_StartQuake(20*FRACUNIT, 10)
		end
		S_StartSound(player.mo, sfx_zoom)
		player.bombhit = true
		end
	end
	if not (player.mo.state == S_PLAY_MELEE) and (P_IsObjectOnGround(player.mo) == true)
	player.bombhit = false
	end
end)


addHook("PlayerThink", function(player)
	if player.mo.skin == "fang" and player.powers[pw_super]
		if player.mo.state == S_PLAY_BOUNCE_LANDING
			if player.bouncelatch == true
				P_NukeEnemies(player.mo, player.mo, 400*FRACUNIT)
				if (player == displayplayer)
					P_StartQuake(20*FRACUNIT, 10)
				end
				player.bouncelatch = false
			end
		else
			player.bouncelatch = true
		end
	end
end)

addHook("PlayerThink", function(player)
	if player.mo.skin == "metalsonic" and player.powers[pw_super]
				if player.dashmode > 3*TICRATE and player.dashhelper == true
					P_NukeEnemies(player.mo, player.mo, 800*FRACUNIT)
					if (player == displayplayer)
						P_StartQuake(20*FRACUNIT, 10)
					end
					player.dashhelper = false
				end
				if (player.dashmode <= 3*34)
					player.dashhelper = true
				end
	end
end)