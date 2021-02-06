Config = {}

Config.AllLogs = true											-- Enable/Disable All Logs Channel
Config.postal = false											-- set to false if you want to disable nerest postal (https://forum.cfx.re/t/release-postal-code-map-minimap-new-improved-v1-2/147458)
Config.username = "Intocables Logs System" 							-- Bot Username
Config.avatar = "https://i.imgur.com/MMV59gA.jpg"				-- Bot Avatar
Config.communtiyName = "Intocables RP"					-- Icon top of the Embed
Config.communtiyLogo = "https://i.imgur.com/SM1cup2.gif"		-- Icon top of the Embed


Config.weaponLog = true  			-- set to false to disable the shooting weapon logs
Config.weaponLogDelay = 60000		-- delay to wait after someone fired a weapon to check again in ms (put to 0 to disable) Best to keep this at atleast 1000

Config.playerID = true				-- set to false to disable Player ID in the logs
Config.steamID = true				-- set to false to disable Steam ID in the logs
Config.steamURL = true				-- set to false to disable Steam URL in the logs
Config.discordID = true				-- set to false to disable Discord ID in the logs
Config.playerIP = true


-- Change color of the default embeds here
-- It used Decimal color codes witch you can get and convert here: https://jokedevil.com/colorPicker
Config.joinColor = "3863105" 		-- Player Connecting
Config.leaveColor = "15874618"		-- Player Disconnected
Config.chatColor = "10592673"		-- Chat Message
Config.shootingColor = "10373"		-- Shooting a weapon
Config.deathColor = "000000"		-- Player Died
Config.resourceColor = "15461951"	-- Resource Stopped/Started



Config.webhooks = {
	all = "DISCORD_WEBHOOK",
	chat = "https://discord.com/api/webhooks/783179061102510100/P_XUX7PUhfvTWoNcMapKeTpLiuY3E1s-y-mD-qY7r8WccpLhBS3Ry-aQO4NBvB0AWV2V",
	joins = "https://discord.com/api/webhooks/783180184441978890/N8lSP44wlnEhUDKN18Pp4r2URtSzjpzP_vgQimW-IWJIfF2zQZYqekpLFSIrva_MD5GG",
	leaving = "https://discord.com/api/webhooks/783180067345793058/kMlEXXKWJWvotO020niesPxC71F8c7rPNOp-JWzUQYyw067KskGHx0LMjItCvwm4IL0O",
	deaths = "https://discord.com/api/webhooks/807695829707390976/S-kJsukjpxIB6Q4ibpdKGvorie8DmhWSLgB7m1nBqPF9xGOfx1r6Clvim2USefss1xRg",
	shooting = "",
	resources = "",
	joins2 = "https://discord.com/api/webhooks/783179660031950908/qkLdxhSQCF8XvnifJ8bzjH_8l8QXwftuKNNrErb0XTpnKYdDKDfesjQgivv7Kz-6bu10", -- norm
	twitter = "https://discord.com/api/webhooks/783179061102510100/P_XUX7PUhfvTWoNcMapKeTpLiuY3E1s-y-mD-qY7r8WccpLhBS3Ry-aQO4NBvB0AWV2V",
	platepurchase = "https://discord.com/api/webhooks/807695701164818482/lQ5INWisxrPTERxnsH1XfmaFm0QLbqOuXwSb-py61zlbfu7retwJA61xhnPVRGg2ruBo",
	perfpurchase = "https://discord.com/api/webhooks/807695517894443018/ePRVVemE0rHOiZmsL4FFG3OEIKs3CByC99sSe8AWqr3cP07cnNP7OQxDVxHgvOE_RXfk",
	numberpurchase = "https://discord.com/api/webhooks/807695610781892688/ts7hUygXaFmME9eD_ivXlGmCdZsC_m2koAuqbnYtkWPXKM3Vy8EpuySnGbMPeBMYKMgl",
	bank = "https://discord.com/api/webhooks/807694791881523201/bh5uIpCiUViwtiyAIK3YjWC7MyPcI-2R4PIHNn3xz1nobIfiqRAzJPJ9hDRUC-z7iFiJ",
	realtimechat = "https://discord.com/api/webhooks/788365802558193664/aGkO_7-DvebtbOUCSHvWJw3BoMHChna0_77vDVCDQQ5sKr0Uq3XT3FAPpurr-yK_dRF9" 

  -- How you add more logs is explained on https://docs.jokedevil.com/JD_logs
  }


 --Debug shizzels :D
Config.debug = false
Config.versionCheck = "1.1.0"
