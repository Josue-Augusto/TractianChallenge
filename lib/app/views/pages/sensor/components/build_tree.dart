import 'package:flutter/material.dart';
import 'package:tractian_tree/app/models/companies_model.dart';
import 'package:tractian_tree/app/views/pages/sensor/components/build_assets.dart';

class BuildTree extends StatelessWidget {
  final CompanyModel data;
  final double padding;
  const BuildTree({super.key, required this.data, required this.padding});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: padding),
      child: ExpansionTile(
        title: Text(data.name),
        iconColor: Colors.transparent,
        leading: const Icon(
          Icons.arrow_drop_down_sharp,
          color: Colors.black,
        ),
        collapsedIconColor: Colors.transparent,
        children: [
          for (var child in data.locations)
            BuildAssets(data: child, padding: padding + 4.0),
          for (var child in data.assets)
            BuildAssets(data: child, padding: padding + 4.0),
        ],
      ),
    );
  }
}
