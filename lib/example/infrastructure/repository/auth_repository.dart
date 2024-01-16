import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onion_architecture_auth_app/example/infrastructure/provider/auth_provider.dart';
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
