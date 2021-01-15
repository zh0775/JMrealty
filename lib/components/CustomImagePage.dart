import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:photo_view/photo_view.dart';

class CustomImagePage extends StatefulWidget {
  final int index;
  final int count;
  final List imageList;
  const CustomImagePage(
      {this.index = 0, this.count, this.imageList = const []});
  @override
  _CustomImagePageState createState() => _CustomImagePageState();
}

class _CustomImagePageState extends State<CustomImagePage> {
  int currentIndex = 0;
  @override
  void initState() {
    currentIndex = widget.index;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
        width: SizeConfig.screenWidth,
        height: double.infinity,
        color: Colors.black,
        child: Stack(
          children: [
            PageView(
              controller: PageController(initialPage: widget.index),
              children: [
                ...getImageWidget(),
              ],
              onPageChanged: (value) {
                if (mounted) {
                  setState(() {
                    currentIndex = value;
                  });
                }
              },
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 50.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  '${currentIndex + 1} / ${widget.count}',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            )
          ],
        ));
  }

  List<Widget> getImageWidget() {
    List<Widget> list = [];
    for (var i = 0; i < widget.imageList.length; i++) {
      dynamic e = widget.imageList[i];
      list.add(GestureDetector(
        onTap: () => Navigator.pop(context),
        child: PhotoView(
            imageProvider: AssetThumbImageProvider(e,
                // scale: SizeConfig.screenWidth / e.originalWidth,
                width: SizeConfig.screenWidth.round(),
                height: (e.originalHeight /
                        e.originalWidth *
                        SizeConfig.screenWidth)
                    .round())),
      ));
    }
    return list;
  }
}
