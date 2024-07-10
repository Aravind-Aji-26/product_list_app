import 'package:flutter/material.dart';
import 'package:product_list_app/app/app.router.dart';
import 'package:product_list_app/app/utils.dart';
import 'package:product_list_app/model/product_model.dart';
import 'package:product_list_app/ui/common/custom_cached_image.dart';

import '../../../../constants/ui_helpers.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navigationService.navigateToProductDetailView(product: product);
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomCachedNetworkImage(imageUrl: product.images?.first ?? ''),
              height_10,
              Text(
                product.title ?? '',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              height_10,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Category : ${product.category}',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        'Price : ${product.price}',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  Image.asset(
                    "assets/images/heart.png",
                    height: 20,
                    width: 20,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
