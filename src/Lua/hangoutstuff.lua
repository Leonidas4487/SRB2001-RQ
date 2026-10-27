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

rawset(_G, "act2", 0)

addHook("MapLoad", function()
    rawset(_G, "act2", 0)
end)

COM_AddCommand("dr_changetrack", function(player, arg)
    if (gamestate == GS_LEVEL) then
        if not netgame or (gametype == GT_COOP or gametype == GT_COMPETITION or gametype == GT_RACE) then
            CONS_Printf(player, "\x82"+"ERROR:\x80 This command only works if you are on a netgame with a valid gametype. Invalid gametypes include: Co-op, Race and Competition.")
            return
        end
    //Sunset Flowers Changes
        if mapheaderinfo[gamemap].lvlttl == "Sunset Flowers" and act2 == 0 then
            act2 = 1
            S_ChangeMusic("sfz2", true, player)
            CONS_Printf(player, "\x88"+"Changed current zone track to their Act 2 version!")
        elseif mapheaderinfo[gamemap].lvlttl == "Sunset Flowers" and act2 == 1 then
            act2 = 0
            S_ChangeMusic("sfz1", true, player)
            CONS_Printf(player, "\x88"+"Changed current zone track to their Act 1 version!")
    //Forgotten Hardware Changes
        elseif mapheaderinfo[gamemap].lvlttl == "Forgotten Hardware" and act2 == 0 then
            act2 = 1
            S_ChangeMusic("fhz2", true, player)
            CONS_Printf(player, "\x88"+"Changed current zone track to their Act 2 version!")
        elseif mapheaderinfo[gamemap].lvlttl == "Forgotten Hardware" and act2 == 1 then
            act2 = 0
            S_ChangeMusic("fhz1", true, player)
            CONS_Printf(player, "\x88"+"Changed current zone track to their Act 1 version!")
    //Drenched Caverns Changes
        elseif mapheaderinfo[gamemap].lvlttl == "Drenched Caverns" and act2 == 0 then
            act2 = 1
            S_ChangeMusic("dcz2", true, player)
            CONS_Printf(player, "\x88"+"Changed current zone track to their Act 2 version!")
        elseif mapheaderinfo[gamemap].lvlttl == "Drenched Caverns" and act2 == 1 then
            act2 = 0
            S_ChangeMusic("dcz1", true, player)
            CONS_Printf(player, "\x88"+"Changed current zone track to their Act 1 version!")
    //Tubular Tunnels Changes
        elseif mapheaderinfo[gamemap].lvlttl == "Tubular Tunnels" and act2 == 0 then
            act2 = 1
            S_ChangeMusic("ttz2", true, player)
            CONS_Printf(player, "\x88"+"Changed current zone track to their Act 2 version!")
        elseif mapheaderinfo[gamemap].lvlttl == "Tubular Tunnels" and act2 == 1 then
            act2 = 0
            S_ChangeMusic("ttz1", true, player)
            CONS_Printf(player, "\x88"+"Changed current zone track to their Act 1 version!")
    //Cloudy Cliff-Face Changes
        elseif mapheaderinfo[gamemap].lvlttl == "Cloudy Cliff-Face" and act2 == 0 then
            act2 = 1
            S_ChangeMusic("ccfz2", true, player)
            CONS_Printf(player, "\x88"+"Changed current zone track to their Act 2 version!")
        elseif mapheaderinfo[gamemap].lvlttl == "Cloudy Cliff-Face" and act2 == 1 then
            act2 = 0
            S_ChangeMusic("ccfz1", true, player)
            CONS_Printf(player, "\x88"+"Changed current zone track to their Act 1 version!")
    //Blazing Vermilion Changes
        elseif mapheaderinfo[gamemap].lvlttl == "Blazing Vermilion" and act2 == 0 then
            act2 = 1
            S_ChangeMusic("bvz2", true, player)
            CONS_Printf(player, "\x88"+"Changed current zone track to their Act 2 version!")
        elseif mapheaderinfo[gamemap].lvlttl == "Blazing Vermilion" and act2 == 1 then
            act2 = 0
            S_ChangeMusic("bvz1", true, player)
            CONS_Printf(player, "\x88"+"Changed current zone track to their Act 1 version!")
    //Forsaken Square Changes
        elseif mapheaderinfo[gamemap].lvlttl == "Forsaken Square" and act2 == 0 then
            act2 = 1
            S_ChangeMusic("fsz2", true, player)
            CONS_Printf(player, "\x88"+"Changed current zone track to their Act 2 version!")
        elseif mapheaderinfo[gamemap].lvlttl == "Forsaken Square" and act2 == 1 then
            act2 = 0
            S_ChangeMusic("fsz1", true, player)
            CONS_Printf(player, "\x88"+"Changed current zone track to their Act 1 version!")
    //'Osphere Doomship Changes
        elseif mapheaderinfo[gamemap].lvlttl == "'Osphere Doomship" and act2 == 0 then
            act2 = 1
            S_ChangeMusic("odz2", true, player)
            CONS_Printf(player, "\x88"+"Changed current zone track to their Act 2 version!")
        elseif mapheaderinfo[gamemap].lvlttl == "'Osphere Doomship" and act2 == 1 then
            act2 = 0
            S_ChangeMusic("odz1", true, player)
            CONS_Printf(player, "\x88"+"Changed current zone track to their Act 1 version!")
    //Frantic Geode Changes
        elseif mapheaderinfo[gamemap].lvlttl == "Frantic Geode" and act2 == 0 then
            act2 = 1
            S_ChangeMusic("fgz2", true, player)
            CONS_Printf(player, "\x88"+"Changed current zone track to their Act 2 version!")
        elseif mapheaderinfo[gamemap].lvlttl == "Frantic Geode" and act2 == 1 then
            act2 = 0
            S_ChangeMusic("fgz1", true, player)
            CONS_Printf(player, "\x88"+"Changed current zone track to their Act 1 version!")
    //Last Holiday Changes
        elseif mapheaderinfo[gamemap].lvlttl == "Last Holiday" and act2 == 0 then
            act2 = 1
            S_ChangeMusic("lhz2", true, player)
            CONS_Printf(player, "\x88"+"Changed current zone track to their Act 2 version!")
        elseif mapheaderinfo[gamemap].lvlttl == "Last Holiday" and act2 == 1 then
            act2 = 0
            S_ChangeMusic("lhz1", true, player)
            CONS_Printf(player, "\x88"+"Changed current zone track to their Act 1 version!")
        end
    end
end)

addHook("PlayerThink", function(player)
    local pressed = (player.cmd.buttons & BT_CUSTOM3) ~= 0
    local wasPressed = (player.lastbuttons & BT_CUSTOM3) ~= 0
    if pressed and not wasPressed then
        COM_BufInsertText(player, "dr_changetrack")
    end
end)