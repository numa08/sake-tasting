import 'package:app/bloc/bloc.dart';
import 'package:app/scene/edit_tasting_note/future_text_field.dart';
import 'package:app/services/edit_tasting_note_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class EditForm extends StatelessWidget {
  const EditForm({Key key, this.title, this.listItem}) : super(key: key);
  final String title;
  final Observable<List<ListRow>> listItem;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: SafeArea(
          child: _Body(
            listItem: listItem,
          ),
        ),
      );
}

class _Body extends StatelessWidget {
  const _Body({Key key, this.listItem}) : super(key: key);

  final Observable<List<ListRow>> listItem;

  @override
  Widget build(BuildContext context) {
    final bloc = EditTastingNoteProvider.of(context);
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: StreamBuilder<List<ListRow>>(
        stream: listItem,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }
          final items = snapshot.data;
          return ListView.separated(
              itemBuilder: (context, index) {
                final item = items[index];
                switch (item.runtimeType) {
                  case FormTitleAndDescriptionRow:
                    final i = item as FormTitleAndDescriptionRow;
                    final form = i.form;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          _formTitleFor(form),
                          style: Theme.of(context).textTheme.title,
                        ),
                        Text(
                          _formDescriptionFor(form),
                          style: Theme.of(context).textTheme.body1,
                        )
                      ],
                    );
                  case InputTextFormRow:
                    final i = item as InputTextFormRow;
                    final field = i.field;
                    final form = i.form;
                    return FutureTextField(
                        future: bloc.editingTarget
                            .map((t) => t.stringField[field])
                            .first,
                        label: _formTitleFor(form),
                        onChanged: (value) => bloc.onUpdateStringField
                            .add(StringFieldValue(field, value)));
                  case DescriptionItemRow:
                    final i = item as DescriptionItemRow;
                    final description = i.description;
                    return Text(
                      _descriptionFor(description),
                      style: Theme.of(context).textTheme.body1,
                    );
                  default:
                    return null;
                }
              },
              separatorBuilder: (context, _index) => const SizedBox(
                    height: 24,
                  ),
              itemCount: items.length);
        },
      ),
    );
  }
}

String _formTitleFor(FormItem form) {
  switch (form) {
    case FormItem.appearanceSoundness:
    case FormItem.fragranceSoundness:
    case FormItem.tasteSoundness:
      return '健全度';
    case FormItem.appearanceHue:
      return '色合い';
    case FormItem.appearanceViscosity:
      return '粘性';
    case FormItem.fragranceStrength:
      return '強さ';
    case FormItem.fragranceExample:
      return '具体例';
    case FormItem.fragranceMainly:
      return '主体となる香り';
    case FormItem.fragranceComplexity:
    case FormItem.tasteComplexity:
      return '複雑製';
    case FormItem.tasteAttack:
      return 'アタック';
    case FormItem.tasteTexture:
      return 'テクスチャー';
    case FormItem.tasteExample:
      return '具体的な味わい';
    case FormItem.tasteSweetness:
      return '甘辛度';
    case FormItem.afterFlavorStrength:
      return '含み香の発現性';
    case FormItem.afterFlavorExample:
      return '含み香の内容';
    case FormItem.reverberationStrength:
      return '余韻';
    case FormItem.reverberationExample:
      return '余韻の内容';
    case FormItem.individuality:
      return '個性抽出';
    case FormItem.noticeComment:
      return '留意点の抽出';
    case FormItem.flavorTypeComment:
      return '香味特性分類の留意点';
  }
}

