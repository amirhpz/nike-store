import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike_ecommerce_flutter/data/repo/auth_repository.dart';
import 'package:nike_ecommerce_flutter/data/repo/cart_repository.dart';
import 'package:nike_ecommerce_flutter/ui/cart/cart.dart';
import 'package:nike_ecommerce_flutter/ui/home/home.dart';
import 'package:nike_ecommerce_flutter/ui/profile/profile_screen.dart';
import 'package:nike_ecommerce_flutter/ui/widgets/badge.dart';

const int homeIndex = 0;
const int cartIndex = 1;
const int profileIndex = 2;

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int selectedScreenIndex = homeIndex;
  final List<int> _history = [];

  final GlobalKey<NavigatorState> _homeKey = GlobalKey();
  final GlobalKey<NavigatorState> _cartKey = GlobalKey();
  final GlobalKey<NavigatorState> _profileKey = GlobalKey();

  late final map = {
    homeIndex: _homeKey,
    cartIndex: _cartKey,
    profileIndex: _profileKey,
  };

  Future<bool> _onWillPop() async {
    final NavigatorState currentSelectedTabNavigatorState =
        map[selectedScreenIndex]!.currentState!;
    if (currentSelectedTabNavigatorState.canPop()) {
      currentSelectedTabNavigatorState.pop();
      return false;
    } else if (_history.isNotEmpty) {
      setState(
        () {
          selectedScreenIndex = _history.last;
          _history.removeLast();
        },
      );
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          body: IndexedStack(
            index: selectedScreenIndex,
            children: [
              _Navigator(_homeKey, homeIndex, const HomeScreen()),
              _Navigator(_cartKey, cartIndex, const CartScreen()),
              _Navigator(_profileKey, profileIndex, ProfileScreen()),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: selectedScreenIndex,
            onTap: (selectedIndex) {
              setState(() {
                _history.remove(selectedScreenIndex);
                _history.add(selectedScreenIndex);
                selectedScreenIndex = selectedIndex;
              });
            },
            items: [
              const BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.home), label: 'خانه'),
              BottomNavigationBarItem(
                  icon: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      const Icon(CupertinoIcons.cart),
                      Positioned(
                        right: -10,
                        top: -4,
                        child: ValueListenableBuilder<int>(
                          valueListenable: CartRepository.cartItemCountNotifier,
                          builder: (context, value, child) {
                            return Badge(value: value);
                          },
                        ),
                      ),
                    ],
                  ),
                  label: 'سبد خرید'),
              const BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.profile_circled), label: 'پروفایل'),
            ],
          ),
        ));
  }

  // ignore: non_constant_identifier_names
  Widget _Navigator(GlobalKey key, int index, Widget child) {
    return key.currentState == null && selectedScreenIndex != index
        ? Container()
        : Navigator(
            key: key,
            onGenerateRoute: (settings) => MaterialPageRoute(
              builder: ((context) => Offstage(
                    offstage: selectedScreenIndex != index,
                    child: child,
                  )),
            ),
          );
  }

  @override
  void initState() {
    cartRepository.count();
    super.initState();
  }
}
