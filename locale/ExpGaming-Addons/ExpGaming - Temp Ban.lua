--[[
Explosive Gaming

This file can be used with permission but this and the credit below must remain in the file.
Contact a member of management on our discord to seek permission to use our code.
Any changes that you may make to the code are yours but that does not make the script yours.
Discord: https://discord.gg/XSsBV6b

The credit below may be used by another script do not remove.
]]
local credits = {{
	name='Temp Bans',
	owner='Explosive Gaming',
	dev='Cooldude2606',
	description='When a ban is too much',
	factorio_version='0.15.23',
	show=true
	}}
local function credit_loop(reg) for _,cred in pairs(reg) do table.insert(credits,cred) end end
--Please Only Edit Below This Line-----------------------------------------------------------
define_command('temp-ban','Temp ban a player untill the next reset',{'player','reason',true},'Mod',function(player,event,args)
    if player == '<server>' then
        local jail_player = game.players[args[1]]
        if not jail_player then print('Invaild Player Name,'..args[1]..', try using tab key to auto-complete the name') return end
        give_rank(jail_player,'Jail')
        table.insert(global.temp_bans,{jail_player.name,player,table.concat(args,' ',2)})
        ExpGui.draw_frame.popup('temp_ban',{player,table.concat(args,' ',2)})
    else
        local jail_player = game.players[args[1]]
        if not jail_player then player.print('Invaild Player Name,'..args[1]..', try using tab key to auto-complete the name') return end
        if get_rank(player).power > get_rank(player).power or get_rank(player).power > string_to_rank('Mod').power then player.print('401 - Unauthorized: Access is denied due to invalid credentials') return end
        give_rank(jail_player,'Jail')
        global.temp_bans[jail_player.name] = {player,table.concat(args,' ',2)}
        ExpGui.draw_frame.popup('temp_ban',{player,table.concat(args,' ',2)})
    end
end)

ExpGui.add_frame.popup('temp_ban','Temp Ban','You have been baned till next reset',nil,nil,function(player,frane,args)
    frame.add{name='title',type='label',caption='You Have Been Temp Baned',style="caption_label_style"}
    frame.add{name='info',type='label',caption='This can not be revert, you will be unbaned on the next map reset'}
    frame.add{name='by_player',type='label',caption='You were banned by '..args[1]}
    frame.add{name='reason',type='label',caption='Reason: '..args[2]}
end)

Event.register(defines.events.on_player_joined_game,function(event)
    local player = game.players[event.player_index]
    if global.temp_bans[player.name] then
        ExpGui.draw_frame.popup('temp_ban',{global.temp_bans[player.name][1],global.temp_bans[player.name][2]})
    end
end)

Event.register(-1,function() global.temp_bans = {} end)
--Please Only Edit Above This Line-----------------------------------------------------------
return credits