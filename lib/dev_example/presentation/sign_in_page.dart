// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:onion_architecture_auth_app/dev_example/application/auth_notifier.dart';
// import 'package:onion_architecture_auth_app/dev_example/infrastructure/repository/auth_repository.dart';
// import 'package:onion_architecture_auth_app/dev_example/presentation/component/auth_error_msg.dart';
// import 'package:onion_architecture_auth_app/dev_example/presentation/home_page.dart';
// import 'package:onion_architecture_auth_app/dev_example/presentation/sign_up_page.dart';

// /// ログイン画面
// class SignInPage extends ConsumerWidget with SnackBarMixin {
//   const SignInPage({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final emailController = TextEditingController();
//     final passwordController = TextEditingController();

//     ref.listen(authNotifierProvider, (pref, next) {
//       // ログインに失敗したら、エラーメッセージを表示する
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
//         title: const Text('ログイン'),
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
//                   await ref
//                       .read(authRepositoryImplProvider)
//                       .signIn(emailController.text, passwordController.text);
//                 } catch (e) {
//                   // エラーが出たら、mixinのスナックバーのメソッドを呼ぶ
//                   if (context.mounted) {
//                     showErrorSnackBar(context, e.toString());
//                   }
//                 }
//               },
//               child: const Text('ログイン'),
//             ),
//             TextButton(
//                 onPressed: () {
//                   Navigator.of(context).push(
//                     MaterialPageRoute(
//                       builder: (context) {
//                         return const SignUpPage();
//                       },
//                     ),
//                   );
//                 },
//                 child: const Text('新規登録')),
//           ],
//         ),
//       ),
//     );
//   }
// }
