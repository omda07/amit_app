import 'package:amit_app/layout/cart/cart_screen.dart';
import 'package:amit_app/layout/category/categories_screen.dart';
import 'package:amit_app/layout/menu/menu_screen.dart';
import 'package:amit_app/layout/products/products_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'amit_state.dart';

class AmitCubit extends Cubit<AmitState> {
  AmitCubit() : super(AmitInitial());
  static AmitCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> bottomScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    CartScreen(),
    MenuScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(AmitChangeBottomNavState());
  }
}
