import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SelectImageView {
  void Function(dynamic image) imageSelected;
  final _picker = ImagePicker();
  SelectImageView({@required this.imageSelected});
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
                  _getImageFromCamera();
                }),
                getButton('从相册选择', () {
                  _getImageFromGallery();
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

  //拍照
  Future _getImageFromCamera() async {
    var image =
        await _picker.getImage(source: ImageSource.camera, maxWidth: 400);
    imageSelected(image);
  }

  //相册选择
  Future _getImageFromGallery() async {
    var image = await _picker.getImage(source: ImageSource.gallery);

    imageSelected(image);
  }
}
