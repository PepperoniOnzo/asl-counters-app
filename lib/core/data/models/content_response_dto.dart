import 'package:json_annotation/json_annotation.dart';

import 'file_structure_dto.dart';

part 'content_response_dto.g.dart';

@JsonSerializable(createToJson: false)
class ContentResponseDto {
  const ContentResponseDto({required this.content});

  final List<FileStructureDto> content;

  factory ContentResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ContentResponseDtoFromJson(json);

}
