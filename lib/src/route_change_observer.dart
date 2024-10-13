import 'dart:async';

import 'package:flutter/material.dart';

enum RouteChangeType {
  push,
  pop,
  remove,
  replace,
}

class NavInfo {
  final String? from;
  final String? to;
  final RouteChangeType type;
  final bool isPopup;

  NavInfo({
    required this.from,
    required this.to,
    required this.type,
    required this.isPopup,
  });

  @override
  String toString() {
    return "NavInfo: from:$from to:$to type:$type isPopup:$isPopup";
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
      from: route.settings.name,
      to: previousRoute?.settings.name,
      type: RouteChangeType.pop,
      isPopup: previousRoute is PopupRoute,
    );
    _currentPath = previousRoute?.settings.name;
    _isCurrentPopup = navInfo.isPopup;
    _controller.add(navInfo);
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    super.didRemove(route, previousRoute);
    final navInfo = NavInfo(
      from: route.settings.name,
      to: previousRoute?.settings.name,
      type: RouteChangeType.remove,
      isPopup: previousRoute is PopupRoute,
    );
    _currentPath = previousRoute?.settings.name;
    _isCurrentPopup = navInfo.isPopup;
    _controller.add(navInfo);
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    final navInfo = NavInfo(
      from: previousRoute?.settings.name,
      to: route.settings.name,
      type: RouteChangeType.push,
      isPopup: route is PopupRoute,
    );
    _currentPath = route.settings.name;
    _isCurrentPopup = navInfo.isPopup;
    _controller.add(navInfo);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    final navInfo = NavInfo(
      from: oldRoute?.settings.name,
      to: newRoute?.settings.name,
      type: RouteChangeType.replace,
      isPopup: newRoute is PopupRoute,
    );
    _currentPath = newRoute?.settings.name;
    _isCurrentPopup = navInfo.isPopup;
    _controller.add(navInfo);
  }
}
