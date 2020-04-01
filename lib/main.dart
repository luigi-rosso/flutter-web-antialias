// Run in macos: flutter run -dmacos
//
// Notice sharp edges as antialiasing settings are respected.

// Run with skia web: flutter run --release --dart-define=FLUTTER_WEB_USE_SKIA=true -d chrome
//
// Notice edges are fuzzy because the canvas webgl context has antialising
// enabled.
import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;
  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: CustomPaint(
        painter: PaintAliased(),
      ),
    );
  }
}

class PaintAliased extends CustomPainter {
  @override
  bool shouldRepaint(PaintAliased oldDelegate) => true;

  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = Colors.black
      ..isAntiAlias = false;
    canvas.save();
    canvas.translate(20, 10);
    canvas.drawLine(Offset.zero, Offset(0, 200), p);

    canvas.translate(100, 0);
    canvas.rotate(pi / 4);
    canvas.drawRect(Rect.fromLTWH(0, 0, 100, 100), p);
    canvas.restore();
  }
}
