import 'package:flutter/material.dart';

mixin RouteResultMixin<T> on Route<T> {
  T? _popResult;

  T? get result => _popResult;

  String? get pageName => null;

  @override
  void onPopInvokedWithResult(bool didPop, T? result) {
    if (didPop) {
      _popResult ??= result;
    }
    super.onPopInvokedWithResult(didPop, result);
  }
}
