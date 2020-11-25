import 'package:flutter/cupertino.dart';

enum BaseState {
  LOADING,
  EMPTY,
  CONTENT,
  FAIL,
}

class BaseViewModel extends ChangeNotifier {
  bool _disposed = false;
  BaseState state;

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }
}
