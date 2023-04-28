import 'package:fitness_app/global/providers/user_credential_provider.dart';
import 'package:fitness_app/global/utils/riverpod/app_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/user_credentials.dart';
import '../graphql/auth/__generated__/query_login.data.gql.dart';

enum AuthProviderLoading {
  logIn,
  logOut,
}

final authProvider =
    StateNotifierProvider<AuthNotifier, AppState<UserCredentials>>(
  (ref) {
    return AuthNotifier(
      ref: ref,
      userCredentialProvider: ref.watch(userCredentialProvider),
    );
  },
);

class AuthNotifier extends StateNotifier<AppState<UserCredentials>> {
  AuthNotifier({
    required this.ref,
    required this.userCredentialProvider,
  }) : super(AppState.initial());

  final Ref ref;
  final UserCredential userCredentialProvider;

  //   void getUser(UserCredentials user) {
  //   state = AppState.loading(AuthProviderLoading.getUser.name);
  //   if (user.accessToken != null) {
  //     authRepository.getUser(user).then(
  //           (either) => either.fold(
  //             (l) => state = AppState.error(l),
  //             (r) => state = AppState.data(r),
  //           ),
  //         );
  //   }
  // }

  void logIn(GLoginData data) {
    state = AppState.loading(AuthProviderLoading.logIn.name);
    userCredentialProvider.saveUserCredential(
      UserCredentials.fromJson(data.login.toJson()),
    );
    state = AppState.data(userCredentialProvider.getUserCredential());
  }

  void logOut() {
    state = AppState.loading(AuthProviderLoading.logOut.name);
    userCredentialProvider.saveUserCredential(UserCredentials());
    state = AppState.data(userCredentialProvider.getUserCredential());
  }
}
