import 'package:app2/data/database/database.dart';
import 'package:app2/data/database/entitiy/entity.dart';
import 'package:flutter/material.dart';

class Top extends StatelessWidget {
  const Top({Key key, this.database}) : super(key: key);
  final TastingNoteDatabase database;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('ティスティングノート'),
        ),
        body: _Body(
          database: database,
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => null,
        ),
      );
}

class _Body extends StatelessWidget {
  const _Body({Key key, this.database}) : super(key: key);
  final TastingNoteDatabase database;

  @override
  Widget build(BuildContext context) => FutureBuilder<List<TastingNote>>(
        future: database.allTastingNotes(),
        builder: (context, snapshot) {
          if (snapshot.data?.isEmpty ?? true) {
            return Center(
              child: Text('ティスティングノートがありません',
                  style: Theme.of(context).textTheme.body1),
            );
          }
          final notes = snapshot.data;
          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) => _buildlabel(notes[index]),
          );
        },
      );

  Widget _buildlabel(TastingNote note) => FutureBuilder<Sake>(
      future: database.findSakeByID(note.sakeID),
      builder: (context, sakeSnapshot) => FutureBuilder<Brewery>(
          future: database.findBreweryByID(sakeSnapshot.data.breweryID),
          builder: (context, brewerySnapshot) => ListTile(
                title: Text(sakeSnapshot.data.name),
                subtitle: Text(brewerySnapshot.data.name),
              )));
}
