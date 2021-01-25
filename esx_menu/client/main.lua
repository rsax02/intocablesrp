ESX = nil
local disableShuffle = true

Citizen.CreateThread(function()
    while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(5)
    end
end)

function OpenCivilianActionsMenu()
	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'civilian_actions', {
		title = 'Inicio',
		align = 'top-left',
		elements = {
			{label = 'Documentos', value = 'documents'},
			{label = 'Acciones', value = 'gest'},
			{label = 'Vehiculo', value = 'vehiclemenu'},
			{label = 'Facturas', value = 'billing'},
			{label = 'IntoCoins', value='coins'},
			{label = 'Regalos', value='gift'}
	   }
   }, function(data, menu)
		if data.current.value == 'gest' then
			menu.close()
			openGestMenu()
		elseif data.current.value == 'documents' then
			menu.close()
			openDocumentsMenu()
		elseif data.current.value == 'changeseat' then
			TriggerEvent("SeatShuffle")
		elseif data.current.value == 'vehiclemenu' then
			if IsPedInAnyVehicle(PlayerPedId()) then
				OpenVehicleMenu()
			end
		elseif data.current.value == 'billing' then
			TriggerEvent('esx_billing:openBillsMenu')
		elseif data.current.value=="coins" then
			OpenDonationMenu()
		elseif data.current.value=="gift"then
			OpenGiftMenu()
		end
	end, function(data, menu)
		menu.close()
	end)
end

function OpenLicenseMenu()
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'id_card_actions', {
        title = 'DNI/Licencias',
        align = 'top-left',
        elements = {{
            label = 'Ver DNI',
            value = 'checkID'
        }, {
            label = 'Mostrar DNI',
            value = 'showID'
        }, {
            label = 'Ver Licencia de conducir',
            value = 'checkDriver'
        }, {
            label = 'Mostrar Licencia de conducir',
            value = 'showDriver'
        }}
    }, function(data, menu)
        local val = data.current.value

        if val == 'checkID' then
            TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), 'dni')
        elseif val == 'checkDriver' then
            TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), 'driver')
        else
            local player, distance = ESX.Game.GetClosestPlayer()

            if distance ~= -1 and distance <= 3.0 then
                if val == 'showID' then
                    TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(player), 'dni')
                elseif val == 'showDriver' then
                    TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(player), 'driver')
                end
            else
                ESX.ShowNotification('No hay jugadores cerca')
            end
        end
    end, function(data, menu)
        menu.close()
        OpenCivilianActionsMenu()
    end)
end

function openDocumentsMenu()
    local ped = PlayerPedId()
    ESX.UI.Menu.CloseAll()
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'documents', {
        title = 'Documentos',
        align = 'top-left',
        elements = {{
            label = 'DNI',
            value = 'dni'
        }, {
            label = 'Licencia de conducir',
            value = 'license'
        }, {
            label = 'Otros documentos',
            value = 'other'
        }}
    }, function(data, menu)
			if data.current.value == 'dni' then
				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'id_card_actions', {
				title = 'DNI',
				align = 'top-left',
				elements = {{
					label = 'Ver',
					value = 'checkID'
				}, {
					label = 'Mostrar',
					value = 'showID'
				}}
			}, function(data, menu)
				local val = data.current.value
					if val == 'checkID' then
						TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()))
					else
						local player, distance = ESX.Game.GetClosestPlayer()

						if distance ~= -1 and distance <= 3.0 then
							TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player))
						else
							ESX.ShowNotification('No hay jugadores cerca')
						end
					end
					menu.close()
				end, function(data, menu)
					menu.close()
					openDocumentsMenu()
				end)

			elseif data.current.value == 'license' then
				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'license_actions', {
				title = 'Licencia de conducir',
				align = 'top-left',
				elements = {{
					label = 'Ver',
					value = 'checkID'
				}, {
					label = 'Mostrar',
					value = 'showID'
				}}
			}, function(data, menu)
				if data.current.value == 'checkID' then
				TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'driver')
			else
				local player, distance = ESX.Game.GetClosestPlayer()
				if distance ~= -1 and distance <= 3.0 then
					TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player), 'driver')
				else
					ESX.ShowNotification('No hay jugadores cerca')
				end
			end
			menu.close()	
			end, function(data, menu)
				menu.close()
				openDocumentsMenu()
			end)

        elseif data.current.value == 'other' then
			TriggerEvent('esx_documents:openDocumentsMenu')
			menu.close()
        end
    end, function(data, menu)
        OpenCivilianActionsMenu()
    end)
