// viewでは、表示にかかわることだけを行います。
// この例は、ログイン画面です。
// ViewとViewModelは、Providerで密に連携します、View側ではModelの監視、Modelの更新依頼、Modelからデータの取得を行います。

import 'package:flutter/material.dart';
import 'package:mvvm_provider_template/mvvm/view/home_screen.dart';
import 'package:mvvm_provider_template/mvvm/view_models/login_view_model.dart';
import 'package:mvvm_provider_template/style.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // ViewModelの通知を受け取ります（APIの実行結果を通知してもらうなど）
        // Consumerは型を指定して利用します。
        child: Consumer<LoginViewModel>(
          builder: (context, model, child) {
            // ViewModelの状態を見てViewの表示内容を決めています
            if (model.isLoading) {
              // loadingの状態であれば、loadingのViewを表示
              return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Text("ログイン中"),
                    CircularProgressIndicator()
                  ]
              );
            } else {
              // Consumerで状態変化の通知を受け取っており、
              // loadingが終了すれば、別の画面を表示する
              return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // styleは外部に定義しています
                const Text("未ログイン", style: loginTitleTextStyle,
                ),
                IconButton(
                  icon: const Icon(Icons.login_outlined),
                  onPressed: () => login(context),)
              ],
            );
            }
          },
        ),
      ),
    );
  }

  login(BuildContext context) async {
    // viewModelからログインを実行する
    final loginViewModel = Provider.of<LoginViewModel>(context, listen: false);
    await loginViewModel.signIn();
    if (!loginViewModel.isSuccessful) {
      // ログイン失敗
      // Fluttertoast.showToast(msg: S.of(context).signInFailed);
      return;
    }
    _openHomeScreen(context);
  }

  void _openHomeScreen(BuildContext context) {
    Navigator.push( context,
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  }
}
