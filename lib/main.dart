import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fontend/pages/dashboard_page.dart';
import 'package:fontend/pages/home_page.dart';
import 'package:fontend/pages/login_page.dart';
import 'package:fontend/pages/product_details_page.dart';
import 'package:fontend/pages/products_page.dart';
import 'package:fontend/pages/register_page.dart';
import 'package:fontend/utils/shared_service.dart';

final GlobalKey<NavigatorState> navigatorkey = GlobalKey<NavigatorState>();

//check login
Widget _defaultHome = const LoginPage();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool _result = await SharedService.isLoggedIn();

  if (_result) {
    _defaultHome = const DashBoardPage();
  }
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        navigatorKey: navigatorkey,
        // home: const RegisterPage(),
        routes: <String, WidgetBuilder>{
          '/': (context) => _defaultHome,
          '/register': (BuildContext context) => const RegisterPage(),
          '/login': (BuildContext context) => const LoginPage(),
          '/home': (BuildContext context) => const HomePage(),
          '/products': (BuildContext context) => const ProductsPage(),
          '/product-details': (BuildContext context) =>
              const ProductDetailsPage(),
        });
  }
}
