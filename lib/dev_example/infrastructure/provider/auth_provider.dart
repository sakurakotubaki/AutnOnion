// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';
// part 'auth_provider.g.dart';

// @riverpod
// FirebaseAuth firebaseAuth(FirebaseAuthRef ref) {
//   return FirebaseAuth.instance;
// }

// @riverpod
// Stream<User?> authStateChanges(AuthStateChangesRef ref) {
//   return ref.watch(firebaseAuthProvider).authStateChanges();
// }

// @riverpod
// String? uid(UidRef ref) {
//   return ref.watch(firebaseAuthProvider).currentUser?.uid;
// }

// FirebaseAuthを提供するProvider
// final authProvider = Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

// // ログイン状態を監視するProvider
// final authStateChangesProvider = StreamProvider<User?>((ref) {
//   return ref.watch(authProvider).authStateChanges();
// });

// // uidを提供するProvider
// final uidProvider = Provider<String?>((ref) {
//   return ref.watch(authProvider).currentUser?.uid;
// });
