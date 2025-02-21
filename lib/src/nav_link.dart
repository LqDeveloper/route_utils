import 'package:flutter/material.dart';

import 'route_manager.dart';

typedef ParamCallback = Map<String, dynamic> Function(BuildContext context);

typedef ResultCallback = void Function(Map<String, dynamic>? result);

class NavLink extends StatelessWidget {
  final String path;
  final Widget child;
  final ParamCallback? paramCallback;
  final ResultCallback? resultCallback;

  const NavLink({
    super.key,
    required this.path,
    required this.child,
    this.paramCallback,
    this.resultCallback,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final result = await RouteManager.instance.push(
          path,
          arguments: paramCallback?.call(context),
        );
        resultCallback?.call(result);
      },
      child: child,
    );
  }
}
