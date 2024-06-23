import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/constants/app_routes.dart';
import 'core/data/repository/repository.dart';
import 'core/theme/theme.dart';
import 'generated/l10n.dart';
import 'src/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<Repository>.value(value: Repository()),
        RepositoryProvider<Service>.value(value: Service()),
      ],
      child: ScreenUtilInit(
          designSize: const Size(375, 812),
          ensureScreenSize: true,
          minTextAdapt: true,
          useInheritedMediaQuery: true,
          builder: (context, child) => MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: appThemeData,
                supportedLocales: S.delegate.supportedLocales,
                localizationsDelegates: const [
                  S.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                initialRoute: AppRoutes.initial,
                routes: {
                  AppRoutes.initial: (context) => const HomeScreen(),
                },
              )),
    );
  }
}
