// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_option.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QuestionOptionImpl _$$QuestionOptionImplFromJson(Map<String, dynamic> json) =>
    _$QuestionOptionImpl(
      id: json['id'] as String,
      text: json['text'] as String,
      imageUrl: json['imageUrl'] as String?,
      latex: json['latex'] as String?,
      isCorrect: json['isCorrect'] as bool?,
    );

Map<String, dynamic> _$$QuestionOptionImplToJson(
  _$QuestionOptionImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'text': instance.text,
  'imageUrl': instance.imageUrl,
  'latex': instance.latex,
  'isCorrect': instance.isCorrect,
};
