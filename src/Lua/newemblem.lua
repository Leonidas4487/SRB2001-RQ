freeslot("MT_CUSEMB", "SPR_SOMB", "SPR_SOTN", "SFX_CUSEMB", 
"S_SOMBADV01", "S_SOMBADV02", "S_SOMBADV03", "S_SOMBADV04", "S_SOMBADV05", 
"S_SOMBADV06", "S_SOMBADV07", "S_SOMBADV08", "S_SOMBADV09", "S_SOMBADV10", 
"S_SOMBADV11", "S_SOMBADV12", "S_SOMBADV13", "S_SOMBADV14", "S_SOMBADV15", 
"S_SOMBADV16", "S_SOMBADV17", "S_SOMBADV18", "S_SOMBADV19")

states[S_SOMBADV01] = { SPR_SOMB, A, -1, nil, 0, 0, S_NULL }
states[S_SOMBADV02] = { SPR_SOMB, B, -1, nil, 0, 0, S_NULL }
states[S_SOMBADV03] = { SPR_SOMB, C, -1, nil, 0, 0, S_NULL }
states[S_SOMBADV04] = { SPR_SOMB, D, -1, nil, 0, 0, S_NULL }
states[S_SOMBADV05] = { SPR_SOMB, E, -1, nil, 0, 0, S_NULL }
states[S_SOMBADV06] = { SPR_SOMB, F, -1, nil, 0, 0, S_NULL }
states[S_SOMBADV07] = { SPR_SOMB, G, -1, nil, 0, 0, S_NULL }
states[S_SOMBADV08] = { SPR_SOMB, H, -1, nil, 0, 0, S_NULL }
states[S_SOMBADV09] = { SPR_SOMB, I, -1, nil, 0, 0, S_NULL }
states[S_SOMBADV10] = { SPR_SOMB, J, -1, nil, 0, 0, S_NULL }
states[S_SOMBADV11] = { SPR_SOMB, K, -1, nil, 0, 0, S_NULL }
states[S_SOMBADV12] = { SPR_SOMB, L, -1, nil, 0, 0, S_NULL }
states[S_SOMBADV13] = { SPR_SOMB, M, -1, nil, 0, 0, S_NULL }
states[S_SOMBADV14] = { SPR_SOMB, N, -1, nil, 0, 0, S_NULL }
states[S_SOMBADV15] = { SPR_SOMB, O, -1, nil, 0, 0, S_NULL }
states[S_SOMBADV16] = { SPR_SOMB, P, -1, nil, 0, 0, S_NULL }
states[S_SOMBADV17] = { SPR_SOMB, Q, -1, nil, 0, 0, S_NULL }
states[S_SOMBADV18] = { SPR_SOMB, R, -1, nil, 0, 0, S_NULL }
states[S_SOMBADV19] = { SPR_SOMB, S, -1, nil, 0, 0, S_NULL }

sfxinfo[sfx_cusemb] = {
        singular = false,
        priority = 64,
        flags = SF_X4AWAYSOUND|SF_X8AWAYSOUND
}
sfxinfo[sfx_cusemb].caption = "Sonikino Emblem Collected!"

//Bank Reserver for the emblems!
local luabanks = _G.luabanks
if not luabanks then
    luabanks = reserveLuabanks()
    rawset(_G, "luabanks", luabanks)
end

//Storing emblems
local EMBLEM_SLOT = 1
local EMBLEM_COUNT = 40 --change later to adjust to actual count of emblems (template)

//checks if you obtain emblem "idk"
local function hasEmblem(idx)
    if idx < 1 or idx > EMBLEM_COUNT then
        return false
    end
    local bit = idx - 1  -- convert to 0-based bit
    return (luabanks[EMBLEM_SLOT] & (1 << bit)) ~= 0
end

