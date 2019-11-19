import 'package:app/services/service.dart';
import 'package:flutter/material.dart';

class AppearanceForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('外観'),
        ),
        body: SafeArea(
          child: Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      '外観では健全度、色合い、粘性について評価する。'
                      'ここで言及する色合いとは、赤・青・緑などの具体的な色を意味し、色相と同義である。',
                      style: Theme.of(context).textTheme.body1,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Text('健全度', style: Theme.of(context).textTheme.title),
                    Text(
                      '例えばにごりなく澄んだ状態であれば「清掃度が高い」「透明度が高い」「輝きがある」'
                      'などの表現を用いて健全であることを記す。（健全だけでも可）',
                      style: Theme.of(context).textTheme.body1,
                    ),
                    StreamBuilder<String>(
                      stream: EditTastingNoteProvider.of(context)
                          .tastingNote
                          .map((n) => n.appearance?.soundness),
                      builder: (context, snapshot) => TextFormField(
                        decoration: InputDecoration(
                            border: UnderlineInputBorder(), labelText: '健全度'),
                        controller: TextEditingController.fromValue(
                            snapshot.hasData
                                ? TextEditingValue(
                                    text: snapshot.data,
                                    selection: TextSelection.collapsed(
                                        offset: snapshot.data.length))
                                : TextEditingValue.empty),
                        // onFieldSubmitted: EditTastingNoteProvider.of(context)
                        //     .onUpdateAppearanceSoundness
                        //     .add,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
