import 'package:flutter/material.dart';

import 'package:greengrocer/src/models/cart_product.dart';

import 'package:greengrocer/src/widgets/quantity_control.dart';

import 'package:greengrocer/src/theme/custom_colors.dart';

import 'package:greengrocer/src/utils/utils.dart';

class CartTile extends StatefulWidget {
  final CartProduct cartProduct;
  final Function(int) updatedQuantity;

  const CartTile({
    Key? key,
    required this.cartProduct,
    required this.updatedQuantity,
  }) : super(key: key);

  @override
  State<CartTile> createState() => _CartTileState();
}

class _CartTileState extends State<CartTile> {
  final Utils utils = Utils();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        // Imagem
        leading: Image.asset(
          widget.cartProduct.product.imageUrl,
          height: 60,
          width: 60,
        ),

        // Titulo
        title: Text(
          widget.cartProduct.product.name,
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
          result: widget.updatedQuantity,
          isRemovable: true,
        ),
      ),
    );
  }
}
