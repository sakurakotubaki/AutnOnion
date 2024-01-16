import 'package:onion_architecture_auth_app/example/domain/auth_state.dart';
import 'package:onion_architecture_auth_app/example/infrastructure/repository/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'auth_notifier.g.dart';

@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  AuthState build() {
    return AuthState();
  }

    Future<void> signIn(String email, String password) async {
    try {
      final userCredential = await ref.read(authRepositoryImplProvider).signIn(email, password);
      state = AuthState(userCredential: userCredential);
    } catch (e) {
      state = AuthState(error: e.toString());
    }
  }

  Future<void> signUp(String email, String password) async {
    try {
      final userCredential = await ref.read(authRepositoryImplProvider).signUp(email, password);
      state = AuthState(userCredential: userCredential);
    } catch (e) {
      state = AuthState(error: e.toString());
    }
  }

  Future<void> signOut() async {
    try {
      await ref.read(authRepositoryImplProvider).signOut();
      state = AuthState();
    } catch (e) {
      state = AuthState(error: e.toString());
    }
  }
}
