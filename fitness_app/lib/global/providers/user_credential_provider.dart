import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../data/models/user_credentials.dart';
import '../utils/constants.dart';

final userCredentialProvider = Provider(
  (ref) {
    return _UserCredentialImpl(
      Hive.box(Constants.hiveDataBox),
    );
  },
);

abstract class UserCredential {
  UserCredentials getUserCredential();

  Future<void> saveUserCredential(UserCredentials credentials);

  Future<void> clear();
}

class _UserCredentialImpl implements UserCredential {
  _UserCredentialImpl(this._box);

  final Box<String> _box;
  final String key = Constants.hiveUserCredentialsKey;

  @override
  Future<void> saveUserCredential(UserCredentials userCredentials) {
    return _box.put(
      key,
      jsonEncode(userCredentials.toJson()),
    );
  }

  @override
  UserCredentials getUserCredential() {
    final json = _box.get(key);
    if (json == null) return UserCredentials();
    return UserCredentials.fromJson(
      jsonDecode(json) as Map<String, dynamic>,
    );
  }

  @override
  Future<void> clear() {
    return _box.delete(key);
  }
}
