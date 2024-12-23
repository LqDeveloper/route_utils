import 'package:go_router/go_router.dart';

mixin RoutePathMixin on GoRouteData {
  String? get pageName => null;

  String get path;

  GoRoute createRoute({
    List<GoRoute> routes = const [],
  });
}
