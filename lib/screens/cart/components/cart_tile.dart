import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:greengrocer/models/cart_product.dart';
import 'package:greengrocer/screens/cart/controllers/cart_controller.dart';

import 'package:greengrocer/widgets/quantity_control.dart';

import 'package:greengrocer/theme/custom_colors.dart';

import 'package:greengrocer/utils/utils.dart';

class CartTile extends StatefulWidget {
  final CartProduct cartProduct;

  const CartTile({Key? key, required this.cartProduct}) : super(key: key);

  @override
  State<CartTile> createState() => _CartTileState();
}

class _CartTileState extends State<CartTile> {
  final Utils utils = Utils();

  final controller = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        // Imagem
        leading: Image.network(
          widget.cartProduct.product.imageUrl,
          height: 60,
          width: 60,
        ),

        // Titulo
        title: Text(
          widget.cartProduct.product.itemName,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),

        // Total
        subtitle: Text(
          utils.priceToCurrency(widget.cartProduct.totalPrice()),
          style: TextStyle(
            color: CustomColors.customSwatchColor,
            fontWeight: FontWeight.bold,
          ),
        ),

        // Quantidade
        trailing: QuantityControl(
          value: widget.cartProduct.quantity,
          suffixText: widget.cartProduct.product.unit,
          result: (quantity) {
            controller.changeItemQuantity(
              cartProducts: widget.cartProduct,
              quantity: quantity,
            );
          },
          isRemovable: true,
        ),
      ),
    );
  }
}
