import 'package:flutter/material.dart';
import 'package:greengrocer/src/models/order_model.dart';
import 'package:greengrocer/src/services/utils_services.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PaymentDialog extends StatelessWidget {

  final OrderModel order;

  PaymentDialog({required this.order});

  final UtilsServices utilsServices = UtilsServices();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Conteúdo
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                // Titulo
               const Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'Pagamento com Pix',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18
                    ),
                  ),
                ),

                // QR Code
                QrImage(
                  data: "fslkjflskjfslkfjsl",
                  version: QrVersions.auto,
                  size: 200.0,
                ),

                // Vencimento
                Text(
                  'Vencimento ${utilsServices.formatDateTime(order.overdueDateTime)}',
                  style: const TextStyle(
                      fontSize: 12
                  ),
                ),

                // Total
                Text(
                  'Total: ${utilsServices.priceToCurrency(order.total)}',
                  style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold
                  ),
                ),

                // Botão de copia e cola
                OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)
                        ),
                        side: const BorderSide(
                            width: 2,
                            color: Colors.green
                        )
                    ),
                    onPressed: (){

                    },
                    icon: const Icon(
                        Icons.copy,
                        size: 15
                    ),
                    label: const Text(
                      'Copiar código Pix',
                      style: TextStyle(
                          fontSize: 13
                      ),
                    )
                )

              ],
            ),
          ),

          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              onPressed: (){
                  Navigator.of(context).pop();
              },
              icon: const Icon(Icons.close),
            ),
          )
        ],
      ),
    );
  }
}
