import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'base_route_register.dart';
import 'route_register.dart';

abstract class BaseRouteConfig {
  FutureOr<String?> routeRedirect(
    BuildContext context,
    String? path,
    Map<String, dynamic>? pageInfo,
    Map<String, dynamic>? arguments,
  ) => null;

  void routeException(
    BuildContext context,
    String? path,
    Map<String, dynamic>? pageInfo,
    Map<String, dynamic>? arguments,
  ) {}

  Codec<Object?, Object?>? get extraCodec => null;

  Listenable? get refreshListenable => null;

  FutureOr<String?> get initialLocation => '/';

  FutureOr<Map<String, dynamic>?> get initialExtra => null;

  List<NavigatorObserver>? get observers => [];

  bool get debugLogDiagnostics => kDebugMode;

  GlobalKey<NavigatorState>? get navigatorKey => null;

  List<BaseRouteRegister> get subRegisters => [];

  void registerRoute(RouteRegister register) {}
}
