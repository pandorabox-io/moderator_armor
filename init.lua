armor:register_armor("moderator_armor:helmet", {
	description = "Moderator Helmet",
	inventory_image = "moderator_armor_inv_helmet.png",
	groups = {armor_head=1, armor_heal=12, armor_use=100},
	armor_groups = {fleshy=15},
	damage_groups = {cracky=2, snappy=1, level=3},
})

armor:register_armor("moderator_armor:chestplate", {
	description = "Moderator Chestplate",
	inventory_image = "moderator_armor_inv_chestplate.png",
	groups = {armor_torso=1, armor_heal=12, armor_use=100},
	armor_groups = {fleshy=20},
	damage_groups = {cracky=2, snappy=1, level=3},
})

armor:register_armor("moderator_armor:leggings", {
	description = "Moderator Leggings",
	inventory_image = "moderator_armor_inv_leggings.png",
	groups = {armor_legs=1, armor_heal=12, armor_use=100},
	armor_groups = {fleshy=20},
	damage_groups = {cracky=2, snappy=1, level=3},
})

armor:register_armor("moderator_armor:boots", {
	description = "Moderator Boots",
	inventory_image = "moderator_armor_inv_boots.png",
	groups = {armor_feet=1, armor_heal=12, armor_use=100},
	armor_groups = {fleshy=15},
	damage_groups = {cracky=2, snappy=1, level=3},
})

armor:register_armor("moderator_armor:shield", {
	description = "Moderator Shield",
	inventory_image = "moderator_armor_inv_shield.png",
	groups = {armor_shield=1, armor_heal=12, armor_use=100},
	armor_groups = {fleshy=15},
	damage_groups = {cracky=2, snappy=1, level=3},
	reciprocate_damage = true,
	on_damage = function(player, index, stack)
		play_sound_effect(player, "default_glass_footstep")
	end,
	on_destroy = function(player, index, stack)
		play_sound_effect(player, "default_break_glass")
	end,
})

print("[OK] Moderator armor")
