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
  }

  Observable<List<TastingNote>> get allNotes =>
      _tastingNoteModel.allTastingNotes;
  Observable<dynamic> get showSaveSuccessToast =>
      _editTastingNoteModel.editingTarget
          .where((t) => t != null)
          .switchMap((t) => _editTastingNoteModel.saveResult(t.id))
          .whereType<ValueResult<TastingNote>>()
          .cast<dynamic>();
  Observable<TastingNoteID> get showTastingNote => selectCard.withLatestFrom(
      allNotes, (index, List<TastingNote> list) => list[index].id);
  final PublishSubject<void> onBuildView = PublishSubject<void>();
  final PublishSubject<void> onPullToRefresh = PublishSubject<void>();
  final PublishSubject<int> selectCard = PublishSubject<int>();
  final TastingNoteModel _tastingNoteModel;
  final EditTastingNoteModel _editTastingNoteModel;
  final List<StreamSubscription<dynamic>> _subscription = [];

  @override
  void dispose() async {
    await Future.wait<dynamic>(_subscription.map((s) => s.cancel()));
    await onBuildView.close();
    await onPullToRefresh.close();
    await selectCard.close();
  }
}
