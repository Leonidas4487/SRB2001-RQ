freeslot("MT_SONIKINO", 
"SPR_SONK", "S_SONKIDLE1", "S_SONKIDLE2", "S_SONKIDLE3",
"SPR_SFZ2", "S_SONKSFZ21", "S_SONKSFZ22", "S_SONKSFZ23",
"SPR_FHZ1", "S_SONKFHZ11", "S_SONKFHZ12", "S_SONKFHZ13",
"SPR_FHZ2", "S_SONKFHZ21", "S_SONKFHZ22", "S_SONKFHZ23",
"SPR_DCZ1", "S_SONKDCZ11", "S_SONKDCZ12", "S_SONKDCZ13",
"SPR_DCZ2", "S_SONKDCZ21", "S_SONKDCZ22", "S_SONKDCZ23",
"SPR_TTZ1", "S_SONKTTZ11", "S_SONKTTZ12", "S_SONKTTZ13",
"SPR_TTZ2", "S_SONKTTZ21", "S_SONKTTZ22", "S_SONKTTZ23",
"SPR_CFZ1", "S_SONKCCFZ11", "S_SONKCCFZ12", "S_SONKCCFZ13",
"SPR_CFZ2", "S_SONKCCFZ21", "S_SONKCCFZ22", "S_SONKCCFZ23",
"SPR_BVZ1", "S_SONKBVZ11", "S_SONKBVZ12", "S_SONKBVZ13",
"SPR_BVZ2", "S_SONKBVZ21", "S_SONKBVZ22", "S_SONKBVZ23",
"SPR_FSZ1", "S_SONKFSZ11", "S_SONKFSZ12", "S_SONKFSZ13",
"SPR_FSZ2", "S_SONKFSZ21", "S_SONKFSZ22", "S_SONKFSZ23",
"SPR_ODZ1", "S_SONKODZ11", "S_SONKODZ12", "S_SONKODZ13",
"SPR_ODZ2", "S_SONKODZ21", "S_SONKODZ22", "S_SONKODZ23",
"SPR_FGZ1", "S_SONKFGZ11", "S_SONKFGZ12", "S_SONKFGZ13",
"SPR_FGZ2", "S_SONKFGZ21", "S_SONKFGZ22", "S_SONKFGZ23",
"SPR_FGZ4", "S_SONKFGZ41", "S_SONKFGZ42", "S_SONKFGZ43")

//Sunset Flowers Zone Act 1
states[S_SONKIDLE1] = { SPR_SONK, A, 4, nil, 0, 0, S_SONKIDLE2 }
states[S_SONKIDLE2] = { SPR_SONK, B, 4, nil, 0, 0, S_SONKIDLE3 }
states[S_SONKIDLE3] = { SPR_SONK, C, 4, nil, 0, 0, S_SONKIDLE1 }

//Sunset Flowers Zone Act 2
states[S_SONKSFZ21] = { SPR_SFZ2, A, 4, nil, 0, 0, S_SONKSFZ22 }
states[S_SONKSFZ22] = { SPR_SFZ2, B, 4, nil, 0, 0, S_SONKSFZ23 }
states[S_SONKSFZ23] = { SPR_SFZ2, C, 4, nil, 0, 0, S_SONKSFZ21 }

//Forgotten Hardware Zone Act 1
states[S_SONKFHZ11] = { SPR_FHZ1, A, 4, nil, 0, 0, S_SONKFHZ12 }
states[S_SONKFHZ12] = { SPR_FHZ1, B, 4, nil, 0, 0, S_SONKFHZ13 }
states[S_SONKFHZ13] = { SPR_FHZ1, C, 4, nil, 0, 0, S_SONKFHZ11 }

//Forgotten Hardware Zone Act 2
states[S_SONKFHZ21] = { SPR_FHZ2, A, 4, nil, 0, 0, S_SONKFHZ22 }
states[S_SONKFHZ22] = { SPR_FHZ2, B, 4, nil, 0, 0, S_SONKFHZ23 }
states[S_SONKFHZ23] = { SPR_FHZ2, C, 4, nil, 0, 0, S_SONKFHZ21 }

