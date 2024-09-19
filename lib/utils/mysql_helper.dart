// class MySqlHelper {
//   Future connection() async {
//     try {
//       var settings = ConnectionSettings(host: '127.0.0.1', port: 3308, user: 'root', password: 'Password@123', db: 'boutique', timeout: const Duration(seconds: 60));
//       return MysqlUtils(settings: settings, prefix: '', pool: true);
//     } catch (e) {
//       dnd(e);
//     }
//   }
//
// Future init() async {
//   var con = await MySqlConnection.connect(ConnectionSettings(host: 'localhost', port: 3308, user: 'root', password: 'Password@123', db: 'boutique'));
//   // var q = await con.query("INSERT INTO `bq_admin` (id, surname, first_name, blocked, active) VALUES('3', 'Victor', 'Blessed', 0, 1)");
//   var q = await con.query("SELECT * FROM `bq_admin` WHERE id = ?", ['pubs']);
//   for (var row in q) {
//     print('Name: ${row[0]}, email: ${row[1]}');
//   }
//   print('DND: ' + q.fields.toString());
//   return con;
// }
//
// Future close() async {
//   await _conn.close();
// }
//
// Future createTable(String sql) async {
//   await _conn.query(sql);
// }
//
// Future insert(String table, Map<String, dynamic> data) async {
//   String sql = 'INSERT INTO $table (';
//   List params = [];
//   String values = '';
//   data.forEach((key, value) {
//     sql += values.isNotEmpty ? ', $key' : key;
//     values += values.isNotEmpty ? ', ?' : '?';
//
//     params.add(value);
//   });
//   sql += ') VALUES($values)';
//   print(sql);
//   print(params);
//   _conn = await init();
//   var result = await _conn.query(sql, params);
//   await _conn.close();
//   return result.insertId;
// }
//
// Future select(String sql, List? params) async {
//   var result = await _conn.query(sql, params);
//   return result;
//   //   for (var row in results) {
//   //     print('Name: ${row[0]}, email: ${row[1]} age: ${row[2]}');
//   //   }
// }
//
// Future update(String sql, List? params) async {
//   await _conn.query('update users set age=? where name=?', [26, 'Bob']);
// }
// }
