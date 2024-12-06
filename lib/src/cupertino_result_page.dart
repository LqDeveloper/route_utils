import 'package:flutter/cupertino.dart';

import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'mixin/route_result_mixin.dart';

class CupertinoResultPage<T> extends CupertinoPage<T> {
  final String? pageName;

  const CupertinoResultPage({
    super.key,
    required super.child,
    this.pageName,
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
    return _PageBasedCupertinoPageRoute<T>(
      page: this,
      name: pageName,
      allowSnapshotting: allowSnapshotting,
    );
  }
}

class _PageBasedCupertinoPageRoute<T> extends PageRoute<T>
    with CupertinoRouteTransitionMixin<T>, RouteResultMixin {
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
  Widget buildContent(BuildContext context) => CupertinoScaffold(
        topRadius: const Radius.circular(16),
        body: _page.child,
      );

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