end

function openGestMenu()
	local ped = PlayerPedId()
	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'gests', {
		title = 'Acciones',
		align = 'top-left',
		elements = {
			{label = 'Cargar', value = 'carry'},
			{label = 'Chiflar', value = 'chifle'},
			{label = 'Cambiar de asiento', value = 'changeseat'},
	   }
   }, function(data, menu)
		if data.current.value == 'carry' then
			TriggerEvent('esx_carry:carry')
		elseif data.current.value == 'changeseat' then
			TriggerEvent("SeatShuffle")
		elseif data.current.value == 'chifle' then
			ExecuteCommand("e whistle2")
		end
	end, function(data, menu)
		OpenCivilianActionsMenu()
	end)
end

RegisterNetEvent('esx_menu:openCivilianMenu')
AddEventHandler('esx_menu:openCivilianMenu', function()
	OpenCivilianActionsMenu()
end)

RegisterCommand("level", function(source, args, message)
	message=string.sub(message,7)
	local player = GetPlayerServerId(PlayerId())
	if(message==""or message==" ")then
		message=player
	end
	TriggerServerEvent("esx:showLevel",message,player)
end)


RegisterCommand("history", function(source, args, command)
	local arg = string.sub(command, 9)
	OpenHistoryMenu(arg)
end)

function OpenHistoryMenu(arg)
	ESX.TriggerServerCallback("esx_menu:getHistory", function(elements)
		if(elements==nil)then
			return
		end
		ESX.UI.Menu.Open('list', GetCurrentResourceName(), 'history', elements, function(data, menu)
		menu.close()
	end, function(data, menu)
		menu.close()
	end)
	end, arg)
end

function IsAlphaNumeric(value)
    local Valid = true
    local Characters = {"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "Ñ", "O", "P", "Q", "R",
                        "S", "T", "U", "V", "W", "X", "Y", "Z", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k",
                        "l", "m", "n", "ñ", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "1", "2", "3",
                        "4", "5", "6", "7", "8", "9", "0", " "}

    for character in string.gmatch(value, ".") do
        local isFounded = false

        for _, c in ipairs(Characters) do
            if c == character then
                isFounded = true
                break
            end
        end
        if isFounded == false then
            Valid = false
            break
        end
    end
    return Valid
end

local Performance = function(current)
    local ped = PlayerPedId()
	if IsPedInAnyVehicle(ped,false) then
		ESX.UI.Menu.CloseAll()
		local vehicle = GetVehiclePedIsIn(ped,false)
		local vehiclePlate = GetVehicleNumberPlateText(	vehicle)
		ESX.TriggerServerCallback('esx_donations:confirmBuy', function(balance)
			if (balance) then
                ESX.Game.SetVehicleProperties(vehicle, {
                    modEngine = 3,
                    modBrakes = 2,
                    modTransmission = 2,
                    modSuspension = 3,
                    modTurbo = true,
                    modXenon = true,
                    windowTint = 1
                })
				local props = ESX.Game.GetVehicleProperties(vehicle)
				TriggerServerEvent('esx_advancedgarage:saveProperties',props,"performance")
            end
        end, current)
	else
        ESX.ShowNotification("Debes estar en un vehículo")
    end
end

local Phone = function(current)
    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'phone', {
        title = "Introduce el numero telefonico"
    }, function(data, menu)
        local num = data.value
        if (num == nil or tonumber(num) == nil) then
            ESX.ShowNotification("Numero invalido")
            return
        end
        if (#num ~= 3) then
            ESX.ShowNotification("El numero debe tener 3 digitos")
            return
        end

		current.number=tonumber(num)
		menu.close()
		ESX.TriggerServerCallback('esx_donations:confirmBuy', function(balance)
			if balance then 
				ESX.UI.Menu.CloseAll()
			end
        end, current)
	end, function(data, menu)
		menu.close()
        --OpenGiftMenu()
    end)
end

