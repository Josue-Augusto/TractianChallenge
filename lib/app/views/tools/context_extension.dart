import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  /// Get color scheme
  ColorScheme get colors {
    return Theme.of(this).colorScheme;
  }

  /// Get heigth
  double get heigth {
    return MediaQuery.of(this).size.height;
  }

  /// Get width
  double get width {
    return MediaQuery.of(this).size.width;
  }
}
