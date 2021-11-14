import 'package:flutter/material.dart';
import 'package:mvvm_provider_template/style.dart';

class PostPage extends StatelessWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 70.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text("ログイン成功", style: loginTitleTextStyle,)
            ],
          ),
        ),
      ),
    );
  }
}
