import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onion_architecture_auth_app/example/application/usecase/auth_notifier.dart';
import 'package:onion_architecture_auth_app/example/domain/auth_state.dart';
import 'package:onion_architecture_auth_app/example/presentation/home_page.dart';
import 'package:onion_architecture_auth_app/example/presentation/sign_up_page.dart';


/// ログイン画面
class SignInPage extends ConsumerWidget {
  const SignInPage({super.key});

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
      // ログインに成功したら、ホーム画面に遷移する
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
        title: const Text('ログイン'),
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
                await ref.read(authNotifierProvider.notifier).signIn(
                      emailController.text,
                      passwordController.text,
                    );
              },
              child: const Text('ログイン'),
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return const SignUpPage();
                      },
                    ),
                  );
                },
                child: const Text('新規登録')),
          ],
        ),
      ),
    );
  }
}
