local item_sounds = require("__base__.prototypes.item_sounds")

data:extend({
    {
        type = "container",
        name = "dequalitier",
        icon = "__Dequalitier__/graphics/dequalitier-chest.png",
        flags = { "hide-alt-info", "placeable-neutral", "player-creation" },
        minable = { mining_time = 0.2, result = "dequalitier" },
        max_health = 350,
        corpse = "steel-chest-remnants",
        dying_explosion = "steel-chest-explosion",
        open_sound = { filename = "__base__/sound/metallic-chest-open.ogg", volume = 0.43 },
        close_sound = { filename = "__base__/sound/metallic-chest-close.ogg", volume = 0.43 },
        resistances = {
            {
                type = "fire",
                percent = 90
            },
            {
                type = "impact",
                percent = 60
            }
        },
        collision_box = { { -0.35, -0.35 }, { 0.35, 0.35 } },
        selection_box = { { -0.5, -0.5 }, { 0.5, 0.5 } },
        damaged_trigger_effect = require("__base__.prototypes.entity.hit-effects").entity(),
        inventory_size = 48,
        impact_category = "metal",
        icon_draw_specification = { scale = 0.7 },
        picture = {
            layers = {
                {
                    filename = "__Dequalitier__/graphics/dequalitier-chest.png",
                    priority = "extra-high",
                    width = 64,
                    height = 80,
                    shift = util.by_pixel(-0.25, -0.5),
                    scale = 0.5
                },
                {
                    filename = "__base__/graphics/entity/steel-chest/steel-chest-shadow.png",
                    priority = "extra-high",
                    width = 110,
                    height = 46,
                    shift = util.by_pixel(12.25, 8),
                    draw_as_shadow = true,
                    scale = 0.5
                },
            }
        },
        circuit_connector = circuit_connector_definitions["chest"],
        circuit_wire_max_distance = default_circuit_wire_max_distance
    }
})



data:extend({
    {
        type = "item",
        name = "dequalitier",
        icons = {{
			icon = "__Dequalitier__/graphics/dequalitier-chest-icon.png",
			icon_size = 64
		}},
        subgroup = "storage",
        order = "za",
        inventory_move_sound = item_sounds.nuclear_inventory_move,
        pick_sound = item_sounds.metal_chest_inventory_pickup,
        drop_sound = item_sounds.metal_chest_inventory_move,
        place_result = "dequalitier",
        stack_size = 50
    }
})

data:extend({
    {
        type = "recipe",
        name = "dequalitier",
        enabled = true,
        item_group = production,
        item_subgroup = module,
        ingredients = {
			{ type = "item", name = "iron-plate", amount = 2 },
			{ type = "item", name = "copper-plate", amount = 1 }
		},
        energy_required = 10,
        results = { { type = "item", name = "dequalitier", amount = 1 } }
    }
})

