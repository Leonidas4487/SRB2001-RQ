addHook("PlayerThink", function(player)
    for player in players.iterate do
        if player.mo and player.mo.valid 
	
	if mapheaderinfo[gamemap].lvlttl == "Final Fright" then

		if player.powers[pw_super] or player.hyper.transformed --and not player.hyper.transformed
		S_ChangeMusic("finalb", true, player)
			
	if player.powers[pw_super] and player.rings <= 1 then
P_DamageMobj(player.mo,nil,nil,1,DMG_INSTAKILL)
                    end
                end
            end
        end
	end
end)