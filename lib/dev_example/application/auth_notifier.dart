// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:onion_architecture_auth_app/dev_example/infrastructure/repository/auth_repository.dart';
// import 'package:onion_architecture_auth_app/example/domain/auth_state.dart';

// class AuthNotifier extends StateNotifier<AuthState> {
//   final AuthRepository authRepository;

//   AuthNotifier(this.authRepository) : super(AuthState());

//   Future<void> signIn(String email, String password) async {
//     try {
//       final userCredential = await authRepository.signIn(email, password);
//       state = AuthState(userCredential: userCredential);
//     } catch (e) {
//       state = AuthState(error: e.toString());
//     }
//   }

//   Future<void> signUp(String email, String password) async {
//     try {
//       final userCredential = await authRepository.signUp(email, password);
//       state = AuthState(userCredential: userCredential);
//     } catch (e) {
//       state = AuthState(error: e.toString());
//     }
//   }

//   Future<void> signOut() async {
//     try {
//       await authRepository.signOut();
//       state = AuthState();
//     } catch (e) {
//       state = AuthState(error: e.toString());
//     }
//   }
// }

// // AuthNotifierを提供するProvider
// final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
//   final authRepository = ref.watch(authRepositoryImplProvider);
//   return AuthNotifier(authRepository);
// });

// @riverpod
// class AuthNotifier extends _$AuthNotifier {
//   @override
//   AuthState build() {
//     return AuthState();
//   }

//   Future<User> signIn(String email, String password) async {
//     try {
//       final userCredential =
//           await ref.read(authRepositoryImplProvider).signIn(email, password);
//       return AuthState(userCredential: userCredential);
//     } catch (e) {
//       state = AuthState(error: e.toString());
//     }
//   }

//   Future<void> signUp(String email, String password) async {
//     try {
//       final userCredential =
//           await ref.read(authRepositoryImplProvider).signUp(email, password);
//       state = AuthState(userCredential: userCredential);
//     } catch (e) {
//       state = AuthState(error: e.toString());
//     }
//   }

//   Future<void> signOut() async {
//     try {
//       await ref.read(authRepositoryImplProvider).signOut();
//       state = AuthState();
//     } catch (e) {
//       state = AuthState(error: e.toString());
//     }
//   }
// }
