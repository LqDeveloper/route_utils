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
        routes: [
          BaseRoute(
            path: "pageOne",
            isMaterial: true,
            builder: (_, arg) {
              return PageOne();
            },
            routes: [
              BaseRoute(
                path: "pageTwo",
                isMaterial: false,
                builder: (_, arg) {
                  return PageTwo();
                },
              ),
              BaseRoute(
                path: "pageThree",
                isMaterial: false,
                isPresent: true,
                builder: (_, arg) {
                  return PageThree();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
