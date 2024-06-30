// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_structure_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FileStructureDto _$FileStructureDtoFromJson(Map<String, dynamic> json) =>
    FileStructureDto(
      id: json['id'] as String,
      isDirectory: json['is_directory'] as bool,
    );

Map<String, dynamic> _$FileStructureDtoToJson(FileStructureDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'is_directory': instance.isDirectory,
    };
