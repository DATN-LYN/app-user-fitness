import 'package:built_collection/src/list.dart';
import 'package:ferry/ferry.dart';
import 'package:fitness_app/global/graphql/mutation/__generated__/mutation_upsert_inbox.data.gql.dart';
import 'package:fitness_app/global/graphql/mutation/__generated__/mutation_upsert_inbox.var.gql.dart';
import 'package:fitness_app/global/graphql/query/__generated__/query_get_my_inboxes.req.gql.dart';

import '../query/__generated__/query_get_my_inboxes.data.gql.dart';

class UpsertInboxHandler {
  static const String key = '@DeleteMessageHandler';
  static UpdateCacheHandler<GUpsertInboxData, GUpsertInboxVars> handler =
      (proxy, response) {
    final GGetMyInboxesData_getMyInboxes_items inboxData =
        response.operationRequest.updateCacheHandlerContext?['inboxData'];

    final req = GGetMyInboxesReq(
      (b) => b
        ..requestId = '@getMyInboxesRequestId'
        ..fetchPolicy = FetchPolicy.CacheAndNetwork
        ..vars.queryParams.page = 1
        ..vars.queryParams.limit = 22
        ..vars.queryParams.orderBy = 'Inbox.createdAt:DESC',
    );
    final oldInboxes = proxy.readQuery(req);

    final newInboxes = oldInboxes!.getMyInboxes.items!.toList()..add(inboxData);
    final newData = oldInboxes.rebuild(
      (p0) => p0
        ..getMyInboxes.meta.itemCount =
            oldInboxes.getMyInboxes.meta!.totalItems! + 1
        ..getMyInboxes.items = ListBuilder(newInboxes),
    );

    proxy.writeQuery(
      req,
      newData,
    );
  };
}
