function terminalClock(){
  var time = new Date();
  setInterval(function() {
    time.setSeconds((time.getSeconds() + 5));
    console.log(time.getHours() + ":" + time.getMinutes() + ":" + time.getSeconds());
  }, 5000);
}
terminalClock();
