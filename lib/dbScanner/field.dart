class Field {
  var field = {};
  String _name, _dataType;
  bool _isPrimaryKey, _isNull;
  int _dataLength;

  // ignore: unnecessary_getters_setters
  set name(String value) => _name = value;

  // ignore: unnecessary_getters_setters
  String get name => _name;

  // ignore: unnecessary_getters_setters
  set dataType(String value) => _dataType = value;

  // ignore: unnecessary_getters_setters
  String get dataType => _dataType;

  // ignore: unnecessary_getters_setters
  set isPrimaryKey(bool value) => _isPrimaryKey = value;

  // ignore: unnecessary_getters_setters
  bool get isPrimaryKey => _isPrimaryKey;

  // ignore: unnecessary_getters_setters
  set isNull(bool value) => _isNull = value;

  // ignore: unnecessary_getters_setters
  bool get isNull => _isNull;

  // ignore: unnecessary_getters_setters
  set dataLength(int value) => _dataLength = value;

  // ignore: unnecessary_getters_setters
  int get dataLength => _dataLength;

  void show() {
    print('Nama Field: $_name');
    print('Data      : $_dataType($_dataLength)');
    print('isPrimary : $_isPrimaryKey');
    print('isNull    : $_isNull');
  }
}
