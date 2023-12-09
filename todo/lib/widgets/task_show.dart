// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:todo/data/local_storage.dart';
import 'package:todo/helper/lang_helper.dart';
import 'package:todo/main.dart';
import 'package:todo/models/task.dart';
import 'package:todo/service/notification_service.dart';

// ignore: must_be_immutable
class TaskShow extends StatefulWidget {
  Task task;
  TaskShow({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  State<TaskShow> createState() => _TaskShowState();
}

class _TaskShowState extends State<TaskShow> {
  bool isComplate = false;
  TextEditingController taskName = TextEditingController();
  late LocalStorage _localStorage;
  @override
  void initState() {
    _localStorage = locator<LocalStorage>();
    taskName.text = widget.task.name;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: widget.task.isComplated == true
          ? Colors.grey.shade200
          : Colors.amber.shade200,
      child: GestureDetector(
        onTap: () async {
          widget.task.isComplated = !widget.task.isComplated;
          await _localStorage.updateTask(task: widget.task);
          setState(() {});
        },
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor:
                widget.task.isComplated == true ? Colors.green : Colors.red,
            child: Icon(
              widget.task.isComplated == true
                  ? Icons.check
                  : Icons.error_outlined,
              color: Colors.white,
            ),
          ),
          title: Column(
            children: [
              Text(
                      widget.task.isComplated == false
                          ? 'taskName'
                          : 'successTask',
                      style: widget.task.isComplated == true
                          ? const TextStyle(
                              decoration: TextDecoration.lineThrough)
                          : const TextStyle())
                  .tr(),
              Text(
                  widget.task.isComplated == false
                      ? widget.task.name.toString()
                      : widget.task.name.toString(),
                  style: widget.task.isComplated == true
                      ? const TextStyle(decoration: TextDecoration.lineThrough)
                      : const TextStyle()),
              Text(
                'taskDate',
                style: widget.task.isComplated == true
                    ? const TextStyle(decoration: TextDecoration.lineThrough)
                    : const TextStyle(),
                textAlign: TextAlign.center,
              ).tr(),
              Text(
                widget.task.createdDate.toString().substring(0, 16),
                style: widget.task.isComplated == true
                    ? const TextStyle(decoration: TextDecoration.lineThrough)
                    : const TextStyle(),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          trailing: IconButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Container(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: TextField(
                        autofocus: true,
                        controller: taskName,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.blue.shade50,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                        ),
                        onSubmitted: (value) async {
                          widget.task.name = value;
                          await _localStorage.updateTask(task: widget.task);
                          setState(() {});

                          // ignore: use_build_context_synchronously
                          Navigator.pop(context);

                          // ignore: use_build_context_synchronously
                          DatePicker.showDateTimePicker(context,
                              locale: LanguageHelper.getDeviceLang(context),
                              onConfirm: (time) async {
                            if (value.isNotEmpty) {
                              NotificationService.deleteNotification(
                                  widget.task);
                              widget.task.createdDate = time;
                              await _localStorage.updateTask(task: widget.task);
                              NotificationService.showScheduleNotification(
                                task: widget.task,
                              );
                              setState(() {});
                            }
                          });
                        },
                      ),
                    );
                  },
                );
              },
              icon: const Icon(Icons.edit)),
        ),
      ),
    );
  }
}
