import 'package:flutter_local_db/model_classes/employee_model_class.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseService {
  static final DataBaseService _instance = DataBaseService._internal();
  DataBaseService._internal();
  factory DataBaseService() => _instance;

  Future<Database> createDatabase() async {
    var path = await getDatabasesPath();
    return await openDatabase(
      join(path, '/EmployeeDB'),
      version: 1,
      singleInstance: true,
      onCreate: (db, version) {
        db.execute(Employee.createTable);
      },
    );
  }

  Future<bool> insertEmployee(Employee employee) async {
    final db = await createDatabase();
    var rowNo = await db.insert(Employee.tableName, employee.toMap());
    return rowNo > 0;
  }
}
