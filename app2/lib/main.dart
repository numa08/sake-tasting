import 'package:app2/data/database/database.dart';
import 'package:app2/scenes/edit_tasting_note/index.dart';
import 'package:app2/scenes/top/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

void main() async {
  await Sqflite.setDebugModeOn(true);
  final database =
      TastingNoteDatabase(p.join(await getDatabasesPath(), 'sake_tasting.db'));

  // Enable integration testing with the Flutter Driver extension.
  // See https://flutter.dev/testing/ for more info.
  // enableFlutterDriverExtension();
  runApp(MyApp(
    database: database,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key key, this.database}) : super(key: key);

  final TastingNoteDatabase database;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue),
      home: TopScene(
        database: database,
      ),
      onGenerateRoute: (settings) {
        if (settings.name == EditTastingNoteScene.name) {
          final tastingNoteID = settings.arguments as String;
          return MaterialPageRoute<dynamic>(
              builder: (context) => EditTastingNoteScene(
                    database: database,
                    tastingNoteID: tastingNoteID,
                  ));
        }
        return null;
      },
    );
  }
}
