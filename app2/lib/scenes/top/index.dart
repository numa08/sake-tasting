import 'dart:io';

import 'package:app2/data/database/database.dart';
import 'package:app2/data/database/entitiy/entity.dart';
import 'package:app2/scenes/edit_tasting_note/index.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class TopScene extends StatefulWidget {
  const TopScene({Key key, this.database}) : super(key: key);
  final TastingNoteDatabase database;

  @override
  State createState() => _TopSceneState();
}

class _TopSceneState extends State<TopScene> {
  List<TastingNote> _tastingNotes;

  @override
  void initState() {
    super.initState();
    _reload();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Text('ティスティングノート'),
      ),
      body: _Body(
        tastingNotes: _tastingNotes,
        database: widget.database,
      ),
      floatingActionButton: Builder(
        builder: (context) {
          return FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () async {
              final result = await Navigator.of(context)
                  .pushNamed(EditTastingNoteScene.name);
              if (result == SaveResult.ok) {
                Scaffold.of(context)
                  ..removeCurrentSnackBar()
                  ..showSnackBar(SnackBar(content: const Text('保存しました')));
                _reload();
              }
            },
          );
        },
      ));

  void _reload() async {
    final notes = await widget.database.allTastingNotes();
    setState(() {
      _tastingNotes = notes;
    });
  }
}

class _Body extends StatelessWidget {
  const _Body({Key key, this.tastingNotes, this.database}) : super(key: key);
  final List<TastingNote> tastingNotes;
  final TastingNoteDatabase database;

  @override
  Widget build(BuildContext context) {
    if (tastingNotes?.isEmpty ?? true) {
      return Center(
        child:
            Text('ティスティングノートがありません', style: Theme.of(context).textTheme.body1),
      );
    }
    return ListView.builder(
      itemCount: tastingNotes.length,
      itemBuilder: (context, index) => _buildlabel(tastingNotes[index]),
    );
  }

  Widget _buildlabel(TastingNote note) => FutureBuilder<Widget>(
      future: _listTile(note),
      builder: (context, snapshot) =>
          snapshot.hasData ? snapshot.data : Container());

  Future<Widget> _listTile(TastingNote note) async {
    final sake = await database.findSakeByID(note.sakeID);
    final brewery = await database.findBreweryByID(sake.breweryID);
    final images = await database.findImage(note.tastingNoteID);
    final documentPath = (await getApplicationDocumentsDirectory()).path;
    final image = File(join(documentPath, images[0].name));
    return Builder(
      builder: (context) => InkWell(
        child: Card(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 180,
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: Image.file(image, fit: BoxFit.cover),
                    ),
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                stops: const [
                              0.2,
                              0.3,
                              1.0
                            ],
                                colors: [
                              Colors.black.withAlpha(126),
                              Colors.grey.withAlpha(64),
                              Colors.white.withAlpha(0),
                            ])),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          sake.name,
                          style: Theme.of(context)
                              .textTheme
                              .title
                              .copyWith(color: Theme.of(context).buttonColor),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        onTap: () {
          Navigator.of(context).pushNamed(EditTastingNoteScene.name,
              arguments: note.tastingNoteID);
        },
      ),
    );
  }
}
