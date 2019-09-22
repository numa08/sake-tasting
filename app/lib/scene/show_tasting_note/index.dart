import 'package:app/bloc/bloc.dart';
import 'package:app/model/model.dart';
import 'package:app/services/service.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class ShowTastingNoteSceneArgument {
  ShowTastingNoteSceneArgument(this.tastingNoteID);

  final TastingNoteID tastingNoteID;
}

class ShowTastingNoteScene extends StatelessWidget {
  static const String name = 'show';

  @override
  Widget build(BuildContext context) {
    final argument = ModalRoute.of(context).settings.arguments
        as ShowTastingNoteSceneArgument;
    if (argument == null) {
      return null;
    }
    final bloc = ShowTastingNoteProvider.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('ティスティングノート')),
      body: _Body(bloc: bloc, argument: argument),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({Key key, this.bloc, this.argument}) : super(key: key);
  final ShowTastingNoteBloc bloc;
  final ShowTastingNoteSceneArgument argument;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
            child: StreamBuilder<TastingNote>(
                stream: bloc.note,
                builder: (context, data) {
                  if (!data.hasData) {
                    return Center(child: const CircularProgressIndicator());
                  }
                  final tastingNote = data.data;
                  return ListView(
                    children: <Widget>[
                      ListTile(
                        title: Text(tastingNote.sake.name),
                      ),
                      ListTile(
                        title: Text(tastingNote.brewery.name),
                      ),
                    ],
                  );
                })),
        _ShowTastingNoteSubscription(
          tastingNoteID: argument.tastingNoteID,
          showTastingNote: bloc.showTastingNote,
        )
      ],
    );
  }
}

class _ShowTastingNoteSubscription extends StatefulWidget {
  const _ShowTastingNoteSubscription(
      {Key key, this.tastingNoteID, this.showTastingNote})
      : super(key: key);
  final TastingNoteID tastingNoteID;

  final PublishSubject<TastingNoteID> showTastingNote;

  @override
  State<StatefulWidget> createState() => _ShowTastingNoteSubscriptionState();
}

class _ShowTastingNoteSubscriptionState
    extends State<_ShowTastingNoteSubscription> {
  @override
  void initState() {
    super.initState();
    setState(() {
      widget.showTastingNote.add(widget.tastingNoteID);
    });
  }

  @override
  Widget build(BuildContext context) => Container();
}
