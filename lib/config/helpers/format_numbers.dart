

import 'package:intl/intl.dart';

class FormatNumbers{

  static String formatNumbers( double number){

    final formatNumbers = NumberFormat.compactCurrency(
      decimalDigits: 0,
      symbol: ''
    ).format(number);
    return formatNumbers;
  }
}