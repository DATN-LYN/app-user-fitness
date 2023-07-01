import 'package:dartz/dartz.dart';

import '../models/failure.dart';

class BaseRepository {
  Future<Either<Failure, T>> guardFuture<T>(
    Future<T> Function() future,
  ) async {
    try {
      return right(await future());
    } catch (e, __) {
      print('Error: $e');
      print('Stack trace: $__');
      return left(Failure.unknown(e));
    }
  }

  Either<Failure, T> guard<T>(T Function() body) {
    try {
      return right(body());
    } catch (e) {
      return left(Failure.unknown(e));
    }
  }
}
