import 'package:JMrealty/Report/viewmodel/ReportUploadViewModel.dart';
import 'package:JMrealty/base/image_loader.dart';
import 'package:JMrealty/components/CustomAlert.dart';
import 'package:JMrealty/components/SelectImageView.dart';
import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:JMrealty/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class CustomGridImageV extends StatelessWidget {
  final int imageCount;
  final List<String> imageUrls;
  final List imageAssets;
  final bool needButton;
  final double width;
  final int count;
  final Function(List images) addImages;
  final Function(dynamic images) deleteImage;
  final Function(int index) imageClick;

  const CustomGridImageV(
      {this.imageUrls = const [],
      this.imageAssets = const [],
      this.needButton = false,
      this.imageClick,
      this.count = 3,
      this.imageCount = 15,
      this.width,
      this.addImages,
      this.deleteImage});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double widthScale = SizeConfig.blockSizeHorizontal;
    double imgHeight = widthScale * 26;
    double imgWidth = widthScale * 26;
    double heightSpace = 10;
    List l = needButton ? imageAssets : imageUrls;
    double selfHeight =
        (((l == null ? 0 : l.length) + (needButton ? 1 : 0)) / count).ceil() *
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
        count = imageAssets.length;
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
                  if (imageAssets.length >= imageCount) {
                    ShowToast.normal('最多上传$imageCount张照片，长按照片可删除');
                    return;
                  }
                  SelectImageView(
                    count: 9,
                    imageSelected: (images) {
                      if (images != null) {
                        if (addImages != null) {
                          if ((imageAssets.length + images.length) >=
                              imageCount) {
                            ShowToast.normal('最多上传$imageCount张照片，长按照片可删除');
                          }
                          addImages(images);
                        }

                        // ReportUploadViewModel().upLoadReportImages(images,
                        //     callBack: (List strImages) {
                        //   if (addImages != null) {
                        //     addImages(strImages);
                        //   }
                        // });
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
          dynamic element = needButton ? imageAssets[i] : imageUrls[i];
          imgs.add(Positioned(
            left: x,
            top: y,
            width: imgWidth,
            height: imgHeight,
            child: GestureDetector(
                onTap: () {
                  if (imageClick != null) {
                    imageClick(i);
                  }
                },
                onLongPress: () {
                  CustomAlert(content: '是否确认删除该照片').show(
                    confirmClick: () {
                      if (deleteImage != null) {
                        deleteImage(element);
                      }
                    },
                  );
                },
                child: needButton
                    ? Image(
                        image: AssetThumbImageProvider(element,
                            height: imgHeight.round(), width: imgWidth.round()))
                    : ImageLoader(
                        element,
                        height: imgHeight,
                      )),
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
}
