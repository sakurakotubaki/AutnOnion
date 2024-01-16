// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:onion_architecture_auth_app/dev_example/application/auth_notifier.dart';
// import 'package:onion_architecture_auth_app/dev_example/infrastructure/repository/auth_repository.dart';
// import 'package:onion_architecture_auth_app/dev_example/presentation/component/auth_error_msg.dart';
// import 'package:onion_architecture_auth_app/dev_example/presentation/home_page.dart';

// /// 新規登録画面
// class SignUpPage extends ConsumerWidget with SnackBarMixin {
//   const SignUpPage({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final emailController = TextEditingController();
//     final passwordController = TextEditingController();

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
//       appBar: AppBar(
//         title: const Text('新規登録'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             SizedBox(
//               width: 300,
//               height: 50,
//               child: TextFormField(
//                 controller: emailController,
//                 decoration: const InputDecoration(
//                   labelText: 'メールアドレス',
//                 ),
//               ),
//             ),
//             const SizedBox(height: 16),
//             SizedBox(
//               width: 300,
//               height: 50,
//               child: TextFormField(
//                 controller: passwordController,
//                 obscureText: true,
//                 decoration: const InputDecoration(
//                   labelText: 'パスワード',
//                 ),
//               ),
//             ),
//             const SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () async {
//                 try {
//                   await ref.read(authRepositoryImplProvider).signUp(
//                         emailController.text,
//                         passwordController.text,
//                       );
//                 } catch (e) {
//                   if (context.mounted) {
//                     showErrorSnackBar(context, e.toString());
//                   }
//                 }
//               },
//               child: const Text('新規登録'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
