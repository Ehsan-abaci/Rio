extension ToMS on Duration {
  String toMs() {
    var minute = inMinutes;
    var second = inSeconds - minute * 60;

    return "${minute < 10 ? "0$minute" : minute}:${second < 10 ? "0$second" : second}";
  }
}

extension ToTime on DateTime {
  String toTime() {
    var hour = this.hour;
    var minute = this.minute ;

    return " ${hour < 10 ? "0$hour" : hour}:${minute < 10 ? "0$minute" : minute}";
  }
}

extension PriceChanger on double {
  String to3Dot() {
    String res = '';
    if (this == 0) return "0.000";
    String str = toStringAsFixed(0);
    int k = 0;
    for (int i = str.length - 1; i >= 0; i--) {
      res = str[i] + res;
      k++;
      if (k % 3 == 0 && str.length != k) {
        res = ".$res";
      }
    }
    return res;
  }
}

extension CardNumberHider on String {
  String toCardNumberHider() {
    String res = '';
    if (length != 16) return "invalid";
    for (int i = 0; i < length; i++) {
      if (i % 4 == 0) res += ' ';
      if (i < 12) {
        res += "*";
      } else {
        res += this[i];
      }
    }
    return res;
  }
}
