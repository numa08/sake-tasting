import 'dart:async';
import 'dart:io';

import 'package:app/model/model.dart';
import 'package:async/async.dart';
import 'package:bloc_provider/bloc_provider.dart';
import 'package:rxdart/rxdart.dart';

class StringFieldValue {
  StringFieldValue(this.field, this.value);
  final StringValueField field;
  final String value;
}

class DoubleFieldValue {
  DoubleFieldValue(this.field, this.value);
  final DoubleValueField field;
  final double value;
}

class EditTastingNoteBloc implements Bloc {
  EditTastingNoteBloc(this.editTastingNoteModel) {
    _subscriptions
      ..add(onBuild.listen((_) {
        editTastingNoteModel.startEditing();
      }))
      ..add(onChangeBreweryName.listen(editTastingNoteModel.setBreweryName))
      ..add(onChangeSakeName.listen(editTastingNoteModel.setSakeName))
      ..add(onClickSaveButton.listen((_) {
        editTastingNoteModel.save();
      }))
      ..add(onAddImage.listen(editTastingNoteModel.addImage))
      ..add(onUpdateStringField
          .listen((v) => editTastingNoteModel.setStringField(v.field, v.value)))
      ..add(onUpdateDoubleField
          .listen((v) => editTastingNoteModel.setDoubleField(v.field, v.value)))
      ..add(onUpdateFlavorTypes.listen(editTastingNoteModel.setFlavorType));
  }

  final EditTastingNoteModel editTastingNoteModel;
  Observable<bool> get enableSaveButton => editTastingNoteModel.canSave;
  Observable<TastingNote> get editingTarget =>
      editTastingNoteModel.editingTarget;
  Observable<void> get dismiss => editTastingNoteModel.editingTarget
      .where((t) => t != null)
      .switchMap((t) => editTastingNoteModel.saveResult(t.id))
      .whereType<ValueResult<TastingNote>>()
      .mapTo(null)
      .cast<void>();
  Observable<List<ImageResource>> get images => editTastingNoteModel.images
      .map((l) => <ImageResource>[AddPhotoIconImage()]
        ..addAll(l.map((i) => FileImageResource(i.image))))
      .startWith(<ImageResource>[]);
  Observable<File> get showImage => onTapImage.withLatestFrom(
      editTastingNoteModel.images,
      (index, List<TastingNoteImage> images) => images[index - 1].image);
  Observable<File> get showRestoreImageBar => onDeleteImage.flatMap((index) =>
      Observable.fromFuture(editTastingNoteModel.deleteImage(index - 1)));

  Observable<List<ListRow>> get editAppearanceListItem =>
      Observable.just(<ListRow>[
        DescriptionItemRow(DescriptionItem.appearance),
        FormTitleAndDescriptionRow(FormItem.appearanceSoundness),
        InputTextFormRow(
            StringValueField.appearanceSoundness, FormItem.appearanceSoundness),
        FormTitleAndDescriptionRow(FormItem.appearanceHue),
        SliderFormRow(DoubleValueField.appearanceHue, FormItem.appearanceHue),
        InputTextFormRow(
            StringValueField.appearanceHueComment, FormItem.appearanceHue),
        FormTitleAndDescriptionRow(FormItem.appearanceViscosity),
        SliderFormRow(
            DoubleValueField.appearanceViscosity, FormItem.appearanceViscosity),
        InputTextFormRow(StringValueField.appearanceViscosityComment,
            FormItem.appearanceViscosity),
      ]);
  Observable<List<ListRow>> get editFragranceListItem =>
      Observable.just(<ListRow>[
        DescriptionItemRow(DescriptionItem.appearance),
        FormTitleAndDescriptionRow(FormItem.fragranceSoundness),
        InputTextFormRow(
            StringValueField.fragranceSoundness, FormItem.fragranceSoundness),
        FormTitleAndDescriptionRow(FormItem.fragranceStrength),
        SliderFormRow(
            DoubleValueField.fragranceStrength, FormItem.fragranceStrength),
        InputTextFormRow(StringValueField.fragranceStrengthComment,
            FormItem.fragranceStrength),
        FormTitleAndDescriptionRow(FormItem.fragranceExample),
        InputTextFormRow(
            StringValueField.fragranceExample, FormItem.fragranceExample),
        FormTitleAndDescriptionRow(FormItem.fragranceMainly),
        InputTextFormRow(
            StringValueField.fragranceMainly, FormItem.fragranceMainly),
        FormTitleAndDescriptionRow(FormItem.fragranceComplexity),
        InputTextFormRow(StringValueField.fragranceComplexityComment,
            FormItem.fragranceComplexity)
      ]);
  Observable<List<ListRow>> get editTasteListItem => Observable.just(<ListRow>[
        DescriptionItemRow(DescriptionItem.taste),
        FormTitleAndDescriptionRow(FormItem.tasteSoundness),
        InputTextFormRow(
            StringValueField.tasteSoundness, FormItem.tasteSoundness),
        FormTitleAndDescriptionRow(FormItem.tasteAttack),
        SliderFormRow(DoubleValueField.tasteAttack, FormItem.tasteAttack),
        InputTextFormRow(
            StringValueField.tasteAttackComment, FormItem.tasteAttack),
        FormTitleAndDescriptionRow(FormItem.tasteTexture),
        InputTextFormRow(StringValueField.tasteTexture, FormItem.tasteTexture),
        FormTitleAndDescriptionRow(FormItem.tasteExample),
        InputTextFormRow(StringValueField.tasteExample, FormItem.tasteExample),
        FormTitleAndDescriptionRow(FormItem.tasteSweetness),
        SliderFormRow(DoubleValueField.tasteSweetness, FormItem.tasteSweetness),
        InputTextFormRow(
            StringValueField.tasteSweetnessComment, FormItem.tasteSweetness),
        FormTitleAndDescriptionRow(FormItem.afterFlavorStrength),
        SliderFormRow(
            DoubleValueField.afterFlavorStrength, FormItem.afterFlavorStrength),
        InputTextFormRow(StringValueField.afterFlavorStrengthComment,
            FormItem.afterFlavorStrength),
        FormTitleAndDescriptionRow(FormItem.afterFlavorExample),
        InputTextFormRow(
            StringValueField.afterFlavorExample, FormItem.afterFlavorExample),
        FormTitleAndDescriptionRow(FormItem.reverberationStrength),
        SliderFormRow(DoubleValueField.reverberationStrength,
            FormItem.reverberationStrength),
        InputTextFormRow(StringValueField.reverberationStrengthComment,
            FormItem.reverberationStrength),
        FormTitleAndDescriptionRow(FormItem.reverberationExample),
        InputTextFormRow(StringValueField.reverberationExample,
            FormItem.reverberationExample),
        FormTitleAndDescriptionRow(FormItem.tasteComplexity),
        InputTextFormRow(
            StringValueField.tasteComplexityComment, FormItem.tasteComplexity),
      ]);
  Observable<List<ListRow>> get editIndividualityListItem =>
      Observable.just(<ListRow>[
        DescriptionItemRow(DescriptionItem.individuality),
        FormTitleAndDescriptionRow(FormItem.individuality),
        InputTextFormRow(
            StringValueField.individuality, FormItem.individuality),
        FormTitleAndDescriptionRow(FormItem.noticeComment),
        InputTextFormRow(StringValueField.noticeComment, FormItem.tasteExample),
        FormTitleAndDescriptionRow(FormItem.flavorType),
        FlavorTypeForm(),
        FormTitleAndDescriptionRow(FormItem.flavorTypeComment),
        InputTextFormRow(
            StringValueField.flavorTypeComment, FormItem.flavorTypeComment),
      ]);

