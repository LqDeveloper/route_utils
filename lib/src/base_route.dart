import 'package:flutter/cupertino.dart';

import 'package:go_router/go_router.dart';

import 'cupertino_result_page.dart';
import 'mixin/route_path_mixin.dart';

abstract class BaseRoute extends GoRouteData with RoutePathMixin {
  @override
  String get path;

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
      routes: routes,
    );
  }

  Widget buildWidget(BuildContext context);

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return CupertinoResultPage(
      pageName: pageName,
      name: state.path,
      arguments: state.extra,
      child: buildWidget(context),
    );
  }
}
