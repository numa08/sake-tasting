import 'package:app/model/model.dart';
import 'package:bloc_provider/bloc_provider.dart';
import 'package:rxdart/rxdart.dart';

class ShowTastingNoteBloc implements Bloc {
  ShowTastingNoteBloc(this._tastingNoteModel);

  final TastingNoteModel _tastingNoteModel;
  final PublishSubject<TastingNoteID> showTastingNote =
      PublishSubject<TastingNoteID>();
  Observable<TastingNote> get note =>
      showTastingNote.flatMap(_tastingNoteModel.tastingNoteByID);

  @override
  void dispose() async {
    await showTastingNote.close();
  }
}
