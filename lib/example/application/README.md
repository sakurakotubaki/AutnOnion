## ユースケースを作る
ViewModelと変わらない気がしますね。View側でエラーが出たら、Modelに通知。ModelからViewに通知。
エラーが出たら、スナックバーを出す!
よくある状態の管理をしてくれています。ロジックはリポジトリに書いて、Notifierを使って、Viewから呼び出します!

## riverpod1系のコード
StateNotifierで状態の管理をする。エラー処理の状態を持っているクラスをデータ型で使う。

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onion_architecture_auth_app/domain/auth_state.dart';
import 'package:onion_architecture_auth_app/infrastructure/repository/auth_repository.dart';

// AuthNotifierを定義。ViewModelですね。
class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository authRepository;

  AuthNotifier(this.authRepository) : super(AuthState());

  Future<void> signIn(String email, String password) async {
    try {
      final userCredential = await authRepository.signIn(email, password);
      state = AuthState(userCredential: userCredential);
    } catch (e) {
      state = AuthState(error: e.toString());
    }
  }

  Future<void> signUp(String email, String password) async {
    try {
      final userCredential = await authRepository.signUp(email, password);
      state = AuthState(userCredential: userCredential);
    } catch (e) {
      state = AuthState(error: e.toString());
    }
  }

  Future<void> signOut() async {
    try {
      await authRepository.signOut();
      state = AuthState();
    } catch (e) {
      state = AuthState(error: e.toString());
    }
  }
}

// AuthNotifierを提供するProvider
final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepository = ref.watch(authRepositoryImplProvider);
  return AuthNotifier(authRepository);
});
```

## riveropd2系のコード
これは、非同期な状態を管理するクラスではないので、AsyncNotifierにしない。Notifierクラスで使うと、ref.listenを使い続けることができる。

```dart
import 'package:onion_architecture_auth_app/domain/auth_state.dart';
import 'package:onion_architecture_auth_app/infrastructure/repository/auth_repository.dart';
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
```
