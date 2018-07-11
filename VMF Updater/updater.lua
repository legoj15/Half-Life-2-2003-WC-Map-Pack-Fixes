
function ReplaceObjekt(pChunk, OldValue, NewValue, ObjektName)

	local objekt = GetValueFromKey( pChunk, ObjektName )

	if objekt == OldValue then
		SetValueToKey( pChunk, ObjektName, NewValue )
	end

end


function FixedBlackColor(pChunk)

	ReplaceObjekt(pChunk, "0 0 0", "255 255 255", "rendercolor")
end

function ReplaceModel(pChunk, OldValue, NewValue)

	ReplaceObjekt(pChunk, OldValue, NewValue, "model")
end

function RenameEntity(pChunk, OldValue, NewValue)

	ReplaceObjekt(pChunk, OldValue, NewValue, "classname")

end

function ReplaceSky(pChunk, OldValue, NewValue)

	ReplaceObjekt(pChunk, OldValue, NewValue, "skyname")

end

function ReplaceTexture(pChunk, OldValue, NewValue)

	ReplaceObjekt(pChunk, OldValue, NewValue, "material")

end

function UpdateMoveDirToEnt( pChunk, EntName, NewValue )

	local objekt = GetValueFromKey( pChunk, "classname" )
	
	if objekt == EntName then
		RenameKey( pChunk, "angles", NewValue )
	end

end

function UpdateMoveDir(pChunk)

	UpdateMoveDirToEnt( pChunk, "env_blood", "spraydir" )
	UpdateMoveDirToEnt( pChunk, "func_button", "movedir" )
	UpdateMoveDirToEnt( pChunk, "func_door", "movedir" )
	UpdateMoveDirToEnt( pChunk, "func_door_weldable", "movedir" )
	UpdateMoveDirToEnt( pChunk, "func_movelinear", "movedir" )
	UpdateMoveDirToEnt( pChunk, "momentary_door", "movedir" )
	UpdateMoveDirToEnt( pChunk, "func_conveyor", "movedir" )
	UpdateMoveDirToEnt( pChunk, "trigger_push", "pushdir" )
	UpdateMoveDirToEnt( pChunk, "func_water", "movedir" )

end



function UpdateOutputForEnts(pChunk, OutputType)

	local target = GetValueFromKey( pChunk, "target" )
	local delay = GetValueFromKey( pChunk, "delay" )
	
	if delay == "not found" then
	
		delay = "0"
	
	end 
	
	if target ~= "not found" then
	
	NewChunk = GetOrCreateSubChunk( pChunk, "connections" )
	
	outputstring = string.format("%s,Toggle,,%f,-1", target, tonumber(delay) )
	
	AddKeyValue( NewChunk, OutputType, outputstring )
	
	end


end

function FixedLogicEntity(pChunk)

	local entitytype = GetValueFromKey( pChunk, "classname" )
	
	if entitytype == "trigger_look" then
	
		UpdateOutputForEnts( pChunk, "OnTrigger" )
	
	end
	
	if entitytype == "trigger_once" then
	
		UpdateOutputForEnts( pChunk, "OnTrigger" )
	
	end	
		
	if entitytype == "trigger_multiple" then
	
		UpdateOutputForEnts( pChunk, "OnTrigger" )
	
	end	
	
	if entitytype == "trigger_relay" then
	
		UpdateOutputForEnts( pChunk, "OnTrigger" )
		RenameEntity( pChunk, "trigger_relay", "logic_relay" )
	end
	
	if entitytype == "trigger_auto" then
	
		UpdateOutputForEnts( pChunk, "OnMapSpawn" )
		RenameEntity( pChunk, "trigger_auto", "logic_auto" )
	
	end
	
	if entitytype == "multi_manager" then
	
		UpdateOutputForEnts( pChunk, "OnTrigger" )

		countkeys = GetCountKeys(pChunk)
		
		for variable = 0, countkeys, 1 do

			CurKey = GetKeyBiId( pChunk, variable )
			
			if CurKey ~= "not found" and CurKey ~= "id" and CurKey ~= "classname" and CurKey ~= "targetname" and CurKey ~= "spawnflags" and CurKey ~= "delay" and CurKey ~= "wait" and CurKey ~= "renderfx" and CurKey ~= "rendermode" and CurKey ~= "renderamt" and CurKey ~= "rendercolor" and CurKey ~= "speed" and CurKey ~= "lip" and CurKey ~= "dmg" and CurKey ~= "health" and CurKey ~= "locked_sentence" and CurKey ~= "unlocked_sentence" and CurKey ~= "origin" then
			
			NewChunk = GetOrCreateSubChunk( pChunk, "connections" )
	
			outputstring = string.format("%s,Toggle,,%f,-1", CurKey, tonumber( GetValueFromKey( pChunk, CurKey ) ) )
	
			AddKeyValue( NewChunk, "OnTrigger", outputstring )
			
			end
		end

		RenameEntity( pChunk, "multi_manager", "logic_relay" )
	
	end	

	-- VXP
	if entitytype == "env_sound" then
		-- VXP: DSP effects for env_soundscape
		local env_sound = {
			["0"] = "Normal (off)",
			["1"] = "Generic",
			["2"] = "Metal Small",
			["3"] = "Metal Medium",
			["4"] = "Metal Large",
			["5"] = "Tunnel Small",
			["6"] = "Tunnel Medium",
			["7"] = "Tunnel Large",
			["8"] = "Chamber Small",
			["9"] = "Chamber Medium",
			["10"] = "Chamber Large",
			["11"] = "Bright Small",
			["12"] = "Bright Medium",
			["13"] = "Bright Large",
			["14"] = "Water 1",
			["15"] = "Water 2",
			["16"] = "Water 3",
			["17"] = "Concrete Small",
			["18"] = "Concrete Medium",
			["19"] = "Concrete Large",
			["20"] = "Big 1",
			["21"] = "Big 2",
			["22"] = "Big 3",
			["23"] = "Cavern Small",
			["24"] = "Cavern Medium",
			["25"] = "Cavern Large",
			["26"] = "Weirdo 1",
			["27"] = "Weirdo 2",
			["28"] = "Weirdo 3",
		}

		RenameEntity( pChunk, "env_sound", "env_soundscape" )
		RenameKey( pChunk, "roomtype", "soundscape" )

		local oldEnvSoundIndex = GetValueFromKey( pChunk, "soundscape" )
		local newSoundscape = env_sound[oldEnvSoundIndex]

		if newSoundscape ~= nil then
			ReplaceObjekt( pChunk, oldEnvSoundIndex, newSoundscape, "soundscape" )
		else
			ReplaceObjekt( pChunk, oldEnvSoundIndex, env_sound["0"], "soundscape" ) -- VXP: Just use "Normal (off)" soundscape
		end
	end
	
