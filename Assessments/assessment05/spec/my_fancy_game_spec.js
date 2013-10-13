describe("MyFancyGame", function() {
  it("should have MyFancyGame defined on the global object", function() {
    expect(MyFancyGame).toBeDefined();
  });

  it("should have Ship defined on MyFancyGame", function() {
    expect(MyFancyGame.Ship).toBeDefined();
  });

  it("should not have Ship defined on window", function() {
    expect(window.Ship).toBeUndefined();
  });

  it("should have Spaceman defined on MyFancyGame", function() {
    expect(MyFancyGame.Spaceman).toBeDefined();
  });
  
  it("should not have Spaceman defined on window", function() {
    expect(window.Spaceman).toBeUndefined();
  });
  
  it("should not have Ship's methods defined on window", function() {
    expect(window.power).toBeUndefined();
    expect(window.turn).toBeUndefined();
    expect(window.fireBullet).toBeUndefined();
  });
  
  it("should not have Spaceman's methods defined on window", function() {
    expect(window.walk).toBeUndefined();
    expect(window.work).toBeUndefined();
    expect(window.moonwalk).toBeUndefined();
  });

  it("should allow creation of a Ship with the proper methods", function() {
    var ship = new MyFancyGame.Ship('A');

    expect(ship.name).toBe('A');
    expect(ship.power()).toBe('power');
    expect(ship.turn()).toBe('turn');
    expect(ship.fireBullet()).toBe('fireBullet');
  });
  
  it("should allow creation of a Spaceman with the proper methods", function() {
    var spaceman = new MyFancyGame.Spaceman('B');

    expect(spaceman.name).toEqual('B');
    expect(spaceman.walk()).toEqual('walk');
    expect(spaceman.work()).toEqual('work');
    expect(spaceman.moonwalk()).toEqual('moonwalk');
  });
  
});

