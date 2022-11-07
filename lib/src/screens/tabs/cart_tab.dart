import 'package:flutter/material.dart';

import 'package:greengrocer/src/models/cart_product.dart';

import 'package:greengrocer/src/widgets/cart_tile.dart';
import 'package:greengrocer/src/widgets/common/custom_elevated_button.dart';
import 'package:greengrocer/src/widgets/payment_dialog.dart';

import 'package:greengrocer/src/theme/custom_colors.dart';

import 'package:greengrocer/src/utils/utils.dart';
import 'package:greengrocer/src/utils/app_data.dart' as app_data;

class CartTab extends StatefulWidget {
  const CartTab({Key? key}) : super(key: key);

  @override
  State<CartTab> createState() => _CartTabState();
}

class _CartTabState extends State<CartTab> {
  final Utils utils = Utils();

  void removeItemFromCart(CartProduct cartProduct) {
    setState(() {
      app_data.cartProducts.remove(cartProduct);
      utils.showToast(
          message: '${cartProduct.product.name} removido(a) do carrinho');
    });
  }

  double cartTotalPrice() {
    double total = 0;

    for (var item in app_data.cartProducts) {
      total += item.totalPrice();
    }

    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: app_data.cartProducts.length,
              itemBuilder: (_, index) {
                final cartItem = app_data.cartProducts[index];

                return CartTile(
                  cartProduct: app_data.cartProducts[index],
                  updatedQuantity: (qtd) {
                    if (qtd == 0) {
                      removeItemFromCart(app_data.cartProducts[index]);
                    } else {
                      setState(() => cartItem.quantity = qtd);
                    }
                  },
                );
              },
            ),
          ),

          // Total geral
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(28),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 3,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Total Geral',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
                Text(
                  utils.priceToCurrency(cartTotalPrice()),
                  style: TextStyle(
                    fontSize: 24,
                    color: CustomColors.customSwatchColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CustomElevatedButton(
                  text: 'Concluir Pedido',
                  onPressed: () async {
                    bool? result = await showOrderConfirmation();

                    if (result ?? false) {
                      showDialog(
                        context: context,
                        builder: (_) {
                          return PaymentDialog(order: app_data.orders.first);
                        },
                      );
                    } else {
                      utils.showToast(
                          message: 'Pedido não confirmado', isError: true);
                    }
                  },
                  primaryColor: CustomColors.customSwatchColor,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<bool?> showOrderConfirmation() {
    return showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Concluir pedido'),
            content: const Text('Deseja realmente concluir o pedido?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: const Text('Não'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: const Text('Sim'),
              ),
            ],
          );
        });
  }
}
