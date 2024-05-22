import 'package:flutter/material.dart';
import 'package:tractian_tree/app/views/style/style.dart';
import 'package:tractian_tree/app/views/tools/context_extension.dart';

class LoadComapnyWidget extends StatelessWidget {
  const LoadComapnyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.heigth * 0.25,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Material(
              elevation: 6.0,
              shape: shape(),
              child: Container(
                height: context.heigth * 0.25,
                width: context.width * 0.4,
                decoration: BoxDecoration(
                    borderRadius: radius(),
                    color: context.colors.secondaryContainer),
              ),
            ),
          );
        },
      ),
    );
  }
}
