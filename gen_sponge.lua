-- LUALOCALS < ---------------------------------------------------------
local math, minetest, nodecore
    = math, minetest, nodecore
local math_floor
    = math.floor
-- LUALOCALS > ---------------------------------------------------------

local modname = minetest.get_current_modname()

local maxy = -8
local miny = maxy - 8

local c_sand = minetest.get_content_id("nc_terrain:sand")
local c_water = minetest.get_content_id("nc_terrain:water_source")
local c_sponge = minetest.get_content_id("nc_sponge:sponge_living")

local function spawn(area, data, x, y, z, rng)
	local total = 0
	nodecore.scan_flood({x = x, y = y, z = z}, 5, function(p)
			if rng() < 0.01 then return true end
			if p.y > y and rng() > 0.1 then return false end
			local idx = area:index(p.x, p.y - 1, p.z)
			if data[idx] ~= c_sponge and data[idx] ~= c_sand then return false end
			idx = area:index(p.x, p.y, p.z)
			if data[idx] ~= c_water then return false end
			data[idx] = c_sponge
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
				local waterabove = nil
				for y = starty, endy, -1 do
					local idx = area:index(x, y, z)
					local cur = data[idx]
					if cur == c_water then
						waterabove = true
					elseif cur == c_sand and waterabove then
						spawn(area, data, x, y + 1, z, rng)
						break
					else
						break
					end
				end
			end
		end
	})
