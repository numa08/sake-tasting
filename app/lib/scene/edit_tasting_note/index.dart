import 'dart:async';
import 'dart:io';

import 'package:app/bloc/bloc.dart';
import 'package:app/model/model.dart';
import 'package:app/services/service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
          backgroundColor: (data.data != null && data.data)
              ? Theme.of(context).accentColor
              : Colors.grey,
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
                Container(
                  height: 112,
                  child: StreamBuilder<List<ImageResource>>(
                    stream: bloc.images,
                    builder: (context, data) {
                      if (!data.hasData) {
                        return Container();
                      }
                      return ListView.separated(
                          separatorBuilder: (context, index) => const SizedBox(
                                width: 12,
                              ),
                          scrollDirection: Axis.horizontal,
                          itemCount: data.data.length,
                          itemBuilder: (context, index) {
                            final image = data.data[index];
                            switch (image.runtimeType) {
                              case AddPhotoIconImage:
                                return Container(
                                  height: 96,
                                  width: 96,
                                  child: RaisedButton.icon(
                                    label: const Text(''),
                                    icon: Icon(Icons.add_a_photo),
                                    onPressed: () {
                                      showDialog<void>(
                                          context: context,
                                          builder: (context) => SimpleDialog(
                                                title: const Text('画像を追加'),
                                                children: <Widget>[
                                                  SimpleDialogOption(
                                                    child: const Text('カメラで撮影'),
                                                    onPressed: () {
                                                      _pickImage(
                                                          ImageSource.camera);
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                  SimpleDialogOption(
                                                    child:
                                                        const Text('ギャラリーから選択'),
                                                    onPressed: () {
                                                      _pickImage(
                                                          ImageSource.gallery);
                                                      Navigator.pop(context);
                                                    },
                                                  )
                                                ],
                                              ));
                                    },
                                  ),
                                );
                              case FileImageResource:
                                final fileImage = image as FileImageResource;
                                return SizedBox(
                                  width: 96,
                                  height: 96,
                                  child: Stack(
                                    children: <Widget>[
                                      Image.file(
                                        fileImage.file,
                                        width: 96,
                                        height: 96,
                                        fit: BoxFit.cover,
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: <Widget>[
                                          IconButton(
                                            icon: Icon(Icons.close),
                                            onPressed: () =>
                                                bloc.onDeleteImage.add(index),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              default:
                                return null;
                            }
                          });
                    },
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
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
                  onChanged: (v) => bloc.onUpdateStringField
                      .add(StringFieldValue(StringValueField.comment, v)),
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
        _ShowRestoreImageSnackBar(
          showRestoreImageSnackBar: bloc.showRestoreImageBar,
          restoreImage: bloc.onAddImage,
        )
      ],
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final image = await ImagePicker.pickImage(source: source);
    if (image == null) {
      return;
    }
    bloc.onAddImage.add(image);
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

class _ShowRestoreImageSnackBar extends StatefulWidget {
  const _ShowRestoreImageSnackBar(
      {Key key, this.showRestoreImageSnackBar, this.restoreImage})
      : super(key: key);

  final Observable<File> showRestoreImageSnackBar;
  final PublishSubject<File> restoreImage;
  @override
  State<StatefulWidget> createState() => _ShowRestoreImageSnackBarState();
}

class _ShowRestoreImageSnackBarState extends State<_ShowRestoreImageSnackBar> {
  StreamSubscription<void> _subscription;

  @override
  void initState() {
    super.initState();
    setState(() {
      _subscription = widget.showRestoreImageSnackBar.listen((file) {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: const Text('画像を削除しました'),
          action: SnackBarAction(
            label: 'キャンセル',
            onPressed: () => widget.restoreImage.add(file),
          ),
        ));
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
