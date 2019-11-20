import 'dart:io';

import 'package:app2/data/database/database.dart';
import 'package:app2/data/database/entitiy/entity.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart';

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
  List<TastingNoteImage> _images;
  Directory _applicationDocumentDirectory;

  final _sakeController = TextEditingController();
  final _breweryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    () async {
      final tastingNote = widget.tastingNoteID == null
          ? null
          : await widget.database.findTastingNoteByID(widget.tastingNoteID);
      final applicationDocument = await getApplicationDocumentsDirectory();
      setState(() {
        _applicationDocumentDirectory = applicationDocument;
      });

      if (tastingNote == null) {
        setState(() {
          final uuid = Uuid();
          _brewery = Brewery.create(breweryID: uuid.v4());
          _sake = Sake.create(sakeID: uuid.v4(), breweryID: _brewery.breweryID);
          _tastingNote = TastingNote.create(
              tastingNoteID: uuid.v4(),
              sakeID: _sake.sakeID,
              createdAtUTC: DateTime.now().millisecondsSinceEpoch);
          _images = const <TastingNoteImage>[];
        });
      } else {
        final sake = await widget.database.findSakeByID(tastingNote.sakeID);
        final brewery = await widget.database.findBreweryByID(sake.breweryID);
        final images =
            await widget.database.findImage(tastingNote.tastingNoteID);
        setState(() {
          _tastingNote = tastingNote;
          _sake = sake;
          _brewery = brewery;
          _sakeController.text = _sake.name;
          _breweryController.text = _brewery.name;
          _images = images;
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
          child: ListView(
            children: <Widget>[
              _ImagePickerForm(
                onSaved: (images) {
                  setState(() {
                    final uuid = Uuid();
                    _images = images
                        .map((f) => TastingNoteImage.create(
                            imageID: uuid.v4(),
                            name: basename(f.path),
                            tastingNoteID: _tastingNote.tastingNoteID))
                        .toList();
                  });
                },
                initialValue: _images
                        ?.map((i) =>
                            join(_applicationDocumentDirectory.path, i.name))
                        ?.map((p) => File(p))
                        ?.toList() ??
                    <File>[],
                validator: (images) {
                  if (images.isEmpty) {
                    return '画像は1枚以上必要です';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 24,
              ),
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
              ),
              Container(
                child: ListTile(
                  title: Text('外観', style: Theme.of(context).textTheme.title),
                  trailing: Icon(Icons.arrow_right),
                  onTap: () {},
                ),
                decoration: BoxDecoration(border: Border(bottom: BorderSide())),
              ),
              Container(
                child: ListTile(
                  title: Text('香り', style: Theme.of(context).textTheme.title),
                  trailing: Icon(Icons.arrow_right),
                  onTap: () {},
                ),
                decoration: BoxDecoration(border: Border(bottom: BorderSide())),
              ),
              Container(
                child: ListTile(
                  title: Text('味わい', style: Theme.of(context).textTheme.title),
                  trailing: Icon(Icons.arrow_right),
                  onTap: () {},
                ),
                decoration: BoxDecoration(border: Border(bottom: BorderSide())),
              ),
              Container(
                child: ListTile(
                  title:
                      Text('個性の抽出', style: Theme.of(context).textTheme.title),
                  trailing: Icon(Icons.arrow_right),
                  onTap: () {},
                ),
                decoration: BoxDecoration(border: Border(bottom: BorderSide())),
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
    await widget.database.save(sake, brewery, _images, tastingNote);
    Navigator.of(context).pop(SaveResult.ok);
  }

  @override
  void dispose() {
    _sakeController.dispose();
    _breweryController.dispose();
    super.dispose();
  }
}

class _ImagePickerForm extends FormField<List<File>> {
  _ImagePickerForm(
      {FormFieldSetter<List<File>> onSaved,
      FormFieldValidator<List<File>> validator,
      List<File> initialValue = const <File>[]})
      : super(
            onSaved: onSaved,
            validator: validator,
            initialValue: initialValue,
            builder: (FormFieldState<List<File>> state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 96,
                    child: ListView.separated(
                      separatorBuilder: (context, index) => const SizedBox(
                        width: 12,
                      ),
                      scrollDirection: Axis.horizontal,
                      itemCount: state.value.length + 1,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return RaisedButton(
                            child: Icon(Icons.camera_enhance),
                            onPressed: () {
                              showDialog<void>(
                                  context: context,
                                  builder: (context) => SimpleDialog(
                                        title: const Text('画像を追加'),
                                        children: <Widget>[
                                          SimpleDialogOption(
                                            child: const Text('カメラで撮影'),
                                            onPressed: () async {
                                              Navigator.pop(context);
                                              final image = await _pickImage(
                                                  ImageSource.camera);
                                              final newList =
                                                  List<File>.from(state.value)
                                                    ..add(image);
                                              state.didChange(newList);
                                            },
                                          ),
                                          SimpleDialogOption(
                                            child: const Text('ギャラリーから選択'),
                                            onPressed: () async {
                                              Navigator.pop(context);
                                              final image = await _pickImage(
                                                  ImageSource.gallery);
                                              final newList =
                                                  List<File>.from(state.value)
                                                    ..add(image);
                                              state.didChange(newList);
                                            },
                                          )
                                        ],
                                      ));
                            },
                          );
                        }
                        return Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: <Widget>[
                            Container(
                              width: 96,
                              height: 96,
                              child: FlatButton(
                                padding: const EdgeInsets.all(0),
                                child: Image.file(state.value[index - 1],
                                    fit: BoxFit.fitHeight),
                                onPressed: () {},
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Container(
                                  width: 24,
                                  height: 24,
                                  child: FlatButton(
                                    padding: const EdgeInsets.all(0),
                                    child: Icon(Icons.close),
                                    onPressed: () async {
                                      final image = state.value[index - 1];
                                      final newImages =
                                          List<File>.from(state.value)
                                            ..removeAt(index - 1);
                                      state.didChange(newImages);

                                      final closed = await Scaffold.of(context)
                                          .showSnackBar(SnackBar(
                                            content: const Text('画像を削除しました'),
                                            action: SnackBarAction(
                                              label: 'もとに戻す',
                                              onPressed: () {
                                                final newImages =
                                                    List<File>.from(state.value)
                                                      ..add(image);
                                                state.didChange(newImages);
                                              },
                                            ),
                                          ))
                                          .closed;
                                      if (closed !=
                                          SnackBarClosedReason.action) {
                                        image.deleteSync();
                                      }
                                    },
                                  ),
                                )
                              ],
                            )
                          ],
                        );
                      },
                    ),
                  ),
                  state.hasError
                      ? Column(children: <Widget>[
                          const SizedBox(
                            height: 4,
                          ),
                          Builder(
                            builder: (context) => Text(state.errorText,
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .copyWith(
                                        color: Theme.of(context).errorColor)),
                          )
                        ])
                      : Container(),
                ],
              );
            });

  static Future<File> _pickImage(ImageSource source) async {
    final image = await ImagePicker.pickImage(source: source);
    final documentPath = (await getApplicationDocumentsDirectory()).path;
    final newPath = join(documentPath, basename(image.path));
    return image.copySync(newPath);
  }
}
