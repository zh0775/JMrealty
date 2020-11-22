import 'package:flutter/cupertino.dart';

enum BaseState {
  LOADING,
  EMPTY,
  CONTENT,
  FAIL,
}

class BaseViewModel extends ChangeNotifier {
  BaseState state;
}
