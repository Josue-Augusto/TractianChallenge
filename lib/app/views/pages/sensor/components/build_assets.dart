import 'package:flutter/material.dart';
import 'package:tractian_tree/app/models/assets_model.dart';
import 'package:tractian_tree/app/views/tools/context_extension.dart';

class BuildAssets extends StatelessWidget {
  final AssetsModel data;
  final double padding;
  const BuildAssets({super.key, required this.data, required this.padding});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: padding),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
            border: data.name.isEmpty
                ? null
                : Border(
                    left: BorderSide(color: Colors.black.withOpacity(0.7)),
                  )),
        child: ValueListenableBuilder(
            valueListenable: data.isExpanded,
            builder: (_, __, ___) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                      onTap: () {
                        data.isExpanded.value = !data.isExpanded.value;
                      },
                      child: Row(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: Image.asset(
                              'images/${data.icon}',
                              height: 16.0,
                              width: 16.0,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Text(
                              data.name,
                              style: TextStyle(
                                  fontSize: 14.0,
                                  color: data.status != null
                                      ? data.status == 'alert'
                                          ? context.colors.error
                                          : context.colors.primary
                                      : context.colors.onPrimaryContainer,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          if (data.sensorType != null)
                            data.sensorType == 'vibration'
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
                      )),
                  if (data.isExpanded.value)
                    for (var child in data.assets)
                      BuildAssets(data: child, padding: padding + 2.0),
                ],
              );
            }),
      ),
    );
  }
}