//this sets the emblem to true or false depending if you got it or not :)
local function setEmblem(idx, value)
    if idx < 1 or idx > EMBLEM_COUNT then
        return
    end
    local bit = idx - 1
    local mask = 1 << bit
    if value then
        luabanks[EMBLEM_SLOT] = luabanks[EMBLEM_SLOT] | mask
    else
        luabanks[EMBLEM_SLOT] = luabanks[EMBLEM_SLOT] & ~mask
    end
    -- Update globals for existing code
    rawset(_G, "sonk1", hasEmblem(1) and 1 or 0)
    rawset(_G, "sonk2", hasEmblem(2) and 1 or 0)
    rawset(_G, "sonk3", hasEmblem(3) and 1 or 0)
	rawset(_G, "sonk4", hasEmblem(4) and 1 or 0)
	rawset(_G, "sonk5", hasEmblem(5) and 1 or 0)
	rawset(_G, "sonk6", hasEmblem(6) and 1 or 0)
	rawset(_G, "sonk7", hasEmblem(7) and 1 or 0)
	rawset(_G, "sonk8", hasEmblem(8) and 1 or 0)
	rawset(_G, "sonk9", hasEmblem(9) and 1 or 0)
	rawset(_G, "sonk10", hasEmblem(10) and 1 or 0)
	rawset(_G, "sonk11", hasEmblem(11) and 1 or 0)
	rawset(_G, "sonk12", hasEmblem(12) and 1 or 0)
	rawset(_G, "sonk13", hasEmblem(13) and 1 or 0)
	rawset(_G, "sonk14", hasEmblem(14) and 1 or 0)
	rawset(_G, "sonk15", hasEmblem(15) and 1 or 0)
	rawset(_G, "sonk16", hasEmblem(16) and 1 or 0)
	rawset(_G, "sonk17", hasEmblem(17) and 1 or 0)
	rawset(_G, "sonk18", hasEmblem(18) and 1 or 0)
	rawset(_G, "sonk19", hasEmblem(19) and 1 or 0)
end

//intializes the stuff
rawset(_G, "sonk1", hasEmblem(1) and 1 or 0)
rawset(_G, "sonk2", hasEmblem(2) and 1 or 0)
rawset(_G, "sonk3", hasEmblem(3) and 1 or 0)
rawset(_G, "sonk4", hasEmblem(4) and 1 or 0)
rawset(_G, "sonk5", hasEmblem(5) and 1 or 0)
rawset(_G, "sonk6", hasEmblem(6) and 1 or 0)
rawset(_G, "sonk7", hasEmblem(7) and 1 or 0)
rawset(_G, "sonk8", hasEmblem(8) and 1 or 0)
rawset(_G, "sonk9", hasEmblem(9) and 1 or 0)
rawset(_G, "sonk10", hasEmblem(10) and 1 or 0)
rawset(_G, "sonk11", hasEmblem(11) and 1 or 0)
rawset(_G, "sonk12", hasEmblem(12) and 1 or 0)
rawset(_G, "sonk13", hasEmblem(13) and 1 or 0)
rawset(_G, "sonk14", hasEmblem(14) and 1 or 0)
rawset(_G, "sonk15", hasEmblem(15) and 1 or 0)
rawset(_G, "sonk16", hasEmblem(16) and 1 or 0)
rawset(_G, "sonk17", hasEmblem(17) and 1 or 0)
rawset(_G, "sonk18", hasEmblem(18) and 1 or 0)
rawset(_G, "sonk19", hasEmblem(19) and 1 or 0)

