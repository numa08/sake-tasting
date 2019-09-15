import 'dart:async';

import 'package:app/model/model.dart';
import 'package:async/async.dart';
import 'package:bloc_provider/bloc_provider.dart';
import 'package:rxdart/rxdart.dart';

class TopBloc implements Bloc {
  TopBloc(this._tastingNoteModel, this._editTastingNoteModel) {
    _subscription.add(
        Observable.merge(<Observable<void>>[onBuildView, onPullToRefresh])
            .listen((_) {
      _tastingNoteModel.fetchAll();
    }));
    _editTastingNoteModel.editingTarget
        .where((t) => t != null)
        .switchMap((t) => _editTastingNoteModel.saveResult(t.id))
        .whereType<ValueResult<TastingNote>>()
        .cast<dynamic>()
        .pipe(_showSaveSuccessToastSubject);
  }

  Observable<List<TastingNote>> get allNotes =>
      _tastingNoteModel.allTastingNotes;
  Observable<dynamic> get showSaveSuccessToast => _showSaveSuccessToastSubject;
  final PublishSubject<void> onBuildView = PublishSubject<void>();
  final PublishSubject<void> onPullToRefresh = PublishSubject<void>();
  final TastingNoteModel _tastingNoteModel;
  final EditTastingNoteModel _editTastingNoteModel;
  final _showSaveSuccessToastSubject = PublishSubject<dynamic>();
  final List<StreamSubscription<dynamic>> _subscription = [];

  @override
  void dispose() async {
    await Future.wait<dynamic>(_subscription.map((s) => s.cancel()));
    await onBuildView.close();
    await onPullToRefresh.close();
    await _tastingNoteModel.close();
    await _showSaveSuccessToastSubject.close();
  }
}
