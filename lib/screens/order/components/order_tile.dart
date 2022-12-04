import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:greengrocer/models/order.dart';
import 'package:greengrocer/models/cart_product.dart';
import 'package:greengrocer/screens/order/controllers/order_controller.dart';

import 'package:greengrocer/widgets/common/custom_elevated_button_with_icon.dart';
import 'package:greengrocer/widgets/order_status.dart';
import 'package:greengrocer/screens/cart/components/payment_dialog.dart';

import 'package:greengrocer/utils/utils.dart';

class OrderTile extends StatelessWidget {
  final Order order;

  OrderTile({
    Key? key,
    required this.order,
  }) : super(key: key);

  final Utils utils = Utils();

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: GetBuilder<OrderController>(
          init: OrderController(order),
          global: false,
          builder: (controller) {
            return ExpansionTile(
              // initiallyExpanded: order.status == 'pending_payment',
              onExpansionChanged: (value) {
                if (value && order.items.isEmpty) {
                  controller.getOrderItems();
                }
              },
              title: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Nº do pedido: ${order.id}'),
                  Text(
                    utils.formatDateTime(order.createdAt!),
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
              children: controller.isLoading
                  ? [
                      Container(
                        height: 80,
                        alignment: Alignment.center,
                        child: const CircularProgressIndicator(),
                      )
                    ]
                  : [
                      IntrinsicHeight(
                        child: Row(
                          children: [
                            // Lista de produtos
                            Expanded(
                              flex: 3,
                              child: SizedBox(
                                height: 140,
                                child: ListView(
                                  children:
                                      controller.order.items.map((orderItem) {
                                    return _OrderItemWidget(
                                      utils: utils,
                                      orderItem: orderItem,
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),

                            // Divisor
                            VerticalDivider(
                              color: Colors.grey.shade300,
                              thickness: 2,
                            ),

                            // Status do pedido
                            Expanded(
                              flex: 2,
                              child: OrderStatus(
                                isExpired: order.expiredAt.isBefore(
                                  DateTime.now(),
                                ),
                                status: order.status,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 8),

                      // Total
                      Text.rich(
                        TextSpan(
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                          children: [
                            const TextSpan(
                              text: 'Total: ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: utils.priceToCurrency(order.total),
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Botao de pagamento
                      Visibility(
                        visible: order.status == 'pending_payment' &&
                            !order.isOverDue,
                        child: CustomElevatedButtonWithIcon(
                          icon: Image.asset(
                            'assets/app_images/pix.png',
                            height: 20,
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (_) {
                                return PaymentDialog(order: order);
                              },
                            );
                          },
                          text: 'Ver QR Code Pix',
                        ),
                      ),
                    ],
            );
          },
        ),
      ),
    );
  }
}

class _OrderItemWidget extends StatelessWidget {
  final CartProduct orderItem;
  final Utils utils;

  const _OrderItemWidget({
    Key? key,
    required this.utils,
    required this.orderItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Text(
            '${orderItem.quantity} ${orderItem.product.unit} - ',
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          Expanded(child: Text(orderItem.product.itemName)),
          Text(utils.priceToCurrency(orderItem.totalPrice())),
        ],
      ),
    );
  }
}
