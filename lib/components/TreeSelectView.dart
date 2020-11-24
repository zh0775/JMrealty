import 'package:JMrealty/components/TreeNode.dart';
import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class TreeSelectView extends StatefulWidget {
  final List<TreeNode> treeData;
  final Size size;
  final needSelected;
  final bool singleSelect;
  final void Function(TreeNode node) nodeSelected;
  final void Function(List<TreeNode> nodes) nodesSelected;
  TreeSelectView(
      {this.treeData = const [],
      this.size = const Size(double.infinity, double.infinity),
      this.needSelected = false,
      this.singleSelect = true,
      this.nodeSelected,
      this.nodesSelected});
  @override
  _TreeSelectViewState createState() => _TreeSelectViewState();
}

class _TreeSelectViewState extends State<TreeSelectView> {
  double selfWidth;
  List<TreeNode> seletedNodes;
  @override
  void dispose() {
    seletedNodes.forEach((element) {
      element.selected = false;
    });
    seletedNodes = null;
    super.dispose();
  }

  @override
  void initState() {
    seletedNodes = [];
    selfWidth = widget.size.width - 20;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Align(
      child: Container(
        width: widget.size.width,
        height: widget.size.height,
        color: Colors.white,
        child: Stack(
          children: [
            Positioned(
                left: (widget.size.width - selfWidth) / 2,
                width: selfWidth,
                top: 10,
                bottom: 60,
                child: getNodes(context)),
            Positioned(
                bottom: 0,
                left: (widget.size.width - 90) / 2,
                child: TextButton(
                  onPressed: () {
                    if (widget.singleSelect) {
                      if (widget.nodeSelected != null &&
                          seletedNodes.length > 0) {
                        widget.nodeSelected(seletedNodes[0]);
                      }
                    } else {
                      if (widget.nodesSelected != null &&
                          seletedNodes.length > 0) {
                        widget.nodesSelected(seletedNodes);
                      }
                    }
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    height: 40,
                    width: 90,
                    color: Color(0xff404351),
                    child: Center(
                        child: Text(
                      '确定',
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    )),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  Widget getNodes(BuildContext context) {
    if (widget.treeData.length == 0) return Container();
    List<Widget> nodes = [];
    widget.treeData.forEach((e0) {
      nodes.add(getOneNode(e0));
      if (e0.children != null && e0.children.length > 0 && e0.expand == true) {
        e0.children.forEach((e1) {
          nodes.add(getOneNode(e1));
          if (e1.children != null &&
              e1.children.length > 0 &&
              e1.expand == true) {
            e1.children.forEach((e2) {
              nodes.add(getOneNode(e2));
              if (e2.children != null &&
                  e2.children.length > 0 &&
                  e2.expand == true) {
                e2.children.forEach((e3) {
                  nodes.add(getOneNode(e3));
                  if (e3.children != null &&
                      e3.children.length > 0 &&
                      e3.expand == true) {
                    e3.children.forEach((e4) {
                      nodes.add(getOneNode(e4));
                      if (e4.children != null &&
                          e4.children.length > 0 &&
                          e4.expand == true) {
                        e4.children.forEach((e5) {
                          nodes.add(getOneNode(e5));
                          if (e5.children != null &&
                              e5.children.length > 0 &&
                              e5.expand == true) {
                            e5.children.forEach((e6) {
                              nodes.add(getOneNode(e6));
                              if (e6.children != null &&
                                  e6.children.length > 0 &&
                                  e6.expand == true) {
                                e6.children.forEach((e7) {
                                  nodes.add(getOneNode(e7));
                                  if (e7.children != null &&
                                      e7.children.length > 0 &&
                                      e7.expand == true) {
                                    e7.children.forEach((e8) {
                                      nodes.add(getOneNode(e8));
                                      if (e8.children != null &&
                                          e8.children.length > 0 &&
                                          e8.expand == true) {
                                        e8.children.forEach((e9) {
                                          nodes.add(getOneNode(e9));
                                        });
                                      }
                                    });
                                  }
                                });
                              }
                            });
                          }
                        });
                      }
                    });
                  }
                });
              }
            });
          }
        });
      }
    });
    // print('nodes.length === ${nodes.length}');
    return ListView(
      children: nodes,
    );
  }

  Widget getOneNode(TreeNode node) {
    double blockWidth = selfWidth / 100;
    double levelSpace = blockWidth * 3;
    Size imageSize = Size(blockWidth * 10, blockWidth * 10);
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
        width: selfWidth,
        height: 55,
        color: Colors.white,
        child: Row(
          children: [
            SizedBox(
              width: levelSpace * node.treeLevel,
            ),
            image,
            Text(
              node.label,
              style: textStyle,
            )
          ],
        ),
      ),
    );
  }

  void treeNodeSelected() {}
}
