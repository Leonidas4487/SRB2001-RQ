/*Sir Thoksalot for "Hyper Sonic" (modified a little bit)
(https://mb.srb2.org/addons/hyper-sonics-directional-dash.2774/)*/

--command to disable the white screenflash
local screenflash = CV_RegisterVar({
    name = "screenflash",
    defaultvalue = "Off",
    flags = CV_SHOWMODIF,
    PossibleValue = CV_OnOff,
})
local colorizedghost = CV_RegisterVar({
    name = "colorizedghost",
    defaultvalue = "On",
    flags = CV_SHOWMODIF,
    PossibleValue = CV_OnOff,
})
local hyperstars = CV_RegisterVar({
    name = "hyperstars",
    defaultvalue = "On",
    flags = CV_SHOWMODIF,
    PossibleValue = CV_OnOff,
})
local hyperskincolor = CV_RegisterVar({
    name = "hyperskincolor",
    flags = CV_SHOWMODIF,
    PossibleValue = {
	    Vanilla = 1,
		Modern = 2},
	defaultvalue = "Modern",
})

--Hyper stars
local function SpawnHyperStars(player)
	local hyperstar = P_SpawnMobjFromMobj(player.mo, 0, 0, 0, MT_SUPERSPARK)
	hyperstar.momx = P_RandomRange(-14, 14) * FRACUNIT + FixedMul(-12, 12, player.mo.scale)
	hyperstar.momy = P_RandomRange(-14, 14) * FRACUNIT + FixedMul(-12, 12, player.mo.scale)
	hyperstar.momz = P_RandomRange(-1, 9) * FRACUNIT + FixedMul(-12, 12, player.mo.scale)
	hyperstar.fuse = 7
	hyperstar.scale = player.mo.scale * 20/22
	hyperstar.source = player.mo
end

