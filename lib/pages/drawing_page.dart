import 'dart:ui';

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

  // 線の描画モード
  PointMode pointMode = PointMode.polygon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Offsetの総数：${dragOffsetLists.expand((element) => element).toList().length}',
        ),
        actions: [
          _dropdownButton(),
        ],
      ),

      body: Listener(
        // ドラッグ中、Offsetを取得し続ける
        onPointerMove: (pointerDownEvent) {
          // スタイラスからのみ受け付ける
          if (pointerDownEvent.kind == PointerDeviceKind.stylus) {
            print(pointerDownEvent.pressure);
            final offset = Offset(
              pointerDownEvent.localPosition.dx,
              pointerDownEvent.localPosition.dy,
            );
            dragOffsetLists[dragNumber].add(offset);
            setState(() {});
          }
        },
        // 一度ペンを離すたびに、dragNumberをインクリメントする
        onPointerUp: (_) {
          dragNumber++;
          dragOffsetLists.add(<Offset>[]);
        },
        child: CustomPaint(
          painter: Painter(dragOffsetLists, pointMode),
          child: Container(),
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

  DropdownButton _dropdownButton() {
    return DropdownButton<PointMode>(
      value: pointMode,
      items: PointMode.values.map<DropdownMenuItem<PointMode>>(
        (PointMode pointMode) {
          return DropdownMenuItem<PointMode>(
            child: Text(pointMode.toString()),
            value: pointMode,
          );
        },
      ).toList(),
      onChanged: (PointMode? selectedPointMode) {
        pointMode = selectedPointMode!;
        setState(() {});
      },
    );
  }
}
