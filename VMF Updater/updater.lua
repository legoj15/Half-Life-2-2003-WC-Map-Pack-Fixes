
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


end

function UpdateModels(pChunk)

	ReplaceModel( pChunk, "models/Citizen.mdl", "models/c17_male1.mdl" )

	ReplaceModel( pChunk, "models/lighting/W_LightBare.mdl", "models/props_c17/light_lightbare01_on.mdl" )

	ReplaceModel( pChunk, "models/Barrels/W_Barrel1.mdl", "models/props_c17/barrel01a.mdl" )
	ReplaceModel( pChunk, "models/Barrels/W_Barrel2.mdl", "models/props_c17/barrel02a.mdl" )
	ReplaceModel( pChunk, "models/Barrels/W_Barrel3.mdl", "models/props_c17/barrel04a.mdl" )
	ReplaceModel( pChunk, "models/Barrels/W_Barrel4.mdl", "models/props_c17/barrel04a.mdl" )
	ReplaceModel( pChunk, "models/Barrels/W_Barrel5.mdl", "models/props_c17/barrel05a.mdl" )

	ReplaceModel( pChunk, "models/Lighting/W_StreetLightOn01.mdl", "models/props_c17/light_streetlight02_on.mdl" )
	ReplaceModel( pChunk, "models/Lighting/W_StreetLightOff01.mdl", "models/props_c17/light_streetlight01_off.mdl" )
	ReplaceModel( pChunk, "models/Lighting/W_StreetLightOn02.mdl", "models/props_c17/light_streetlight02_on.mdl" )
	ReplaceModel( pChunk, "models/Lighting/W_StreetLightOff02.mdl", "models/props_c17/light_streetlight02_off.mdl" )

	ReplaceModel( pChunk, "models/Lighting/W_LightCage.mdl", "models/props_c17/light_lightcage01_on.mdl" )
	
	ReplaceModel( pChunk, "models/Lighting/W_StreetLampOn01.mdl", "models/props_c17/light_industrialbell01_on.mdl" )
	ReplaceModel( pChunk, "models/Lighting/W_StreetLampOff01.mdl", "models/props_c17/light_industrialbell01_off.mdl" )
	ReplaceModel( pChunk, "models/Lighting/W_StreetLampOn02.mdl", "models/props_c17/light_industrialbell02_on.mdl" )
	ReplaceModel( pChunk, "models/Lighting/W_StreetLampOff02.mdl", "models/props_c17/light_industrialbell02_off.mdl" )
	
	ReplaceModel( pChunk, "models/Lighting/W_DomeLightOn01.mdl", "models/props_c17/light_domelight01_on.mdl" )
	ReplaceModel( pChunk, "models/Lighting/W_DomeLightOff01.mdl", "models/props_c17/light_domelight01_off.mdl" )
	ReplaceModel( pChunk, "models/Lighting/W_DomeLightOn02.mdl", "models/props_c17/light_domelight01_on.mdl" )
	ReplaceModel( pChunk, "models/Lighting/W_DomeLightOff02.mdl", "models/props_c17/light_domelight02_off.mdl" )
	
	ReplaceModel( pChunk, "models/Furniture/W_Mailbox.mdl", "" )

	-- VXP: BuTou's list
	ReplaceModel( pChunk, "models/Lighting/W_DeckLightOn01.mdl", "models/props_c17/light_decklight01_on.mdl" )
	ReplaceModel( pChunk, "models/Lighting/W_DeckLightOff01.mdl", "models/props_c17/light_decklight01_off.mdl" )
