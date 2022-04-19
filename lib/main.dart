import 'package:flutter/material.dart';
import 'package:tasktwo/loginPage.dart';

void main() {
  runApp(const MyApp());
}
//heba elosta
//hebaelosta98@gmail.com
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
    );
  }
}
