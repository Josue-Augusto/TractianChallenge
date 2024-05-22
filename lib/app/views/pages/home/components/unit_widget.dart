import 'package:flutter/material.dart';
import 'package:tractian_tree/app/views/style/style.dart';
import 'package:tractian_tree/app/views/tools/context_extension.dart';

class UnitWidget extends StatelessWidget {
  final int index;
  final String name;
  final void Function()? onTap;
  const UnitWidget(
      {super.key, required this.index, required this.name, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
      child: InkWell(
        onTap: onTap,
        child: Material(
          elevation: 6.0,
          shape: shape(),
          child: Container(
            width: context.width * 0.4,
            decoration: BoxDecoration(
              borderRadius: radius(),
              color: index == 0
                  ? context.colors.secondary
                  : context.colors.onBackground,
            ),
            child: Stack(
              children: [
                Positioned(
                  left: 10.0,
                  bottom: 16.0,
                  child: Text('$name\nUnit',
                      style: textStyle(
                        colors: index == 0
                            ? context.colors.onPrimary
                            : context.colors.secondary,
                      )),
                ),
                Positioned(
                  top: 16.0,
                  left: 10.0,
                  child: Icon(
                    Icons.apartment_rounded,
                    size: 32.0,
                    color: index == 0
                        ? context.colors.onPrimary
                        : context.colors.secondary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
