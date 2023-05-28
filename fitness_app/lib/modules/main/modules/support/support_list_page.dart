import 'package:auto_route/auto_route.dart';
import 'package:ferry/ferry.dart';
import 'package:fitness_app/global/graphql/query/__generated__/query_get_my_supports.req.gql.dart';
import 'package:fitness_app/modules/main/modules/support/widgets/shimmer_support_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../global/gen/i18n.dart';
import '../../../../global/graphql/client.dart';
import '../../../../global/utils/constants.dart';
import '../../../../global/widgets/fitness_empty.dart';
import '../../../../global/widgets/fitness_error.dart';
import '../../../../global/widgets/infinity_list.dart';
import 'widgets/support_tile.dart';

class SupportListPage extends ConsumerStatefulWidget {
  const SupportListPage({super.key});

  @override
  ConsumerState<SupportListPage> createState() => _SupportListPageState();
}

class _SupportListPageState extends ConsumerState<SupportListPage> {
  var getSupportsReq = GGetMySupportsReq(
    (b) => b
      ..requestId = '@getMySupportsRequestId'
      ..fetchPolicy = FetchPolicy.CacheAndNetwork
      ..vars.queryParams.page = 1
      ..vars.queryParams.limit = Constants.defaultLimit
      ..vars.queryParams.orderBy = 'Support.createdAt:DESC',
  );
  @override
  Widget build(BuildContext context) {
    final client = ref.watch(appClientProvider);

    final i18n = I18n.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(i18n.support_Title),
        leading: IconButton(
          onPressed: context.popRoute,
          icon: const Icon(
            Icons.arrow_back_ios_outlined,
          ),
        ),
      ),
      body: InfinityList(
        client: client,
        request: getSupportsReq,
        loadMoreRequest: (response) {
          final data = response?.data?.getMySupports;
          if (data != null &&
              data.meta!.currentPage!.toDouble() <
                  data.meta!.totalPages!.toDouble()) {
            getSupportsReq = getSupportsReq.rebuild(
              (b) => b
                ..vars.queryParams.page = (b.vars.queryParams.page! + 1)
                ..updateResult = (previous, result) =>
                    previous?.rebuild(
                      (b) => b.getMySupports
                        ..meta = (result?.getMySupports.meta ??
                                previous.getMySupports.meta)!
                            .toBuilder()
                        ..items.addAll(result?.getMySupports.items ?? []),
                    ) ??
                    result,
            );
            return getSupportsReq;
          }
          return null;
        },
        refreshRequest: () {
          getSupportsReq = getSupportsReq.rebuild(
            (b) => b
              ..vars.queryParams.page = 1
              ..updateResult = ((previous, result) => result),
          );
          return getSupportsReq;
        },
        builder: (context, response, error) {
          if ((response?.hasErrors == true ||
                  response?.data?.getMySupports.meta?.itemCount == 0) &&
              getSupportsReq.vars.queryParams.page != 1) {
            getSupportsReq = getSupportsReq.rebuild(
              (b) => b..vars.queryParams.page = b.vars.queryParams.page! - 1,
            );
          }

          if (response?.hasErrors == true) {
            return FitnessError(response: response);
          }

          if (response?.hasErrors == true) {
            return FitnessError(response: response);
          }

          if (response?.loading ?? false) {
            return ListView.separated(
              itemCount: 3,
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              itemBuilder: (context, index) {
                return const ShimmerSupportTile();
              },
              separatorBuilder: (_, __) => const SizedBox(height: 16),
            );
          }

          final data = response!.data!.getMySupports;
          final hasMoreData = data.meta!.currentPage!.toDouble() <
              data.meta!.totalPages!.toDouble();
          final supports = data.items;

          if (supports?.isEmpty == true) {
            return FitnessEmpty(
              title: i18n.common_EmptyData,
            );
          }

          return ListView.separated(
            itemCount: supports!.length + (hasMoreData ? 1 : 0),
            itemBuilder: (context, index) {
              final item = supports[index];
              return SupportTile(support: item);
            },
            separatorBuilder: (_, __) => const Divider(height: 1),
          );
        },
      ),
    );
  }
}
