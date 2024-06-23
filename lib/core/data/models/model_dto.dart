import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'model_dto.g.dart';

@immutable
@JsonSerializable()
class ModelDto {
  const ModelDto();

  factory ModelDto.fromJson(Map<String, dynamic> json) =>
      _$ModelDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ModelDtoToJson(this);
}
