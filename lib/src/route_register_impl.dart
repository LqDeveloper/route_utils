import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:go_router/go_router.dart';
import 'package:meta/meta.dart';

import 'mixin/route_path_mixin.dart';
import 'route_register.dart';

@internal
class RouteRegisterImpl extends RouteRegister {
  static final RouteRegisterImpl instance = RouteRegisterImpl._();

  factory RouteRegisterImpl() => instance;

  RouteRegisterImpl._();

  late GoRouter _goRouter;

  GoRouter get goRouter => _goRouter;

  GlobalKey<NavigatorState> get navigatorKey =>
      goRouter.configuration.navigatorKey;

  GoRouterDelegate get delegate => goRouter.routerDelegate;
  final Map<String, RoutePathMixin> _pathRoutes = {};

  List<GoRoute> get routeStack =>
      delegate.currentConfiguration.routes.map((e) => e as GoRoute).toList();

  List<String> get pathStack => routeStack.map((e) => e.path).toList();

  String get currentRoutePath {
    final RouteMatch lastMatch = delegate.currentConfiguration.last;
    final RouteMatchList matchList =
        lastMatch is ImperativeRouteMatch
            ? lastMatch.matches
            : delegate.currentConfiguration;
    return matchList.uri.toString();
  }

  @override
  void registerRoute(RoutePathMixin route) {
    assert(!_pathRoutes.containsKey(route.path), "name has been registered");
    _pathRoutes[route.path] = route;
  }

  bool containPathInStack(String? path) {
    if (path == null || path.isEmpty) {
      return false;
    }
    return pathStack.contains(path);
  }

  bool containPath(String? path) {
    if (path == null || path.isEmpty) {
      return false;
    }
    return _pathRoutes.containsKey(path);
  }

  List<GoRoute> get getAllRoutes {
    return _pathRoutes.values.map((e) => e.createRoute()).toList();
  }

  void initRoute({
    String? initialLocation,
    Object? initialExtra,
    Codec<Object?, Object?>? extraCodec,
    List<NavigatorObserver>? observers,
    bool debugLogDiagnostics = false,
    GlobalKey<NavigatorState>? navigatorKey,
    GoRouterRedirect? redirect,
    void Function(BuildContext context, GoRouterState state)? onException,
    Listenable? refreshListenable,
  }) {
    _goRouter = GoRouter(
      routes: getAllRoutes,
      initialLocation: initialLocation,
      initialExtra: initialExtra,
      extraCodec: extraCodec,
      observers: observers,
      debugLogDiagnostics: debugLogDiagnostics,
      navigatorKey: navigatorKey,
      redirect: redirect,
      onException: (cxt, state, _) {
        onException?.call(cxt, state);
      },
      refreshListenable: refreshListenable,
    );
  }
}