--	ReplaceModel( pChunk, "models/Lighting/W_DomeLightOn01.mdl", "models/props_c17/light_domelight01_on.mdl" )
--	ReplaceModel( pChunk, "models/Lighting/W_DomeLightOff01.mdl", "models/props_c17/light_domelight01_off.mdl" )
--	ReplaceModel( pChunk, "models/Lighting/W_DomeLightOn02.mdl", "models/props_c17/light_domelight01_on.mdl" )
--	ReplaceModel( pChunk, "models/Lighting/W_DomeLightOff02.mdl", "models/props_c17/light_domelight02_off.mdl" )
--	ReplaceModel( pChunk, "models/Lighting/W_LightBare.mdl", "models/props_c17/light_lightbare01_on.mdl" )
--	ReplaceModel( pChunk, "models/Lighting/W_LightCage.mdl", "models/props_c17/light_lightcage01_on.mdl" )
	ReplaceModel( pChunk, "models/Lighting/W_LightShade2On.mdl", "models/props_wasteland/W_LightShade2On.mdl" )
	ReplaceModel( pChunk, "models/Lighting/W_LightShade2Off.mdl", "models/props_wasteland/W_LightShade2Off.mdl" )
	ReplaceModel( pChunk, "models/props_c17/apc_engine01.mdl", "models/props_c17/TrapPropeller_Engine.mdl" )
	ReplaceModel( pChunk, "models/props_c17/streetlight01a_on.mdl", "models/props_c17/light01a_on.mdl" )

	-- VXP: BuTou's list 2
	ReplaceModel( pChunk, "models/Building_details/W_RebarSmallNorm01a.mdl", "models/props_debris/Rebar_SmallNorm01a.mdl" )
	ReplaceModel( pChunk, "models/Building_details/W_RebarSmallNorm01b.mdl", "models/props_debris/Rebar_SmallNorm01b.mdl" )
	ReplaceModel( pChunk, "models/Building_details/W_RebarSmallNorm01c.mdl", "models/props_debris/Rebar_SmallNorm01c.mdl" )
	ReplaceModel( pChunk, "models/Building_details/W_RebarMedNorm01a.mdl", "models/props_debris/Rebar_MedNorm01a.mdl" )
	ReplaceModel( pChunk, "models/Building_details/W_RebarMedNorm01b.mdl", "models/props_debris/Rebar_MedNorm01b.mdl" )
	ReplaceModel( pChunk, "models/Building_details/W_RebarMedNorm01c.mdl", "models/props_debris/Rebar_MedNorm01c.mdl" )
	ReplaceModel( pChunk, "models/Building_details/W_RebarMedNorm02a.mdl", "models/props_debris/Rebar_MedNorm02a.mdl" )
	ReplaceModel( pChunk, "models/Building_details/W_RebarMedNorm02b.mdl", "models/props_debris/Rebar_MedNorm02b.mdl" )
	ReplaceModel( pChunk, "models/Building_details/W_RebarMedNorm02c.mdl", "models/props_debris/Rebar_MedNorm02c.mdl" )
	ReplaceModel( pChunk, "models/Building_details/W_RebarLargeThick01a.mdl", "models/props_debris/Rebar_LargeThick01a.mdl" )
	ReplaceModel( pChunk, "models/Furniture/W_Clock.mdl", "models/props_c17/clock01.mdl" )
	ReplaceModel( pChunk, "models/Furniture/W_GarbCan.mdl", "models/props_c17/garbagecan01.mdl" )
	ReplaceModel( pChunk, "models/Ship/W_MapTube.mdl", "models/props_borealis/maptube01.mdl" )
	ReplaceModel( pChunk, "models/Electronics/W_Speaker01.mdl", "models/props_c17/trainspeaker01.mdl" )
	ReplaceModel( pChunk, "models/Lighting/W_IndustrialBell01On.mdl", "models/props_c17/light_industrialbell01_on.mdl" )
	ReplaceModel( pChunk, "models/Lighting/W_IndustrialBell01Off.mdl", "models/props_c17/light_industrialbell01_off.mdl" )
	ReplaceModel( pChunk, "models/Lighting/W_IndustrialBell02On.mdl", "models/props_c17/light_industrialbell02_on.mdl" )
	ReplaceModel( pChunk, "models/Lighting/W_IndustrialBell02Off.mdl", "models/props_c17/light_industrialbell02_off.mdl" )

	-- VXP: BuTou's list 3
	ReplaceModel( pChunk, "models/Lighting/W_CageLightOn01.mdl", "models/props_c17/light_cagelight01_on.mdl" )
	ReplaceModel( pChunk, "models/Lighting/W_FluorescentOn01.mdl", "models/props_c17/light_fluorescent01_on.mdl" )
	ReplaceModel( pChunk, "models/Lighting/W_FluorescentOff01.mdl", "models/props_c17/light_fluorescent01_off.mdl" )
	ReplaceModel( pChunk, "models/Lighting/W_GlobeLightOn01.mdl", "models/props_c17/light_globelight01_on.mdl" )
	ReplaceModel( pChunk, "models/Lighting/W_GlobeLightOff01.mdl", "models/props_c17/light_globelight01_off.mdl" )
