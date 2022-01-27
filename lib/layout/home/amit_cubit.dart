import 'package:amit_app/layout/cart/cart_screen.dart';
import 'package:amit_app/layout/category/categories_screen.dart';
import 'package:amit_app/layout/login/login_screen.dart';
import 'package:amit_app/layout/menu/menu_screen.dart';
import 'package:amit_app/layout/products/products_screen.dart';
import 'package:amit_app/models/categories_model.dart';
import 'package:amit_app/models/change_favorites_model.dart';
import 'package:amit_app/models/favourites_model.dart';
import 'package:amit_app/models/home_model.dart';
import 'package:amit_app/models/login_model.dart';
import 'package:amit_app/network/constants.dart';
import 'package:amit_app/network/end_points.dart';
import 'package:amit_app/network/local/cache_helper.dart';
import 'package:amit_app/network/remote/dio_helper.dart';
import 'package:amit_app/shared/component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'amit_state.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitial());
  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    CartScreen(),
    MenuScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavState());
  }

  HomeModel? homeModel;
  Map<int, bool> favorites = {};

  void signOut(context) {
    CacheHelper.removeData(key: token.toString()).then((value) {
      if (value) {
        navigateAndFinish(context, LoginScreen());
      }
      emit(LogOutUserSuccessState());
    }).catchError((onError) {
      emit(LogOutUserErrorState(onError));
    });
  }

  void getHomeData() {
    emit(AppLoadingHomeDataState());
    DioHelper.getData(
      url: HOME,
      token: token.toString(),
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      for (var element in homeModel!.data!.products) {
        favorites.addAll({
          element.id!: element.inFavorites!,
        });
      }

      print(homeModel!.data!.banners[0].image);
      print(homeModel!.status);
      emit(AppSuccessHomeDataState());
    }).catchError((onError) {
      print(onError.toString());
      emit(AppErrorHomeDataState(onError.toString()));
    });
  }

  CategoriesModel? categoriesModel;

  void getCategories() {
    DioHelper.getData(
      url: GET_CATEGORIES,
      token: token.toString(),
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      print(categoriesModel!.data!.data[0].image);
      print(categoriesModel!.status);
      emit(AppSuccessCategoriesDataState());
    }).catchError((onError) {
      print(onError.toString());
      emit(AppErrorCategoriesDataState(onError.toString()));
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;

  void changeFavorites(int productId) {
    favorites[productId] = !favorites[productId]!;

    emit(AppChangeFavoritesState());

    DioHelper.postData(
      url: FAVORITES,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      print(value.data);

      if (!changeFavoritesModel!.status!) {
        favorites[productId] = !favorites[productId]!;
      } else {
        getFavorites();
      }

      emit(AppSuccessChangeFavoritesState(changeFavoritesModel!));
    }).catchError((error) {
      favorites[productId] = !favorites[productId]!;

      emit(AppErrorChangeFavoritesState());
    });
  }

  FavoritesModel? favoritesModel;

  void getFavorites() {
    emit(AppLoadingGetFavoritesState());

    DioHelper.getData(
      url: FAVORITES,
      token: token.toString(),
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      //printFullText(value.data.toString());

      emit(AppSuccessGetFavoritesState());
    }).catchError((error) {
      print(error.toString());
      emit(AppErrorGetFavoritesState());
    });
  }

  LoginModel? userModel;

  void getUserData() async {
    emit(AppLoadingGetUserDataState());

    await DioHelper.getData(
      url: PROFILE,
      token: token.toString(),
    ).then((value) {
      userModel = LoginModel.fromJson(value.data);
      //printFullText(value.data.toString());

      emit(AppSuccessGetUserDataState(userModel!));
    }).catchError((error) {
      print(error.toString());
      emit(AppErrorGetUserDataState());
    });
  }

  void updateUserData({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(AppLoadingUpdateUserDataState());

    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
      },
    ).then((value) {
      userModel = LoginModel.fromJson(value.data);
      //printFullText(value.data.toString());

      emit(AppSuccessUpdateUserDataState(userModel!));
    }).catchError((error) {
      print(error.toString());
      emit(AppErrorUpdateUserDataState());
    });
  }
}
