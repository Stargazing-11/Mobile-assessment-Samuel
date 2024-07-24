import 'package:flutter_assessment/models/cart.dart';
import 'package:flutter_assessment/models/product/product.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Cart', () {
    late Cart cart;
    late Product product;

    setUp(() {
      cart = Cart();
      product = const Product(
        id: 1,
        title: 'Test Product',
        price: 10.0,
        description: 'this is test product',
      );
    });
    
    test('should add an item to the cart', () {
      cart.addItem(product: product);

      expect(cart.itemCount, 1);
      expect(cart.totalAmount, 10.0);
    });
  });
}
