import 'package:example/src/pages.dart';
import 'package:flutter/material.dart';
import 'package:route_utils/route_utils.dart';

class AppRouteConfig extends BaseRouteConfig {
  @override
  List<NavigatorObserver>? get observers => [RouteChangeObserver()];

  @override
  bool get debugLogDiagnostics => false;

  @override
  void registerRoute(RouteRegister register) {
    register.registerRoute(
      BaseRoute(
        path: "/",
        isMaterial: true,
        builder: (_, arg) {
          return HomePage();
        },
      ),
    );

    register.registerRoute(
      BaseRoute(
        path: "pageOne",
        isMaterial: true,
        builder: (_, arg) {
          return PageOne();
        },
      ),
    );

    register.registerRoute(
      BaseRoute(
        path: "pageTwo",
        isMaterial: false,
        builder: (_, arg) {
          return PageTwo();
        },
      ),
    );

    register.registerRoute(
      BaseRoute(
        path: "pageThree",
        isMaterial: false,
        isPresent: true,
        builder: (_, arg) {
          return PageThree();
        },
      ),
    );
  }
}
