var MyFancyGame = (function () {

	function Ship (name) {
		this.name = name;
	}

	Ship.prototype.power = function() {
		return "power";
	};

	Ship.prototype.turn = function() {
		return "turn";
	};

	Ship.prototype.fireBullet = function() {
		return "fireBullet";
	};

	function Spaceman (name) {
		this.name = name;

		this.walk = function () {return 'walk';};
		this.work = function () {return 'work';};
		this.moonwalk = function () {return 'moonwalk';};
	}

	return {
		Ship: Ship,
		Spaceman: Spaceman
	};
})();
