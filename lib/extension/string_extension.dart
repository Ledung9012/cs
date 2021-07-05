import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:intl/intl.dart';

// Định dạng tiền tệ
final currencyFormat = NumberFormat.currency(locale: "vi", symbol: "đ");
final dateFormat = DateFormat("dd/MM/yyyy");

extension StringExtension on String {
  String removeFirst() {
    return this.substring(1, this.length );
  }

  String toMD5() {
    var bytes = utf8.encode(this); // data being hashed
    var digest = md5.convert(bytes);
    return digest.toString();
  }

  String generateRandomString(int len) {
    var r = Random();
    const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();
  }


  T toEnum<T>(List<T> values) {
    return values.firstWhere(
            (e) =>
        e.toString().toLowerCase().split(".").last == '$this'.toLowerCase(),
        orElse: () => values[0]); //return null if not found
  }
}



extension DateTimeParsing on DateTime {
  String stringValue() {
    return dateFormat.format(this);
  }
}

extension DoubleExtension on double {
  String currencyValue() {
    if(this == 0)
      {
        return "-";
      }
    return currencyFormat.format(this);
  }
}
