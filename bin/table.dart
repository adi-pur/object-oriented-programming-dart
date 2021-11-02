import 'fields.dart';

class Table {
  String _name;
  bool _isView;

  Fields _fields;

  Table() {
    _fields = Fields();
  }

  Fields fields() => _fields;

  // ignore: unnecessary_getters_setters
  set name(String value) => _name = value;

  // ignore: unnecessary_getters_setters
  String get name => _name;

  // ignore: unnecessary_getters_setters
  set isView(bool value) => _isView = value;

  // ignore: unnecessary_getters_setters
  bool get isView => _isView;

  void show() {
    print('Nama Tabel: $_name');
    print('Data      : $_isView');
  }
}
