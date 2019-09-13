import 'package:app/bloc/bloc.dart';
import 'package:app/services/service.dart';
import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/cupertino.dart';

class EditTastingNoteProvider extends BlocProvider<EditTastingNoteBloc> {
  EditTastingNoteProvider({Widget child})
      : super(
            creator: (context, _bag) {
              final provider = ServiceProvider.of(context);
              return EditTastingNoteBloc(provider.editTastingNoteModel);
            },
            child: child);

  static EditTastingNoteBloc of(BuildContext context) =>
      BlocProvider.of(context);
}
