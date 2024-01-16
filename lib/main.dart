import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onion_architecture_auth_app/example/infrastructure/provider/auth_provider.dart';
import 'package:onion_architecture_auth_app/example/presentation/home_page.dart';
import 'package:onion_architecture_auth_app/example/presentation/sign_in_page.dart';
import 'package:onion_architecture_auth_app/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // AsyncValue<User?> user型の変数を作成
    final user = ref.watch(authStateChangesProvider);

    return MaterialApp(
      // StreamProviderを使っているので、StreamProviderの値が変更されると、
      // このConsumerWidgetが再ビルドされる。AsyncValueなので、whenが使える。data, loading, errorの3つの状態を持つ。
      home: user.when(
        data: (user) {// dataあったら、userがnullかどうかで、表示するWidgetを変更する。
          if (user == null) {
            return const SignInPage();
          } else {
            return const HomePage();
          }
        },
        loading: () => const Scaffold(// loadingの間は、ローディング画面を表示する。
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
        error: (error, stackTrace) => const Scaffold(// errorの間は、エラー画面を表示する。
          body: Center(
            child: Text('エラーが発生しました'),
          ),
        ),
      ),
    );
  }
}
