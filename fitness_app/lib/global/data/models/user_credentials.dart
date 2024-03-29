import 'package:freezed_annotation/freezed_annotation.dart';

import '../../models/hive/user.dart';

part 'user_credentials.freezed.dart';
part 'user_credentials.g.dart';

@freezed
class UserCredentials with _$UserCredentials {
  factory UserCredentials({
    String? id,
    String? accessToken,
    String? refreshToken,
    User? user,
  }) = _UserCredentials;

  factory UserCredentials.fromJson(Map<String, dynamic> json) =>
      _$UserCredentialsFromJson(json);
}
