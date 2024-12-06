import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:meta/meta.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../route_register_impl.dart';
import 'route_path_mixin.dart';

@internal
mixin RouteMixin {
  GoRouter get router {
    return RouteRegisterImpl.instance.goRouter;
  }

  GlobalKey<NavigatorState> get navigatorKey =>
      RouteRegisterImpl.instance.navigatorKey;

  BuildContext? get navContext =>
      RouteRegisterImpl.instance.navigatorKey.currentContext;

  List<GoRoute> get routeStack => RouteRegisterImpl.instance.routeStack;

  List<String> get pathStack => RouteRegisterImpl.instance.pathStack;

  String get currentPath => RouteRegisterImpl.instance.currentRoutePath;

  List<String> get allRouterPath => RouteRegisterImpl.instance.allRouterPath;

  bool containPathInStack(String? path) {
    return RouteRegisterImpl.instance.containPathInStack(path);
  }

  bool containPath(String? path) {
    return RouteRegisterImpl.instance.containPath(path);
  }

  RoutePathMixin? getRouteFromPath(String? path) {
    return RouteRegisterImpl.instance.getRouteFromPath(path);
  }

  void addListener(VoidCallback listener) {
    RouteRegisterImpl.instance.delegate.addListener(listener);
  }

  void removeListener(VoidCallback listener) {
    RouteRegisterImpl.instance.delegate.removeListener(listener);
  }

  String getFullPath(String location) {
    if (location == "/") {
      return location;
    } else {
      return "/$location";
    }
  }

  void go(
    String location, {
    Map<String, dynamic>? arguments,
  }) =>
      router.go(getFullPath(location), extra: arguments);

  Future<Map<String, dynamic>?> push<T extends Object?>(
    String location, {
    Map<String, dynamic>? arguments,
  }) =>
      router.push(getFullPath(location), extra: arguments);

  Future<Map<String, dynamic>?> pushReplacement<T extends Object?>(
    String location, {
    Map<String, dynamic>? arguments,
  }) =>
      router.pushReplacement(getFullPath(location), extra: arguments);

  Future<Map<String, dynamic>?> replace<T>(
    String location, {
    Map<String, dynamic>? arguments,
  }) =>
      router.replace(getFullPath(location), extra: arguments);

  Future<Map<String, dynamic>?> pushOrReplace<T>(
    String location, {
    Map<String, dynamic>? arguments,
  }) {
    if (currentPath == location) {
      return router.replace(getFullPath(location), extra: arguments);
    } else {
      return router.push(getFullPath(location), extra: arguments);
    }
  }

  void popToRoot() => router.go('/');

  bool canPop() => router.canPop();

  void pop([Map<String, dynamic>? result]) => router.pop(result);

  Future<T?> showAppDialog<T extends Object?>({
    required BuildContext context,
    required WidgetBuilder builder,
    bool barrierDismissible = true,
    Color? barrierColor,
    String? barrierLabel,
    bool useSafeArea = true,
    bool useRootNavigator = true,
    RouteSettings? routeSettings,
    Offset? anchorPoint,
    TraversalEdgeBehavior? traversalEdgeBehavior,
  }) {
    return showDialog(
      context: context,
      builder: builder,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor,
      barrierLabel: barrierLabel,
      useSafeArea: useSafeArea,
      useRootNavigator: useRootNavigator,
      routeSettings: routeSettings,
      anchorPoint: anchorPoint,
      traversalEdgeBehavior: traversalEdgeBehavior,
    );
  }

  Future<T?> showAppModalBottomSheet<T>({
    required BuildContext context,
    required WidgetBuilder builder,
    Color? backgroundColor,
    String? barrierLabel,
    double? elevation,
    ShapeBorder? shape,
    Clip? clipBehavior,
    Color? barrierColor,
    bool isScrollControlled = true,
    bool useRootNavigator = false,
    bool isDismissible = true,
    bool enableDrag = true,
    bool? showDragHandle,
    bool useSafeArea = false,
    RouteSettings? routeSettings,
    AnimationController? transitionAnimationController,
    Offset? anchorPoint,
    AnimationStyle? sheetAnimationStyle,
  }) {
    final mediaQuery = MediaQuery.of(context);
    return showModalBottomSheet(
      context: context,
      builder: (cxt) {
        return CupertinoScaffold(
          topRadius: const Radius.circular(16),
          transitionBackgroundColor: Colors.transparent,
          body: builder(cxt),
        );
      },
      backgroundColor: backgroundColor,
      elevation: elevation,
      shape: shape,
      clipBehavior: clipBehavior,
      constraints: BoxConstraints(
        maxHeight: mediaQuery.size.height - kToolbarHeight,
      ),
      barrierColor: barrierColor,
      isScrollControlled: isScrollControlled,
      useRootNavigator: useRootNavigator,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      showDragHandle: showDragHandle,
      useSafeArea: useSafeArea,
      routeSettings: routeSettings,
      transitionAnimationController: transitionAnimationController,
      anchorPoint: anchorPoint,
      sheetAnimationStyle: sheetAnimationStyle,
    );
  }

  Future<T?> showCupertinoModalBottomSheet<T>({
    required BuildContext context,
    required WidgetBuilder builder,
    double? closeProgressThreshold,
    Curve? animationCurve,
    Curve? previousRouteAnimationCurve,
    Color? backgroundColor,
    Color? barrierColor,
    bool expand = false,
    bool useRootNavigator = false,
    bool bounce = true,
    bool? isDismissible,
    bool enableDrag = true,
    Duration? duration,
    RouteSettings? settings,
    BoxShadow? shadow,
  }) {
    return CupertinoScaffold.showCupertinoModalBottomSheet<T>(
      context: context,
      closeProgressThreshold: closeProgressThreshold,
      builder: builder,
      animationCurve: animationCurve,
      previousRouteAnimationCurve: previousRouteAnimationCurve,
      backgroundColor: backgroundColor,
      barrierColor: barrierColor,
      expand: expand,
      useRootNavigator: useRootNavigator,
      bounce: bounce,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      duration: duration,
      settings: settings,
      shadow: shadow,
    );
  }
}
