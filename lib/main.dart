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
