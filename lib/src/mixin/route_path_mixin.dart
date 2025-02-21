import 'package:go_router/go_router.dart';

mixin RoutePathMixin on GoRouteData {
  String? get pageName => null;

  String get path;

  Map<String, dynamic>? get pageInfo => null;

  GoRoute createRoute({List<GoRoute> routes = const []});
}
