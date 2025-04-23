import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:magikart_grocery_app/app_theme.dart';
import 'package:magikart_grocery_app/screens/cart.dart';
import 'package:magikart_grocery_app/screens/home_screen.dart';
import 'package:magikart_grocery_app/screens/login_page.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: AppTheme.primaryIndigo),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('lib/src/ProfilePic.jpg'),
            ),
            accountName: Text('John Wick'),
            accountEmail: Text('xyz@gmail.com'),
          ),
          ListTile(
            leading: Icon(Icons.home_outlined),
            title: Text('Home'),
            onTap: () {
              Navigator.pushNamed(context, HomeScreen.id);
            },
          ),
          ListTile(
            leading: Icon(Icons.shopping_cart_outlined),
            title: Text('My Cart'),
            onTap: () {
              Navigator.pushNamed(context, MyCart.id);
            },
          ),

          ListTile(
            leading: Icon(Icons.login_outlined),
            title: Text('Logout'),
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                LoginPage.id,
                (Route<dynamic> route) => false,
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app_outlined),
            title: Text('Exit'),
            onTap: () {
              SystemNavigator.pop();
            },
          ),
        ],
      ),
    );
  }
}
