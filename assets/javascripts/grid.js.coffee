window.Grid = class Grid extends fabric.Group

	constructor: () ->
		super

		pixel_size = 10
		rows = 6
		cols = 5
		fill = "#999"

		for y in [1..6]
			scaled_y = y * pixel_size
			@add new fabric.Line [0, scaled_y, cols * pixel_size, scaled_y],
				fill: fill

		for x in [1..5]
			scaled_x = x * pixel_size
			@add new fabric.Line [scaled_x, 0, scaled_x, rows * pixel_size],
				fill: fill