--	ReplaceModel( pChunk, "models/Building_details/W_Antenna01.mdl", "models/props_borealis/antenna001.mdl" ) -- Not original
	ReplaceModel( pChunk, "models/Furniture/W_Chair.mdl", "models/props_c17/chair02a.mdl" )

	-- VXP: BuTou's list 4
	ReplaceModel( pChunk, "models/Building_details/W_RebarMedThin02b.mdl", "models/props_debris/Rebar_MedThin02b.mdl" ) -- Not original
	ReplaceModel( pChunk, "models/Pipes/W_Pipe_1b_curve_halfsize.mdl", "models/props_c17/pipe02_90degree01.mdl" ) -- Not original
	ReplaceModel( pChunk, "models/Pipes/W_Pipe_1c_curve_quartersize.mdl", "models/props_c17/pipe01_90degree01.mdl" ) -- Not original
	ReplaceModel( pChunk, "models/Pipes/W_Pipe_2a_45curve.mdl", "models/props_c17/pipe03_45degree01.mdl" ) -- Not original
	ReplaceModel( pChunk, "models/Pipes/W_Pipe_2b_45curve_halfsize.mdl", "models/props_c17/pipe02_45degree01.mdl" ) -- Not original
	ReplaceModel( pChunk, "models/Pipes/W_Pipe_4a_Yjoint.mdl", "models/props_c17/pipe03_yjoint01.mdl" ) -- Not original
	ReplaceModel( pChunk, "models/Pipes/W_Pipe_4b_Yjoint_halfsize.mdl", "models/props_c17/pipe02_yjoint01.mdl" ) -- Not original
	ReplaceModel( pChunk, "models/c17_props/W_LoudSpeaker01.mdl", "models/props_wasteland/speakercluster01a.mdl" ) -- Not original
	ReplaceModel( pChunk, "models/Building_details/W_RebarMedThin02a.mdl", "models/props_debris/Rebar_MedThin02a.mdl" )
	ReplaceModel( pChunk, "models/Building_details/W_RebarMedThin02c.mdl", "models/props_debris/Rebar_MedThin02c.mdl" )
	ReplaceModel( pChunk, "models/Lighting/W_TrafficLight.mdl", "models/props_c17/Traffic_Light001a.mdl" )
	ReplaceModel( pChunk, "models/Barrels/W_Barrel2.mdl", "models/props_c17/barrel02a.mdl" )
	ReplaceModel( pChunk, "models/Building_details/W_ValveWheel01.mdl", "models/props_borealis/valvewheel002b.mdl" ) -- Not original
	ReplaceModel( pChunk, "models/Sentry01/Sentry01Gun.mdl", "models/Sentry_Guns/Sentry01Gun.mdl" )
	ReplaceModel( pChunk, "models/Sentry01/Sentry01Post.mdl", "models/Sentry_Guns/Sentry01Post.mdl" )
	ReplaceModel( pChunk, "models/Sentry01/Sentry01Base.mdl", "models/Sentry_Guns/Sentry01Base.mdl" )

	-- legoj15
	ReplaceModel( pChunk, "models/Pipes/W_Pipe_1b_curve_halfsize.mdl", "models/props_c17/pipe02_90degree01.mdl" ) -- Close probably
	ReplaceModel( pChunk, "models/Pipes/W_Pipe_1a_curve.mdl", "models/props_c17/pipe03_90degree01.mdl" ) -- Close probably
	ReplaceModel( pChunk, "models/Lighting/W_LightBareOn.mdl", "models/props_c17/light_lightbare01_on.mdl" ) -- Close probably
end

function UpdateSky(pChunk)

	ReplaceSky( pChunk, "sky_urb01", "sky_c17_02" )
end

function UpdateTextures(pChunk)

	--Brick
