import 'package:flutter/material.dart';

import '../painter.dart';

class DrawingPage extends StatefulWidget {
  static const routeName = 'DrawingPage';
  const DrawingPage({Key? key}) : super(key: key);

  @override
  State<DrawingPage> createState() => _DrawingPageState();
}

class _DrawingPageState extends State<DrawingPage> {
  int index = 0;
  List<List<Offset>> offsetListList = [<Offset>[]];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Offsetの数：${offsetListList.expand((element) => element).toList().length}'),
      ),
      body: CustomPaint(
        painter: Painter(offsetListList),
        child: GestureDetector(
          onPanEnd: (_) {
            index++;
            offsetListList.add(<Offset>[]);
          },
          onPanUpdate: (details) {
            final dx = details.localPosition.dx;
            final dy = details.localPosition.dy;
            final offset = Offset(dx, dy);
            if (!offsetListList[index].contains(offset)) {
              offsetListList[index].add(Offset(dx, dy));
            }
            setState(() {});
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          offsetListList = [<Offset>[]];
          index = 0;
          setState(() {});
        },
        child: const Icon(Icons.delete_forever),
      ),
    );
  }
}