addHook("TouchSpecial", function(cusemb, p)
    if not (p and p.player and p.valid and p.health) then
        return
    end

    local state = cusemb and cusemb.state

    if state == S_SOMBADV01 and not hasEmblem(1) then
        setEmblem(1, true)
        CONS_Printf(p.player, "\x88"+"A tiny tree, very good decoration for a house!\x80")
    elseif state == S_SOMBADV02 and not hasEmblem(2) then
        setEmblem(2, true)
        CONS_Printf(p.player, "\x88"+"Hey apple! I just got this emblem!\x80")
    elseif state == S_SOMBADV03 and not hasEmblem(3) then
        setEmblem(3, true)
        CONS_Printf(p.player, "\x88"+"Some scraps, wonder if a Fennec Fox could like these...\x80")
    elseif state == S_SOMBADV04 and not hasEmblem(4) then
        setEmblem(4, true)
        CONS_Printf(p.player, "\x88"+"A splat of purple goo, maybe it tastes like grapes?\x80")
    elseif state == S_SOMBADV05 and not hasEmblem(5) then
        setEmblem(5, true)
        CONS_Printf(p.player, "\x88"+"And the lemonade stand? WHERE'S THE LEMONADE STAND!?!?!?\x80")
    elseif state == S_SOMBADV06 and not hasEmblem(6) then
        setEmblem(6, true)
        CONS_Printf(p.player, "\x88"+"Water! Water? Huh... It's just water...\x80")
    elseif state == S_SOMBADV07 and not hasEmblem(7) then
        setEmblem(7, true)
        CONS_Printf(p.player, "\x88"+"Some gems from this cave system, brought to you by Sonikino himself!\x80")
    elseif state == S_SOMBADV08 and not hasEmblem(8) then
        setEmblem(8, true)
        CONS_Printf(p.player, "\x88"+"A mystical shard from a different realm, a mystic realm!\x80")
    elseif state == S_SOMBADV09 and not hasEmblem(9) then
        setEmblem(9, true)
        CONS_Printf(p.player, "\x88"+"A cloud made of hopes and dreams, very fluffy and soft!\x80")
    elseif state == S_SOMBADV10 and not hasEmblem(10) then
        setEmblem(10, true)
        CONS_Printf(p.player, "\x88"+"A smiley ball from an old computer, good thing it's just a ball and not alive! Right?..\x80")
	elseif state == S_SOMBADV11 and not hasEmblem(11) then
        setEmblem(11, true)
        CONS_Printf(p.player, "\x88"+"A blazle cookie, with your favorite ingredient: LAVA!\x80")
	elseif state == S_SOMBADV12 and not hasEmblem(12) then
        setEmblem(12, true)
        CONS_Printf(p.player, "\x88"+"Sword of the darkest vermilions in this volcano, does +1000 damage, bad thing you don't have hands...\x80")
	elseif state == S_SOMBADV13 and not hasEmblem(13) then
        setEmblem(13, true)
        CONS_Printf(p.player, "\x88"+"A... JOB APPLICATION!?!?!? RUNNNNNN!!!!!!!\x80")
	elseif state == S_SOMBADV14 and not hasEmblem(14) then
        setEmblem(14, true)
        CONS_Printf(p.player, "\x88"+"An electricity generator, it seems to have been ripped apart from a cable system of a ship...\x80")
	elseif state == S_SOMBADV15 and not hasEmblem(15) then
        setEmblem(15, true)
        CONS_Printf(p.player, "\x88"+"Some leftover pizza from a pizza party from yesterday, it really was a pizza time that day...\x80")
	elseif state == S_SOMBADV16 and not hasEmblem(16) then
        setEmblem(16, true)
        CONS_Printf(p.player, "\x88"+"A broken lever from this airship, the person who broke it must have been very stressed...\x80")
	elseif state == S_SOMBADV17 and not hasEmblem(17) then
        setEmblem(17, true)
        CONS_Printf(p.player, "\x88"+"You got the egg. It's not too important, but not too un-important...\x80")
	elseif state == S_SOMBADV18 and not hasEmblem(18) then
        setEmblem(18, true)
        CONS_Printf(p.player, "\x88"+"A key that opens a very secret room! The catch is that the room doesn't exist anymore!\x80")
	elseif state == S_SOMBADV19 and not hasEmblem(19) then
        setEmblem(19, true)
        CONS_Printf(p.player, "\x88"+"A crown for your very good actions! Enjoy it as much as you want!\x80")
	
    end
end, MT_CUSEMB)

