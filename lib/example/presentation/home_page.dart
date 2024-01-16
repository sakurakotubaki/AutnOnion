import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onion_architecture_auth_app/example/application/usecase/auth_notifier.dart';
import 'package:onion_architecture_auth_app/example/domain/auth_state.dart';
import 'package:onion_architecture_auth_app/example/presentation/sign_in_page.dart';


/// ログインしたら表示されるホーム画面
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AuthState>(authNotifierProvider, (pref, next) {
      // ログアウトしたらログイン画面に戻る
        if (next.userCredential != null) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const SignInPage(),
            ),
            (_) => false,
          );
        }
    });

    return Scaffold(
        appBar: AppBar(
      actions: [
        IconButton(
          onPressed: () async {
            await ref.read(authNotifierProvider.notifier).signOut();
          },
          icon: const Icon(Icons.logout),
        ),
      ],
      title: const Text('Welcome!'),
    ));
  }
}
