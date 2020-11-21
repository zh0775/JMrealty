import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProviderWidget<T extends ChangeNotifier> extends StatefulWidget {
  final Widget Function(BuildContext context, T value, Widget child) builder;
  final T model;
  final Widget child;
  final Function(T) onReady;

  ProviderWidget({this.model, this.builder, this.child, this.onReady});

  @override
  _ProviderWidgetState createState() => _ProviderWidgetState();
}

class _ProviderWidgetState<T extends ChangeNotifier>
    extends State<ProviderWidget> {
  @override
  void initState() {
    super.initState();
    if (widget.onReady != null) {
      widget.onReady(widget.model);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => widget.model,
      child: Consumer<T>(
        builder: widget.builder,
        child: widget.child,
      ),
    );
  }
}
