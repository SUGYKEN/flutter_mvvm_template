// modelでは、アプリ外部（HardWare、バックエンド、他のアプリなど）との連携部分を担います
// この例は、ログインのためサーバー接続を行うケースです。また、アカウント作成済の判断のため別のModelに依存しているクラスです。
// APIの実行結果はそのまま使わずに、自分で定義したdata_modelに変換します。
// data_modelへの変換までがModel層の責務としています。

// data_modelへの変換には他のModel層の情報を必要とする場合があります。その場合はクラスの内部で定義したプロパティに外部からインスタンスを注入します！
// 外部から注入することでdummyのModelを注入することも可能になります（テストコード）。

import 'package:mvvm_provider_template/data_model/user.dart';
import 'package:mvvm_provider_template/models/db/database_manager.dart';

class UserRepository {
  final DataBaseManager dbManager;
  UserRepository({required this.dbManager});

  // save on memory static
  static User? currentUser;

  // sign in status
  Future<bool> isSignIn() async {
    // APIを実行してログイン情報を取得する
    return dummy_isSignIn();
  }

  // sign in method
  Future<bool> signIn() async {
    try {
      // APIを実行してログインを実行する
      AuthUser? authUser = await dummy_signIn();
      if (authUser == null) { return false; }
      // search DB(if none insert)
      final isUserExist = await dbManager.searchUserInDb(authUser);
      if (!isUserExist) await dbManager.insertUser(_convertToUser(authUser));
      return true;
    } catch (error) {
      print("Error is (error)");
    }
    return false;
  }

  // data model に従ってオブジェクト生成して、managerに渡す
  _convertToUser(AuthUser authUser) {
    return User(
        userId: authUser.uid ?? "",
        displayName: authUser.displayName ?? "",
        inAppUserName: authUser.displayName ?? "",
        photoUrl: authUser.photoURL ?? "",
        email: authUser.email ?? "",
        bio: "");
  }

  // dummyAPI
  static bool dummy_isSignIn() {
    return true;
  }

  // dummyAPI
  static Future<AuthUser?> dummy_signIn() async {
    if (currentUser == null) { throw Error(); }
    return dummyAuthUser;
  }
}

// dummyClass
// ダミークラスです。連携先に依存した情報です。
// 実際に使う時には消すこと。TODO
class AuthUser {
  AuthUser(this.uid, this.displayName, this.photoURL, this.email);
  final String? uid;
  final String? displayName;
  final String? photoURL;
  final String? email;
}
final AuthUser dummyAuthUser = AuthUser("uid", "dummyDisplayName", "photoURL", "email");