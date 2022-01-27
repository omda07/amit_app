import 'package:amit_app/layout/home/amit_cubit.dart';
import 'package:amit_app/shared/resources/color_manager.dart';
import 'package:amit_app/shared/resources/values_manager.dart';
import 'package:amit_app/shared/styles/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Amit Shop',
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(color: ColorManager.swatch),
            ),
            actions: <Widget>[
              IconButton(
                onPressed: () {
                  cubit.signOut(context);
                },
                icon: const Icon(
                  Icons.power_settings_new_rounded,
                  color: Colors.red,
                ),
              ),
              IconButton(
                icon: const Icon(IconBroken.Search),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(IconBroken.Buy),
                onPressed: () {},
              ),
              const SizedBox(width: AppSize.s12)
            ],
          ),
          body: cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              cubit.changeBottom(index);
            },
            currentIndex: cubit.currentIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Category),
                label: 'Categories',
              ),
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Buy),
                label: 'Cart',
              ),
              BottomNavigationBarItem(
                icon: Icon(IconBroken.More_Square),
                label: 'Menu',
              ),
            ],
          ),
        );
      },
    );
  }
}