end

function UpdateModels(pChunk) --Credits for the list: Bun, CrazzyBubba and Витой


	ReplaceModel( pChunk, "models/Barrels/W_Barrel1.mdl", "models/props_c17/barrel01a.mdl" )
	ReplaceModel( pChunk, "models/Barrels/W_Barrel2.mdl", "models/props_c17/barrel02a.mdl" )
	ReplaceModel( pChunk, "models/Barrels/W_Barrel3.mdl", "models/props_c17/barrel03a.mdl" )
	ReplaceModel( pChunk, "models/Barrels/W_Barrel4.mdl", "models/props_c17/barrel04a.mdl" )
	ReplaceModel( pChunk, "models/Barrels/W_Barrel5.mdl", "models/props_c17/barrel05a.mdl" )
	ReplaceModel( pChunk, "models/Barrels/W_Barrel6.mdl", "models/props_c17/barrel06a.mdl" )
	ReplaceModel( pChunk, "models/Barrels/W_Barrel7.mdl", "models/props_c17/barrel07a.mdl" )
	ReplaceModel( pChunk, "models/Barrels/W_Barrel8.mdl", "models/props_c17/barrel08a.mdl" )
	ReplaceModel( pChunk, "models/Barrels/W_Barrel9.mdl", "models/props_c17/barrel09a.mdl" )
	ReplaceModel( pChunk, "models/Barrels/W_Barrel10.mdl", "models/props_c17/barrel10a.mdl" )
	ReplaceModel( pChunk, "models/Barrels/W_Barrel11.mdl", "models/props_c17/barrel11a.mdl" )
	ReplaceModel( pChunk, "models/Barrels/W_Barrel12.mdl", "models/props_c17/barrel12a.mdl" )
	
	ReplaceModel( pChunk, "models/Building_details/W_RebarSmallNorm01a.mdl", "models/props_debris/Rebar_SmallNorm01a.mdl" )
	ReplaceModel( pChunk, "models/Building_details/W_RebarSmallNorm01b.mdl", "models/props_debris/Rebar_SmallNorm01b.mdl" )
	ReplaceModel( pChunk, "models/Building_details/W_RebarSmallNorm01c.mdl", "models/props_debris/Rebar_SmallNorm01c.mdl" )
	
	ReplaceModel( pChunk, "models/Building_details/W_RebarMedNorm01a.mdl", "models/props_debris/Rebar_MedNorm01a.mdl" )
	ReplaceModel( pChunk, "models/Building_details/W_RebarMedNorm01b.mdl", "models/props_debris/Rebar_MedNorm01b.mdl" )
	ReplaceModel( pChunk, "models/Building_details/W_RebarMedNorm01c.mdl", "models/props_debris/Rebar_MedNorm01c.mdl" )
	ReplaceModel( pChunk, "models/Building_details/W_RebarMedNorm02a.mdl", "models/props_debris/Rebar_MedNorm02a.mdl" )
	ReplaceModel( pChunk, "models/Building_details/W_RebarMedNorm02b.mdl", "models/props_debris/Rebar_MedNorm02b.mdl" )
	ReplaceModel( pChunk, "models/Building_details/W_RebarMedNorm02c.mdl", "models/props_debris/Rebar_MedNorm02c.mdl" )
	ReplaceModel( pChunk, "models/Building_details/W_RebarMedNorm03a.mdl", "models/props_debris/Rebar_MedNorm03a.mdl" )
	ReplaceModel( pChunk, "models/Building_details/W_RebarMedNorm03b.mdl", "models/props_debris/Rebar_MedNorm03b.mdl" )
	ReplaceModel( pChunk, "models/Building_details/W_RebarMedNorm03c.mdl", "models/props_debris/Rebar_MedNorm03c.mdl" )
	ReplaceModel( pChunk, "models/Building_details/W_RebarMedThin01a.mdl", "models/props_debris/Rebar_MedThin01a.mdl" )
	ReplaceModel( pChunk, "models/Building_details/W_RebarMedThin01b.mdl", "models/props_debris/Rebar_MedThin01b.mdl" )
	ReplaceModel( pChunk, "models/Building_details/W_RebarMedThin01c.mdl", "models/props_debris/Rebar_MedThin01c.mdl" )
	ReplaceModel( pChunk, "models/Building_details/W_RebarMedThin02a.mdl", "models/props_debris/Rebar_MedThin02a.mdl" )
	ReplaceModel( pChunk, "models/Building_details/W_RebarMedThin02b.mdl", "models/props_debris/Rebar_MedThin02b.mdl" ) -- Not original
	ReplaceModel( pChunk, "models/Building_details/W_RebarMedThin02c.mdl", "models/props_debris/Rebar_MedThin02c.mdl" )
	ReplaceModel( pChunk, "models/Building_details/W_RebarMedThin03a.mdl", "models/props_debris/Rebar_MedThin03a.mdl" )
	ReplaceModel( pChunk, "models/Building_details/W_RebarMedThin03b.mdl", "models/props_debris/Rebar_MedThin03b.mdl" )
	ReplaceModel( pChunk, "models/Building_details/W_RebarMedThin03c.mdl", "models/props_debris/Rebar_MedThin03c.mdl" )
	ReplaceModel( pChunk, "models/Building_details/W_RebarLargeThick01a.mdl", "models/props_debris/Rebar_LargeThick01a.mdl" )
