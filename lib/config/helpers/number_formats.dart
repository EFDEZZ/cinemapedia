import 'package:intl/intl.dart';

class NumberFormats {

  static String humanFormatNumber(double number) {
    final formatterNumber = NumberFormat.compactCurrency(
      decimalDigits: 0,
      symbol: '',
      locale: 'en',
    ).format(number);

    return formatterNumber;
  }

  static String numberRounded(double number) {
    final formatterNumber = NumberFormat('0.0', 'en_us').format(number);
    return formatterNumber;
  }
}
