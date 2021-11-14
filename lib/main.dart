import 'package:flutter/material.dart';
import 'package:mvvm_provider_template/di/providers.dart';
import 'package:provider/provider.dart';

import 'mvvm/view/home_screen.dart';
import 'mvvm/view/login/screens/login_screen.dart';
import 'mvvm/view_models/login_view_model.dart';

void main() {
  runApp(
    // root でProviderを定義します.
    // 特徴：全体からアクセスができる、MaterialAppに依存するものは×
      MultiProvider(
        providers: globalProviders,
        child: const MyApp(),
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // 読み取るだけ。値の変化はキャッチしないのでlisten false。
    final loginViewModel = Provider.of<LoginViewModel>(context, listen: false);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
        // futureBuilderはfutureに設定する非同期処理の完了でWidgetがBuildされる。
        home: FutureBuilder(
          future: loginViewModel.isSignIn(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.hasData && snapshot.data == true) {
              return const HomeScreen();
            } else {
              return const LoginScreen();
            }
          },
        )
    );
  }
}