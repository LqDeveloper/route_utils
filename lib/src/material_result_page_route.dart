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
    return _PageBasedMaterialPageRoute<T>(
      page: this,
      name: pageName,
      allowSnapshotting: allowSnapshotting,
    );
  }
}

class _PageBasedMaterialPageRoute<T> extends PageRoute<T>
    with MaterialRouteTransitionMixin<T>, RouteResultMixin<T> {
  final String? name;

  _PageBasedMaterialPageRoute({
    required MaterialPage<T> page,
    this.name,
    super.allowSnapshotting,
  }) : super(settings: page) {
    assert(opaque);
  }

  MaterialPage<T> get _page => settings as MaterialPage<T>;

  @override
  Widget buildContent(BuildContext context) {
    return _page.child;
  }

  @override
  String? get pageName => name;

  @override
  bool get maintainState => _page.maintainState;

  @override
  bool get fullscreenDialog => _page.fullscreenDialog;

  @override
  String get debugLabel => '${super.debugLabel}(${_page.name})';
}
