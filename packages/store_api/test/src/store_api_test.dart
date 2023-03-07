// ignore_for_file: prefer_const_constructors
import 'package:store_api/store_api.dart';
import 'package:test/test.dart';

void main() {
  test('getProducts()', () async {
    final client = FakeStoreApiClient();
    var data = await client.getProducts();
    expect(data, isNotEmpty);
  });
}
