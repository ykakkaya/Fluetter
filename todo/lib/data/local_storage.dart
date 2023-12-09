import 'package:todo/models/task.dart';

abstract class LocalStorage {
  Future<void> addTask({required Task task});
  Future<List<Task>> getAllTask();
  Future<Task?> getTask({required String id});
  Future<bool> deleteTask({required Task task});
  Future<Task> updateTask({required Task task});
}
