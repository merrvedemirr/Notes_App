import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:notes_app/View/screens/dashboard.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  //* veritabanını hazırlıyoruz.
  WidgetsFlutterBinding.ensureInitialized();
  //*app dizini alıyoruz.
  final dir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(dir.path); //*hive dizinde başlatılıyor.

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NoteApp',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Dashboard(),
    );
  }
}
