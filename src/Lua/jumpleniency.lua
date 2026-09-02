local function PreThinkJump(player)
	P_DoJump(player, true);

	-- Prevent using abilities immediately, by removing jump inputs.
	player.cmd.buttons = $1 & ~BT_JUMP;
	player.pflags = $1 | (PF_JUMPDOWN|PF_JUMPSTASIS);
end

local function RestoreAbility(player)
	player.secondjump = 0;
	player.pflags = $1 & ~PF_THOKKED;
end

local function RemoveAbility(player)
	player.secondjump = UINT8_MAX;
	player.pflags = $1 | PF_THOKKED;
end

local function RecoveryThink(player, mo, pressedJump, latency)
	mo.coyoteTime = 0; -- Reset coyote time
	mo.recoveryWait = $1 + 1; -- Increment recovery wait time.

	-- The recovery jump from SA2, where you can jump out of your pain state.
	if (pressedJump == true)
		local painThrust = 69*FRACUNIT/10;
		local baseGravity = max(1, abs(P_GetMobjGravity(mo)));
		local painTime = FixedFloor(FixedDiv(painThrust, baseGravity)) >> FRACBITS;

		local baseRecoveryWait = (painTime * 2); -- Double the length of your pain state, - your latency.

		if (mo.recoveryWait > baseRecoveryWait - latency)
			PreThinkJump(player);

			--[[
			RemoveAbility(player);

			-- Reset momentum so you can move a bit.
			player.mo.momx = 0;
			player.mo.momy = 0;
			--]]

			RestoreAbility(player);
		end
	end
end

local function CoyoteThink(player, mo, pressedJump, latency)
	-- "Coyote time" is how much time you have after leaving the ground where you can jump off.
	-- Many modern platformers do this, especially 3D.
	-- Prevents lots of "the jump didn't jump".
	local baseCoyoteTime = TICRATE/4; -- 0.25 seconds, + your latency.

	-- Check if you're in a state where you would normally be allowed to jump.
	local canJump = false;
	if ((P_IsObjectOnGround(mo) == true) or (P_InQuicksand(mo) == true))
	and (player.powers[pw_carry] == CR_NONE)
		canJump = true;
	end

	if (player.pflags & PF_JUMPED) or (player.powers[pw_justsprung])
		-- We jumped. We should not have coyote time.
		mo.coyoteTime = 0;
	elseif (canJump == true)
		-- Set the coyote time while in a state where you can jump.
		mo.coyoteTime = baseCoyoteTime + latency;
	else
		if (pressedJump == true) and (mo.coyoteTime > 0)
			-- Pressed jump in a state where you can't jump,
			-- but you have coyote time. So we'll give you a jump anyway!
			PreThinkJump(player);
			RestoreAbility(player);
			mo.coyoteTime = 0;
		end

		if (mo.coyoteTime > 0)
			-- Reduce coyote timer while in a state where you can't jump.
			mo.coyoteTime = $1 - 1;
		end
	end
end

local function JumpLeniencyThink(player)
	if not (player.mo and player.mo.valid)
		return;
	end
	local mo = player.mo;

	if (player.playerstate != PST_LIVE)
		return;
	end

	local latency = player.cmd.latency;

	-- Init variables
	if (mo.coyoteTime == nil)
		mo.coyoteTime = 0;
	end

	if (mo.recoveryWait == nil)
		mo.recoveryWait = 0;
	end

	if (player.exiting)
	or (player.pflags & PF_JUMPSTASIS)
	or ((player.powers[pw_nocontrol] > 0) and not (player.powers[pw_nocontrol] & (1<<15)))
		-- Can't control anyway.
		return;
	end

	local pressedJump = false;
	if (player.cmd.buttons & BT_JUMP) and not (player.pflags & PF_JUMPDOWN)
		pressedJump = true;
	end

	if (P_PlayerInPain(player) == true)
		RecoveryThink(player, mo, pressedJump, latency);
		return;
	else
		-- Reset recovery wait time outside of pain state.
		mo.recoveryWait = 0;
	end

	CoyoteThink(player, mo, pressedJump, latency);
end

addHook("PreThinkFrame", function()
	if (mapheaderinfo[gamemap].jumpleniency)
		-- Don't run more than once on maps that have their own (SUGOI)
		return;
	end

	for player in players.iterate do
		JumpLeniencyThink(player);
	end
end);
