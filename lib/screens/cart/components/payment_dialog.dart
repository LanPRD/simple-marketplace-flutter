import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';

import 'package:greengrocer/models/order.dart';

import 'package:greengrocer/widgets/common/custom_outlined_button_with_icon.dart';

import 'package:greengrocer/utils/utils.dart';

class PaymentDialog extends StatelessWidget {
  final Order order;

  PaymentDialog({
    Key? key,
    required this.order,
  }) : super(key: key);

  final Utils utils = Utils();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Conteudo
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Titulo
                const Text(
                  'Pagamento com PIX',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),

                // QR Code
                Image.memory(
                  utils.decodeQrCodeImage(order.qrCodeImage),
                  height: 200,
                  width: 200,
                ),

                // Vencimento
                Text(
                  'Vencimento: ${utils.formatDateTime(order.expiredAt)}',
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),

                // Total
                Text(
                  'Total: ${utils.priceToCurrency(order.total)}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 20),

                // Botao copia e cola
                CustomOutlinedButtonWithIcon(
                  icon: const Icon(Icons.copy, size: 20),
                  onPressed: () async {
                    await FlutterClipboard.copy(order.copyAndPaste);
                    utils.showToast(message: 'Código copiado');
                  },
                  textButton: 'Copiar código PIX',
                ),
              ],
            ),
          ),

          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.close),
            ),
          ),
        ],
      ),
    );
  }
}
