import 'package:app/bloc/top_bloc.dart';
import 'package:app/services/service.dart';
import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/cupertino.dart';

class TopProvider extends BlocProvider<TopBloc> {
  TopProvider({Widget child})
      : super(
            creator: (context, _bag) {
              final provider = ServiceProvider.of(context);
              return TopBloc(
                  provider.tastingNoteModel, provider.editTastingNoteModel);
            },
            child: child);

  static TopBloc of(BuildContext context) => BlocProvider.of(context);
}
