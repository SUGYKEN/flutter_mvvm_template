import 'package:flutter/material.dart';
import 'package:mvvm_provider_template/constants.dart';
import 'package:mvvm_provider_template/mvvm/view/common/common_dialog.dart';
import 'package:mvvm_provider_template/mvvm/view_models/post_view_model.dart';
import 'package:provider/provider.dart';

class PostUploadScreen extends StatelessWidget {
  final UploadType uploadType;

  const PostUploadScreen({Key? key, required this.uploadType}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // viewModelに非同期で連携、写真アプリ/カメラを起動する
    Future(() {
      final postViewModel = context.read<PostViewModel>();
      if (!postViewModel.isProcessing) {
        postViewModel.pickImage(uploadType);
      }
    });

    return Consumer<PostViewModel>(
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            leading: model.isProcessing
                ? Container()
                : IconButton(
                    icon: const Icon(Icons.arrow_back), // MaterialIconを使う場合
                    onPressed: () => _cancelPost(context),
                  ),
            title: model.isProcessing
                ? const Text("処理中")
                : const Text("投稿する"),
            actions: <Widget>[
              (model.isProcessing)
                  ? IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => _cancelPost(context),
                    )
                  : IconButton(
                      icon: const Icon(Icons.done),
                      onPressed: () => showConfirmDialog(
                        context: context,
                        title: "TITLE",
                        content: "CONFIRM",
                        onConfirmed: (isConfirmed){
                          if (isConfirmed){
                            _post(context);
                          }
                        },
                      ),
                    )
            ],
          ),
          body: model.isProcessing
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : const SingleChildScrollView( // もしスクロールが必要になるのであれば。
                  child: Center(child: Text("Processing Done(ここで画像を受け取って何かをする)"))
              )
        );
      },
    );
  }

  _cancelPost(BuildContext context) {
    final postViewModel = Provider.of<PostViewModel>(context, listen: false);
    // postViewModel.cancelPost();
    Navigator.pop(context);
  }

  void _post(BuildContext context) async{
    // viewModelに処理
    final postViewModel = Provider.of<PostViewModel>(context, listen: false);
    await postViewModel.post();
    Navigator.pop(context);
  }
}
