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
                        subtitle: Text(tastingNote.brewery.name),
                      ),
                      ListTile(
                        title: const Text('外観'),
                      ),
                      ListTile(
                        leading: const Text('健全度'),
                        trailing: _NullableText(
                          text: tastingNote.stringField[
                              StringValueField.appearanceSoundness],
                        ),
                      ),
                      ListTile(
                        leading: const Text('色合い'),
                        trailing: _NullableText(
                            text: tastingNote
                                .doubleField[DoubleValueField.appearanceHue]
                                ?.toString()),
                        subtitle: _NullableText(
                          text: tastingNote.stringField[
                              StringValueField.appearanceHueComment],
                        ),
                      ),
                      ListTile(
                        leading: const Text('粘性'),
                        trailing: _NullableText(
                          text: tastingNote
                              .doubleField[DoubleValueField.appearanceViscosity]
                              ?.toString(),
                        ),
                        subtitle: _NullableText(
                          text: tastingNote.stringField[
                              StringValueField.appearanceViscosityComment],
                        ),
                      ),
                      ListTile(
                        title: const Text('香り'),
                      ),
                      ListTile(
                        leading: const Text('健全度'),
                        trailing: _NullableText(
                          text: tastingNote
                              .stringField[StringValueField.fragranceSoundness],
                        ),
                      ),
                      ListTile(
                        leading: const Text('強さ'),
                        subtitle: _NullableText(
                          text: tastingNote.stringField[
                              StringValueField.fragranceStrengthComment],
                        ),
                        trailing: _NullableText(
                            text: tastingNote
                                .doubleField[DoubleValueField.fragranceStrength]
                                ?.toString()),
                      ),
                      ListTile(
                        leading: const Text('具体例'),
                        trailing: _NullableText(
                          text: tastingNote
                              .stringField[StringValueField.fragranceExample],
                        ),
                      ),
                      ListTile(
                        leading: const Text('主体となる香り'),
                        trailing: _NullableText(
                          text: tastingNote
                              .stringField[StringValueField.fragranceMainly],
                        ),
                      ),
                      ListTile(
                        leading: const Text('複雑性'),
                        trailing: _NullableText(
                          text: tastingNote.stringField[
                              StringValueField.fragranceComplexityComment],
                        ),
                      ),
                      ListTile(
                        title: const Text('味わい'),
                      ),
                      ListTile(
                        leading: const Text('健全度'),
                        trailing: _NullableText(
                          text: tastingNote
                              .stringField[StringValueField.tasteSoundness],
                        ),
                      ),
                      ListTile(
                        leading: const Text('アタック'),
                        trailing: _NullableText(
                          text: tastingNote
                              .doubleField[DoubleValueField.tasteAttack]
                              ?.toString(),
                        ),
                        subtitle: _NullableText(
                          text: tastingNote
                              .stringField[StringValueField.tasteAttackComment],
                        ),
                      ),
                      ListTile(
                        leading: const Text('テクスチャー'),
                        trailing: _NullableText(
                          text: tastingNote
                              .stringField[StringValueField.tasteTexture],
                        ),
                      ),
                      ListTile(
                        leading: const Text('具体的な味わい'),
                        trailing: _NullableText(
                          text: tastingNote
                              .stringField[StringValueField.tasteExample],
                        ),
                      ),
                      ListTile(
                        leading: const Text('甘辛度'),
                        trailing: _NullableText(
                          text: tastingNote
                              .doubleField[DoubleValueField.tasteSweetness]
                              ?.toString(),
                        ),
                        subtitle: _NullableText(
                          text: tastingNote.stringField[
                              StringValueField.tasteSweetnessComment],
                        ),
                      ),
                      ListTile(
                        leading: const Text('含み香の発現性'),
                        trailing: _NullableText(
                          text: tastingNote
                              .doubleField[DoubleValueField.afterFlavorStrength]
                              ?.toString(),
                        ),
                        subtitle: _NullableText(
                          text: tastingNote.stringField[
                              StringValueField.afterFlavorStrengthComment],
                        ),
                      ),
                      ListTile(
                        leading: const Text('含み香の内容'),
                        trailing: _NullableText(
                          text: tastingNote
                              .stringField[StringValueField.afterFlavorExample],
                        ),
                      ),
                      ListTile(
                        leading: const Text('余韻'),
                        trailing: _NullableText(
                          text: tastingNote.doubleField[
                                  DoubleValueField.reverberationStrength]
                              ?.toString(),
                        ),
                        subtitle: _NullableText(
                          text: tastingNote.stringField[
                              StringValueField.reverberationStrengthComment],
                        ),
                      ),
                      ListTile(
                        leading: const Text('余韻の内容'),
                        trailing: _NullableText(
                          text: tastingNote.stringField[
                              StringValueField.reverberationExample],
                        ),
                      ),
                      ListTile(
                        leading: const Text('複雑性'),
                        trailing: _NullableText(
                          text: tastingNote.stringField[
                              StringValueField.tasteComplexityComment],
                        ),
                      ),
                      ListTile(
                        title: const Text('個性の抽出'),
                      ),
                      ListTile(
                        leading: const Text('個性抽出'),
                        trailing: _NullableText(
                          text: tastingNote
                              .stringField[StringValueField.individuality],
                        ),
                      ),
                      ListTile(
                        leading: const Text('留意点の抽出'),
                        trailing: _NullableText(
                          text: tastingNote
                              .stringField[StringValueField.noticeComment],
                        ),
                      ),
                      ListTile(
                        leading: const Text('香味特性'),
                        trailing: _NullableText(
                          text: tastingNote.flavorTypes
                              .map(_flavorTypeToName)
                              .join(','),
                        ),
                      ),
                      ListTile(
                        leading: const Text('香味特性分類の留意点'),
                        trailing: _NullableText(
                          text: tastingNote
                              .stringField[StringValueField.flavorTypeComment],
                        ),
                      )
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

class _NullableText extends StatelessWidget {
  const _NullableText({Key key, this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) => Text(text ?? '');
}

String _flavorTypeToName(FlavorType type) {
  if (type == FlavorType.aromatic()) {
    return '薫酒';
  }
  if (type == FlavorType.refreshing()) {
    return '爽酒';
  }
  if (type == FlavorType.rich()) {
    return '醇酒';
  }
  if (type == FlavorType.aged()) {
    return '熟酒';
  }
  if (type == FlavorType.sparkling()) {
    return 'スパークリング';
  }
  throw ArgumentError('未定義のtypeです $type');
}
