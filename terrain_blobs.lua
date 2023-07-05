-- LUALOCALS < ---------------------------------------------------------
local minetest
    = minetest
-- LUALOCALS > ---------------------------------------------------------

local modname = minetest.get_current_modname()

-- ================================================================== --
	
--[[
minetest.register_ore({
                ore_type         = "blob",
                ore              = "nc_terrain:lava_source",
                wherein          = {"nc_terrain:stone"},
                clust_scarcity   = 90 * 90 * 90,
                clust_size       = 1,
                y_min            = -10,
                y_max            = 10,
                noise_threshold = 0.0,
                noise_params     = {
                        offset = 0.5,
                        scale = 0.2,
                        spread = {x = 5, y = 5, z = 5},
                        seed = 1024,
                        octaves = 1,
                        persist = 0.0
                },
        })

minetest.register_ore({
                ore_type         = "blob",
                ore              = "nc_terrain:water_source",
                wherein          = {"nc_terrain:stone"},
                clust_scarcity   = 20* 20 * 20,
                clust_size       = 12,
                y_min            = -30000,
                y_max            = 4,
                noise_threshold = 0.2,
                noise_params     = {
                        offset = 0.5,
                        scale = 0.2,
                        spread = {x = 500, y = 500, z = 500},
                        seed = 1024,
                        octaves = 1,
                        persist = 0.0
                },
        })

minetest.register_ore({
                ore_type         = "blob",
                ore              = "nc_terrain:lava_source",
                wherein          = {"nc_terrain:stone"},
                clust_scarcity   = 10* 10 * 10,
                clust_size       = 12,
                y_min            = -3,
                y_max            = 4,
                noise_threshold = 0.2,
                noise_params     = {
                        offset = 0.5,
                        scale = 0.2,
                        spread = {x = 500, y = 500, z = 500},
                        seed = 1024,
                        octaves = 1,
                        persist = 0.0
                },
        })

minetest.register_ore({
                ore_type         = "blob",
                ore              = "nc_concrete:concrete_cloudstone_vermy",
                wherein          = {"nc_terrain:sand"},
                clust_scarcity   = 20 * 20 * 20,
                clust_size       = 9,
                y_min            = -200,
                y_max            = 200,
                noise_threshold = 0.0,
                noise_params     = {
                        offset = 0.5,
                        scale = 0.2,
                        spread = {x = 5, y = 5, z = 5},
                        seed = 1024,
                        octaves = 1,
                        persist = 0.0
                },
        })

minetest.register_ore({
                ore_type         = "blob",
                ore              = "nc_concrete:concrete_cloudstone_vermy",
                wherein          = {"nc_terrain:sand"},
                clust_scarcity   = 10 * 10 * 10,
                clust_size       = 9,
                y_min            = -200,
                y_max            = 200,
                noise_threshold = 0.0,
                noise_params     = {
                        offset = 0.5,
                        scale = 0.2,
                        spread = {x = 5, y = 5, z = 5},
                        seed = 1024,
                        octaves = 1,
                        persist = 0.0
                },
        })
--]]

minetest.register_ore({
                ore_type       = "scatter",
                ore            = "nc_terrain:lava_source",
                wherein        = {"nc_terrain:water_source"},
                clust_scarcity = 2 * 2 * 2,
		clust_num_ores = 5,
                clust_size     = 3,
                y_min          = -200,
                y_max          = 200
        })

minetest.register_ore({
                ore_type       = "scatter",
                ore            = "nc_terrain:lava_flowing",
                wherein        = {"nc_terrain:water_source","nc_terrain:lava_source"},
                clust_scarcity = 2 * 2 * 2,
		clust_num_ores = 5,
                clust_size     = 3,
                y_min          = -200,
                y_max          = 200
        })

minetest.register_ore({
                ore_type         = "scatter",
                ore              = "nc_terrain:lava_flowing",
                wherein          = {"nc_terrain:water_source","nc_terrain:lava_source"},
                clust_scarcity   = 2 * 2 * 2,
		clust_num_ores   = 5,
                clust_size       = 3,
                y_min            = -200,
                y_max            = 200
        })

minetest.register_ore({
                ore_type         = "scatter",
                ore              = "nc_terrain:lava_flowing",
                wherein          = {"nc_terrain:water_source","nc_terrain:lava_source"},
                clust_scarcity   = 2 * 2 * 2,
		clust_num_ores   = 5,
                clust_size       = 3,
                y_min            = -200,
                y_max            = 200
        })