String _formDescriptionFor(FormItem form) {
  switch (form) {
    case FormItem.appearanceSoundness:
      return '例えばにごりなく澄んだ状態であれば「清掃度が高い」'
          '「透明度が高い」「輝きがある」などの表現を用いて健全であることを記す。（健全だけでも可）';
    case FormItem.appearanceHue:
      return 'ここでは「雪解け水」「岩清水」「水晶」「トパーズ」'
          '「琥珀色」といった抽象的かつセールストーク的な用語は使用せず、あくまでも客観的な特徴をコメントすることが肝心である。';
    case FormItem.appearanceViscosity:
      return 'グラスの内側に付着し、流れ落ちる液体部分を「脚」と呼ぶ。'
          'これはアルコール度数が高い場合や、糖分などのエキス分を多く含むほど明確に発現する。'
          'これを「粘性」と呼び、「高い」「低い」で表す。ただし多くの日本酒のアルコール度数は15%前後に仕上げられているので、'
          '粘性に極端な差が生じない。';
    case FormItem.fragranceSoundness:
      return '香りの健全度を確認する。特に紫外線劣化、熱劣化、参加などによる劣化臭がないかに注意する。';
    case FormItem.fragranceStrength:
      return '香りの強弱を判断する。強いか弱いかで表すが、比較対象を明確にすることが肝要となる。';
    case FormItem.fragranceExample:
      return '香りの特徴を、何かの食品類にたとえ、コメントする。'
          '日本酒の香りの用語集を活用し、味わいの基本とされる甘味、酸味、苦味、旨味、またはその他のうち、'
          'どの要素を思わせるかを探り、近いと思われる食品類を抽出すると良い。';
    case FormItem.fragranceMainly:
      return '日本酒の香りの用語集から選んだ具体的な要素が最も多かった枠のふさわしい形容詞例を参照し、'
          '香りの総合的な印象を、主体となる香りとして箇条書きで記す。';
    case FormItem.fragranceComplexity:
      return '香りの要素が多いか、少ないかを判別する。多い場合は複雑、少ない場合はシンプルと表す。';
    case FormItem.tasteSoundness:
      return '外観、香りに続いて味わいの健全度を確認する。';
    case FormItem.tasteAttack:
      return '口に含んだ際の印象や感覚をアタックと呼び、「強い」か「弱い」で表す。';
    case FormItem.tasteTexture:
      return '食品分野では「口当たり」「歯ごたえ」「舌触り」、飲料分野では「飲み口」などと呼ばれる。'
          '「柔らかい」「硬い」「キメが粗い」「キメが細かい」など、物理的な感覚を表す。';
    case FormItem.tasteExample:
      return '具体的な味わいの特徴を箇条書きで記す。特に味わいの核となる旨味に言及し、'
          'その他特徴的な要素があれば、併せてコメントする。'
          '「甘み」「酸味」「苦味」「渋み」「旨味」「アルコール」など';
    case FormItem.tasteSweetness:
      return '味わいの指標として長らく使用されてきた「甘口」「辛口」。'
          'なお、甘辛度の捉え方には個人差があることに留意すべきである。';
    case FormItem.afterFlavorStrength:
      return '含み香とは、アフターフレーバーと呼ぶこともある。'
          '含み香とは、口に含んだ状態から鼻腔に戻る香りを指し、'
          '発現性が「高い」か「低い」かで表す。';
    case FormItem.afterFlavorExample:
      return 'どのような香りが感じられるか具体例も確認する。';
    case FormItem.reverberationStrength:
      return '余韻とは最後に残る味わいの要素を指し、「後味」とも呼ばれる。「長い」か「短い」かで表す。';
    case FormItem.reverberationExample:
      return '旨味の要素を確認する';
    case FormItem.tasteComplexity:
      return '味わいが「複雑」か「シンプル」かを判定する';
    case FormItem.individuality:
      return '品質の評価コメントの中から、最も特徴的な要素を「個性」として抽出する。'
          '「外観」「香り」「テクスチャー」「味わい」の中から２〜３要素を抽出し、'
          '優先順位の高い要素から記載する。';
    case FormItem.noticeComment:
      return '個性の中で、サービス時、セールス時に留意すべきと思われる要素があれば記入しておく。'
          '（留意点がない場合は無理に抽出する必要はない）';
    case FormItem.flavorTypeComment:
      return '個性抽出後、香味特性別分類のいずれに該当するかを判定する。';
  }
}

String _descriptionFor(DescriptionItem description) {
  switch (description) {
    case DescriptionItem.appearance:
      return '外観では健全度、色合い、粘性について評価する。'
          'ここで言及する色合いとは、赤・青・緑などの具体的な色を意味し、'
          '色相と同義である。';
    case DescriptionItem.fragrance:
      return '香りは上立香、トップノート、またはトップノーズなどと呼ぶ。'
          'さらに、口内に含んだ際に感じる香りは含み香またはアフターフレーバーと呼ぶ。'
          '香りは「健全度」「強さ」「主体となる香り」「複雑性」について評価する。';
    case DescriptionItem.taste:
      return '味わいは「健全度」「アタック」テクスチャー」「具体的な味わい」「甘辛度」'
          '「含み香」「余韻」「複雑性」について評価する。特に、「テクスチャー」'
          'と、日本酒の味わいの核となる「旨味」を重点的に評価するとよい。';
    case DescriptionItem.individuality:
      return '日本酒の提供時に役立つ「個性抽出の重要性と手法」「留意点の抽出」「香味特性分類の判定」を行う。';
  }
}
