var SnakeGame = (function () {
	function Coord(x, y){
		this.x = x;
		this.y = y;
	}

	function Snake(board) {
		this.angle = 0;
		this.length = 4;
		this.stepSize = 10;

		this.coords = [/* put 4 initial points here */];
	}

	Snake.prototype.turn = function(dir) {
		var that = this;
		that.angle += (Math.floor(Math.PI/30) * dir);
	};

	Snake.prototype.move = function() {
		var that = this;
		var head = _.last(that.pieces);

		var new_x = that.stepSize * head.x * Math.cos(that.angle);
		var new_y = that.stepSize * head.y * Math.sin(that.angle);

		var new_head = new Coord(new_x, new_y)

		that.coords.push(new_head);
		that.coords.shift();
	};

	Snake.prototype.update = function() {
		var that = this;

		if (key.isPressed("left"))
			that.turn(1);
		if (key.isPressed("right"))
			that.turn(-1);

		that.move();
	};

	Snake.prototype.draw = function(ctx) {
		var that = this;

		_.each(that.coords, function(coord) {
			// 
		}
	};

	return {
		Board: Board,
		Coord: Coord,
		Snake: Snake
	}
})();