import 'package:flutter/material.dart';

class EmptyView extends StatelessWidget {
  final String message;
  final Widget? callToAction;
  final Widget image;

  const EmptyView(
      {super.key,
      required this.message,
      this.callToAction,
      required this.image});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          image,
          const SizedBox(height: 40),
          Text(
            message,
            style: Theme.of(context).textTheme.headline6,
          ),
          const SizedBox(height: 30),
          if (callToAction != null) callToAction!
        ]),
      ),
    );
  }
}
