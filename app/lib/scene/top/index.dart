import 'dart:async';

import 'package:app/bloc/top_bloc.dart';
import 'package:app/model/model.dart';
import 'package:app/scene/edit_tasting_note/index.dart';
import 'package:app/scene/show_tasting_note/index.dart';
import 'package:app/services/service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class TopScene extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = TopProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('ティスティングノート'),
      ),
      body: SafeArea(
        child: _Body(
          bloc: bloc,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () =>
            Navigator.of(context).pushNamed(EditTastingNoteScene.name),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({Key key, this.bloc}) : super(key: key);

  final TopBloc bloc;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
          child: StreamBuilder<List<TastingNote>>(
            stream: bloc.allNotes,
            builder: (context, data) {
              if (!data.hasData) {
                return Center(
                  child: const CircularProgressIndicator(),
                );
              }
              if (data.data.isEmpty) {
                return Center(
                  child: const Text('ノートがありません'),
                );
              }
              final notes = data.data;
              return ListView.builder(
                  itemCount: notes.length,
                  itemBuilder: (context, index) {
                    final note = notes[index];
                    return InkWell(
                      onTap: () => bloc.selectCard.add(index),
                      child: Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Image.file(
                              note.images.first.image,
                              height: 240,
                              fit: BoxFit.fitWidth,
                            ),
                            ListTile(
                              title: Text(
                                '（${note.isDraft ? '下書き' : ''}）'
                                '${note.sake.name} '
                                  ),
                              subtitle: Text(note.brewery.name),
                            )
                          ],
                        ),
                      ),
                    );
                  });
            },
          ),
        ),
        _SaveSuccessSnackBar(bloc.showSaveSuccessToast),
        _OnBuildSubscription(onBuild: bloc.onBuildView),
        _ShowTastingNote(
          showTastingNote: bloc.showTastingNote,
        )
      ],
    );
  }
}

@immutable
class _SaveSuccessSnackBar extends StatefulWidget {
  const _SaveSuccessSnackBar(this.showSaveSuccessSnackBar);

  final Observable<dynamic> showSaveSuccessSnackBar;
  @override
  State<StatefulWidget> createState() => _SaveSuccessSnackBarState();
}

class _SaveSuccessSnackBarState extends State<_SaveSuccessSnackBar> {
  StreamSubscription<dynamic> _subscription;

  @override
  void initState() {
    super.initState();
    setState(() {
      _subscription = widget.showSaveSuccessSnackBar.listen((dynamic _) {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: const Text('保存しました'),
        ));
      });
    });
  }

  @override
  void dispose() async {
    await _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Container();
}

class _OnBuildSubscription extends StatefulWidget {
  const _OnBuildSubscription({Key key, this.onBuild}) : super(key: key);

  final PublishSubject<void> onBuild;

  @override
  State<StatefulWidget> createState() => _OnBuildSubscriptionState();
}

class _OnBuildSubscriptionState extends State<_OnBuildSubscription> {
  @override
  void initState() {
    super.initState();
    setState(() {
      widget.onBuild.add(null);
    });
  }

  @override
  Widget build(BuildContext context) => Container();
}

class _ShowTastingNote extends StatefulWidget {
  const _ShowTastingNote({Key key, this.showTastingNote}) : super(key: key);

  final Observable<TastingNoteID> showTastingNote;

  @override
  State<StatefulWidget> createState() => _ShowTastingNoteState();
}

class _ShowTastingNoteState extends State<_ShowTastingNote> {
  StreamSubscription<dynamic> _subscription;

  @override
  void initState() {
    super.initState();
    setState(() {
      _subscription = widget.showTastingNote.listen((id) {
        Navigator.of(context).pushNamed(ShowTastingNoteScene.name,
            arguments: ShowTastingNoteSceneArgument(id));
      });
    });
  }

  @override
  void dispose() async {
    await _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Container();
}
