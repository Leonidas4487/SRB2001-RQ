addHook("PlayerThink", function(player)
    if (gamestate == GS_LEVEL) and player.powers[pw_super] then	
        if player.powers[pw_underwater] < 29*TICRATE then
            player.powers[pw_underwater] = 30*TICRATE
        end   
        if player.powers[pw_spacetime] < 29*TICRATE then
            player.powers[pw_spacetime] = 30*TICRATE
        end
    end
end)