--	ReplaceModel( pChunk, "models/Building_details/W_Antenna01.mdl", "models/props_borealis/antenna001.mdl" ) -- Not original
	ReplaceModel( pChunk, "models/Building_details/W_ValveWheel01.mdl", "models/props_borealis/valvewheel002b.mdl" ) -- Not original

	ReplaceModel( pChunk, "models/c17_props/W_LoudSpeaker01.mdl", "models/props_wasteland/speakercluster01a.mdl" ) -- Not original

	ReplaceModel( pChunk, "models/Electronics/W_Intercom.mdl", "models/props_borealis/intercom01.mdl" )
	ReplaceModel( pChunk, "models/Electronics/W_Speaker01.mdl", "models/props_c17/trainspeaker01.mdl" )
	
	ReplaceModel( pChunk, "models/Furniture/W_Chair.mdl", "models/props_c17/chair02a.mdl" )
	ReplaceModel( pChunk, "models/Furniture/W_Clock.mdl", "models/props_c17/clock01.mdl" )
	ReplaceModel( pChunk, "models/Furniture/W_GarbCan.mdl", "models/props_c17/garbagecan01.mdl" )
	ReplaceModel( pChunk, "models/Furniture/W_Mailbox.mdl", "models/props_c17/mailbox01.mdl" ) --Not original
	ReplaceModel( pChunk, "models/Furniture/W_TrashCan.mdl", "models/props_c17/trashcan01a.mdl" )
	
	ReplaceModel( pChunk, "models/Lighting/W_CageLightOn01.mdl", "models/props_c17/light_cagelight01_on.mdl" )
	ReplaceModel( pChunk, "models/Lighting/W_CageLightOff01.mdl", "models/props_c17/light_cagelight01_off.mdl" )
	ReplaceModel( pChunk, "models/Lighting/W_CageLightOn02.mdl", "models/props_c17/light_cagelight02_on.mdl" )
	ReplaceModel( pChunk, "models/Lighting/W_CageLightOff02.mdl", "models/props_c17/light_cagelight02_off.mdl" )
	ReplaceModel( pChunk, "models/Lighting/W_DeckLightOn01.mdl", "models/props_c17/light_decklight01_on.mdl" )
	ReplaceModel( pChunk, "models/Lighting/W_DeckLightOff01.mdl", "models/props_c17/light_decklight01_off.mdl" )
	ReplaceModel( pChunk, "models/Lighting/W_DomeLightOn01.mdl", "models/props_c17/light_domelight01_on.mdl" )
	ReplaceModel( pChunk, "models/Lighting/W_DomeLightOff01.mdl", "models/props_c17/light_domelight01_off.mdl" )
	ReplaceModel( pChunk, "models/Lighting/W_DomeLightOn02.mdl", "models/props_c17/light_domelight01_on.mdl" )
	ReplaceModel( pChunk, "models/Lighting/W_DomeLightOff02.mdl", "models/props_c17/light_domelight02_off.mdl" )
	ReplaceModel( pChunk, "models/Lighting/W_FluorescentOn01.mdl", "models/props_c17/light_fluorescent01_on.mdl" )
	ReplaceModel( pChunk, "models/Lighting/W_FluorescentOff01.mdl", "models/props_c17/light_fluorescent01_off.mdl" )
	ReplaceModel( pChunk, "models/Lighting/W_GlobeLightOn01.mdl", "models/props_c17/light_globelight01_on.mdl" )
	ReplaceModel( pChunk, "models/Lighting/W_GlobeLightOff01.mdl", "models/props_c17/light_globelight01_off.mdl" )
	ReplaceModel( pChunk, "models/Lighting/W_IndustrialBell01On.mdl", "models/props_c17/light_industrialbell01_on.mdl" )
	ReplaceModel( pChunk, "models/Lighting/W_IndustrialBell01Off.mdl", "models/props_c17/light_industrialbell01_off.mdl" )
	ReplaceModel( pChunk, "models/Lighting/W_IndustrialBell02On.mdl", "models/props_c17/light_industrialbell02_on.mdl" )
	ReplaceModel( pChunk, "models/Lighting/W_IndustrialBell02Off.mdl", "models/props_c17/light_industrialbell02_off.mdl" )
	ReplaceModel( pChunk, "models/Lighting/W_LightBareOn.mdl", "models/props_c17/light_lightbare01_on.mdl" )
	ReplaceModel( pChunk, "models/Lighting/W_LightBareOff.mdl", "models/props_c17/light_lightbare01_off.mdl" )
	ReplaceModel( pChunk, "models/Lighting/W_LightBare.mdl", "models/props_c17/light_lightbare01_on.mdl" )
	ReplaceModel( pChunk, "models/lighting/W_LightBare.mdl", "models/props_c17/light_lightbare01_on.mdl" )
	ReplaceModel( pChunk, "models/Lighting/W_LightCage.mdl", "models/props_c17/light_lightcage01_on.mdl" )
	ReplaceModel( pChunk, "models/lighting/W_LightCage.mdl", "models/props_c17/light_lightcage01_on.mdl" )
	ReplaceModel( pChunk, "models/Lighting/W_LightShade.mdl", "models/props_c17/light_lightshade01_on.mdl" )
	ReplaceModel( pChunk, "models/lighting/W_LightShade.mdl", "models/props_c17/light_lightshade01_on.mdl" )
	ReplaceModel( pChunk, "models/Lighting/W_LightShade2On.mdl", "models/props_wasteland/W_LightShade2On.mdl" )
	ReplaceModel( pChunk, "models/Lighting/W_LightShade2Off.mdl", "models/props_wasteland/W_LightShade2Off.mdl" )
	ReplaceModel( pChunk, "models/Lighting/W_LightShade3On.mdl", "models/props_c17/light_cagelight02_on.mdl" )
	ReplaceModel( pChunk, "models/Lighting/W_LightShade3Off.mdl", "models/props_c17/light_cagelight02_off.mdl" )
	ReplaceModel( pChunk, "models/Lighting/W_StreetLightOn01.mdl", "models/props_c17/light_streetlight02_on.mdl" )
	ReplaceModel( pChunk, "models/Lighting/W_StreetLightOff01.mdl", "models/props_c17/light_streetlight01_off.mdl" )
	ReplaceModel( pChunk, "models/Lighting/W_StreetLightOn02.mdl", "models/props_c17/light_streetlight02_on.mdl" )
	ReplaceModel( pChunk, "models/Lighting/W_StreetLightOff02.mdl", "models/props_c17/light_streetlight02_off.mdl" )
	ReplaceModel( pChunk, "models/Lighting/W_StreetLampOn01.mdl", "models/props_c17/light_industrialbell01_on.mdl" ) -- Not original
	ReplaceModel( pChunk, "models/Lighting/W_StreetLampOff01.mdl", "models/props_c17/light_industrialbell01_off.mdl" ) -- Not original
	ReplaceModel( pChunk, "models/Lighting/W_StreetLampOn02.mdl", "models/props_c17/light_industrialbell02_on.mdl" ) -- Not original
	ReplaceModel( pChunk, "models/Lighting/W_StreetLampOff02.mdl", "models/props_c17/light_industrialbell02_off.mdl" )	-- Not original
	ReplaceModel( pChunk, "models/Lighting/W_TrafficLight.mdl", "models/props_c17/Traffic_Light001a.mdl" )
	
	ReplaceModel( pChunk, "models/Pipes/W_Pipe_1b_curve_halfsize.mdl", "models/props_c17/pipe02_90degree01.mdl" ) -- Not original
	ReplaceModel( pChunk, "models/Pipes/W_Pipe_1c_curve_quartersize.mdl", "models/props_c17/pipe01_90degree01.mdl" ) -- Not original
	ReplaceModel( pChunk, "models/Pipes/W_Pipe_2a_45curve.mdl", "models/props_c17/pipe03_45degree01.mdl" ) -- Not original
	ReplaceModel( pChunk, "models/Pipes/W_Pipe_2b_45curve_halfsize.mdl", "models/props_c17/pipe02_45degree01.mdl" ) -- Not original
	ReplaceModel( pChunk, "models/Pipes/W_Pipe_2c_45curve_quartersize.mdl", "models/props_c17/pipe01_45degree01.mdl" ) -- Not original
	ReplaceModel( pChunk, "models/Pipes/W_Pipe_4a_Yjoint.mdl", "models/props_c17/pipe03_yjoint01.mdl" ) -- Not original
	ReplaceModel( pChunk, "models/Pipes/W_Pipe_4b_Yjoint_halfsize.mdl", "models/props_c17/pipe02_yjoint01.mdl" ) -- Not original
	ReplaceModel( pChunk, "models/Pipes/W_PipeJoint.mdl", "models/props_c17/pipe01_tjoint01.mdl" ) -- Not original
	ReplaceModel( pChunk, "models/pipes/W_Valve.mdl", "models/props_borealis/valvewheel002.mdl" )
	
	ReplaceModel( pChunk, "models/props_c17/apc_engine01.mdl", "models/props_c17/TrapPropeller_Engine.mdl" )
	ReplaceModel( pChunk, "models/props_c17/streetlight01a_on.mdl", "models/props_c17/light01a_on.mdl" )
	ReplaceModel( pChunk, "models/props_c17/utilitymount001a.mdl", "models/props_c17/utilitypolemount01a.mdl" )

    ReplaceModel( pChunk, "models/Sentry01/Sentry01Gun.mdl", "models/Sentry_Guns/Sentry01Gun.mdl" )
	ReplaceModel( pChunk, "models/Sentry01/Sentry01Post.mdl", "models/Sentry_Guns/Sentry01Post.mdl" )
	ReplaceModel( pChunk, "models/Sentry01/Sentry01Base.mdl", "models/Sentry_Guns/Sentry01Base.mdl" )
	
	ReplaceModel( pChunk, "models/Ship/W_MapTube.mdl", "models/props_borealis/maptube01.mdl" )
	ReplaceModel( pChunk, "models/Ship/W_LifeCan.mdl", "models/props_borealis/lifecan01.mdl" )
	ReplaceModel( pChunk, "models/Ship/W_LifeRing.mdl", "models/props_borealis/lifering01.mdl" )
	ReplaceModel( pChunk, "models/Ship/W_Windlass.mdl", "models/props_borealis/windlass01.mdl" )

	-- legoj15
	ReplaceModel( pChunk, "models/Pipes/W_Pipe_1a_curve.mdl", "models/props_c17/pipe03_90degree01.mdl" ) -- Close probably
