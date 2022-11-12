import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_ecommerce_flutter/data/order.dart';
import 'package:nike_ecommerce_flutter/data/repo/order_repository.dart';
import 'package:nike_ecommerce_flutter/ui/receipt/payment_receipt.dart';
import 'package:nike_ecommerce_flutter/ui/shipping/bloc/shipping_bloc.dart';

import '../cart/price_info.dart';

class ShippigScreen extends StatefulWidget {
  final int payablePrice;
  final int totalPrice;
  final int shippingCost;

  const ShippigScreen(
      {super.key,
      required this.payablePrice,
      required this.totalPrice,
      required this.shippingCost});

  @override
  State<ShippigScreen> createState() => _ShippigScreenState();
}

class _ShippigScreenState extends State<ShippigScreen> {
  final TextEditingController firstNameController =
      TextEditingController(text: 'امیرحسین');

  final TextEditingController lastNameController =
      TextEditingController(text: 'زین الدینی');

  final TextEditingController phoneNumberController =
      TextEditingController(text: '09123456789');

  final TextEditingController postalCodeController =
      TextEditingController(text: '1234567890');

  final TextEditingController addressController =
      TextEditingController(text: 'سعادت آباد خیابان کوهستان مجتمع کوهستان');

  StreamSubscription? streamSubscription;

  @override
  void dispose() {
    streamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('انتخاب تحویل گیرنده و شیوه پرداخت'),
        centerTitle: false,
      ),
      body: BlocProvider<ShippingBloc>(
        create: (context) {
          final bloc = ShippingBloc(orderRepository);
          streamSubscription = bloc.stream.listen((event) {
            if (event is ShippingError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(event.appException.message),
                ),
              );
            } else if (event is ShippingSuccess) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => PaymentRecieptScreen(
                    orderId: event.result.orderId,
                  ),
                ),
              );
            }
          });
          return bloc;
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: firstNameController,
                decoration: const InputDecoration(label: Text('نام')),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: lastNameController,
                decoration: const InputDecoration(label: Text('نام خانوادگی')),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: phoneNumberController,
                decoration: const InputDecoration(label: Text('شماره تماس')),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: postalCodeController,
                decoration: const InputDecoration(label: Text('کد پستی')),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: addressController,
                decoration:
                    const InputDecoration(label: Text('آدرس تحویل گیرنده')),
              ),
              PriceInfo(
                payablePrice: widget.payablePrice,
                totalPrice: widget.totalPrice,
                shippingCost: widget.shippingCost,
              ),
              BlocBuilder<ShippingBloc, ShippingState>(
                builder: (context, state) {
                  return state is ShippingLoading
                      ? const Center(child: CupertinoActivityIndicator())
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            OutlinedButton(
                                onPressed: () {
                                  BlocProvider.of<ShippingBloc>(context).add(
                                    ShippingCreateOrder(
                                      CreateOrderParams(
                                        firstNameController.text,
                                        lastNameController.text,
                                        phoneNumberController.text,
                                        postalCodeController.text,
                                        addressController.text,
                                        PaymentMethod.cashOnDelivery,
                                      ),
                                    ),
                                  );
                                },
                                child: const Text('پرداخت در محل')),
                            ElevatedButton(
                                onPressed: () {},
                                child: const Text('پرداخت اینترنتی'))
                          ],
                        );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
