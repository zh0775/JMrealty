class TreeNode {
  int id;
  String label;
  // Map<String, dynamic> data;
  bool expand;
  bool selected;
  int treeLevel;
  List<TreeNode> children;

  TreeNode({this.label,this.children,this.expand,this.selected,this.treeLevel,this.id});
}