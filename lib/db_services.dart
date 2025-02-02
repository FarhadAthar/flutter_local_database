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

  Future<bool> updateEmployee(Employee employee) async {
    final db = await createDatabase();
    var rowNo = await db.update(Employee.tableName, employee.toMap(),
        where: '${Employee.colID} = ?', whereArgs: [employee.eId]);
    return rowNo > 0;
  }

  Future<bool> deleteEmployee(Employee employee) async {
    final db = await createDatabase();
    var rowNo = await db.delete(Employee.tableName,
        where: '${Employee.colID} = ?', whereArgs: [employee.eId]);
    return rowNo > 0;
  }

  Future<List<Employee>> getAllEmployees() async {
    final db = await createDatabase();
    var rows = await db.rawQuery('SELECT * FROM ${Employee.tableName}');
    return rows.map((e) => Employee.fromMap(e)).toList();
  }
}
