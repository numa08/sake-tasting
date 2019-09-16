import 'package:app/bloc/bloc.dart';
import 'package:app/services/service.dart';
import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/material.dart';

class ShowTastingNoteProvider extends BlocProvider<ShowTastingNoteBloc> {
  ShowTastingNoteProvider({Widget child})
      : super(
            creator: (context, _bag) {
              final provider = ServiceProvider.of(context);
              return ShowTastingNoteBloc(provider.tastingNoteModel);
            },
            child: child);

  static ShowTastingNoteBloc of(BuildContext context) =>
      BlocProvider.of(context);
}
