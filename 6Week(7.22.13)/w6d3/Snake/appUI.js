var SnakeUI = (function() {

	function SnakeGameUI(elem) {
		this.elem = $(elem);

		this.board = null;
		this.interval = null;
		this.snake = null;
	}

	SnakeGameUI.prototype.processMove = function(event) {
		var that = this;

		if (event.keyCode == 37)
			that.snake.dir = "W";
		if (event.keyCode == 38)
			that.snake.dir = "N";
		if (event.keyCode == 39)
			that.snake.dir = "E"
		if (event.keyCode == 40)
			that.snake.dir = "S";
	}

	SnakeGameUI.prototype.step = function() {
		var that = this;

		that.snake.move();
		that.elem.html(that.board.render());
	};

	SnakeGameUI.prototype.start = function() {
		var that = this;

		that.board = new SnakeGame.Board(20, 20);
		that.snake = new SnakeGame.Snake(that.board);
		that.board.addSnake(that.snake);

		$(window).keydown(that.processMove.bind(that));
    that._startStepLoop();
  };

  SnakeGameUI.prototype._startStepLoop = function () {
    var that = this;

    that.intervalId = window.setInterval(
      that.step.bind(that),
      50
    );
  };

  return {
    SnakeGameUI: SnakeGameUI
  };
})();