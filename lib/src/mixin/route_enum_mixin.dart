import '../route_manager.dart';

mixin RouteEnumMixin on Enum {
  String get routePath;

  Map<String, dynamic>? get pageInfo => null;

  void go({
    Map<String, dynamic>? arguments,
  }) =>
      RouteManager.instance.go(routePath, arguments: arguments);

  Future<Map<String, dynamic>?> push<T extends Object?>({
    Map<String, dynamic>? arguments,
  }) =>
      RouteManager.instance.push(routePath, arguments: arguments);

  Future<Map<String, dynamic>?> pushReplacement<T extends Object?>({
    Map<String, dynamic>? arguments,
  }) =>
      RouteManager.instance.pushReplacement(routePath, arguments: arguments);

  Future<Map<String, dynamic>?> replace<T>({
    Map<String, dynamic>? arguments,
  }) =>
      RouteManager.instance.replace(routePath, arguments: arguments);

  void popToRoot() => RouteManager.instance.go('/');

  bool canPop() => RouteManager.instance.canPop();

  void pop([Map<String, dynamic>? result]) => RouteManager.instance.pop(result);
}
