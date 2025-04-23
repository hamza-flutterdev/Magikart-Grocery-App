import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:magikart_grocery_app/db/db_helper.dart';
import 'package:magikart_grocery_app/screens/home_screen.dart';
import 'package:magikart_grocery_app/providers/cart_provider.dart';
import 'package:magikart_grocery_app/widgets/checkout_button.dart';
import 'package:magikart_grocery_app/widgets/reusable_widget.dart';
import 'package:provider/provider.dart';
import '../db/cart_model.dart';
import '../widgets/navigation_drawer.dart';

class MyCart extends StatefulWidget {
  static const String id = 'cart';
  const MyCart({super.key});

  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  DBHelper? dbHelper = DBHelper();
  late Future<List<Cart>> _cartFuture;

  @override
  void initState() {
    super.initState();
    final cart = Provider.of<CartProvider>(context, listen: false);
    _cartFuture = cart.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Magik Cart'),

        actions: [
          IconButton(
            icon: const Icon(Icons.home_outlined, size: 30.0),
            onPressed: () {
              Navigator.pushNamed(context, HomeScreen.id);
            },
          ),
        ],
      ),
      drawer: const NavDrawer(),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<Cart>>(
              future: _cartFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('Your cart is empty'));
                }

                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final item = snapshot.data![index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: CachedNetworkImage(
                                height: 70,
                                width: 70,
                                fit: BoxFit.cover,
                                imageUrl: item.image.toString(),
                                errorWidget:
                                    (context, url, error) =>
                                        const Icon(Icons.error, size: 30),
                              ),
                            ),

                            const SizedBox(width: 12),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        item.productName.toString(),
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      IconButton(
                                        icon: const Icon(
                                          Icons.delete_outline,
                                          size: 22,
                                        ),
                                        color: Colors.red[400],
                                        onPressed: () async {
                                          final cartProvider =
                                              Provider.of<CartProvider>(
                                                context,
                                                listen: false,
                                              );

                                          int itemQuantity = item.quantity!;

                                          await dbHelper!.delete(item.id!);

                                          for (
                                            int i = 0;
                                            i < itemQuantity;
                                            i++
                                          ) {
                                            cartProvider.remCounter();
                                          }

                                          cartProvider.remTotalPrice(
                                            item.productPrice!,
                                          );

                                          setState(() {
                                            _cartFuture =
                                                cartProvider.getData();
                                          });
                                        },
                                      ),
                                    ],
                                  ),

                                  Text(
                                    "${item.unitTag} • Rs.${item.initialPrice}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                    ),
                                  ),

                                  const SizedBox(height: 8),

                                  // Quantity Controls
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Rs.${item.productPrice}",
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.teal,
                                        ),
                                      ),

                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.grey[100],
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            IconButton(
                                              icon: const Icon(
                                                Icons.remove,
                                                size: 18,
                                              ),
                                              onPressed: () async {
                                                final cartProvider =
                                                    Provider.of<CartProvider>(
                                                      context,
                                                      listen: false,
                                                    );

                                                if (item.quantity! > 1) {
                                                  await dbHelper!
                                                      .updateQuantity(
                                                        item.id!,
                                                        item.quantity! - 1,
                                                        item.initialPrice! *
                                                            (item.quantity! -
                                                                1),
                                                      );
                                                  cartProvider.remCounter();
                                                  cartProvider.remTotalPrice(
                                                    item.initialPrice!,
                                                  );
                                                } else {
                                                  await dbHelper!.delete(
                                                    item.id!,
                                                  );
                                                  cartProvider.remCounter();
                                                  cartProvider.remTotalPrice(
                                                    item.productPrice!,
                                                  );
                                                }

                                                setState(() {
                                                  _cartFuture =
                                                      cartProvider.getData();
                                                });
                                              },
                                            ),

                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 4,
                                                  ),
                                              child: Text(
                                                item.quantity.toString(),
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),

                                            IconButton(
                                              icon: const Icon(
                                                Icons.add,
                                                size: 18,
                                              ),
                                              onPressed: () async {
                                                final cartProvider =
                                                    Provider.of<CartProvider>(
                                                      context,
                                                      listen: false,
                                                    );

                                                await dbHelper!.updateQuantity(
                                                  item.id!,
                                                  item.quantity! + 1,
                                                  item.initialPrice! *
                                                      (item.quantity! + 1),
                                                );

                                                cartProvider.addCounter();
                                                cartProvider.addTotalPrice(
                                                  item.initialPrice!,
                                                );

                                                setState(() {
                                                  _cartFuture =
                                                      cartProvider.getData();
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Consumer<CartProvider>(
            builder: (context, cartProvider, child) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ReusableWidget(
                  title: 'Sub Total',
                  value: 'Rs. ${cartProvider.getTotalPrice()}',
                ),
              );
            },
          ),
          CheckoutButton(
            onCheckoutComplete: () {
              setState(() {
                _cartFuture =
                    Provider.of<CartProvider>(context, listen: false).getData();
              });
            },
          ),
        ],
      ),
    );
  }
}
