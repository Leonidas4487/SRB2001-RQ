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
		if player.pflags & PF_THOKKED then
		if player.charability == CA_FLY or player.charability == CA_SWIM then
		    player.powers[pw_tailsfly] = 8*TICRATE
			end
        end
    end
end)

local ValidMaps = {
	["Sunset Flowers"] = { Act1 = "sfz1", Act2 = "sfz2" },
	["Forgotten Hardware"] = { Act1 = "fhz1", Act2 = "fhz2" },
	["Drenched Caverns"] = { Act1 = "dcz1", Act2 = "dcz2" },
	["Tubular Tunnels"] = { Act1 = "ttz1", Act2 = "ttz2" },
	["Cloudy Cliff-Face"] = { Act1 = "ccfz1", Act2 = "ccfz2" },
	["Blazing Vermilion"] = { Act1 = "bvz1", Act2 = "bvz2" },
	["Forsaken Square"] = { Act1 = "fsz1", Act2 = "fsz2" },
	["'Osphere Doomship"] = { Act1 = "odz1", Act2 = "odz2" },
	["Frantic Geode"] = { Act1 = "fgz1", Act2 = "fgz2" },
    ["Hidden Palace"] = { Act1 = "hpz1", Act2 = "hpz2" },
    ["Ween-a-Trickery"] = { Act1 = "watz1", Act2 = "watz2" },
	["Last Holiday"] = { Act1 = "lhz1", Act2 = "lhz2" },
    ["Lovely Air"] = { Act1 = "laz1", Act2 = "laz2" },
    ["Knothole Coast"] = { Act1 = "kcz1", Act2 = "kcz2" },
	["Shattered Nightmares"] = { Act1 = "snz1", Act2 = "snz2" },
    ["Fortress Yolk"] = { Act1 = "fyz1", Act2 = "fyz2" },
    ["Deserted Valley"] = { Act1 = "dvz1", Act2 = "dvz2" },
	["Jungle Woods"] = { Act1 = "jwz1", Act2 = "jwz2" },
    ["Angel's Heaven"] = { Act1 = "ahz1", Act2 = "ahz2" },
    ["Passing Calender"] = { Act1 = "pcz1", Act2 = "pcz2" },
	["Alien's Crib"] = { Act1 = "acz1", Act2 = "acz2" },
    ["EVIL Alien's Crib"] = { Act1 = "acz1", Act2 = "acz2" },
}

local isAct2 = false

addHook("MapLoad", function()
	isAct2 = false
end)

COM_AddCommand("dr_changetrack", function(player)
	if not netgame or gametype == GT_COOP or gametype == GT_COMPETITION or gametype == GT_RACE or gamestate ~= GS_LEVEL then
		CONS_Printf(player, "\x82"+"ERROR:\x80 This command only works if you are on a netgame with a valid gametype. Invalid gametypes include: Co-op, Race and Competition.")
		S_StartSound(player.mo, sfx_adderr)
		return
	end

	local Header = mapheaderinfo[gamemap]
	local Track = Header and ValidMaps[Header.lvlttl]
    if not Track then
		return
	end

	isAct2 = not isAct2

	local DaMusic = isAct2 and Track.Act2 or Track.Act1

    S_StartSound(player.mo, sfx_s3k63)
	S_ChangeMusic(DaMusic, true, player)
	CONS_Printf(player, "\x88"+"Changed current zone track to their Act ".. (isAct2 and "2" or "1").. " version!")
end)

addHook("PlayerThink", function(player)
	local Pressed = (player.cmd.buttons & BT_CUSTOM3) ~= 0 and (player.cmd.buttons & BT_CUSTOM2) ~= 0
	local WasPressed = (player.lastbuttons & BT_CUSTOM3) ~= 0 and (player.lastbuttons & BT_CUSTOM2) ~= 0
	if Pressed and not WasPressed then
		COM_BufInsertText(player, "dr_changetrack")
	end
end)