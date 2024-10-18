import 'dart:async';

import 'package:flutter/material.dart';

import 'mixin/route_result_mixin.dart';

enum RouteChangeType {
  push,
  pop,
  remove,
  replace,
}

extension RouteExtension<T> on Route<T> {
  bool get isPopup {
    return this is PopupRoute;
  }

  RouteResultMixin<T>? get _resultMixin =>
      (this is RouteResultMixin<T>) ? this as RouteResultMixin<T> : null;

  Object? get arguments => settings.arguments;

  T? get result => _resultMixin?.result;

  String? get pageName => _resultMixin?.pageName;
}

class NavInfo {
  final Route<dynamic>? from;
  final Route<dynamic>? to;
  final RouteChangeType type;

  NavInfo({
    required this.from,
    required this.to,
    required this.type,
  });

  Object? get arguments => to?.settings.arguments;

  Object? get result => from?.result;

  @override
  String toString() {
    if (type == RouteChangeType.push || type == RouteChangeType.replace) {
      return "NavInfo: from:${from?.settings.name} to:${to?.settings.name} type:$type arguments:$arguments";
    } else {
      return "NavInfo: from:${from?.settings.name} to:${to?.settings.name} type:$type result:$result";
    }
  }
}

class RouteChangeObserver extends NavigatorObserver {
  static final RouteChangeObserver instance = RouteChangeObserver._();

  factory RouteChangeObserver() => instance;

  RouteChangeObserver._();

  Stream<NavInfo> get navStream => _controller.stream;

  final StreamController<NavInfo> _controller = StreamController.broadcast();

  String? _currentPath;

  String? get currentPath => _currentPath;

  bool _isCurrentPopup = false;

  bool get isCurrentPopup => _isCurrentPopup;

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    final navInfo = NavInfo(
      from: route,
      to: previousRoute,
      type: RouteChangeType.pop,
    );
    _currentPath = previousRoute?.settings.name;
    _isCurrentPopup = navInfo.to?.isPopup ?? false;
    _controller.add(navInfo);
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    super.didRemove(route, previousRoute);
    final navInfo = NavInfo(
      from: route,
      to: previousRoute,
      type: RouteChangeType.remove,
    );
    _currentPath = previousRoute?.settings.name;
    _isCurrentPopup = navInfo.to?.isPopup ?? false;
    _controller.add(navInfo);
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    final navInfo = NavInfo(
      from: previousRoute,
      to: route,
      type: RouteChangeType.push,
    );
    _currentPath = route.settings.name;
    _isCurrentPopup = navInfo.to?.isPopup ?? false;
    _controller.add(navInfo);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    final navInfo = NavInfo(
      from: oldRoute,
      to: newRoute,
      type: RouteChangeType.replace,
    );
    _currentPath = newRoute?.settings.name;
    _isCurrentPopup = navInfo.to?.isPopup ?? false;
    _controller.add(navInfo);
  }
}
