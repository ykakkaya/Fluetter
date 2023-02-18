import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:list_item/student.dart';

class ListBuilder extends StatefulWidget {
  const ListBuilder({super.key});

  @override
  State<ListBuilder> createState() => _ListBuilderState();
}

class _ListBuilderState extends State<ListBuilder> {
  List<Student> studentsList = List.generate(
      500,
      (index) =>
          Student(index + 1, 'ogrenci ${index + 1}', 'soyad ${index + 1}'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("liste yapısı deneme"),
          backgroundColor: Colors.purple.shade300,
        ),
        body: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            var student = studentsList[index];
            return Card(
              color: index % 2 == 0 ? Colors.amber : Colors.green.shade200,
              child: ListTile(
                  onTap: () {
                    if (index % 2 == 0) {
                      EasyLoading.instance.backgroundColor = Colors.red;
                    } else {
                      EasyLoading.instance.backgroundColor = Colors.teal;
                    }
                    EasyLoading.showToast("Elemente Tıklandı",
                        dismissOnTap: true,
                        toastPosition: EasyLoadingToastPosition.top,
                        duration: Duration(seconds: 2));
                  },
                  title: Text(student.ad),
                  subtitle: Text(student.soyad),
                  leading: CircleAvatar(
                    backgroundColor: Colors.red.shade500,
                    child: Text(
                      student.id.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                  )),
            );
          },
          itemCount: studentsList.length,
        ));
  }
}
