import 'package:flutter/material.dart';

/* [シングルトンで、SnackBarを表示するためのクラス]
どこからでも呼ぶことができる。
*/
class SnackBarUtils {
  SnackBarUtils._();
  static final instance = SnackBarUtils._();
  // 赤いSnackBarを表示する
  void showErrorSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      backgroundColor: Colors.red,
      content: Text(message),
      duration: const Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

/* [mixinで、SnackBarを表示するためのクラス]
例えば、SignInPageで使う場合は、
class SignInPage extends HookConsumerWidget with SnackBarMixin
で多重継承できる。こうすることで、UI側でSnackBarを表示することがメソッドを
mixinクラスから呼ぶことができる。
*/
mixin SnackBarMixin {
  // シングルトンのSnackBarUtilsを使う。これだとあるクラスに依存しているので、密結合になるかな〜?
  void showErrorSnackBar(BuildContext context, String message) {
    SnackBarUtils.instance.showErrorSnackBar(context, message);
  }
}
