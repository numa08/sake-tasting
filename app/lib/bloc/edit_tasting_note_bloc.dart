import 'dart:async';

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
      ..add(onChangeBreweryName
          .doOnData(print)
          .listen(editTastingNoteModel.setBreweryName))
      ..add(onChangeSakeName
          .doOnData(print)
          .listen(editTastingNoteModel.setSakeName))
      ..add(onChangeComment
          .doOnData(print)
          .listen(editTastingNoteModel.setComment))
      ..add(onClickSaveButton.listen((_) {
        editTastingNoteModel.save();
      }));
    editTastingNoteModel.canSave.pipe(_enableSaveButtonSubject);
    editTastingNoteModel.editingTarget
        .where((t) => t != null)
        .switchMap((t) => editTastingNoteModel.saveResult(t.id))
        .whereType<ValueResult<TastingNote>>()
        .cast<dynamic>()
        .pipe(_showSaveSuccessToastSubject);
  }

  final EditTastingNoteModel editTastingNoteModel;
  Observable<bool> get enableSaveButton => _enableSaveButtonSubject;
  Observable<dynamic> get showSaveSuccessToast => _showSaveSuccessToastSubject;
  final PublishSubject<void> onBuild = PublishSubject<void>();
  final PublishSubject<String> onChangeBreweryName = PublishSubject<String>();
  final PublishSubject<String> onChangeSakeName = PublishSubject<String>();
  final PublishSubject<String> onChangeComment = PublishSubject<String>();
  final PublishSubject<void> onClickSaveButton = PublishSubject<void>();

  final _enableSaveButtonSubject = PublishSubject<bool>();
  final _showSaveSuccessToastSubject = PublishSubject<dynamic>();
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
    await _showSaveSuccessToastSubject.close();
    await editTastingNoteModel.close();
  }
}
