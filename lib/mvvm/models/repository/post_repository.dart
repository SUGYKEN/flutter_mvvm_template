// modelでは、アプリ外部（HardWare、バックエンド、他のアプリなど）との連携部分を担います
// この例は、dbManagerを経由してサーバー接続を行うケースです。また、別のModelに依存しているクラスです。
// APIの実行結果はそのまま使わずに、自分で定義したdata_modelに変換します。
// data_modelへの変換までがModel層の責務としています。

// data_modelへの変換には他のModel層の情報を必要とする場合があります。その場合はクラスの内部で定義したプロパティに外部からインスタンスを注入します！
// 外部から注入することでdummyのModelを注入することも可能になります（テストコード）。

import 'dart:io';

import 'package:mvvm_provider_template/mvvm/data_model/location.dart';
import 'package:mvvm_provider_template/mvvm/data_model/post.dart';
import 'package:mvvm_provider_template/mvvm/data_model/user.dart';
import 'package:mvvm_provider_template/mvvm/models/db/database_manager.dart';
import 'package:mvvm_provider_template/mvvm/models/location/location_manager.dart';

class PostRepository {

  final DataBaseManager dbManager;
  final LocationManager locationManager;

  PostRepository({required this.dbManager, required this.locationManager});

  // get Current Location Information
  Future<Location> getCurrentLocation() async {
    return await locationManager.getCurrentLocation();
  }

  Future<Location> updateLocation(double latitude, double longitude) async {
    return await locationManager.updateLocation(latitude, longitude);
  }

  Future<void> post(User currentUser, File imageFile, String caption, Location? location, String locationString) async {
    // data model に従ってオブジェクト生成して、managerに渡す
    final post = Post(
        postId: "1234dfdfe",
        userId: currentUser.userId,
        imageUrl: "huga/huga/huga",
        imageStoragePath: "hoge/hoge/hoge",
        caption: caption, locationString: locationString,
        latitude: (location != null) ? location.latitude : 0.0 ,
        longitude: (location != null) ? location.longitude : 0.0 ,
        postDateTime: DateTime.now());
    await dbManager.insertPost(post); // dbManagerのinsertPost
  }
}