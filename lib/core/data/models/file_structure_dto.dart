import 'package:json_annotation/json_annotation.dart';

part 'file_structure_dto.g.dart';

@JsonSerializable()
class FileStructureDto {
  const FileStructureDto({
    required this.id,
    required this.isDirectory,
  });

  @JsonKey(name: 'id')
  final String id;
  @JsonKey(name: 'is_directory')
  final bool isDirectory;

  factory FileStructureDto.fromJson(Map<String, dynamic> json) =>
      _$FileStructureDtoFromJson(json);

  Map<String, dynamic> toJson() => _$FileStructureDtoToJson(this);
}
