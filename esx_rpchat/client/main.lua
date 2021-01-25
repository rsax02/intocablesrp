RegisterNetEvent('esx_rpchat:sendProximityMessage')
AddEventHandler('esx_rpchat:sendProximityMessage', function(playerId, title, message, color)
	local source = PlayerId()
	local target = GetPlayerFromServerId(playerId)

	local sourcePed, targetPed = PlayerPedId(), GetPlayerPed(target)
	local sourceCoords, targetCoords = GetEntityCoords(sourcePed), GetEntityCoords(targetPed)

	if target == source then
		TriggerEvent('chat:addMessage', { args = { title, message }, color = { 128, 128, 128 } })
	elseif GetDistanceBetweenCoords(sourceCoords, targetCoords, true) < 20 then
		TriggerEvent('chat:addMessage', { args = { title, message }, color = { 128, 128, 128 } })
	end
end)

function isActive(id)
	for k,v in pairs(GetActivePlayers()) do          
		if(GetPlayerServerId(v)==id)then             
			return true         
		end     
	end     
	return false
end

RegisterNetEvent('sendProximityMessage')
AddEventHandler('sendProximityMessage', function(id, name, message)
  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id)
  if pid == myId then
    TriggerEvent('chat:addMessage', { args = {'OOC |' .. id, "^7 "..message}, color= {128, 128, 128}})
  elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 19.999 and isActive(id) then
    TriggerEvent('chat:addMessage', { args = {'OOC |' .. id, "^7 "..message}, color= {128, 128, 128}})
  end
end)

Citizen.CreateThread(function()
	TriggerEvent('chat:addSuggestion', '/twt',  _U('twt_help'),  { { name = _U('generic_argument_name'), help = _U('generic_argument_help') } } )
	TriggerEvent('chat:addSuggestion', '/anon',  _U('anon_help'),  { { name = _U('generic_argument_name'), help = _U('generic_argument_help') } } )
	
	
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		TriggerEvent('chat:removeSuggestion', '/twt')
		TriggerEvent('chat:removeSuggestion', '/anon')
	end
end)
