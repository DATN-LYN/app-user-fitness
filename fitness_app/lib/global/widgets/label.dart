import 'package:flutter/material.dart';

import '../themes/app_colors.dart';

class Label extends StatelessWidget {
  const Label(
    this.data, {
    Key? key,
    this.isRequired = false,
    this.padding = const EdgeInsets.only(bottom: 8, top: 16),
  }) : super(key: key);

  final String data;
  final bool isRequired;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Text.rich(
        TextSpan(
          text: data,
          style: const TextStyle(fontWeight: FontWeight.w600),
          children: [
            TextSpan(
              text: isRequired ? ' *' : '',
              style: const TextStyle(color: AppColors.error),
            ),
          ],
        ),
      ),
    );
  }
}
