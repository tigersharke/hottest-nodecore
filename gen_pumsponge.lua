-- LUALOCALS < ---------------------------------------------------------
local math, minetest, nodecore
    = math, minetest, nodecore
local math_floor
    = math.floor
-- LUALOCALS > ---------------------------------------------------------

local modname = minetest.get_current_modname()

local maxy = -8
local miny = maxy - 8

local c_hardstone1 = minetest.get_content_id("nc_terrain:hard_stone_1")
local c_hardstone2 = minetest.get_content_id("nc_terrain:hard_stone_2")
local c_hardstone3 = minetest.get_content_id("nc_terrain:hard_stone_3")
local c_hardstone4 = minetest.get_content_id("nc_terrain:hard_stone_4")
local c_hardstone5 = minetest.get_content_id("nc_terrain:hard_stone_5")
local c_hardstone6 = minetest.get_content_id("nc_terrain:hard_stone_6")
local c_hardstone7 = minetest.get_content_id("nc_terrain:hard_stone_7")
local c_lava = minetest.get_content_id("nc_terrain:lava_source")
local c_psponge = minetest.get_content_id("nc_psponge:psponge_glowing")

local function spawn(area, data, x, y, z, rng)
	local total = 0
	nodecore.scan_flood({x = x, y = y, z = z}, 5, function(p)
			if rng() < 0.01 then return true end
			if p.y > y and rng() > 0.1 then return false end
			local idx = area:index(p.x, p.y - 1, p.z)
			if data[idx] ~= c_psponge and data[idx] ~= c_sand then return false end
			idx = area:index(p.x, p.y, p.z)
			if data[idx] ~= c_lava then return false end
			data[idx] = c_psponge
			total = total + 1
			if total >= 20 then return true end
		end)
end

nodecore.register_mapgen_shared({
		label = "sponges",
		func = function(minp, maxp, area, data, _, _, _, rng)
			if minp.y > maxy or maxp.y < miny then return end

			local rawqty = rng() * (maxp.x - minp.x + 1)
			* (maxp.z - minp.z + 1) / (64 * 64)
			local qty = math_floor(rawqty)
			if rng() < (rawqty - qty) then qty = qty + 1 end

			for _ = 1, qty do
				local x = math_floor(rng() * (maxp.x - minp.x + 1)) + minp.x
				local z = math_floor(rng() * (maxp.z - minp.z + 1)) + minp.z
				local starty = maxp.y
				if starty > (maxy + 1) then starty = (maxy + 1) end
				local endy = minp.y
				if endy < miny then endy = miny end
				local pumwaterabove = nil
				for y = starty, endy, -1 do
					local idx = area:index(x, y, z)
					local cur = data[idx]
					if cur == c_pwater then
						pumwaterabove = true
					elseif cur == c_hardstone1 and pumwaterabove then
						spawn(area, data, x, y + 1, z, rng)
						break
					elseif cur == c_hardstone2 and pumwaterabove then
						spawn(area, data, x, y + 1, z, rng)
						break
					elseif cur == c_hardstone3 and pumwaterabove then
						spawn(area, data, x, y + 1, z, rng)
						break
					elseif cur == c_hardstone4 and pumwaterabove then
						spawn(area, data, x, y + 1, z, rng)
						break
					elseif cur == c_hardstone5 and pumwaterabove then
						spawn(area, data, x, y + 1, z, rng)
						break
					elseif cur == c_hardstone6 and pumwaterabove then
						spawn(area, data, x, y + 1, z, rng)
						break
					elseif cur == c_hardstone7 and pumwaterabove then
						spawn(area, data, x, y + 1, z, rng)
						break
					else
						break
					end
				end
			end
		end
	})
