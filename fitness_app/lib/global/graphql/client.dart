import 'package:ferry/ferry.dart';
import 'package:ferry_hive_store/ferry_hive_store.dart';
import 'package:fitness_app/global/providers/user_credential_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../utils/constants.dart';
import 'auth/__generated__/query_refresh_token.req.gql.dart';
import 'http_auth_link.dart';

final appClientProvider = Provider(
  (ref) => AppClient(ref).initClient(),
);

class AppClient {
  final box = Hive.box(Constants.hiveGraphqlBox);
  AppClient(this._ref) {
    box.clear();
    store = HiveStore(box);
    cache = Cache(store: store);
  }
  late Cache cache;
  late HiveStore store;

  final Ref _ref;
  late final userCredentialsPro = _ref.read(userCredentialProvider);

  Client initClient() {
    late Client client;

    final link = HttpAuthLink(
      ref: _ref,
      graphQLEndpoint: Constants.graphQLEndpoint,
      getToken: () {
        String? token = userCredentialsPro.getUserCredential().accessToken;

        return 'Bearer $token';
      },
      getNewToken: () async {
        final userCredentials = userCredentialsPro.getUserCredential();
        String? refreshToken = userCredentials.refreshToken;

        final result = await client
            .request(
              GRefreshTokenReq(
                (b) => b..vars.refreshToken = refreshToken,
              ),
            )
            .first;

        if (!result.hasErrors) {
          final newToken = result.data?.refreshToken.token;

          await userCredentialsPro.saveUserCredential(
            userCredentials.copyWith(
              accessToken: newToken,
            ),
          );
        }
      },
    );

    client = Client(
      link: link,
      cache: cache,
      defaultFetchPolicies: {
        OperationType.query: FetchPolicy.CacheAndNetwork,
        OperationType.mutation: FetchPolicy.NoCache,
      },
      updateCacheHandlers: {
        // UpsertInboxHandler.key: UpsertInboxHandler.handler,
      },
    );
    return client;
  }
}