local Xenon = function(current)
	ESX.UI.Menu.Open('default',GetCurrentResourceName(),'xenon',{
		title="Colores",
		align="top-left",
		elements={
			{label="Blanco",value=0},
			{label="Azul",value=1},
			{label="Azul electrico",value=2},
			{label="Verde menta",value=3},
			{label="Verde lima",value=4},
			{label="Amarillo",value=5},
			{label="Dorado",value=6},
			{label="Anaranjado",value=7},
			{label="rojo",value=8},
			{label="Rosa claro",value=9},
			{label="Rosa fuerte",value=10},
			{label="Violeta",value=11},
			{label="Negro",value=12},
		}
	},function(data,menu)
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped,false) then
			ESX.ShowNotification("Debes estar en un vehiculo")
			return
		end
		ESX.UI.Menu.CloseAll()
		ESX.TriggerServerCallback('esx_donations:confirmBuy', function(balance)
			if balance then
				ESX.UI.Menu.CloseAll()
				local vehicle = GetVehiclePedIsIn(ped,false)
				ESX.Game.SetVehicleProperties(vehicle, {
					modXenon = true,
					xenonColor = data.current.value
				})
				local props = ESX.Game.GetVehicleProperties(vehicle)
				TriggerServerEvent('esx_advancedgarage:saveProperties',props,"xenon")
			end
		end, current)
	end,function(data,menu)
		menu.close()
	end)
end

local Plate = function(current)
    local plate1, plate2
    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'plate1', {
        title = "Introduce la placa del auto que deseas modificar"
    }, function(data, menu)
        plate1 = data.value
        if plate1 then
            if not IsAlphaNumeric(plate1) then
                ESX.ShowNotification("Solo puedes utilizar caracteres alfanumericos")
                return
            end
            menu.close()
            ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'plate2', {
                title = "Introduce la nueva placa"
            }, function(data2, menu2)
                plate2 = data2.value
                if plate2 then
                    if not IsAlphaNumeric(plate2) then
                        ESX.ShowNotification("Solo puedes utilizar caracteres alfanumericos")
                        return
					end
					if #plate2>8 then
						ESX.ShowNotification("La nueva placa debe tener 8 caracteres como maximo")
						return
					end
                    current.plate1 = string.upper(plate1)
                    current.plate2 = string.upper(plate2)
					ESX.TriggerServerCallback('esx_donations:confirmBuy', function(balance)
						if balance then
							local ped = PlayerPedId()
							if(IsPedInAnyVehicle(ped,false))then
								local vehicle = GetVehiclePedIsIn(ped,false)
								if GetVehicleNumberPlateText(vehicle) == plate1 then
									DeleteVehicle(vehicle)
								end 
							end 
							ESX.UI.Menu.CloseAll()
						end
                    end, current)
                    menu2.close()
                end
            end, function(data2, menu2)
                menu2.close()
            end)
        end
    end, function(data, menu)
        menu.close()
    end)
end

function OpenGiftMenu()
	ESX.TriggerServerCallback('esx_donations:getGifts',function(settings)
		ESX.UI.Menu.Open('default',GetCurrentResourceName(),'gift_menu',settings,
		function(data,menu)
			if data.current.value ~= "nil" then
				if data.current.value=="performance" then
					ESX.UI.Menu.Open('default',GetCurrentResourceName(),'confirm_gift',{
						title="Confirmar compra",
						align="top-left",
						elements = {{
							label="Sí",
							value="yes"
							},
							{
							label="No",
							value="no"
							}}
					},function(data2,menu2)
						if(data2.current.value=="yes")then
							Performance(data.current)
						else
							menu2.close()
						end
					end,function(data2,menu2)
						menu2.close()
						OpenGiftMenu()
					end)
				elseif data.current.value=="xenon"then
					Xenon(data.current)
				elseif data.current.value=="identity"then
					ESX.UI.Menu.CloseAll()
					ESX.TriggerServerCallback('esx_donations:confirmBuy', function()end,data.current)
				else
					--ESX.UI.Menu.CloseAll()
					if(data.current.value=="phone") then
						Phone(data.current)
					elseif data.current.value=="plate" then
						Plate(data.current)
					end
				end
			end
		end,function(data,menu)
			menu.close()
		end)
	end)
end

