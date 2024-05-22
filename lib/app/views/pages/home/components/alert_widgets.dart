import 'package:flutter/material.dart';
import 'package:tractian_tree/app/views/style/style.dart';
import 'package:tractian_tree/app/views/tools/context_extension.dart';

class AlertWidget extends StatelessWidget {
  final String icon;
  final String name;
  final int index;
  final String? sensorType;
  const AlertWidget({
    super.key,
    required this.icon,
    required this.name,
    required this.index,
    this.sensorType,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 4.0),
      child: SizedBox(
          height: 70.0,
          child: Card(
              color: context.colors.onPrimary.withOpacity(0.6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(width: 8.0),
                  Container(
                    height: 40.0,
                    width: 40.0,
                    decoration: BoxDecoration(
                        color: context.colors.background,
                        borderRadius: radius()),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Image.asset(
                        'images/$icon',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Text(
                      name,
                      style: textStyle(
                        size: 14,
                        colors: context.colors.error,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  if (sensorType != null)
                    sensorType == 'vibration'
                        ? const Icon(
                            Icons.vibration,
                            color: Colors.teal,
                            size: 18.0,
                          )
                        : const Icon(
                            Icons.bolt,
                            color: Colors.amber,
                            size: 18.0,
                          )
                ],
              ))),
    );
  }
}
