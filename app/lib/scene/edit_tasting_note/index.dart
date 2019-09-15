import 'dart:async';

import 'package:app/bloc/bloc.dart';
import 'package:app/services/service.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class EditTastingNoteScene extends StatelessWidget {
  static const String name = '/edit';

  @override
  Widget build(BuildContext context) {
    final bloc = EditTastingNoteProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('ティスティングノート'),
      ),
      body: SafeArea(
        child: _Body(
          bloc: bloc,
        ),
      ),
      floatingActionButton: StreamBuilder<bool>(
        stream: bloc.enableSaveButton,
        builder: (context, data) => FloatingActionButton(
          onPressed: (data.data != null && data.data)
              ? () => bloc.onClickSaveButton.add(null)
              : null,
          child: Icon(Icons.save),
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({Key key, this.bloc}) : super(key: key);

  final EditTastingNoteBloc bloc;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      filled: true,
                      hintText: '日本の酒 純米大吟醸',
                      labelText: '銘柄'),
                  onChanged: bloc.onChangeSakeName.add,
                ),
                const SizedBox(
                  height: 24,
                ),
                TextField(
                  textCapitalization: TextCapitalization.characters,
                  decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      filled: true,
                      hintText: '日本酒酒蔵',
                      labelText: '酒蔵'),
                  onChanged: bloc.onChangeBreweryName.add,
                ),
                const SizedBox(
                  height: 24,
                ),
                TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  onChanged: bloc.onChangeComment.add,
                  decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      hintText: '',
                      labelText: 'ティスティングノート'),
                )
              ],
            ),
          ),
        ),
        _DismissHandler(bloc.dismiss),
        _OnBuildSubscription(onBuild: bloc.onBuild),
      ],
    );
  }
}

@immutable
class _DismissHandler extends StatefulWidget {
  const _DismissHandler(this.dismiss);

  final Observable<void> dismiss;
  @override
  State<StatefulWidget> createState() => _DismissHandlerState();
}

class _DismissHandlerState extends State<_DismissHandler> {
  StreamSubscription<void> _subscription;

  @override
  void initState() {
    super.initState();
    setState(() {
      _subscription = widget.dismiss.listen((_) {
        Navigator.of(context).pop();
      });
    });
  }

  @override
  void dispose() async {
    super.dispose();
    await _subscription.cancel();
  }

  @override
  Widget build(BuildContext context) => Container();
}

@immutable
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