addHook("MapThingSpawn", function(mo, mt)
    if not (mo and mo.valid) then
        return
    end

//this is extracted from the sonikino handler (sonkhandler.lua) please check it.

    local arg0 = "0"
    if mt and mt.args then
        arg0 = tostring(mt.args[0])
    end

    if arg0 == "1" then
        mo.state = S_SOMBADV02
    elseif arg0 == "2" then
        mo.state = S_SOMBADV03
    elseif arg0 == "3" then
        mo.state = S_SOMBADV04
	elseif arg0 == "4" then
        mo.state = S_SOMBADV05
	elseif arg0 == "5" then
        mo.state = S_SOMBADV06
	elseif arg0 == "6" then
        mo.state = S_SOMBADV07
	elseif arg0 == "7" then
        mo.state = S_SOMBADV08
	elseif arg0 == "8" then
        mo.state = S_SOMBADV09
	elseif arg0 == "9" then
        mo.state = S_SOMBADV10
	elseif arg0 == "10" then
        mo.state = S_SOMBADV11
	elseif arg0 == "11" then
        mo.state = S_SOMBADV12
	elseif arg0 == "12" then
        mo.state = S_SOMBADV13
	elseif arg0 == "13" then
        mo.state = S_SOMBADV14
	elseif arg0 == "14" then
        mo.state = S_SOMBADV15
	elseif arg0 == "15" then
        mo.state = S_SOMBADV16
	elseif arg0 == "16" then
        mo.state = S_SOMBADV17
	elseif arg0 == "17" then
        mo.state = S_SOMBADV18
	elseif arg0 == "18" then
        mo.state = S_SOMBADV19
    else
        mo.state = S_SOMBADV01
    end

//if you have the emblem then it dissapears
    if hasEmblem(1) and mo.state == S_SOMBADV01 then
        mo.state = S_NULL
    elseif hasEmblem(2) or not hasEmblem(1) and mo.state == S_SOMBADV02 then
        mo.state = S_NULL
    elseif hasEmblem(3) or not hasEmblem(1) and mo.state == S_SOMBADV03 then
        mo.state = S_NULL
    elseif hasEmblem(4) or not hasEmblem(1) and mo.state == S_SOMBADV04 then
        mo.state = S_NULL
	elseif hasEmblem(5) or not hasEmblem(1) and mo.state == S_SOMBADV05 then
        mo.state = S_NULL
	elseif hasEmblem(6) or not hasEmblem(1) and mo.state == S_SOMBADV06 then
        mo.state = S_NULL
	elseif hasEmblem(7) or not hasEmblem(1) and mo.state == S_SOMBADV07 then
        mo.state = S_NULL
	elseif hasEmblem(8) or not hasEmblem(1) and mo.state == S_SOMBADV08 then
        mo.state = S_NULL
    elseif hasEmblem(9) or not hasEmblem(1) and mo.state == S_SOMBADV09 then
        mo.state = S_NULL
	elseif hasEmblem(10) or not hasEmblem(1) and mo.state == S_SOMBADV10 then
        mo.state = S_NULL
	elseif hasEmblem(11) or not hasEmblem(1) and mo.state == S_SOMBADV11 then
        mo.state = S_NULL
	elseif hasEmblem(12) or not hasEmblem(1) and mo.state == S_SOMBADV12 then
        mo.state = S_NULL
	elseif hasEmblem(13) or not hasEmblem(1) and mo.state == S_SOMBADV13 then
        mo.state = S_NULL
	elseif hasEmblem(14) or not hasEmblem(1) and mo.state == S_SOMBADV14 then
        mo.state = S_NULL
	elseif hasEmblem(15) or not hasEmblem(1) and mo.state == S_SOMBADV15 then
        mo.state = S_NULL
	elseif hasEmblem(16) or not hasEmblem(1) and mo.state == S_SOMBADV16 then
        mo.state = S_NULL
	elseif hasEmblem(17) or not hasEmblem(1) and mo.state == S_SOMBADV17 then
        mo.state = S_NULL
	elseif hasEmblem(18) or not hasEmblem(1) and mo.state == S_SOMBADV18 then
        mo.state = S_NULL
	elseif hasEmblem(19) or not hasEmblem(1) and mo.state == S_SOMBADV19 then
        mo.state = S_NULL
    end
end, MT_CUSEMB)

