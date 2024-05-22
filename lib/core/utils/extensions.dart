

extension ToMS on Duration {
  String toMs() {
    var minute = inMinutes;
    var second = inSeconds - minute * 60;

    return "${minute < 10 ? "0$minute" : minute}:${second < 10 ? "0$second" : second}";
  }
}