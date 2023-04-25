import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/user_credentials.dart';
import '../data/repositories/user_credential_repository.dart';
import 'auth_provider.dart';

final meProvider = Provider<UserCredentials?>((ref) {
  ref.watch(authProvider);
  final userCredentialsRepository = ref.read(
    userCredentialsRepositoryProvider,
  );
  return userCredentialsRepository.getUserCredentials().fold(
        (l) => null,
        (r) => r,
      );
});

final isSignedInProvider = Provider<bool>((ref) {
  final user = ref.watch(meProvider);
  return user?.accessToken != null;
});
