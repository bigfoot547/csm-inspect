local inspect = false
minetest.register_chatcommand("inspect", {
	description = "Modify inspection settings",
	params = "help|get|on|off|hand|toggle",
	func = function(param)
		param = param:lower()
		if param == "help" then
			minetest.display_chat_message("HELP: Show this help message.")
			minetest.display_chat_message("GET: Inspection settings.")
			minetest.display_chat_message("ON: Enable inspection.")
			minetest.display_chat_message("OFF: Disable inspection.")
			minetest.display_chat_message("HAND: Show held item.")
			minetest.display_chat_message("TOGGLE: Toggle inspection. (Default)")
			return true
		elseif param == "get" then
			if inspect then
				return true, "Inspection is enabled."
			else
				return true, "Inspection is disabled."
			end
		elseif param == "on" then
			inspect = true
			return true, "Inspection enabled."
		elseif param == "off" then
			inspect = false
			return true, "Inspection disabled."
		elseif param == "hand" then
			local stack = minetest.get_wielded_item()
			if stack:get_name() == "" then
				minetest.display_chat_message("Your hand is empty.")
				return true
			end
			if stack:get_wear() > 0 then -- If a tool, then say wear instead of count.
				minetest.display_chat_message("You are holding a " .. stack:get_name() .. " which is " .. tostring(math.floor((stack:get_wear()/65535) * 100)) .. "% worn.")
				return true
			else
				minetest.display_chat_message("You are holding " .. tostring(stack:get_count()) .. " of " .. stack:get_name() .. ".")
				return true
			end
			return false, "Not Implimented."
		elseif param == "toggle" or param == "" then
			inspect = not inspect
			if inspect then
				return true, "Inspection enabled."
			else
				return true, "Inspection disabled."
			end
			return true
		else
			return false, "Invalid Arguments."
		end
	end
})

minetest.register_on_punchnode(function(pos, node)
	if inspect then
		minetest.display_chat_message("Node name: " .. node.name)
		minetest.display_chat_message("Param1: " .. tostring(node.param1))
		minetest.display_chat_message("Param2, Facedir: " .. tostring(node.param2) .. ", " .. tostring(node.param2 % 32))
	end
end)
