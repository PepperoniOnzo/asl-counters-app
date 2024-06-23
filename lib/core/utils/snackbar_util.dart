import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_colors.dart';
import '../theme/text_styles.dart';

class SnackBarUtil {
  static void showSuccessMessage(BuildContext context,
          {required String message}) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: AppColors.primary,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.w),
      ));

  static void showError(BuildContext context, {String? error}) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(error ?? '', style: AppTextStyles.primary),
        backgroundColor: AppColors.primary,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.w),
      ));
}
