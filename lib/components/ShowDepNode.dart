import 'package:JMrealty/const/Default.dart';
import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:flutter/material.dart';

import 'TreeNode.dart';
import 'TreeSelectView.dart';

class ShowDepNode {
  final List<TreeNode> treeData;
  final void Function(TreeNode node) nodeSelected;
  final void Function(List<TreeNode> nodes) nodesSelected;
  final Size size;
  ShowDepNode(
      {@required this.treeData,
      this.nodesSelected,
      this.nodeSelected,
      @required this.size});
  show() {
    showGeneralDialog(
        context: Global.navigatorKey.currentContext,
        barrierDismissible: true,
        barrierLabel: '',
        transitionDuration: Duration(milliseconds: 200),
        barrierColor: Colors.black.withOpacity(.5),
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return TreeSelectView(
            // size: Size(SizeConfig.blockSizeHorizontal * 80,
            //     SizeConfig.blockSizeVertical * 80),
            size: size,
            treeData: treeData,
            nodeSelected: (node) {
              if (nodeSelected != null) {
                nodeSelected(node);
              }
              // setState(() {
              //   callBackData = {'value': node.id, 'title': node.label};
              // });
            },
            nodesSelected: (nodes) {
              if (nodesSelected != null) {
                nodesSelected(nodes);
              }
            },
          );
        });
  }
}
