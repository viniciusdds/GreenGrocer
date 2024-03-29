import 'package:flutter/material.dart';
import 'package:greengrocer/src/config/custom_colors.dart';
import 'package:greengrocer/src/models/item_model.dart';
import 'package:greengrocer/src/pages/product/product_screen.dart';
import 'package:greengrocer/src/services/utils_services.dart';

class ItemTile extends StatefulWidget {

  final ItemModel item;
  final void Function(GlobalKey) cartAnimationMethod;

  ItemTile({
    required this.item,
    required this.cartAnimationMethod
  });

  @override
  State<ItemTile> createState() => _ItemTileState();
}

class _ItemTileState extends State<ItemTile> {
  final GlobalKey imageGk = GlobalKey();

  UtilsServices utilsServices = UtilsServices();

  IconData titleIcon = Icons.add_shopping_cart_outlined;

  Future<void> switchIcon() async {
    setState(() =>  titleIcon = Icons.check);
    await Future.delayed(const Duration(milliseconds: 1500));
    setState(() =>  titleIcon = Icons.add_shopping_cart_outlined);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [

        // Conteúdo
        GestureDetector(
          onTap: (){
            Navigator.of(context).push(
              MaterialPageRoute(builder: (c) {
                return ProductScreen(
                  item: widget.item,
                );
              })
            );
          },
          child: Card(
            elevation: 3,
            shadowColor: Colors.grey.shade300,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Imagem
                  Expanded(
                      child: Hero(
                          tag: widget.item.imgUrl,
                          child: Image.network(
                              widget.item.imgUrl,
                              key: imageGk
                          )
                      )
                  ),

                  // Nome
                  Text(
                    widget.item.itemName,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                    ),
                  ),

                  // Preço - Unidade
                  Row(
                    children: [
                      Text(
                        utilsServices.priceToCurrency(widget.item.price),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: CustomColors.customSwatchColor
                        ),
                      ),
                      Text(
                        '/${widget.item.unit}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Colors.grey.shade500
                        ),
                      ),
                    ],
                  )

                ],
              ),
            ),
          ),
        ),

        // Botão add carrinho
        Positioned(
          top: 4,
          right: 4,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(15),
                topRight: Radius.circular(20)
            ),
            child: Material(
              child: InkWell(
                onTap: (){
                    switchIcon();
                    widget.cartAnimationMethod(imageGk);
                },
                child: Ink(
                  height: 40,
                  width: 35,
                  decoration: BoxDecoration(
                    color: CustomColors.customSwatchColor,

                  ),
                  child: Icon(
                      titleIcon,
                      color: Colors.white,
                      size: 20,
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
