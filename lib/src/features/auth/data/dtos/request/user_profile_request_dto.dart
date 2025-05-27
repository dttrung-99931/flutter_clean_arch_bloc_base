import 'package:json_annotation/json_annotation.dart';

part 'user_profile_request_dto.g.dart';

@JsonSerializable(includeIfNull: false, createFactory: false)
class UserProfileRequestDto {
  @JsonKey(name: 'pass_chosse_manufacture')
  final bool? passChooseManufacturer;

  UserProfileRequestDto({
    this.passChooseManufacturer,
  });

  Map<String, dynamic> toJson() => _$UserProfileRequestDtoToJson(this);
}
