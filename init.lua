minetest.register_chatcommand("mapfix", {
	params = "<size>",
	description = "Recalculate the flowing liquids and the light of a chunk",
	func = function(name, param)
		local pos = minetest.get_player_by_name(name):getpos()
		local size = tonumber(param) or 40

		if size > 50 and not minetest.check_player_privs(name, {server=true}) then
			return false, "You need the server privilege to exceed the radius of 50 blocks"
		end

		local minp = vector.round(vector.subtract(pos, size - 0.5))
		local maxp = vector.round(vector.add(pos, size + 0.5))

		-- use the voxelmanip to fix problems
		local vm = minetest.get_voxel_manip(minp, maxp)
		vm:update_liquids()
		vm:write_to_map()
		vm:update_map()
		return true, "Done."
	end,
})
