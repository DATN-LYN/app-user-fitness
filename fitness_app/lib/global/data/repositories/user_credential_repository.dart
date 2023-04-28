import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';

import '../../utils/constants.dart';
import '../models/failure.dart';
import '../models/user_credentials.dart';
import '_base_repository.dart';

final userCredentialsRepositoryProvider = Provider(
  (ref) => _UserCredentialsRepositoryImpl(
    Hive.box(Constants.hiveDataBox),
  ),
);

abstract class UserCredentialsRepository {
  Either<Failure, UserCredentials> getUserCredentials();

  Future<Either<Failure, UserCredentials>> saveUserCredential(
    UserCredentials user,
  );

  Future<Either<Failure, Unit>> signOut();
}

class _UserCredentialsRepositoryImpl extends BaseRepository
    implements UserCredentialsRepository {
  final Box<String> box;
  final String key = Constants.hiveUserCredentialsKey;

  _UserCredentialsRepositoryImpl(this.box);

  @override
  Either<Failure, UserCredentials> getUserCredentials() {
    return guard(() {
      final user = box.get(key);
      if (user != null) {
        return UserCredentials.fromJson(jsonDecode(user));
      }
      return UserCredentials();
    });
  }

  @override
  Future<Either<Failure, UserCredentials>> saveUserCredential(
    UserCredentials user,
  ) {
    return guardFuture(() async {
      return getUserCredentials().fold(
        (l) => throw l,
        (r) async {
          await box.put(
            key,
            jsonEncode(user),
          );
          return r;
        },
      );
    });
  }

  @override
  Future<Either<Failure, Unit>> signOut() {
    return guardFuture(() async {
      await box.delete(key);
      return unit;
    });
  }
}
