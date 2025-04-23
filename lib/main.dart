import 'package:flutter/material.dart';
import 'package:magikart_grocery_app/screens/cart.dart';
import 'package:magikart_grocery_app/screens/home_screen.dart';
import 'package:magikart_grocery_app/screens/login_page.dart';
import 'package:magikart_grocery_app/providers/cart_provider.dart';
import 'package:provider/provider.dart';
import 'app_theme.dart';

void main() {
  runApp(const MagiKart());
}

class MagiKart extends StatelessWidget {
  const MagiKart({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CartProvider(),
      child: Builder(
        builder: (BuildContext context) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'MagiKart',
            theme: AppTheme.lightTheme,
            initialRoute: LoginPage.id,
            routes: {
              HomeScreen.id: (context) => HomeScreen(),
              MyCart.id: (context) => MyCart(),
              LoginPage.id: (context) => LoginPage(),
            },
          );
        },
      ),
    );
  }
}
