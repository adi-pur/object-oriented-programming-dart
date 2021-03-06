import 'table.dart';

class Tables {
  final List<Table> _listTable = [];

  List get listTable => _listTable;

  Table addTable(String name, bool isView) {
    var table = Table();
    table.name = name;
    table.isView = isView;

    _listTable.add(table);
    return table;
  }

  void getAllTable() {
    for (var i = 0; i < _listTable.length; i++) {
      print('------------------- $i -------------------');
      print('Nama Tabel: ${_listTable[i].name}');
      print('isView    : ${_listTable[i].isView}');
      _listTable[i].fields().getAllField();
    }
  }

  // ignore: missing_return
  Table getTableByName(String name) {
    for (var i = 0; i < _listTable.length; i++) {
      if (_listTable[i].name == name) return _listTable[i];
    }
  }

  Table getTableByIndex(int index) => _listTable[index];

  int countTable() {
    return _listTable.length;
  }

  void deleteTableByName(String name) {
    for (var i = 0; i < _listTable.length; i++) {
      if (_listTable[i].name == name) _listTable.removeAt(i);
    }
  }

  void deleteTableByIndex(int index) {
    _listTable.removeAt(index);
  }
}
