import 'package:amit_app/layout/home/amit_cubit.dart';
import 'package:amit_app/shared/styles/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AmitCubit(),
      child: BlocConsumer<AmitCubit, AmitState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AmitCubit.get(context);
          return Scaffold(
            // appBar: AppBar(
            //   title: Text('Amit'),
            // ),
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
      ),
    );
  }
}
