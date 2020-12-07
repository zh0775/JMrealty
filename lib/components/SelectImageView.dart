// import 'dart:io';

import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class SelectImageView {
  void Function(List<dynamic> images) imageSelected;
  // final _picker = ImagePicker();
  final int count;
  SelectImageView({@required this.imageSelected, this.count = 1});
  double selfHeight = 200.0;
  void showImage(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext ctx) {
          return Container(
            height: selfHeight,
            child: Column(
              children: [
                getButton('拍照', () {
                  loadAssets(true);
                  Navigator.pop(context);
                  // _getImageFromCamera(ctx);
                }),
                getButton('从相册选择', () {
                  loadAssets(false);
                  Navigator.pop(context);
                  // _getImageFromGallery(ctx);
                }),
                getButton('取消', () {
                  Navigator.pop(context);
                }),
              ],
            ),
          );
        });
  }

  Widget getButton(String title, void Function() pressed) {
    return Container(
      height: selfHeight / 3,
      width: double.infinity,
      child: TextButton(
        onPressed: pressed,
        child: Center(
          child: Text(
            title,
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
        ),
      ),
    );
  }

  // //拍照
  // Future _getImageFromCamera(BuildContext context) async {
  //   final pickedFile = await _picker.getImage(source: ImageSource.camera);

  //   if (pickedFile != null) {
  //     imageSelected(File(pickedFile.path));
  //     Navigator.pop(context);
  //   }
  // }

  // //相册选择
  // Future _getImageFromGallery(BuildContext context) async {
  //   final pickedFile = await _picker.getImage(source: ImageSource.gallery);
  //   if (pickedFile != null) {
  //     imageSelected(File(pickedFile.path));
  //     Navigator.pop(context);
  //   }
  // }

  //
  Future<void> loadAssets(bool isCamera) async {
    List<Asset> resultList;
    // String error;
    resultList = await MultiImagePicker.pickImages(
      maxImages: count,
      enableCamera: isCamera,
    );
    if (resultList != null) {
      imageSelected(resultList);
    }
    // try {
    //   resultList = await MultiImagePicker.pickImages(
    //     maxImages: 300,
    //   );
    // } on Exception catch (e) {
    //   error = e.toString();
    // }
    // print('resultList == $resultList');

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    // if (!mounted) return;

    // setState(() {
    //   images = resultList;
    //   _error = error;
    // });
  }
}
