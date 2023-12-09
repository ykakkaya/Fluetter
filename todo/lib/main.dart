import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo/data/hive_local_storage.dart';
import 'package:todo/data/local_storage.dart';
import 'package:todo/models/task.dart';
import 'package:todo/screens/home.dart';

var locator = GetIt.instance;
void setup() {
  locator.registerSingleton<LocalStorage>(HiveLocalStorage());
}

Future<void> hiveSetup() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  var taskBox = await Hive.openBox<Task>('tasks');
  // taskBox.values.forEach((element) {
  //   if (element.createdDate.day != DateTime.now().day) {
  //     taskBox.delete(element.id);
  //   }
  // });
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
  //   statusBarColor: Colors.blueGrey,
  // ));
  await EasyLocalization.ensureInitialized();
  await hiveSetup();
  setup();
  runApp(EasyLocalization(
      supportedLocales: const [
        Locale('tr', 'TR'),
        Locale('en', 'US'),
        Locale('de', 'DE')
      ],
      path:
          'assets/translations', // <-- change the path of the translation files
      fallbackLocale: const Locale('tr', 'TR'),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.deviceLocale,
      debugShowCheckedModeBanner: false,
      title: 'AJANDA',
      theme: ThemeData(
        appBarTheme: AppBarTheme(color: Colors.purple.shade100, elevation: 0),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Home(),
    );
  }
}
