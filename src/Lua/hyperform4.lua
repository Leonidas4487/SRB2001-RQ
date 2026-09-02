/*Team Prismatic For "Mystic Realm: Community Edition" (hyper music change here)
(https://mb.srb2.org/addons/the-mystic-realm-community-edition-mrce.8345/)*/

rawset(_G, "YouHyper", function(p)
	if not p.powers[pw_super] then return false end
	if p.valid and p.hyper.isunlocked /*and p.mo.skin == "sonic"*/ then
			return true
	elseif not p.hyper.isunlocked then
		return false
	end
end)

local theMusu = 0
addHook("PreThinkFrame", function(r)
	if (gamestate ~= GS_LEVEL) then return end
	if (consoleplayer and consoleplayer.mo and consoleplayer.mo.valid and consoleplayer.mo.health) then
		if YouHyper(consoleplayer) and not consoleplayer.powers[pw_extralife] then
			theMusu = S_GetMusicPosition()
		elseif not YouHyper(consoleplayer) then
			theMusu = 0
		end
	end
	if consoleplayer and consoleplayer.exiting and consoleplayer.exiting == 38 then
		--CONS_Printf(consoleplayer, consoleplayer.exiting)
		S_FadeMusic(0, 1250, consoleplayer)
	end
end)

addHook("MusicChange", function(om, nm)
	if (gamestate ~= GS_LEVEL) then return end
	if (consoleplayer and consoleplayer.mo and consoleplayer.mo.valid)
	and consoleplayer.mo.health and YouHyper(consoleplayer)
	and (nm == "_shoes" or nm == "_inv" or nm == "_minv" or nm == mapmusname or nm == "_super" or nm == "xsss") then
		if om == "_hyper" then
			return true
		else
			return "_hyper", 0, true, theMusu
		end
	end
	if (consoleplayer and consoleplayer.mo and consoleplayer.mo.valid)
	and consoleplayer.mo.health and consoleplayer.powers[pw_sneakers]
	and (nm == "_shoes") then
		if om == "_shoes" then
			return true
		else
			return "_shoes", 0, true, 0
		end
	end
	if (consoleplayer and consoleplayer.mo and consoleplayer.mo.valid)
	and consoleplayer.mo.health and consoleplayer.powers[pw_invulnerability]
	and (nm == "_inv") then
		if om == "_inv" then
			return true
		else
			return "_inv", 0, true, 0
		end
	end
end)

//from here on this file, everything was made by me
rawset(_G, "allsuper", 0)

addHook("ThinkFrame", do
    for player in players.iterate
        if allsuper == 1 then
            if not (player.charflags & SF_SUPER) then
                player.charflags = $1 | SF_SUPER
            end
        elseif allsuper == 0 then
            if (player.charflags & SF_SUPER) then
                if not (player.charflags & SF_SUPER) then
                    player.charflags = $1 & !SF_SUPER
                end
            end
        end
    end
end)

//You can just read the "CONS_Printf" to see what it does, it's very selfexplaining
COM_AddCommand("dr_transall", function(player, arg)
    allsuper = 1
	S_StartSound(player.mo, sfx_supert)
    CONS_Printf(player, "You now have transformation privileges! (effects last until exiting save file)")
    return
end, COM_ADMIN)

COM_AddCommand("dr_transnone", function(player, arg)
    allsuper = 0
	S_StartSound(player.mo, sfx_adderr)
    CONS_Printf(player, "Revoked transformation privileges... (effects won't work until exiting save file)")
    return
end, COM_ADMIN)

COM_AddCommand("dr_forcenone", function(player, arg)
    player.rings = 0
	S_StartSound(player.mo, sfx_antiri)
    CONS_Printf(player, "Forcing Des-transformation...")
    return
end, COM_ADMIN)

COM_AddCommand("dr_addrings", function(player, arg)
    player.rings = $ + 50
	S_StartSound(player.mo, sfx_itemup)
    CONS_Printf(player, "Added 50 rings to your pocket!")
    return
end, COM_ADMIN)

COM_AddCommand("dr_getchaos", function(player, arg)
        emeralds = 127
		S_StartSound(player.mo, sfx_cgot)
        CONS_Printf(player, "You now have all 7 Chaos Emeralds.")
    return
end, COM_ADMIN)

COM_AddCommand("dr_nonechaos", function(player, arg)
        emeralds = 0
		S_StartSound(player.mo, sfx_adderr)
        CONS_Printf(player, "Your 7 Chaos Emeralds have been removed.")
    return
end, COM_ADMIN)

COM_AddCommand("dr_noneshield", function(player, arg)
		player.powers[pw_shield] = 0
		P_RemoveShield(player)
		S_StartSound(player.mo, sfx_shldls)
        CONS_Printf(player, "Your shield has been removed.")
    return
end, COM_ADMIN)