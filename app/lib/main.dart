import 'dart:async';

import 'package:app/data/database/database.dart';
import 'package:app/model/model.dart';
import 'package:app/scene/edit_tasting_note/index.dart';
import 'package:app/scene/show_tasting_note/index.dart';
import 'package:app/scene/top/index.dart';
import 'package:app/services/service.dart';
import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

void main() async {
//  await Sqflite.setDebugModeOn(true);
  final database =
      TastingNoteDatabase(p.join(await getDatabasesPath(), 'sake_tasting.db'));

  final tastingNoteModel = TastingNoteModel(database);
  final editTastingNoteModel = EditTastingNoteModel(database);

  editTastingNoteModel.onSaveSuccess.listen((_) => tastingNoteModel.fetchAll());

  runApp(ServiceProvider(
    tastingNoteModel: TastingNoteModel(database),
    editTastingNoteModel: EditTastingNoteModel(database),
    child: App(),
  ));
}

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<App> {
  final _subscriptions = <StreamSubscription<dynamic>>[];

  @override
  void initState() {
    super.initState();
    final serviceProvider = ServiceProvider.of(context);
    setState(() {
      _subscriptions.add(serviceProvider.editTastingNoteModel.onSaveSuccess
          .listen((_) => serviceProvider.tastingNoteModel.fetchAll()));
    });
  }

  @override
  Widget build(BuildContext context) => BlocProviderTree(
        blocProviders: [
          EditTastingNoteProvider(),
          TopProvider(),
          ShowTastingNoteProvider()
        ],
        child: MaterialApp(
          title: 'ティスティングノート',
          theme: ThemeData(),
          home: TopScene(),
          routes: {
            EditTastingNoteScene.name: (context) => EditTastingNoteScene(),
            ShowTastingNoteScene.name: (context) => ShowTastingNoteScene(),
          },
        ),
      );

  @override
  void dispose() async {
    await Future.wait<dynamic>(_subscriptions.map((s) => s.cancel()));
    final serviceProvider = ServiceProvider.of(context);
    await serviceProvider.editTastingNoteModel.close();
    await serviceProvider.tastingNoteModel.close();
    super.dispose();
  }
}
