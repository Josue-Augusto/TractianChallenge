import 'package:flutter/material.dart';
import 'package:tractian_tree/app/views/style/style.dart';
import 'package:tractian_tree/app/views/tools/context_extension.dart';

class LoadAlertWidget extends StatelessWidget {
  const LoadAlertWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.heigth * 0.59,
      child: ListView.builder(
        itemCount: 8,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
            child: Material(
              elevation: 6.0,
              child: Container(
                height: 60.0,
                decoration: BoxDecoration(
                  borderRadius: radius(radius: 4.0),
                  color: context.colors.secondaryContainer,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
