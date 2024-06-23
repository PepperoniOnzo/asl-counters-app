import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_colors.dart';
import '../../core/services/app_service.dart';
import '../../core/utils/snackbar_util.dart';
import 'bloc/search_bloc.dart';
import 'widgets/file_widget.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchBloc(appService: context.read<AppService>()),
      child: BlocConsumer<SearchBloc, SearchState>(
        listener: (context, state) => state.status.callback(
          onError: (error) {
            SnackBarUtil.showError(context, error: error);
          },
        ),
        builder: (context, state) {
          return PopScope(
            canPop: false,
            onPopInvoked: (didPop) {
              context.read<SearchBloc>().add(PopContent());
            },
            child: Scaffold(
                body: Column(
              children: [
                DecoratedBox(
                  decoration: const BoxDecoration(color: AppColors.white),
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).padding.top + 10.h,
                        left: 16.w,
                        right: 16.w,
                        bottom: 10.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            context.read<SearchBloc>().add(PopContent());
                          },
                          child: const SizedBox(
                            width: 24,
                            height: 24,
                            child: Align(
                              child: Icon(
                                Icons.arrow_back_ios_new_rounded,
                              ),
                            ),
                          ),
                        ),
                        Text(state.currentDirectory),
                        const SizedBox(width: 24),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 16.w, right: 16.w, top: 10.h),
                    child: GridView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: state.files.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5,
                          crossAxisSpacing: 5.w,
                          mainAxisSpacing: 5.h),
                      itemBuilder: (context, index) => FileWidget(
                        onTap: () {
                          context
                              .read<SearchBloc>()
                              .add(OnFilePressed(file: state.files[index]));
                        },
                        file: state.files[index],
                      ),
                    ),
                  ),
                )
              ],
            )),
          );
        },
      ),
    );
  }
}
