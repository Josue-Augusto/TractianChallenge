import 'package:flutter/material.dart';
import 'package:tractian_tree/app/views/style/colors.dart';

/// Return a circular shape
/// [shape] = 8.0
RoundedRectangleBorder shape({double? shape}) {
  return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(shape ?? 8.0));
}

/// Return a circular radius
/// [radius] = 8.0
BorderRadius radius({double? radius}) {
  return BorderRadius.circular(radius ?? 8);
}

/// Return a text style
TextStyle textStyle(
    {Color? colors,
    double? size,
    FontWeight? fontWeight,
    TextDecoration? decoration,
    bool? shadow}) {
  return TextStyle(
    fontSize: size ?? 24.0,
    fontWeight: fontWeight ?? FontWeight.w600,
    fontFamily: 'Schyler',
    color: colors ?? colorSchemeLight.primary,
    decoration: decoration,
    shadows: shadow != null
        ? <Shadow>[
            const Shadow(
              offset: Offset(0.0, 0.0),
              blurRadius: 5.0,
              color: Colors.white,
            ),
          ]
        : null,
  );
}

/// Return a Button style
ButtonStyle buttonStyle() {
  return ButtonStyle(
    padding:
        const MaterialStatePropertyAll(EdgeInsets.only(left: 8.0, right: 8.0)),
    elevation: const MaterialStatePropertyAll(0.5),
    shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
      shape(),
    ),
  );
}
