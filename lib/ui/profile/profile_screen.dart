import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike_ecommerce_flutter/data/auth_info.dart';
import 'package:nike_ecommerce_flutter/data/repo/auth_repository.dart';
import 'package:nike_ecommerce_flutter/data/repo/cart_repository.dart';
import 'package:nike_ecommerce_flutter/ui/auth/auth.dart';
import 'package:nike_ecommerce_flutter/ui/favorites/favorite_screen.dart';
import 'package:nike_ecommerce_flutter/ui/order/order_history_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'پروفایل',
          style:
              Theme.of(context).textTheme.headline6!.apply(fontSizeFactor: 1.2),
        ),
      ),
      body: ValueListenableBuilder<AuthInfo?>(
          valueListenable: AuthRepository.authChangeNotifier,
          builder: (context, authInfo, child) {
            final isLogin = authInfo != null && authInfo.accessToken.isNotEmpty
                ? true
                : false;
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 16, bottom: 16),
                    padding: const EdgeInsets.all(4),
                    height: 65,
                    width: 65,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Theme.of(context).dividerColor),
                    ),
                    child: Image.asset('assets/img/nike_logo.png'),
                  ),
                  Text(isLogin ? authInfo.email : 'کاربر میهمان'),
                  const SizedBox(height: 32),
                  const Divider(),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const FavoritesListScreen(),
                        ),
                      );
                    },
                    child: Container(
                      height: 36,
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: Row(
                        children: const [
                          Icon(CupertinoIcons.heart),
                          SizedBox(width: 8),
                          Text('لیست علاقه مندی ها'),
                        ],
                      ),
                    ),
                  ),
                  const Divider(),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const OrderHistoryScreen(),
                        ),
                      );
                    },
                    child: Container(
                      height: 36,
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: Row(
                        children: const [
                          Icon(CupertinoIcons.cart),
                          SizedBox(width: 8),
                          Text('سوابق سفارش'),
                        ],
                      ),
                    ),
                  ),
                  const Divider(),
                  InkWell(
                    onTap: () {
                      if (isLogin) {
                        showDialog(
                          useRootNavigator: true,
                          context: context,
                          builder: (context) {
                            return Directionality(
                              textDirection: TextDirection.rtl,
                              child: AlertDialog(
                                title: const Text('خروج از حساب کاربری'),
                                content: const Text(
                                    'آیا می خواهید از حساب خود خارج شوید؟'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('خیر'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      CartRepository
                                          .cartItemCountNotifier.value = 0;
                                      authRepository.signOut();
                                    },
                                    child: const Text('بله'),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      } else {
                        Navigator.of(context, rootNavigator: true).push(
                          MaterialPageRoute(
                            builder: (context) => const AuthScreen(),
                          ),
                        );
                      }
                    },
                    child: Container(
                      height: 36,
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: Row(
                        children: [
                          isLogin
                              ? const Icon(CupertinoIcons.arrow_right_square)
                              : const Icon(CupertinoIcons.arrow_left_square),
                          const SizedBox(width: 8),
                          isLogin
                              ? const Text('خروج از حساب کاربری')
                              : const Text('ورود به حساب کاربری'),
                        ],
                      ),
                    ),
                  ),
                  const Divider(),
                ],
              ),
            );
          }),
    );
  }
}
