import 'package:JMrealty/components/CustomAppBar.dart';
import 'package:JMrealty/components/TreeNode.dart';
import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class DepSelectView extends StatefulWidget {
  final List<TreeNode> treeData;
  final bool singleSelect;
  final void Function(TreeNode node) nodeSelected;
  final void Function(List<TreeNode> nodes) nodesSelected;
  const DepSelectView(
      {Key key,
      @required this.treeData,
      this.singleSelect = true,
      this.nodeSelected,
      this.nodesSelected})
      : super(key: key);
  @override
  _DepSelectViewState createState() => _DepSelectViewState();
}

class _DepSelectViewState extends State<DepSelectView> {
  List<TreeNode> seletedNodes = [];
  List<Widget> nodes = [];
  double selfWidth;
  double widthScale;
  double margin;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    seletedNodes.forEach((element) {
      element.selected = false;
    });
    seletedNodes = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    widthScale = SizeConfig.blockSizeHorizontal;
    margin = widthScale * 4;
    selfWidth = SizeConfig.screenWidth - margin * 2;
    return Scaffold(
      appBar: CustomAppbar(
        flexibleSpace: null,
        title: '选择部门',
        backClick: () {
          if (widget.nodesSelected != null) {
            widget.nodesSelected(seletedNodes);
          }
          if (widget.nodeSelected != null &&
              seletedNodes != null &&
              seletedNodes.length > 0) {
            widget.nodeSelected(seletedNodes[0]);
          }
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            ...treeNodes()
          ],
        ),
      ),
    );
  }

  List<Widget> treeNodes() {
    nodes = [];
    formatNodes(widget.treeData);
    return nodes;
  }

  void formatNodes(List<TreeNode> data) {
    if (data == null || data.length == 0) return;
    for (var i = 0; i < data.length; i++) {
      TreeNode n = data[i];
      nodes.add(getOneNode(n));
      if (n.children != null && n.children.length > 0 && n.expand) {
        formatNodes(n.children);
      }
    }
  }

  Widget getOneNode(TreeNode node) {
    double blockWidth = selfWidth / 100;
    double levelSpace = blockWidth * 6;
    Size imageSize = Size(blockWidth * 6, blockWidth * 6);
    Widget image;
    TextStyle textStyle;
    if (node.children != null && node.children.length > 0) {
      if (node.expand) {
        image = GestureDetector(
            onTap: () {
              setState(() {
                node.expand = !node.expand;
              });
            },
            child: Transform.rotate(
              angle: math.pi / 2,
              child: Image.asset('assets/images/arrow_right.png',
                  width: imageSize.width, height: imageSize.height),
            ));
      } else {
        image = GestureDetector(
          onTap: () {
            setState(() {
              node.expand = !node.expand;
            });
          },
          child: Image.asset(
            'assets/images/arrow_right.png',
            width: imageSize.width,
            height: imageSize.height,
          ),
        );
      }
    } else {
      image = SizedBox(width: imageSize.width, height: imageSize.height);
    }
    if (node.selected) {
      textStyle = TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: jm_appTheme,
        decoration: TextDecoration.none,
      );
    } else {
      textStyle = TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 15,
        color: Color(0xff333333),
        decoration: TextDecoration.none,
      );
    }

    return GestureDetector(
      onTap: () {
        node.selected = !node.selected;
        if (node.selected) {
          if (widget.singleSelect) {
            seletedNodes.forEach((element) {
              element.selected = false;
            });
            seletedNodes = [];
          }
          seletedNodes.add(node);
        } else {
          seletedNodes.remove(node);
        }
        setState(() {});
      },
      child: Container(
        width: SizeConfig.screenWidth,
        height: 40,
        color: Colors.white,
        child: Row(
          children: [
            SizedBox(
              width: levelSpace * node.treeLevel + widthScale * 2,
            ),
            image,
            Checkbox(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                value: node.selected,
                checkColor: Colors.white,
                activeColor: jm_appTheme,
                tristate: true,
                onChanged: (bool) {
                  node.selected = !node.selected;
                  if (node.selected) {
                    if (widget.singleSelect) {
                      seletedNodes.forEach((element) {
                        element.selected = false;
                      });
                      seletedNodes = [];
                    }
                    seletedNodes.add(node);
                  } else {
                    seletedNodes.remove(node);
                  }
                  setState(() {});
                }),
            Text(
              node.label,
              style: textStyle,
            )
          ],
        ),
      ),
    );
  }
}
