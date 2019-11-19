import 'package:app2/data/database/database.dart';
import 'package:app2/data/database/entitiy/entity.dart';
import 'package:app2/scenes/edit_tasting_note/index.dart';
import 'package:flutter/material.dart';

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

  Widget _buildlabel(TastingNote note) => FutureBuilder<ListTile>(
      future: _listTile(note),
      builder: (context, snapshot) =>
          snapshot.hasData ? snapshot.data : Container());

  Future<ListTile> _listTile(TastingNote note) async {
    final sake = await database.findSakeByID(note.sakeID);
    final brewery = await database.findBreweryByID(sake.breweryID);
    return ListTile(
      title: Text(sake.name),
      subtitle: Text(brewery.name),
    );
  }
}
