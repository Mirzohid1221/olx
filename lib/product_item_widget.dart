import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'Product_model.dart';

class ProductItemWidget extends StatefulWidget {
  final ProductModel product;
  final VoidCallback? onDelete;

  const ProductItemWidget({
    super.key,
    required this.product,
    required this.onDelete,
  });

  @override
  State<ProductItemWidget> createState() => _ProductItemWidgetState();
}

class _ProductItemWidgetState extends State<ProductItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 4, spreadRadius: 2),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child:
                widget.product.imageUrl != null &&
                        widget.product.imageUrl!.isNotEmpty
                    ? Image.network(
                      widget.product.imageUrl!,
                      height: 120,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          height: 120,
                          width: double.infinity,
                          color: Colors.grey.shade300,
                          alignment: Alignment.center,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(Icons.error, color: Colors.black, size: 40),
                              Text(
                                "Изображение по данной ссылке не найдено",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w200,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    )
                    : Container(
                      height: 120,
                      width: double.infinity,
                      color: Colors.grey.shade300,
                      alignment: Alignment.center,
                      child: Icon(Icons.image, color: Colors.grey, size: 40),
                    ),
          ),
          SizedBox(height: 8),
          Text(
            "Имя: ${widget.product.productName ?? 'Неизвестно'}",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text(
            widget.product.productPrice != null
                ? 'Цена: ${widget.product.productPrice} сум'
                : 'Цена: Не указана',
            style: TextStyle(color: Colors.black54),
          ),
          SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  widget.product.location != null
                      ? 'Локация: ${widget.product.location}'
                      : 'Локация: Не указана',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              // kIsWeb
              //     ? SizedBox()
              //     :
              IconButton(
                icon: Icon(
                  Icons.delete_outline,
                  color: Colors.redAccent,
                  size: 20,
                ),
                onPressed: () {
                  if (widget.onDelete != null) {
                    widget.onDelete!();
                  }
                },
                tooltip: 'Удалить',
                splashRadius: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
