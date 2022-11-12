import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:nike_ecommerce_flutter/data/repo/auth_repository.dart';
import 'package:nike_ecommerce_flutter/data/repo/cart_repository.dart';
import 'package:nike_ecommerce_flutter/theme.dart';
import 'package:nike_ecommerce_flutter/ui/auth/auth.dart';
import 'package:nike_ecommerce_flutter/ui/cart/bloc/cart_bloc.dart';
import 'package:nike_ecommerce_flutter/ui/cart/cart_item.dart';
import 'package:nike_ecommerce_flutter/ui/cart/price_info.dart';
import 'package:nike_ecommerce_flutter/ui/shipping/shipping.dart';
import 'package:nike_ecommerce_flutter/ui/widgets/empty_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool stateIsSuccess = false;
  StreamSubscription? stateStreamSubscription;
  final RefreshController _refreshController = RefreshController();
  CartBloc? cartBloc;

  @override
  void initState() {
    super.initState();
    AuthRepository.authChangeNotifier.addListener(authChangeNotifierListener);
  }

  @override
  void dispose() {
    AuthRepository.authChangeNotifier
        .removeListener(authChangeNotifierListener);
    cartBloc?.close();
    stateStreamSubscription?.cancel();
    super.dispose();
  }

  void authChangeNotifierListener() {
    cartBloc?.add(CartAuthInfoChanged(AuthRepository.authChangeNotifier.value));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Visibility(
        visible: stateIsSuccess,
        child: Container(
          margin: const EdgeInsets.only(left: 48, right: 48),
          width: MediaQuery.of(context).size.width,
          child: FloatingActionButton.extended(
              onPressed: () {
                final state = cartBloc!.state;
                if (state is CartSuccess) {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ShippigScreen(
                      payablePrice: state.cartResponse.payablePrice,
                      shippingCost: state.cartResponse.shippingCost,
                      totalPrice: state.cartResponse.totalPrice,
                    ),
                  ));
                }
              },
              label: const Text('پرداخت')),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: LightThemeColors.surfaceVarientColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('سبد خرید'),
      ),
      body: BlocProvider<CartBloc>(
        create: (context) {
          final bloc = CartBloc(cartRepository);
          cartBloc = bloc;
          stateStreamSubscription = bloc.stream.listen((state) {
            setState(() {
              stateIsSuccess = state is CartSuccess;
            });

            if (_refreshController.isRefresh) {
              if (state is CartSuccess) {
                _refreshController.refreshCompleted();
              } else if (state is CartError) {
                Center(child: Text(state.exception.message));
              }
            }
          });
          bloc.add(CartStarted(AuthRepository.authChangeNotifier.value));
          return bloc;
        },
        child: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartLoading) {
              return const Center(child: CupertinoActivityIndicator());
            } else if (state is CartError) {
              return Center(
                child: Text(state.exception.message),
              );
            } else if (state is CartSuccess) {
              return SmartRefresher(
                header: const ClassicHeader(
                  completeText: 'با موفقیت انجام شد',
                  refreshingText: 'در حال بروزرسانی',
                  idleText: 'برای بروزرسانی به پایین بکشید',
                  releaseText: 'رها کنید',
                  failedText: 'خطای نامشخص',
                  spacing: 2,
                ),
                controller: _refreshController,
                onRefresh: () {
                  cartBloc?.add(
                    CartStarted(AuthRepository.authChangeNotifier.value,
                        isRefreshing: true),
                  );
                },
                child: ListView.builder(
                  padding: const EdgeInsets.only(bottom: 80),
                  itemBuilder: (context, index) {
                    if (index < state.cartResponse.cartItems.length) {
                      final data = state.cartResponse.cartItems[index];

                      return CartItem(
                        data: data,
                        onDeleteButtonClicked: () {
                          cartBloc?.add(CartDeleteButtonClicked(data.id));
                        },
                        onIncreaseButtonClick: () {
                          if (data.count < 5) {
                            cartBloc
                                ?.add(CartIncreaseCountButtonClicked(data.id));
                          }
                        },
                        onDecreaseButtonClick: () {
                          if (data.count > 1) {
                            cartBloc
                                ?.add(CartDecreaseCountButtonClicked(data.id));
                          }
                        },
                      );
                    } else {
                      return PriceInfo(
                        payablePrice: state.cartResponse.payablePrice,
                        shippingCost: state.cartResponse.shippingCost,
                        totalPrice: state.cartResponse.totalPrice,
                      );
                    }
                  },
                  itemCount: state.cartResponse.cartItems.length + 1,
                ),
              );
            } else if (state is CartAuthRequired) {
              return EmptyView(
                message: ' برای مشاهده ی سبد خرید ابتدا وارد حساب خود شوید',
                callToAction: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const AuthScreen()));
                  },
                  child: const Text('ورود به حساب کاربری'),
                ),
                image: SvgPicture.asset(
                  'assets/img/auth_required.svg',
                  width: 140,
                ),
              );
            } else if (state is CartEmpty) {
              return EmptyView(
                message: "تاکنون هیچ محصولی به سبد خرید خود اضافه نکردید",
                image:
                    SvgPicture.asset('assets/img/empty_cart.svg', width: 200),
              );
            } else {
              throw Exception('current cart state is not valid');
            }
          },
        ),
      ),
    );
  }
}
