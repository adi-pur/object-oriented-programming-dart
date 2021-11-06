import 'field.dart';

class Fields {
  final List<Field> _listField = [];

  Field addField(String name, String dataType, int dataLength,
      bool isPrimaryKey, bool isNull) {
    var field = Field();
    field.name = name;
    field.dataType = dataType;
    field.dataLength = dataLength;
    field.isPrimaryKey = isPrimaryKey;
    field.isNull = isNull;

    _listField.add(field);
    return field;
  }

  void getAllField() {
    for (var i = 0; i < _listField.length; i++) {
      print('   ↳ Nama Field  : ${_listField[i].name}');
      print(
          '     ↳ Data      : ${_listField[i].dataType}(${_listField[i].dataLength})');
      print('     ↳ isPrimary : ${_listField[i].isPrimaryKey}');
      print('     ↳ isNull    : ${_listField[i].isNull}');
    }
  }

  // ignore: missing_return
  Field getFieldByName(String name) {
    for (var i = 0; i < _listField.length; i++) {
      if (_listField[i].name == name) return _listField[i];
    }
  }

  Field getFieldByIndex(int index) => _listField[index];

  int countField() {
    return _listField.length;
  }

  void deleteField(String name) {
    for (var i = 0; i < _listField.length; i++) {
      if (_listField[i].name == name) _listField.removeAt(i);
    }
  }
}