//Drenched Caverns Zone Act 1
states[S_SONKDCZ11] = { SPR_DCZ1, A, 4, nil, 0, 0, S_SONKDCZ12 }
states[S_SONKDCZ12] = { SPR_DCZ1, B, 4, nil, 0, 0, S_SONKDCZ13 }
states[S_SONKDCZ13] = { SPR_DCZ1, C, 4, nil, 0, 0, S_SONKDCZ11 }

//Drenched Caverns Zone Act 2
states[S_SONKDCZ21] = { SPR_DCZ2, A, 4, nil, 0, 0, S_SONKDCZ22 }
states[S_SONKDCZ22] = { SPR_DCZ2, B, 4, nil, 0, 0, S_SONKDCZ23 }
states[S_SONKDCZ23] = { SPR_DCZ2, C, 4, nil, 0, 0, S_SONKDCZ21 }

//Tubular Tunnels Zone Act 1
states[S_SONKTTZ11] = { SPR_TTZ1, A, 4, nil, 0, 0, S_SONKTTZ12 }
states[S_SONKTTZ12] = { SPR_TTZ1, B, 4, nil, 0, 0, S_SONKTTZ13 }
states[S_SONKTTZ13] = { SPR_TTZ1, C, 4, nil, 0, 0, S_SONKTTZ11 }

//Tubular Tunnels Zone Act 2
states[S_SONKTTZ21] = { SPR_TTZ2, A, 4, nil, 0, 0, S_SONKTTZ22 }
states[S_SONKTTZ22] = { SPR_TTZ2, B, 4, nil, 0, 0, S_SONKTTZ23 }
states[S_SONKTTZ23] = { SPR_TTZ2, C, 4, nil, 0, 0, S_SONKTTZ21 }

//Cloudy Cliff-Face Zone Act 1
states[S_SONKCCFZ11] = { SPR_CFZ1, A, 4, nil, 0, 0, S_SONKCCFZ12 }
states[S_SONKCCFZ12] = { SPR_CFZ1, B, 4, nil, 0, 0, S_SONKCCFZ13 }
states[S_SONKCCFZ13] = { SPR_CFZ1, C, 4, nil, 0, 0, S_SONKCCFZ11 }

//Cloudy Cliff-Face Zone Act 2
states[S_SONKCCFZ21] = { SPR_CFZ2, A, 4, nil, 0, 0, S_SONKCCFZ22 }
states[S_SONKCCFZ22] = { SPR_CFZ2, B, 4, nil, 0, 0, S_SONKCCFZ23 }
states[S_SONKCCFZ23] = { SPR_CFZ2, C, 4, nil, 0, 0, S_SONKCCFZ21 }

//Blazing Vermilion Zone Act 1
states[S_SONKBVZ11] = { SPR_BVZ1, A, 4, nil, 0, 0, S_SONKBVZ12 }
states[S_SONKBVZ12] = { SPR_BVZ1, B, 4, nil, 0, 0, S_SONKBVZ13 }
states[S_SONKBVZ13] = { SPR_BVZ1, C, 4, nil, 0, 0, S_SONKBVZ11 }

//Blazing Vermilion Zone Act 2
states[S_SONKBVZ21] = { SPR_BVZ2, A, 4, nil, 0, 0, S_SONKBVZ22 }
states[S_SONKBVZ22] = { SPR_BVZ2, B, 4, nil, 0, 0, S_SONKBVZ23 }
states[S_SONKBVZ23] = { SPR_BVZ2, C, 4, nil, 0, 0, S_SONKBVZ21 }

//Forsaken Square Zone Act 1
states[S_SONKFSZ11] = { SPR_FSZ1, A, 4, nil, 0, 0, S_SONKFSZ12 }
states[S_SONKFSZ12] = { SPR_FSZ1, B, 4, nil, 0, 0, S_SONKFSZ13 }
states[S_SONKFSZ13] = { SPR_FSZ1, C, 4, nil, 0, 0, S_SONKFSZ11 }

//Forsaken Square Zone Act 2
states[S_SONKFSZ21] = { SPR_FSZ2, A, 4, nil, 0, 0, S_SONKFSZ22 }
states[S_SONKFSZ22] = { SPR_FSZ2, B, 4, nil, 0, 0, S_SONKFSZ23 }
states[S_SONKFSZ23] = { SPR_FSZ2, C, 4, nil, 0, 0, S_SONKFSZ21 }