--the actual hyper form stuff
addHook("PlayerThink",  function(player)
	local pmo = player.mo
	if not (pmo and pmo.valid) return end
	if (player == nil) return end

	if player.hyper == nil
		local hyper = {
		isunlocked = false,
		transformed = false
		}
		player.hyperscript = true
		if pmo
			player.hyper = hyper
		else
			player.hyper = nil
		end
	end

	--if you're capable of going hyper
	if /*(skins[pmo.skin].flags & SF_SUPER) and pmo.skin == "sonic" and*/ player.hyper.isunlocked == true
		--let's fucking go
		if not player.powers[pw_super]
		    player.hyper.transformed = false
		else
		    player.hyper.transformed = true
		end
		--If you're hyper...
		if (player.hyper.transformed == true)
		     if pmo.state == S_PLAY_SUPER_TRANS1
	    		 if not S_SoundPlaying(player.mo, sfx_hypefx) then
        			S_StartSound(player.mo, sfx_hypefx)
					P_StartQuake(70*FRACUNIT, 13)
					P_NukeEnemies(pmo, pmo, 1214*FRACUNIT)
					P_NukeEnemies(pmo, pmo, 1758*FRACUNIT)
					P_NukeEnemies(pmo, pmo, 1982*FRACUNIT)
					P_NukeEnemies(pmo, pmo, 2461*FRACUNIT)
					P_FlashPal(player, PAL_WHITE, 3)
				end
			end
		    if hyperstars.value == 1
    		    SpawnHyperStars(player)
			end
			--Set the correct skincolor for Hyper stuff.
			if (pmo.color == SKINCOLOR_SUPERGOLD1 or pmo.color == SKINCOLOR_SUPERGOLD2 or pmo.color == SKINCOLOR_SUPERGOLD3 or pmo.color == SKINCOLOR_SUPERGOLD4 or pmo.color == SKINCOLOR_SUPERGOLD5 or
			pmo.color == SKINCOLOR_SUPERRED1 or pmo.color == SKINCOLOR_SUPERRED2 or pmo.color == SKINCOLOR_SUPERRED3 or pmo.color == SKINCOLOR_SUPERRED4 or pmo.color == SKINCOLOR_SUPERRED5 or 
			pmo.color == SKINCOLOR_SUPERORANGE1 or pmo.color == SKINCOLOR_SUPERORANGE2 or pmo.color == SKINCOLOR_SUPERORANGE3 or pmo.color == SKINCOLOR_SUPERORANGE4 or pmo.color == SKINCOLOR_SUPERORANGE5 or 
			pmo.color == SKINCOLOR_SUPERSILVER1 or pmo.color == SKINCOLOR_SUPERSILVER2 or pmo.color == SKINCOLOR_SUPERSILVER3 or pmo.color == SKINCOLOR_SUPERSILVER4 or pmo.color == SKINCOLOR_SUPERSILVER5 or 
			pmo.color == SKINCOLOR_SUPERPERIDOT1 or pmo.color == SKINCOLOR_SUPERPERIDOT2 or pmo.color == SKINCOLOR_SUPERPERIDOT3 or pmo.color == SKINCOLOR_SUPERPERIDOT4 or pmo.color == SKINCOLOR_SUPERPERIDOT5 or 
			pmo.color == SKINCOLOR_SUPERSKY1 or pmo.color == SKINCOLOR_SUPERSKY2 or pmo.color == SKINCOLOR_SUPERSKY3 or pmo.color == SKINCOLOR_SUPERSKY4 or pmo.color == SKINCOLOR_SUPERSKY5 or 
			pmo.color == SKINCOLOR_SUPERPURPLE1 or pmo.color == SKINCOLOR_SUPERPURPLE2 or pmo.color == SKINCOLOR_SUPERPURPLE3 or pmo.color == SKINCOLOR_SUPERPURPLE4 or pmo.color == SKINCOLOR_SUPERPURPLE5 or 
			pmo.color == SKINCOLOR_SUPERRUST1 or pmo.color == SKINCOLOR_SUPERRUST2 or pmo.color == SKINCOLOR_SUPERRUST3 or pmo.color == SKINCOLOR_SUPERRUST4 or pmo.color == SKINCOLOR_SUPERRUST5
			or pmo.color == SKINCOLOR_SUPERTAN1 or SKINCOLOR_SUPERTAN2 or pmo.color == SKINCOLOR_SUPERTAN3 or pmo.color == SKINCOLOR_SUPERTAN4 or pmo.color == SKINCOLOR_SUPERTAN5 or p.scolor == "default")
		    	if hyperskincolor.value == 1
		     	    pmo.color = (SKINCOLOR_SUPERSILVER1 + 5*((leveltime >> 1) % 7))
		    	elseif hyperskincolor.value == 2	
		     	    pmo.color = SKINCOLOR_HYPERFORM1
				end
			end
			--Adjust stats for hyper forms
			/*if not (player.charflags & SF_NOSUPERJUMPBOOST)
	    		player.jumpfactor = skins[pmo.skin].jumpfactor * 4 / 3
			end*/
			player.actionspd = skins[pmo.skin].actionspd * 6 / 4
			player.thrustfactor = skins[pmo.skin].thrustfactor * 4 / 3
			--afterimages
			if (player.speed > 2*FRACUNIT or pmo.momz > 2*FRACUNIT or pmo.momz < -1*FRACUNIT)
				local afterimage = P_SpawnGhostMobj(pmo)
				afterimage.rollangle = pmo.rollangle
				afterimage.fuse = 5
				if colorizedghost.value == 1
	    			afterimage.colorized = true
		    		afterimage.color = pmo.color
				else
				    afterimage.colorized = false
				end
			end
		elseif (player.hyper.transformed == false or player.hyper.isunlocked == false or darkemerald < 1)
			/*if not (player.charflags & SF_NOSUPERJUMPBOOST)
	    		player.jumpfactor = skins[pmo.skin].jumpfactor * 4 / 3
			end*/
			player.actionspd = skins[pmo.skin].actionspd
			player.thrustfactor = skins[pmo.skin].thrustfactor
		end
	end
end)

