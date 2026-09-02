freeslot(
"TOL_HANGOUT"
)

G_AddGametype({
    name = "Hangout",
    identifier = "hangout",
    typeoflevel = TOL_HANGOUT,
    rules = GTR_CUTSCENES|GTR_SPECTATORS|GTR_FRIENDLY|GTR_NOSPECTATORSPAWN|GTR_ALLOWEXIT|GTR_POWERSTONES|GTR_SPECIALSTAGES|GTR_EMERALDTOKENS|GTR_FRIENDLYFIRE|GTR_TEAMFLAGS,
    intermissiontype = int_coop,
	rankingtype = GT_COOP,
    headerleftcolor = 123,
	headerrightcolor = 113,
    description = "I think it's pretty obvious what you can do here, so, go enjoy it! :D"
})

addHook("PlayerThink", function(player)
    if (gamestate == GS_LEVEL) and (gametype == GT_HANGOUT) then	
        if player.powers[pw_underwater] < 29*TICRATE then
            player.powers[pw_underwater] = 30*TICRATE
        end   
        if player.powers[pw_spacetime] < 29*TICRATE then
            player.powers[pw_spacetime] = 30*TICRATE
        end
		if player.pflags & PF_THOKKED
		if player.charability == CA_FLY or player.charability == CA_SWIM then
		    player.powers[pw_tailsfly] = 8*TICRATE
			end
        end
    end
end)