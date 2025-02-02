// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Employee {
  String name;
  int eId;
  double salary;

  static const tableName = 'Employee';
  static const colName = 'name';
  static const colID = 'eid';
  static const colSalary = 'salary';

  static const createTable = "CREATE TABLE IF NOT EXIST $tableName($colID INTEGER PRIMARY KEY AUTOINCREMENT, &colName TEXT NOT NULL, $colSalary REAL NOT NULL)";

  Employee({
    required this.name,
    required this.eId,
    required this.salary,
  });

  Employee copyWith({
    String? name,
    int? eId,
    double? salary,
  }) {
    return Employee(
      name: name ?? this.name,
      eId: eId ?? this.eId,
      salary: salary ?? this.salary,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'eId': eId,
      'salary': salary,
    };
  }

  factory Employee.fromMap(Map<String, dynamic> map) {
    return Employee(
      name: map['name'] as String,
      eId: map['eId'] as int,
      salary: map['salary'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory Employee.fromJson(String source) =>
      Employee.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Employee(name: $name, eId: $eId, salary: $salary)';

  @override
  bool operator ==(covariant Employee other) {
    if (identical(this, other)) return true;

    return other.name == name && other.eId == eId && other.salary == salary;
  }

  @override
  int get hashCode => name.hashCode ^ eId.hashCode ^ salary.hashCode;
}
