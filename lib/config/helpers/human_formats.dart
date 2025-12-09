import 'package:intl/intl.dart';

class HumanFormats {
  static String number(double number, {required int decimals}) {
    final formattedNumber = NumberFormat.compact(
      locale: 'en',
    ).format(number);
    return formattedNumber;
  }
}
