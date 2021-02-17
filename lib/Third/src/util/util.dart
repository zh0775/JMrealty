import 'package:flutter/material.dart';

export 'extensions.dart';
export 'handler.dart';

// ignore_for_file: public_member_api_docs

double interval(double begin, double end, double t,
    {Curve curve = Curves.linear}) {
  assert(t != null);

  if (t < begin) return 0.0;
  if (t > end) return 1.0;

  final v = ((t - begin) / (end - begin)).clamp(0.0, 1.0);
  return curve?.transform(v) ?? v;
}

void postFrame(VoidCallback callback) {
  assert(callback != null);
  WidgetsBinding.instance.addPostFrameCallback((_) => callback());
}
