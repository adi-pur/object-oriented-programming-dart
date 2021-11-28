import 'dart:io';

import 'package:dart_application_1/base/base62.dart';

Future<void> main(List<String> arguments) async {
  var base62 = Base62();
  int num;
  // List<int> result = [];
  num = int.tryParse(stdin.readLineSync());
  print(base62.toBase62(num));

  var a = stdin.readLineSync();
  print(base62.toDecimal(a));

  // while (num > 0) {
  //   result.add(num % 62);
  //   num = (num / 62).floor();
  // }

  // print(result.reversed.toList().toString());
}
