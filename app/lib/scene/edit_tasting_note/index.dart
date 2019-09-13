import 'dart:async';

import 'package:app/bloc/bloc.dart';
import 'package:app/services/service.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class EditTastingNoteScene extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = EditTastingNoteProvider.of(context);
    bloc.onBuild.add(null);
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
