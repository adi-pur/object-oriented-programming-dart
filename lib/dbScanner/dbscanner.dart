import 'package:meta/meta.dart';
import 'package:mysql1/mysql1.dart';
import 'tables.dart';

class DBScanner {
  MySqlConnection _conn;
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
      //mengambil tabel dari database
      await _conn.query('SHOW TABLES').then((value) {
        for (var row in value) {
          row.fields.forEach((key, tableName) async {
            tables().addTable(tableName, null);
          });
        }
      });
      //mengambil isView dari database dan membuat objek
      for (var i = 0; i < tables().countTable(); i++) {
        var table = tables().getTableByIndex(i);

        await _getIsView(dbName, table.name);
        await _getField(dbName, table.name);
      }

      tables().getAllTable();
      print('-----------------------------------------');
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _getIsView(String dbName, String tableName) async {
    await _conn
        .query(
            "SELECT TABLE_TYPE FROM information_schema.tables WHERE TABLE_SCHEMA = '$dbName' AND TABLE_NAME = '$tableName'")
        .then((value) {
      for (var item in value) {
        tables().getTableByName(tableName).isView =
            item.fields['TABLE_TYPE'] == 'BASE TABLE' ? false : true;
      }
    });
  }

  Future<void> _getField(String dbName, String tableName) async {
    await _conn
        .query(
            "SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = '$dbName' AND TABLE_NAME = '$tableName'")
        .then((value) {
      for (var item in value) {
        tables().getTableByName(tableName).fields().addField(
            item.fields['COLUMN_NAME'],
            item.fields['DATA_TYPE'],
            item.fields['CHARACTER_MAXIMUM_LENGTH'] ??
                item.fields['NUMERIC_PRECISION'],
            item.fields['COLUMN_KEY'] == 'PRI' ? true : false,
            item.fields['IS_NULLABLE'] == 'NO' ? false : true);
      }
    });
  }

  Tables tables() => _tables;
}


//? HOW TO USE
// var dbScanner = DBScanner();

//   await dbScanner.scanMySQL(
//       host: 'localhost', port: 3306, dbName: 'belajar', user: 'root');

//   dbScanner
//       .tables()
//       .addTable('mahasiswa', false)
//       .fields()
//       .addField('id', 'int', 11, false, true);
//   dbScanner
//       .tables()
//       .getTableByName('mahasiswa')
//       .fields()
//       .addField('nama', 'varchar', 255, false, false);

//   dbScanner.tables().getAllTable();

//   print(dbScanner
//       .tables()
//       .getTableByName('golongan')
//       .fields()
//       .getFieldByName('id')
//       .dataLength);