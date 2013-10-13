var readline = require('readline');
var us = require('underscore');
var PEGS = ['left', 'right', 'center'];

var rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

tower = {
  left: [3,2,1],
  center: [],
  right: [],

  makeMove: function(to, from) {
    this[to].push(this[from].pop());
    if (this.won()) {
      rl.close();
      console.log("You win!");
    } else {
      turn(this);
    }
  },

  print: function() {
    console.log("left:[" + this.left + "] center: [" + this.center + "] right:[" + this.right + "]");
  },

  validMove: function(to, from) {
    return (us.include(PEGS, from) || us.include(PEGS, to)) &&
    this[from][0] && (!this[to][0] || us.last(this[to]) > us.last(this[from]));
  },

  won: function() {
    return (this.left.length == 0 && ( this.center.length == 0 || this.right.length == 0));
  }

}

var turn = function(tower) {
  tower.print();
  rl.question("Enter a peg to move from: ", function(fromAns) {
    rl.question("Enter a peg to move to: ", function(toAns) {
      if (tower.validMove(toAns, fromAns)) {
        tower.makeMove(toAns, fromAns);
      } else {
        console.log("invalid move.")
        turn(tower);
      }
    })
  })
}

turn(tower);

