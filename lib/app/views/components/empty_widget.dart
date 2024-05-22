import 'package:flutter/material.dart';
import 'package:tractian_tree/app/views/tools/context_extension.dart';

class EmptyWidget extends StatelessWidget {
  final String message;
  final IconData? icon;
  final double? heigth;
  final double? width;
  final Color? backgroundColor;
  final double? iconSize;
  final Color? color;
  final TextStyle? textStyle;
  const EmptyWidget(
      {super.key,
      required this.message,
      this.icon,
      this.heigth,
      this.width,
      this.backgroundColor,
      this.iconSize,
      this.color,
      this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: heigth ?? context.heigth,
      width: width ?? context.width,
      color: backgroundColor ?? context.colors.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon ?? Icons.info,
            color: color ?? context.colors.background.withOpacity(0.7),
            size: iconSize ?? 50,
          ),
          Text(
            message,
            style: textStyle ??
                TextStyle(
                    color: color ?? context.colors.background.withOpacity(0.7),
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
