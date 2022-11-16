import 'package:hive_flutter/hive_flutter.dart';
import 'package:nike_ecommerce_flutter/data/product.dart';

final favoriteManager = FavoriteManager();

class FavoriteManager {
  static const _boxName = 'favorites';
  final _box = Hive.box(_boxName);

  static init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(ProductEntityAdapter());
    Hive.openBox(_boxName);
  }

  void addFavorite(ProductEntity product) {
    _box.put(product.id, product);
  }

  void deleteRavorite(ProductEntity product) {
    _box.delete(product.id);
  }

  List get favorites => _box.values.toList();

  bool isFovorite(ProductEntity product) {
    return _box.containsKey(product.id);
  }
}
