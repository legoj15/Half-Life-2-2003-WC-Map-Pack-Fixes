
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
	UpdateMoveDirToEnt( pChunk, "func_conveyor", "movedir" )
	UpdateMoveDirToEnt( pChunk, "func_door", "movedir" )
	UpdateMoveDirToEnt( pChunk, "func_door_weldable", "movedir" )
	UpdateMoveDirToEnt( pChunk, "func_movelinear", "movedir" )
	UpdateMoveDirToEnt( pChunk, "func_water", "movedir" )
	UpdateMoveDirToEnt( pChunk, "momentary_door", "movedir" )
	UpdateMoveDirToEnt( pChunk, "trigger_push", "pushdir" )
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
		-- DSP effects for env_soundscape
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

	-- VXP: No need to check on "static_prop" - they're already converted at UpdateEntitiesName, right?
	if entitytype == "prop_static" then
		local SOLID = {}
		SOLID["NONE"] =		"0"
		SOLID["BSP"] =		"1"
		SOLID["BBOX"] =		"2"
		SOLID["OBB"] =		"3"
		SOLID["OBB_YAW"] =	"4"
		SOLID["CUSTOM"] =	"5"
		SOLID["VPHYSICS"] =	"6"

		local solidType = GetValueFromKey( pChunk, "solid" )
		if solidType ~= SOLID.NONE and solidType ~= SOLID.BBOX and solidType ~= SOLID.VPHYSICS then -- Older maps are using old solid values for static props
			ReplaceObjekt( pChunk, solidType, SOLID.VPHYSICS, "solid" )
		end
	end

	-- VXP
	if entitytype == "logic_case" then
		-- Updating keyvalues section (https://developer.valvesoftware.com/wiki/Logic_case)
		for i = 1, 9 do
			RenameKey( pChunk, "Case" .. i, "Case0" .. i )
		end

		-- Updating outputs
		local NewChunk = GetOrCreateSubChunk( pChunk, "connections" )
		for i = 1, 9 do
			RenameKey( NewChunk, "OnCase" .. i, "OnCase0" .. i )
		end
	end

	-- VXP
	if entitytype == "func_tracktrain" then
		-- Wrong one
	--	local oldTrainSoundNumber = GetValueFromKey( pChunk, "sounds" )
	--	RenameKey( pChunk, "sounds", "MoveSound" )
	--	ReplaceObjekt( pChunk, oldTrainSoundNumber, "plats/ttrain" .. oldTrainSoundNumber .. ".wav", "MoveSound" ) -- ReplaceObjekt(pChunk, OldValue, NewValue, ObjektName)

		local TrainSound = {}
		TrainSound["1"] = "plats/ttrain1.wav"
		TrainSound["2"] = "plats/ttrain2.wav"
		TrainSound["3"] = "plats/ttrain3.wav"
		TrainSound["4"] = "plats/ttrain4.wav"
		TrainSound["5"] = "plats/ttrain6.wav"
		TrainSound["6"] = "plats/ttrain7.wav"

		local oldTrainSoundNumber = GetValueFromKey( pChunk, "sounds" ) -- Getting the old value of sounds
		local newValue = TrainSound[oldTrainSoundNumber]
		if newValue ~= nil then
			ReplaceObjekt( pChunk, oldTrainSoundNumber, newValue, "sounds" ) -- Replacing old sounds value with new one
			RenameKey( pChunk, "sounds", "MoveSound" ) -- Renaming key
		end
	end

	-- VXP
	if entitytype == "func_physbox" or entitytype == "phys_magnet" or entitytype == "prop_physics" then
		local oldMass = GetValueFromKey( pChunk, "mass" )
		if oldMass ~= nil then
			-- "mass" key to "massScale"
			RenameKey( pChunk, "mass", "massScale" )
		end
	end

	-- VXP
	if entitytype == "npc_metropolice" then
		local oldWeapon = GetValueFromKey( pChunk, "additionalequipment" )
		if oldWeapon ~= nil and oldWeapon == "npcweapon_mp5k" then
			ReplaceObjekt( pChunk, oldWeapon, "weapon_smg1", "additionalequipment" )
		end
	end

	-- VXP
	if entitytype == "func_door_rotating" then
		local oldNoise1 = GetValueFromKey( pChunk, "noise1" )
		local oldNoise2 = GetValueFromKey( pChunk, "noise2" )

		if oldNoise1 ~= nil and oldNoise1 == "doors/func_door_rotating/gate1_move.wav" then -- TODO: Maybe do partial search of string
			ReplaceObjekt( pChunk, oldNoise1, "doors/func_door_rotating/gate_move1.wav", "noise1" )
		end

		if oldNoise2 ~= nil and oldNoise2 == "doors/func_door_rotating/gate1_stop.wav" then -- TODO: Maybe do partial search of string
			ReplaceObjekt( pChunk, oldNoise2, "doors/func_door_rotating/gate_stop1.wav", "noise2" )
		end
	end

	-- VXP
	if entitytype == "ambient_generic" then
		local oldMessage = GetValueFromKey( pChunk, "message" )
		if oldMessage ~= nil then
			if oldMessage ==		"sound/ambient/hyper/coldwind3_loop.wav" then
				ReplaceObjekt( pChunk, oldMessage, "ambient/hyper/coldwind3_loop.wav", "message" )
			elseif oldMessage ==	"ambient/areas/borealis/cargo_hold.wav" then
				ReplaceObjekt( pChunk, oldMessage, "ambient/areas/borealis/cargo_hold1.wav", "message" )
			end
		end
	end

	-- VXP: func_physbox spawnflags routine
--[[
	do
		function bitand(a, b)
			local result = 0
			local bitval = 1
			while a > 0 and b > 0 do
			  if a % 2 == 1 and b % 2 == 1 then -- test the rightmost bits
				  result = result + bitval      -- set the current bit
			  end
			  bitval = bitval * 2 -- shift left
			  a = math.floor(a/2) -- shift right
			  b = math.floor(b/2)
			end
			return result
		end

		-- Old?
		local OSF_PHYSBOX_ASLEEP =			1
		local OSF_PHYSBOX_IGNOREUSE =		2
		local OSF_PHYSBOX_DEBRIS =			4

		-- New
		local SF_PHYSBOX_ASLEEP =			4096 -- 0x01000
		local SF_PHYSBOX_IGNOREUSE =		8192 -- 0x02000
		local SF_PHYSBOX_DEBRIS =			16384 -- 0x04000
	--	local SF_PHYSBOX_MOTIONDISABLED =	32768 -- 0x08000
	--	local SF_PHYSBOX_USEPREFERRED =		65536 -- 0x10000

		local oldSpawnflags = GetValueFromKey( pChunk, "spawnflags" )
		oldSpawnflags = tonumber( oldSpawnflags )
		if bit.band( oldSpawnflags, OSF_PHYSBOX_ASLEEP ) then
			
		end
	end
]]
end

function UpdateModels(pChunk) --Credits for the list: Витой, Bun and CrazzyBubba

	--ReplaceModel( pChunk, "models/AirVent01.mdl", "models/props_airex/airvent01.mdl" ) -- Not original 
	ReplaceModel( pChunk, "models/can.mdl", "models/Junk/W_Garb_PopCan.mdl" ) -- Not original 
	ReplaceModel( pChunk, "models/hydra_seer.mdl", "models/E3hydra_seer.mdl" )
	ReplaceModel( pChunk, "models/hydra_smacker.mdl", "models/E3hydra_smacker.mdl" )
	ReplaceModel( pChunk, "models/iceaxe.mdl", "models/weapons/w_iceaxe.mdl" )
	--ReplaceModel( pChunk, "models/Pistons01.mdl", "models/props_airex/pistons01.mdl" ) -- Not original 
	ReplaceModel( pChunk, "models/SScanner.mdl", "models/Shield_Scanner.mdl" )
	ReplaceModel( pChunk, "models/striderscale1.mdl", "models/Combine_Strider.mdl" ) -- Not original 
	ReplaceModel( pChunk, "models/striderscale2.mdl", "models/Combine_Strider.mdl" ) -- Not original 
	ReplaceModel( pChunk, "models/striderscale3.mdl", "models/Combine_Strider.mdl" ) -- Not original 
		
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
	
	ReplaceModel( pChunk, "models/Bathroom/W_ToiletStained.mdl", "models/props_c17/toilet01_dirty.mdl" )
	
	ReplaceModel( pChunk, "models/Building_details/W_MetalRebar01.mdl", "models/props_debris/Rebar_MedNorm01a.mdl" )
	ReplaceModel( pChunk, "models/Building_details/W_MetalRebar02.mdl", "models/props_debris/Rebar_MedNorm01b.mdl" )
	ReplaceModel( pChunk, "models/Building_details/W_MetalRebar03.mdl", "models/props_debris/Rebar_MedNorm01c.mdl" )
	ReplaceModel( pChunk, "models/Building_details/W_RebarLargeThick01a.mdl", "models/props_debris/Rebar_LargeThick01a.mdl" )
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
	ReplaceModel( pChunk, "models/Building_details/W_RebarSmallNorm01a.mdl", "models/props_debris/Rebar_SmallNorm01a.mdl" )
	ReplaceModel( pChunk, "models/Building_details/W_RebarSmallNorm01b.mdl", "models/props_debris/Rebar_SmallNorm01b.mdl" )
	ReplaceModel( pChunk, "models/Building_details/W_RebarSmallNorm01c.mdl", "models/props_debris/Rebar_SmallNorm01c.mdl" )
	ReplaceModel( pChunk, "models/Building_details/W_RebarThin01.mdl", "models/props_debris/Rebar_MedThin01a.mdl" )
	
--	ReplaceModel( pChunk, "models/Building_details/W_Antenna01.mdl", "models/props_borealis/antenna001.mdl" ) -- Not original
	ReplaceModel( pChunk, "models/Building_details/W_ValveWheel01.mdl", "models/props_borealis/valvewheel002b.mdl" ) -- Not original

	ReplaceModel( pChunk, "models/c17_props/W_LoudSpeaker01.mdl", "models/props_c17/loudspeaker01.mdl" )
	ReplaceModel( pChunk, "models/c17_props/W_Pipes03.mdl", "models/props_c17/pipe_cluster01.mdl" ) --Not original

	ReplaceModel( pChunk, "models/Electronics/W_Intercom.mdl", "models/props_borealis/intercom01.mdl" )
	ReplaceModel( pChunk, "models/Electronics/W_Speaker01.mdl", "models/props_c17/trainspeaker01.mdl" )
	
	ReplaceModel( pChunk, "models/Furniture/W_Chair.mdl", "models/props_c17/chair02a.mdl" )
	ReplaceModel( pChunk, "models/Furniture/W_Clock.mdl", "models/props_c17/clock01.mdl" )
	ReplaceModel( pChunk, "models/Furniture/W_GarbCan.mdl", "models/props_c17/garbagecan01.mdl" )
	ReplaceModel( pChunk, "models/Furniture/W_Mailbox.mdl", "models/props_c17/mailbox01.mdl" ) --Not original
	ReplaceModel( pChunk, "models/Furniture/W_TrashCan.mdl", "models/props_c17/trashcan01a.mdl" ) --Not original
	
	ReplaceModel( pChunk, "models/Lighting/W_CageLight.mdl", "models/props_c17/light_cagelight02_on.mdl" )
	ReplaceModel( pChunk, "models/Lighting/W_CageLightOn01.mdl", "models/props_c17/light_cagelight01_on.mdl" )
	ReplaceModel( pChunk, "models/Lighting/W_CageLightOff01.mdl", "models/props_c17/light_cagelight01_off.mdl" )
	ReplaceModel( pChunk, "models/Lighting/W_CageLightOn02.mdl", "models/props_c17/light_cagelight02_on.mdl" )
	ReplaceModel( pChunk, "models/Lighting/W_CageLightOff02.mdl", "models/props_c17/light_cagelight02_off.mdl" )
	ReplaceModel( pChunk, "models/Lighting/W_ChandelierOn01.mdl", "models/props_c17/light_chandelier03_on.mdl" ) --Not original
	ReplaceModel( pChunk, "models/Lighting/W_DeckLightOn01.mdl", "models/props_c17/light_decklight01_on.mdl" )
	ReplaceModel( pChunk, "models/Lighting/W_DeckLightOff01.mdl", "models/props_c17/light_decklight01_off.mdl" )
	ReplaceModel( pChunk, "models/Lighting/W_DeskLamp.mdl", "models/props_c17/light_desklamp01_off.mdl" )
	ReplaceModel( pChunk, "models/Lighting/W_DomeLightOn01.mdl", "models/props_c17/light_domelight01_on.mdl" )
	ReplaceModel( pChunk, "models/Lighting/W_DomeLightOff01.mdl", "models/props_c17/light_domelight01_off.mdl" )
	ReplaceModel( pChunk, "models/Lighting/W_FloodLight.mdl", "models/props_c17/light_floodlight01_off.mdl" )
	ReplaceModel( pChunk, "models/Lighting/W_FloodLight2.mdl", "models/props_c17/light_floodlight02_off.mdl" )
	ReplaceModel( pChunk, "models/Lighting/W_FluorescentOn01.mdl", "models/props_c17/light_fluorescent01_on.mdl" )
	ReplaceModel( pChunk, "models/Lighting/W_FluorescentOff01.mdl", "models/props_c17/light_fluorescent01_off.mdl" )
	ReplaceModel( pChunk, "models/Lighting/W_GlobeLightOn01.mdl", "models/props_c17/light_globelight01_on.mdl" )
	ReplaceModel( pChunk, "models/Lighting/W_GlobeLightOff01.mdl", "models/props_c17/light_globelight01_off.mdl" )
	ReplaceModel( pChunk, "models/Lighting/W_IndustrialBell01On.mdl", "models/props_c17/light_industrialbell01_on.mdl" )
	ReplaceModel( pChunk, "models/Lighting/W_IndustrialBell01Off.mdl", "models/props_c17/light_industrialbell01_off.mdl" )
	ReplaceModel( pChunk, "models/Lighting/W_IndustrialBell02On.mdl", "models/props_c17/light_industrialbell02_on.mdl" )
	ReplaceModel( pChunk, "models/Lighting/W_IndustrialBell02Off.mdl", "models/props_c17/light_industrialbell02_off.mdl" )
	ReplaceModel( pChunk, "models/Lighting/W_LightBare.mdl", "models/props_c17/light_lightbare01_on.mdl" )
	ReplaceModel( pChunk, "models/lighting/W_LightBare.mdl", "models/props_c17/light_lightbare01_on.mdl" )
	ReplaceModel( pChunk, "models/Lighting/W_LightBareOn.mdl", "models/props_c17/light_lightbare01_on.mdl" )
	ReplaceModel( pChunk, "models/Lighting/W_LightCage.mdl", "models/props_c17/light_lightcage01_on.mdl" )
	ReplaceModel( pChunk, "models/lighting/W_LightCage.mdl", "models/props_c17/light_lightcage01_on.mdl" )
	ReplaceModel( pChunk, "models/Lighting/W_LightShade.mdl", "models/props_c17/light_lightshade01_on.mdl" )
	ReplaceModel( pChunk, "models/lighting/W_LightShade.mdl", "models/props_c17/light_lightshade01_on.mdl" )
	ReplaceModel( pChunk, "models/Lighting/W_LightShade2On.mdl", "models/props_wasteland/W_LightShade2On.mdl" )
	ReplaceModel( pChunk, "models/Lighting/W_LightShade2Off.mdl", "models/props_wasteland/W_LightShade2Off.mdl" )
	ReplaceModel( pChunk, "models/Lighting/W_LightShade3On.mdl", "models/props_c17/light_cagelight02_on.mdl" )
	ReplaceModel( pChunk, "models/Lighting/W_LightShadeCage.mdl", "models/props_c17/light_lightshadecage01_on.mdl" )
	ReplaceModel( pChunk, "models/Lighting/W_StreetLampOn01.mdl", "models/props_c17/light_industrialbell01_on.mdl" ) -- Not original
	ReplaceModel( pChunk, "models/Lighting/W_StreetLampOff01.mdl", "models/props_c17/light_industrialbell01_off.mdl" ) -- Not original
	ReplaceModel( pChunk, "models/Lighting/W_StreetLight.mdl", "models/props_c17/light_streetlight01_off.mdl" )
	ReplaceModel( pChunk, "models/Lighting/W_StreetLightOn01.mdl", "models/props_c17/light_streetlight02_on.mdl" )
	ReplaceModel( pChunk, "models/Lighting/W_StreetLightOff01.mdl", "models/props_c17/light_streetlight01_off.mdl" )
	ReplaceModel( pChunk, "models/Lighting/W_StreetLightOn02.mdl", "models/props_c17/light_streetlight02_on.mdl" )
	ReplaceModel( pChunk, "models/Lighting/W_StreetLightOff02.mdl", "models/props_c17/light_streetlight02_off.mdl" )
	ReplaceModel( pChunk, "models/Lighting/W_TrafficLight.mdl", "models/props_c17/Traffic_Light001a.mdl" )
	ReplaceModel( pChunk, "models/Lighting/W_WallSconceOn01.mdl", "models/props_c17/light_sconce01_on.mdl" )
	ReplaceModel( pChunk, "models/Lighting/W_WallSconceOff01.mdl", "models/props_c17/light_sconce01_off.mdl" )
	
	ReplaceModel( pChunk, "models/Pipes/W_Pipe_1a_curve.mdl", "models/props_c17/pipe03_90degree01.mdl" ) --Not original
	ReplaceModel( pChunk, "models/Pipes/W_Pipe_1b_curve_halfsize.mdl", "models/props_c17/pipe02_90degree01.mdl" ) -- Not original
	ReplaceModel( pChunk, "models/Pipes/W_Pipe_1c_curve_quartersize.mdl", "models/props_c17/pipe01_90degree01.mdl" ) -- Not original
	ReplaceModel( pChunk, "models/Pipes/W_Pipe_2a_45curve.mdl", "models/props_c17/pipe03_45degree01.mdl" ) -- Not original
	ReplaceModel( pChunk, "models/Pipes/W_Pipe_2b_45curve_halfsize.mdl", "models/props_c17/pipe02_45degree01.mdl" ) -- Not original
	ReplaceModel( pChunk, "models/Pipes/W_Pipe_2c_45curve_quartersize.mdl", "models/props_c17/pipe01_45degree01.mdl" ) -- Not original
	ReplaceModel( pChunk, "models/Pipes/W_Pipe_3a_Tjoint.mdl", "models/props_c17/pipe03_tjoint01.mdl" ) --Not original
	ReplaceModel( pChunk, "models/Pipes/W_Pipe_4a_Yjoint.mdl", "models/props_c17/pipe03_yjoint01.mdl" ) -- Not original
	ReplaceModel( pChunk, "models/Pipes/W_Pipe_4b_Yjoint_halfsize.mdl", "models/props_c17/pipe02_yjoint01.mdl" ) -- Not original
	ReplaceModel( pChunk, "models/Pipes/W_Pipe_5b_Yyjoint.mdl", "models/props_c17/pipe02_yjoint02.mdl" ) -- Not original
	ReplaceModel( pChunk, "models/Pipes/W_PipeJoint.mdl", "models/props_c17/pipe01_tjoint01.mdl" ) -- Not original
	ReplaceModel( pChunk, "models/pipes/W_Valve.mdl", "models/props_borealis/valvewheel001.mdl" ) -- Not original
	ReplaceModel( pChunk, "models/Pipes/W_Valve.mdl", "models/props_borealis/valvewheel001.mdl" ) -- Not original
	
	ReplaceModel( pChunk, "models/props_borealis/Icebergs01d.mdl", "models/props_borealis/Iceberg01d.mdl" )
	
	ReplaceModel( pChunk, "models/props_c17/apc_engine01.mdl", "models/props_c17/TrapPropeller_Engine.mdl" )
	ReplaceModel( pChunk, "models/props_c17/chair03a_kleiner.mdl", "models/props_c17/chair_kleiner03a.mdl" )
	ReplaceModel( pChunk, "models/props_c17/light_streetlamp01_on.mdl", "models/props_c17/light_industrialbell01_on.mdl" )
	ReplaceModel( pChunk, "models/props_c17/streetlight01a_on.mdl", "models/props_c17/light01a_on.mdl" ) --Not original
	ReplaceModel( pChunk, "models/props_c17/pipe02_lcurve01.mdl", "models/props_c17/pipe02_lcurve01_short.mdl" ) --Not original
	ReplaceModel( pChunk, "models/props_c17/powertower02.mdl", "models/props_wasteland/powertower02.mdl" )
	ReplaceModel( pChunk, "models/props_c17/trashcan01b.mdl", "models/props_c17/trashcan01a.mdl" ) --Not original
	ReplaceModel( pChunk, "models/props_c17/utilitymount001a.mdl", "models/props_c17/utilitypolemount01a.mdl" ) --Not original
	
	ReplaceModel( pChunk, "models/props_debris/concretedebris_chunk01a_reference.mdl", "models/props_debris/concrete_chunk01a.mdl" )
	ReplaceModel( pChunk, "models/props_debris/concretedebris_chunk01b_reference.mdl", "models/props_debris/concrete_chunk01b.mdl" )
	ReplaceModel( pChunk, "models/props_debris/concretedebris_chunk01c_reference.mdl", "models/props_debris/concrete_chunk01c.mdl" )
	ReplaceModel( pChunk, "models/props_debris/concretedebris_chunk02a_reference.mdl", "models/props_debris/concrete_chunk02a.mdl" )
	ReplaceModel( pChunk, "models/props_debris/concretedebris_chunk02b_reference.mdl", "models/props_debris/concrete_chunk02b.mdl" )
	ReplaceModel( pChunk, "models/props_debris/concretedebris_chunk02c_reference.mdl", "models/props_debris/concrete_chunk02c.mdl" )
	ReplaceModel( pChunk, "models/props_debris/concretedebris_chunk03a_reference.mdl", "models/props_debris/concrete_chunk03a.mdl" )
	ReplaceModel( pChunk, "models/props_debris/concretedebris_chunk04a_reference.mdl", "models/props_debris/concrete_chunk04a.mdl" )
	ReplaceModel( pChunk, "models/props_debris/concretedebris_chunk05a_reference.mdl", "models/props_debris/concrete_chunk05a.mdl" )
	ReplaceModel( pChunk, "models/props_debris/concretedebris_chunk05b_reference.mdl", "models/props_debris/concrete_chunk05b.mdl" )
	ReplaceModel( pChunk, "models/props_debris/concretedebris_chunk05c_reference.mdl", "models/props_debris/concrete_chunk05c.mdl" )
	ReplaceModel( pChunk, "models/props_debris/concretedebris_chunk05d_reference.mdl", "models/props_debris/concrete_chunk05d.mdl" )
	ReplaceModel( pChunk, "models/props_debris/concretedebris_chunk05e_reference.mdl", "models/props_debris/concrete_chunk05e.mdl" )
	ReplaceModel( pChunk, "models/props_debris/concretedebris_chunk05f_reference.mdl", "models/props_debris/concrete_chunk05f.mdl" )
	ReplaceModel( pChunk, "models/props_debris/concretedebris_chunk05g_reference.mdl", "models/props_debris/concrete_chunk05g.mdl" )
	
	ReplaceModel( pChunk, "models/props_wasteland/laundry_cart001_reference.mdl", "models/props_wasteland/laundry_cart001.mdl" )
	ReplaceModel( pChunk, "models/props_wasteland/laundry_cart002_reference.mdl", "models/props_wasteland/laundry_cart002.mdl" )
	ReplaceModel( pChunk, "models/props_wasteland/laundry_cart003_reference.mdl", "models/props_wasteland/laundry_cart003.mdl" )
	ReplaceModel( pChunk, "models/props_wasteland/laundry_dryer001_reference.mdl", "models/props_wasteland/laundry_dryer001.mdl" )
	ReplaceModel( pChunk, "models/props_wasteland/laundry_dryer002_reference.mdl", "models/props_wasteland/laundry_dryer002.mdl" )
	ReplaceModel( pChunk, "models/props_wasteland/laundry_dryer003_reference.mdl", "models/props_wasteland/laundry_dryer003.mdl" )
	ReplaceModel( pChunk, "models/props_wasteland/laundry_washer_arm001_reference.mdl", "models/props_wasteland/laundry_blade001.mdl" )
	ReplaceModel( pChunk, "models/props_wasteland/laundry_washer_basket001_reference.mdl", "models/props_wasteland/laundry_basket001.mdl" )
	ReplaceModel( pChunk, "models/props_wasteland/laundry_washer001_reference.mdl", "models/props_wasteland/laundry_washer001a.mdl" )
	ReplaceModel( pChunk, "models/props_wasteland/laundry_washer002_reference.mdl", "models/props_wasteland/laundry_washer001b.mdl" )
	ReplaceModel( pChunk, "models/props_wasteland/laundry_washer003_reference.mdl", "models/props_wasteland/laundry_washer003.mdl" )
	ReplaceModel( pChunk, "models/props_wasteland/laundry_washer004_reference.mdl", "models/props_wasteland/laundry_washer002.mdl" )
	
    ReplaceModel( pChunk, "models/Sentry01/Sentry01Gun.mdl", "models/Sentry_Guns/Sentry01Gun.mdl" )
	ReplaceModel( pChunk, "models/Sentry01/Sentry01Post.mdl", "models/Sentry_Guns/Sentry01Post.mdl" )
	
	ReplaceModel( pChunk, "models/Ship/W_LifeCan.mdl", "models/props_borealis/lifecan01.mdl" )
	ReplaceModel( pChunk, "models/Ship/W_LifeRing.mdl", "models/props_borealis/lifering01.mdl" )
	ReplaceModel( pChunk, "models/Ship/W_MapTube.mdl", "models/props_borealis/maptube01.mdl" )
	ReplaceModel( pChunk, "models/Ship/W_Windlass.mdl", "models/props_borealis/windlass01.mdl" )
	
end

function UpdateSky(pChunk)

	ReplaceSky( pChunk, "sky_c17_morning01", "sky_c17_03" )
	ReplaceSky( pChunk, "sky_c17_overcast01", "sky_c17_01" )
	ReplaceSky( pChunk, "sky_urb01", "sky_c17_01" )
	ReplaceSky( pChunk, "sky_vert01", "sky_palace01" )
	ReplaceSky( pChunk, "wastelands001", "sky_wasteland01" )
	ReplaceSky( pChunk, "wastelands002", "sky_wasteland02" )
end

function UpdateTextures(pChunk) --Credits for the list: Bun, CrazzyBubba and Витой


    ReplaceTexture( pChunk, "BLACK", "TOOLS/TOOLSBLACK" )
	ReplaceTexture( pChunk, "HALFLIFE/AAATRIGGER", "TOOLS/TOOLSTRIGGER" )
	
	--Brick
	ReplaceTexture( pChunk, "BRICK/BRICKWALL001A", "BRICK/BRICKWALL001A_OLD" )
	ReplaceTexture( pChunk, "BRICK/BRICKWALL001C", "BRICK/BRICKWALL001C_OLD" )
	ReplaceTexture( pChunk, "BRICK/BRICKWALL001D", "SHADERTEST/SPHERICALENVMAPBLENDMASKEDBASETIMESLIGHTMAP" )
	ReplaceTexture( pChunk, "BRICK/BRICKWALL001G", "BRICK/BRICKWALL001G_OLD" )
	ReplaceTexture( pChunk, "BRICK/BRICKWALL002A", "STONE/STONEWALL036A" )
	ReplaceTexture( pChunk, "BRICK/BRICKWALL002B", "STONE/STONEWALL036B" )
	--ReplaceTexture( pChunk, "BRICK/BRICKWALL002C", "STONE/STONEWALL036C" ) --Does not exist
	ReplaceTexture( pChunk, "BRICK/BRICKWALL002D", "STONE/STONEWALL036D" )
	ReplaceTexture( pChunk, "BRICK/BRICKWALL005A", "STONE/STONEWALL033A_OLD" )
	ReplaceTexture( pChunk, "BRICK/BRICKWALL005B", "STONE/STONEWALL033B_OLD" )
	ReplaceTexture( pChunk, "BRICK/BRICKWALL005C", "STONE/STONEWALL033C_OLD" )
	ReplaceTexture( pChunk, "BRICK/BRICKWALL005F", "STONE/STONEWALL033F_OLD" )
	ReplaceTexture( pChunk, "BRICK/BRICKWALL005G", "STONE/STONEWALL033G_OLD" )
	ReplaceTexture( pChunk, "BRICK/BRICKWALL005H", "STONE/STONEWALL033H_OLD" )
	ReplaceTexture( pChunk, "BRICK/BRICKWALL005I", "STONE/STONEWALL033I_OLD" )
	ReplaceTexture( pChunk, "BRICK/BRICKWALL006A", "BRICK/BRICKWALL054A" )
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
	ReplaceTexture( pChunk, "BRICK/BRICKWALL012D", "DEV/BRICKWALL012D" )
	ReplaceTexture( pChunk, "BRICK/BRICKWALL012E", "DEV/BRICKWALL012E" )
	ReplaceTexture( pChunk, "BRICK/BRICKWALL013A", "STONE/STONEWALL034A" )
	ReplaceTexture( pChunk, "BRICK/BRICKWALL013B", "STONE/STONEWALL034B" )
	ReplaceTexture( pChunk, "BRICK/BRICKWALL013C", "STONE/STONEWALL034A" ) --Not original
	ReplaceTexture( pChunk, "BRICK/BRICKWALL014A", "STONE/STONEWALL035A" )
	ReplaceTexture( pChunk, "BRICK/BRICKWALL014B", "STONE/STONEWALL035B" )
	ReplaceTexture( pChunk, "BRICK/BRICKWALL020A", "STONE/STONEWALL018A" ) --Possibly not original
	ReplaceTexture( pChunk, "BRICK/BRICKWALL027A", "BRICK/BRICKWALL004A" ) --Not original
	ReplaceTexture( pChunk, "BRICK/BRICKWALL028A", "BRICK/BRICKWALL044A" ) --Not original
	ReplaceTexture( pChunk, "BRICK/BRICKWALL030A", "CONCRETE/CONCRETEWALL011C" ) --Not original
	ReplaceTexture( pChunk, "BRICK/BRICKWALL033J", "CONCRETE/CONCRETEWALL011B" ) --Not original
	ReplaceTexture( pChunk, "BRICK/BRICKWALL033K", "CONCRETE/CONCRETEWALL011D" ) --Not original
	ReplaceTexture( pChunk, "BRICK/BRICKWALL034A", "CONCRETE/CONCRETEWALL001A" ) --Not original
	ReplaceTexture( pChunk, "BRICK/BRICKWALL034B", "CONCRETE/CONCRETEWALL001B" ) --Not original
	ReplaceTexture( pChunk, "BRICK/BRICKWALL034C", "CONCRETE/CONCRETEWALL001C" ) --Not original
	ReplaceTexture( pChunk, "BRICK/BRICKWALL035B", "BRICK/BRICKWALL032B" ) --Not original
	ReplaceTexture( pChunk, "BRICK/BRICKWALL035C", "BRICK/BRICKWALL032C" ) --Not original
	ReplaceTexture( pChunk, "BRICK/BRICKWALL045B", "BRICK/BRICKWALL003D" )
	ReplaceTexture( pChunk, "BRICK/BRICKWALL045C", "BRICK/BRICKWALL003F" )
	ReplaceTexture( pChunk, "BRICK/BRICKWALL045D", "BRICK/BRICKWALL003C" )
	
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
	ReplaceTexture( pChunk, "CONCRETE/CONCRETEWALL013B", "CONCRETE/CONCRETEWALL013D" )
	ReplaceTexture( pChunk, "CONCRETE/CONCRETEWALL016C", "CONCRETE/CONCRETEWALL016C_OLD" )
	ReplaceTexture( pChunk, "CONCRETE/CONCRETEWALL017B", "CONCRETE/CONCRETEWALL017B_OLD" )
	ReplaceTexture( pChunk, "CONCRETE/CONCRETEWALL017C", "CONCRETE/CONCRETEWALL017C_OLD" )
	ReplaceTexture( pChunk, "CONCRETE/CONCRETEWALL020A", "CONCRETE/CONCRETEWALL020A_OLD" )
	ReplaceTexture( pChunk, "CONCRETE/CONCRETEWALL022A", "CONCRETE/CONCRETEWALL022A_OLD" )
	ReplaceTexture( pChunk, "CONCRETE/CONCRETEWALL026A", "CONCRETE/CONCRETEWALL026A_OLD" )
	ReplaceTexture( pChunk, "CONCRETE/CONCRETEWALL026B", "CONCRETE/CONCRETEWALL026B_OLD" )
	ReplaceTexture( pChunk, "CONCRETE/CONCRETEWALL026C", "CONCRETE/CONCRETEWALL026C_OLD" )
	ReplaceTexture( pChunk, "CONCRETE/CONCRETEWALL026D", "CONCRETE/CONCRETEWALL026D_OLD" )
	ReplaceTexture( pChunk, "CONCRETE/CONCRETEWALL060C", "CONCRETE/CONCRETEWALL060C_OLD" )
	
	--Dev
	
	--Glass
	ReplaceTexture( pChunk, "GLASS/GLASSWINDOW020A", "SHADERTEST/LIGHTMAPPEDBASEALPHAMASKEDENVMAPPEDTEXTURE" )
	ReplaceTexture( pChunk, "GLASS/GLASSWINDOW038A", "GLASS/GLASSWINDOW001A" ) --Not original
	ReplaceTexture( pChunk, "GLASS/GLASSWINDOW064A", "GLASS/GLASSWINDOW070A" ) 
	ReplaceTexture( pChunk, "GLASS/GLASSSKYBRIDGE003A", "BUILDING_TEMPLATE/BUILDING_SKYBRIDGE_TEMPLATE001A" ) --Not original
	
	--Lights
	
	--Metal
	ReplaceTexture( pChunk, "METAL/COMBINE_METAL01", "METAL/METALWALL065A" ) --Not original
	ReplaceTexture( pChunk, "METAL/METALDOOR012A", "METAL/METALDOOR012A_OLD" )
	ReplaceTexture( pChunk, "METAL/METALDOOR029A", "METAL/METALDOOR029A_OLD" )
	ReplaceTexture( pChunk, "METAL/FLOOR002A", "METAL/METALFLOOR002A" )
	ReplaceTexture( pChunk, "METAL/METALHULL006A", "METAL/METALHULL006A_OLD" )
    ReplaceTexture( pChunk, "METAL/METALHULL006B", "METAL/METALHULL006B_OLD" )
	ReplaceTexture( pChunk, "METAL/METALHULL006C", "METAL/METALHULL006C_OLD" )
	ReplaceTexture( pChunk, "METAL/METALPIPE003A", "METAL/METALPIPE003A_OLD" )
	ReplaceTexture( pChunk, "METAL/METALPIPE009A", "PROPS/METALPIPE009A" )
	ReplaceTexture( pChunk, "METAL/METALPIPE011A", "METAL/METALPIPE011A_OLD" )
	ReplaceTexture( pChunk, "METAL/METALPIPEENDCAP002B", "METAL/METALPIPEENDCAP001A" ) --Not original
	ReplaceTexture( pChunk, "METAL/METALRAIL001A", "METAL/METALRAIL001A_OLD" )
	ReplaceTexture( pChunk, "METAL/METALWALL007A", "METAL/METALWALL006B" )
	ReplaceTexture( pChunk, "METAL/METALWALL008A", "METAL/METALWALL010A" )
	ReplaceTexture( pChunk, "METAL/METALWALL012B", "METAL/METALWALL010B" )
	ReplaceTexture( pChunk, "METAL/METALWALL012C", "METAL/METALWALL010C" )
	ReplaceTexture( pChunk, "METAL/METALWALL018A", "METAL/METALWALL001A" )
	ReplaceTexture( pChunk, "METAL/METALWALL018B", "METAL/METALWALL001B" )
	ReplaceTexture( pChunk, "METAL/METALWALL018C", "METAL/METALWALL001C" )
	ReplaceTexture( pChunk, "METAL/METALWALL018D", "METAL/METALWALL001D" )
	ReplaceTexture( pChunk, "METAL/METALWALL046B", "METAL/METALWALL046A" )
	

	--Nature
	ReplaceTexture( pChunk, "NATURE/ROCKWALL012A", "NATURE/ROCKWALL018C" )

	--Plaster
	ReplaceTexture( pChunk, "PLASTER/PLASTERCOLUMN001A", "PLASTER/PLASTERWALL001H" )
	ReplaceTexture( pChunk, "PLASTER/PLASTERCOLUMN001B", "PLASTER/PLASTERWALL001I" )
	ReplaceTexture( pChunk, "PLASTER/PLASTERCOLUMN001C", "PLASTER/PLASTERWALL001J" )
	ReplaceTexture( pChunk, "PLASTER/PLASTERWALL002B", "PLASTER/PLASTERWALL002F" )
	ReplaceTexture( pChunk, "PLASTER/PLASTERWALL002C", "PLASTER/PLASTERWALL002A" )
	ReplaceTexture( pChunk, "PLASTER/PLASTERWALL002D", "PLASTER/PLASTERWALL002F" )
	ReplaceTexture( pChunk, "PLASTER/PLASTERWALL003F", "PLASTER/PLASTERWALL003B" )
	ReplaceTexture( pChunk, "PLASTER/PLASTERWALL010A", "STONE/STONEWALL033B" )
	ReplaceTexture( pChunk, "PLASTER/PLASTERWALL010B", "STONE/STONEWALL033C" )
	ReplaceTexture( pChunk, "PLASTER/PLASTERWALL010H", "PLASTER/PLASTERWALL010H_OLD" )
	ReplaceTexture( pChunk, "PLASTER/PLASTERWALL010I", "PLASTER/PLASTERWALL010I_OLD" )
	ReplaceTexture( pChunk, "PLASTER/PLASTERWALL010J", "PLASTER/PLASTERWALL010J_OLD" )
	ReplaceTexture( pChunk, "PLASTER/PLASTERWALL011A", "PLASTER/PLASTERWALL011A_OLD" )
	ReplaceTexture( pChunk, "PLASTER/PLASTERWALL011B", "PLASTER/PLASTERWALL011B_OLD" )
	ReplaceTexture( pChunk, "PLASTER/PLASTERWALL011C", "PLASTER/PLASTERWALL011C_OLD" )
	ReplaceTexture( pChunk, "PLASTER/PLASTERWALL012C", "METAL/METALWALL035A" ) --Speculation
	ReplaceTexture( pChunk, "PLASTER/PLASTERWALL017A", "STONE/STONEWALL009A" )
	ReplaceTexture( pChunk, "PLASTER/PLASTERWALL028E", "PLASTER/PLASTERWALL028I" )
	ReplaceTexture( pChunk, "PLASTER/PLASTERWALL033A", "PLASTER/PLASTERWALL030A" ) --Not original
	ReplaceTexture( pChunk, "PLASTER/PLASTERWALL039C", "PLASTER/PLASTERWALL039A" )
	ReplaceTexture( pChunk, "PLASTER/PLASTERWALL043C", "STONE/STONEWALL040E" )
	ReplaceTexture( pChunk, "PLASTER/PLASTERWALL043D", "STONE/STONEWALL040D" )
	ReplaceTexture( pChunk, "PLASTER/PLASTERWALL043E", "STONE/STONEWALL040E" )
	
	--Props
	ReplaceTexture( pChunk, "PROPS/BILLBOARD002A", "PROPS/SIGNBILLBOARD002A" )
	ReplaceTexture( pChunk, "PROPS/METALSIGN001A", "PROPS/METALSIGN001A_OLD" )
	ReplaceTexture( pChunk, "PROPS/METALSIGN001D", "PROPS/METALSIGN001D_OLD" )
	ReplaceTexture( pChunk, "PROPS/PAPERPOSTER001A", "PROPS/PAPERPOSTER001A_OLD" )
	ReplaceTexture( pChunk, "PROPS/PAPERPOSTER001B", "PROPS/PAPERPOSTER001B_OLD" )
	ReplaceTexture( pChunk, "PROPS/PAPERPOSTER002A", "PROPS/PAPERPOSTER002A_OLD" )
	ReplaceTexture( pChunk, "PROPS/PAPERPOSTER002B", "PROPS/PAPERPOSTER002B_OLD" )
	ReplaceTexture( pChunk, "PROPS/PAPERPOSTER003A", "PROPS/PAPERPOSTER003A_OLD" )
	ReplaceTexture( pChunk, "PROPS/PAPERPOSTER003B", "PROPS/PAPERPOSTER003B_OLD" )
	--ReplaceTexture( pChunk, "PROPS/PAPERPOSTER005A", "PROPS/PAPERPOSTER005A_OLD" )
	--ReplaceTexture( pChunk, "PROPS/PAPERPOSTER005B", "PROPS/PAPERPOSTER005B_OLD" )
	
	--Stone
	ReplaceTexture( pChunk, "STONE/STONEWALL001A", "DEV/DEV_STONEWALL001A" )
	ReplaceTexture( pChunk, "STONE/STONEWALL008A", "STONE/STONEWALL008C" )
    ReplaceTexture( pChunk, "STONE/STONEWALL008E", "STONE/STONEWALL008A" )
	ReplaceTexture( pChunk, "STONE/STONEWALL013A", "STONE/STONEWALL013D" )
	ReplaceTexture( pChunk, "STONE/STONEWALL013C", "STONE/STONEWALL013B" )
	ReplaceTexture( pChunk, "STONE/STONEWALL014A", "STONE/STONEWALL035A" )
	ReplaceTexture( pChunk, "STONE/STONEWALL014C", "STONE/STONEWALL035B" )
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
	
	--Tile
	--Wood
	ReplaceTexture( pChunk, "WOOD/WOODDOOR003A", "WOOD/WOODDOOR009A" )
	ReplaceTexture( pChunk, "WOOD/WOODWALL013C", "WOOD/WOODWALL013C_OLD" )
	ReplaceTexture( pChunk, "WOOD/WOODWALL015B", "WOOD/WOODWALL015B_OLD" )

end


function UpdateEntitiesName(pChunk)

	RenameEntity( pChunk, "aiscripted_sequence", "scripted_sequence" )
	RenameEntity( pChunk, "detail_prop", "prop_detail" )
	RenameEntity( pChunk, "dynamic_prop", "prop_dynamic" )
	RenameEntity( pChunk, "env_glow", "env_sprite" )
	RenameEntity( pChunk, "env_steamjet", "env_steam" )
--	RenameEntity( pChunk, "func_train", "func_tracktrain" ) -- ???
    RenameEntity( pChunk, "helicopter", "npc_helicopter" )
	RenameEntity( pChunk, "info_player_deathmatch", "info_player_start" )
	RenameEntity( pChunk, "light_glspot", "light_spot" )
	RenameEntity( pChunk, "model_studio", "cycler" )
	RenameEntity( pChunk, "momentary_door", "func_movelinear" ) 
	RenameEntity( pChunk, "monster_barnacle", "npc_barnacle" )
	RenameEntity( pChunk, "monster_combot", "npc_cscanner" )
	RenameEntity( pChunk, "monster_metropolice", "npc_metropolice" )
	RenameEntity( pChunk, "npc_metrocop", "npc_metropolice" )
	RenameEntity( pChunk, "npc_turret", "npc_turret_ceiling" )
	RenameEntity( pChunk, "physics_prop", "prop_physics" )
	RenameEntity( pChunk, "static_prop", "prop_static" )
	RenameEntity( pChunk, "trigger_brush", "trigger_multiple" )
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