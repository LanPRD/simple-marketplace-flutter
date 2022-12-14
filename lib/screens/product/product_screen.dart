import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:greengrocer/models/product.dart';
import 'package:greengrocer/screens/base/controllers/navigation_controller.dart';
import 'package:greengrocer/screens/cart/controllers/cart_controller.dart';

import 'package:greengrocer/widgets/common/custom_elevated_button_with_icon.dart';
import 'package:greengrocer/widgets/quantity_control.dart';

import 'package:greengrocer/theme/custom_colors.dart';

import 'package:greengrocer/utils/utils.dart';

class ProductScreen extends StatefulWidget {
  ProductScreen({Key? key}) : super(key: key);

  final Product product = Get.arguments;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final Utils utils = Utils();
  int carItemQuantity = 1;

  final navigationController = Get.find<NavigationController>();
  final cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withAlpha(230),
      body: Stack(
        children: [
          Column(
            children: [
              // Imagem
              Expanded(
                child: Hero(
                  tag: widget.product.imageUrl,
                  child: Image.network(widget.product.imageUrl),
                ),
              ),

              // Infos
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(32),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade200,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Nome - quantidade
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              widget.product.itemName,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          QuantityControl(
                            suffixText: widget.product.unit,
                            value: carItemQuantity,
                            result: (int quantity) {
                              setState(() {
                                carItemQuantity = quantity;
                              });
                            },
                          ),
                        ],
                      ),

                      // Preco
                      Text(
                        utils.priceToCurrency(widget.product.price),
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: CustomColors.customSwatchColor,
                        ),
                      ),

                      // Descricao
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Text(
                              widget.product.description,
                              textAlign: TextAlign.justify,
                              style: const TextStyle(
                                height: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Botao
                      CustomElevatedButtonWithIcon(
                        onPressed: () {
                          Get.back();
                          cartController.addItemToCart(
                            product: widget.product,
                            quantity: carItemQuantity,
                          );
                          navigationController
                              .navigatePageview(NavigationTabs.cart);
                        },
                        text: "Adicionar ao carrinho",
                        icon: Icons.shopping_cart_outlined,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 8,
            left: 8,
            child: SafeArea(
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
