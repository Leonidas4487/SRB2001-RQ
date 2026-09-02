freeslot("MT_DARKEMER","S_DARKEMER1", "SPR_NDKE", 
"SPR_TDKE", "SFX_DARKEM", "SFX_HYPEFX")

//The dark emerald object
mobjinfo[MT_DARKEMER] = {
	--$Category Mod Stuff
	--$Name Dark Emerald
	--$Sprite NDKEA0
	--$NotAngled
	doomednum = 3560,
    spawnstate = S_DARKEMER1,
    spawnhealth = 1000,
    deadstate = S_SPRK1,
    xdeathstate = S_NULL,
	deathsound = sfx_darkem,
    reactiontime = 0,
    painchance = 0,
    speed = 0,
	radius = 16*FU,
	height = 24*FU,
	mass = 16*FU,
	flags = MF_SPECIAL|MF_NOGRAVITY|MF_NOCLIPHEIGHT,
}

//states stuff
states[S_DARKEMER1] = { SPR_NDKE, FF_FULLBRIGHT|A, -1, nil, 0, 0, S_NULL }

//sfx for captions and stuff
sfxinfo[sfx_darkem] = {
        singular = false,
        priority = 64,
        flags = SF_X4AWAYSOUND|SF_X8AWAYSOUND
}
sfxinfo[sfx_darkem].caption = "Got... \x8f"+"Emerald\x80?"

sfxinfo[sfx_hypefx] = {
        singular = false,
        priority = 64,
        flags = SF_X4AWAYSOUND|SF_X8AWAYSOUND
}
sfxinfo[sfx_hypefx].caption = "Hyper Transformation"

//Reserving the luabank once for the whole mod globally!
local luabanks = reserveLuabanks()
rawset(_G, "luabanks", luabanks)

//Slot 0 bit 7 for the dark emerald
local DARK_EMERALD_SLOT = 0
local DARK_EMERALD_BIT = 7

local function hasDarkEmerald()
    return (luabanks[DARK_EMERALD_SLOT] & (1 << DARK_EMERALD_BIT)) ~= 0
end

local function setDarkEmerald(value)
    local mask = 1 << DARK_EMERALD_BIT
    if value then
        //set the bit
        luabanks[DARK_EMERALD_SLOT] = luabanks[DARK_EMERALD_SLOT] | mask
    else
        //clear the bit
        luabanks[DARK_EMERALD_SLOT] = luabanks[DARK_EMERALD_SLOT] & ~mask
    end
    //Updating the rawset thing stuff
    rawset(_G, "darkemerald", hasDarkEmerald() and 1 or 0)
end

rawset(_G, "darkemerald", hasDarkEmerald() and 1 or 0)

//if you have it then hyper, else no hyper
addHook("ThinkFrame", do
    for player in players.iterate do
        local pmo = player.mo
        if darkemerald == 1 then
            if player.hyper.isunlocked == false then
                player.hyper.isunlocked = true
            end
        end
        if darkemerald < 1 then
            if player.hyper.isunlocked == true then
                player.hyper.isunlocked = false
            end
            if player.hyper.transformed == true then
                player.hyper.transformed = false
            end
        end
    end
end)

//TouchSpecial for getting you the "actual" emerald when you touch it!
addHook("TouchSpecial", function(darkemer, p)
    if p.player and p.valid and p.health then
        if not All7Emeralds(emeralds) then
            setDarkEmerald(true)
            CONS_Printf(p.player, "Get all the emeralds to use \x8f"+"this\x80...")
        elseif All7Emeralds(emeralds) and not hasDarkEmerald() then
            setDarkEmerald(true)
            CONS_Printf(p.player, "Get 50 rings and enjoy your \x8f"+"reward\x80.")
        elseif All7Emeralds(emeralds) and hasDarkEmerald() then
            p.player.rings = $ + 50 
            CONS_Printf(p.player, "You already have \x8f"+"this\x80, take these rings.")
        end
    end
end, MT_DARKEMER)

addHook("NetVars", function(net)
    local newDark = net(hasDarkEmerald() and 1 or 0)
    setDarkEmerald(newDark ~= 0)
end)

//draws the emerald if you have the value depending if you are in multiplayer or not
local function Display(v)
    if not netgame then
        //dark emerald for singleplayer
        if darkemerald > 0 then
            local darkemerald1 = v.cachePatch("CHAOS9") //graphic
            v.draw(200, 67, darkemerald1)
	    end
	else //tiny dark emerald for multiplayer
        if darkemerald > 0 then
            local tdarkemerald1 = v.getSpritePatch(SPR_TDKE, A) //sprite
            v.draw(90, 9, tdarkemerald1)
     	end
	end
end
	
hud.add(Display, "scores")

//moved from "hyperform4.lua" because the "setDarkEmerald" doesn't exist there.
COM_AddCommand("dr_getdark", function(player, arg)
    setDarkEmerald(true)
	S_StartSound(player.mo, sfx_darkem)
    CONS_Printf(player, "You now have the \x8f"+"Dark Emerald\x80.")
    return
end, COM_ADMIN)

COM_AddCommand("dr_nonedark", function(player, arg)
    setDarkEmerald(false)
	S_StartSound(player.mo, sfx_adderr)
    CONS_Printf(player, "Your \x8f"+"Dark Emerald\x80 has been removed.")
    return
end, COM_ADMIN)

//just to be really sure
addHook("MapLoad", function()
    rawset(_G, "darkemerald", hasDarkEmerald() and 1 or 0)
end)

addHook("MapThingSpawn", function(mo, mt)
    if not (mo and mo.valid) then
        return
    end
	
    if darkemerald == 1 or hasDarkEmerald() and mo.state == S_DARKEMER1 then
        mo.state = S_NULL
    end
end, MT_DARKEMER)