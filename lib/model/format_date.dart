import 'package:intl/intl.dart';


class FormatDate {

  static String getDate() {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd hh:mm:ss');
    String formatted = formatter.format(now);
    return formatted;
  }

  static String labelDateFormat(String date) {
    String labelDate;
    if (date == '') {
      labelDate = '';
    }
    else {
      String year = date.substring(2, 4);
      String month = date.substring(5, 7);
      String day = date.substring(8, 10);

      labelDate = '$day.$month.$year';
    }
    return labelDate;
  }
}