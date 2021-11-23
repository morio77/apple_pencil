import 'package:flutter/material.dart';

import '../painter.dart';

class DrawingPage extends StatefulWidget {
  static const routeName = 'DrawingPage';
  const DrawingPage({Key? key}) : super(key: key);

  @override
  State<DrawingPage> createState() => _DrawingPageState();
}

class _DrawingPageState extends State<DrawingPage> {
  // 1ドラッグ中で取得できた複数のOffsetをListとして持つ
  List<List<Offset>> dragOffsetLists = [<Offset>[]];
  // ペンを離すたびにdragNumberを上げる
  int dragNumber = 0;

  /// つまり、dragOffsetListsは以下のようになる
  /// dragOffsetLists[0] => [Offset(0, 0), Offset(2, 4), ...] // 1ドラッグ目
  /// dragOffsetLists[1] => [Offset(6, 6), Offset(7, 7), ...] // 2ドラッグ目
  /// dragOffsetLists[2] => [Offset(4, 2), Offset(4, 6), ...] // 3ドラッグ目
  /// .
  /// .
  /// .

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Offsetの総数：${dragOffsetLists.expand((element) => element).toList().length}',
        ),
      ),

      body: CustomPaint(
        painter: Painter(dragOffsetLists),
        child: GestureDetector(
          // 一度ペンを離すたびに、dragNumberをインクリメントする
          onPanEnd: (_) {
            dragNumber++;
            dragOffsetLists.add(<Offset>[]);
          },
          // ドラッグ中、Offsetを取得し続ける
          onPanUpdate: (details) {
            final offset = Offset(
              details.localPosition.dx,
              details.localPosition.dy,
            );
            dragOffsetLists[dragNumber].add(offset);
            setState(() {});
          },
        ),
      ),

      // 全消しするボタン
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          dragOffsetLists = [<Offset>[]];
          dragNumber = 0;
          setState(() {});
        },
        child: const Icon(Icons.delete_forever),
      ),
    );
  }
}
