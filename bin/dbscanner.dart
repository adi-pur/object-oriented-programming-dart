import 'package:meta/meta.dart';
import 'package:mysql1/mysql1.dart';
import 'tables.dart';

class DBScanner {
  MySqlConnection _conn;
  final List _listTable = [];
  Tables _tables;

  DBScanner() {
    _tables = Tables();
  }

  Future<void> scanMySQL(
      {@required String host,
      @required int port,
      @required String dbName,
      @required String user}) async {
    try {
      _conn = await MySqlConnection.connect(
          ConnectionSettings(host: host, port: port, user: user, db: dbName));

      print('---Connect To Database $dbName Success---');
      //mengambil tabel dari database untuk sementara
      await _conn.query('SHOW TABLES').then((value) {
        for (var row in value) {
          row.fields.forEach((key, tableName) async {
            _listTable.add(tableName);
          });
        }
      });
      //mengambil isView dari database dan membuat objek
      for (var i = 0; i < _listTable.length; i++) {
        await _conn
            .query(
                "SELECT TABLE_TYPE FROM information_schema.tables WHERE TABLE_SCHEMA = '$dbName' AND TABLE_NAME = '${_listTable[i]}'")
            .then((value) {
          for (var item in value) {
            tables().addTable(_listTable[i],
                item.fields['TABLE_TYPE'] == 'BASE TABLE' ? false : true);
          }
        });
        await _getField(dbName, _listTable[i]);
      }

      tables().getAllTable();
      print('-----------------------------------------');
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _getField(String dbName, String tableName) async {
    await _conn
        .query(
            "SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = '$dbName' AND TABLE_NAME = '$tableName'")
        .then((value) {
      for (var item in value) {
        tables().getTable(tableName).fields().addField(
            item.fields['COLUMN_NAME'],
            item.fields['DATA_TYPE'],
            item.fields['DATA_TYPE'] == 'int'
                ? 11
                : item.fields['CHARACTER_MAXIMUM_LENGTH'],
            item.fields['COLUMN_KEY'] == 'PRI' ? true : false,
            item.fields['IS_NULLABLE'] == 'NO' ? false : true);
      }
    });
  }

  Tables tables() => _tables;
}
