import 'package:flutter/material.dart';
import 'package:magikart_grocery_app/db/db_helper.dart';
import 'package:magikart_grocery_app/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class CheckoutButton extends StatefulWidget {
  final VoidCallback? onCheckoutComplete;

  const CheckoutButton({super.key, this.onCheckoutComplete});

  @override
  State<CheckoutButton> createState() => _CheckoutButtonState();
}

class _CheckoutButtonState extends State<CheckoutButton> {
  bool _isLoading = false;

  Future<void> _checkout(BuildContext context) async {
    if (!mounted) return;
    setState(() {
      _isLoading = true;
    });

    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final dbHelper = DBHelper();

    final cartItems = await dbHelper.getCartList();
    for (var item in cartItems) {
      await dbHelper.delete(item.id!);
    }

    cartProvider.remCounterByAmount(cartProvider.counter);
    cartProvider.remTotalPrice(cartProvider.totalPrice);

    if (!mounted) return;
    setState(() {
      _isLoading = false;
    });

    if (!mounted) return;
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Order Placed!'),
            content: const Text('Your order has been placed successfully.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  widget.onCheckoutComplete?.call();
                },
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cartProvider, child) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(),
              onPressed:
                  cartProvider.counter == 0 || _isLoading
                      ? null
                      : () => _checkout(context),
              child:
                  _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                        'Checkout',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
            ),
          ),
        );
      },
    );
  }
}
