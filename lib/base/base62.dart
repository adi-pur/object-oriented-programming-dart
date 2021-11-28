import 'dart:math';

class Base62 {
  final Map<int, String> _alphabets = {};

  Base62() {
    for (var i = 0; i <= 9; i++) {
      _alphabets[_alphabets.length] = i.toString();
    }

    for (var i = 65; i <= 90; i++) {
      _alphabets[_alphabets.length] = String.fromCharCode(i);
    }

    for (var i = 97; i <= 122; i++) {
      _alphabets[_alphabets.length] = String.fromCharCode(i);
    }
  }

  String toBase62(int number) {
    var resultTemporary = <int>[];
    var result = '';

    while (number > 0) {
      resultTemporary.add(number % 62);
      number = (number / 62).floor();
    }

    var resultreversed = resultTemporary.reversed.toList();
    for (var item in resultreversed) {
      result += _alphabets[item];
    }
    return result;
  }

  int toDecimal(String base62) {
    var list = base62.replaceAll(' ', '').split('').reversed.toList();
    var result = 0;

    for (var j = 0; j < list.length; j++) {
      for (var i = 0; i < _alphabets.length; i++) {
        if (_alphabets[i] == list[j]) {
          result += i * pow(62, j);
        }
      }
    }

    return result;
  }
}
