// view modelでは、Viewから依頼されるものを返します。必要であればModelと連携します。
// Modelとの連携はRepository層を経由します。
// ビジネスロジックはViewには書かず、Modelにも書かず、ViewModelに描きます。
// 状態を持ち、Viewには状態の変化だけ通知する役割を持ちます。

import 'package:flutter/material.dart';
import 'package:mvvm_provider_template/models/repository/user_repository.dart';

class LoginViewModel extends ChangeNotifier {
  final UserRepository userRepository; // 依存するModel
  LoginViewModel({required this.userRepository});

  bool isLoading = false; // 状態
  bool isSuccessful = false; // 状態

  // sign in status
  Future<bool> isSignIn() async {
    return await userRepository.isSignIn();
  }

  Future<void> signIn() async {
    isLoading = true; // 状態を持ち
    notifyListeners(); // Viewに通知

    isSuccessful = await userRepository.signIn();

    isLoading = false; // 状態を更新し、
    notifyListeners(); // Viewに通知
  }
}