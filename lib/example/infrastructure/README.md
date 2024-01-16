## 認証のロジックを書いたレポジトリ
Enumと抽象クラスが必要なのかと考えたが、意外と書いている人が多いので作ってみた。Enumと抽象クラスがなければもっと短くかける。

## riverpod1系のコード
プロパイダーから、FirebaseAuthのインスタンスを呼び出して、ログイン、新規登録、ログアウトのメソッドを使えるようにした。これだけで使えるが、Viewとロジックを分けるには、riverpodやProvierを使ってViewModelにすることがよくある書き方。

```dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onion_architecture_auth_app/infrastructure/provider/auth_provider.dart';

// FirebaseAuthのエラーコードをenumで定義。定数ですね。
enum AuthErrorCode {
  invalidEmail,
  userDisabled,
  userNotFound,
  wrongPassword,
  unknown,
}

// FirebaseAuthのエラーコードをenumに変換する関数。そのまま渡すとString型になるので、enumに変換しています。
AuthErrorCode parseErrorCode(String errorCode) {
  switch (errorCode) {
    case 'invalid-email':
      return AuthErrorCode.invalidEmail;
    case 'user-disabled':
      return AuthErrorCode.userDisabled;
    case 'user-not-found':
      return AuthErrorCode.userNotFound;
    case 'wrong-password':
      return AuthErrorCode.wrongPassword;
    default:
      return AuthErrorCode.unknown;
  }
}

// e.codeを受け取って、エラーメッセージを返す関数
String handleError(AuthErrorCode errorCode) {
  switch (errorCode) {
    case AuthErrorCode.invalidEmail:
      return 'メールアドレスが無効。';
    case AuthErrorCode.userDisabled:
      return 'このアカウントは無効になっています。';
    case AuthErrorCode.userNotFound:
      return 'アカウントが見つかりません。';
    case AuthErrorCode.wrongPassword:
      return 'パスワードが一致しません。';
    default:
      return 'エラーが発生しました。';
  }
}

// 認証のメソッドのみを定義した抽象クラス
abstract interface class AuthRepository {
  Future<UserCredential> signUp(String email, String password);
  Future<UserCredential> signIn(String email, String password);
  Future<void> signOut();
}

// AuthRepositoryを提供するProvider
final authRepositoryImplProvider =
    Provider<AuthRepositoryImpl>((ref) => AuthRepositoryImpl(ref));

// インターフェースを実装したクラス
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this.ref);
  final Ref ref;

  // ログインメソッド
  @override
  Future<UserCredential> signIn(String email, String password) async {
    try {
      final result = await ref.read(authProvider).signInWithEmailAndPassword(
            email: email,
            password: password,
          );
      return result;
    } on FirebaseAuthException catch (e) {
      throw handleError(parseErrorCode(e.code));
    } catch (e) {
      throw 'エラーが発生しました。';
    }
  }

  // 新規登録メソッド
  @override
  Future<UserCredential> signUp(String email, String password) async {
    try {
      final result =
          await ref.read(authProvider).createUserWithEmailAndPassword(
                email: email,
                password: password,
              );
      return result;
    } on FirebaseAuthException catch (e) {
      throw handleError(parseErrorCode(e.code));
    } catch (e) {
      throw 'エラーが発生しました。';
    }
  }

  // ログアウトメソッド
  @override
  Future<void> signOut() async {
    await ref.read(authProvider).signOut();
  }
}
```

## 簡単な書き方の例
ViewModelは使わないで、View側でエラーが出たら、SnackBarを出すようにしている。このクラスからメソッドを呼び出すだけで、
ログインと新規登録はできる。

```dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../domain/service/auth/auth_provider.dart';

part 'auth_service.g.dart';

@Riverpod(keepAlive: true)
AuthService authService(AuthServiceRef ref) {
  return AuthService(ref);
}

class AuthService {
  AuthService(this.ref);
  Ref ref;

  Future<UserCredential> signUp(String email, String password) async {
    try {
      final result =
          await ref.read(firebaseAuthProvider).createUserWithEmailAndPassword(
                email: email,
                password: password,
              );
      return result;
    } on FirebaseAuthException catch (e) {
      throw _handleError(e.code);
    } catch (e) {
      throw 'エラーが発生しました。';
    }
  }

  Future<UserCredential> signIn(String email, String password) async {
    try {
      final result = await ref.read(firebaseAuthProvider).signInWithEmailAndPassword(
            email: email,
            password: password,
          );
      return result;
    } on FirebaseAuthException catch (e) {
      throw _handleError(e.code);
    } catch (e) {
      throw 'エラーが発生しました。';
    }
  }

  // パスワードのリセット
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await ref.read(firebaseAuthProvider).sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw _handleError(e.code);
    } catch (e) {
      throw 'エラーが発生しました。';
    }
  }

  String _handleError(String errorCode) {
    switch (errorCode) {
      case 'invalid-email':
        return 'メールアドレスが無効。';
      case 'user-disabled':
        return 'このアカウントは無効になっています。';
      case 'user-not-found':
        return 'アカウントが見つかりません。';
      case 'wrong-password':
        return 'パスワードが一致しません。';
      default:
        return 'エラーが発生しました。';
    }
  }
}
```

## riverpod2系のコード
関数のようなものを書いて、プロバイダーを生成するようにするコードに変更。

```dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onion_architecture_auth_app/infrastructure/provider/auth_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'auth_repository.g.dart';

// FirebaseAuthのエラーコードをenumで定義。定数ですね。
enum AuthErrorCode {
  invalidEmail,
  userDisabled,
  userNotFound,
  wrongPassword,
  unknown,
}

// FirebaseAuthのエラーコードをenumに変換する関数。そのまま渡すとString型になるので、enumに変換しています。
AuthErrorCode parseErrorCode(String errorCode) {
  switch (errorCode) {
    case 'invalid-email':
      return AuthErrorCode.invalidEmail;
    case 'user-disabled':
      return AuthErrorCode.userDisabled;
    case 'user-not-found':
      return AuthErrorCode.userNotFound;
    case 'wrong-password':
      return AuthErrorCode.wrongPassword;
    default:
      return AuthErrorCode.unknown;
  }
}

// e.codeを受け取って、エラーメッセージを返す関数
String handleError(AuthErrorCode errorCode) {
  switch (errorCode) {
    case AuthErrorCode.invalidEmail:
      return 'メールアドレスが無効。';
    case AuthErrorCode.userDisabled:
      return 'このアカウントは無効になっています。';
    case AuthErrorCode.userNotFound:
      return 'アカウントが見つかりません。';
    case AuthErrorCode.wrongPassword:
      return 'パスワードが一致しません。';
    default:
      return 'エラーが発生しました。';
  }
}

// 認証のメソッドのみを定義した抽象クラス
abstract interface class AuthRepository {
  Future<UserCredential> signUp(String email, String password);
  Future<UserCredential> signIn(String email, String password);
  Future<void> signOut();
}

// AuthRepositoryを提供するProvider
// final authRepositoryImplProvider =
//     Provider<AuthRepositoryImpl>((ref) => AuthRepositoryImpl(ref));

// 状態の破棄が必要ないと思うので、keepAliveをtrueにしています。
@Riverpod(keepAlive: true)
AuthRepositoryImpl authRepositoryImpl(AuthRepositoryImplRef ref) => AuthRepositoryImpl(ref);
// インターフェースを実装したクラス
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this.ref);
  final Ref ref;

  // ログインメソッド
  @override
  Future<UserCredential> signIn(String email, String password) async {
    try {
      final result = await ref.read(firebaseAuthProvider).signInWithEmailAndPassword(
            email: email,
            password: password,
          );
      return result;
    } on FirebaseAuthException catch (e) {
      throw handleError(parseErrorCode(e.code));
    } catch (e) {
      throw 'エラーが発生しました。';
    }
  }

  // 新規登録メソッド
  @override
  Future<UserCredential> signUp(String email, String password) async {
    try {
      final result =
          await ref.read(firebaseAuthProvider).createUserWithEmailAndPassword(
                email: email,
                password: password,
              );
      return result;
    } on FirebaseAuthException catch (e) {
      throw handleError(parseErrorCode(e.code));
    } catch (e) {
      throw 'エラーが発生しました。';
    }
  }

  // ログアウトメソッド
  @override
  Future<void> signOut() async {
    await ref.read(firebaseAuthProvider).signOut();
  }
}
```
