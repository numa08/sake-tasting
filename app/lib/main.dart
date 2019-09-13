import 'package:app/data/database/database.dart';
import 'package:app/model/model.dart';
import 'package:app/scene/edit_tasting_note/index.dart';
import 'package:app/services/service.dart';
import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  await Sqflite.setDebugModeOn(true);
  final database =
      TastingNoteDatabase(join(await getDatabasesPath(), 'sake_tasting.db'));
  runApp(ServiceProvider(
    editTastingNoteModel: EditTastingNoteModel(database),
    child: App(),
  ));
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) => BlocProviderTree(
        blocProviders: [EditTastingNoteProvider()],
        child: MaterialApp(
          title: 'ティスティングノート',
          theme: ThemeData(),
          home: EditTastingNoteScene(),
        ),
      );
}
