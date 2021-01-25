Citizen.CreateThread(function()
	while true do
        --This is the Application ID (Replace this with you own)
		SetDiscordAppId(782442475377131541)

        --Here you will have to put the image name for the "large" icon.
		SetDiscordRichPresenceAsset('intogif')
        
        --(11-11-2018) New Natives:

        --Here you can add hover text for the "large" icon.
        SetDiscordRichPresenceAssetText('Intocables RP El Original')
       
        --Here you will have to put the image name for the "small" icon.
        SetDiscordRichPresenceAssetSmall('intogif')

        --Here you can add hover text for the "small" icon.
        SetDiscordRichPresenceAssetSmallText('play.intocablesrp.com')

        --It updates every one minute just in case.
		Citizen.Wait(60000)
	end
end)