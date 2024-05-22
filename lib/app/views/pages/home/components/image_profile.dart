import 'package:flutter/material.dart';
import 'package:tractian_tree/app/views/style/style.dart';
import 'package:tractian_tree/app/views/tools/context_extension.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            borderRadius: radius(radius: 50.0),
            border: Border.all(color: context.colors.scrim, width: 0.5),
          ),
          child: ClipRRect(
            borderRadius: radius(radius: 50.0),
            child: Image.network(
              'https://cdn.pixabay.com/photo/2017/11/02/14/27/model-2911332_1280.jpg',
              fit: BoxFit.cover,
            ),
          )),
    );
  }
}
