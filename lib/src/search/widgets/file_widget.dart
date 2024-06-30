import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/data/models/file_structure_dto.dart';
import 'cached_image.dart';

class FileWidget extends StatelessWidget {
  const FileWidget({required this.onTap, required this.file, super.key});

  final FileStructureDto file;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Ink(
        padding: EdgeInsets.all(5.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: AppColors.white),
        child: Align(
            child: file.isDirectory
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.folder, color: AppColors.blue),
                      Text(file.id)
                    ],
                  )
                : CachedImage(id: file.id)),
      ),
    );
  }
}
