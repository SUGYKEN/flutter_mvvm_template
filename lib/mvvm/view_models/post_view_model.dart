// view modelでは、Viewから依頼されるものを返します。必要であればModelと連携します。
// Modelとの連携はRepository層を経由します。
// ビジネスロジックはViewには書かず、Modelにも書かず、ViewModelに描きます。
// 状態を持ちます、Viewには状態の変化だけ通知する役割を持ちます。

// notifyListenersで、Providerに状態の変更を通知、ViewはProviderをConsumerしているので
// 状態の変更を受け取れます

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mvvm_provider_template/mvvm/data_model/location.dart';
import 'package:mvvm_provider_template/mvvm/models/repository/post_repository.dart';
import 'package:mvvm_provider_template/mvvm/models/repository/user_repository.dart';

// 投稿のViewModel
class PostViewModel extends ChangeNotifier {
  final PostRepository postRepository; // 依存するModel
  final UserRepository userRepository; // 依存するModel
  PostViewModel({required this.postRepository, required this.userRepository});

  bool isProcessing = false; // 状態
  // model
  Location? location; // 状態　

  // pick image
  pickImage() async {
    isProcessing = true;
    notifyListeners();
    // 何かしらの処理
    isProcessing = false;
    notifyListeners();
  }

  // viewModel内で完結するビジネスロジック
  // 表示用に加工するメソッド 例えば位置情報から位置情報のテキストを返している.
  String _convertToLocationString(Location? location) {
    if (location == null) return "";
    final locationString = location.country + " " + location.state + " " + location.city;
    return locationString;
  }

  // Modelで位置情報を更新 -> 更新後にViewに通知する.
  Future<void> updateLocation(double latitude, double longitude) async {
    location = await postRepository.updateLocation(latitude, longitude);
    notifyListeners();
  }

  Future<void> post() async {
    isProcessing = true; // 状態を持ち
    notifyListeners(); // Viewに通知
    // Modelで何かしらの処理
    // Repository からサーバーにPOSTメソッドを実行する、など。
    await postRepository.post(
        UserRepository.currentUser!,
        File("hoge/hoge"),
        "huge",
        location,
        "test"
    );
    isProcessing = false; // 状態を変更し
    notifyListeners(); // Viewに通知
  }
}