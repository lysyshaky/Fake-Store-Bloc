import 'package:store_api/store_api.dart' hide Product;
import 'package:store_repository/src/models/product.dart';

/// {@template store_repository}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class StoreRepository {
  /// {@macro store_repository}
  StoreRepository({FakeStoreApiClient? storeApiClient})
      : _fakeStoreApiClient = storeApiClient ?? FakeStoreApiClient();

  final FakeStoreApiClient _fakeStoreApiClient;

  /// Gets list of products from the an api.
  Future<List<Product>> getProducts() async {
    final products = await _fakeStoreApiClient.getProducts();

    return products
        .map((e) =>Product.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
