-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore, pairs
    = minetest, nodecore, pairs
-- LUALOCALS > ---------------------------------------------------------

local replacements = {}
local function replace(old, new)
	replacements[minetest.get_content_id(old)] = minetest.get_content_id(new)
end

nodecore.register_mapgen_shared({
		label = "pumtastic",
		priority = -1000,
		func = function(minp, maxp, area, data)
			local ai = area.index
			for z = minp.z, maxp.z do
				for y = minp.y, maxp.y do
					local offs = ai(area, 0, y, z)
					for x = minp.x, maxp.x do
						local i = offs + x
						local dd = data[i]
						if replacements[dd] then
							data[i] = replacements[dd]
						end
					end
				end
			end
		end
	})

local oldsound = nodecore.sound_play

--replace("nc_sponge:sponge_living","nc_pumsponge:pumsponge_zero")
replace("nc_terrain:water_flowing", "air")
replace("nc_terrain:water_source", "nc_terrain:lava_source")
--replace("nc_terrain:lava_flowing", "air")
include("terrain_blobs") 
--replace("nc_pumsponge:zero","nc_pumsponge:pumsponge_glowing")
--include("gen_sponge")
include("pumsalot")
