-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore, pairs
    = minetest, nodecore, pairs
-- LUALOCALS > ---------------------------------------------------------

local modname = minetest.get_current_modname()

local function findpumwater(pos)
        return nodecore.find_nodes_around(pos, "group:lava")
end

local function soakup(pos)
        local any
        for _, p in pairs(findpumwater(pos)) do
                nodecore.node_sound(p, "dig")
                minetest.remove_node(p)
                any = true
        end
        return any
end

minetest.register_abm({
                label = "sponge glowing",
                interval = 1,
                chance = 10,
                nodenames = {modname .. ":pumsponge"},
                neighbors = {"group:lava"},
                action = function(pos)
                        if soakup(pos) then
                                nodecore.set_loud(pos, {name = modname .. ":pumsponge_glowing"})
                                return nodecore.fallcheck(pos)
                        end
                end
        })

nodecore.register_aism({
                label = "sponge stack glowing",
                interval = 1,
                chance = 10,
                itemnames = {modname .. ":pumsponge"},
                action = function(stack, data)
                        if data.pos and soakup(data.pos) then
                                local taken = stack:take_item(1)
                                taken:set_name(modname .. ":pumsponge_glowing")
                                if data.inv then taken = data.inv:add_item("main", taken) end
                                if not taken:is_empty() then nodecore.item_eject(data.pos, taken) end
                                return stack
                        end
                end
        })

--need to fix this for air/water cooling it instead of sun drying
-- maybe steal code from amalgamation effect
minetest.register_abm({
                label = "sponge air cold",
                interval = 1,
                chance = 100,
                nodenames = {modname .. ":sponge_glowing"},
                arealoaded = 1,
                action = function(pos)
                        local above = {x = pos.x, y = pos.y + 1, z = pos.z}
                        if nodecore.is_full_sun(above) and #findwater(pos) < 1 then
                                nodecore.sound_play("nc_api_craft_hiss", {gain = 0.02, pos = pos})
                                return minetest.set_node(pos, {name = modname .. ":sponge"})
                        end
                end
        })

nodecore.register_aism({
                label = "sponge stack air cold",
                interval = 1,
                chance = 100,
                arealoaded = 1,
                itemnames = {modname .. ":sponge_glowing"},
                action = function(stack, data)
                        if data.player and (data.list ~= "main"
                                or data.slot ~= data.player:get_wield_index()) then return end
                        if data.pos and nodecore.is_full_sun(data.pos)
                        and #findwater(data.pos) < 1 then
                                nodecore.sound_play("nc_api_craft_hiss", {gain = 0.02, pos = data.pos})
                                local taken = stack:take_item(1)
                                taken:set_name(modname .. ":sponge")
                                if data.inv then taken = data.inv:add_item("main", taken) end
                                if not taken:is_empty() then nodecore.item_eject(data.pos, taken) end
                                return stack
                        end
                end
        })

minetest.register_abm({
                label = "sponge water cold",
                interval = 1,
                chance = 20,
                nodenames = {modname .. ":sponge_wet"},
                neighbors = {"group:igniter"},
                action = function(pos)
                        nodecore.sound_play("nc_api_craft_hiss", {gain = 0.02, pos = pos})
                        return minetest.set_node(pos, {name = modname .. ":sponge"})
                end
        })
