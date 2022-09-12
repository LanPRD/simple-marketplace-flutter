import 'package:flutter/material.dart';

import 'package:greengrocer/src/models/product.dart';

import 'package:greengrocer/src/screens/product_screen.dart';

import 'package:greengrocer/src/theme/custom_colors.dart';

import 'package:greengrocer/src/utils/utils.dart';

class ItemTile extends StatelessWidget {
  final Product product;
  final void Function(GlobalKey) cartAnimationMethod;
  final GlobalKey imageGk = GlobalKey();

  ItemTile({
    Key? key,
    required this.product,
    required this.cartAnimationMethod,
  }) : super(key: key);

  final Utils utils = Utils();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (c) {
              return ProductScreen(product: product);
            }));
          },
          child: Card(
            elevation: 1,
            shadowColor: Colors.grey.shade300,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Imagem
                  Expanded(
                    child: Hero(
                      tag: product.imageUrl,
                      child: Image.asset(product.imageUrl, key: imageGk),
                    ),
                  ),

                  // Nome
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  // Preco
                  Row(
                    children: [
                      Text(
                        utils.priceToCurrency(product.price),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: CustomColors.customSwatchColor,
                        ),
                      ),
                      Text(
                        '/${product.unit}',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),

        // Botao add carrinho
        Positioned(
          top: 4,
          right: 4,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              topRight: Radius.circular(8),
            ),
            child: Material(
              child: InkWell(
                onTap: () {
                  cartAnimationMethod(imageGk);
                },
                child: Ink(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: CustomColors.customSwatchColor,
                  ),
                  child: const Icon(
                    Icons.add_shopping_cart_outlined,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
