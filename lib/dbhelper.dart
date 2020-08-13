import 'package:todo_app/model/todo.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static final DbHelper _instance = DbHelper.internal();
  factory DbHelper() => _instance;
  DbHelper.internal();
  static Database _db;
  String table = 'todo';

  Future<Database> createDatabase() async {
    if (_db != null) {
      return _db;
    }

    //define the path to the database
    String path = join(await getDatabasesPath(), 'todo.db');
    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int v) {
        //creat tables
        String sql =
            'create table todo(id integer primary key autoincrement, title varchar(50), description varchar(255), date varchar(50),time varchar(50))';
        db.execute(sql);
      },
    );
    return _db;
  }

  Future<int> createTodo(Todo todo) async {
    Database db = await createDatabase();
    return db.insert(table, todo.toMap());
  }

  Future<List> allTodo() async {
    Database db = await createDatabase();
    return db.query(table);
  }

  Future<int> delete(int id) async {
    Database db = await createDatabase();
    return db.delete(table, where: 'id=?', whereArgs: [id]);
  }

  Future<int> todoUpdate(Todo todo) async {
    Database db = await createDatabase();
    return await db
        .update(table, todo.toMap(), where: 'id = ?', whereArgs: [todo.id]);
  }
}
