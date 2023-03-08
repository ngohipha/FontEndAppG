import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fontend/pages/home_page.dart';
import 'package:fontend/pages/login_page.dart';
import 'package:fontend/pages/products_page.dart';
import 'package:fontend/pages/register_page.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const RegisterPage(),
        routes: <String, WidgetBuilder>{
          '/register': (BuildContext context) => const RegisterPage(),
          '/login': (BuildContext context) => const LoginPage(),
          '/home': (BuildContext context) => const HomePage(),
          '/products': (BuildContext context) => const ProductsPage()
        });
  }
}
