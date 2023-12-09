// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo/data/local_storage.dart';
import 'package:todo/main.dart';

import 'package:todo/models/task.dart';
import 'package:todo/widgets/task_show.dart';

class CustomSearchDelegate extends SearchDelegate {
  List<Task> allTasks;
  CustomSearchDelegate({
    required this.allTasks,
  });

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            if (query.isEmpty) {
              null;
            } else {
              query = '';
            }
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return GestureDetector(
      onTap: () {
        close(context, null);
      },
      child: const Icon(
        Icons.arrow_back_ios_new,
        color: Colors.red,
        size: 20,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    var filterdeTasks = allTasks
        .where(
          (element) => element.name.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
    return filterdeTasks.isNotEmpty
        ? ListView.builder(
            itemCount: filterdeTasks.length,
            itemBuilder: (context, index) {
              var item = filterdeTasks[index];
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
                  key: Key(item.id.toString()),
                  onDismissed: (direction) async {
                    if (filterdeTasks.isNotEmpty) {
                      filterdeTasks.removeAt(index);
                      await locator<LocalStorage>().deleteTask(task: item);
                    }
                  },
                  child: TaskShow(task: item));
            },
          )
        : Center(
            child: Text(
              'searchNotFound',
              style: Theme.of(context).textTheme.headlineLarge,
              textAlign: TextAlign.center,
            ).tr(),
          );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
      child: Text(
        'searchPage',
        style: Theme.of(context).textTheme.headlineLarge,
        textAlign: TextAlign.center,
      ).tr(),
    );
  }
}