//synchronizes the emblems when loading a map!
addHook("MapLoad", function()
    rawset(_G, "sonk1", hasEmblem(1) and 1 or 0)
    rawset(_G, "sonk2", hasEmblem(2) and 1 or 0)
    rawset(_G, "sonk3", hasEmblem(3) and 1 or 0)
	rawset(_G, "sonk4", hasEmblem(4) and 1 or 0)
	rawset(_G, "sonk5", hasEmblem(5) and 1 or 0)
	rawset(_G, "sonk6", hasEmblem(6) and 1 or 0)
	rawset(_G, "sonk7", hasEmblem(7) and 1 or 0)
	rawset(_G, "sonk8", hasEmblem(8) and 1 or 0)
	rawset(_G, "sonk9", hasEmblem(9) and 1 or 0)
	rawset(_G, "sonk10", hasEmblem(10) and 1 or 0)
	rawset(_G, "sonk11", hasEmblem(11) and 1 or 0)
	rawset(_G, "sonk12", hasEmblem(12) and 1 or 0)
	rawset(_G, "sonk13", hasEmblem(13) and 1 or 0)
	rawset(_G, "sonk14", hasEmblem(14) and 1 or 0)
	rawset(_G, "sonk15", hasEmblem(15) and 1 or 0)
	rawset(_G, "sonk16", hasEmblem(16) and 1 or 0)
	rawset(_G, "sonk17", hasEmblem(17) and 1 or 0)
	rawset(_G, "sonk18", hasEmblem(18) and 1 or 0)
	rawset(_G, "sonk19", hasEmblem(19) and 1 or 0)
end)

//syncs emblem flags if you are in multiplayer
addHook("NetVars", function(net)
//Packs the stuff into a small integer (bits 0–2)
    local packed = 0
    if hasEmblem(1) then packed = packed | (1 << 0) end
    if hasEmblem(2) then packed = packed | (1 << 1) end
    if hasEmblem(3) then packed = packed | (1 << 2) end
	if hasEmblem(4) then packed = packed | (1 << 3) end
    if hasEmblem(5) then packed = packed | (1 << 4) end
    if hasEmblem(6) then packed = packed | (1 << 5) end
	if hasEmblem(7) then packed = packed | (1 << 6) end
    if hasEmblem(8) then packed = packed | (1 << 7) end
    if hasEmblem(9) then packed = packed | (1 << 8) end
	if hasEmblem(10) then packed = packed | (1 << 9) end
	if hasEmblem(11) then packed = packed | (1 << 10) end
	if hasEmblem(12) then packed = packed | (1 << 11) end
	if hasEmblem(13) then packed = packed | (1 << 12) end
	if hasEmblem(14) then packed = packed | (1 << 13) end
	if hasEmblem(15) then packed = packed | (1 << 14) end
	if hasEmblem(16) then packed = packed | (1 << 15) end
	if hasEmblem(17) then packed = packed | (1 << 16) end
	if hasEmblem(18) then packed = packed | (1 << 17) end
	if hasEmblem(19) then packed = packed | (1 << 18) end

    local newPacked = net(packed)

    setEmblem(1, (newPacked & (1 << 0)) ~= 0)
    setEmblem(2, (newPacked & (1 << 1)) ~= 0)
    setEmblem(3, (newPacked & (1 << 2)) ~= 0)
	setEmblem(4, (newPacked & (1 << 3)) ~= 0)
    setEmblem(5, (newPacked & (1 << 4)) ~= 0)
    setEmblem(6, (newPacked & (1 << 5)) ~= 0)
	setEmblem(7, (newPacked & (1 << 6)) ~= 0)
    setEmblem(8, (newPacked & (1 << 7)) ~= 0)
    setEmblem(9, (newPacked & (1 << 8)) ~= 0)
	setEmblem(10, (newPacked & (1 << 9)) ~= 0)
	setEmblem(11, (newPacked & (1 << 10)) ~= 0)
	setEmblem(12, (newPacked & (1 << 11)) ~= 0)
	setEmblem(13, (newPacked & (1 << 12)) ~= 0)
	setEmblem(14, (newPacked & (1 << 13)) ~= 0)
	setEmblem(15, (newPacked & (1 << 14)) ~= 0)
	setEmblem(16, (newPacked & (1 << 15)) ~= 0)
	setEmblem(17, (newPacked & (1 << 16)) ~= 0)
	setEmblem(18, (newPacked & (1 << 17)) ~= 0)
	setEmblem(19, (newPacked & (1 << 18)) ~= 0)
end)

