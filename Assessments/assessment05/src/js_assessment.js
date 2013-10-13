JSA = {};

JSA.twoSum = function (arr) {
	for (var i = 0; i < arr.length; i++) {
		for (var j = i+1; j < arr.length; j++) {
			if (arr[i] + arr[j] == 0)
				return true;
		}
	}
	return false;
};

JSA.factors = function (num) {
	factors = [1];
	for (var i = 2; i <= num; i++) {
		if (num % i == 0)
			factors.push(i);
	}
	return factors;
}

JSA.fibonacci = function (num) {
	var fibs = [0, 1]
	if (num <= 2)
		return fibs[num-1]
	for (var i = num - 2; i > 0; i--) {
		fibs.push(fibs[fibs.length - 2] + fibs[fibs.length - 1]);
	}
	return fibs[fibs.length - 1];
}


JSA.myBind = function(func, obj) {
  var fbind = func;
  var boundFunc = function(args) {
  	var aArgs = [].slice.call(arguments);
    fbind.apply(obj, aArgs);
  };
  return boundFunc;
};

JSA.addThenDo = function(n1, n2, callback) {
	var sum = n1 + n2;
	callback(n1, n2);

	return sum;
}

JSA.inherits = function (child, parent) {
	// function Surrogate () {};

	// Surrogate.prototype = new parent();

	child.prototype = parent.prototype;
}

// ...
