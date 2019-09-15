import 'dart:async';

import 'package:app/bloc/top_bloc.dart';
import 'package:app/model/model.dart';
import 'package:app/scene/edit_tasting_note/index.dart';
import 'package:app/services/service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class TopScene extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = TopProvider.of(context);
    bloc.onBuildView.add(null);
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
                    return Text('${note.sake.name} at ${note.brewery.name}');
                  });
            },
          ),
        ),
        _SaveSuccessSnackBar(bloc.showSaveSuccessToast)
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
