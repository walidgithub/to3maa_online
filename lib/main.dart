import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:To3maa/zakat/presentation/di/di.dart';
import 'package:To3maa/zakat/presentation/router/app_router.dart';
import 'package:To3maa/zakat/presentation/shared/constant/app_strings.dart';
import 'package:To3maa/zakat/presentation/shared/style/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/preferences/app_pref.dart';
import 'zakat/presentation/shared/constant/app_constants.dart';
import 'zakat/presentation/shared/style/app_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await ServiceLocator().init();
  await ScreenUtil.ensureScreenSize();

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // runApp(DevicePreview(builder: (context) => const MyApp()));
  runApp(const MyApp());

  ErrorWidget.builder = (FlutterErrorDetails details) => Scaffold(
        body: SafeArea(
          child: Scaffold(
            body: Center(
              child: Column(
                children: [
                  const Text(
                    AppStrings.someThingWentWrong,
                    style: TextStyle(color: AppColors.cPrimary),
                  ),
                  SizedBox(
                    height: AppConstants.heightBetweenElements,
                  ),
                  Text(
                    details.exceptionAsString(),
                    style: const TextStyle(color: AppColors.cPrimary),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppPreferences _appPreferences = sl<AppPreferences>();

  bool loggedIn = false;
  goNext() {
    _appPreferences.isUserLoggedIn().then((isUserLoggedIn) => {
      if (isUserLoggedIn)
        {loggedIn = true}
      else
        {loggedIn = false}
    });
  }

  @override
  void initState() {
    goNext();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: AppStrings.appName,
              builder: EasyLoading.init(),
              onGenerateRoute: RouteGenerator.getRoute,
              // initialRoute: loggedIn ? Routes.homeRoute : Routes.signInRoute,
              initialRoute: Routes.verificationCodeRoute,
              theme: AppTheme.lightTheme);
        });
  }
}
