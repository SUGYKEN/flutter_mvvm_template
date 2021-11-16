import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mvvm_provider_template/constants.dart';
import 'package:mvvm_provider_template/mvvm/view/common/button_with_icon.dart';
import 'package:mvvm_provider_template/mvvm/view/post/screens/post_upload_screen.dart';

class PostPage extends StatelessWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 90.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ButtonWithIcon(
                iconData: FontAwesomeIcons.images,
                label: "Gallery",
                onPressed: () => _openPostUploadScreen(
                  UploadType.GALLERY,
                  context,
                ),
              ),
              const SizedBox(
                height: 24.0,
              ),
              ButtonWithIcon(
                iconData: FontAwesomeIcons.camera,
                label: "Camera",
                onPressed: () => _openPostUploadScreen(
                  UploadType.CAMERA,
                  context,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _openPostUploadScreen(UploadType uploadType, BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PostUploadScreen(uploadType: uploadType),
      ),
    );
  }
}
