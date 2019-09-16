import 'dart:async';
import 'dart:io';

import 'package:app/model/model.dart';
import 'package:async/async.dart';
import 'package:bloc_provider/bloc_provider.dart';
import 'package:rxdart/rxdart.dart';

class EditTastingNoteBloc implements Bloc {
  EditTastingNoteBloc(this.editTastingNoteModel) {
    _subscriptions
      ..add(onBuild.listen((_) {
        editTastingNoteModel.startEditing();
      }))
      ..add(onChangeBreweryName.listen(editTastingNoteModel.setBreweryName))
      ..add(onChangeSakeName.listen(editTastingNoteModel.setSakeName))
      ..add(onChangeComment.listen(editTastingNoteModel.setComment))
      ..add(onClickSaveButton.listen((_) {
        editTastingNoteModel.save();
      }))
      ..add(onAddImage.listen(editTastingNoteModel.addImage))
      ..add(onDeleteImage.listen((index) async {
        final file = await editTastingNoteModel.deleteImage(index - 1);
        _showRestoreImageBar.add(file);
      }));
    editTastingNoteModel.canSave.pipe(_enableSaveButtonSubject);
    editTastingNoteModel.editingTarget
        .where((t) => t != null)
        .switchMap((t) => editTastingNoteModel.saveResult(t.id))
        .whereType<ValueResult<TastingNote>>()
        .mapTo(null)
        .cast<void>()
        .pipe(_dismissSubject);
  }

  final EditTastingNoteModel editTastingNoteModel;
  Observable<bool> get enableSaveButton => _enableSaveButtonSubject;
  Observable<void> get dismiss => _dismissSubject;
  Observable<List<ImageResource>> get images => editTastingNoteModel.images
      .map((l) => <ImageResource>[AddPhotoIconImage()]
        ..addAll(l.map((i) => FileImageResource(i.image))))
      .startWith(<ImageResource>[]);
  Observable<File> get showImage => onTapImage.withLatestFrom(
      editTastingNoteModel.images,
      (index, List<TastingNoteImage> images) => images[index - 1].image);
  Observable<File> get showRestoreImageBar => _showRestoreImageBar;
  final PublishSubject<void> onBuild = PublishSubject<void>();
  final PublishSubject<String> onChangeBreweryName = PublishSubject<String>();
  final PublishSubject<String> onChangeSakeName = PublishSubject<String>();
  final PublishSubject<String> onChangeComment = PublishSubject<String>();
  final PublishSubject<void> onClickSaveButton = PublishSubject<void>();
  final PublishSubject<File> onAddImage = PublishSubject<File>();
  final PublishSubject<int> onDeleteImage = PublishSubject<int>();
  final PublishSubject<int> onTapImage = PublishSubject<int>();

  final _enableSaveButtonSubject = PublishSubject<bool>();
  final _dismissSubject = PublishSubject<void>();
  final _showRestoreImageBar = PublishSubject<File>();
  final _subscriptions = <StreamSubscription<dynamic>>[];

  @override
  void dispose() async {
    await Future.wait<dynamic>(_subscriptions.map((s) => s.cancel()));
    await onBuild.close();
    await onChangeBreweryName.close();
    await onChangeSakeName.close();
    await onChangeComment.close();
    await onClickSaveButton.close();
    await _enableSaveButtonSubject.close();
    await _dismissSubject.close();
    await onAddImage.close();
    await onDeleteImage.close();
    await _showRestoreImageBar.close();
    await onTapImage.close();
    await editTastingNoteModel.close();
  }
}

abstract class ImageResource {}

class AddPhotoIconImage implements ImageResource {}

class FileImageResource implements ImageResource {
  FileImageResource(this.file);
  final File file;
}
