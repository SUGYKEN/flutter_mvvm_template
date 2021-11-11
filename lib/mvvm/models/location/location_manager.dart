// modelでは、アプリ外部（HardWare、バックエンド、他のアプリなど）との連携部分を担います
// この例は、アプリの位置情報と連携する部分。
// APIの実行結果はそのまま使わずに、自分で定義したdata_modelに変換します。
// data_modelへの変換までがModel層の責務としています。

import 'package:mvvm_provider_template/mvvm/data_model/location.dart';
class LocationManager {

  // 現在地を取得
  Future<Location> getCurrentLocation() async {
    // APIを実行
    final position = dummy_getCurrentPosition();
    // 実行結果は、そのまま返さずconvertします。
    return Future.value(convertToLocation(position.latitude, position.longitude));
  }

  // 独自modelに変換
  Location convertToLocation(double latitude, double longitude) {
    return Location(
        latitude: latitude,
        longitude: longitude,
        country: "",
        state: "",
        city: ""
    );
  }

  // 位置情報を更新
  Future<Location> updateLocation(double latitude, double longitude) async {
    final position = dummy_updateLocation();
    return Future.value(convertToLocation(position.latitude, position.longitude));
  }

  // dummyAPI
  static Position dummy_getCurrentPosition() {
    return Position(0.00, 0.00);
  }
  // dummyAPI
  static Position dummy_updateLocation() {
    return Position(0.00, 0.00);
  }
}

// dummyClass
// ダミークラスです。連携先に依存した情報です。
// 実際に使う時には消すこと。TODO
class Position {
  Position(this.latitude, this.longitude);
  final double latitude;
  final double longitude;
}
