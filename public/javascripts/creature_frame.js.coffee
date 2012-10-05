window.CreatureFrame = class CreatureFrame extends fabric.Group

	constructor: (options) ->
		super

		@data = new CreatureData(3, 6)
		@pixel_size = 10
		@half_pixel_size = @pixel_size / 2

		for data_y, y in ([0...@data.rows.length])
			for data_x, x in [0...@data.rows[data_y].length].concat [1, 0]
				p = @data.rows[data_y][data_x]
				if p
					@add new fabric.Rect
						top: y * @pixel_size + @half_pixel_size
						left: x * @pixel_size + @half_pixel_size
						width: @pixel_size
						height: @pixel_size

	mutate: (chance) ->
		new CreatureFrame(@data.mutate(chance))