--local variables
local vertical_dash_dist = 20*FRACUNIT

--The quakes should only appear for the player creating them
local function StartQuakes(player)
	if (player == consoleplayer)
         P_StartQuake(7*FRACUNIT, 4)
	end
end

--Handles dashing in 3D
local function Do3DHyperDash(player)
    local pmo = player.mo
    --my god is this code a mess
    local dash_forward = (player.cmd.forwardmove) and not (((player.pflags & PF_USEDOWN) and (player.cmd.forwardmove) or ((player.cmd.forwardmove) and (player.cmd.sidemove))) and not (pmo.state == S_PLAY_FLOAT or pmo.state == S_PLAY_FLOAT_RUN))
    local dash_diagonal = ((player.cmd.forwardmove) and (player.cmd.sidemove)) and not ((player.pflags & PF_USEDOWN) and not (pmo.state == S_PLAY_FLOAT or pmo.state == S_PLAY_FLOAT_RUN))
	local dash_sideward = (player.cmd.sidemove) and not ((player.cmd.forwardmove) and (player.cmd.sidemove))  and not ((player.pflags & PF_USEDOWN) and not (pmo.state == S_PLAY_FLOAT or pmo.state == S_PLAY_FLOAT_RUN))
	local dash_upward = P_GetPlayerControlDirection(player) == 0 and not ((player.pflags & PF_USEDOWN) and not (pmo.state == S_PLAY_FLOAT or pmo.state == S_PLAY_FLOAT_RUN))
	local dash_downward = (player.pflags & PF_USEDOWN) and pmo.state != S_PLAY_FLOAT and pmo.state != S_PLAY_FLOAT_RUN
    if dash_forward
    	P_InstaThrust(pmo, pmo.angle, player.actionspd)
    elseif dash_diagonal
    	P_InstaThrust(pmo, player.drawangle, player.actionspd)
	elseif dash_sideward
    	P_InstaThrust(pmo, player.drawangle, player.actionspd)
    elseif dash_upward
    	P_SetObjectMomZ(pmo, vertical_dash_dist, false)
	elseif dash_downward
        P_SetObjectMomZ(pmo, -vertical_dash_dist, false)
	end
end
--Handles dashing in 2D
--the exact same way it worked in Sonic 3 & Knuckles
local function Do2DHyperDash(player)
    local pmo = player.mo
    local dash_forward = (player.cmd.forwardmove)
	local dash_upward = (player.cmd.forwardmove > 0) and not (player.cmd.forwardmove < 0)
	local dash_downward = (player.cmd.forwardmove < 0) and not (player.cmd.forwardmove > 0)
    if not dash_forward
		P_InstaThrust(pmo, pmo.angle, player.actionspd)
	elseif dash_upward
        P_SetObjectMomZ(pmo, vertical_dash_dist, false)
	elseif dash_downward
        P_SetObjectMomZ(pmo, -vertical_dash_dist, false)
	end
end
--now we can dash, yay :DDDDDD
addHook("AbilitySpecial", function(player)
    local pmo = player.mo
	if pmo.skin != "sonic" then
	    return
	end
	if (player.pflags & PF_THOKKED) then
    	return
	end
	
	if (player.hyper.transformed == true) 
	    P_SpawnThokMobj(player)
        S_StartSound(pmo, sfx_s3kb6) 
        P_NukeEnemies(pmo, pmo, 1214*FRACUNIT)
--        StartQuakes(player)
        player.pflags = $ | PF_THOKKED
    	if screenflash.value == 1
        	P_FlashPal(player, PAL_WHITE, 3)
    	end
    	if not (pmo.flags2 & MF2_TWOD)
    	    Do3DHyperDash(player) --3D Hyper Dash
		else
		    Do2DHyperDash(player) --2D Hyper Dash
		end
	elseif (player.hyper.transformed == false) then
	    player.charability = skins[pmo.skin].ability
	end 
end)