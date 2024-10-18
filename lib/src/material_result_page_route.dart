import 'package:flutter/material.dart';

import 'mixin/route_result_mixin.dart';

class MaterialResultPage<T> extends MaterialPage<T> {
  final String? pageName;

  const MaterialResultPage({
    required super.child,
    this.pageName,
    super.maintainState = true,
    super.fullscreenDialog = false,
    super.allowSnapshotting = true,
    super.key,
    super.canPop,
    super.onPopInvoked,
    super.name,
    super.arguments,
    super.restorationId,
  });

  @override
  Route<T> createRoute(BuildContext context) {
    return MaterialResultPageRoute<T>(
      settings: this,
      name: pageName,
      fullscreenDialog: fullscreenDialog,
      allowSnapshotting: allowSnapshotting,
      builder: (BuildContext context) {
        return child;
      },
    );
  }
}

class MaterialResultPageRoute<T> extends MaterialPageRoute<T>
    with MaterialRouteTransitionMixin<T>, RouteResultMixin {
  final String? name;
  final bool maintain;

  MaterialResultPageRoute({
    required super.builder,
    this.name,
    super.settings,
    this.maintain = true,
    super.fullscreenDialog = false,
    super.allowSnapshotting = true,
    super.barrierDismissible = false,
  });

  @override
  bool get maintainState => maintain;

  @override
  String? get pageName => name;

  @override
  Widget buildContent(BuildContext context) {
    return builder(context);
  }
}
