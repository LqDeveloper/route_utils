import 'package:flutter/cupertino.dart';

import 'package:go_router/go_router.dart';

import 'cupertino_result_page.dart';
import 'material_result_page_route.dart';
import 'mixin/route_path_mixin.dart';

typedef WidgetRouteBuilder =
    Widget Function(BuildContext context, Map<String, dynamic>? arguments);

class BaseRoute extends GoRouteData with RoutePathMixin {
  @override
  final String path;
  final bool auth;
  final WidgetRouteBuilder builder;
  final bool isMaterial;
  final bool isPresent;

  const BaseRoute({
    required this.path,
    this.auth = false,
    this.isMaterial = true,
    this.isPresent = false,
    required this.builder,
  });

  @override
  Map<String, dynamic>? get pageInfo => {"auth": auth};

  @override
  GoRoute createRoute({List<GoRoute> routes = const []}) {
    return GoRoute(
      path: path,
      pageBuilder: buildPage,
      redirect: redirect,
      onExit: onExit,
      routes: routes,
    );
  }

  Widget buildWidget(BuildContext context, Map<String, dynamic>? arguments) =>
      builder(context, arguments);

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    if (isMaterial) {
      return MaterialResultPage(
        pageName: pageName,
        name: state.path,
        arguments: state.extra,
        child: buildWidget(context, state.extra as Map<String, dynamic>?),
      );
    } else {
      return CupertinoResultPage(
        isPresent: isPresent,
        pageName: pageName,
        name: state.path,
        arguments: state.extra,
        child: buildWidget(context, state.extra as Map<String, dynamic>?),
      );
    }
  }
}
