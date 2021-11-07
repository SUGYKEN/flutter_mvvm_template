import 'package:mvvm_provider_template/models/db/database_manager.dart';
import 'package:mvvm_provider_template/models/location/location_manager.dart';
import 'package:mvvm_provider_template/models/repository/post_repository.dart';
import 'package:mvvm_provider_template/models/repository/user_repository.dart';
import 'package:mvvm_provider_template/view_models/login_view_model.dart';
import 'package:mvvm_provider_template/view_models/post_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';


// ProviderもSingleChildWidget（元はinheritedWidget→SingleChildStatelessWidgetなので）
List<SingleChildWidget> globalProviders = [
  ...independentModels,
  ...dependentModels,
  ...viewModels
];

// 独立しているもの（CleanArchitecture上依存がない）
List<SingleChildWidget> independentModels = [
  Provider<DataBaseManager>(
      create: (_) => DataBaseManager()
  ),
  Provider<LocationManager>(
      create: (_) => LocationManager()
  ),
];

// 依存しているもの（Model）
List<SingleChildWidget> dependentModels = [
  // 別のインスタンスができてから生成する
  ProxyProvider<DataBaseManager,UserRepository>(
      update: (_, dbManager, repo) => UserRepository(dbManager: dbManager)
  ),
  // 2つのインスタンスに依存する
  ProxyProvider2<DataBaseManager,LocationManager,PostRepository>(
      update: (_, dbManager, locationManager, repo)
      => PostRepository(dbManager: dbManager, locationManager: locationManager)
  ),
];

// 依存しているもの（ViewModel）
List<SingleChildWidget> viewModels = [
  ChangeNotifierProvider<LoginViewModel>(
      create: (context) => LoginViewModel(
          userRepository: context.read<UserRepository>()
      )
  ),
  ChangeNotifierProvider<PostViewModel>(
    create: (context) => PostViewModel(
        userRepository: context.read<UserRepository>(),
        postRepository: context.read<PostRepository>()
    ),
  ),
];