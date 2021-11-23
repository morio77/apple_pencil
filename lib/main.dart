import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_apple_pencil/pages/drawing_page.dart';

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
      initialRoute: DrawingPage.routeName,
      routes: {
        DrawingPage.routeName: (_) => const DrawingPage(),
      },
    );
  }
}
