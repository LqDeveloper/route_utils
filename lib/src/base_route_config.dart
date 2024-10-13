import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:go_router/go_router.dart';

import 'route_register.dart';

abstract class BaseRouteConfig {
  FutureOr<String?> routeRedirect(BuildContext context, GoRouterState state) =>
      null;

  void routeException(BuildContext context, GoRouterState state) {}

  Codec<Object?, Object?>? get extraCodec => null;

  Listenable? get refreshListenable => null;

  FutureOr<String?> get initialLocation => '/';

  FutureOr<Map<String, dynamic>?> get initialExtra => null;

  List<NavigatorObserver>? get observers => [];

  bool get debugLogDiagnostics => kDebugMode;

  GlobalKey<NavigatorState>? get navigatorKey => null;

  void registerRoute(RouteRegister register) {}
}
