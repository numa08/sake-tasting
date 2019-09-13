import 'dart:async';

import 'package:app/model/model.dart';
import 'package:bloc_provider/bloc_provider.dart';
import 'package:rxdart/rxdart.dart';

class TopBloc implements Bloc {
  TopBloc(this._tastingNoteModel) {
    _subscription.add(
        Observable.merge(<Observable<void>>[onBuildView, onPullToRefresh])
            .listen((_) {
      _tastingNoteModel.fetchAll();
    }));
  }

  Observable<List<TastingNote>> get allNotes =>
      _tastingNoteModel.allTastingNotes;
  final PublishSubject<void> onBuildView = PublishSubject<void>();
  final PublishSubject<void> onPullToRefresh = PublishSubject<void>();
  final TastingNoteModel _tastingNoteModel;
  final List<StreamSubscription<dynamic>> _subscription = [];

  @override
  void dispose() async {
    await Future.wait<dynamic>(_subscription.map((s) => s.cancel()));
    await onBuildView.close();
    await onPullToRefresh.close();
    await _tastingNoteModel.close();
  }
}
