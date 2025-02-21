import 'package:flutter/cupertino.dart';

import 'mixin/route_result_mixin.dart';

class CupertinoResultPage<T> extends CupertinoPage<T> {
  final String? pageName;
  final bool isPresent;

  const CupertinoResultPage({
    super.key,
    required super.child,
    this.pageName,
    this.isPresent = false,
    super.maintainState = true,
    super.title,
    super.fullscreenDialog = false,
    super.allowSnapshotting = true,
    super.canPop,
    super.onPopInvoked,
    super.name,
    super.arguments,
    super.restorationId,
  });

  @override
  Route<T> createRoute(BuildContext context) {
    if (isPresent) {
      return _CupertinoSheetResultRoute(
        name: pageName,
        settings: this,
        builder: (_) => child,
      );
    } else {
      return _PageBasedCupertinoPageRoute<T>(
        page: this,
        name: pageName,
        allowSnapshotting: allowSnapshotting,
      );
    }
  }
}

class _CupertinoSheetResultRoute<T> extends CupertinoSheetRoute<T>
    with RouteResultMixin<T> {
  final String? name;

  @override
  String? get pageName => name;

  _CupertinoSheetResultRoute({
    this.name,
    super.settings,
    required super.builder,
  });
}

class _PageBasedCupertinoPageRoute<T> extends PageRoute<T>
    with CupertinoRouteTransitionMixin<T>, RouteResultMixin<T> {
  final String? name;

  _PageBasedCupertinoPageRoute({
    required CupertinoPage<T> page,
    super.allowSnapshotting = true,
    this.name,
  }) : super(settings: page) {
    assert(opaque);
  }

  CupertinoPage<T> get _page => settings as CupertinoPage<T>;

  @override
  Widget buildContent(BuildContext context) {
    return _page.child;
  }

  @override
  String? get pageName => name;

  @override
  String? get title => _page.title;

  @override
  bool get maintainState => _page.maintainState;

  @override
  bool get fullscreenDialog => _page.fullscreenDialog;

  @override
  String get debugLabel => '${super.debugLabel}(${_page.name})';
}
