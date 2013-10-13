var readline = require('readline');
var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});


function crazyBubbleSort (array, i, sortCompletionCallback) {
  var sorted = true;

  var compare = function (el1,el2,compareCallback) {
    reader.question("compare " + el1 + " and " + el2 + " (< : -1, = : 0, > : 1)", function (answer) { compareCallback(parseInt(answer)); })
  };
  var performSortPass = function(arr, i, sortPassCallback) {
    if (i == array.length - 1) {
      sortPassCallback(sorted);
      return;
    }

    compare(array[i], array[i+1], function(response) {
      if (response === 1) {
        var tmp = array[i];
        array[i] = array[i+1];
        array[i+1] = tmp;
        sorted = false;
      }
      performSortPass(array, ++i, sortPassCallback)
    });
  }

  performSortPass(array, i, function(sorted) {
    if (!sorted) {
      sorted = true;
      crazyBubbleSort(array, 0, sortCompletionCallback);
    } else {
      sortCompletionCallback(array);
    }
  });
}

crazyBubbleSort([3,2,1], 0, function (arr) {console.log("Sorted: " + arr);});
