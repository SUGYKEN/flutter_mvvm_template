// modelでは、アプリ外部（HardWare、バックエンド、他のアプリなど）との連携部分を担います
// この例は、バックエンドのdbと連携する部分。
// 今後データベースがFirebase以外に変わっても使えるようにModel層のなかで連携部分は完結させます。
// 一部のメソッドを例に残しています。FirebaseFireStoreと連携させていました。

import 'package:mvvm_provider_template/data_model/post.dart';
import 'package:mvvm_provider_template/data_model/user.dart';
import 'package:mvvm_provider_template/models/repository/user_repository.dart';

class DataBaseManager {

  final _db = null; // db 接続のためのインスタンス生成

  // db内部のuserをクエリしてユーザーが作成済を判断
  Future<bool> searchUserInDb(AuthUser user) async {
    final query = await _db.collection("users")
        .where("userId", isEqualTo: user.uid)
        .get();
    if (query.docs.length > 0) { return true; }
    return false;
  }

  // get User
  Future<User> getUserInfoFromDbById(String uid) async {
    final query = await _db.collection("users").where("userId", isEqualTo: uid).get();
    return User.fromMap(query.docs[0].data());
  }

  Future<void> insertPost(Post post) async {
    await _db.collection("posts").doc(post.postId).set(post.toMap());
  }

  Future<void> insertUser(User user) async {
    await _db.collection("users").doc(user.userId).set(user.toMap());
  }
}