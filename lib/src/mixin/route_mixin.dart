import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:meta/meta.dart';

import '../route_register_impl.dart';

@internal
mixin RouteMixin {
  GoRouter get router {
    return RouteRegisterImpl.instance.goRouter;
  }

  GlobalKey<NavigatorState> get navigatorKey =>
      RouteRegisterImpl.instance.navigatorKey;

  BuildContext? get navContext =>
      RouteRegisterImpl.instance.navigatorKey.currentContext;

  List<GoRoute> get routeStack => RouteRegisterImpl.instance.routeStack;

  List<String> get pathStack => RouteRegisterImpl.instance.pathStack;

  String get currentPath => RouteRegisterImpl.instance.currentRoutePath;

  bool containPathInStack(String? path) {
    return RouteRegisterImpl.instance.containPathInStack(path);
  }

  void addListener(VoidCallback listener) {
    RouteRegisterImpl.instance.delegate.addListener(listener);
  }

  void removeListener(VoidCallback listener) {
    RouteRegisterImpl.instance.delegate.removeListener(listener);
  }

  void go(String location, {Map<String, dynamic>? arguments}) =>
      router.go(location, extra: arguments);

  Future<Map<String, dynamic>?> push<T extends Object?>(
    String location, {
    Map<String, dynamic>? arguments,
  }) => router.push(location, extra: arguments);

  Future<Map<String, dynamic>?> pushReplacement<T extends Object?>(
    String location, {
    Map<String, dynamic>? arguments,
  }) => router.pushReplacement(location, extra: arguments);

  Future<Map<String, dynamic>?> replace<T>(
    String location, {
    Map<String, dynamic>? arguments,
  }) => router.replace(location, extra: arguments);

  void popToRoot() => router.go('/');

  bool canPop() => router.canPop();

  void pop([Map<String, dynamic>? result]) => router.pop(result);
}
