import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onion_architecture_auth_app/example/application/usecase/auth_notifier.dart';
import 'package:onion_architecture_auth_app/example/domain/auth_state.dart';
import 'package:onion_architecture_auth_app/example/presentation/home_page.dart';

/// 新規登録画面
class SignUpPage extends ConsumerWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    ref.listen<AuthState>(authNotifierProvider, (pref, next) {
      // ログインに失敗したら、エラーメッセージを表示する
      if (next.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(next.error!),
          ),
        );
      }
      // 新規登録に成功したら、ホーム画面に遷移する
      if (next.userCredential != null) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
          (_) => false,
        );
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('新規登録'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 300,
              height: 50,
              child: TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'メールアドレス',
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: 300,
              height: 50,
              child: TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'パスワード',
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                await ref.read(authNotifierProvider.notifier).signUp(
                      emailController.text,
                      passwordController.text,
                    );
              },
              child: const Text('新規登録'),
            ),
          ],
        ),
      ),
    );
  }
}
