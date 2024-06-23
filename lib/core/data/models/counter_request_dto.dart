import 'package:json_annotation/json_annotation.dart';

part 'counter_request_dto.g.dart';

@JsonSerializable(createFactory: false)
class CounterRequestDto {
  const CounterRequestDto({
    required this.amount,
    required this.backgroundPathId,
    required this.frontPathId,
    required this.size,
  });

  @JsonKey(name: 'front_path_id')
  final String frontPathId;
  @JsonKey(name: 'background_path_id')
  final String backgroundPathId;
  @JsonKey(name: 'size')
  final double size;
  @JsonKey(name: 'amount')
  final int amount;

  Map<String, dynamic> toJson() => _$CounterRequestDtoToJson(this);
}
