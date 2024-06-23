// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContentResponseDto _$ContentResponseDtoFromJson(Map<String, dynamic> json) =>
    ContentResponseDto(
      content: (json['content'] as List<dynamic>)
          .map((e) => FileStructureDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
