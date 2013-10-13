Function.prototype.myBind = function(obj) {
  args = Array.prototype.slice.call(arguments)
  bindFunc = this;
  boundFunc = function() {
    return bindFunc.apply(obj, args);
  }
  return boundFunc;
}


var job = {
  name: "bill",

  getName: function() {
    return this.name;
  }
};

var obj = {
  name:"bob"
};

console.log(job.getName.myBind(obj)());