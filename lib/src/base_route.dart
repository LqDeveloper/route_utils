import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'material_result_page_route.dart';
import 'route_path_mixin.dart';

abstract class BaseRoute extends GoRouteData with RoutePathMixin {
  @override
  String get path;

  List<GoRoute> get subRoutes => [];

  Map<String, dynamic> get pageInfo => {};

  @override
  GoRoute createRoute({
    List<GoRoute> routes = const [],
  }) {
    return GoRoute(
      path: path,
      pageBuilder: buildPage,
      redirect: redirect,
      onExit: onExit,
      routes: routes.isNotEmpty ? routes : subRoutes,
    );
  }

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return MaterialResultPage(
      routeName: routeName,
      name: state.path,
      arguments: state.extra,
      child: build(context, state),
    );
  }
}