//Draws a sprite in the section where the emeralds are (score thing)
//This one is for no friends :(
local function Display(v)
    if not netgame then
        if sonk1 == 1 then
		    local embmenu = v.cachePatch("EMBMENU")
            v.draw(234, 45, embmenu)
            local sonblem1 = v.getSpritePatch(SPR_SOTN, A)
            v.draw(240, 64, sonblem1)
        end
        if sonk2 == 1 then
            local sonblem2 = v.getSpritePatch(SPR_SOTN, B)
            v.draw(250, 64, sonblem2)
        end
        if sonk3 == 1 then
            local sonblem3 = v.getSpritePatch(SPR_SOTN, C)
            v.draw(260, 64, sonblem3)
        end
		if sonk4 == 1 then
            local sonblem4 = v.getSpritePatch(SPR_SOTN, D)
            v.draw(270, 64, sonblem4)
        end
		if sonk5 == 1 then
            local sonblem5 = v.getSpritePatch(SPR_SOTN, E)
            v.draw(280, 64, sonblem5)
        end
		if sonk6 == 1 then
            local sonblem6 = v.getSpritePatch(SPR_SOTN, F)
            v.draw(290, 64, sonblem6)
        end
		if sonk7 == 1 then
            local sonblem7 = v.getSpritePatch(SPR_SOTN, G)
            v.draw(300, 64, sonblem7)
        end
		if sonk8 == 1 then
            local sonblem8 = v.getSpritePatch(SPR_SOTN, H)
            v.draw(310, 64, sonblem8)
        end
		if sonk9 == 1 then
            local sonblem9 = v.getSpritePatch(SPR_SOTN, I)
            v.draw(320, 64, sonblem9)
        end
		if sonk10 == 1 then
            local sonblem10 = v.getSpritePatch(SPR_SOTN, J)
            v.draw(330, 64, sonblem10)
        end
		if sonk11 == 1 then
            local sonblem11 = v.getSpritePatch(SPR_SOTN, K)
            v.draw(340, 64, sonblem11)
        end
		if sonk12 == 1 then
            local sonblem12 = v.getSpritePatch(SPR_SOTN, L)
            v.draw(350, 64, sonblem12)
        end
		if sonk13 == 1 then
            local sonblem13 = v.getSpritePatch(SPR_SOTN, M)
            v.draw(240, 74, sonblem13)
        end
		if sonk14 == 1 then
            local sonblem14 = v.getSpritePatch(SPR_SOTN, N)
            v.draw(250, 74, sonblem14)
        end
		if sonk15 == 1 then
            local sonblem15 = v.getSpritePatch(SPR_SOTN, O)
            v.draw(260, 74, sonblem15)
        end
		if sonk16 == 1 then
            local sonblem16 = v.getSpritePatch(SPR_SOTN, P)
            v.draw(270, 74, sonblem16)
        end
		if sonk17 == 1 then
            local sonblem17 = v.getSpritePatch(SPR_SOTN, Q)
            v.draw(280, 74, sonblem17)
        end
		if sonk18 == 1 then
            local sonblem18 = v.getSpritePatch(SPR_SOTN, R)
            v.draw(290, 74, sonblem18)
        end
		if sonk19 == 1 then
            local sonblem19 = v.getSpritePatch(SPR_SOTN, S)
            v.draw(300, 74, sonblem19)
        end
    else
	//This one is for friends :)
        if sonk1 == 1 then
            local tonblem1 = v.getSpritePatch(SPR_SOTN, A)
            v.draw(20, -20, tonblem1)
        end
        if sonk2 == 1 then
            local tonblem2 = v.getSpritePatch(SPR_SOTN, B)
            v.draw(30, -20, tonblem2)
        end
        if sonk3 == 1 then
            local tonblem3 = v.getSpritePatch(SPR_SOTN, C)
            v.draw(40, -20, tonblem3)
        end
		if sonk4 == 1 then
            local tonblem4 = v.getSpritePatch(SPR_SOTN, D)
            v.draw(50, -20, tonblem4)
        end
		if sonk5 == 1 then
            local tonblem5 = v.getSpritePatch(SPR_SOTN, E)
            v.draw(60, -20, tonblem5)
        end
		if sonk6 == 1 then
            local tonblem6 = v.getSpritePatch(SPR_SOTN, F)
            v.draw(70, -20, tonblem6)
        end
		if sonk7 == 1 then
            local tonblem7 = v.getSpritePatch(SPR_SOTN, G)
            v.draw(80, -20, tonblem7)
        end
		if sonk8 == 1 then
            local tonblem8 = v.getSpritePatch(SPR_SOTN, H)
            v.draw(90, -20, tonblem8)
        end
		if sonk9 == 1 then
            local tonblem9 = v.getSpritePatch(SPR_SOTN, I)
            v.draw(100, -20, tonblem9)
        end
		if sonk10 == 1 then
            local tonblem10 = v.getSpritePatch(SPR_SOTN, J)
            v.draw(110, -20, tonblem10)
        end
    end
