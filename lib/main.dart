import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'Screens/home_screen.dart';
import 'models/notes_model.dart';

void main() async{
WidgetsFlutterBinding.ensureInitialized();
var directory = await getApplicationDocumentsDirectory();
Hive.init(directory.path);
//FOR CONNECTING HIVE
  Hive.registerAdapter(NotesModelAdapter());
  await Hive.openBox<NotesModel>("notes");


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Homescreen(),
    );
  }
}


