import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:magikart_grocery_app/app_theme.dart';
import 'package:magikart_grocery_app/db/cart_model.dart';
import 'package:magikart_grocery_app/db/db_helper.dart';
import 'package:magikart_grocery_app/screens/cart.dart';
import 'package:badges/badges.dart' as badges;
import 'package:magikart_grocery_app/list/grocery_list.dart';
import 'package:magikart_grocery_app/widgets/add_to_cart_button.dart';
import 'package:magikart_grocery_app/providers/cart_provider.dart';
import 'package:magikart_grocery_app/widgets/navigation_drawer.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DBHelper? dbHelper = DBHelper();

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Magik List'),

        actions: [
          Center(
            child: Padding(
              padding: EdgeInsets.only(right: 20.0, bottom: 5.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, MyCart.id);
                },
                child: badges.Badge(
                  position: badges.BadgePosition.topEnd(top: -10, end: -12),
                  badgeContent: Consumer<CartProvider>(
                    builder: (context, value, child) {
                      return Text(
                        value.getCounter().toString(),
                        style: TextStyle(color: AppTheme.lightGrey),
                      );
                    },
                  ),
                  badgeStyle: badges.BadgeStyle(
                    badgeColor: AppTheme.darkGrey,
                    elevation: 1.0,
                    shape: badges.BadgeShape.circle,
                  ),
                  child: Icon(Icons.shopping_bag_outlined, size: 30.0),
                ),
              ),
            ),
          ),
        ],
      ),
      drawer: NavDrawer(),

      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: productNames.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16.0),
                              child: CachedNetworkImage(
                                height: 60,
                                width: 60,
                                fit: BoxFit.fill,
                                imageUrl: productImages[index].toString(),
                                fadeInDuration: Duration(milliseconds: 100),
                                errorWidget:
                                    (context, url, error) => Icon(Icons.error),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(left: 5.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      productNames[index].toString(),
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: AppTheme.primaryIndigo,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      "${productUnits[index]} - Rs.${productPrices[index]}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        // color: AppTheme.primaryIndigo,
                                      ),
                                    ),
                                    SizedBox(height: 3),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: AddToCartButton(
                                        onPressed: () async {
                                          try {
                                            dbHelper!
                                                .insert(
                                                  Cart(
                                                    id: null,
                                                    productId: index.toString(),
                                                    productName:
                                                        productNames[index]
                                                            .toString(),
                                                    initialPrice:
                                                        productPrices[index],
                                                    productPrice:
                                                        productPrices[index],
                                                    quantity: 1,
                                                    unitTag:
                                                        productUnits[index],
                                                    image: productImages[index],
                                                  ),
                                                )
                                                .then((value) {
                                                  debugPrint(
                                                    'Product has been added to the Cart',
                                                  );
                                                  cart.addTotalPrice(
                                                    double.parse(
                                                      productPrices[index]
                                                          .toString(),
                                                    ),
                                                  );
                                                  cart.addCounter();
                                                });
                                          } catch (e) {
                                            debugPrint(
                                              'error adding to cart: $e',
                                            );
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  'Failed to add item to the cart',
                                                ),
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
