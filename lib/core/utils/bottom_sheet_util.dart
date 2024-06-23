import 'package:flutter/material.dart';

class BottomSheetUtil {
  static void showBottomSheet({
    required BuildContext context,
  }) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        useRootNavigator: true,
        clipBehavior: Clip.hardEdge,
        backgroundColor: Colors.transparent,
        builder: (context) => SizedBox(
            height: MediaQuery.of(context).size.height * 0.25,
            child: Container()));
  }
}
