// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
part 'task.g.dart';

@HiveType(typeId: 1)
class Task extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String name;
  @HiveField(2)
  DateTime createdDate;
  @HiveField(3)
  bool isComplated;

  Task(
      {required this.id,
      required this.name,
      required this.createdDate,
      required this.isComplated});

  factory Task.create(String name, DateTime createdDate) {
    return Task(
        id: Uuid().v1(),
        name: name,
        createdDate: createdDate,
        isComplated: false);
  }

  @override
  String toString() {
    return 'Task(id: $id, name: $name, createdDate: $createdDate, isComplated: $isComplated)';
  }
}
