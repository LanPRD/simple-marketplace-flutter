import 'package:flutter/material.dart';

import 'package:greengrocer/src/widgets/order_tile.dart';

import 'package:greengrocer/src/utils/app_data.dart' as app_data;

class OrdersTab extends StatelessWidget {
  const OrdersTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pedidos'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        physics: const BouncingScrollPhysics(),
        itemBuilder: (_, index) => OrderTile(order: app_data.orders[index]),
        separatorBuilder: (_, index) => const SizedBox(height: 12),
        itemCount: app_data.orders.length,
      ),
    );
  }
}
