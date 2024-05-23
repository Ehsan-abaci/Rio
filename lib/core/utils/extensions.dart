

extension ToMS on Duration {
  String toMs() {
    var minute = inMinutes;
    var second = inSeconds - minute * 60;

    return "${minute < 10 ? "0$minute" : minute}:${second < 10 ? "0$second" : second}";
  }
}

extension PriceChanger on String {
  String to3Dot() {
    String res = '';
    int k = 0;
    for (int i = length - 1; i >= 0; i--) {
      res = this[i] + res;
      k++;
      if (k % 3 == 0 && length != k) {
        res = ",$res";
      }
    }
    return res;
  }
}
