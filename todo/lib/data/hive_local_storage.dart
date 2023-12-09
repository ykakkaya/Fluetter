import 'package:hive/hive.dart';
import 'package:todo/data/local_storage.dart';
import 'package:todo/models/task.dart';

class HiveLocalStorage extends LocalStorage {
  late Box<Task> _taskBox;
  HiveLocalStorage() {
    _taskBox = Hive.box<Task>('tasks');
  }
  @override
  Future<void> addTask({required Task task}) async {
    await _taskBox.put(task.id, task);
  }

  @override
  Future<bool> deleteTask({required Task task}) async {
    await task.delete();
    return true;
  }

  @override
  Future<List<Task>> getAllTask() async {
    List<Task> _alltasks = <Task>[];
    _alltasks = await _taskBox.values.toList();
    if (_alltasks.isNotEmpty) {
      _alltasks.sort(((a, b) => a.createdDate.compareTo(b.createdDate)));
      return _alltasks;
    } else {
      return _alltasks;
    }
  }

  @override
  Future<Task?> getTask({required String id}) async {
    if (_taskBox.containsKey(id)) {
      return await _taskBox.get(id);
    } else {
      return null;
    }
  }

  @override
  Future<Task> updateTask({required Task task}) async {
    await task.save();
    return task;
  }
}
