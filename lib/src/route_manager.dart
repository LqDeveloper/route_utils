import 'package:go_router/go_router.dart';

import 'base_route_config.dart';
import 'mixin/route_mixin.dart';
import 'route_register_impl.dart';

class RouteManager with RouteMixin {
  static final RouteManager instance = RouteManager._();

  factory RouteManager() => instance;

  RouteManager._();

  static Future<void> initRoute(BaseRouteConfig config) async {
    GoRouter.optionURLReflectsImperativeAPIs = true;
    final initialLocation = await config.initialLocation;
    config.registerRoute(RouteRegisterImpl());
    for (final subModule in config.subRegisters) {
      subModule.registerRoute(RouteRegisterImpl());
    }
    RouteRegisterImpl.instance.initRoute(
      initialLocation: initialLocation,
      initialExtra: config.initialExtra,
      extraCodec: config.extraCodec,
      observers: config.observers,
      debugLogDiagnostics: config.debugLogDiagnostics,
      navigatorKey: config.navigatorKey,
      redirect: (context, state) {
        Map<String, dynamic>? arguments;
        if (state.extra is Map<String, dynamic>) {
          arguments = state.extra as Map<String, dynamic>?;
        }
        final path = config.routeRedirect(context, state.fullPath, arguments);
        return path;
      },
      onException: (context, state) {
        Map<String, dynamic>? arguments;
        if (state.extra is Map<String, dynamic>) {
          arguments = state.extra as Map<String, dynamic>?;
        }
        config.routeException(context, state.fullPath, arguments);
      },
      refreshListenable: config.refreshListenable,
    );
  }
}