function OpenDonationMenu()
	ESX.TriggerServerCallback('esx_donations:getTokens',function(tokens,settings)
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'tokens_menu', settings,
		function(data, menu)
			if data.current.value == "coins" then
				return
			end
			local elements = {{
						label="Para mi",
						value="personal"
					}}

				if data.current.giftOption then
					table.insert(elements,{
					label="Para regalo",
					value="gift"
					})
				end
				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'gift_buy',{
					title="Comprar para",
					align="top-left",
					elements = elements
				},function(data2,menu2)
					if(data2.current.value=="personal")then
						if data.current.confirm then
							ESX.UI.Menu.Open('default',GetCurrentResourceName(),'confirm',{
								title="Confirmar compra",
								align="top-left",
								elements = {{
									label="Si",
									value="yes"
									},
									{
									label="No",
									value="no"
									}}
							},function(data3,menu3)
								if(data3.current.value=="yes")then
									--ESX.UI.Menu.CloseAll()
									--TriggerServerEvent('esx_donations:confirmBuy',data.current,data.current)
									--print(data.current.value)
									if data.current.value == "performance" then
										Performance(data.current)
									elseif data.current.value=="phone" then
										Phone(data.current)
									elseif data.current.value=="plate" then
										Plate(data.current)
									elseif data.current.value=="identity" then
										ESX.TriggerServerCallback('esx_donations:confirmBuy', function()end,data.current)
										ESX.UI.Menu.CloseAll()
									elseif data.current.value=="xenon" then
										Xenon(data.current)
									end
								else
									ESX.UI.Menu.CloseAll()
								end
							end,function(data3,menu3)
								menu3.close()
							end)
						else 
							if data.current.value == "performance" then
								Performance(data.current)
							elseif data.current.value=="phone" then
								Phone(data.current)
							elseif data.current.value=="plate" then
								Plate(data.current)
							elseif data.current.value=="money" then
								ESX.TriggerServerCallback('esx_donations:confirmBuy', function()end,data.current)ESX.UI.Menu.CloseAll()
								ESX.UI.Menu.CloseAll()
							elseif data.current.value=="identity" then
								ESX.TriggerServerCallback('esx_donations:confirmBuy', function()end,data.current)
								ESX.UI.Menu.CloseAll()
							elseif data.current.value=="xenon" then
								Xenon(data.current)
							end
						end
					else 
						ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'gift_id',{
							title="Introducir Id"
						},function(data3,menu3)
							local id = data3.value
							local serverId = GetPlayerFromServerId(tonumber(id))
							if id == nil then ESX.ShowNotification('Id invalida') return end
							ESX.TriggerServerCallback('esx_donations:isOnline', function(online)
							if not online then ESX.ShowNotification('Id invalida') return end
							if id==GetPlayerServerId(PlayerId()) then ESX.ShowNotification("No te puedes dar un regalo a ti mismo") return end
								menu3.close()
								ESX.UI.Menu.Open('default',GetCurrentResourceName(),'confirm_id_gift',{
									title="Confirmar compra",
									align="top-left",
									elements = {{
										label="Si",
										value="yes"
										},
										{
										label="No",
										value="no"
										}}
								},function(data4,menu4)
									if(data4.current.value=="yes")then
										ESX.UI.Menu.CloseAll()
										data.current.sendGift = true
										data.current.target = data3.value
										data.current.id=id
										ESX.TriggerServerCallback('esx_donations:confirmBuy',function(balance)
										end,data.current)
									else
										ESX.UI.Menu.CloseAll()
									end
								end,function(data4,menu4)
									menu3.close()
								end)
							end, id)							
						end,function(data3,menu3)
							menu3.close()
						end)
					end	
				end,function(data2,menu2)
					menu2.close()
				end)
			end, function(data, menu)
				menu.close()
				OpenCivilianActionsMenu()
			end)
	end)
end

