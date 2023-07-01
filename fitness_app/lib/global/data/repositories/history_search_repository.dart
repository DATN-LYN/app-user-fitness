import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';

import '../../utils/constants.dart';
import '../models/failure.dart';
import '_base_repository.dart';

final historySearchRepositoryProvider = Provider((ref) {
  return _HistorySearchRepositoryImpl(
    Hive.box(Constants.hiveDataBox),
  );
});

abstract class HistorySearchRepository {
  Either<Failure, List<String>> getHistory();

  Future<Either<Failure, List<String>>> addItemHistory(String item);

  Future<Either<Failure, List<String>>> clearHistory();

  Future<Either<Failure, List<String>>> deleteItemHistory(int index);
}

class _HistorySearchRepositoryImpl extends BaseRepository
    implements HistorySearchRepository {
  _HistorySearchRepositoryImpl(this.box);

  final Box<String> box;
  final String key = Constants.hiveSearchKey;

  @override
  Future<Either<Failure, List<String>>> addItemHistory(String item) {
    return guardFuture(() async {
      return getHistory().fold(
        (l) => throw l,
        (items) {
          return _updateListHistory([item, ...items]);
        },
      );
    });
  }

  @override
  Future<Either<Failure, List<String>>> deleteItemHistory(int index) {
    return guardFuture(() async {
      return getHistory().fold(
        (l) => throw l,
        (items) {
          items.removeAt(index);
          return _updateListHistory(items);
        },
      );
    });
  }

  @override
  Future<Either<Failure, List<String>>> clearHistory() {
    return guardFuture(() async {
      await box.delete(key);
      return [];
    });
  }

  @override
  Either<Failure, List<String>> getHistory() {
    return guard(() {
      final recentData = box.get(key);
      List<String> results = [];
      if (recentData != null) {
        List<dynamic> parseListRecent = jsonDecode(recentData);
        results =
            parseListRecent.map((recentItem) => recentItem.toString()).toList();
      }
      return results;
    });
  }

  Future<List<String>> _updateListHistory(List<String> items) async {
    await box.put(
      key,
      jsonEncode(items),
    );
    return items;
  }
}
