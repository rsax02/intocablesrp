local Scaleform
local ClickReturn

function OpenScaleform(GameLives, GameBackground, GameLastText, GameTimeout, ReturnDelay)
	local Aproved = false
	local GamePassword = string.upper(ESX.GetRandomString(8))
	Scaleform = RequestScaleformMovieInteractive("HACKING_PC")
	
    while not HasScaleformMovieLoaded(Scaleform) do
        Citizen.Wait(0)
    end
    PushScaleformMovieFunction(Scaleform, "SET_LABELS")
    PushScaleformMovieFunctionParameterString("Local Disk (C:)")
    PushScaleformMovieFunctionParameterString("Network")
    PushScaleformMovieFunctionParameterString("USB (Z:)")
    PushScaleformMovieFunctionParameterString("HackConnect_v1.97")
    PushScaleformMovieFunctionParameterString("BruteForcer_v2.34")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(Scaleform, "SET_BACKGROUND")
    PushScaleformMovieFunctionParameterInt(GameBackground)
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(Scaleform, "ADD_PROGRAM")
    PushScaleformMovieFunctionParameterFloat(1.0)
    PushScaleformMovieFunctionParameterFloat(4.0)
    PushScaleformMovieFunctionParameterString("This PC")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(Scaleform, "SET_COLUMN_SPEED")
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(255)
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(Scaleform, "SET_COLUMN_SPEED")
    PushScaleformMovieFunctionParameterInt(1)
    PushScaleformMovieFunctionParameterInt(255)
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(Scaleform, "SET_COLUMN_SPEED")
    PushScaleformMovieFunctionParameterInt(2)
    PushScaleformMovieFunctionParameterInt(255)
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(Scaleform, "SET_COLUMN_SPEED")
    PushScaleformMovieFunctionParameterInt(3)
    PushScaleformMovieFunctionParameterInt(255)
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(Scaleform, "SET_COLUMN_SPEED")
    PushScaleformMovieFunctionParameterInt(4)
    PushScaleformMovieFunctionParameterInt(255)
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(Scaleform, "SET_COLUMN_SPEED")
    PushScaleformMovieFunctionParameterInt(5)
    PushScaleformMovieFunctionParameterInt(255)
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(Scaleform, "SET_COLUMN_SPEED")
    PushScaleformMovieFunctionParameterInt(6)
    PushScaleformMovieFunctionParameterInt(255)
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(Scaleform, "SET_COLUMN_SPEED")
    PushScaleformMovieFunctionParameterInt(7)
    PushScaleformMovieFunctionParameterInt(255)
	PopScaleformMovieFunctionVoid()
	
	Citizen.CreateThread(function()
		while Scaleform ~= nil do
			Citizen.Wait(0)
			--ESX.HideHudThisFrame()
			--ESX.DisableAllControlsThisFrame()
			--EnableControlAction(0, ESX.Keys['T'], true)

			DrawScaleformMovieFullscreen(Scaleform, 255, 255, 255, 255, 0)
			PushScaleformMovieFunction(Scaleform, "SET_CURSOR")
			PushScaleformMovieFunctionParameterFloat(GetControlNormal(0, 239))
			PushScaleformMovieFunctionParameterFloat(GetControlNormal(0, 240))
			PopScaleformMovieFunctionVoid()
			if IsDisabledControlJustPressed(0, 24) then
				PushScaleformMovieFunction(Scaleform, "SET_INPUT_EVENT_SELECT")
				ClickReturn = PopScaleformMovieFunction()

				PlaySoundFrontend(-1, "HACKING_CLICK", "", true)
			elseif IsDisabledControlJustPressed(0, 25) then
				PushScaleformMovieFunction(Scaleform, "SET_INPUT_EVENT_BACK")
				PopScaleformMovieFunctionVoid()
				PlaySoundFrontend(-1, "HACKING_CLICK", "", true)
			end
		end
	end)
	while Scaleform ~= nil and HasScaleformMovieLoaded(Scaleform) do
		Citizen.Wait(0)
		local ped = PlayerPedId()

		FreezeEntityPosition(ped, true)
		DisablePlayerFiring(ped, true)
		if GetScaleformMovieFunctionReturnBool(ClickReturn) then
			local ProgramID = GetScaleformMovieFunctionReturnInt(ClickReturn)
			
			--print("ProgramID: " .. ProgramID)
			if GameLives == 0 then
				PlaySoundFrontend(-1, "HACKING_FAILURE", "", true)
				PushScaleformMovieFunction(Scaleform, "SET_ROULETTE_OUTCOME")
				PushScaleformMovieFunctionParameterBool(false)
				PushScaleformMovieFunctionParameterString("HACK FAILED!")
				PopScaleformMovieFunctionVoid()

				Citizen.Wait(3500)
				PushScaleformMovieFunction(Scaleform, "CLOSE_APP")
				PopScaleformMovieFunctionVoid()

				PushScaleformMovieFunction(Scaleform, "OPEN_ERROR_POPUP")
				PushScaleformMovieFunctionParameterBool(true)
				PushScaleformMovieFunctionParameterString("CRITICAL ERROR HAS OCCURED")
				PopScaleformMovieFunctionVoid()

				Citizen.Wait(2500)
				SetScaleformMovieAsNoLongerNeeded(Scaleform)
				PopScaleformMovieFunctionVoid()
				FreezeEntityPosition(ped, false)
				DisableControlAction(0, 24, false)
				DisableControlAction(0, 25, false)
				Scaleform = nil
				Aproved = false
			elseif ProgramID == 82 then
				PlaySoundFrontend(-1, "HACKING_CLICK_BAD", "", false)
			elseif ProgramID == 83 then
				PushScaleformMovieFunction(Scaleform, "RUN_PROGRAM")
				PushScaleformMovieFunctionParameterFloat(83.0)
				PopScaleformMovieFunctionVoid()

				PushScaleformMovieFunction(Scaleform, "SET_ROULETTE_WORD")
				PushScaleformMovieFunctionParameterString(GamePassword)
				PopScaleformMovieFunctionVoid()
			elseif ProgramID == 87 then
				GameLives = GameLives - 1

				PlaySoundFrontend(-1, "HACKING_CLICK_BAD", "", false)
				PushScaleformMovieFunction(Scaleform, "SET_ROULETTE_WORD")
				PushScaleformMovieFunctionParameterString(GamePassword)
				PopScaleformMovieFunctionVoid()
				PushScaleformMovieFunction(Scaleform, "SET_LIVES")
				PushScaleformMovieFunctionParameterInt(GameLives)
				PushScaleformMovieFunctionParameterInt(5)
				PopScaleformMovieFunctionVoid()
			elseif ProgramID == 92 then
				PlaySoundFrontend(-1, "HACKING_CLICK_GOOD", "", false)
			elseif ProgramID == 86 then
				PlaySoundFrontend(-1, "HACKING_SUCCESS", "", true)
				PushScaleformMovieFunction(Scaleform, "SET_ROULETTE_OUTCOME")
				PushScaleformMovieFunctionParameterBool(true)
				PushScaleformMovieFunctionParameterString("HACK SUCCESSFUL! (HTTP 200 OK)")
				PopScaleformMovieFunctionVoid()

				Citizen.Wait(3000)
				PushScaleformMovieFunction(Scaleform, "CLOSE_APP")
				PopScaleformMovieFunctionVoid()
				PushScaleformMovieFunction(Scaleform, "OPEN_LOADING_PROGRESS")
				PushScaleformMovieFunctionParameterBool(true)
				PopScaleformMovieFunctionVoid()
				PushScaleformMovieFunction(Scaleform, "SET_LOADING_PROGRESS")
				PushScaleformMovieFunctionParameterInt(25)
				PopScaleformMovieFunctionVoid()
				PushScaleformMovieFunction(Scaleform, "SET_LOADING_TIME")
				PushScaleformMovieFunctionParameterInt(3)
				PopScaleformMovieFunctionVoid()
				PushScaleformMovieFunction(Scaleform, "SET_LOADING_MESSAGE")
				PushScaleformMovieFunctionParameterString("CREATING JSON PAYLOAD...")
				PushScaleformMovieFunctionParameterFloat(2.0)
				PopScaleformMovieFunctionVoid()

				Citizen.Wait(3000)
				PushScaleformMovieFunction(Scaleform, "SET_LOADING_MESSAGE")
				PushScaleformMovieFunctionParameterString("APPLYING MAN IN THE MIDDLE...")
				PushScaleformMovieFunctionParameterFloat(2.0)
				PopScaleformMovieFunctionVoid()
				PushScaleformMovieFunction(Scaleform, "SET_LOADING_PROGRESS")
				PushScaleformMovieFunctionParameterInt(50)
				PopScaleformMovieFunctionVoid()
				PushScaleformMovieFunction(Scaleform, "SET_LOADING_TIME")
				PushScaleformMovieFunctionParameterInt(6)
				PopScaleformMovieFunctionVoid()

				Citizen.Wait(3000)
				PushScaleformMovieFunction(Scaleform, "SET_LOADING_PROGRESS")
				PushScaleformMovieFunctionParameterInt(75)
				PopScaleformMovieFunctionVoid()
				PushScaleformMovieFunction(Scaleform, "SET_LOADING_TIME")
				PushScaleformMovieFunctionParameterInt(9)
				PopScaleformMovieFunctionVoid()
				PushScaleformMovieFunction(Scaleform, "SET_LOADING_MESSAGE")
				PushScaleformMovieFunctionParameterString("UPLOADING JSON PAYLOAD...")
				PushScaleformMovieFunctionParameterFloat(2.0)
				PopScaleformMovieFunctionVoid()

				Citizen.Wait(3000)
				PushScaleformMovieFunction(Scaleform, "SET_LOADING_MESSAGE")
				PushScaleformMovieFunctionParameterString("STILL UPLOADING JSON PAYLOAD...")
				PushScaleformMovieFunctionParameterFloat(2.0)
				PopScaleformMovieFunctionVoid()
				PushScaleformMovieFunction(Scaleform, "SET_LOADING_PROGRESS")
				PushScaleformMovieFunctionParameterInt(100)
				PopScaleformMovieFunctionVoid()
				PushScaleformMovieFunction(Scaleform, "SET_LOADING_TIME")
				PushScaleformMovieFunctionParameterInt(12)
				PopScaleformMovieFunctionVoid()

				Citizen.Wait(3000)
				PushScaleformMovieFunction(Scaleform, "OPEN_LOADING_PROGRESS")
				PushScaleformMovieFunctionParameterBool(false)
				PopScaleformMovieFunctionVoid()
				PushScaleformMovieFunction(Scaleform, "OPEN_ERROR_POPUP")
				PushScaleformMovieFunctionParameterBool(true)
				PushScaleformMovieFunctionParameterString("READY! " .. GameLastText .. ". TOKEN OAUTH: " .. math.random(100000000, 999999999))
				PopScaleformMovieFunctionVoid()

				Citizen.Wait(GameTimeout)
				SetScaleformMovieAsNoLongerNeeded(Scaleform)
				PopScaleformMovieFunctionVoid()
				FreezeEntityPosition(ped, false)
				Scaleform = nil
				Aproved = true
			end
		end
	end
	if ReturnDelay then Citizen.Wait(ReturnDelay) end
	return Aproved
end

function IsScaleform()
    return Scaleform
end

function CloseScaleform()
    Scaleform = nil
end