function OpenVehicleMenu()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_actions', {
		title = 'Vehiculo',
		align = 'top-left',
		elements = {
			{label = 'Puertas', value = 'doors'},
			{label = 'Ventanas', value = 'windows'},
			{label = 'Velocidad', value = 'cruise_control'}
	   }
   }, function(data, menu)
		if data.current.value == 'doors' then
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'doors', {
				title = 'Puertas',
				align = 'top-left',
				elements = {
					{label = 'Capó', value = 'hood'},
					{label = 'Baúl', value = 'trunk'},
					{label = 'Puerta frontal izquierda', value = 'dooravg'},
					{label = 'Puerta frontal derecha', value = 'dooravd'},
					{label = 'Puerta trasera izquierda', value = 'doorarg'},
					{label = 'Puerta trasera derecha', value = 'doorard'},
					{label = 'Todas las puertas', value = 'doorall'}
			   }
		   }, function(data, menu)
				if data.current.value == 'hood' then
					local playerPed = PlayerPedId()
					local playerVeh = GetVehiclePedIsIn(playerPed, false)
					if IsPedSittingInAnyVehicle(playerPed) then
						if GetVehicleDoorAngleRatio(playerVeh, 4) > 0.0 then
							SetVehicleDoorShut(playerVeh, 4, false)
						else
							SetVehicleDoorOpen(playerVeh, 4, false)
						end
					end
				elseif data.current.value == 'trunk' then
					local playerPed = PlayerPedId()
					local playerVeh = GetVehiclePedIsIn(playerPed, false)
					if IsPedSittingInAnyVehicle(playerPed) then
						if GetVehicleDoorAngleRatio(playerVeh, 5) > 0.0 then
							SetVehicleDoorShut(playerVeh, 5, false)
						else
							SetVehicleDoorOpen(playerVeh, 5, false)
						end
					end
				elseif data.current.value == 'dooravg' then
					local playerPed = PlayerPedId()
					local playerVeh = GetVehiclePedIsIn(playerPed, false)
					if IsPedSittingInAnyVehicle(playerPed) then
						if GetVehicleDoorAngleRatio(playerVeh, 0) > 0.0 then
							SetVehicleDoorShut(playerVeh, 0, false)
						else
							SetVehicleDoorOpen(playerVeh, 0, false)
						end
					end
				elseif data.current.value == 'dooravd' then
					local playerPed = PlayerPedId()
					local playerVeh = GetVehiclePedIsIn(playerPed, false)
					if IsPedSittingInAnyVehicle(playerPed) then
						if GetVehicleDoorAngleRatio(playerVeh, 1) > 0.0 then
							SetVehicleDoorShut(playerVeh, 1, false)
						else
							SetVehicleDoorOpen(playerVeh, 1, false)
						end
					end
				elseif data.current.value == 'doorarg' then
					local playerPed = PlayerPedId()
					local playerVeh = GetVehiclePedIsIn(playerPed, false)
					if IsPedSittingInAnyVehicle(playerPed) then
						if GetVehicleDoorAngleRatio(playerVeh, 2) > 0.0 then
							SetVehicleDoorShut(playerVeh, 2, false)
						else
							SetVehicleDoorOpen(playerVeh, 2, false)
						end
					end
				elseif data.current.value == 'doorard' then
					local playerPed = PlayerPedId()
					local playerVeh = GetVehiclePedIsIn(playerPed, false)
					if IsPedSittingInAnyVehicle(playerPed) then
						if GetVehicleDoorAngleRatio(playerVeh, 3) > 0.0 then
							SetVehicleDoorShut(playerVeh, 3, false)
						else
							SetVehicleDoorOpen(playerVeh, 3, false)
						end
					end
				elseif data.current.value=="doorall" then
					local playerPed = PlayerPedId()
					local playerVeh = GetVehiclePedIsIn(playerPed, false)
					if IsPedSittingInAnyVehicle(playerPed) then
						if GetVehicleDoorAngleRatio(playerVeh, 0) > 0.0 then
							SetVehicleDoorShut(playerVeh, 0, false)
						else
							SetVehicleDoorOpen(playerVeh, 0, false)
						end

						if GetVehicleDoorAngleRatio(playerVeh, 1) > 0.0 then
							SetVehicleDoorShut(playerVeh, 1, false)
						else
							SetVehicleDoorOpen(playerVeh, 1, false)
						end


						if GetVehicleDoorAngleRatio(playerVeh, 2) > 0.0 then
							SetVehicleDoorShut(playerVeh, 2, false)
						else
							SetVehicleDoorOpen(playerVeh, 2, false)
						end


						if GetVehicleDoorAngleRatio(playerVeh, 3) > 0.0 then
							SetVehicleDoorShut(playerVeh, 3, false)
						else
							SetVehicleDoorOpen(playerVeh, 3, false)
						end

						if GetVehicleDoorAngleRatio(playerVeh, 5) > 0.0 then
							SetVehicleDoorShut(playerVeh, 5, false)
						else
							SetVehicleDoorOpen(playerVeh, 5, false)
						end

						if GetVehicleDoorAngleRatio(playerVeh, 4) > 0.0 then
							SetVehicleDoorShut(playerVeh, 4, false)
						else
							SetVehicleDoorOpen(playerVeh, 4, false)
						end
					end
				end
			end, function(data, menu)
				menu.close()
				OpenVehicleMenu()
			end)
		elseif data.current.value == 'windows' then
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'windows', {
				title = 'Ventanas',
				align = 'top-left',
				elements = {
					{label = 'Ventana izquierda', value = '1'},
					{label = 'Ventana derecha', value = '2'}
			   }
		   }, function(data, menu)
				if data.current.value == '1' then
					local playerPed = PlayerPedId()
					local playerVeh = GetVehiclePedIsIn(playerPed, false)
					if windowavg == false then
						RollDownWindow(playerVeh, 0)
						windowavg = true
					else
						RollUpWindow(playerVeh, 0)
						windowavg = false
					end
				elseif data.current.value == '2' then
					local playerPed = PlayerPedId()
					local playerVeh = GetVehiclePedIsIn(playerPed, false)
					if windowavd == false then
						RollDownWindow(playerVeh, 1)
						windowavd = true
					else
						RollUpWindow(playerVeh, 1)
						windowavd = false
					end
				end
			end, function(data, menu)
				menu.close()
				OpenVehicleMenu()
			end)
		elseif data.current.value == 'cruise_control' then
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cruise_control', {
				title = 'Limitar velocidad', 
				align = 'top-left', 
				elements = {
					{label = 'Limitar', value = 'limit'},
					{label = 'Deslimitar', value = 'unlimited'}
			   }
		   }, function(data, menu)
				if data.current.value == 'limit' then
					ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'speed_limit', {
					title = "Velocidad en Km/h"
					}, function(data2, menu2)
						local count = tonumber(data2.value)

						if count == nil then
							ESX.ShowNotification("Valor invalido")
						else
							menu2.close()
							if(count==0)then
							local playerPed = PlayerPedId()
							local playerVeh = GetVehiclePedIsIn(playerPed, false)
							local modelVeh = GetEntityModel(playerVeh)
							local maxSpeed = GetVehicleMaxSpeed(modelVeh)
							SetEntityMaxSpeed(playerVeh, maxSpeed)
							else
								local speed = count / 3.6
								local playerPed = PlayerPedId()
								local playerVeh = GetVehiclePedIsIn(playerPed, false)
								SetEntityMaxSpeed(playerVeh, 9999 / 3.6)
								SetEntityMaxSpeed(playerVeh, speed)
							end
						end
					end, function(data2, menu2)
						menu2.close()
					end)					
				elseif data.current.value == 'unlimited' then
					local playerPed = PlayerPedId()
					local playerVeh = GetVehiclePedIsIn(playerPed, false)
					SetEntityMaxSpeed(playerVeh, 9999/3.6)
				end
			end, function(data, menu)
				menu.close()
				OpenVehicleMenu()
			end)
		end
	end, function(data, menu)
		menu.close()
		OpenCivilianActionsMenu()
	end)
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(6)
		if IsControlJustReleased(0, 170) and IsInputDisabled(0) then
			OpenCivilianActionsMenu()
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(30)
		local playerPed = PlayerPedId()
		if IsPedInAnyVehicle(playerPed,false) and disableShuffle then
			local playerVeh = GetVehiclePedIsIn(playerPed, false)

			if GetPedInVehicleSeat(playerVeh, 0) == playerPed then
				if GetIsTaskActive(playerPed, 165) then
					SetPedIntoVehicle(playerPed, playerVeh, 0)
				end
			end
		else
			Citizen.Wait(600)
		end
	end
end)

RegisterNetEvent("SeatShuffle")
AddEventHandler("SeatShuffle", function()
	if IsPedInAnyVehicle(PlayerPedId(), false) then
		disableShuffle = false
		Citizen.Wait(5000)
		disableShuffle = true
	else
		CancelEvent()
	end
end)