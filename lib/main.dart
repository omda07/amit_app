import 'package:amit_app/layout/home/amit_cubit.dart';
import 'package:amit_app/layout/login/login_screen.dart';
import 'package:amit_app/network/local/cache_helper.dart';
import 'package:amit_app/network/remote/dio_helper.dart';
import 'package:amit_app/shared/bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'layout/home/home.dart';
import 'layout/on_boarding/on_boarding_screen.dart';
import 'network/constants.dart';
import 'shared/styles/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DioHelper.init();
  await CacheHelper.init();
  var onBoarding = await CacheHelper.getData(key: 'onBoarding') ?? false;
  Widget widget;

  token = CacheHelper.getData(key: token.toString()).toString();
  print('token : ${token.toString()}');
  if (onBoarding) {
    if (token!.isNotEmpty) {
      widget = Home();
    } else {
      widget = const LoginScreen();
    }
  } else {
    widget = const OnBoardingScreen();
  }
  BlocOverrides.runZoned(
    () {
      runApp(MyApp(
        onBoarding: onBoarding,
        startWidget: widget,
      ));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.onBoarding, required this.startWidget})
      : super(key: key);
  final bool onBoarding;
  final Widget startWidget;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()
        ..getHomeData()
        ..getCategories()
        ..getFavorites()
        ..getCart()
        ..getUserData(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Amit',
            theme: lightTheme,
            home: startWidget,
          );
        },
      ),
    );
  }
}
