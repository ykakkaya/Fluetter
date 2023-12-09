import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:todo/data/local_storage.dart';
import 'package:todo/helper/lang_helper.dart';
import 'package:todo/main.dart';
import 'package:todo/models/task.dart';
import 'package:todo/service/notification_service.dart';
import 'package:todo/widgets/custom_search_delegate.dart';
import 'package:todo/widgets/task_show.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late LocalStorage _localStorage;
  late List<Task> _allTasks;
  @override
  void initState() {
    _localStorage = locator<LocalStorage>();
    _allTasks = [];
    _getAllTaskFromDb();
    tz.initializeTimeZones();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("appbarTitle").tr(),
        actions: [
          IconButton(
              onPressed: () {
                _showSearch();
              },
              icon: const Icon(Icons.search)),
          IconButton(
              onPressed: () {
                _showAddTask(context);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: _allTasks.isNotEmpty
          ? ListView.builder(
              itemCount: _allTasks.length,
              itemBuilder: (context, index) {
                var task = _allTasks[index];
                return Dismissible(
                    direction: DismissDirection.startToEnd,
                    background: Container(
                      color: Colors.red,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.delete,
                            size: MediaQuery.of(context).size.height * 0.06,
                            color: Colors.white,
                          ),
                          const Text(
                            'removeTask',
                            style: TextStyle(color: Colors.white),
                          ).tr(),
                        ],
                      ),
                    ),
                    key: Key(task.id.toString()),
                    onDismissed: (direction) async {
                      _allTasks.removeAt(index);
                      await _localStorage.deleteTask(task: task);
                      setState(() {});
                    },
                    child: TaskShow(task: task));
              },
            )
          : Center(child: const Text('emptyTask').tr()),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.purple.shade200,
          onPressed: () {
            _showAddTask(context);
          },
          child: const Icon(Icons.add)),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
    );
  }

  void _showAddTask(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: TextField(
            autofocus: true,
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.blue.shade50,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                hintText: 'addTask'.tr()),
            onSubmitted: (value) {
              Navigator.pop(context);

              DatePicker.showDateTimePicker(context,
                  locale: LanguageHelper.getDeviceLang(context),
                  onConfirm: (time) async {
                if (value.isNotEmpty) {
                  var newTask = Task.create(value, time);

                  _allTasks.add(newTask);
                  _allTasks.sort(
                    (a, b) => a.createdDate.compareTo(b.createdDate),
                  );
                  await _localStorage.addTask(task: newTask);

                  NotificationService.showScheduleNotification(
                    task: newTask,
                  );
                  setState(() {});
                }
              });
            },
          ),
        );
      },
    );
  }

  void _getAllTaskFromDb() async {
    _allTasks = await _localStorage.getAllTask();

    setState(() {});
  }

  Future<void> _showSearch() async {
    await showSearch(
        context: context, delegate: CustomSearchDelegate(allTasks: _allTasks));

    _getAllTaskFromDb();
  }
}
