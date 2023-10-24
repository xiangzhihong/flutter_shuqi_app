
class TimeUtil {
  formatTime(var timeStamp) {
    var time = timeStamp.millisecondsSinceEpoch;
    var date = DateTime.fromMillisecondsSinceEpoch(time);
    return date;
  }
}
