
local mod_priv = minetest.settings:get("moderator_armor_priv") or "ban"

local disable_sounds = minetest.settings:get_bool("shields_disable_sounds")

-- Prevent non-moderators from wearing the armor
armor:register_on_equip(function(player, index, stack)
	local item = stack:get_name()
	if item ~= "" and string.match(item, "^moderator_armor:%a+") then
		local name, inv = armor:get_valid_player(player, "[equip]")
		if name and not minetest.check_player_privs(name, {[mod_priv] = true}) then
			minetest.chat_send_player(name, "You are not allowed to wear moderator armor.")
			inv:set_stack("armor", index, "")
			armor:set_player_armor(player)
			armor:save_armor_inventory(player)
		end
	end
end)

-- Sounds for shield
local function play_sound_effect(player, name)
	if not disable_sounds and player then
		local pos = player:get_pos()
		if pos then
			minetest.sound_play(name, {
				pos = pos,
				max_hear_distance = 10,
				gain = 0.5,
			})
		end
	end
end

armor:register_armor("moderator_armor:helmet", {
	description = "Moderator Helmet",
	inventory_image = "moderator_armor_inv_helmet.png",
	groups = {armor_head=1, armor_heal=12, armor_use=100},
	armor_groups = {fleshy=15},
	damage_groups = {cracky = 2, snappy = 1, level = 3},
})

armor:register_armor("moderator_armor:chestplate", {
	description = "Moderator Chestplate",
	inventory_image = "moderator_armor_inv_chestplate.png",
	groups = {armor_torso = 1, armor_heal = 12, armor_use = 100},
	armor_groups = {fleshy = 20},
	damage_groups = {cracky = 2, snappy = 1, level = 3},
})

armor:register_armor("moderator_armor:leggings", {
	description = "Moderator Leggings",
	inventory_image = "moderator_armor_inv_leggings.png",
	groups = {armor_legs = 1, armor_heal = 12, armor_use = 100},
	armor_groups = {fleshy = 20},
	damage_groups = {cracky = 2, snappy = 1, level = 3},
})

armor:register_armor("moderator_armor:boots", {
	description = "Moderator Boots",
	inventory_image = "moderator_armor_inv_boots.png",
	groups = {armor_feet = 1, armor_heal = 12, armor_use = 100},
	armor_groups = {fleshy = 15},
	damage_groups = {cracky = 2, snappy = 1, level = 3},
})

armor:register_armor("moderator_armor:shield", {
	description = "Moderator Shield",
	inventory_image = "moderator_armor_inv_shield.png",
	groups = {armor_shield = 1, armor_heal = 12, armor_use = 100},
	armor_groups = {fleshy = 20},
	damage_groups = {cracky = 2, snappy = 1, level = 3},
	reciprocate_damage = true,
	on_damage = function(player)
		play_sound_effect(player, "default_glass_footstep")
	end,
	on_destroy = function(player)
		play_sound_effect(player, "default_break_glass")
	end,
})

-- Chat command for moderators to get moderator armor
minetest.register_chatcommand("mod_armor", {
    params = "[<piece>]",
    description = "Gives moderator armor set or specific piece",
    privs = {[mod_priv] = true},
    func = function(name, param)
		local player = minetest.get_player_by_name(name)
		if not player then
			return false, "Player does not exist!"
		end
		local inv = player:get_inventory()
		local piece = string.gsub(param, "%s+", "")
		if piece == "helmet" or piece == "" then
			inv:add_item("main", "moderator_armor:helmet")
		end
		if piece == "chestplate" or piece == "" then
			inv:add_item("main", "moderator_armor:chestplate")
		end
		if piece == "leggings" or piece == "" then
			inv:add_item("main", "moderator_armor:leggings")
		end
		if piece == "boots" or piece == "" then
			inv:add_item("main", "moderator_armor:boots")
		end
		if piece == "shield" or piece == "" then
			inv:add_item("main", "moderator_armor:shield")
		end
    end,
})