--	ReplaceModel( pChunk, "models/props_c17/handrail01a_level03.mdl", "models/props_c17/handrail01a_level03.mdl" ) -- Couldn't find replacement
--	ReplaceModel( pChunk, "models/C17_citizen_minimal.mdl", "models/Humans/Male_Cheaple.mdl" ) This is probably 200% wrong
end

function UpdateSky(pChunk)

	ReplaceSky( pChunk, "sky_urb01", "sky_c17_02" )
end

function UpdateTextures(pChunk) --Credits for the list: Bun, CrazzyBubba and Витой

	--Brick
	ReplaceTexture( pChunk, "BRICK/BRICKWALL001D", "BRICK/BRICKWALL001A_OLD" )
	ReplaceTexture( pChunk, "BRICK/BRICKWALL001C", "BRICK/BRICKWALL001C_OLD" )
	ReplaceTexture( pChunk, "BRICK/BRICKWALL001D", "SHADERTEST/SPHERICALENVMAPBLENDMASKEDBASETIMESLIGHTMAP" )
	ReplaceTexture( pChunk, "BRICK/BRICKWALL001G", "BRICK/BRICKWALL001G_OLD" )
	ReplaceTexture( pChunk, "BRICK/BRICKWALL002A", "STONE/STONEWALL036A" )
	ReplaceTexture( pChunk, "BRICK/BRICKWALL002B", "STONE/STONEWALL036B" )
	--ReplaceTexture( pChunk, "BRICK/BRICKWALL002C", "STONE/STONEWALL036C" ) --Does not exist
	ReplaceTexture( pChunk, "BRICK/BRICKWALL002D", "STONE/STONEWALL036D" )
	ReplaceTexture( pChunk, "BRICK/BRICKWALL007A", "STONE/STONEWALL037A" )
	ReplaceTexture( pChunk, "BRICK/BRICKWALL007B", "STONE/STONEWALL037B" )
	ReplaceTexture( pChunk, "BRICK/BRICKWALL007C", "STONE/STONEWALL037C" )
	ReplaceTexture( pChunk, "BRICK/BRICKWALL007D", "STONE/STONEWALL037D" )
	ReplaceTexture( pChunk, "BRICK/BRICKWALL007E", "STONE/STONEWALL037E" )
	ReplaceTexture( pChunk, "BRICK/BRICKWALL007F", "STONE/STONEWALL037F" )
	ReplaceTexture( pChunk, "BRICK/BRICKWALL007G", "STONE/STONEWALL037G" )
	ReplaceTexture( pChunk, "BRICK/BRICKWALL010A", "STONE/STONEWALL038A" )
	ReplaceTexture( pChunk, "BRICK/BRICKWALL010B", "STONE/STONEWALL038B" )
	ReplaceTexture( pChunk, "BRICK/BRICKWALL010C", "STONE/STONEWALL038C" )
	ReplaceTexture( pChunk, "BRICK/BRICKWALL010D", "STONE/STONEWALL038D" )
	ReplaceTexture( pChunk, "BRICK/BRICKWALL010E", "STONE/STONEWALL038E" )
	ReplaceTexture( pChunk, "BRICK/BRICKWALL010F", "STONE/STONEWALL038F" )
	ReplaceTexture( pChunk, "BRICK/BRICKWALL011A", "BRICK/BRICKWALL011A_OLD" )
	ReplaceTexture( pChunk, "BRICK/BRICKWALL011B", "BRICK/BRICKWALL011B_OLD" )
	ReplaceTexture( pChunk, "BRICK/BRICKWALL011C", "BRICK/BRICKWALL011C_OLD" )
	ReplaceTexture( pChunk, "BRICK/BRICKWALL011D", "STONE/STONEWALL039D" )
	ReplaceTexture( pChunk, "BRICK/BRICKWALL011E", "STONE/STONEWALL039E" )
	ReplaceTexture( pChunk, "BRICK/BRICKWALL011F", "STONE/STONEWALL039F" )
	ReplaceTexture( pChunk, "BRICK/BRICKWALL011G", "STONE/STONEWALL039G" )
	ReplaceTexture( pChunk, "BRICK/BRICKWALL011H", "STONE/STONEWALL039H" )
	ReplaceTexture( pChunk, "BRICK/BRICKWALL011I", "STONE/STONEWALL039I" )
	ReplaceTexture( pChunk, "BRICK/BRICKWALL012B", "BRICK/BRICKWALL012B_OLD" )
	ReplaceTexture( pChunk, "BRICK/BRICKWALL012C", "BRICK/BRICKWALL012C_OLD" )
	ReplaceTexture( pChunk, "BRICK/BRICKWALL013A", "STONE/STONEWALL034A" )
	ReplaceTexture( pChunk, "BRICK/BRICKWALL013B", "STONE/STONEWALL034B" )
	ReplaceTexture( pChunk, "BRICK/BRICKWALL013C", "STONE/STONEWALL034A" ) --Not original
	ReplaceTexture( pChunk, "BRICK/BRICKWALL014A", "STONE/STONEWALL035A" )
	ReplaceTexture( pChunk, "BRICK/BRICKWALL014B", "STONE/STONEWALL035B" )
	ReplaceTexture( pChunk, "BRICK/BRICKWALL020A", "STONE/STONEWALL018A" ) --Possibly not original
		
	--BUILDINGS_SM
	
	--Composite
	ReplaceTexture( pChunk, "COMPOSITE/BUILDINGWINDOW001A", "GLASS/GLASSWINDOW021A" )
	ReplaceTexture( pChunk, "COMPOSITE/BUILDINGWINDOW001B", "GLASS/GLASSWINDOW021B" )
	ReplaceTexture( pChunk, "COMPOSITE/BUILDINGWINDOW001C", "GLASS/GLASSWINDOW021C" )
	ReplaceTexture( pChunk, "COMPOSITE/BUILDINGWINDOW001D", "GLASS/GLASSWINDOW021D" )
	ReplaceTexture( pChunk, "COMPOSITE/BUILDINGWINDOW001E", "GLASS/GLASSWINDOW021E" )
	ReplaceTexture( pChunk, "COMPOSITE/BUILDINGWINDOW001F", "GLASS/GLASSWINDOW021F" )
	ReplaceTexture( pChunk, "COMPOSITE/BUILDINGWINDOW001G", "GLASS/GLASSWINDOW021G" )
	ReplaceTexture( pChunk, "COMPOSITE/BUILDINGWINDOW003A", "GLASS/GLASSWINDOW023A" )
	ReplaceTexture( pChunk, "COMPOSITE/BUILDINGWINDOW003B", "GLASS/GLASSWINDOW023B" )
	ReplaceTexture( pChunk, "COMPOSITE/BUILDINGWINDOW004A", "GLASS/GLASSWINDOW024A" )
	ReplaceTexture( pChunk, "COMPOSITE/BUILDINGWINDOW004B", "GLASS/GLASSWINDOW024B" )
	ReplaceTexture( pChunk, "COMPOSITE/BUILDINGWINDOW005A", "GLASS/GLASSWINDOW025A" )
	ReplaceTexture( pChunk, "COMPOSITE/BUILDINGWINDOW005B", "GLASS/GLASSWINDOW025B" )
	ReplaceTexture( pChunk, "COMPOSITE/BUILDINGWINDOW005C", "GLASS/GLASSWINDOW025C" )
	ReplaceTexture( pChunk, "COMPOSITE/BUILDINGWINDOW005D", "GLASS/GLASSWINDOW025D" )
	ReplaceTexture( pChunk, "COMPOSITE/BUILDINGWINDOW005E", "GLASS/GLASSWINDOW025E" )
	ReplaceTexture( pChunk, "COMPOSITE/BUILDINGWINDOW006A", "GLASS/GLASSWINDOW026A" )
	ReplaceTexture( pChunk, "COMPOSITE/BUILDINGWINDOW006B", "GLASS/GLASSWINDOW026B" )
	ReplaceTexture( pChunk, "COMPOSITE/BUILDINGWINDOW006C", "GLASS/GLASSWINDOW026C" )
	ReplaceTexture( pChunk, "COMPOSITE/BUILDINGWINDOW006D", "GLASS/GLASSWINDOW026D" )
		
	--Concrete
	ReplaceTexture( pChunk, "CONCRETE/CONCRETEFLOOR003A", "CONCRETE/CONCRETEFLOOR004A" )
	ReplaceTexture( pChunk, "CONCRETE/CONCRETEWALL012B", "SHADERTEST/BASETIMESLIGHTMAPTIMESDETAIL" )
	ReplaceTexture( pChunk, "CONCRETE/CONCRETEWALL012C", "CONCRETE/CONCRETEWALL012C_OLD" )
	ReplaceTexture( pChunk, "CONCRETE/CONCRETEWALL016C", "CONCRETE/CONCRETEWALL016C_OLD" )
	ReplaceTexture( pChunk, "CONCRETE/CONCRETEWALL017B", "CONCRETE/CONCRETEWALL017B_OLD" )
	ReplaceTexture( pChunk, "CONCRETE/CONCRETEWALL017C", "CONCRETE/CONCRETEWALL017C_OLD" )
	ReplaceTexture( pChunk, "CONCRETE/CONCRETEWALL020A", "CONCRETE/CONCRETEWALL020A_OLD" )
	ReplaceTexture( pChunk, "CONCRETE/CONCRETEWALL022A", "CONCRETE/CONCRETEWALL022A_OLD" )
	ReplaceTexture( pChunk, "CONCRETE/CONCRETEWALL026B", "CONCRETE/CONCRETEWALL026B_OLD" )
	ReplaceTexture( pChunk, "CONCRETE/CONCRETEWALL026C", "CONCRETE/CONCRETEWALL026C_OLD" )
	ReplaceTexture( pChunk, "CONCRETE/CONCRETEWALL060C", "CONCRETE/CONCRETEWALL060C_OLD" )
	
	--Dev
	
	--Glass
	ReplaceTexture( pChunk, "GLASS/GLASSWINDOW020A", "SHADERTEST/LIGHTMAPPEDBASEALPHAMASKEDENVMAPPEDTEXTURE" )
	ReplaceTexture( pChunk, "GLASS/GLASSWINDOW038A", "GLASS/GLASSWINDOW001A" ) --Not original
	ReplaceTexture( pChunk, "GLASS/GLASSWINDOW064A", "GLASS/GLASSWINDOW070A" ) 
	ReplaceTexture( pChunk, "GLASS/GLASSSKYBRIDGE003A", "BUILDING_TEMPLATE/BUILDING_SKYBRIDGE_TEMPLATE001A" ) --Not original
	
	--Lights
	
	--Metal
	ReplaceTexture( pChunk, "METAL/METALDOOR029A", "METAL/METALDOOR029A_OLD" )
	ReplaceTexture( pChunk, "METAL/FLOOR002A", "METAL/METALFLOOR002A" )
    ReplaceTexture( pChunk, "METAL/METALHULL006B", "METAL/METALHULL006B_OLD" )
	ReplaceTexture( pChunk, "METAL/METALPIPE003A", "METAL/METALPIPE003A_OLD" )
	ReplaceTexture( pChunk, "METAL/METALPIPE009A", "PROPS/METALPIPE009A" )
	ReplaceTexture( pChunk, "METAL/METALPIPE011A", "METAL/METALPIPE011A_OLD" )
	ReplaceTexture( pChunk, "METAL/METALRAIL001A", "METAL/METALRAIL001A_OLD" )
	

	--Nature

	--Plaster
	ReplaceTexture( pChunk, "PLASTER/PLASTERCOLUMN001A", "PLASTER/PLASTERWALL001H" )
	ReplaceTexture( pChunk, "PLASTER/PLASTERCOLUMN001B", "PLASTER/PLASTERWALL001I" )
	ReplaceTexture( pChunk, "PLASTER/PLASTERCOLUMN001C", "PLASTER/PLASTERWALL001J" )
    ReplaceTexture( pChunk, "PLASTER/PLASTERWALL002B", "PLASTER/PLASTERWALL002F" )
	ReplaceTexture( pChunk, "PLASTER/PLASTERWALL002C", "PLASTER/PLASTERWALL002A" )
	ReplaceTexture( pChunk, "PLASTER/PLASTERWALL003F", "PLASTER/PLASTERWALL003B" )
	ReplaceTexture( pChunk, "PLASTER/PLASTERWALL010H", "PLASTER/PLASTERWALL010H_OLD" )
	ReplaceTexture( pChunk, "PLASTER/PLASTERWALL010I", "PLASTER/PLASTERWALL010I_OLD" )
	ReplaceTexture( pChunk, "PLASTER/PLASTERWALL010J", "PLASTER/PLASTERWALL010J_OLD" )
	ReplaceTexture( pChunk, "PLASTER/PLASTERWALL012C", "METAL/METALWALL035A" ) --Speculation
	ReplaceTexture( pChunk, "PLASTER/PLASTERWALL028E", "PLASTER/PLASTERWALL028I" )
	ReplaceTexture( pChunk, "PLASTER/PLASTERWALL039C", "PLASTER/PLASTERWALL039A" )
	ReplaceTexture( pChunk, "PLASTER/PLASTERWALL043C", "STONE/STONEWALL040E" )
	ReplaceTexture( pChunk, "PLASTER/PLASTERWALL043D", "STONE/STONEWALL040D" )
	ReplaceTexture( pChunk, "PLASTER/PLASTERWALL043E", "STONE/STONEWALL040E" )
	
	--Props
	ReplaceTexture( pChunk, "PROPS/BILLBOARD002A", "PROPS/SIGNBILLBOARD002A" )
	ReplaceTexture( pChunk, "PROPS/METALSIGN001A", "PROPS/METALSIGN001A_OLD" )
	ReplaceTexture( pChunk, "PROPS/METALSIGN001D", "PROPS/METALSIGN001D_OLD" )
	ReplaceTexture( pChunk, "PROPS/PAPERPOSTER001A", "PROPS/PAPERPOSTER001A_OLD" )
	ReplaceTexture( pChunk, "PROPS/PAPERPOSTER002A", "PROPS/PAPERPOSTER002A_OLD" )
	ReplaceTexture( pChunk, "PROPS/PAPERPOSTER003A", "PROPS/PAPERPOSTER003A_OLD" )
	
	--Stone
	ReplaceTexture( pChunk, "STONE/STONEWALL001A", "DEV/DEV_STONEWALL001A" )
    ReplaceTexture( pChunk, "STONE/STONEWALL008B", "STONE/STONEWALL008E" )
	ReplaceTexture( pChunk, "STONE/STONEWALL008D", "STONE/STONEWALL008A" )
	ReplaceTexture( pChunk, "STONE/STONEWALL021B", "STONE/STONEWALL021C" )
	ReplaceTexture( pChunk, "STONE/STONEWALL021C", "STONE/STONEWALL021A" )
	ReplaceTexture( pChunk, "STONE/STONEWALL021D", "STONE/STONEWALL021I" )
	ReplaceTexture( pChunk, "STONE/STONEWALL021E", "STONE/STONEWALL021G" )
	ReplaceTexture( pChunk, "STONE/STONEWALL021F", "STONE/STONEWALL021K" )
	ReplaceTexture( pChunk, "STONE/STONEWALL021H", "STONE/STONEWALL021B" )
	ReplaceTexture( pChunk, "STONE/STONEWALL023A", "STONE/STONEWALL023A_OLD" )
	ReplaceTexture( pChunk, "STONE/STONEWALL024C", "STONE/STONEWALL024F" )
	ReplaceTexture( pChunk, "STONE/STONEWALL024I", "STONE/STONEWALL024A" )
	ReplaceTexture( pChunk, "STONE/STONEWALL029A", "PLASTER/PLASTERWALL036A" )
	ReplaceTexture( pChunk, "STONE/STONEWALL029B", "PLASTER/PLASTERWALL036B" )
	ReplaceTexture( pChunk, "STONE/STONEWALL029C", "PLASTER/PLASTERWALL036C" )
	ReplaceTexture( pChunk, "STONE/STONEWALL029D", "PLASTER/PLASTERWALL036D" )
	ReplaceTexture( pChunk, "STONE/STONEWALL029H", "PLASTER/PLASTERWALL036H" )
	ReplaceTexture( pChunk, "STONE/STONEWALL030B", "STONE/STONEWALL030K" )
	ReplaceTexture( pChunk, "STONE/STONEWALL033A", "STONE/STONEWALL033A_OLD" )
	ReplaceTexture( pChunk, "STONE/STONEWALL033B", "STONE/STONEWALL033B_OLD" )
	ReplaceTexture( pChunk, "STONE/STONEWALL033C", "STONE/STONEWALL033C_OLD" )
	ReplaceTexture( pChunk, "STONE/STONEWALL033F", "STONE/STONEWALL033F_OLD" )
	ReplaceTexture( pChunk, "STONE/STONEWALL033G", "STONE/STONEWALL033G_OLD" )
	ReplaceTexture( pChunk, "STONE/STONEWALL033H", "STONE/STONEWALL033H_OLD" )
	ReplaceTexture( pChunk, "STONE/STONEWALL033I", "STONE/STONEWALL033I_OLD" )
	
	--Tile

