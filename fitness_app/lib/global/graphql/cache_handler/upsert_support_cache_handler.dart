import 'package:ferry/ferry.dart';

import '../__generated__/schema.schema.gql.dart';
import '../fragment/__generated__/support_fragment.data.gql.dart';
import '../fragment/__generated__/support_fragment.req.gql.dart';
import '../mutation/__generated__/mutation_upsert_support.data.gql.dart';
import '../mutation/__generated__/mutation_upsert_support.var.gql.dart';

class UpsertSupportCacheHandler {
  const UpsertSupportCacheHandler._();

  static const String key = '@upsertSupportCacheHandler';

  static UpdateCacheHandler<GUpsertSupportData, GUpsertSupportVars> handler =
      (proxy, response) {
    final upsertData = response.operationRequest
        .updateCacheHandlerContext?['upsertData'] as GUpsertSupportInputDto;
    if (upsertData.id != null) {
      final req = GSupportReq((b) => b..idFields = {'id': upsertData.id});
      final oldSupport = proxy.readFragment(req);

      final newData = response.data != null
          ? GSupportData.fromJson(response.data!.upsertSupport.toJson())
          : null;
      if (newData != null && oldSupport != null) {
        final updatedSupport = newData;

        proxy.writeFragment(req, updatedSupport);
      }
    }
  };
}
