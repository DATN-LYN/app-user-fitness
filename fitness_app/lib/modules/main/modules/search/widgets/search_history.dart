import 'package:fitness_app/global/widgets/fitness_error.dart';
import 'package:fitness_app/global/widgets/indicator_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../global/themes/app_colors.dart';
import '../providers/history_search_provider.dart';

class SearchHistory extends ConsumerWidget {
  const SearchHistory({
    super.key,
    required this.onTap,
  });

  final ValueChanged<String> onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyProvider = ref.watch(historySearchProvider.notifier);
    final state = ref.watch(historySearchProvider);
    return Column(
      children: [
        Row(
          children: [
            const SizedBox(width: 16),
            const Text(
              'Recent Searches',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: historyProvider.clearHistory,
              child: const Text(
                'Clear all',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            const SizedBox(width: 16),
          ],
        ),
        const Divider(height: 1),
        Expanded(
          child: state.maybeWhen(
            data: (data, _) {
              return ListView.separated(
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                primary: false,
                itemCount: data.length > 20 ? 20 : data.length,
                separatorBuilder: (_, __) => const Divider(
                  height: 1,
                  indent: 16,
                ),
                itemBuilder: (BuildContext context, int index) {
                  final item = data[index];

                  return ListTile(
                    visualDensity: VisualDensity.compact,
                    onTap: () => onTap(item),
                    title: Text(item),
                    trailing: IconButton(
                      splashRadius: 10,
                      onPressed: () => historyProvider.deleteItemHistory(index),
                      icon: const Icon(
                        Icons.close,
                        size: 14,
                        color: AppColors.grey1,
                      ),
                    ),
                  );
                },
              );
            },
            error: (error) => const FitnessError(),
            orElse: () => const IndicatorLoading(),
          ),
        ),
      ],
    );
  }
}
