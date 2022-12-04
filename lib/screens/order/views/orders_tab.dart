import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:greengrocer/screens/order/controllers/all_orders_controllers.dart';
import 'package:greengrocer/screens/order/components/order_tile.dart';

class OrdersTab extends StatelessWidget {
  const OrdersTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pedidos'),
      ),
      body: GetBuilder<AllOrdersController>(
        builder: (controller) {
          return RefreshIndicator(
            onRefresh: () => controller.getAllOrders(),
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              physics: const AlwaysScrollableScrollPhysics(),
              itemBuilder: (_, index) => OrderTile(
                order: controller.allOrders[index],
              ),
              separatorBuilder: (_, index) => const SizedBox(height: 12),
              itemCount: controller.allOrders.length,
            ),
          );
        },
      ),
    );
  }
}
