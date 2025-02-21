import 'package:flutter/material.dart';
import 'package:route_utils/route_utils.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("这是标题")),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
              onPressed: () {
                RouteManager.instance.push("/pageOne");
              },
              child: Text("Android 风格"),
            ),
            TextButton(
              onPressed: () {
                RouteManager.instance.push("/pageOne/pageTwo");
              },
              child: Text("iOS 风格"),
            ),
            TextButton(
              onPressed: () {
                RouteManager.instance.push("/pageOne/pageThree");
              },
              child: Text("iOS Present风格"),
            ),
          ],
        ),
      ),
    );
  }
}

class PageOne extends StatelessWidget {
  const PageOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Android风格")),
      body: Center(
        child: TextButton(
          onPressed: () {
            // Navigator.of(context).pop({"data": "Android风格"});
            RouteManager.instance.go("/pageTwo");
          },
          child: Text("点击返回"),
        ),
      ),
    );
  }
}

class PageTwo extends StatelessWidget {
  const PageTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("iOS风格")),
      body: Center(
        child: TextButton(
          onPressed: () {
            Navigator.of(context).pop({"data": "iOS风格"});
          },
          child: Text("点击返回"),
        ),
      ),
    );
  }
}

class PageThree extends StatelessWidget {
  const PageThree({super.key});

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: Scaffold(
        appBar: AppBar(title: Text("iOS Present风格")),
        body: Center(
          child: TextButton(
            onPressed: () {
              Navigator.of(context).pop({"data": "iOS Present风格"});
            },
            child: Text("点击返回"),
          ),
        ),
      ),
    );
  }
}
