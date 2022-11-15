import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike_ecommerce_flutter/data/repo/auth_repository.dart';
import 'package:nike_ecommerce_flutter/data/repo/cart_repository.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('پروفایل'),
        actions: [
          IconButton(
              onPressed: () {
                CartRepository.cartItemCountNotifier.value = 0;
                authRepository.signOut();
              },
              icon: Icon(Icons.exit_to_app))
        ],
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 24, bottom: 16),
              padding: const EdgeInsets.all(4),
              height: 65,
              width: 65,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Theme.of(context).dividerColor),
              ),
              child: Image.asset('assets/img/nike_logo.png'),
            ),
            const Text('amirhpz2000@gmail.com'),
            const SizedBox(height: 32),
            const Divider(),
            InkWell(
              onTap: () {},
              child: Container(
                height: 56,
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
              onTap: () {},
              child: Container(
                height: 56,
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
          ],
        ),
      ),
    );
  }
}
