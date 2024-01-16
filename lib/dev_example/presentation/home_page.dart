// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:onion_architecture_auth_app/dev_example/application/auth_notifier.dart';
// import 'package:onion_architecture_auth_app/dev_example/infrastructure/repository/auth_repository.dart';

// /// ログインしたら表示されるホーム画面
// class HomePage extends ConsumerWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     ref.listen(authNotifierProvider, (pref, next) {
//       // ログインに成功したら、ホーム画面に遷移する
//       if (next.userCredential != null) {
//         Navigator.of(context).pushAndRemoveUntil(
//           MaterialPageRoute(
//             builder: (context) => const HomePage(),
//           ),
//           (_) => false,
//         );
//       }
//     });

//     return Scaffold(
//         appBar: AppBar(
//       actions: [
//         IconButton(
//           onPressed: () async {
//             await ref.read(authRepositoryImplProvider).signOut();
//           },
//           icon: const Icon(Icons.logout),
//         ),
//       ],
//       title: const Text('Welcome!'),
//     ));
//   }
// }
