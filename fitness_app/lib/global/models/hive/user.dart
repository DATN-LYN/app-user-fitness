import 'package:freezed_annotation/freezed_annotation.dart';

import '../../graphql/__generated__/schema.schema.gql.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  factory User({
    String? id,
    required String email,
    required String fullName,
    required double age,
    String? avatar,
    String? gender,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
