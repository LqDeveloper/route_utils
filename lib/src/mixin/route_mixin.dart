import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:meta/meta.dart';

import '../route_register_impl.dart';
import 'route_path_mixin.dart';

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

  List<String> get allRouterPath => RouteRegisterImpl.instance.allRouterPath;

  bool containPathInStack(String? path) {
    return RouteRegisterImpl.instance.containPathInStack(path);
  }

  bool containPath(String? path) {
    return RouteRegisterImpl.instance.containPath(path);
  }

  RoutePathMixin? getRouteFromPath(String? path) {
    return RouteRegisterImpl.instance.getRouteFromPath(path);
  }

  void addListener(VoidCallback listener) {
    RouteRegisterImpl.instance.delegate.addListener(listener);
  }

  void removeListener(VoidCallback listener) {
    RouteRegisterImpl.instance.delegate.removeListener(listener);
  }

  String getFullPath(String location) {
    if (location == "/") {
      return location;
    } else {
      return "/$location";
    }
  }

  void go(String location, {Map<String, dynamic>? arguments}) =>
      router.go(getFullPath(location), extra: arguments);

  Future<Map<String, dynamic>?> push<T extends Object?>(
    String location, {
    Map<String, dynamic>? arguments,
  }) => router.push(getFullPath(location), extra: arguments);

  Future<Map<String, dynamic>?> pushReplacement<T extends Object?>(
    String location, {
    Map<String, dynamic>? arguments,
  }) => router.pushReplacement(getFullPath(location), extra: arguments);

  Future<Map<String, dynamic>?> replace<T>(
    String location, {
    Map<String, dynamic>? arguments,
  }) => router.replace(getFullPath(location), extra: arguments);

  Future<Map<String, dynamic>?> pushOrReplace<T>(
    String location, {
    Map<String, dynamic>? arguments,
  }) {
    if (currentPath == location) {
      return router.replace(getFullPath(location), extra: arguments);
    } else {
      return router.push(getFullPath(location), extra: arguments);
    }
  }

  void popToRoot() => router.go('/');

  bool canPop() => router.canPop();

  void pop([Map<String, dynamic>? result]) => router.pop(result);
}