--	ReplaceTexture( pChunk, "BRICK/BRICKFLOOR003A", "BRICK/BRICKFLOOR002A" )
	ReplaceTexture( pChunk, "BRICK/BRICKWALL001G", "BRICK/BRICKWALL001A" )	
	ReplaceTexture( pChunk, "BRICK/BRICKWALL001H", "BRICK/BRICKWALL001A" )	
	ReplaceTexture( pChunk, "BRICK/BRICKWALL001l", "BRICK/BRICKWALL001A" )	
	ReplaceTexture( pChunk, "BRICK/BRICKWALL001M", "BRICK/BRICKWALL001A" )	
	ReplaceTexture( pChunk, "BRICK/BRICKWALL002B", "BRICK/BRICKWALL002A" )
	ReplaceTexture( pChunk, "BRICK/BRICKWALL002C", "BRICK/BRICKWALL002A" )
	ReplaceTexture( pChunk, "BRICK/BRICKWALL002D", "BRICK/BRICKWALL002A" )	
	ReplaceTexture( pChunk, "BRICK/BRICKWALL004D", "BRICK/BRICKWALL004A" )
	ReplaceTexture( pChunk, "BRICK/BRICKWALL005B", "BRICK/BRICKWALL005A" )
	ReplaceTexture( pChunk, "BRICK/BRICKWALL005D", "BRICK/BRICKWALL005A" )
	ReplaceTexture( pChunk, "BRICK/BRICKWALL005E", "BRICK/BRICKWALL005A" )
	ReplaceTexture( pChunk, "BRICK/BRICKWALL005F", "BRICK/BRICKWALL005A" )
	ReplaceTexture( pChunk, "BRICK/BRICKWALL005H", "BRICK/BRICKWALL005A" )
	ReplaceTexture( pChunk, "BRICK/BRICKWALL007D", "BRICK/BRICKWALL007A" )
	ReplaceTexture( pChunk, "BRICK/BRICKWALL007E", "BRICK/BRICKWALL007A" )
	ReplaceTexture( pChunk, "BRICK/BRICKWALL007F", "BRICK/BRICKWALL007A" )
	ReplaceTexture( pChunk, "BRICK/BRICKWALL008E", "BRICK/BRICKWALL008A" )
	ReplaceTexture( pChunk, "BRICK/BRICKWALL008F", "BRICK/BRICKWALL008A" )	
	ReplaceTexture( pChunk, "BRICK/BRICKWALL011D", "BRICK/BRICKWALL011A" )
	ReplaceTexture( pChunk, "BRICK/BRICKWALL011E", "BRICK/BRICKWALL011A" )
	ReplaceTexture( pChunk, "BRICK/BRICKWALL011F", "BRICK/BRICKWALL011A" )
	ReplaceTexture( pChunk, "BRICK/BRICKWALL011G", "BRICK/BRICKWALL011A" )
	ReplaceTexture( pChunk, "BRICK/BRICKWALL011H", "BRICK/BRICKWALL011A" )	
	ReplaceTexture( pChunk, "BRICK/BRICKWALL011I", "BRICK/BRICKWALL011A" )	
	ReplaceTexture( pChunk, "BRICK/BRICKWALL012F", "BRICK/BRICKWALL012A" )
	ReplaceTexture( pChunk, "BRICK/BRICKWALL020C", "BRICK/BRICKWALL020A" )	
	ReplaceTexture( pChunk, "BRICK/BRICKWALL022B", "BRICK/BRICKWALL022A" )	
	ReplaceTexture( pChunk, "BRICK/BRICKWALL022C", "BRICK/BRICKWALL022A" )
	ReplaceTexture( pChunk, "BRICK/BRICKWALL024C", "BRICK/BRICKWALL024A" )
	ReplaceTexture( pChunk, "BRICK/BRICKWALL025E", "BRICK/BRICKWALL025A" )
	ReplaceTexture( pChunk, "BRICK/BRICKWALL025F", "BRICK/BRICKWALL025B" )
	ReplaceTexture( pChunk, "BRICK/BRICKWALL025G", "BRICK/BRICKWALL025A" )	
	ReplaceTexture( pChunk, "BRICK/BRICKWALL025H", "BRICK/BRICKWALL025A" )	
	ReplaceTexture( pChunk, "BRICK/BRICKWALL030B", "BRICK/BRICKWALL030A" )
	ReplaceTexture( pChunk, "BRICK/BRICKWALL030C", "BRICK/BRICKWALL030A" )
	ReplaceTexture( pChunk, "BRICK/BRICKWALL030D", "BRICK/BRICKWALL030A" )
	ReplaceTexture( pChunk, "BRICK/BRICKWALL030E", "BRICK/BRICKWALL030A" )
	ReplaceTexture( pChunk, "BRICK/BRICKWALL030F", "BRICK/BRICKWALL030A" )
	ReplaceTexture( pChunk, "BRICK/BRICKWALL030G", "BRICK/BRICKWALL030A" )
	ReplaceTexture( pChunk, "BRICK/BRICKWALL030H", "BRICK/BRICKWALL030A" )
	ReplaceTexture( pChunk, "BRICK/BRICKWALL030I", "BRICK/BRICKWALL030A" )
	ReplaceTexture( pChunk, "BRICK/BRICKWALL030J", "BRICK/BRICKWALL030A" )
	ReplaceTexture( pChunk, "BRICK/BRICKWALL030K", "BRICK/BRICKWALL030A" )
	ReplaceTexture( pChunk, "BRICK/BRICKWALL031H", "BRICK/BRICKWALL031A" )	
	ReplaceTexture( pChunk, "BRICK/BRICKWALL033D", "BRICK/BRICKWALL033A" )	
	ReplaceTexture( pChunk, "BRICK/BRICKWALL033J", "BRICK/BRICKWALL033A" )
	ReplaceTexture( pChunk, "BRICK/BRICKWALL033K", "BRICK/BRICKWALL033A" )
	ReplaceTexture( pChunk, "BRICK/BRICKWALL035B", "BRICK/BRICKWALL035A" )
	ReplaceTexture( pChunk, "BRICK/BRICKWALL035C", "BRICK/BRICKWALL035A" )
	ReplaceTexture( pChunk, "BRICK/BRICKWALL037E", "BRICK/BRICKWALL037A" )
	ReplaceTexture( pChunk, "BRICK/BRICKWALL039B", "BRICK/BRICKWALL039A" )
	ReplaceTexture( pChunk, "BRICK/BRICKWALL039C", "BRICK/BRICKWALL039A" )	
	ReplaceTexture( pChunk, "BRICK/BRICKWALL039D", "BRICK/BRICKWALL039A" )	
	ReplaceTexture( pChunk, "BRICK/BRICKWALL039E", "BRICK/BRICKWALL039A" )	
	ReplaceTexture( pChunk, "BRICK/BRICKWALL039F", "BRICK/BRICKWALL039A" )
	ReplaceTexture( pChunk, "BRICK/BRICKWALL040H", "BRICK/BRICKWALL040G" )
	ReplaceTexture( pChunk, "BRICK/BRICKWALL044B", "BRICK/BRICKWALL044A" )
