import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'painter.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // 画面の向きを縦に固定
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Apple Pencil',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Offset> offsetList = <Offset>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('配列の長さ：${offsetList.length}'),
      ),
      body: CustomPaint(
        painter: Painter(offsetList),
        child: GestureDetector(
          onPanUpdate: (details) {
            final dx = details.localPosition.dx;
            final dy = details.localPosition.dy;
            final offset = Offset(dx, dy);
            if (!offsetList.contains(offset)) {
              offsetList.add(Offset(dx, dy));
            }
            setState(() {});
          },
        ),
      ),
    );
  }
}
