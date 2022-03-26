import 'package:flutter/material.dart';

class MyColor extends InheritedWidget {
  const MyColor({
    Key? key,
    required this.color,
    required Widget child,
  }) : super(key: key, child: child);

  final Color color;

  @override
  bool updateShouldNotify(MyColor oldWidget) {
    return color != oldWidget.color;
  }

  static MyColor of(context) =>
      context.dependOnInheritedWidgetOfExactType<MyColor>();
}

class ColorScreen extends StatelessWidget {
  const ColorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: MyColor(
            color: Colors.amber,
            child: Builder(
              builder: (ctx) => Text(
                'my Text',
                style: TextStyle(
                  fontSize: 45,
                  backgroundColor: MyColor.of(ctx).color,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