--	ReplaceTexture( pChunk, "BRICK/BRICKWALL050C", "BRICK/BRICKWALL053A" ) -- i don't know
	
	--BUILDINGS_SM
	ReplaceTexture( pChunk, "BUILDINGS_SM/BRICKWALL006A_SM", "BRICK/BRICKWALL006A" )
	ReplaceTexture( pChunk, "BUILDINGS_SM/BRICKWALL011E_SM", "BRICK/BRICKWALL011A" )
	ReplaceTexture( pChunk, "BUILDINGS_SM/BRICKWALL012C_SM", "BRICK/BRICKWALL011C" )
	ReplaceTexture( pChunk, "BUILDINGS_SM/METALWALL006A_SM", "METAL/METALWALL006A" )
	ReplaceTexture( pChunk, "BUILDINGS_SM/METALWALL020A_SM", "METAL/METALWALL020A" )
	
	--Concrete
	ReplaceTexture( pChunk, "CONCRETE/CONCRETEFLOOR001B", "DECALS/DECAL_CRATER001A" )
	ReplaceTexture( pChunk, "CONCRETE/CONCRETEFLOOR003D", "CONCRETE/CONCRETEFLOOR003A" )
	ReplaceTexture( pChunk, "CONCRETE/CONCRETEFLOOR004B", "CONCRETE/CONCRETEFLOOR004A" )
	ReplaceTexture( pChunk, "CONCRETE/CONCRETEFLOOR021B", "CONCRETE/CONCRETEFLOOR021A" )
	ReplaceTexture( pChunk, "CONCRETE/CONCRETEFLOOR021D", "CONCRETE/CONCRETEFLOOR021A" )
	ReplaceTexture( pChunk, "CONCRETE/CONCRETEFLOOR024C", "CONCRETE/CONCRETEFLOOR024A" )
	ReplaceTexture( pChunk, "CONCRETE/CONCRETEFLOOR024D", "CONCRETE/CONCRETEFLOOR024A" )
	ReplaceTexture( pChunk, "CONCRETE/CONCRETEFLOOR026B", "CONCRETE/CONCRETEFLOOR026A" )
	ReplaceTexture( pChunk, "CONCRETE/CONCRETEWALL003C", "CONCRETE/CONCRETEWALL003A" )
--	ReplaceTexture( pChunk, "CONCRETE/CONCRETEWALL007C", "CONCRETE/CONCRETEWALL003A" ) --found in retail
	ReplaceTexture( pChunk, "CONCRETE/CONCRETEWALL012F", "CONCRETE/CONCRETEWALL012B" )
	ReplaceTexture( pChunk, "CONCRETE/CONCRETEWALL015F", "CONCRETE/CONCRETEWALL015A" )
--	ReplaceTexture( pChunk, "CONCRETE/CONCRETEWALL030C", "CONCRETE/CONCRETEWALL003A" ) --found in retail
--	ReplaceTexture( pChunk, "CONCRETE/CONCRETEWALL036B", "CONCRETE/CONCRETEWALL003A" ) --found in retail
	ReplaceTexture( pChunk, "CONCRETE/CONCRETEWALL049A", "CONCRETE/CONCRETEWALL049B" )
	ReplaceTexture( pChunk, "CONCRETE/CONCRETEWALL060B", "CONCRETE/CONCRETEWALL060A" )
	
	--Dev
	ReplaceTexture( pChunk, "DEV/DEV_WATER", "DEV/DEV_WATER2" )
	ReplaceTexture( pChunk, "DEV/DEV_WATERBLACK01", "DEV/DEV_WATER2" )
	ReplaceTexture( pChunk, "DEV/NETHER01_WATER", "DEV/DEV_WATER2" )
	
	--Glass
	ReplaceTexture( pChunk, "GLASS/GLASSPIPE001B", "PROPS/PLASTICPIPE002A" )
	ReplaceTexture( pChunk, "GLASS/GLASSPIPE001D", "PROPS/PLASTICPIPE002A" )
	ReplaceTexture( pChunk, "GLASS/GLASSPIPE001E", "METAL/METALPIPE001A" )
	ReplaceTexture( pChunk, "GLASS/GLASSPIPE001F", "PROPS/PLASTICPIPE002A" )
	ReplaceTexture( pChunk, "GLASS/GLASSSKYBRIDGE003A", "GLASS/GLASSSKYBRIDGE001A" )
	ReplaceTexture( pChunk, "GLASS/GLASSWINDOW007C", "GLASS/GLASSWINDOW007A" )	
	ReplaceTexture( pChunk, "GLASS/GLASSWINDOW019B", "GLASS/GLASSWINDOW019A" )	
	ReplaceTexture( pChunk, "GLASS/GLASSWINDOW033B", "GLASS/GLASSWINDOW033A" )
	ReplaceTexture( pChunk, "GLASS/GLASSWINDOW033C", "GLASS/GLASSWINDOW033A" )
	ReplaceTexture( pChunk, "GLASS/GLASSWINDOW038A", "GLASS/GLASSWINDOW035A" )
	ReplaceTexture( pChunk, "GLASS/GLASSWINDOW039A", "GLASS/GLASSWINDOW035A" )
	ReplaceTexture( pChunk, "GLASS/GLASSWINDOW045B", "GLASS/GLASSWINDOW045A" )
	ReplaceTexture( pChunk, "GLASS/GLASSWINDOW049A", "GLASS/GLASSWINDOW048A" )
	ReplaceTexture( pChunk, "GLASS/GLASSWINDOW063A", "GLASS/GLASSWINDOW066F" )
	ReplaceTexture( pChunk, "GLASS/GLASSWINDOW066B", "GLASS/GLASSWINDOW066F" )
	ReplaceTexture( pChunk, "GLASS/GLASSWINDOW071A", "GLASS/GLASSWINDOW071B" )
	
	--Lights
