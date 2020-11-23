import 'package:JMrealty/components/TreeNode.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:flutter/material.dart';

class TreeSelectView extends StatefulWidget {
  final List<TreeNode> treeData;
  final Size size;
  final needSelected;
  TreeSelectView({this.treeData = const [],
    this.size = const Size(double.infinity,double.infinity),
    this.needSelected = false});
  @override
  _TreeSelectViewState createState() => _TreeSelectViewState();
}

class _TreeSelectViewState extends State<TreeSelectView> {
  @override
  Widget build(BuildContext context) {
    print('treeData === ${widget.treeData}');
    SizeConfig().init(context);
    return Align(
      child: Container(
        width: widget.size.width,
        height: widget.size.height,
        color: Colors.white,
        child: Stack(
          children: [
            Positioned(
              left: 10,
                right: 10,
                top: 10,
                bottom: 60,
                child: Container(

                )),
            Positioned(
                bottom: 0,
                left: (widget.size.width - 90) / 2,
                child: TextButton(onPressed: (){
                  Navigator.of(context).pop();
                },
                child: Container(
              height: 40,
              width: 90,
              color: Color(0xff404351),
              child: Center(child: Text('确定',style: TextStyle(fontSize: 15,color: Colors.white),)),
            ),))
          ],
        ),
      ),
    );
  }

  Widget node (BuildContext context, TreeNode nodeData) {
    return Container();
  }
}
