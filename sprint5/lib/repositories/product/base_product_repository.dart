import '../../Page/models/models.dart';

abstract class BaseProductRepository {
  Stream<List<Product>> getAllProducts();
}
