// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:onion_architecture_auth_app/example/infrastructure/provider/auth_provider.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';
// part 'auth_repository.g.dart';

// /* 認証のメソッドのみを定義した抽象クラス
// [abstract class AuthRepository] でも良い。これが昔からある書き方。
// */
// abstract interface class AuthRepository {
//   Future<UserCredential> signUp(String email, String password);
//   Future<UserCredential> signIn(String email, String password);
//   Future<void> signOut();
// }

// // AuthRepositoryを提供するProvider
// // final authRepositoryImplProvider =
// //     Provider<AuthRepositoryImpl>((ref) => AuthRepositoryImpl(ref));

// // 状態の破棄が必要ないと思うので、keepAliveをtrueにしています。
// @Riverpod(keepAlive: true)
// AuthRepositoryImpl authRepositoryImpl(AuthRepositoryImplRef ref) => AuthRepositoryImpl(ref);
// // インターフェースを実装したクラス
// class AuthRepositoryImpl implements AuthRepository {
//   AuthRepositoryImpl(this.ref);
//   final Ref ref;// ref.read使うため必要

//   // ログインメソッド
//   @override
//   Future<UserCredential> signIn(String email, String password) async {
//     try {
//       final result = await ref.read(firebaseAuthProvider).signInWithEmailAndPassword(
//             email: email,
//             password: password,
//           );
//       return result;
//     } on FirebaseAuthException catch (e) {
//       throw _handleError(e.code);
//     } catch (e) {
//       throw 'エラーが発生しました。';
//     }
//   }

//   // 新規登録メソッド
//   @override
//   Future<UserCredential> signUp(String email, String password) async {
//     try {
//       final result =
//           await ref.read(firebaseAuthProvider).createUserWithEmailAndPassword(
//                 email: email,
//                 password: password,
//               );
//       return result;
//     } on FirebaseAuthException catch (e) {
//       throw _handleError(e.code);
//     } catch (e) {
//       throw 'エラーが発生しました。';
//     }
//   }

//   // ログアウトメソッド
//   @override
//   Future<void> signOut() async {
//     await ref.read(firebaseAuthProvider).signOut();
//   }

//   /* FirebaseAuthExceptionのエラーコードに応じて、エラーメッセージを返すメソッド。
//   表示は、SnackBarを使って、View側で表示する。
//   */
//   String _handleError(String errorCode) {
//     switch (errorCode) {
//       case 'invalid-email':
//         return 'メールアドレスが無効。';
//       case 'user-disabled':
//         return 'このアカウントは無効になっています。';
//       case 'user-not-found':
//         return 'アカウントが見つかりません。';
//       case 'wrong-password':
//         return 'パスワードが一致しません。';
//       default:
//         return 'エラーが発生しました。';
//     }
//   }
// }
