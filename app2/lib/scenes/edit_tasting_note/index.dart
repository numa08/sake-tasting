import 'package:app2/data/database/database.dart';
import 'package:app2/data/database/entitiy/entity.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

enum SaveResult {
  ok,
  failure,
}

class EditTastingNoteScene extends StatefulWidget {
  const EditTastingNoteScene({Key key, this.database, this.tastingNoteID})
      : super(key: key);
  static const String name = '/edit';
  final TastingNoteDatabase database;
  final String tastingNoteID;

  @override
  State<StatefulWidget> createState() => _EditTastingNoteSceneState();
}

class _EditTastingNoteSceneState extends State<EditTastingNoteScene> {
  final _formKey = GlobalKey<FormState>();

  TastingNote _tastingNote;
  Sake _sake;
  Brewery _brewery;

  final _sakeController = TextEditingController();
  final _breweryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    () async {
      final tastingNote = widget.tastingNoteID == null
          ? null
          : await widget.database.findTastingNoteByID(widget.tastingNoteID);

      if (tastingNote == null) {
        setState(() {
          final uuid = Uuid();
          _brewery = Brewery.create(breweryID: uuid.v4());
          _sake = Sake.create(sakeID: uuid.v4(), breweryID: _brewery.breweryID);
          _tastingNote = TastingNote.create(
              tastingNoteID: uuid.v4(),
              sakeID: _sake.sakeID,
              createdAtUTC: DateTime.now().millisecondsSinceEpoch);
        });
      } else {
        final sake = await widget.database.findSakeByID(tastingNote.sakeID);
        final brewery = await widget.database.findBreweryByID(sake.breweryID);
        setState(() {
          _tastingNote = tastingNote;
          _sake = sake;
          _brewery = brewery;
          _sakeController.text = _sake.name;
          _breweryController.text = _brewery.name;
        });
      }
    }();
  }

  @override
  Widget build(BuildContext context) {
    if (_tastingNote == null || _sake == null || _brewery == null) {
      return Center(child: const CircularProgressIndicator());
    }
    return Form(
      key: _formKey, // 作成したフォームキーを指定
      child: Scaffold(
        appBar: AppBar(
          title: const Text('ティスティングノート'),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.save),
          onPressed: () {
            if (_formKey.currentState.validate()) {
              _formKey.currentState.save();
              _saveTastingNote(context);
            }
          },
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    filled: true,
                    hintText: '日本の酒 大吟醸',
                    labelText: '銘柄'),
                autofocus: true,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return '銘柄は必須項目です';
                  }
                  return null;
                },
                controller: _sakeController,
              ),
              const SizedBox(
                height: 24,
              ),
              TextFormField(
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  filled: true,
                  hintText: '日本酒を作る蔵',
                  labelText: '酒蔵',
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return '酒蔵は必須項目です';
                  }
                  return null;
                },
                controller: _breweryController,
              )
            ],
          ),
        ),
      ),
    );
  }

  void _saveTastingNote(BuildContext context) async {
    final brewery = Brewery.create(
        breweryID: _brewery.breweryID, name: _breweryController.text);
    final sake = Sake.create(
        sakeID: _sake.sakeID,
        breweryID: brewery.breweryID,
        name: _sakeController.text);
    final tastingNote = TastingNote.create(
        tastingNoteID: _tastingNote.tastingNoteID,
        sakeID: sake.sakeID,
        createdAtUTC: DateTime.now().millisecondsSinceEpoch);
    await widget.database
        .save(sake, brewery, <TastingNoteImage>[], tastingNote);
    Navigator.of(context).pop(SaveResult.ok);
  }

  @override
  void dispose() {
    _sakeController.dispose();
    _breweryController.dispose();
    super.dispose();
  }
}
