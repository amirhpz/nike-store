import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nike_ecommerce_flutter/common/utils.dart';
import 'package:nike_ecommerce_flutter/data/favorite_manager.dart';
import 'package:nike_ecommerce_flutter/data/product.dart';
import 'package:nike_ecommerce_flutter/theme.dart';
import 'package:nike_ecommerce_flutter/ui/product/detail.dart';
import 'package:nike_ecommerce_flutter/ui/widgets/image.dart';

class FavoritesListScreen extends StatelessWidget {
  const FavoritesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('لیست علاقه مندی ها')),
      body: ValueListenableBuilder<Box<ProductEntity>>(
          valueListenable: favoriteManager.listenable,
          builder: (context, box, child) {
            final products = box.values.toList();
            return ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return Padding(
                    padding: const EdgeInsets.all(8),
                    child: InkWell(
                      onLongPress: () {
                        favoriteManager.deleteRavorite(product);
                        favoriteManager.isFovorite(product);
                      },
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              ProductDetailScreen(product: product),
                        ));
                      },
                      child: Row(
                        children: [
                          SizedBox(
                            width: 110,
                            height: 110,
                            child: ImageLoadingService(
                              imageUrl: products[index].imageUrl,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.title,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .apply(
                                          fontSizeFactor: 0.9,
                                          color: LightThemeColors
                                              .primaryTextColor),
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  product.previousPrice.withPriceLabel,
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .apply(
                                          decoration:
                                              TextDecoration.lineThrough),
                                ),
                                const SizedBox(height: 4),
                                Text(product.price.withPriceLabel),
                              ],
                            ),
                          ))
                        ],
                      ),
                    ),
                  );
                });
          }),
    );
  }
}
