--[[
Explosive Gaming

This file can be used with permission but this and the credit below must remain in the file.
Contact a member of management on our discord to seek permission to use our code.
Any changes that you may make to the code are yours but that does not make the script yours.
Discord: https://discord.gg/XSsBV6b

The credit below may be used by another script do not remove.
]]
local credits = {{
	name='Control',
	owner='Explosive Gaming',
	dev='Cooldude2606',
	description='Core Factorio File',
	factorio_version='0.15.23',
	show=false
	}}
local function credit_loop(reg) for _,cred in pairs(reg) do table.insert(credits,cred) end end
--Please Only Edit Below This Line-----------------------------------------------------------
require("mod-gui")
credit_loop(require("locale/StdLib/event"))
Event.gui_update = script.generate_event_name()
credit_loop(require("locale/file-header"))
--below 'game.tick/(3600*game.speed)) % 15 == 0' raises the gui_update event every 15 minutes fell free to change the update time on that
Event.register(defines.events.on_tick, function(event)
	if (game.tick/(3600*game.speed)) % 15 == 0 then 
		for _,player in pairs(game.connected_players) do find_new_rank(player) end
		script.raise_event(Event.gui_update,{tick=game.tick}) 
	end 
end)
Event.register(-1,function() global.credits = credits end)
