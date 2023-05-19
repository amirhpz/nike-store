import 'package:nike_ecommerce_flutter/data/common/http_client.dart';
import 'package:nike_ecommerce_flutter/data/order.dart';
import 'package:nike_ecommerce_flutter/data/payment_receipt.dart';
import 'package:nike_ecommerce_flutter/data/source/order_data_source.dart';

final orderRepository = OrderRepository(OrderRemoteDataSource(httpClient));

abstract class IOrderRepository extends IOrderDataSourse {}

class OrderRepository implements IOrderRepository {
  final IOrderDataSourse orderdataSourse;

  OrderRepository(this.orderdataSourse);

  @override
  Future<CreateOrderResult> create(CreateOrderParams params) {
    return orderdataSourse.create(params);
  }

  @override
  Future<PaymentReceiptData> getPaymentReceipt(int orderId) {
    return orderdataSourse.getPaymentReceipt(orderId);
  }

  @override
  Future<List<OrderEntity>> getOrders() {
    return orderdataSourse.getOrders();
  }
}
