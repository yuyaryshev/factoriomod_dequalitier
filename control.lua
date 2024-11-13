local quality_level = {}

function regenerate_qualities()
	quality_level = {}
    for name, prototype in pairs(prototypes.quality) do
		quality_level[name] = prototype.level
    end
end

--------------------------------
local entity_filter = {
    { filter = "name", name = "dequalitier" }
}

local exclude_list = {
    ["tank"] = true,
    ["spidertron"] = true,
    ["modular-armor"] = true,
    ["power-armor"] = true,
    ["power-armor-mk2"] = true,
    ["mech-armor"] = true
}

local function update_recipe_unlocks()
    for _, force in pairs(game.forces) do
        if force.technologies["quality-module"].researched then
            force.recipes["dequalitier"].enabled = true
        end
    end
end

local function on_init()
	regenerate_qualities();
    storage.down_binners = {};
end

local function on_built(evt)
    storage.down_binners[evt.entity.unit_number] = evt.entity
end

local function main()
	regenerate_qualities()

	if 1 > 0 then
		for unit_number, entity in pairs(storage.down_binners) do

			if (not entity or not entity.valid) then
				table.remove(storage.down_binners, unit_number)
				goto next_entity
			end

			local target_quality = entity.quality

			local inventory = entity.get_inventory(defines.inventory.chest)
			local contents = inventory.get_contents()

			for _, content in pairs(contents) do

				if exclude_list[content.name] then
					goto next_content
				end

				if not quality_level[content.quality] then
					goto next_content
				end

				if target_quality.level < quality_level[content.quality] then
					inventory.remove(content)
					content.quality = target_quality.name
					inventory.insert(content)
				end

				:: next_content ::
			end

			:: next_entity ::
		end
	end
end

script.on_init(on_init)
script.on_configuration_changed(update_recipe_unlocks)

script.on_event(defines.events.on_built_entity, on_built, entity_filter)
script.on_event(defines.events.on_robot_built_entity, on_built, entity_filter)
script.on_event(defines.events.script_raised_built, on_built, entity_filter)
script.on_event(defines.events.script_raised_revive, on_built, entity_filter)
if script.active_mods["space-age"] then
    script.on_event(defines.events.on_space_platform_built_entity, on_built, entity_filter)
end

script.on_nth_tick(60, main)



