import 'package:flutter/material.dart';

class Badge extends StatelessWidget {
  final int value;

  const Badge({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: value > 0,
      child: Container(
        alignment: Alignment.center,
        height: 18,
        width: 18,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          shape: BoxShape.circle,
        ),
        child: Text(
          value.toString(),
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
            fontSize: 10,
          ),
        ),
      ),
    );
  }
}
