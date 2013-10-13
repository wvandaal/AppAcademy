var readline = require('readline');
var us = require('underscore');

var rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});


var ttt = {

  TEAMS: ["X", "O"],

  board: [["-","-","-"],
          ["-","-","-"],
          ["-","-","-"]],

  print: function() {
    this.board.forEach(function(elem, i, array) {
      console.log(" " + elem[0] + " | " + elem[1] + " | " + elem[2]);
      if (i != 2)
        console.log("-----------")
    })
  },

  makeMove: function(col,row) {
    console.log(this.TEAMS);
    this.board[row][col] = this.TEAMS[0];
    this.TEAMS = this.TEAMS.reverse();
    if (!this.won()) {
      turn(this);
    } else {
      rl.close();
      console.log("You win!");
    }
  },

  validMove: function(col, row) {
    return (this.board[row][col] == "-")
  },

  won: function() {
    var transposed = us.zip(this.board[0],this.board[1],this.board[2]);
    return (us.include(this.board, ["X", "X", "X"]) ||
    us.include(this.board, ["O", "O", "O"]) ||
    us.include(transposed, ["X", "X", "X"]) ||
    us.include(transposed, ["O", "O", "O"]) ||
    (this.board[0][0] && this.board[1][1] && this.board[2][2]) == "X" ||
    (this.board[0][0] && this.board[1][1] && this.board[2][2]) == "O" ||
    (this.board[0][2] && this.board[1][1] && this.board[2][0]) == "X" ||
    (this.board[0][2] && this.board[1][1] && this.board[2][0]) == "O");
  }

}

function turn(ttt) {
  ttt.print();
  rl.question("Enter a col: ", function(colAns) {
    rl.question("Enter a row: ", function(rowAns) {
      var col = parseInt(colAns),
      row = parseInt(rowAns);

      if (ttt.validMove(col, row)) {
        ttt.makeMove(col, row);
      } else {
        console.log("invalid move.")
        turn(ttt);
      }
    })
  })

}

turn(ttt);