end

function UpdateEntitiesName(pChunk)

	RenameEntity( pChunk, "detail_prop", "prop_detail" )
	RenameEntity( pChunk, "dynamic_prop", "prop_dynamic" )
	RenameEntity( pChunk, "physics_prop", "prop_physics" )
	RenameEntity( pChunk, "static_prop", "prop_static" )
	RenameEntity( pChunk, "model_studio", "prop_static" )
	RenameEntity( pChunk, "monster_metropolice", "npc_metropolice" )
	RenameEntity( pChunk, "npc_metrocop", "npc_metropolice" )
	RenameEntity( pChunk, "monster_combot", "npc_cscanner" )
	RenameEntity( pChunk, "aiscripted_sequence", "scripted_sequence" )
	RenameEntity( pChunk, "npc_turret", "npc_turret_ceiling" )
	RenameEntity( pChunk, "env_glow", "env_lightglow" )
--	RenameEntity( pChunk, "func_train", "func_tracktrain" ) -- ???
	RenameEntity( pChunk, "light_glspot", "light_spot" )
end

function UpdateCode(pChunk)

	local chunkname = GetChunkName(pChunk);
	
	if chunkname == "entity" then
		FixedBlackColor(pChunk)
		UpdateEntitiesName(pChunk)
		UpdateModels(pChunk)
	 	UpdateMoveDir(pChunk)
		FixedLogicEntity(pChunk)
	end
	
	if chunkname == "world" then
		UpdateSky(pChunk)
	end	
	
	if chunkname == "side" then
		UpdateTextures(pChunk)
	end	

end