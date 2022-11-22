import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:add_to_cart_animation/add_to_cart_icon.dart';
import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:badges/badges.dart';

import 'package:greengrocer/screens/home/controllers/home_controller.dart';

import 'package:greengrocer/widgets/app_name.dart';

import 'package:greengrocer/screens/home/components/category_tile.dart';
import 'package:greengrocer/screens/home/components/custom_shimmer.dart';
import 'package:greengrocer/screens/home/components/item_tile.dart';

import 'package:greengrocer/theme/custom_colors.dart';
import 'package:greengrocer/utils/utils.dart';

import 'package:greengrocer/utils/app_data.dart' as app_data;

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  String selectedCategory = 'Frutas';

  GlobalKey<CartIconKey> globalKeyCartItems = GlobalKey<CartIconKey>();

  late Function(GlobalKey) runAddToCardAnimation;

  void itemSelectedCArtAnimations(GlobalKey gkImage) {
    runAddToCardAnimation(gkImage);
  }

  final Utils utils = Utils();

  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    Get.find<HomeController>();

    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const AppNameWidget(),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: GestureDetector(
              onTap: () {},
              child: Badge(
                badgeColor: CustomColors.customContrastColor,
                badgeContent: const Text(
                  '2',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                ),
                child: AddToCartIcon(
                  key: globalKeyCartItems,
                  icon: Icon(
                    Icons.shopping_cart,
                    color: CustomColors.customSwatchColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: AddToCartAnimation(
        gkCart: globalKeyCartItems,
        receiveCreateAddToCardAnimationMethod: (addToCardAnimationMethod) {
          runAddToCardAnimation = addToCardAnimationMethod;
        },
        previewDuration: const Duration(milliseconds: 100),
        previewCurve: Curves.ease,
        child: Column(
          children: [
            // Campo de pesquisa
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              child: TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  isDense: true,
                  hintText: 'Pesquise aqui...',
                  hintStyle: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 14,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: CustomColors.customContrastColor,
                    size: 24,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                ),
              ),
            ),

            // Categorias
            Container(
              padding: const EdgeInsets.only(left: 20),
              child: SizedBox(
                height: 40,
                child: !isLoading
                    ? ListView.separated(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (_, index) {
                          return CategoryTile(
                            category: app_data.categories[index],
                            isSelected:
                                app_data.categories[index] == selectedCategory,
                            onPressed: () {
                              setState(() {
                                selectedCategory = app_data.categories[index];
                              });
                            },
                          );
                        },
                        separatorBuilder: (_, index) =>
                            const SizedBox(width: 10),
                        itemCount: app_data.categories.length,
                      )
                    : ListView(
                        scrollDirection: Axis.horizontal,
                        children: List.generate(
                          10,
                          (index) => Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(right: 10),
                            child: CustomShimmer(
                              height: 32,
                              width: 80,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
              ),
            ),

            // Grid
            Expanded(
              child: !isLoading
                  ? GridView.builder(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
                      physics: const BouncingScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 9 / 11.5,
                      ),
                      itemCount: app_data.items.length,
                      itemBuilder: (_, index) {
                        return ItemTile(
                          product: app_data.items[index],
                          cartAnimationMethod: itemSelectedCArtAnimations,
                        );
                      },
                    )
                  : GridView.count(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
                      physics: const BouncingScrollPhysics(),
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 9 / 11.5,
                      children: List.generate(
                        10,
                        (_) => CustomShimmer(
                          height: double.infinity,
                          width: double.infinity,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
