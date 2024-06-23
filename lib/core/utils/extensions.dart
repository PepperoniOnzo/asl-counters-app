import 'package:flutter/material.dart';

extension TextStyleColor on TextStyle {
  TextStyle copyWithColor(Color color) => copyWith(color: color);
}
