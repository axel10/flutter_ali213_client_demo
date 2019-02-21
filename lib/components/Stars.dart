import 'dart:ui' as UI;
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';

class StarWidget extends StatelessWidget {
  Future<UI.Image> _loadImg() async {
    var bd = await rootBundle.load('assets/stars.png');
    var codec = await UI.instantiateImageCodec(bd.buffer.asUint8List());
    var frame = await codec.getNextFrame();
    return frame.image;
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UI.Image>(
      future: _loadImg(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return CustomPaint(painter: Stars(snapshot.data),);
      },
    );
  }
}

class Stars extends CustomPainter {
  Paint _paint;

  final UI.Image starsImage;

  Stars(this.starsImage) {
    _paint = Paint()
      ..color = Colors.redAccent
      ..strokeWidth = 1;
  }

  @override
  void paint(Canvas canvas, Size size) {
    _paint.color= Colors.redAccent;
    _paint.blendMode = BlendMode.dstIn;
    canvas.drawCircle(Offset(0,0),100, _paint);
    canvas.saveLayer(Rect.fromLTWH(0, 0, 300, 300), _paint);
    _paint.color= Colors.blue;
    canvas.drawCircle(Offset(100,0),50, _paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
