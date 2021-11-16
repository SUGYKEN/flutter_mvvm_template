# mvvm_provider_template

 MVVM + CleanArchitecture + Provider
 
 とてもSimpleな画面になっています。
 - (仮想)ログイン画面
 - タブありのホーム画面
 - カメラの起動/写真アプリの起動画面
　
 viewModelからの通知・依頼・状態の取得、などが参考にできると思います！！
![mvvm_temp](https://user-images.githubusercontent.com/77915965/142031019-f21cc36f-e91f-4048-8874-14c846085124.gif)


## Architecture

 状態管理はViewModel、API通信などはModel層、に分けています。
 
 Providerを使うことで簡単にViewとViewModelが連携できています。

<img width="982" alt="スクリーンショット 2021-11-11 23 53 38" src="https://user-images.githubusercontent.com/77915965/141318947-9b6b40d1-509d-4c10-9699-9d6126cd9194.png">

## MVVM

 [Sample Provider](https://flutter.dev/docs/development/data-and-backend/state-mgmt/simple)
 
 [Sample Provider Github](https://github.com/flutter/samples/tree/master/provider_shopper/lib)

## Bloc(memo)
[Bloc Sample](https://bloclibrary.dev/#/flutterlogintutorial)