  final PublishSubject<void> onBuild = PublishSubject<void>();
  final PublishSubject<String> onChangeBreweryName = PublishSubject<String>();
  final PublishSubject<String> onChangeSakeName = PublishSubject<String>();
  final PublishSubject<void> onClickSaveButton = PublishSubject<void>();
  final PublishSubject<File> onAddImage = PublishSubject<File>();
  final PublishSubject<int> onDeleteImage = PublishSubject<int>();
  final PublishSubject<int> onTapImage = PublishSubject<int>();
  final PublishSubject<StringFieldValue> onUpdateStringField =
      PublishSubject<StringFieldValue>();
  final PublishSubject<DoubleFieldValue> onUpdateDoubleField =
      PublishSubject<DoubleFieldValue>();
  final PublishSubject<List<FlavorType>> onUpdateFlavorTypes =
      PublishSubject<List<FlavorType>>();

  final _subscriptions = <StreamSubscription<dynamic>>[];

  @override
  void dispose() async {
    await Future.wait<dynamic>(_subscriptions.map((s) => s.cancel()));
    await onBuild.close();
    await onChangeBreweryName.close();
    await onChangeSakeName.close();
    await onClickSaveButton.close();
    await onAddImage.close();
    await onDeleteImage.close();
    await onTapImage.close();
    await onUpdateStringField.close();
    await onUpdateDoubleField.close();
  }
}

abstract class ImageResource {}

class AddPhotoIconImage implements ImageResource {}

class FileImageResource implements ImageResource {
  FileImageResource(this.file);
  final File file;
}

abstract class ListRow {}

class InputTextFormRow extends ListRow {
  InputTextFormRow(this.field, this.form);
  final StringValueField field;
  final FormItem form;
}

class SliderFormRow extends ListRow {
  SliderFormRow(this.field, this.form);
  final DoubleValueField field;
  final FormItem form;
}

class FlavorTypeForm extends ListRow {}

enum DescriptionItem { appearance, fragrance, taste, individuality }

class DescriptionItemRow extends ListRow {
  DescriptionItemRow(this.description);
  final DescriptionItem description;
}

enum FormItem {
  appearanceSoundness,
  appearanceHue,
  appearanceViscosity,
  fragranceSoundness,
  fragranceStrength,
  fragranceExample,
  fragranceMainly,
  fragranceComplexity,
  tasteSoundness,
  tasteAttack,
  tasteTexture,
  tasteExample,
  tasteSweetness,
  afterFlavorStrength,
  afterFlavorExample,
  reverberationStrength,
  reverberationExample,
  tasteComplexity,
  individuality,
  noticeComment,
  flavorType,
  flavorTypeComment
}

class FormTitleAndDescriptionRow extends ListRow {
  FormTitleAndDescriptionRow(this.form);
  final FormItem form;
}
