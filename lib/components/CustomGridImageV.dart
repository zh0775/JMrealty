import 'package:JMrealty/Report/viewmodel/ReportUploadViewModel.dart';
import 'package:JMrealty/base/image_loader.dart';
import 'package:JMrealty/components/SelectImageView.dart';
import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:flutter/material.dart';

class CustomGridImageV extends StatelessWidget {
  final List<String> imageUrls;
  final bool needButton;
  final double width;
  final int count;
  final Function(List<String> images) addImages;

  const CustomGridImageV(
      {this.imageUrls = const [],
      this.needButton = false,
      this.count = 3,
      this.width,
      this.addImages});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double widthScale = SizeConfig.blockSizeHorizontal;
    double imgHeight = widthScale * 26;
    double imgWidth = widthScale * 26;
    double heightSpace = 10;
    double selfHeight =
        (((imageUrls == null ? 0 : imageUrls.length) + (needButton ? 1 : 0)) /
                    count)
                .ceil() *
            (imgHeight + heightSpace);
    double margin =
        width != null ? (SizeConfig.screenWidth - width) / 2 : widthScale * 5;
    double selfWidth = width ?? SizeConfig.screenWidth - margin * 2;
    return UnconstrainedBox(
      child: Container(
        color: Colors.transparent,
        constraints: BoxConstraints(maxWidth: width, maxHeight: selfHeight),
        child: Stack(
          children: [
            ...getImgVs(selfWidth, imgWidth, imgHeight, heightSpace, context)
          ],
        ),
      ),
    );
  }

  List<Widget> getImgVs(double selfWidth, double imgWidth, double imgHeight,
      double heightSpace, BuildContext context) {
    double x = 0;
    double y = 0;
    double xOffset = (selfWidth - imgWidth * 3) / 2 + imgWidth;
    double yOffset = imgHeight + heightSpace;
    List<Widget> imgs = [];
    if (imageUrls != null) {
      int count = imageUrls.length;
      if (needButton) {
        count++;
      }
      for (var i = 0; i < count; i++) {
        if (needButton && i == count - 1) {
          imgs.add(Positioned(
            left: x,
            top: y,
            width: imgWidth,
            height: imgHeight,
            child: GestureDetector(
                onTap: () {
                  SelectImageView(
                    count: 9,
                    imageSelected: (images) {
                      if (images != null) {
                        ReportUploadViewModel().upLoadReportImages(images,
                            callBack: () {
                          if (addImages != null) {
                            addImages(images);
                          }
                        });
                      }
                    },
                  ).showImage(context);
                },
                child: Container(
                  color: jm_line_color,
                  child: Center(
                    child: Icon(
                      Icons.add_circle_outline,
                      size: 30,
                      color: Colors.black,
                    ),
                  ),
                )),
          ));
        } else {
          String element = imageUrls[i];
          imgs.add(Positioned(
            left: x,
            top: y,
            width: imgWidth,
            height: imgHeight,
            child: GestureDetector(
                onTap: () {
                  selectImage(element, i);
                },
                child: ImageLoader(element, imgHeight)),
          ));
        }
        if ((i + 1) % 3 == 0) {
          y += yOffset;
          x = 0;
        } else {
          x += xOffset;
        }
      }
    }
    return imgs;
  }

  void selectImage(String imageUrl, int index) {
    print('imageUrl === $imageUrl ----- index === $index');
  }
}
