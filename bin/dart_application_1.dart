import 'dbscanner.dart';

Future<void> main(List<String> arguments) async {
  var dbScanner = DBScanner();

  await dbScanner.scanMySQL(
      host: 'localhost', port: 3306, dbName: 'belajar', user: 'root');

  dbScanner
      .tables()
      .addTable('mahasiswa', false)
      .fields()
      .addField('id', 'int', 11, false, true);
  dbScanner
      .tables()
      .getTableByName('mahasiswa')
      .fields()
      .addField('nama', 'varchar', 255, false, false);
  // dbScanner
  //     .tables()
  //     .addTable('test', false)
  //     .fields()
  //     .addField('id', 'int', 11, false, true);

  dbScanner.tables().getAllTable();

  print(dbScanner
      .tables()
      .getTableByName('golongan')
      .fields()
      .getFieldByName('id')
      .dataLength);

  // dbScanner.tables().deleteTable('users');
  // dbScanner.tables().getTable('golongan').fields().deleteField('id');
  // dbScanner.tables().getTable('mahasiswa').show();
}
