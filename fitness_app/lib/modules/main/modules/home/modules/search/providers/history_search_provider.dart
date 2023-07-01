import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../global/data/repositories/history_search_repository.dart';
import '../../../../../../../global/utils/riverpod/app_state.dart';

final historySearchProvider =
    StateNotifierProvider<HistorySearchProvider, AppState<List<String>>>(
  (ref) => HistorySearchProvider(
    ref.watch(historySearchRepositoryProvider),
  ),
);

class HistorySearchProvider extends StateNotifier<AppState<List<String>>> {
  HistorySearchProvider(this._hiveService)
      : super(
          _hiveService.getHistory().fold(
                (l) => AppState.error(l),
                (r) => AppState.data(r),
              ),
        );

  final HistorySearchRepository _hiveService;

  void addItemHistory(String item) {
    if (item.trim().isNotEmpty) {
      state = AppState.loading();
      _hiveService.addItemHistory(item).then((either) => either.fold(
            (l) => state = AppState.error(l),
            (r) => state = AppState.data(r),
          ));
    }
  }

  void deleteItemHistory(int index) async {
    state = AppState.loading();

    await _hiveService.deleteItemHistory(index).then(
          (either) => either.fold(
            (l) => state = AppState.error(l),
            (r) => state = AppState.data(r),
          ),
        );
  }

  void clearHistory() async {
    state = AppState.loading();

    await _hiveService.clearHistory().then(
          (either) => either.fold(
            (l) => state = AppState.error(l),
            (r) => state = AppState.data(r),
          ),
        );
  }
}