//'Osphere Doomship Zone Act 1
states[S_SONKODZ11] = { SPR_ODZ1, A, 4, nil, 0, 0, S_SONKODZ12 }
states[S_SONKODZ12] = { SPR_ODZ1, B, 4, nil, 0, 0, S_SONKODZ13 }
states[S_SONKODZ13] = { SPR_ODZ1, C, 4, nil, 0, 0, S_SONKODZ11 }

//'Osphere Doomship Zone Act 2
states[S_SONKODZ21] = { SPR_ODZ2, A, 4, nil, 0, 0, S_SONKODZ22 }
states[S_SONKODZ22] = { SPR_ODZ2, B, 4, nil, 0, 0, S_SONKODZ23 }
states[S_SONKODZ23] = { SPR_ODZ2, C, 4, nil, 0, 0, S_SONKODZ21 }

//Frantic Geode Zone Act 1
states[S_SONKFGZ11] = { SPR_FGZ1, A, 4, nil, 0, 0, S_SONKFGZ12 }
states[S_SONKFGZ12] = { SPR_FGZ1, B, 4, nil, 0, 0, S_SONKFGZ13 }
states[S_SONKFGZ13] = { SPR_FGZ1, C, 4, nil, 0, 0, S_SONKFGZ11 }

//Frantic Geode Zone Act 2
states[S_SONKFGZ21] = { SPR_FGZ2, A, 4, nil, 0, 0, S_SONKFGZ22 }
states[S_SONKFGZ22] = { SPR_FGZ2, B, 4, nil, 0, 0, S_SONKFGZ23 }
states[S_SONKFGZ23] = { SPR_FGZ2, C, 4, nil, 0, 0, S_SONKFGZ21 }

//Frantic Geode Zone Act 4 or Aftermath
states[S_SONKFGZ41] = { SPR_FGZ4, A, 4, nil, 0, 0, S_SONKFGZ42 }
states[S_SONKFGZ42] = { SPR_FGZ4, B, 4, nil, 0, 0, S_SONKFGZ43 }
states[S_SONKFGZ43] = { SPR_FGZ4, C, 4, nil, 0, 0, S_SONKFGZ41 }

addHook("MapThingSpawn", function(mo, mt)
    if not (mo and mo.valid and mt and mt.args) then
//for safety reasons idk.
        mo.state = S_SONKIDLE1
        return
    end
//idk why this is needed but ok, the game hates me!
    local arg0 = tostring(mt.args[0]) 

    if arg0 == "1" then
        mo.state = S_SONKSFZ21
    elseif arg0 == "2" then
        mo.state = S_SONKFHZ11
	elseif arg0 == "3" then
        mo.state = S_SONKFHZ21
	elseif arg0 == "4" then
        mo.state = S_SONKDCZ11
	elseif arg0 == "5" then
        mo.state = S_SONKDCZ21
	elseif arg0 == "6" then
        mo.state = S_SONKTTZ11
	elseif arg0 == "7" then
        mo.state = S_SONKTTZ21
	elseif arg0 == "8" then
        mo.state = S_SONKCCFZ11
	elseif arg0 == "9" then
        mo.state = S_SONKCCFZ21
	elseif arg0 == "10" then
        mo.state = S_SONKBVZ11
	elseif arg0 == "11" then
        mo.state = S_SONKBVZ21
	elseif arg0 == "12" then
        mo.state = S_SONKFSZ11
	elseif arg0 == "13" then
        mo.state = S_SONKFSZ21
	elseif arg0 == "14" then
        mo.state = S_SONKODZ11
	elseif arg0 == "15" then
        mo.state = S_SONKODZ21
	elseif arg0 == "16" then
        mo.state = S_SONKFGZ11
	elseif arg0 == "17" then
        mo.state = S_SONKFGZ21
	elseif arg0 == "18" then
        mo.state = S_SONKFGZ41
    else
//if not any of these then go to the normal one!
        mo.state = S_SONKIDLE1
    end
end, MT_SONIKINO)