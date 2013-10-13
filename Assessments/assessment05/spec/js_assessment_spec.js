describe("twoSum", function() {
  it("should determine whether two numbers in an array sum to zero", function() {
    var trueArr = [1, 2, 3, 4, -2];
    var falseArr = [1, 2, 3, 4];
    expect(JSA.twoSum(trueArr)).toBe(true);
    expect(JSA.twoSum(falseArr)).toBe(false);
  });

  it("should return false for one zero", function() {
    var oneZero = [0, 1, 2, 3, 4];
    expect(JSA.twoSum(oneZero)).toBe(false);
  });

  it("should return true for two zeros", function() {
    var twoZeros = [0, 0, 3, 4, 5];
    expect(JSA.twoSum(twoZeros)).toBe(true);
  });
});

describe("factors", function() {
  it("should return the factors for a number", function() {
    expect(JSA.factors(10)).toEqual([1, 2, 5, 10]);
    expect(JSA.factors(21)).toEqual([1, 3, 7, 21]);
  });

  it("should handle 1 correctly", function() {
    expect(JSA.factors(1)).toEqual([1]);
  });
});

describe("fibonacci", function() {
  it("should return the Nth fibonacci number", function() {
    expect(JSA.fibonacci(10)).toBe(34);
    expect(JSA.fibonacci(20)).toBe(4181);
  });

  it("should work for 1 and 2", function() {
    expect(JSA.fibonacci(1)).toBe(0);
    expect(JSA.fibonacci(2)).toBe(1);
  });
});

describe("myBind", function() {
  it("should take a function and bind the given context", function() {
    var myObj = {};
    var myFunc = function() {
      this.name = "John";
    };

    var myBoundFunc = JSA.myBind(myFunc, myObj);

    myBoundFunc();
    expect(myObj.name).toEqual("John");
  });

  it("should correctly handle a function bound multiple times", function() {
    var myObj = {};
    var pushyObj = {};

    var myFunc = function() {
      this.name = "John";
    };

    var myBoundFunc = JSA.myBind(myFunc, myObj);
    var myDoublyBoundFunc = JSA.myBind(myBoundFunc, pushyObj);

    myDoublyBoundFunc();
    expect(myObj.name).toEqual("John");
    expect(pushyObj.name).toBeUndefined();
  });

  it("should pass through any given arguments", function() {
    var myObj = { count: 10 }
    var adder = function (x, y, z) { this.count += (x + y + z); };

    var boundAdder = JSA.myBind(adder, myObj);
    boundAdder(3, 4, 5);

    expect(myObj.count).toBe(22);
  });
});

describe("addThenDo", function() {
    it("should add two numbers and return their sum", function() {
      var counter = function() {};
      expect(JSA.addThenDo(3, 4, counter)).toBe(7);
    });

    it("should take a callback and call it", function() {
      var count = 0;

      var counter = function() {
        count += 1;
      };

      expect(JSA.addThenDo(3, 4, counter)).toBe(7);
      expect(count).toBe(1); 
    });
});

describe("inherits", function() {
  var Animal, Dog, dog;

  beforeEach(function() {
    Animal = function() {
      this.name = "Yogi";
    };

    Animal.prototype.makeNoise = function() { return "Hi!"; };

    Dog = function() {
      this.age = 7;
    };

    JSA.inherits(Dog, Animal);

    Dog.prototype.bark = function() { return "Woof!"; };

    dog = new Dog();
  });

  it("should properly set up the prototype chain between a child and parent", function() {
    expect(dog.bark()).toBe("Woof!");
    expect(dog.makeNoise()).toBe("Hi!");
  });

  it("should not call the parent's constructor function", function() {
    expect(dog.name).toBeUndefined();
  });

  it("should maintain separation of parent and child prototypes", function() {
    Dog.prototype.someProperty = 42;
    var animal = new Animal();
    expect(animal.someProperty).toBeUndefined();
    expect(animal.makeNoise()).toBe("Hi!");
  });

  it("should properly work for longer inheritance chains", function() {
    var Poodle = function() { this.name = "Bill"; };

    JSA.inherits(Poodle, Dog);

    Poodle.prototype.shave = function() { return "Brrr."; };

    var poodle = new Poodle();
    expect(poodle.name).toBe("Bill");
    expect(poodle.shave()).toBe("Brrr.");
    expect(poodle.makeNoise()).toBe("Hi!");
    expect(poodle.bark()).toBe("Woof!");
  });
});