--	ReplaceTexture( pChunk, "LIGHTS/FLUORESCENTWARM001A", "LIGHTS/FLUORESCENTWARM001A" ) --Found in retail
	ReplaceTexture( pChunk, "LIGHTS/HALOGENCOOL001A", "LIGHTS/HIDCOOL001B" )
--	ReplaceTexture( pChunk, "LIGHTS/HIDCOOL001A, "LIGHTS/HIDCOOL001A" ) --Found in retail
--	ReplaceTexture( pChunk, "LIGHTS/HIDWARM001A, "LIGHTS/HIDWARM001A" ) --Found in retail
--	ReplaceTexture( pChunk, "LIGHTS/INCANDESCENTCOOL001A, "LIGHTS/INCANDESCENTCOOL001A" ) --Found in retail
--	ReplaceTexture( pChunk, "LIGHTS/INCANDESCENTWARM001A, "LIGHTS/INCANDESCENTWARM001A" ) --Found in retail
	
	--Metal
	ReplaceTexture( pChunk, "METAL/COMBINE_METAL01", "METAL/METALCOMBINE001" )
	ReplaceTexture( pChunk, "METAL/COMBINE_METAL02", "METAL/METALCOMBINE002" )	
	ReplaceTexture( pChunk, "METAL/COMBINE_METAL02B", "METAL/METALCOMBINE002" )
	ReplaceTexture( pChunk, "METAL/COMBINE_METAL02C", "METAL/METALCOMBINE002" )
	ReplaceTexture( pChunk, "METAL/FLOOR002A", "METAL/METALFLOOR002A" )
	ReplaceTexture( pChunk, "METAL/METALCEILING001A", "METAL/METALCEILING005A" )
	ReplaceTexture( pChunk, "METAL/METALCEILING003A", "METAL/METALCEILING005A" )
	ReplaceTexture( pChunk, "METAL/METALCEILING006A", "METAL/METALCEILING005A" )
	ReplaceTexture( pChunk, "METAL/METALDOOR039B", "METAL/METALDOOR039A" )
	ReplaceTexture( pChunk, "METAL/METALDOOR044C", "METAL/METALDOOR044A" )
	ReplaceTexture( pChunk, "METAL/METALDOOR044D", "METAL/METALDOOR044A" )
	ReplaceTexture( pChunk, "METAL/METALGRATE001B", "METAL/METALGRATE001A" )
	ReplaceTexture( pChunk, "METAL/METALHULL001B", "METAL/METALHULL002A" )	
	ReplaceTexture( pChunk, "METAL/METALHULL002D", "METAL/METALHULL002A")
	ReplaceTexture( pChunk, "METAL/METALHULL005B", "METAL/METALHULL005A")
	ReplaceTexture( pChunk, "METAL/METALHULL006A", "METAL/METALHULL006C")
	ReplaceTexture( pChunk, "METAL/METALHULL007E", "METAL/METALHULL007A")
	ReplaceTexture( pChunk, "METAL/METALPIPE007C", "METAL/METALPIPE007A" )
	ReplaceTexture( pChunk, "METAL/METALLADDER001B", "METAL/METALLADDER001A" )
	ReplaceTexture( pChunk, "METAL/METALPIPEENDCAP002A", "METAL/METALPIPEENDCAP001A" )
	ReplaceTexture( pChunk, "METAL/METALPIPEENDCAP002B", "METAL/METALPIPEENDCAP001A" )
--	ReplaceTexture( pChunk, "METAL/METALPIPENETHER", "METAL/METALPIPE001A" ) -- that is this ?
	ReplaceTexture( pChunk, "METAL/METALROOF005B", "METAL/METALROOF005A" )
	ReplaceTexture( pChunk, "METAL/METALSTAIR001B", "METAL/METALSTAIR001A" ) 
	ReplaceTexture( pChunk, "METAL/METALTARCH001D", "METAL/METALARCH001A" )
	ReplaceTexture( pChunk, "METAL/METALWALL001E", "METAL/METALWALL001A" )
--	ReplaceTexture( pChunk, "METAL/METALWALL004B", "METAL/METALWALL004B" ) --Found in retail
	ReplaceTexture( pChunk, "METAL/METALWALL005A", "METAL/METALWALL005B" )
	ReplaceTexture( pChunk, "METAL/METALWALL009B", "METAL/METALWALL009A" )
	ReplaceTexture( pChunk, "METAL/METALWALL009C", "METAL/METALWALL009A" )
	ReplaceTexture( pChunk, "METAL/METALWALL012C", "METAL/METALWALL012B" )
	ReplaceTexture( pChunk, "METAL/METALWALL039B", "METAL/METALWALL039A" )
	ReplaceTexture( pChunk, "METAL/METALWALL040A", "METAL/METALWALL041A" )
	ReplaceTexture( pChunk, "METAL/METALWALL042B", "METAL/METALWALL042A" )
	ReplaceTexture( pChunk, "METAL/METALWALL042C", "METAL/METALWALL042A" )
	ReplaceTexture( pChunk, "METAL/METALWALL042E", "METAL/METALWALL042A" )
	ReplaceTexture( pChunk, "METAL/METALWALL043B", "METAL/METALWALL043A" )
	ReplaceTexture( pChunk, "METAL/METALWALL043C", "METAL/METALWALL043A" )
	ReplaceTexture( pChunk, "METAL/METALWALL043D", "METAL/METALWALL043A" )
	ReplaceTexture( pChunk, "METAL/METALWALL044B", "METAL/METALWALL044A" )
	ReplaceTexture( pChunk, "METAL/METALWALL044C", "METAL/METALWALL044A" )
	ReplaceTexture( pChunk, "METAL/METALWALL044D", "METAL/METALWALL044A" )	
	ReplaceTexture( pChunk, "METAL/METALWALL046B", "METAL/METALWALL046A" )
	ReplaceTexture( pChunk, "METAL/METALWALL047C", "METAL/METALWALL047A" )
	ReplaceTexture( pChunk, "METAL/METALWALL053B", "METAL/METALWALL053A" )	
	ReplaceTexture( pChunk, "METAL/METALWALL053C", "METAL/METALWALL053A" )
	ReplaceTexture( pChunk, "METAL/METALWALL053D", "METAL/METALWALL053A" )
	ReplaceTexture( pChunk, "METAL/METALWALL054E", "METAL/METALWALL054A" )
	ReplaceTexture( pChunk, "METAL/METALWALL054I", "METAL/METALWALL054A" )
	ReplaceTexture( pChunk, "METAL/METALWALL065C", "METAL/METALWALL065B" )
	ReplaceTexture( pChunk, "METAL/METALWALL065G", "METAL/METALWALL065B" )
	ReplaceTexture( pChunk, "METAL/METALWALL065H", "METAL/METALWALL065B" )
	ReplaceTexture( pChunk, "METAL/METALWALL065I", "METAL/METALWALL065B" )
	ReplaceTexture( pChunk, "METAL/METALWALL065J", "METAL/METALWALL065B" )
	ReplaceTexture( pChunk, "METAL/METALWALL071B", "METAL/METALWALL071A" )
	ReplaceTexture( pChunk, "METAL/METALWALL071E", "METAL/METALWALL071A" )
	ReplaceTexture( pChunk, "METAL/METALWALL073A", "METAL/METALWALL074A" )
	ReplaceTexture( pChunk, "METAL/METALWALL073B", "METAL/METALWALL074A" )
	ReplaceTexture( pChunk, "METAL/METALWALL075B", "METAL/METALWALL075A" )
	ReplaceTexture( pChunk, "METAL/METALWALL076C", "METAL/METALWALL076A" )
	ReplaceTexture( pChunk, "METAL/METALWALL078A", "METAL/METALWALL076A" )
	ReplaceTexture( pChunk, "METAL/METALWALL078B", "METAL/METALWALL076A" )
	ReplaceTexture( pChunk, "METAL/METALWALL078C", "METAL/METALWALL076A" )
	ReplaceTexture( pChunk, "METAL/METALWALL079A", "METAL/METALWALL074A" )
	ReplaceTexture( pChunk, "METAL/METALWALL079C", "METAL/METALWALL076A" )
	ReplaceTexture( pChunk, "METAL/METALWALL080A", "METAL/METALWALL080B" )
--	ReplaceTexture( pChunk, "METAL/METALWALL080B", "METAL/METALWALL080B" ) --Found in retail -- it's another ???
	ReplaceTexture( pChunk, "METAL/METALWALL080C", "METAL/METALWALL080C" )
	ReplaceTexture( pChunk, "METAL/METALWALL081A", "METAL/METALWALL080B" )
	ReplaceTexture( pChunk, "METAL/METALWALL081C", "METAL/METALWALL080B" )
	ReplaceTexture( pChunk, "METAL/METALWALL090B", "METAL/METALWALL090A" )
	ReplaceTexture( pChunk, "METAL/METALVENT008A", "METAL/METALVENT001A" )

	--Nature
--	ReplaceTexture( pChunk, "NATURE/BLENDGRASSCOBBLE001A", "NATURE/BLENDGRASSCOBBLE001A" ) --Found in retail
	ReplaceTexture( pChunk, "NATURE/DIRTJUNK", "NATURE/BLENDDIRTROCKS001A" ) -- Unknown texture
	ReplaceTexture( pChunk, "NATURE/DIRTROCK", "NATURE/BLENDDIRTROCKS001A" )
	ReplaceTexture( pChunk, "NATURE/QUARRYROCKDIRT001A", "NATURE/BLENDDIRTROCKS001A" )
	ReplaceTexture( pChunk, "NATURE/ROCKWALL08A", "NATURE/ROCKWALL008A" )
	ReplaceTexture( pChunk, "NATURE/ROCKWALL09B", "NATURE/ROCKWALL009B" )
	ReplaceTexture( pChunk, "NATURE/ROCKWALL010A", "NATURE/ROCKWALL010A" )
	ReplaceTexture( pChunk, "NATURE/ROCKWALL011A", "NATURE/ROCKWALL011A" )
	ReplaceTexture( pChunk, "NATURE/ROCKWALL14A", "NATURE/ROCKWALL014A" )
	ReplaceTexture( pChunk, "NATURE/ROCKWALL16A", "NATURE/ROCKWALL016A" )
	ReplaceTexture( pChunk, "NATURE/SAND_ROCK_BLEND", "NATURE/BLENDSANDROCK004A" )
	ReplaceTexture( pChunk, "NATURE/WATER_BOREALIS02", "NATURE/WATER_BOREALIS01" )
	ReplaceTexture( pChunk, "NATURE/WATER_VERT01", "NATURE/WATER_CANALS03" )
	ReplaceTexture( pChunk, "NATURE/WATER_WASTELAND001", "NATURE/WATER_WASTELAND002" )

	--Plaster
	ReplaceTexture( pChunk, "PLASTER/PLASTERCOLUMN001A", "STONE/STONECOLUMN001A" )
	ReplaceTexture( pChunk, "PLASTER/PLASTERCOLUMN001B", "STONE/STONECOLUMN001B" )
	ReplaceTexture( pChunk, "PLASTER/PLASTERCOLUMN001C", "STONE/STONECOLUMN001A" )
	ReplaceTexture( pChunk, "PLASTER/PLASTERCORNICE001A", "PLASTER/PLASTERWALL001A" ) -- Unknown texture
	ReplaceTexture( pChunk, "PLASTER/PLASTERCORNICE001B", "PLASTER/PLASTERWALL001A" ) -- Unknown texture
	ReplaceTexture( pChunk, "PLASTER/PLASTERRELIEF001A", "PLASTER/PLASTERWALL001A" ) -- Unknown texture
	ReplaceTexture( pChunk, "PLASTER/PLASTERRELIEF005A", "PLASTER/PLASTERWALL001A" ) -- Unknown texture
	ReplaceTexture( pChunk, "PLASTER/PLASTERWALL012C", "PLASTER/PLASTERWALL012A" )
	ReplaceTexture( pChunk, "PLASTER/PLASTERWALL016B", "PLASTER/PLASTERWALL016A" )
--	ReplaceTexture( pChunk, "PLASTER/PLASTERWALL018D", "PLASTER/PLASTERWALL018D" ) --Found in retail
	ReplaceTexture( pChunk, "PLASTER/PLASTERWALL037D", "PLASTER/PLASTERWALL037B" )
--	ReplaceTexture( pChunk, "PLASTER/PLASTERWALL040C", "PLASTER/PLASTERWALL040C" ) --Found in retail
--	ReplaceTexture( pChunk, "PLASTER/PLASTERWALL045D", "PLASTER/PLASTERWALL045D" ) --Found in retail

	--Props
	ReplaceTexture( pChunk, "PROPS/BILLBOARD002A", "PROPS/SIGNBILLBOARD002A" )
	ReplaceTexture( pChunk, "PROPS/BILLBOARD002B", "PROPS/SIGNBILLBOARD005A" )
	
	--Stone
--	ReplaceTexture( pChunk, "STONE/DIRTROAD001A", "STONE/STONEFLOOR007A" )
	ReplaceTexture( pChunk, "STONE/STONECORNICE001A", "STONE/STONEWALL013A" ) -- Unknown texture

	--Tile
--	ReplaceTexture( pChunk, "TILE/TILEFLOOR016A", "TILE/TILEFLOOR016A" ); --Found in retail
	ReplaceTexture( pChunk, "TILE/TILEWALL007B", "TILE/TILEWALL007A" );
	ReplaceTexture( pChunk, "TILE/TILEWALL007C", "TILE/TILEWALL007A" );
	ReplaceTexture( pChunk, "TILE/TILEWALL011A", "TILE/TILEWALL006A" );	

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