end

hud.add(Display, "scores")

COM_AddCommand("dr_starthunt", function(player, arg)
    setEmblem(1, true)
	S_StartSound(player.mo, sfx_cusemb)
    CONS_Printf(player, "Started the Emblem hunt!")
    return
end, COM_ADMIN)

COM_AddCommand("dr_resetemblems", function(player, arg)
    setEmblem(1, false)
	setEmblem(2, false)
	setEmblem(3, false)
	setEmblem(4, false)
	setEmblem(5, false)
	setEmblem(6, false)
	setEmblem(7, false)
	setEmblem(8, false)
	setEmblem(9, false)
	setEmblem(10, false)
	setEmblem(11, false)
	setEmblem(12, false)
	setEmblem(13, false)
	setEmblem(14, false)
	setEmblem(15, false)
	setEmblem(16, false)
	setEmblem(17, false)
	setEmblem(18, false)
	setEmblem(19, false)
	S_StartSound(player.mo, sfx_adderr)
    CONS_Printf(player, "Removed all Sonikino emblems.")
    return
end, COM_ADMIN)

COM_AddCommand("dr_allemblems", function(player, arg)
    setEmblem(1, true)
	setEmblem(2, true)
	setEmblem(3, true)
	setEmblem(4, true)
	setEmblem(5, true)
	setEmblem(6, true)
	setEmblem(7, true)
	setEmblem(8, true)
	setEmblem(9, true)
	setEmblem(10, true)
	setEmblem(11, true)
	setEmblem(12, true)
	setEmblem(13, true)
	setEmblem(14, true)
	setEmblem(15, true)
	setEmblem(16, true)
	setEmblem(17, true)
	setEmblem(18, true)
	setEmblem(19, true)
	S_StartSound(player.mo, sfx_cusemb)
    CONS_Printf(player, "Obtained all Sonikino emblems!")
    return
end, COM_ADMIN)