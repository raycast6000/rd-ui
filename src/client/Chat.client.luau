local endpoints = game.ReplicatedStorage.Endpoints
local module = {}

function get_message_sender(message: TextChatMessage): Player
	for _,player in pairs(game.Players:GetPlayers()) do
		if player.UserId == message.TextSource.UserId then
			return player
		end
	end
end

function module:init()
	game.TextChatService.OnIncomingMessage = function(message: TextChatMessage)
		local sender: Player = get_message_sender(message)
		
		if sender:GetAttribute("IsInParty") then
			local party_acronym: string = sender:GetAttribute("PartyAcronym")
			local party_color: string = sender:GetAttribute("PartyColor")
			
			message.PrefixText = ("<font color='#%s'>[%s] %s:</font>"):format(party_color, party_acronym, sender.Name)
		end
	end
end

return module